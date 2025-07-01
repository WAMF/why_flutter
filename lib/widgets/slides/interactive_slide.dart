import 'package:flutter/material.dart';
import '../../models/slide_data.dart';

class InteractiveSlide extends StatelessWidget {
  final SlideData slide;
  final AnimationController animationController;

  const InteractiveSlide({
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
        curve: const Interval(0.3, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    final highlightAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            const Color(0xFF00695C),
            const Color(0xFF00796B),
            const Color(0xFF009688),
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
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.teal.withOpacity(0.3 * highlightAnimation.value),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.business,
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
                      opacity: contentAnimation,
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - contentAnimation.value)),
                        child: ListView.builder(
                          itemCount: slide.bulletPoints.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.teal.withOpacity(0.1 * highlightAnimation.value),
                                      blurRadius: 15,
                                      spreadRadius: 3,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.teal.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        _getCompanyIcon(index),
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _getCompanyName(slide.bulletPoints[index]),
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            _getCompanyDescription(slide.bulletPoints[index]),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white70,
                                              height: 1.4,
                                            ),
                                          ),
                                        ],
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

  IconData _getCompanyIcon(int index) {
    switch (index) {
      case 0:
        return Icons.directions_car;
      case 1:
        return Icons.precision_manufacturing;
      case 2:
        return Icons.shopping_cart;
      case 3:
        return Icons.local_shipping;
      default:
        return Icons.business;
    }
  }

  String _getCompanyName(String bulletPoint) {
    if (bulletPoint.contains('BMW')) return 'BMW';
    if (bulletPoint.contains('Toyota')) return 'Toyota';
    if (bulletPoint.contains('Alibaba')) return 'Alibaba';
    if (bulletPoint.contains('eBay')) return 'eBay Motors';
    return 'Enterprise';
  }

  String _getCompanyDescription(String bulletPoint) {
    final colonIndex = bulletPoint.indexOf(':');
    if (colonIndex != -1 && colonIndex < bulletPoint.length - 1) {
      return bulletPoint.substring(colonIndex + 1).trim();
    }
    return bulletPoint;
  }
}