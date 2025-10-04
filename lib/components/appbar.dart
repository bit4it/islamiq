
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DuaAppBar extends StatelessWidget {
  const DuaAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 16),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 24),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Dua',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFB8998C),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.text_fields, color: Colors.white, size: 20),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.swap_horiz,
                      color: Color(0xFFB8998C),
                      size: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GenericAppBar extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback? onIconPressed;

  const GenericAppBar({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.onIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 16),
      color: const Color.fromRGBO(251, 248, 247, 100),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 24),
            onPressed: () {
              Navigator.of(context).pop();
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(89, 79, 74, 100),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onIconPressed,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                
                  width: 25,
                  height: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}