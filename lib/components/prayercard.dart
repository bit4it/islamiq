import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


Widget buildQuickActionCard(BuildContext context, String title, String iconName) {
  return GestureDetector(
    onTap: () {
      // Handle button press - map mosque icon to masjid route
      String route = iconName == 'mosque' ? 'masjid' : iconName;
      Navigator.pushNamed(context, '/$route');
    },
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(251, 248, 247, 1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: SvgPicture.asset(
              'assets/icons/features/$iconName.svg',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}




  Widget buildPrayerTimeItem(String name, String? time, String iconName) {
    bool isActive = false;
    
    if (time != null) {
      final now = DateTime.now();
      final parts = time.split(":");
      if (parts.length == 2) {
        int hour = int.parse(parts[0]);
        int minute = int.parse(parts[1]);
      
        final prayerTime = DateTime(now.year, now.month, now.day, hour, minute);
        isActive = now.isAfter(prayerTime);
      }
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFE8F5F1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
           SizedBox(
            width: 30,
            height:30 ,
            child: SvgPicture.asset('assets/icons/prayers/$iconName.svg', fit: BoxFit.cover),
          )
          ,
          const SizedBox(height: 4),
          Text(
            name,
            style: TextStyle(
              color: Color.fromRGBO(117, 104, 96, 1),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            time ?? '',
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }