import 'package:flutter/material.dart';
import 'package:islamiq/theme/app_theme.dart';

class QuranReaderAppBar extends StatelessWidget {
  final String surahName;
  final String surahArabicName;
  final VoidCallback onBack;
  final VoidCallback onTranslate;

  const QuranReaderAppBar({
    Key? key,
    required this.surahName,
    required this.surahArabicName,
    required this.onBack,
    required this.onTranslate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppTheme.backgroundLight,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppTheme.textDark),
                  onPressed: onBack,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '$surahName ($surahArabicName)',
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 18,
                          color: AppTheme.cardGreen,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.translate, color: AppTheme.cardGreen, size: 24),
                  onPressed: onTranslate,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
