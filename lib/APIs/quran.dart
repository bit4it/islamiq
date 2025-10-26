import 'package:islamiq/APIs/api.dart';
import 'package:islamiq/models/quran.dart';

class QuranAPIs {

  final APIService _apiService = APIService();

  Future<List<Chapter>> fetchQuranChapters({bool withVerses = false, String? language_code}) async {
    if (withVerses) {
      final response = await _apiService.get('quran/chapters/verses?language_code=${language_code ?? 'AR'}');
      if (response.statusCode == 200) {
        final data = response.data;
        List chapters = data['data'] ?? data;

        return chapters
            .map((chapter) => Chapter.fromJson(chapter))
            .toList();

      } else {
        throw Exception('Failed to load chapters with verses');
      }
    } else {
      final response = await _apiService.get('quran/chapters');

      if (response.statusCode == 200) {
        final data = response.data;

        List chapters = data['data'] ?? data;
        return chapters
            .map((chapter) => Chapter.fromJson(chapter))
            .toList();

      } else {

        throw Exception('Failed to load chapters');

      }
      }
  }

  Future<List<Language>> fetchAvailableLanguages() async {
    final response = await _apiService.get('quran/available/languages/');

    if (response.statusCode == 200) {
      final data = response.data;
      List languages = data['data'] ?? data;
      List<Language> languagesList = languages
          .map((language) => Language.fromJson(language))
          .toList();
      languagesList.removeWhere((language) => language.code == "AR");
      languagesList.insert(0, Language(id: 0, name: 'Off', code: 'AR'));
      return languagesList;
      
    } else {
      throw Exception('Failed to load available languages');
    }
  }

  Future<List<Juz>> fetchQuranJuzs() async {
    final response = await _apiService.get('quran/juzs/');

    if (response.statusCode == 200) {
      final data = response.data;
      List juzs = data['data'] ?? data;
      return juzs
          .map((juz) => Juz.fromJson(juz))
          .toList();
    } else {
      throw Exception('Failed to load juzs');
    }
  }
}


final QuranAPIs quranAPIs = QuranAPIs();