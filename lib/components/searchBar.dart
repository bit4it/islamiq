

// Search Bar Component
import 'package:flutter/material.dart';

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
          border: Border.all(color: const Color.fromRGBO(170, 163, 160, 100)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            const Icon(Icons.search, color: Color.fromRGBO(170, 163, 160, 100)),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
          decoration: InputDecoration(
            hintText: placeholderText,
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Color(0xFFBDBDBD),
            ),
            border: InputBorder.none,
          ),
              ),
            ),
            const Icon(Icons.mic, color:  Color.fromRGBO(170, 163, 160, 100), size: 24),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}