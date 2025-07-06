import 'package:flutter/material.dart';
import '../../models/slide_data.dart';

class ConclusionSlide extends StatelessWidget {
  final SlideData slide;
  final AnimationController animationController;

  const ConclusionSlide({
    super.key,
    required this.slide,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    final titleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic),
      ),
    );

    final subtitleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.2, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    final contentAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    final ctaAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    final glowAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF0D47A1),
            const Color(0xFF1565C0),
            const Color(0xFF1976D2),
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: titleAnimation,
                    child: Transform.translate(
                      offset: Offset(0, 50 * (1 - titleAnimation.value)),
                      child: Text(
                        slide.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.1,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeTransition(
                    opacity: subtitleAnimation,
                    child: Transform.translate(
                      offset: Offset(0, 30 * (1 - subtitleAnimation.value)),
                      child: Text(
                        slide.subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white70,
                          height: 1.3,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  FadeTransition(
                    opacity: contentAnimation,
                    child: Transform.translate(
                      offset: Offset(0, 30 * (1 - contentAnimation.value)),
                      child: Column(
                        children: slide.bulletPoints.asMap().entries.map((entry) {
                          final index = entry.key;
                          final point = entry.value;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.1 * glowAnimation.value),
                                    blurRadius: 15,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: _getTimeframeColor(index),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      _getTimeframeIcon(index),
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      point,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  FadeTransition(
                    opacity: ctaAnimation,
                    child: Transform.translate(
                      offset: Offset(0, 30 * (1 - ctaAnimation.value)),
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.1 * glowAnimation.value),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 28,
                            ),
                            SizedBox(width: 12),
                            Text(
                              '95.7% of CTOs would choose Flutter again',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 28,
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

  Color _getTimeframeColor(int index) {
    switch (index) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.purple;
      case 3:
        return Colors.blue;
      default:
        return Colors.blue;
    }
  }

  IconData _getTimeframeIcon(int index) {
    switch (index) {
      case 0:
        return Icons.speed;
      case 1:
        return Icons.build;
      case 2:
        return Icons.trending_up;
      case 3:
        return Icons.thumb_up;
      default:
        return Icons.check;
    }
  }
}