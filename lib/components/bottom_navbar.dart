import 'package:flutter/material.dart';
import 'package:islamiq/screens/home.dart';
import 'package:islamiq/screens/ilm.dart';
import 'package:islamiq/theme/app_theme.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundWhite,
        boxShadow: [
          BoxShadow(
            color: AppTheme.textLight.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(context, Icons.home, 'Home', 0, currentIndex),
              _buildNavItem(context, Icons.menu_book_outlined, 'Ilm', 1, currentIndex),
              _buildNavItem(context, Icons.notifications_outlined, '', 2, currentIndex),
              _buildNavItem(context, Icons.calendar_today_outlined, '', 3, currentIndex),
              _buildNavItem(context, Icons.more_horiz, '', 4, currentIndex),
            ],
          ),
        ),
      ),
    );
  }
}

  Widget _buildNavItem(BuildContext context, IconData icon, String label, int index, int currentIndex) {
    final bool isActive = currentIndex == index;
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
        } else if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => IlmScreen()));
        }
        // Add navigation for other screens as needed
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.accentGreenLight : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? AppTheme.primaryGreen : AppTheme.textMedium,
              size: 24,
            ),
            if (label.isNotEmpty && isActive) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: AppTheme.primaryGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }