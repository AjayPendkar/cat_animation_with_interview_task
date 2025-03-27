import 'package:flutter/material.dart';
import 'dart:math' as math;

class CatWidget extends StatefulWidget {
  const CatWidget({super.key});

  @override
  State<CatWidget> createState() => _CatWidgetState();
}

class _CatWidgetState extends State<CatWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _tailAnimation;
  late Animation<double> _earAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);

    _tailAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _earAnimation = Tween<double>(
      begin: -0.15,
      end: 0.15,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 300,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: const Size(200, 300),
            painter: CatPainter(
              tailAngle: _tailAnimation.value,
              earAngle: _earAnimation.value,
            ),
          );
        },
      ),
    );
  }
}

class CatPainter extends CustomPainter {
  final double tailAngle;
  final double earAngle;

  CatPainter({
    required this.tailAngle,
    required this.earAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2B3A55)
      ..style = PaintingStyle.fill;

    // Main body
    final bodyPath = Path()
      ..moveTo(size.width * 0.3, size.height * 0.3)
      ..lineTo(size.width * 0.7, size.height * 0.3)
      ..lineTo(size.width * 0.7, size.height * 0.7)
      ..lineTo(size.width * 0.3, size.height * 0.7)
      ..close();
    canvas.drawPath(bodyPath, paint);

    // White belly patch
    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final bellyPath = Path()
      ..moveTo(size.width * 0.4, size.height * 0.35)
      ..quadraticBezierTo(
        size.width * 0.5, size.height * 0.33,
        size.width * 0.6, size.height * 0.35,
      )
      ..lineTo(size.width * 0.6, size.height * 0.7)
      ..lineTo(size.width * 0.4, size.height * 0.7)
      ..close();
    canvas.drawPath(bellyPath, whitePaint);

    // Left Ear
    canvas.save();
    canvas.translate(size.width * 0.3, size.height * 0.3);
    canvas.rotate(earAngle);
    final leftEarPath = Path()
      ..moveTo(0, 0)
      ..lineTo(-20, -35)
      ..lineTo(20, -5)
      ..close();
    canvas.drawPath(leftEarPath, paint);
    canvas.restore();

    // Right Ear
    canvas.save();
    canvas.translate(size.width * 0.7, size.height * 0.3);
    canvas.rotate(-earAngle);
    final rightEarPath = Path()
      ..moveTo(0, 0)
      ..lineTo(20, -35)
      ..lineTo(-20, -5)
      ..close();
    canvas.drawPath(rightEarPath, paint);
    canvas.restore();

    // Eye
    final blackPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.38),
      4,
      blackPaint,
    );

    // Tail with wave animation and shadow
    canvas.save();
    canvas.translate(size.width * 0.7, size.height * 0.55);
    
    // Draw shadow first
    final shadowPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 22
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    final tailPaint = Paint()
      ..color = const Color(0xFF2B3A55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    final tailPath = Path();
    final startY = 5.0;
    tailPath.moveTo(0, startY);

    // Create wave effect through the tail with fixed base
    for (double t = 0; t <= 1; t += 0.01) {
      double x = t * 140;
      double waveAmplitude = t * 25;
      double wave = math.sin(t * 2 + tailAngle) * waveAmplitude;
      double baseCurve = -(t * t * 60) + (t * 70) + startY;
      double y = -wave + baseCurve;
      
      if (t == 0) {
        tailPath.moveTo(x, y);
      } else {
        tailPath.lineTo(x, y);
      }
    }
    
    // Draw shadow
    canvas.drawPath(tailPath, shadowPaint);
    // Draw tail
    canvas.drawPath(tailPath, tailPaint);
    
    canvas.restore();
  }

  @override
  bool shouldRepaint(CatPainter oldDelegate) {
    return oldDelegate.tailAngle != tailAngle || oldDelegate.earAngle != earAngle;
  }
} 