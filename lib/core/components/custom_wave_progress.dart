import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:readback/core/constants/app_colors.dart';

class CustomProgressIndicator extends ProgressIndicator {
  const CustomProgressIndicator({
    Key? key,
    required double value,
    Color? backgroundColor = AppColors.progressBackgroundColor,
    Color? color,
    this.minHeight,
    this.borderRadius = 18,
    this.waveWidth = 10,
    this.waveColor = const Color(0x21FFFFFF),
    this.waveBackgroundColor = AppColors.progressBackgroundColor,
    this.waveStep = 8,
    this.labelDecoration,
    this.enableBounceAnimation = false,
    this.width,
    this.thickness,
    this.diagonalStrapColor = const Color(0xFFFFFFFF),
    this.diagonalStrapWidth = 20.0,
    this.diagonalStrapAngle = 45.0,
    this.diagonalStrapSpacing = 30.0,
    this.animateWave = true,
    this.showLabel = true, // Added option to show/hide label
    this.label, // Added option for custom label text
    this.labelStyle, // Added option for custom label style
  }) : super(
    key: key,
    value: value,
    backgroundColor: backgroundColor,
    color: color,
  );

  /// The minimum height of the line used to draw the linear indicator.
  final double? minHeight;

  /// Rounded corners of the progress indicator
  final double? borderRadius;

  /// Width of wave
  final double waveWidth;

  /// Background color of the progress indicator
  final Color waveBackgroundColor;

  /// Spacing from wave to the next wave
  final double waveStep;

  /// Color of the spacing between waves
  final Color waveColor;

  /// Decoration of the progress label widget
  final Decoration? labelDecoration;

  /// Whether to turn on the bouncing animation effect
  final bool enableBounceAnimation;

  /// Width of the progress bar (null for full width)
  final double? width;

  /// Thickness (height) of the progress bar
  final double? thickness;

  /// Color of the diagonal straps
  final Color diagonalStrapColor;

  /// Width of each diagonal strap
  final double diagonalStrapWidth;

  /// Angle of the diagonal straps in degrees
  final double diagonalStrapAngle;

  /// Spacing between diagonal straps
  final double diagonalStrapSpacing;

  /// Whether to animate the wave pattern
  final bool animateWave;

  /// Whether to show the progress label
  final bool showLabel;

  /// Custom label text (if null, percentage will be shown)
  final String? label;

  /// Custom label text style
  final TextStyle? labelStyle;

  @override
  State<StatefulWidget> createState() => _WaveLinearProgressIndicatorState();
}

class _WaveLinearProgressIndicatorState
    extends State<CustomProgressIndicator> with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  final GlobalKey _progressLabelKey = GlobalKey();

  Decoration get _labelDecoration {
    if (widget.labelDecoration != null) {
      return widget.labelDecoration!;
    }
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xFF9DF3E9),
          Color(0xFF71E4D6),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(
        color: Colors.white,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(13),
    );
  }

  Color get _backgroundColor {
    final Color trackColor = widget.backgroundColor ??
        _indicatorTheme.linearTrackColor ??
        Theme.of(context).colorScheme.background;
    return trackColor;
  }

  double get _minHeight =>
      widget.minHeight ?? _indicatorTheme.linearMinHeight ?? 9;

  // Use thickness if provided, otherwise use minHeight
  double get _thickness => widget.thickness ?? _minHeight;

  // Calculate the overall height including label padding
  double get _progressLabelHeight => _thickness + 4.5 * 2;

  ProgressIndicatorThemeData get _indicatorTheme =>
      ProgressIndicatorTheme.of(context);

  @override
  void initState() {
    _waveController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000));

    // Only start the wave animation if animateWave is true
    if (widget.animateWave) {
      _waveController.repeat();
    }

    _progressController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _progressAnimation =
        Tween(begin: widget.value).animate(_progressController);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldValue = oldWidget.value ?? 0;
    final newValue = widget.value ?? 0;

    // Handle wave animation toggle
    if (oldWidget.animateWave != widget.animateWave) {
      if (widget.animateWave) {
        _waveController.repeat();
      } else {
        _waveController.stop();
        _waveController.reset();
      }
    }

    if (widget.enableBounceAnimation) {
      double bouncingValue = newValue +
          (10 / 100) * ((newValue - oldValue) / (newValue - oldValue).abs());
      bouncingValue = bouncingValue.clamp(0, 1.0).toDouble();
      _progressAnimation = TweenSequence(<TweenSequenceItem<double>>[
        TweenSequenceItem(
          tween: Tween(begin: oldValue, end: bouncingValue)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 3 / 4,
        ),
        TweenSequenceItem(
          tween: Tween(begin: bouncingValue, end: newValue)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 1 / 4,
        ),
      ]).animate(_progressController);
    } else {
      _progressAnimation =
          Tween(begin: oldValue, end: newValue).animate(_progressController);
    }
    _progressController.forward(from: 0);
  }

  @override
  void dispose() {
    _waveController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: widget.width ?? double.infinity,
        minHeight: _progressLabelHeight,
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        final progressWidth = widget.width ?? constraints.maxWidth;

        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: _thickness,
                  minWidth: progressWidth,
                ),
                child: CustomPaint(
                  painter: WaveIndicatorPainter(
                    repaint: _waveController,
                    progressAnimation: _progressAnimation,
                    backgroundColor: _backgroundColor,
                    progressColor: widget.color ?? widget.waveBackgroundColor,
                    borderRadius: widget.borderRadius,
                    waveWidth: widget.waveWidth,
                    waveStep: widget.waveStep,
                    waveColor: widget.waveColor,
                    diagonalStrapColor: widget.diagonalStrapColor,
                    diagonalStrapWidth: widget.diagonalStrapWidth,
                    diagonalStrapAngle: widget.diagonalStrapAngle,
                    diagonalStrapSpacing: widget.diagonalStrapSpacing,
                  ),
                ),
              ),
            ),
            // Only show the label if showLabel is true
            if (widget.showLabel) _buildProgressLabel(progressWidth),
          ],
        );
      }),
    );
  }

  Widget _buildProgressLabel(double progressWidth) {
    // Use custom label if provided, otherwise show percentage
    final labelText = widget.label ?? '${(widget.value! * 100).round()}%';

    return Positioned(
      right: 0,
      child: Container(
        key: _progressLabelKey,
        decoration: _labelDecoration,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        child: Text(
          labelText,
          style: widget.labelStyle ?? const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class WaveIndicatorPainter extends CustomPainter {
  final Animation<double> repaint;
  final Animation<double> progressAnimation;
  final Color backgroundColor;
  final Color progressColor;
  final double? borderRadius;
  final double waveWidth;
  final double waveStep;
  final Color waveColor;
  final Color diagonalStrapColor;
  final double diagonalStrapWidth;
  final double diagonalStrapAngle;
  final double diagonalStrapSpacing;

  WaveIndicatorPainter({
    required this.repaint,
    required this.progressAnimation,
    required this.backgroundColor,
    required this.progressColor,
    this.borderRadius,
    required this.waveWidth,
    required this.waveStep,
    required this.waveColor,
    required this.diagonalStrapColor,
    required this.diagonalStrapWidth,
    required this.diagonalStrapAngle,
    required this.diagonalStrapSpacing,
  }) : super(repaint: Listenable.merge([repaint, progressAnimation]));

  @override
  void paint(Canvas canvas, Size size) {
    final progress = progressAnimation.value;
    final waveOffset = repaint.value * waveStep;

    // Draw background bar with rounded ends
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    // Create a rounded rectangle for the background
    final backgroundRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius ?? 0),
    );
    canvas.drawRRect(backgroundRect, backgroundPaint);

    if (progress > 0) {
      // Draw progress bar with rounded ends
      final progressPaint = Paint()
        ..color = progressColor
        ..style = PaintingStyle.fill;

      // Create a rounded rectangle for the progress
      final progressRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width * progress, size.height),
        Radius.circular(borderRadius ?? 0),
      );
      canvas.drawRRect(progressRect, progressPaint);

      // Create a path for clipping the diagonal straps to the rounded progress bar
      final progressPath = Path();
      progressPath.addRRect(progressRect);

      canvas.save();
      // Clip to the rounded progress bar
      canvas.clipPath(progressPath);

      // Convert angle to radians
      final angleRad = math.pi * diagonalStrapAngle / 180.0;

      // Calculate the vertical offset based on the angle
      final verticalOffset = diagonalStrapSpacing * math.tan(angleRad);

      // Calculate the number of straps needed to cover the progress bar
      final strapCount = (size.width / diagonalStrapSpacing).ceil() + 2;

      // Create paint for the diagonal straps
      final strapPaint = Paint()
        ..color = diagonalStrapColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = diagonalStrapWidth
        ..strokeCap = StrokeCap.round;

      // Draw each diagonal strap in the opposite direction
      for (int i = -1; i < strapCount; i++) {
        // Calculate the starting position of the strap (now starting from the right)
        final startX = i * diagonalStrapSpacing + waveOffset + diagonalStrapSpacing;
        final startY = -verticalOffset;

        // Calculate the ending position of the strap (going to the left)
        final endX = startX - size.height / math.tan(angleRad);
        final endY = size.height + verticalOffset;

        // Draw the diagonal strap
        canvas.drawLine(
          Offset(startX, startY),
          Offset(endX, endY),
          strapPaint,
        );
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant WaveIndicatorPainter oldDelegate) {
    return true;
  }
}