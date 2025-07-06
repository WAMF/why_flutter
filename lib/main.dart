import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'screens/home_screen.dart';
import 'widgets/slideshow_screen.dart';
import 'models/slide_data.dart';
import 'services/presentation_service.dart';

void main() {
  runApp(FlutterSlideshowApp());
}

class FlutterSlideshowApp extends StatelessWidget {
  FlutterSlideshowApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/presentation',
        builder: (context, state) {
          final presentation = state.extra as Presentation?;
          if (presentation != null) {
            return PresentationScreen(presentation: presentation);
          }
          // If no presentation is provided, load the default
          return FutureBuilder<Presentation>(
            future: PresentationService.createDefaultPresentation(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PresentationScreen(presentation: snapshot.data!);
              }
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/presentation/:encodedUrl',
        builder: (context, state) {
          final encodedUrl = state.pathParameters['encodedUrl'];
          if (encodedUrl != null) {
            final url = Uri.decodeComponent(encodedUrl);
            return LoadPresentationFromUrl(url: url);
          }
          return const HomeScreen();
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter: The Strategic Choice',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0175C2),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoadPresentationFromUrl extends StatelessWidget {
  final String url;
  
  const LoadPresentationFromUrl({super.key, required this.url});
  
  Future<Presentation?> _loadFromUrl() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return Presentation.fromJson(json);
      }
    } catch (e) {
      debugPrint('Error loading presentation from URL: $e');
    }
    return null;
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Presentation?>(
      future: _loadFromUrl(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        
        if (snapshot.hasError || snapshot.data == null) {
          return Scaffold(
            backgroundColor: const Color(0xFF1a1a1a),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load presentation from URL',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    url,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.go('/'),
                    child: const Text('Go to Home'),
                  ),
                ],
              ),
            ),
          );
        }
        
        return PresentationScreen(presentation: snapshot.data!);
      },
    );
  }
}

class PresentationScreen extends StatelessWidget {
  final Presentation presentation;
  
  const PresentationScreen({super.key, required this.presentation});
  
  @override
  Widget build(BuildContext context) {
    return SlideshowScreen(presentation: presentation);
  }
}
