import 'dart:convert';
import 'dart:io';
import '../models/slide_data.dart';
import '../services/presentation_service.dart';

Future<void> exportDefaultPresentation() async {
  final presentation = await PresentationService.createDefaultPresentation();
  final json = const JsonEncoder.withIndent('  ').convert(presentation.toJson());
  
  final file = File('why_flutter_presentation.json');
  await file.writeAsString(json);
  
  print('Presentation exported to: ${file.absolute.path}');
}

// Run this to export the presentation
void main() async {
  await exportDefaultPresentation();
}