import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/slide_data.dart';

class ShowcaseSlide extends StatelessWidget {
  final SlideData slide;
  final AnimationController animationController;

  const ShowcaseSlide({
    super.key,
    required this.slide,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    final headerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic),
      ),
    );

    final contentAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    final buttonAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.6, 1.0, curve: Curves.elasticOut),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A237E),
            const Color(0xFF3F51B5),
            const Color(0xFF5C6BC0),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  FadeTransition(
                    opacity: headerAnimation,
                    child: Transform.translate(
                      offset: Offset(0, 30 * (1 - headerAnimation.value)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.3),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.explore,
                                  color: Colors.white,
                                  size: 36,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  slide.title,
                                  style: const TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            slide.subtitle,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white70,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Content
                  Expanded(
                    child: FadeTransition(
                      opacity: contentAnimation,
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - contentAnimation.value)),
                        child: Column(
                          children: [
                            // Bullet points
                            Expanded(
                              child: ListView.builder(
                                itemCount: slide.bulletPoints.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 8),
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(
                                              0.8,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: Text(
                                            slide.bulletPoints[index],
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),

                            // Showcase Button
                            const SizedBox(height: 40),
                            FadeTransition(
                              opacity: buttonAnimation,
                              child: Transform.scale(
                                scale: 0.8 + (0.2 * buttonAnimation.value),
                                child: Container(
                                  width: double.infinity,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFF01579B),
                                        const Color(0xFF0277BD),
                                        const Color(0xFF039BE5),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.4),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () => _launchUrl(
                                        'https://flutter.dev/showcase',
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 30,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.launch,
                                              color: Colors.white,
                                              size: 28,
                                            ),
                                            const SizedBox(width: 15),
                                            const Text(
                                              'Visit Flutter Showcase',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            const Icon(
                                              Icons.arrow_forward,
                                              color: Colors.white,
                                              size: 28,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // URL display
                            FadeTransition(
                              opacity: buttonAnimation,
                              child: Text(
                                'flutter.dev/showcase',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white.withOpacity(0.7),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // Handle error silently or show a snackbar if needed
      debugPrint('Could not launch $url: $e');
    }
  }
}
