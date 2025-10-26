import 'package:flutter/material.dart';
import 'package:islamiq/APIs/quran.dart';
import 'package:islamiq/api/base.dart';
import 'package:islamiq/api/quran.dart';
import 'package:islamiq/components/appbar.dart';
import 'package:islamiq/components/quran/chapter_card_modern.dart';
import 'package:islamiq/components/quran/listen_juz_card.dart';
import 'package:islamiq/components/quran/listen_quran_card.dart';
import 'package:islamiq/components/quran/juz_card.dart';
import 'package:islamiq/components/searchBar.dart';
import 'package:islamiq/components/selector.dart';
import 'package:islamiq/models/quran.dart';
import 'package:islamiq/theme/app_theme.dart';



class QuranMajeedScreen extends StatefulWidget {
  QuranMajeedScreen({Key? key}) : super(key: key);

  @override
  State<QuranMajeedScreen> createState() => _QuranMajeedScreenState();
}

class _QuranMajeedScreenState extends State<QuranMajeedScreen> {
  late Future<List<Chapter>> quranChapters = quranAPIs.fetchQuranChapters(withVerses: true);
  final Future<List<Juz>> quranJuz = quranAPIs.fetchQuranJuzs();
  int selectedTab = 0;
  int selectedSection = 0;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: Column(
        children: [
          const GenericAppBar(title: "Quran Majeed", iconPath: null, onIconPressed: null),

          SelectorTabs(
            tabs: [
              SelectorTabData(label: 'Listen To Quran', icon: Icons.menu_book),
              SelectorTabData(label: 'Read Quran', icon: Icons.layers),
            ],
            initialIndex: selectedTab,
            onTabSelected: (index) {
              setState(() {
                selectedTab = index;
              });
            },
          ),
          const SizedBox(height: 16),

          const GenericSearchBar(placeholderText: "Search Quran",),

          const SizedBox(height: 16),

          SelectorTabs(
            tabs: [
              SelectorTabData(label: 'Sura', icon: null),
              SelectorTabData(label: 'Parah', icon: null),
              // SelectorTabData(label: 'Favourite', icon: null),
            ],
            initialIndex: selectedSection,
            onTabSelected: (index) {
              setState(() {
                selectedSection = index;
              });
            },
          ),

          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                if (selectedSection == 1) ...[
                
                FutureBuilder<List<Juz>>(
                  future: quranJuz,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final juzList = snapshot.data!;
                      return Column(
                        children: [
                          for (var juz in juzList) ...[
                            selectedTab == 0
                                ? ListenJuzCard(
                                    index: juzList.indexOf(juz) + 1,
                                    arabicTitle: juz.urName ?? '',
                                    romanTitle: juz.translitName,
                                    verseCount: juz.verseCount ?? 0,
                                  )
                                : QuranJuzCard(
                                    index: juzList.indexOf(juz) + 1,
                                    arabicTitle: juz.urName ?? '',
                                    romanTitle: juz.translitName,
                                    verseCount: juz.verseCount ?? 0,
                                  ),
                          ],
                        ],
                      );
                    }
                  },
                ),
                ] 
                 
                else if (selectedSection != 1) ...[
                  FutureBuilder<List<dynamic>>(
                    future: quranChapters,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final chapters = snapshot.data!;
                        print("Chapters: ${chapters[0].verses[0].content}");
                        return Column(
                          children: [
                            for (var chapter in chapters) ...[
                              
                              selectedTab == 0
                                  ? ListenQuranCard(
                                      index: chapters.indexOf(chapter) + 1,
                                      arabicTitle: chapter.arName ?? '',
                                      romanTitle: chapter.translitName ?? '',
                                      englishTitle: chapter.enName ?? '',
                                      origin: chapter.origin ?? '',
                                    )
                                  : ChapterCardModern(
                                      index: chapters.indexOf(chapter) + 1,
                                      arabicTitle: chapter.arName ?? '',
                                      romanTitle: chapter.translitName ?? '',
                                      englishTitle: chapter.enName ?? '',
                                      origin: chapter.origin ?? '',
                                      verseCount: chapter.verseCount ?? 0,
                                      verses: chapter.verses ?? [],
                                    ),
                            ],
                          ],
                        );
                      } else {
                        return const Center(child: Text('No data available'));
                      }
                    },
                  ),
                ],
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
