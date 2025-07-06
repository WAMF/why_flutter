import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import '../models/slide_data.dart';

class PresentationService {
  static const String _presentationsDir = 'presentations';
  
  static Future<void> savePresentation(Presentation presentation) async {
    if (kIsWeb) {
      await _saveForWeb(presentation);
    } else {
      await _saveForMobile(presentation);
    }
  }
  
  static Future<Presentation?> loadPresentation({String? fileName}) async {
    if (kIsWeb) {
      return await _loadForWeb(fileName ?? '');
    } else {
      if (fileName != null) {
        return await _loadForMobile(fileName);
      } else {
        return await _loadFromPicker();
      }
    }
  }
  
  static Future<List<String>> getAvailablePresentations() async {
    if (kIsWeb) {
      return await _getWebPresentations();
    } else {
      return await _getMobilePresentations();
    }
  }
  
  static Future<void> _saveForMobile(Presentation presentation) async {
    final directory = await _getPresentationsDirectory();
    final file = File('${directory.path}/${presentation.name}.json');
    final json = jsonEncode(presentation.toJson());
    await file.writeAsString(json);
  }
  
  static Future<Presentation?> _loadForMobile(String fileName) async {
    try {
      final directory = await _getPresentationsDirectory();
      final file = File('${directory.path}/$fileName');
      if (!await file.exists()) return null;
      
      final content = await file.readAsString();
      final json = jsonDecode(content) as Map<String, dynamic>;
      return Presentation.fromJson(json);
    } catch (e) {
      debugPrint('Error loading presentation: $e');
      return null;
    }
  }
  
  static Future<List<String>> _getMobilePresentations() async {
    try {
      final directory = await _getPresentationsDirectory();
      final files = await directory.list().toList();
      return files
          .where((file) => file.path.endsWith('.json'))
          .map((file) => file.path.split('/').last)
          .toList();
    } catch (e) {
      debugPrint('Error listing presentations: $e');
      return [];
    }
  }
  
  static Future<Directory> _getPresentationsDirectory() async {
    if (kIsWeb) {
      // Web doesn't have file system access
      throw UnsupportedError('File system not available on web');
    }
    final appDir = await getApplicationDocumentsDirectory();
    final presentationsDir = Directory('${appDir.path}/$_presentationsDir');
    if (!await presentationsDir.exists()) {
      await presentationsDir.create(recursive: true);
    }
    return presentationsDir;
  }
  
  static Future<void> _saveForWeb(Presentation presentation) async {
    final json = const JsonEncoder.withIndent('  ').convert(presentation.toJson());
    final bytes = utf8.encode(json);
    
    // Create a download using FileSaver approach
    await FilePicker.platform.saveFile(
      dialogTitle: 'Save presentation',
      fileName: '${presentation.name}.json',
      type: FileType.custom,
      allowedExtensions: ['json'],
      bytes: Uint8List.fromList(bytes),
    );
  }
  
  static Future<Presentation?> _loadForWeb(String fileName) async {
    return null;
  }
  
  static Future<List<String>> _getWebPresentations() async {
    return [];
  }
  
  
  static Future<void> deletePresentationForMobile(String fileName) async {
    final directory = await _getPresentationsDirectory();
    final file = File('${directory.path}/$fileName');
    if (await file.exists()) {
      await file.delete();
    }
  }
  
  static Future<Presentation> createDefaultPresentation() async {
    return Presentation(
      name: 'Why Flutter',
      slides: PresentationData.getSlides(),
      lastModified: DateTime.now(),
    );
  }
  
  static Future<Presentation?> _loadFromPicker() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      
      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final content = await file.readAsString();
        final json = jsonDecode(content) as Map<String, dynamic>;
        return Presentation.fromJson(json);
      }
    } catch (e) {
      debugPrint('Error loading presentation from picker: $e');
    }
    return null;
  }
}