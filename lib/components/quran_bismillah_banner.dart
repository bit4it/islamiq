import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamiq/theme/app_theme.dart';

class QuranBismillahBanner extends StatelessWidget {
  const QuranBismillahBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryGreen.withOpacity(0.05),
            AppTheme.primaryGreen.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryGreen.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Center(
        child: ColorFiltered(
          colorFilter: const ColorFilter.mode(
            AppTheme.primaryGreen,
            BlendMode.srcIn,
          ),
          child: SizedBox(
            height: 50,
            child: SvgPicture.asset(
              'assets/icons/quran/bismillah.svg',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
