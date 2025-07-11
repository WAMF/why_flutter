import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/slide_data.dart';

class SlideNotesBottomSheet extends StatelessWidget {
  final SlideData slide;

  const SlideNotesBottomSheet({
    super.key,
    required this.slide,
  });

  static void show(BuildContext context, SlideData slide) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SlideNotesBottomSheet(slide: slide),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Presentation Notes',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D47A1),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  slide.title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: _NotesBottomSheetContent(slide: slide),
          ),
        ],
      ),
    );
  }


}

class _NotesBottomSheetContent extends StatefulWidget {
  final SlideData slide;

  const _NotesBottomSheetContent({required this.slide});

  @override
  State<_NotesBottomSheetContent> createState() => _NotesBottomSheetContentState();
}

class _NotesBottomSheetContentState extends State<_NotesBottomSheetContent> {
  bool _showingSources = false;

  @override
  Widget build(BuildContext context) {
    final hasNotes = widget.slide.speakingNotes != null && widget.slide.speakingNotes!.isNotEmpty;
    final hasLinks = widget.slide.sourceLinks != null && widget.slide.sourceLinks!.isNotEmpty;

    if (!hasNotes && !hasLinks) {
      return _buildEmptyState();
    }

    // If only one type of content, show it directly
    if (hasNotes && !hasLinks) {
      return _buildNotesContent();
    }
    if (hasLinks && !hasNotes) {
      return _buildSourcesContent();
    }

    // Both types available - show toggle
    return Column(
      children: [
        Expanded(
          child: _showingSources ? _buildSourcesContent() : _buildNotesContent(),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.05),
            border: Border(
              top: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () => setState(() => _showingSources = false),
                icon: Icon(
                  Icons.speaker_notes,
                  color: !_showingSources ? const Color(0xFF0D47A1) : Colors.grey,
                ),
                label: Text(
                  'Speaking Notes',
                  style: TextStyle(
                    color: !_showingSources ? const Color(0xFF0D47A1) : Colors.grey,
                    fontWeight: !_showingSources ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              TextButton.icon(
                onPressed: () => setState(() => _showingSources = true),
                icon: Icon(
                  Icons.link,
                  color: _showingSources ? const Color(0xFF0D47A1) : Colors.grey,
                ),
                label: Text(
                  'Sources',
                  style: TextStyle(
                    color: _showingSources ? const Color(0xFF0D47A1) : Colors.grey,
                    fontWeight: _showingSources ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotesContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.speaker_notes,
                color: const Color(0xFF0D47A1),
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Speaking Notes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: widget.slide.speakingNotes?.length ?? 0,
              itemBuilder: (context, index) {
                final note = widget.slide.speakingNotes![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.blue.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFF0D47A1),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            note,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.black87,
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
        ],
      ),
    );
  }

  Widget _buildSourcesContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.link,
                color: const Color(0xFF0D47A1),
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Sources & References',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: widget.slide.sourceLinks?.length ?? 0,
              itemBuilder: (context, index) {
                final source = widget.slide.sourceLinks![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => _launchUrl(source.url),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0D47A1).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.link,
                                  color: Color(0xFF0D47A1),
                                  size: 16,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      source.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      source.description,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.open_in_new,
                                color: Colors.grey,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.grey[400],
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            'No notes or sources available',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      // Show error message to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open link: $url'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}