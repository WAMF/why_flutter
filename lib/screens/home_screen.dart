import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import '../models/slide_data.dart';
import '../services/presentation_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _dragging = false;
  bool _loading = false;
  String? _errorMessage;
  List<String> _recentPresentations = [];

  @override
  void initState() {
    super.initState();
    _loadRecentPresentations();
  }

  Future<void> _loadRecentPresentations() async {
    if (!kIsWeb) {
      try {
        final presentations = await PresentationService.getAvailablePresentations();
        setState(() {
          _recentPresentations = presentations;
        });
      } catch (e) {
        debugPrint('Error loading recent presentations: $e');
      }
    }
  }

  Future<void> _loadPresentationFromFile() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null) {
        String jsonContent;
        
        if (kIsWeb && result.files.single.bytes != null) {
          jsonContent = utf8.decode(result.files.single.bytes!);
        } else if (result.files.single.path != null) {
          final file = File(result.files.single.path!);
          jsonContent = await file.readAsString();
        } else {
          throw Exception('Unable to read file');
        }

        final json = jsonDecode(jsonContent) as Map<String, dynamic>;
        final presentation = Presentation.fromJson(json);
        
        if (mounted) {
          context.go('/presentation', extra: presentation);
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading presentation: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _loadPresentationFromUrl(String url) async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final presentation = Presentation.fromJson(json);
        
        if (mounted) {
          context.go('/presentation', extra: presentation);
        }
      } else {
        throw Exception('Failed to load presentation from URL');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading presentation from URL: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _loadDefaultPresentation() async {
    final presentation = await PresentationService.createDefaultPresentation();
    if (mounted) {
      context.go('/presentation', extra: presentation);
    }
  }

  Future<void> _onDropDone(DropDoneDetails details) async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      final file = details.files.first;
      final jsonContent = await file.readAsString();
      final json = jsonDecode(jsonContent) as Map<String, dynamic>;
      final presentation = Presentation.fromJson(json);
      
      if (mounted) {
        context.go('/presentation', extra: presentation);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading dropped file: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.slideshow,
                size: 80,
                color: Colors.blue.shade400,
              ),
              const SizedBox(height: 24),
              const Text(
                'Presentation Viewer',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 48),
              
              // Drop Zone
              DropTarget(
                onDragDone: _onDropDone,
                onDragEntered: (detail) => setState(() => _dragging = true),
                onDragExited: (detail) => setState(() => _dragging = false),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _dragging ? Colors.blue : Colors.grey.shade600,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: _dragging 
                        ? Colors.blue.withValues(alpha: 0.1)
                        : Colors.grey.withValues(alpha: 0.05),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          size: 48,
                          color: _dragging ? Colors.blue : Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _dragging 
                              ? 'Drop your presentation file here'
                              : 'Drag and drop a JSON presentation file here',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'or',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: _loading ? null : _loadPresentationFromFile,
                          icon: const Icon(Icons.folder_open),
                          label: const Text('Browse Files'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Default Presentation Button
              OutlinedButton.icon(
                onPressed: _loading ? null : _loadDefaultPresentation,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Load Default "Why Flutter" Presentation'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.grey),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
              
              if (_errorMessage != null) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ],
              
              if (_loading) ...[
                const SizedBox(height: 24),
                const CircularProgressIndicator(),
              ],
              
              // Recent Presentations (for non-web platforms)
              if (!kIsWeb && _recentPresentations.isNotEmpty) ...[
                const SizedBox(height: 48),
                Text(
                  'Recent Presentations',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(height: 16),
                ...(_recentPresentations.map((fileName) => 
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: const Icon(Icons.description, color: Colors.blue),
                      title: Text(
                        fileName,
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () async {
                        final presentation = await PresentationService.loadPresentation(
                          fileName: fileName,
                        );
                        if (presentation != null && mounted) {
                          context.go('/presentation', extra: presentation);
                        }
                      },
                      tileColor: Colors.grey.withValues(alpha: 0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                )),
              ],
            ],
          ),
        ),
      ),
    );
  }
}