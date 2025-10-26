import 'package:flutter/material.dart';
import 'package:islamiq/models/masjid.dart';
import 'package:islamiq/theme/app_theme.dart';

class PrayerTimesCard extends StatelessWidget {
  final PrayerTimes prayerTimes;

  const PrayerTimesCard({Key? key, required this.prayerTimes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prayers = [
      {'name': 'Fajr', 'time': prayerTimes.fajr, 'icon': Icons.wb_sunny_outlined, 'arabic': 'الفجر'},
      {'name': 'Dhuhr', 'time': prayerTimes.dhuhr, 'icon': Icons.wb_sunny, 'arabic': 'الظهر'},
      {'name': 'Asr', 'time': prayerTimes.asr, 'icon': Icons.wb_cloudy, 'arabic': 'العصر'},
      {'name': 'Maghrib', 'time': prayerTimes.maghrib, 'icon': Icons.wb_twilight, 'arabic': 'المغرب'},
      {'name': 'Isha', 'time': prayerTimes.isha, 'icon': Icons.nightlight_round, 'arabic': 'العشاء'},
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.backgroundWhite,
            AppTheme.accentGreen.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: AppTheme.primaryGreen.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Modern Header with Islamic Pattern
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.schedule,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Prayer Times',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _formatDate(prayerTimes.date),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Today',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Modern Prayer Times Table
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Table Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.accentGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Text(
                          'Prayer',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryGreen,
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: Text(
                          'Arabic',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryGreen,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Expanded(
                        flex: 3,
                        child: Text(
                          'Time',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryGreen,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Prayer Rows
                ...prayers.map((prayer) {
                  final isCurrentPrayer = _isCurrentPrayerTime(prayer['name'] as String, prayer['time'] as String);
                  
                  return Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: isCurrentPrayer 
                          ? AppTheme.primaryGreen.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: isCurrentPrayer 
                          ? Border.all(color: AppTheme.primaryGreen.withOpacity(0.3), width: 1.5)
                          : Border.all(color: AppTheme.textLight.withOpacity(0.1)),
                    ),
                    child: Row(
                      children: [
                        // Prayer Name with Icon
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: isCurrentPrayer 
                                      ? AppTheme.primaryGreen
                                      : AppTheme.accentGreen,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Icon(
                                  prayer['icon'] as IconData,
                                  color: isCurrentPrayer 
                                      ? Colors.white
                                      : AppTheme.primaryGreen,
                                  size: 14,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  prayer['name'] as String,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isCurrentPrayer ? FontWeight.w700 : FontWeight.w600,
                                    color: isCurrentPrayer ? AppTheme.primaryGreen : AppTheme.textDark,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Arabic Name
                        Expanded(
                          flex: 2,
                          child: Text(
                            prayer['arabic'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isCurrentPrayer ? AppTheme.primaryGreen : AppTheme.textGreenMedium,
                              fontFamily: 'Arabic',
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        
                        // Time
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                              color: isCurrentPrayer 
                                  ? AppTheme.primaryGreen
                                  : AppTheme.backgroundLight,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              prayer['time'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isCurrentPrayer 
                                    ? Colors.white
                                    : AppTheme.textGreen,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                
                // Jumma Special Section
                if (prayerTimes.jumma.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryGreen.withOpacity(0.1),
                          AppTheme.primaryGreenLight.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryGreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.people, color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Jumu\'ah Prayer',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryGreen,
                                ),
                              ),
                              Text(
                                'Friday Congregation',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.textMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryGreen,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            prayerTimes.jumma,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }



  String _formatDate(DateTime date) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  bool _isCurrentPrayerTime(String prayerName, String prayerTime) {
    // Simple logic to highlight current prayer time
    // You can implement more sophisticated logic based on your needs
    final currentHour = DateTime.now().hour;
    
    // Basic time ranges for highlighting
    switch (prayerName.toLowerCase()) {
      case 'fajr':
        return currentHour >= 4 && currentHour < 7;
      case 'dhuhr':
        return currentHour >= 11 && currentHour < 15;
      case 'asr':
        return currentHour >= 15 && currentHour < 18;
      case 'maghrib':
        return currentHour >= 18 && currentHour < 20;
      case 'isha':
        return currentHour >= 10 || currentHour < 4;
      default:
        return false;
    }
  }
}