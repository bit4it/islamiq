import 'package:flutter/material.dart';
import 'package:islamiq/components/appbar.dart';
import 'package:islamiq/components/ilm_card.dart';
import 'package:islamiq/components/bottom_navbar.dart';
import 'package:islamiq/theme/app_theme.dart';




class IlmScreen extends StatelessWidget {
  IlmScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GenericAppBar(title: "Islamic Ilm", iconPath: null, onIconPressed: null),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2),
                  const Padding(
                  
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text('Basic', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                  ),
                 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GridView.count(
                                            padding: EdgeInsets.symmetric(vertical: 24.0),

                      crossAxisCount: 2,
                      childAspectRatio: 0.95,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        IlmCard(
                          title: 'Names of Allah',
                          subtitle: 'اسم من أسماء الله',
                          svgPath: 'assets/icons/ilm/allah-names.svg',
                          onTap: () {},
                        ),
                        IlmCard(
                          title: 'Kalima',
                          subtitle: 'الكلمة',
                          svgPath: 'assets/icons/ilm/kalimah.svg',
                          onTap: () {},
                        ),
                        IlmCard(
                          title: 'Ayatul Kursi',
                          subtitle: 'آية الكرسي',
                          svgPath: 'assets/icons/ilm/aytul-kursi.svg',
                          onTap: () {},
                        ),
                        IlmCard(
                          title: 'Wudu (Ablution)',
                          subtitle: 'الوضوء',
                          svgPath: 'assets/icons/ilm/wudhu.svg',
                          onTap: () {},
                        ),
                        IlmCard(
                          title: 'Prayer Rakats',
                          subtitle: 'ركعات الصلاة',
                          svgPath: 'assets/icons/ilm/prayer.svg',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text('5 Pillars of Islam', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GridView.count(
                      padding: EdgeInsets.symmetric(vertical: 24.0),

                      crossAxisCount: 2,
                      childAspectRatio: 0.95,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        IlmCard(
                          title: 'Shahada (Faith)',
                          subtitle: 'الشهادة',
                          svgPath: 'assets/icons/ilm/shahada.svg',
                          onTap: () {},
                        ),
                        IlmCard(
                          title: 'Salah',
                          subtitle: 'الكلمة',
                          svgPath: 'assets/icons/ilm/salah.svg',
                          onTap: () {},
                        ),
                        IlmCard(
                          title: 'Zakat',
                          subtitle: 'آية الكرسي',
                          svgPath: 'assets/icons/ilm/zakat.svg',
                          onTap: () {},
                        ),
                        IlmCard(
                          title: 'Sawn (Fasting)',
                          subtitle: 'الوضوء',
                          svgPath: 'assets/icons/ilm/fasting.svg',
                          onTap: () {},
                        ),
                        IlmCard(
                          title: 'Hajj',
                          subtitle: 'ركعات الصلاة',
                          svgPath: 'assets/icons/ilm/hajj.svg',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 1),
    );
  }
}

