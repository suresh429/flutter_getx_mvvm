import 'package:flutter/material.dart';
import '../model/LoginModel.dart';

class ProfileWithProgressBar extends StatelessWidget {
  final LoginModel data;
  final double size;

  const ProfileWithProgressBar({
    required this.data,
    this.size = 60.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int progressPercentage = calculateProfileCompletion(data.data);
    Color progressColor = _getProgressColor(progressPercentage);

    double avatarSize = size * 0.78;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: _RoundedArcPainter(
                  progress: progressPercentage / 100,
                  color: progressColor,
                  strokeWidth: size * 0.05,
                ),
              ),
            ),
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    data.data?.profileImageUrl ?? 'https://via.placeholder.com/150',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Percentage badge overlapping the bottom of the progress arc
            Positioned(
              bottom: size * 0.08, // was 0.02 before — lift it more
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size * 0.12,
                  vertical: size * 0.04,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(size * 0.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Text(
                  '$progressPercentage%',
                  style: TextStyle(
                    fontSize: size * 0.15,
                    fontWeight: FontWeight.bold,
                    color: progressColor,
                  ),
                ),
              ),
            ),


          ],
        ),
        const SizedBox(height: 8),

      ],
    );
  }

  Color _getProgressColor(int percentage) {
    if (percentage < 40) return Colors.red;
    if (percentage < 75) return Colors.orange;
    return Colors.green;
  }

  int calculateProfileCompletion(data) {
    if (data == null) return 0;

    int percentage = 0;
    bool basicInfoComplete = data.currentRole?.isNotEmpty == true &&
        isNameComplete(data.name) &&
        isAddressComplete(data.address);

    if (basicInfoComplete) percentage += 30;
    if (data.aboutMe?.isNotEmpty == true) percentage += 10;
    if (data.experience?.isNotEmpty == true) percentage += 20;
    if (data.functionalExpertise?.isNotEmpty == true) percentage += 20;
    if (data.areasOfInterest?.isNotEmpty == true) percentage += 10;
    if (data.achievements?.isNotEmpty == true) percentage += 10;

    return percentage.clamp(0, 100);
  }

  bool isNameComplete(name) {
    return name?.firstName?.isNotEmpty == true ||
        name?.middleName?.isNotEmpty == true ||
        name?.lastName?.isNotEmpty == true;
  }

  bool isAddressComplete(address) {
    return address?.line1?.isNotEmpty == true ||
        address?.city?.isNotEmpty == true ||
        address?.state?.isNotEmpty == true;
  }
}
class _RoundedArcPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _RoundedArcPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final startAngle = 5 * 3.14 / 6;  // ~150°
    final sweepAngle = 4 * 3.14 / 3;  // ~240°

    final backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    final arcRect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    canvas.drawArc(arcRect, startAngle, sweepAngle, false, backgroundPaint);
    canvas.drawArc(arcRect, startAngle, sweepAngle * progress, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
