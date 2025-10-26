

// Search Bar Component
import 'package:flutter/material.dart';
import 'package:islamiq/theme/app_theme.dart';

class GenericSearchBar extends StatelessWidget {
  final String placeholderText;

  const GenericSearchBar({Key? key, required this.placeholderText}) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Color.fromRGBO(251, 248, 247, 100),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.primaryGreen, width: 1.5),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            const Icon(Icons.search, color: AppTheme.textMedium, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
          decoration: InputDecoration(
            hintText: placeholderText,
            hintStyle: const TextStyle(
              fontSize: 16,
              color: AppTheme.textGreenLight,
              
            ),
            border: InputBorder.none,
          ),
              ),
            ),
            const Icon(Icons.mic, color:  AppTheme.textDark, size: 24),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}