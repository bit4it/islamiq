


class Language {
  final int id;
  final String code;
  final String name;

  Language({
    required this.id,
    required this.code,
    required this.name,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['id'],
      code: json['code'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
    };
  }
}



class Chapter {
  final int chapterId;
  final String enName;
  final String arName;
  final String translitName;
  final bool? isFavourite;
  final String origin;
  final int verseCount;
  final List<ChapterVerse>? verses;

  Chapter({
    required this.chapterId,
    required this.enName,
    required this.arName,
    required this.translitName,
    required this.isFavourite,
    required this.origin,
    required this.verseCount,
    this.verses,

  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      chapterId: json['chapter_id'],
      enName: json['en_name'],
      arName: json['ar_name'],
      translitName: json['translit_name'],
      isFavourite: json['is_favourite'],
      origin: json['origin'],
      verseCount: json['verse_count'],
      verses: json['verses'] != null
          ? (json['verses'] as List)
              .map((v) => ChapterVerse.fromJson(v))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chapter_id': chapterId,
      'en_name': enName,
      'ar_name': arName,
      'translit_name': translitName,
      'is_favourite': isFavourite,
      'origin': origin,
      'verse_count': verseCount,
      'verses': verses?.map((v) => v.toJson()).toList(),
    };
  }
}


class ChapterVerse {
  final int? juzId;
  final int verseNumber;
  final String content;
  final Language? language;

  ChapterVerse({
    required this.juzId,
    required this.verseNumber,
    required this.content,
    this.language,
  }); 
  

  factory ChapterVerse.fromJson(Map<String, dynamic> json) {
    return ChapterVerse(
      juzId: json['juz_id'],
      verseNumber: json['verse_number'],
      content: json['content'],
      language: json['language'] != null ? Language.fromJson(json['language']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'juz_id': juzId,
      'verse_number': verseNumber,
      'content': content,
      'language': language?.toJson(),
    };
  }
}



class Juz {
  final int juzId;
  final String? urName;
  final String translitName;
  final int? verseCount;
  final int startChapter;
  final int startVerseNumber;
  final int endChapter;
  final int endVerseNumber;

  Juz({
    required this.juzId,
    this.urName,
    required this.translitName,
    this.verseCount,
    required this.startChapter,
    required this.startVerseNumber,
    required this.endChapter,
    required this.endVerseNumber,
  });

  factory Juz.fromJson(Map<String, dynamic> json) {
    return Juz(
      juzId: json['juz_id'],
      urName: json['ur_name'],
      translitName: json['translit_name'],
      verseCount: json['verse_count'],
      startChapter: json['start_chapter'],
      startVerseNumber: json['start_verse_number'],
      endChapter: json['end_chapter'],
      endVerseNumber: json['end_verse_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'juz_id': juzId,
      'ur_name': urName,
      'translit_name': translitName,
      'verse_count': verseCount,
      'start_chapter': startChapter,
      'start_verse_number': startVerseNumber,
      'end_chapter': endChapter,
      'end_verse_number': endVerseNumber,
    };
  }
}