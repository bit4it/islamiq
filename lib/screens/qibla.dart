import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamiq/api/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:islamiq/api/services.dart';

void main() {
  runApp(const QiblaCompassApp());
}

class QiblaCompassApp extends StatelessWidget {
  const QiblaCompassApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFE8D4C8),
      ),
      home: const QiblaCompassScreen(),
    );
  }
}

class QiblaCompassScreen extends StatefulWidget {
  const QiblaCompassScreen({Key? key}) : super(key: key);

  @override
  State<QiblaCompassScreen> createState() => _QiblaCompassScreenState();
}

class _QiblaCompassScreenState extends State<QiblaCompassScreen>
    with SingleTickerProviderStateMixin {
  // Customizable properties
  double currentHeading = 160; // Current device heading
  double targetHeading = 160; // Target heading for smooth animation
  double qiblaDirection = 0; // Qibla direction from north
  String location = "Delhi, India";
  String coordinates = "";

  // Animation controller for smooth compass rotation
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    fetchLocation();
  }

  void fetchLocation() async {
    try {
      Position position = await fetchCurrentLocation();
      setState(() {
        coordinates = "${position.latitude}, ${position.longitude}";
        location = "Your current location";
      });

      Future<double?> direction = fetchQiblaDirection(
        latitude: position.latitude, 
        longitude: position.longitude
      );
      
      direction.then((value) {
        setState(() {
          qiblaDirection = value ?? 0.0;
        });
      });

      FlutterCompass.events!.listen((event) {
        double newHeading = (event.heading ?? 0.0) % 360;
        _updateHeadingSmooth(newHeading);
      });

    } catch (e) {
      setState(() {
        location = "Error: ${e.toString()}";
      });
    }
  }

  void _updateHeadingSmooth(double newHeading) {
    // Calculate the shortest rotation path
    double diff = newHeading - currentHeading;
    
    // Normalize to -180 to 180 range
    if (diff > 180) {
      diff -= 360;
    } else if (diff < -180) {
      diff += 360;
    }
    
    targetHeading = currentHeading + diff;
    
    _animation = Tween<double>(
      begin: currentHeading,
      end: targetHeading,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    )..addListener(() {
        setState(() {
          // Normalize currentHeading to 0-360 range after animation
          currentHeading = _animation.value % 360;
          if (currentHeading < 0) currentHeading += 360;
        });
      });
    
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Calculate color based on heading alignment with Qibla
  Color getCompassColor() {
    double difference = (currentHeading - qiblaDirection).abs();
    
    // Normalize difference to 0-180 range
    if (difference > 180) {
      difference = 360 - difference;
    }

    if (difference <= 10) {
      // Exact match - Green
      return Colors.green;
    } else if (difference <= 45) {
      // Close - Yellow/Orange
      return Colors.orange;
    } else if (difference >= 160) {
      // Opposite direction - Red
      return Colors.red;
    } else {
      // Moving towards - Light red/pink
      return const Color(0xFFFF6B6B);
    }
  }

  String getDirectionLabel(double degree) {
    const directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    int index = ((degree + 22.5) % 360 ~/ 45);
    return directions[index];
  }

  @override
  Widget build(BuildContext context) {
    final compassColor = getCompassColor();

    return Scaffold(
      body: Stack(
        children: [
          // SVG Background
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/qibla.svg',
              fit: BoxFit.cover,
            ),
          ),
          // Main Content
          SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                const SizedBox(height: 20),
                Spacer(),
                const Text(
                  'Heading',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF5D4E47),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${currentHeading.toInt()}° ${getDirectionLabel(currentHeading)}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D2420),
                    letterSpacing: 2,
                  ),
                ),
               
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 320,
                      height: 320,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: compassColor.withOpacity(0.4),
                            blurRadius: 60,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                    ),
                    Transform.rotate(
                      angle: -currentHeading * math.pi / 180,
                      child: CustomPaint(
                        size: const Size(280, 280),
                        painter: CompassPainter(
                          qiblaAngle: qiblaDirection,
                          currentHeading: currentHeading,
                          compassColor: compassColor,
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Center(
                        child: Text(
                          '🕋',
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  '${qiblaDirection.toInt()}° ${getDirectionLabel(qiblaDirection)}',
                  style: const TextStyle(
                    fontSize: 32.2,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D2420),
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  coordinates,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5D4E47),
                  ),
                ),
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF5D4E47),
                  ),
                ),
                const SizedBox(height: 20),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CompassPainter extends CustomPainter {
  final double qiblaAngle;
  final double currentHeading;
  final Color compassColor;

  CompassPainter({
    required this.qiblaAngle,
    required this.currentHeading,
    required this.compassColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw compass circle background
    final bgPaint = Paint()
      ..color = const Color(0xFFD4BFB3).withOpacity(0.8)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, bgPaint);

    // Draw tick marks
    for (int i = 0; i < 360; i++) {
      final angle = i * math.pi / 180;
      final isMainDirection = i % 90 == 0;
      final isMajorTick = i % 30 == 0;
      final isMinorTick = i % 10 == 0;

      double tickLength;
      double tickWidth;

      if (isMainDirection) {
        tickLength = 25;
        tickWidth = 3;
      } else if (isMajorTick) {
        tickLength = 20;
        tickWidth = 2;
      } else if (isMinorTick) {
        tickLength = 12;
        tickWidth = 1.5;
      } else {
        tickLength = 8;
        tickWidth = 1;
      }

      final tickPaint = Paint()
        ..color = const Color(0xFF5D4E47)
        ..strokeWidth = tickWidth
        ..strokeCap = StrokeCap.round;

      final startRadius = radius - tickLength;
      final endRadius = radius;

      final start = Offset(
        center.dx + startRadius * math.cos(angle - math.pi / 2),
        center.dy + startRadius * math.sin(angle - math.pi / 2),
      );
      final end = Offset(
        center.dx + endRadius * math.cos(angle - math.pi / 2),
        center.dy + endRadius * math.sin(angle - math.pi / 2),
      );

      canvas.drawLine(start, end, tickPaint);
    }

    // Draw cardinal direction letters
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    final directions = ['N', 'E', 'S', 'W'];
    for (int i = 0; i < 4; i++) {
      final angle = i * math.pi / 2;
      textPainter.text = TextSpan(
        text: directions[i],
        style: const TextStyle(
          color: Color(0xFF2D2420),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();

      final textRadius = radius - 50;
      final offset = Offset(
        center.dx + textRadius * math.cos(angle - math.pi / 2) - textPainter.width / 2,
        center.dy + textRadius * math.sin(angle - math.pi / 2) - textPainter.height / 2,
      );

      textPainter.paint(canvas, offset);
    }

    // Draw Qibla direction needle (red)
    final qiblaPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    final qiblaAngleRad = qiblaAngle * math.pi / 180;
    final needleLength = radius - 30;

    final qiblaPath = Path();
    qiblaPath.moveTo(center.dx, center.dy);
    qiblaPath.lineTo(
      center.dx + needleLength * math.cos(qiblaAngleRad - math.pi / 2),
      center.dy + needleLength * math.sin(qiblaAngleRad - math.pi / 2),
    );

    // Draw arrow head for Qibla
    final arrowSize = 20.0;
    final arrowAngle = 25 * math.pi / 180;
    
    final arrowTip = Offset(
      center.dx + needleLength * math.cos(qiblaAngleRad - math.pi / 2),
      center.dy + needleLength * math.sin(qiblaAngleRad - math.pi / 2),
    );

    final arrowPath = Path();
    arrowPath.moveTo(arrowTip.dx, arrowTip.dy);
    arrowPath.lineTo(
      arrowTip.dx - arrowSize * math.cos(qiblaAngleRad - math.pi / 2 - arrowAngle),
      arrowTip.dy - arrowSize * math.sin(qiblaAngleRad - math.pi / 2 - arrowAngle),
    );
    arrowPath.lineTo(
      arrowTip.dx - arrowSize * math.cos(qiblaAngleRad - math.pi / 2 + arrowAngle),
      arrowTip.dy - arrowSize * math.sin(qiblaAngleRad - math.pi / 2 + arrowAngle),
    );
    arrowPath.close();

    canvas.drawPath(qiblaPath, qiblaPaint);
    canvas.drawPath(arrowPath, qiblaPaint);

    // Draw opposite needle (dark)
    final oppositePaint = Paint()
      ..color = const Color(0xFF3D2D27)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final oppositeAngleRad = (qiblaAngle + 180) * math.pi / 180;
    canvas.drawLine(
      center,
      Offset(
        center.dx + needleLength * math.cos(oppositeAngleRad - math.pi / 2),
        center.dy + needleLength * math.sin(oppositeAngleRad - math.pi / 2),
      ),
      oppositePaint,
    );

    // Draw other needles for visual effect
    final decorativePaint = Paint()
      ..color = const Color(0xFF5D4E47)
      ..strokeWidth = 2;

    for (int i = 1; i < 4; i++) {
      final decorAngle = (qiblaAngle + i * 90) * math.pi / 180;
      canvas.drawLine(
        center,
        Offset(
          center.dx + (needleLength - 20) * math.cos(decorAngle - math.pi / 2),
          center.dy + (needleLength - 20) * math.sin(decorAngle - math.pi / 2),
        ),
        decorativePaint,
      );
    }
  }

  @override
  bool shouldRepaint(CompassPainter oldDelegate) {
    return oldDelegate.currentHeading != currentHeading ||
        oldDelegate.compassColor != compassColor;
  }
}