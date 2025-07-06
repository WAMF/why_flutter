import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import '../models/slide_data.dart';

abstract class PresentationService {
  Future<void> savePresentation(Presentation presentation);
  Future<Presentation?> loadPresentation();
  Future<List<String>> getAvailablePresentations();
  Future<Presentation> createDefaultPresentation();
}

class PresentationServiceImpl implements PresentationService {
  @override
  Future<void> savePresentation(Presentation presentation) async {
    await _saveWithPicker(presentation);
  }

  @override
  Future<Presentation?> loadPresentation() async {
    return await _loadWithPicker();
  }

  @override
  Future<List<String>> getAvailablePresentations() async {
    // No longer maintaining a list of available presentations
    // Users will use file picker to select presentations
    return [];
  }

  Future<void> _saveWithPicker(Presentation presentation) async {
    try {
      final json = const JsonEncoder.withIndent(
        '  ',
      ).convert(presentation.toJson());
      final bytes = utf8.encode(json);

      await FilePicker.platform.saveFile(
        dialogTitle: 'Save presentation',
        fileName: '${presentation.name}.json',
        type: FileType.custom,
        allowedExtensions: ['json'],
        bytes: Uint8List.fromList(bytes),
      );
    } catch (e) {
      debugPrint('Error saving presentation: $e');
    }
  }

  @override
  Future<Presentation> createDefaultPresentation() async {
    return Presentation(
      name: 'Why Flutter',
      slides: PresentationData.getSlides(),
      lastModified: DateTime.now(),
    );
  }

  Future<Presentation?> _loadWithPicker() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null) {
        String? content;

        if (kIsWeb) {
          if (result.files.single.bytes != null) {
            content = utf8.decode(result.files.single.bytes!);
          }
        } else {
          if (result.files.single.path != null) {
            final file = File(result.files.single.path!);
            content = await file.readAsString();
          }
        }

        if (content != null) {
          final json = jsonDecode(content) as Map<String, dynamic>;
          return Presentation.fromJson(json);
        }
      }
    } catch (e) {
      debugPrint('Error loading presentation: $e');
    }
    return null;
  }
}
