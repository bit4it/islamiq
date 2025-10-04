// Dua Category Item Component
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class DuaCategory extends StatelessWidget {
  final String title;
  final int duasCount;
  final int index;

  DuaCategory({
    Key? key,
    required this.title,
    required this.duasCount,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle button press
        Navigator.pushNamed(context, '/dua/list');
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
                  child: SizedBox(
                    width: 56,
                    height: 56,
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
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(94, 83, 77, 100),
                      
                    ),
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
                      '$duasCount Duas',
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