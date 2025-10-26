import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamiq/APIs/quran.dart';
import 'package:islamiq/components/quran_reader_appbar.dart';
import 'package:islamiq/components/quran_bismillah_banner.dart';
import 'package:islamiq/components/quran_ayah_item.dart';
import 'package:islamiq/models/quran.dart';
import 'package:islamiq/theme/app_theme.dart';



class QuranMajeedReaderScreen extends StatefulWidget {
  QuranMajeedReaderScreen({Key? key}) : super(key: key);


  
  State<QuranMajeedReaderScreen> createState() => _QuranMajeedReaderScreenState();
}

class _QuranMajeedReaderScreenState extends State<QuranMajeedReaderScreen> {
  Chapter? chapterData;
  List<ChapterVerse>? translationVerses;

  final Future<List<Language>> translationOptions = quranAPIs.fetchAvailableLanguages();
    
  String selectedTranslation = 'Off';
  final String surahName = 'Al - Faatihah';
  final String surahArabicName = 'الفاتحة';

  
  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null && args['chapter'] != null) {
        print("  Received chapter data in QuranMajeedReaderScreen ${args['chapter']}");
        setState(() {
          chapterData = Chapter.fromJson(args['chapter']);
        });

        print("  Verses in QuranMajeedReaderScreen: ${chapterData?.verses?.length}");
        
      } else {
        chapterData = null;
      }
    });
  }


  void _showTranslationSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.backgroundWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: FutureBuilder(future: translationOptions, builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                final languages = snapshot.data ?? [];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var language in languages)
                     
                      _translationOption(language),
                  ],
                );
              }
            }),
     
        );
      },
    );
  }

  Widget _translationOption(Language language) {
    final isSelected = selectedTranslation == language.name;
    return ListTile(
      title: Text(language.name, style: const TextStyle(fontSize: 18, color: AppTheme.textDark)),
      subtitle: Text(language.code, style: const TextStyle(color: AppTheme.textMedium)),
      trailing: isSelected ? const Icon(Icons.check, color: AppTheme.primaryGreen) : null,
      onTap: () async {
        // close sheet first
        Navigator.of(context).pop();

        setState(() {
          selectedTranslation = language.name;
        });

        // small feedback
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Loading ${language.name}...'),
            duration: const Duration(seconds: 2),
          ),
        );

        try {
          // handle 'Off' option: clear translations without fetching
          if (language.code.toLowerCase() == 'off') {
            setState(() {
              translationVerses = null;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Translation turned off'),
                duration: const Duration(seconds: 2),
              ),
            );
            return;
          }

          final code = language.code;
          final chapters = await quranAPIs.fetchQuranChapters(withVerses: true, language_code: code);

          if (chapters.isNotEmpty) {
            // find current chapter by id and store its verses in translationVerses
            if (chapterData != null) {
              final updated = chapters.firstWhere((c) => c.chapterId == chapterData!.chapterId, orElse: () => chapters.first);
              setState(() {
                translationVerses = updated.verses;
              });
            } else {
              // no original chapter loaded - use the fetched chapter as original (edge-case)
              setState(() {
                chapterData = chapters.first;
                translationVerses = chapters.first.verses;
              });
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${language.name} loaded'),
                backgroundColor: AppTheme.primaryGreen,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to load ${language.name}: $e'),
              backgroundColor: Colors.redAccent,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
    );
  }

  void _shareAyah(String ayahText, int ayahNumber) {
    final shareText = '''
${chapterData?.enName ?? 'Quran'} ${chapterData?.chapterId ?? ''}:$ayahNumber

$ayahText

Shared from IslamIQ App
    ''';
    
    // For now, just print the text that would be shared
    // In a real app, you would use the share_plus package
    print('Sharing: $shareText');
    
    // Show a snackbar to indicate sharing (placeholder)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ayah ${chapterData?.chapterId ?? ''}:$ayahNumber ready to share'),
        backgroundColor: AppTheme.primaryGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppTheme.backgroundLight,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppTheme.backgroundLight,
        body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuranReaderAppBar(
              surahName: chapterData?.enName ?? '',
              surahArabicName: chapterData?.arName ?? '',
              onBack: () => Navigator.of(context).pop(),
              onTranslate: () => _showTranslationSelector(context),
            ),
            
            // Scrollable content with Bismillah banner and ayahs
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 24),
                itemCount: (chapterData?.verses?.length ?? 0) + 1, // +1 for bismillah banner
                itemBuilder: (context, index) {
                  // First item is the Bismillah banner
                  if (index == 0) {
                    return const QuranBismillahBanner();
                  }
                  
                  // Adjust index for ayahs (subtract 1 since bismillah takes index 0)
                  final ayahIndex = index - 1;
                  final ayah = chapterData?.verses?[ayahIndex];
                  String? translationText;

                  if (selectedTranslation != 'Off' && translationVerses != null) {
                    translationText = translationVerses!.length > ayahIndex ? translationVerses![ayahIndex].content : null;
                  }

                  return QuranAyahItem(
                    chapterNumber: chapterData?.chapterId,
                    // Ensure Arabic text remains the original chapter's content
                    ayahText: ayah?.content ?? '',
                    ayahNumber: ayah?.verseNumber ?? 0,
                    translationText: translationText,
                    onMenu: () {
                      // Share functionality can be implemented here
                      _shareAyah(ayah?.content ?? '', ayah?.verseNumber ?? 0);
                    },
                  );
                },
              ),
            ),
                      ],
                    ),
                  ),
        ),
      );
  }
} 