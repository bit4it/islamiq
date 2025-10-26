import 'package:flutter/material.dart';
import 'package:islamiq/components/appbar.dart';
import 'package:islamiq/theme/app_theme.dart';


// Main Detail Page
class DuaDetailsScreen extends StatelessWidget {
  const DuaDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(251, 248, 247, 100),
        body: Column(
          children: [
            const SizedBox(height: 10),
            const GenericAppBar(title: 'When walking up', iconPath: 'assets/icons/utils/translator.svg', onIconPressed: null,),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const ArabicText(
                        text: 'اللَّهُمَّ لَكَ الْحَمْدُ أَنْتَ كَسَوْتَنِيهِ، أَسْأَلُكَ مِنْ خَيْرِهِ وَخَيْرِ مَا صُنِعَ لَهُ، وَأَعُوذُ بِكَ مِنْ شَرِّهِ وَشَرِّ مَا صُنِعَ لَهُ',
                      ),
                      const SizedBox(height: 32),
                      const TransliterationText(
                        text: 'Allahumma laka-l-hamdu Anta kasawtanth, as\'aluka min khayrihi wa khayri ma suni a lah, wa a\'ūdhu bika min sharrihi wa sharri mā suni a lah.',
                      ),
                      const SizedBox(height: 32),
                      const TranslationText(
                        text: 'O Allah, all praise is for You Alone — You have clothed me with it. I ask You for its good and the good of that for which it was made; and I seek Your protection from its evil and the evil of that for which it was made.',
                      ),
                      const SizedBox(height: 32),
                      const ReferenceText(
                        primary: 'Sahih al-Bukhari 1 (Book 1, Hadith 1)',
                        secondary: 'English Reference: Vol. 1,  Book 1, Hadith 1',
                      ),
                      const SizedBox(height: 24),
                      const Divider(
                        color: Color(0xFFD6D1CA),
                        thickness: 1,
                        height: 1,
                      ),
                      const SizedBox(height: 16),
                      const ActionButtons(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      
    );
  }
}

// Custom App Bar Component
// Arabic Text Component
class ArabicText extends StatelessWidget {
  final String text;

  const ArabicText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 28,
        height: 2.2,
        fontWeight: FontWeight.w400,
        color: AppTheme.primaryGreen,
        fontFamily: 'Traditional Arabic',
      ),
    );
  }
}

// Transliteration Text Component
class TransliterationText extends StatelessWidget {
  final String text;

  const TransliterationText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        height: 1.6,
        fontWeight: FontWeight.w400,
        color: AppTheme.textDark,
        letterSpacing: 0.2,
      ),
    );
  }
}

// Translation Text Component
class TranslationText extends StatelessWidget {
  final String text;

  const TranslationText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        height: 1.6,
        fontWeight: FontWeight.w400,
        color: AppTheme.textMedium,
        letterSpacing: 0.2,
      ),
    );
  }
}

// Reference Text Component
class ReferenceText extends StatelessWidget {
  final String primary;
  final String secondary;

  const ReferenceText({
    Key? key,
    required this.primary,
    required this.secondary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          primary,
          style: const TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: AppTheme.primaryGreen,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          secondary,
          style: const TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
                        color: AppTheme.primaryGreen,

            height: 1.5,
          ),
        ),
      ],
    );
  }
}

// Action Buttons Component
class ActionButtons extends StatelessWidget {
  const ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ActionButton(
          icon: Icons.bookmark_border,
          label: 'Bookmark',
          onTap: () {},
        ),
        const SizedBox(width: 60),
        ActionButton(
          icon: Icons.share_outlined,
          label: 'Share',
          onTap: () {},
        ),
      ],
    );
  }
}

// Action Button Component
class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ActionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppTheme.primaryGreen,
              size: 22,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppTheme.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}