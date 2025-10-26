// Dua Category Item Component
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ChapterCard extends StatelessWidget {
  final String arabic_title;
  final String english_title;
  final int verse_count;
  final int index;
  final String? origin;
  final String? roman_title;

  ChapterCard({
    Key? key,
    required this.arabic_title,
    required this.english_title,
    required this.verse_count,
    required this.index,
    this.origin,
    this.roman_title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle button press
        Navigator.pushNamed(context, '/quran/reader');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(251, 248, 247, 100),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column( // Change to Column to include Divider
          children: [
            Row(
              children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFF97867C).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF97867C), width: 1.5),
                    ),
                    child: Center(
                      child: Text(
                        '$index.',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(94, 83, 77, 100),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        arabic_title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(94, 83, 77, 100),
                        ),
                      ),
                      if (roman_title != null)
                        Text(
                          roman_title!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(151, 134, 124, 100),
                          ),
                        ),
                      if (origin != null)
                        Text(
                          origin!,
                          style: TextStyle(
                            fontSize: 12,
                            color: origin == 'Makki'
                                ? Colors.green[700]
                                : Colors.blue[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Removed the undefined name
                    SvgPicture.asset(
                      'assets/icons/utils/book.svg',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$verse_count Ayahs',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(94, 83, 77, 100),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // const SizedBox(height: 8), // Add some space before the Divider
            const Divider(color: Color.fromRGBO(151, 134, 124, 100), thickness: 0.5,), // Add the horizontal line
          ],
        ),
      ),
    );
  }
}