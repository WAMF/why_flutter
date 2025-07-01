import 'package:flutter/material.dart';
import '../../models/slide_data.dart';

class PerformanceSlide extends StatelessWidget {
  final SlideData slide;
  final AnimationController animationController;

  const PerformanceSlide({
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

    final metricsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    final bulletAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            const Color(0xFF2E7D32),
            const Color(0xFF1B5E20),
            const Color(0xFF0D47A1),
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
                              const Icon(
                                Icons.speed,
                                color: Colors.white,
                                size: 48,
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
                  const SizedBox(height: 40),
                  if (slide.statistics != null)
                    FadeTransition(
                      opacity: metricsAnimation,
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - metricsAnimation.value)),
                        child: Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: slide.statistics!.entries.map((entry) {
                              return Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        _getPerformanceIcon(entry.key),
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      entry.value,
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      entry.key,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: FadeTransition(
                      opacity: bulletAnimation,
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - bulletAnimation.value)),
                        child: ListView.builder(
                          itemCount: slide.bulletPoints.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 20,
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

  IconData _getPerformanceIcon(String metric) {
    switch (metric.toLowerCase()) {
      case 'startup time':
        return Icons.rocket_launch;
      case 'frame rate':
        return Icons.speed;
      case 'battery efficiency':
        return Icons.battery_charging_full;
      case 'cpu usage':
        return Icons.memory;
      default:
        return Icons.trending_up;
    }
  }
}