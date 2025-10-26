import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:islamiq/api/location.dart';
import 'package:islamiq/api/services.dart';
import 'package:islamiq/components/prayercard.dart';
import 'package:islamiq/components/bottom_navbar.dart';
import 'package:islamiq/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
} 

class _HomeScreenState extends State<HomeScreen> {
  late Future<PrayerTimesResponse?> futurePrayerTimes;
  String hijriDate = '';
  String gregorianDate = '';
  String formattedTime = getFormattedTime();
  Map<String, String> prayerTimes = {};

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  void fetchLocation() async {
    try {
      Position position = await fetchCurrentLocation();
      setState(() {
        DateTime now = DateTime.now();
        String todayDate = '${now.day}-${now.month}-${now.year}';
        // Call API once screen loads
        futurePrayerTimes = fetchPrayerTimes(
          date: todayDate,  // 👈 your date
          latitude: position.latitude,   // 👈 your lat
          longitude: position.longitude,  // 👈 your long
        );

        futurePrayerTimes.then((value) {
          setState(() {
            prayerTimes = value?.timings ?? {};
            hijriDate = getFormattedHijriDate(value?.hijriDate ?? {});
            gregorianDate = getFormattedGreorgianDate(value?.gregorianDate ?? {});
          });
        });
        
      });
    } catch (e) {
      print("Exception in getting location : $e");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Stack(

        children: [
          Column(
            children: [
              // Header Image Section with overlay content
              SizedBox(
                width: double.infinity,
                height: 380,
                child: Stack(
                  children: [
                    // Background SVG Image
                    SvgPicture.asset(
                      'assets/images/homebackground.svg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 380,
                    ),
                    
                    // Header content on top of image
                    SafeArea(
                      child: _buildHeader(formattedTime, hijriDate, gregorianDate),
                    ),
                  ],
                ),
              ),
              
              // Main Content
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 70), // Space for overlapping prayer times
                        
                        const SizedBox(height: 20),
                        
                        // Quick Actions Grid
                        _buildQuickActionsGrid(context),
                        
                        const SizedBox(height: 20),
                        
                        // Daily Verse Card
                        _buildDailyCard(
                          title: 'Daily Verse',
                          surahInfo: 'Surah Al-Isra, (Verse 23)',
                          arabicText: 'وَقَضَىٰ رَبُّكَ أَلَّا تَعْبُدُوا إِلَّا إِيَّاهُ وَبِالْوَالِدَيْنِ إِحْسَانًا ۚ إِمَّا يَبْلُغَنَّ عِندَكَ\nالْكِبَرَ أَحَدُهُمَا أَوْ كِلَاهُمَا فَلَا تَقُل لَّهُمَا أُفٍّ وَلَا...',
                          translation: 'And your Lord has decreed that you not worship except Him, and to parents....',
                          backgroundColor: const Color(0xFF0D8E6F),
                        ),
                     
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Prayer Times Row - Overlapping
          Positioned(
            top: 340, // Adjust this to control overlap position
            left: 0,
            right: 0,
            child: _buildPrayerTimesRow(prayerTimes),
          ),
        ],
      ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }
  }
    Widget _buildHeader(String formattedTime, String hijriDate, String gregorianDate) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date and Location
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                      hijriDate,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      gregorianDate,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Delhi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 120),
            
            // Time until Ashar
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  Text(
                    formattedTime,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height:2),
                  Text(
                    'Ashar 2 Hours 9 Min Left',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
    }
  

  Widget _buildPrayerTimesRow(Map<String, String> prayerTimes) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Color.fromRGBO(251, 248, 247, 1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
            buildPrayerTimeItem('Fajr', prayerTimes["Fajr"] ?? 'N/A', "fajr"),
            buildPrayerTimeItem('Dhuhr', prayerTimes["Dhuhr"] ?? 'N/A', "duhr"),
            buildPrayerTimeItem('Asr', prayerTimes["Asr"] ?? 'N/A', "asr"),
            buildPrayerTimeItem('Maghrib', prayerTimes["Maghrib"] ?? 'N/A', "maghrib"),
            buildPrayerTimeItem('Isha', prayerTimes["Isha"] ?? 'N/A', "isha"),
            ],
      ),
    );
  }


Widget _buildQuickActionsGrid(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(child: buildQuickActionCard(context, 'Quran Majeed', "quran")),
            const SizedBox(width: 12),
            Expanded(child: buildQuickActionCard(context, 'Dua', "dua")),
            const SizedBox(width: 12),
            Expanded(child: buildQuickActionCard(context, 'Mosque', "mosque")),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: buildQuickActionCard(context, 'Qibla', "qibla")),
            const SizedBox(width: 12),
            Expanded(child: buildQuickActionCard(context, 'Tasbih', "tasbeeh")),
            const SizedBox(width: 12),
            Expanded(child: buildQuickActionCard(context, 'Hijri Calendar', "calender")),
          ],
        ),
      ],
    ),
  );
}


  Widget _buildDailyCard({
    required String title,
    required String surahInfo,
    required String arabicText,
    required String translation,
    required Color backgroundColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: backgroundColor == Colors.white ? Colors.black87 : Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                surahInfo,
                style: TextStyle(
                  color: backgroundColor == Colors.white ? Colors.grey[600] : Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            arabicText,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: backgroundColor == Colors.white ? Colors.black87 : Colors.white,
              fontSize: 18,
              height: 2,
              fontFamily: 'Arabic',
            ),
          ),
          const SizedBox(height: 12),
          Text(
            translation,
            style: TextStyle(
              color: backgroundColor == Colors.white ? Colors.grey[700] : Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

