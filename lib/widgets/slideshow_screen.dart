import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../models/slide_data.dart';
import 'slide_widgets.dart';

class SlideshowScreen extends StatefulWidget {
  final Presentation? presentation;
  
  const SlideshowScreen({super.key, this.presentation});

  @override
  State<SlideshowScreen> createState() => _SlideshowScreenState();
}

class _SlideshowScreenState extends State<SlideshowScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  int _currentSlide = 0;
  bool _presentationStarted = false;
  late List<SlideData> _slides;

  @override
  void initState() {
    super.initState();
    
    // Initialize with provided presentation or default
    if (widget.presentation != null) {
      _slides = widget.presentation!.slides;
    } else {
      _slides = PresentationData.getSlides();
    }
    
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  void _startPresentation() {
    setState(() {
      _presentationStarted = true;
    });
    // Start the first slide animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _nextSlide() {
    if (_currentSlide < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // On last slide, navigate to home
      context.go('/');
    }
  }

  void _previousSlide() {
    if (_currentSlide > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToSlide(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Auto-start presentation since we're coming from home screen
    if (!_presentationStarted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startPresentation();
      });
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: KeyboardListener(
        focusNode: FocusNode()..requestFocus(),
        autofocus: true,
        onKeyEvent: (KeyEvent event) {
          if (event is KeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.escape) {
              // Return to home screen on escape key
              context.go('/');
            } else if (event.logicalKey == LogicalKeyboardKey.space ||
                event.logicalKey == LogicalKeyboardKey.arrowRight) {
              _nextSlide();
            } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
              _previousSlide();
            }
          }
        },
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentSlide = index;
                });
                if (_presentationStarted) {
                  _animationController.reset();
                  _animationController.forward();
                }
              },
              itemCount: _slides.length,
              itemBuilder: (context, index) {
                return Center(
                  child: AspectRatio(
                    aspectRatio: 4 / 3, // 8:9 aspect ratio
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 800,
                        maxHeight: 900,
                      ),
                      child: SlideBuilder.buildSlide(
                        _slides[index],
                        _animationController,
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: _currentSlide > 0 ? _previousSlide : null,
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${_currentSlide + 1} / ${_slides.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: _currentSlide < _slides.length - 1
                            ? _nextSlide
                            : null,
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: () => SlideNotesBottomSheet.show(
                          context,
                          _slides[_currentSlide],
                        ),
                        icon: const Icon(
                          Icons.speaker_notes,
                          color: Colors.white,
                        ),
                        tooltip: 'Show speaker notes',
                      ),
                    ],
                  ),
                  Row(
                    children: List.generate(
                      _slides.length,
                      (index) => GestureDetector(
                        onTap: () => _goToSlide(index),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == _currentSlide
                                ? Colors.white
                                : Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SlideBuilder {
  static Widget buildSlide(
    SlideData slide,
    AnimationController animationController,
  ) {
    switch (slide.type) {
      case SlideType.title:
        return TitleSlide(
          slide: slide,
          animationController: animationController,
        );
      case SlideType.statistics:
        return StatisticsSlide(
          slide: slide,
          animationController: animationController,
        );
      case SlideType.performance:
        return PerformanceSlide(
          slide: slide,
          animationController: animationController,
        );
      case SlideType.roi:
        return ROISlide(slide: slide, animationController: animationController);
      case SlideType.future:
        return FutureSlide(
          slide: slide,
          animationController: animationController,
        );
      case SlideType.partnership:
        return PartnershipSlide(
          slide: slide,
          animationController: animationController,
        );
      case SlideType.interactive:
        return InteractiveSlide(
          slide: slide,
          animationController: animationController,
        );
      case SlideType.conclusion:
        return ConclusionSlide(
          slide: slide,
          animationController: animationController,
        );
      case SlideType.showcase:
        return ShowcaseSlide(
          slide: slide,
          animationController: animationController,
        );
    }
  }
}
