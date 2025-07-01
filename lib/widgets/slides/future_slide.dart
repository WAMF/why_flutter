import 'package:flutter/material.dart';
import '../../models/slide_data.dart';

class FutureSlide extends StatelessWidget {
  final SlideData slide;
  final AnimationController animationController;

  const FutureSlide({
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

    final featuresAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    final glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
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
            const Color(0xFF1A237E),
            const Color(0xFF283593),
            const Color(0xFF3F51B5),
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
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.3 * glowAnimation.value),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.auto_awesome,
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
                           ),                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Expanded(
                    child: FadeTransition(
                      opacity: featuresAnimation,
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - featuresAnimation.value)),
                        child: ListView.builder(
                          itemCount: slide.bulletPoints.length,
                          itemBuilder: (context, index) {
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
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        _getFutureIcon(index),
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
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
                              ),
                            );
                          },
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

  IconData _getFutureIcon(int index) {
    switch (index) {
      case 0:
        return Icons.psychology;
      case 1:
        return Icons.chat;
      case 2:
        return Icons.devices;
      case 3:
        return Icons.web;
      default:
        return Icons.auto_awesome;
    }
  }
}