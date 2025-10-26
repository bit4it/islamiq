import 'package:flutter/material.dart';
import 'package:islamiq/theme/app_theme.dart';

class ListenJuzCard extends StatelessWidget {
  final int index;
  final String arabicTitle;
  final String romanTitle;
  final int verseCount;
  final VoidCallback? onPlay;

  const ListenJuzCard({
    Key? key,
    required this.index,
    required this.arabicTitle,
    required this.romanTitle,
    required this.verseCount,
    this.onPlay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  romanTitle,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.primaryGreen,
                  ),
                ),
              ],
            ),
          ),
          // Right: Play button and verse count
          Column(
            children: [
              IconButton(
                icon: Icon(
                  Icons.play_circle_outline,
                  color: AppTheme.primaryGreen,
                  size: 36,
                ),
                onPressed: onPlay,
              ),
           
            ],
          ),
        ],
      ),
    );
  }
}
