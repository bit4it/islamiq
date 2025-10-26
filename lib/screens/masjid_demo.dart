import 'package:flutter/material.dart';
import 'package:islamiq/models/masjid.dart';
import 'package:islamiq/screens/masjid_home.dart';

class MasjidDemoScreen extends StatelessWidget {
  const MasjidDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample masjid data
    final sampleMasjid = Masjid(
      id: '1',
      name: 'Al-Noor Mosque',
      description: 'A peaceful place of worship serving the local Muslim community with daily prayers, Friday sermons, and Islamic education programs.',
      imamName: 'Sheikh Muhammad Abdullah',
      address: '123 Main Street, Downtown Area, City 12345',
      phone: '+1 (555) 123-4567',
      email: 'info@alnoormasjid.org',
      images: [],
      prayerTimes: PrayerTimes(
        fajr: '5:30 AM',
        dhuhr: '12:45 PM',
        asr: '4:15 PM',
        maghrib: '6:30 PM',
        isha: '8:00 PM',
        jumma: '1:00 PM',
        date: DateTime.now(),
      ),
      announcements: [
        Announcement(
          id: '1',
          title: 'Ramadan Schedule Updated',
          description: 'The prayer timings for the holy month of Ramadan have been updated. Please check the new schedule and plan accordingly. Iftar will be served daily at the masjid.',
          createdAt: DateTime.now().subtract(Duration(days: 1)),
          expiryDate: DateTime.now().add(Duration(days: 30)),
          isImportant: true,
          category: 'prayer',
        ),
        Announcement(
          id: '2',
          title: 'Community Cleanup Drive',
          description: 'Join us this Saturday for a community cleanup drive around the masjid premises. Volunteers are needed from 9 AM to 12 PM.',
          createdAt: DateTime.now().subtract(Duration(days: 3)),
          expiryDate: DateTime.now().add(Duration(days: 2)),
          isImportant: false,
          category: 'community',
        ),
        Announcement(
          id: '3',
          title: 'Islamic Study Circle',
          description: 'Weekly Islamic study circle every Wednesday evening at 7 PM. This week we will be discussing the virtues of patience in Islam.',
          createdAt: DateTime.now().subtract(Duration(days: 5)),
          isImportant: false,
          category: 'education',
        ),
      ],
      isVerified: true,
      rating: 4.5,
      totalRatings: 127,
      createdAt: DateTime.now().subtract(Duration(days: 365)),
      updatedAt: DateTime.now(),
    );

    return MasjidHomeScreen(masjid: sampleMasjid);
  }
}