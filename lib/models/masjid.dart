class Masjid {
  final String id;
  final String name;
  final String description;
  final String imamName;
  final String address;
  final String phone;
  final String email;
  final List<String> images;
  final PrayerTimes prayerTimes;
  final List<Announcement> announcements;
  final bool isVerified;
  final double rating;
  final int totalRatings;
  final DateTime createdAt;
  final DateTime updatedAt;

  Masjid({
    required this.id,
    required this.name,
    required this.description,
    required this.imamName,
    required this.address,
    required this.phone,
    required this.email,
    required this.images,
    required this.prayerTimes,
    required this.announcements,
    this.isVerified = false,
    this.rating = 0.0,
    this.totalRatings = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Masjid.fromJson(Map<String, dynamic> json) {
    return Masjid(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imamName: json['imam_name'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      prayerTimes: PrayerTimes.fromJson(json['prayer_times'] ?? {}),
      announcements: (json['announcements'] as List? ?? [])
          .map((item) => Announcement.fromJson(item))
          .toList(),
      isVerified: json['is_verified'] ?? false,
      rating: (json['rating'] ?? 0).toDouble(),
      totalRatings: json['total_ratings'] ?? 0,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imam_name': imamName,
      'address': address,
      'phone': phone,
      'email': email,
      'images': images,
      'prayer_times': prayerTimes.toJson(),
      'announcements': announcements.map((item) => item.toJson()).toList(),
      'is_verified': isVerified,
      'rating': rating,
      'total_ratings': totalRatings,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class PrayerTimes {
  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String jumma;
  final DateTime date;

  PrayerTimes({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.jumma,
    required this.date,
  });

  factory PrayerTimes.fromJson(Map<String, dynamic> json) {
    return PrayerTimes(
      fajr: json['fajr'] ?? '',
      dhuhr: json['dhuhr'] ?? '',
      asr: json['asr'] ?? '',
      maghrib: json['maghrib'] ?? '',
      isha: json['isha'] ?? '',
      jumma: json['jumma'] ?? '',
      date: json['date'] != null 
          ? DateTime.parse(json['date']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fajr': fajr,
      'dhuhr': dhuhr,
      'asr': asr,
      'maghrib': maghrib,
      'isha': isha,
      'jumma': jumma,
      'date': date.toIso8601String(),
    };
  }
}

class Announcement {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime? expiryDate;
  final bool isImportant;
  final String category;

  Announcement({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.createdAt,
    this.expiryDate,
    this.isImportant = false,
    required this.category,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      expiryDate: json['expiry_date'] != null 
          ? DateTime.parse(json['expiry_date']) 
          : null,
      isImportant: json['is_important'] ?? false,
      category: json['category'] ?? 'general',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'expiry_date': expiryDate?.toIso8601String(),
      'is_important': isImportant,
      'category': category,
    };
  }
}