import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/slide_data.dart';
import 'slide_widgets.dart';

class SlideshowScreen extends StatefulWidget {
  const SlideshowScreen({super.key});

  @override
  State<SlideshowScreen> createState() => _SlideshowScreenState();
}

class _SlideshowScreenState extends State<SlideshowScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  int _currentSlide = 0;
  bool _presentationStarted = false;
  final List<SlideData> _slides = PresentationData.getSlides();

  @override
  void initState() {
    super.initState();
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
    if (!_presentationStarted) {
      return StartScreen(onStart: _startPresentation);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: KeyboardListener(
        focusNode: FocusNode()..requestFocus(),
        autofocus: true,
        onKeyEvent: (KeyEvent event) {
          if (event is KeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.space ||
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
              return SlideBuilder.buildSlide(_slides[index], _animationController);
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
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${_currentSlide + 1} / ${_slides.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: _currentSlide < _slides.length - 1 ? _nextSlide : null,
                      icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
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
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              onPressed: () => SystemNavigator.pop(),
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    ),
    );
  }
}

class SlideBuilder {
  static Widget buildSlide(SlideData slide, AnimationController animationController) {
    switch (slide.type) {
      case SlideType.title:
        return TitleSlide(slide: slide, animationController: animationController);
      case SlideType.statistics:
        return StatisticsSlide(slide: slide, animationController: animationController);
      case SlideType.performance:
        return PerformanceSlide(slide: slide, animationController: animationController);
      case SlideType.roi:
        return ROISlide(slide: slide, animationController: animationController);
      case SlideType.future:
        return FutureSlide(slide: slide, animationController: animationController);
      case SlideType.partnership:
        return PartnershipSlide(slide: slide, animationController: animationController);
      case SlideType.interactive:
        return InteractiveSlide(slide: slide, animationController: animationController);
      case SlideType.conclusion:
        return ConclusionSlide(slide: slide, animationController: animationController);
    }
  }
}