import 'package:flutter/material.dart';
import '../models/slide_data.dart';
import 'slide_notes_bottom_sheet.dart';

class SlideFootnote extends StatelessWidget {
  final SlideData slide;

  const SlideFootnote({
    super.key,
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    final hasNotes = slide.speakingNotes != null && slide.speakingNotes!.isNotEmpty;
    final hasLinks = slide.sourceLinks != null && slide.sourceLinks!.isNotEmpty;
    
    if (!hasNotes && !hasLinks) {
      return const SizedBox.shrink();
    }

    return Positioned(
      bottom: 80,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _showNotesBottomSheet(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 8),
                const Text(
                  'more',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showNotesBottomSheet(BuildContext context) {
    SlideNotesBottomSheet.show(context, slide);
  }
}