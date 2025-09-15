import 'package:flutter/material.dart';
import 'package:etron_flutter/ui/theme/colors.dart';

class AddVehicleDashedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const AddVehicleDashedButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CustomPaint(
        painter: _DashedRRectPainter(
          color: AppColors.primary.withOpacity(.6),
          strokeWidth: 1.4,
          radius: 24.0,
          dashWidth: 6.0,
          dashSpace: 4.0,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 26),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              const Icon(Icons.add, color: AppColors.primary, size: 30),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedRRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double radius;
  final double dashWidth;
  final double dashSpace;

  _DashedRRectPainter({
    required this.color,
    required this.strokeWidth,
    required this.radius,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;

    final path = Path()..addRRect(rrect);
    final dashPath = _createDashedPath(path, dashWidth, dashSpace);
    canvas.drawPath(dashPath, paint);
  }

  Path _createDashedPath(Path source, double dashW, double dashS) {
    final dashed = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final end = (distance + dashW).clamp(0.0, metric.length).toDouble();
        dashed.addPath(metric.extractPath(distance, end), Offset.zero);
        distance += dashW + dashS;
      }
    }
    return dashed;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
