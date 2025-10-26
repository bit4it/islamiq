import 'package:flutter/material.dart';
import 'package:islamiq/theme/app_theme.dart';
import 'package:arabic_font/arabic_font.dart';

class QuranAyahItem extends StatelessWidget {
  final String ayahText;
  final int ayahNumber;
  final int? chapterNumber;
  final String? translationText;
  final VoidCallback? onMenu;

  const QuranAyahItem({
    Key? key,
    required this.ayahText,
    required this.chapterNumber,
    required this.ayahNumber,
    this.translationText,
    this.onMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppTheme.primaryGreen.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with ayah number
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  AppTheme.primaryGreen.withOpacity(0.05),
                  AppTheme.primaryGreen.withOpacity(0.02),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppTheme.primaryGreen.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '$chapterNumber:$ayahNumber',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.share, color: AppTheme.primaryGreen, size: 18),
                  onPressed: onMenu,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  tooltip: 'Share Ayah',
                ),
              ],
            ),
          ),
          
          // Arabic text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Text(
              ayahText,
              style: ArabicTextStyle(
                arabicFont:  ArabicFont.scheherazade,
                fontSize: 30,
                color: AppTheme.textDark,
                fontWeight: FontWeight.w500,
                height: 1.8,
              ),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
          ),
          
          // Translation text
          if (translationText != null && translationText!.isNotEmpty) ...[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 1,
              color: AppTheme.primaryGreen.withOpacity(0.1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                translationText!,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppTheme.textMedium,
                  fontWeight: FontWeight.w500,
                  height: 1.6,
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
          
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
