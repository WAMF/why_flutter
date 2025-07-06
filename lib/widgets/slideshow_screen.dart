import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../models/slide_data.dart';
import '../services/presentation_service.dart';
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
  late String _presentationName;

  @override
  void initState() {
    super.initState();
    
    // Initialize with provided presentation or default
    if (widget.presentation != null) {
      _slides = widget.presentation!.slides;
      _presentationName = widget.presentation!.name;
    } else {
      _slides = PresentationData.getSlides();
      _presentationName = 'Why Flutter';
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
                  aspectRatio: 800 / 900, // 8:9 aspect ratio
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 800,
                      maxHeight: 900,
                    ),
                    child: SlideBuilder.buildSlide(_slides[index], _animationController),
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
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () => SlideNotesBottomSheet.show(context, _slides[_currentSlide]),
                      icon: const Icon(Icons.speaker_notes, color: Colors.white),
                      tooltip: 'Show speaker notes',
                    ),
                    const SizedBox(width: 10),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      onSelected: (value) {
                        switch (value) {
                          case 'save':
                            _savePresentation();
                            break;
                          case 'load':
                            _loadPresentation();
                            break;
                          case 'new':
                            _newPresentation();
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                          value: 'save',
                          child: Row(
                            children: [
                              Icon(Icons.save),
                              SizedBox(width: 8),
                              Text('Save Presentation'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'load',
                          child: Row(
                            children: [
                              Icon(Icons.folder_open),
                              SizedBox(width: 8),
                              Text('Load Presentation'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'new',
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              SizedBox(width: 8),
                              Text('New Presentation'),
                            ],
                          ),
                        ),
                      ],
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
  
  Future<void> _savePresentation() async {
    final nameController = TextEditingController(text: _presentationName);
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Save Presentation'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Presentation Name',
              hintText: 'Enter presentation name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(nameController.text),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    
    if (result != null && result.isNotEmpty) {
      final presentation = Presentation(
        name: result,
        slides: _slides,
        lastModified: DateTime.now(),
      );
      
      await PresentationService.savePresentation(presentation);
      setState(() {
        _presentationName = result;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Presentation "$result" saved successfully')),
        );
      }
    }
  }
  
  Future<void> _loadPresentation() async {
    final presentation = await PresentationService.loadPresentation();
    
    if (presentation != null) {
      setState(() {
        _slides = presentation.slides;
        _presentationName = presentation.name;
        _currentSlide = 0;
      });
      
      _pageController.jumpToPage(0);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Loaded "${presentation.name}"')),
        );
      }
    }
  }
  
  Future<void> _newPresentation() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Presentation'),
          content: const Text('Create a new empty presentation? Current changes will be lost.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Create New'),
            ),
          ],
        );
      },
    );
    
    if (confirm == true) {
      setState(() {
        _slides = [
          SlideData(
            title: 'New Presentation',
            subtitle: 'Add your content here',
            bulletPoints: ['Point 1', 'Point 2', 'Point 3'],
            type: SlideType.title,
          ),
        ];
        _presentationName = 'New Presentation';
        _currentSlide = 0;
      });
      
      _pageController.jumpToPage(0);
    }
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