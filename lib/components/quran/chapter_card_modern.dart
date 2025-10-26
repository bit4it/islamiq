import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamiq/models/quran.dart';
import 'package:islamiq/theme/app_theme.dart';

class ChapterCardModern extends StatelessWidget {
  final int index;
  final String arabicTitle;
  final String romanTitle;
  final String englishTitle;
  final String origin;
  final int verseCount;
  final List<ChapterVerse>? verses;

  const ChapterCardModern({
    Key? key,
    required this.index,
    required this.arabicTitle,
    required this.romanTitle,
    required this.englishTitle,
    required this.origin,
    required this.verseCount,
    this.verses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/quran/reader', arguments: {
          'chapter': {
            'index': index,
            'chapter_id': index,
            'ar_name': arabicTitle,
            'translit_name': romanTitle,
            'en_name': englishTitle,
            'origin': origin,
            'verse_count': verseCount,
            'verses': verses?.map( (v) => v.toJson()).toList(), // Convert ChapterVerse objects to JSON
          },
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left: Number in decorated box
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppTheme.accentGreen.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.primaryGreen, width: 1.5),
              ),
              child: Center(
                child: Text(
                  '$index',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryGreen,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Center: Titles
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    arabicTitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textGreenMedium,
                    ),
                  ),
                  Text(
                    '$romanTitle',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textDark,
                    ),
                  ),
                  Text(
                    '$englishTitle (${origin})',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppTheme.primaryGreenDark,
                    ),
                  ),
                ],
              ),
            ),
            // Right: Book icon and verse count
            Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/utils/quran-book.svg',
                  width: 28,
                  height: 28,
                ),
                const SizedBox(height: 4),
                Text(
                  '$verseCount Verses',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.primaryGreenDark,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
