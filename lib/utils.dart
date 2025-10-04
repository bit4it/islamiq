
String getFormattedHijriDate(Map<String, dynamic> hijriDate) {
  print(hijriDate);
  return "${hijriDate["day"]} ${hijriDate["month"]["en"]}, ${hijriDate["year"]} AH";
}

String getFormattedGreorgianDate(Map<String, dynamic> gregorianDate) {
  print(gregorianDate);
  return "${gregorianDate["day"]} ${gregorianDate["month"]["en"]}, ${gregorianDate["year"]}";
}

String getFormattedTime() {
  final now = DateTime.now();
  final hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
  final minute = now.minute.toString().padLeft(2, '0');
  final period = now.hour >= 12 ? 'PM' : 'AM';
  return "$hour:$minute $period";
}