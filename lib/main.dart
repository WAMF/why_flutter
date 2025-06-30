import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/slide_data.dart';
import 'widgets/slideshow_screen.dart';

void main() {
  runApp(const FlutterSlideshowApp());
}

class FlutterSlideshowApp extends StatelessWidget {
  const FlutterSlideshowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter: The Strategic Choice',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0175C2),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const SlideshowScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
