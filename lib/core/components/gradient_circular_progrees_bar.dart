import 'package:flutter/material.dart';

enum ProgressType { circular, linear }
enum ProgressStyle { continuous, segmented, dashed }

class AnimatedCircularProgressBar extends StatefulWidget {
  final double progress;
  final ProgressType type;
  final ProgressStyle style;
  final double size;
  final double strokeWidth;
  final double? width; // For linear progress bar
  final double? height; // For linear progress bar
  final Color? progressColor;
  final Gradient? gradient;
  final Color backgroundColor;
  final Color textColor;
  final TextStyle? textStyle;
  final Widget? centerWidget;
  final Duration duration;
  final Curve curve;
  final BorderRadius? borderRadius; // For linear progress bar
  final int? segmentCount; // For segmented style
  final double? dashWidth; // For dashed style
  final double? dashGap; // For dashed style
  final bool rounded; // New parameter to control rounded ends

  const AnimatedCircularProgressBar({
    super.key,
    required this.progress,
    this.type = ProgressType.circular,
    this.style = ProgressStyle.continuous,
    this.size = 200.0,
    this.strokeWidth = 12.0,
    this.width,
    this.height,
    this.progressColor,
    this.gradient,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.textColor = Colors.white,
    this.textStyle,
    this.centerWidget,
    this.duration = const Duration(milliseconds: 1000),
    this.curve = Curves.easeInOut,
    this.borderRadius,
    this.segmentCount,
    this.dashWidth,
    this.dashGap,
    this.rounded = true, // Default to true for backward compatibility
  }) : assert(progressColor != null || gradient != null,
  'Either progressColor or gradient must be provided');

  @override
  State<AnimatedCircularProgressBar> createState() => _AnimatedCircularProgressBarState();
}

class _AnimatedCircularProgressBarState extends State<AnimatedCircularProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _previousProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: widget.progress,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedCircularProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _previousProgress = oldWidget.progress;
      _animation = Tween<double>(
        begin: _previousProgress,
        end: widget.progress,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ));
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        if (widget.type == ProgressType.circular) {
          return _buildCircularProgressBar();
        } else {
          return _buildLinearProgressBar();
        }
      },
    );
  }

  Widget _buildCircularProgressBar() {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: CustomPaint(
              painter: widget.style == ProgressStyle.segmented
                  ? _CircularSegmentedBackgroundPainter(
                strokeWidth: widget.strokeWidth,
                color: widget.backgroundColor,
                segmentCount: widget.segmentCount ?? 10,
                rounded: widget.rounded, // Pass rounded parameter
              )
                  : widget.style == ProgressStyle.dashed
                  ? _CircularDashedBackgroundPainter(
                strokeWidth: widget.strokeWidth,
                color: widget.backgroundColor,
                dashWidth: widget.dashWidth ?? 10.0,
                dashGap: widget.dashGap ?? 5.0,
                rounded: widget.rounded, // Pass rounded parameter
              )
                  : _CircularBackgroundPainter(
                strokeWidth: widget.strokeWidth,
                color: widget.backgroundColor,
                rounded: widget.rounded, // Pass rounded parameter
              ),
            ),
          ),
          // Progress indicator (solid color or gradient)
          Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: CustomPaint(
              painter: widget.gradient != null
                  ? (widget.style == ProgressStyle.segmented
                  ? _CircularSegmentedGradientProgressPainter(
                progress: _animation.value,
                strokeWidth: widget.strokeWidth,
                gradient: widget.gradient!,
                segmentCount: widget.segmentCount ?? 10,
                rounded: widget.rounded, // Pass rounded parameter
              )
                  : widget.style == ProgressStyle.dashed
                  ? _CircularDashedGradientProgressPainter(
                progress: _animation.value,
                strokeWidth: widget.strokeWidth,
                gradient: widget.gradient!,
                dashWidth: widget.dashWidth ?? 10.0,
                dashGap: widget.dashGap ?? 5.0,
                rounded: widget.rounded, // Pass rounded parameter
              )
                  : _CircularGradientProgressPainter(
                progress: _animation.value,
                strokeWidth: widget.strokeWidth,
                gradient: widget.gradient!,
                rounded: widget.rounded, // Pass rounded parameter
              ))
                  : (widget.style == ProgressStyle.segmented
                  ? _CircularSegmentedSolidProgressPainter(
                progress: _animation.value,
                strokeWidth: widget.strokeWidth,
                color: widget.progressColor!,
                segmentCount: widget.segmentCount ?? 10,
                rounded: widget.rounded, // Pass rounded parameter
              )
                  : widget.style == ProgressStyle.dashed
                  ? _CircularDashedSolidProgressPainter(
                progress: _animation.value,
                strokeWidth: widget.strokeWidth,
                color: widget.progressColor!,
                dashWidth: widget.dashWidth ?? 10.0,
                dashGap: widget.dashGap ?? 5.0,
                rounded: widget.rounded, // Pass rounded parameter
              )
                  : _CircularSolidProgressPainter(
                progress: _animation.value,
                strokeWidth: widget.strokeWidth,
                color: widget.progressColor!,
                rounded: widget.rounded, // Pass rounded parameter
              )),
            ),
          ),
          // Center widget or percentage text
          widget.centerWidget ?? Text(
            '${(_animation.value * 100).round()}%',
            style: widget.textStyle ??
                TextStyle(
                  fontSize: widget.size * 0.16,
                  fontWeight: FontWeight.bold,
                  color: widget.textColor,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinearProgressBar() {
    final width = widget.width ?? 200.0;
    final height = widget.height ?? widget.strokeWidth;
    // Use rounded parameter to determine border radius
    final borderRadius = widget.rounded
        ? (widget.borderRadius ?? BorderRadius.circular(height / 2))
        : BorderRadius.zero;

    return Stack(
      children: [
        // Background
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: borderRadius,
          ),
        ),
        // Progress
        if (widget.style == ProgressStyle.segmented)
          _buildSegmentedLinearProgress(width, height, borderRadius)
        else if (widget.style == ProgressStyle.dashed)
          _buildDashedLinearProgress(width, height, borderRadius)
        else
          Container(
            width: width * _animation.value,
            height: height,
            decoration: BoxDecoration(
              color: widget.progressColor,
              gradient: widget.gradient,
              borderRadius: borderRadius,
            ),
          ),
        // Center widget or percentage text
        if (widget.centerWidget != null)
          Positioned.fill(
            child: Center(child: widget.centerWidget),
          )
        else
          Positioned.fill(
            child: Center(
              child: Text(
                '${(_animation.value * 100).round()}%',
                style: widget.textStyle ??
                    TextStyle(
                      fontSize: height * 0.8,
                      fontWeight: FontWeight.bold,
                      color: widget.textColor,
                    ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSegmentedLinearProgress(double width, double height, BorderRadius borderRadius) {
    final segmentCount = widget.segmentCount ?? 10;
    final gapWidth = width * 0.02; // 2% of width for gaps
    final totalGapWidth = gapWidth * (segmentCount - 1);
    final segmentWidth = (width - totalGapWidth) / segmentCount;
    final filledSegments = (_animation.value * segmentCount).floor();
    final partialSegmentProgress = (_animation.value * segmentCount) - filledSegments;

    return Row(
      children: [
        for (int i = 0; i < segmentCount; i++)
          if (i < filledSegments)
            Container(
              width: segmentWidth,
              height: height,
              decoration: BoxDecoration(
                color: widget.progressColor,
                gradient: widget.gradient,
                borderRadius: borderRadius,
              ),
            )
          else if (i == filledSegments && partialSegmentProgress > 0)
            Container(
              width: segmentWidth * partialSegmentProgress,
              height: height,
              decoration: BoxDecoration(
                color: widget.progressColor,
                gradient: widget.gradient,
                borderRadius: borderRadius,
              ),
            )
          else
            SizedBox(width: segmentWidth),
      ],
    );
  }

  Widget _buildDashedLinearProgress(double width, double height, BorderRadius borderRadius) {
    final dashWidth = widget.dashWidth ?? 10.0;
    final dashGap = widget.dashGap ?? 5.0;
    final totalDashWidth = dashWidth + dashGap;
    final dashCount = (width / totalDashWidth).floor();
    final filledDashCount = (_animation.value * dashCount).floor();
    final partialDashProgress = (_animation.value * dashCount) - filledDashCount;

    return Row(
      children: [
        for (int i = 0; i < dashCount; i++)
          if (i < filledDashCount)
            Container(
              width: dashWidth,
              height: height,
              decoration: BoxDecoration(
                color: widget.progressColor,
                gradient: widget.gradient,
                borderRadius: borderRadius,
              ),
            )
          else if (i == filledDashCount && partialDashProgress > 0)
            Container(
              width: dashWidth * partialDashProgress,
              height: height,
              decoration: BoxDecoration(
                color: widget.progressColor,
                gradient: widget.gradient,
                borderRadius: borderRadius,
              ),
            )
          else
            SizedBox(width: dashWidth),
        SizedBox(width: dashGap),
      ],
    );
  }
}

// Circular Progress Painters
class _CircularBackgroundPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final bool rounded; // New parameter

  _CircularBackgroundPainter({
    required this.strokeWidth,
    required this.color,
    required this.rounded, // New parameter
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = rounded ? StrokeCap.round : StrokeCap.butt; // Apply rounded option

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _CircularBackgroundPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.color != color ||
        oldDelegate.rounded != rounded;
  }
}

class _CircularSolidProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color color;
  final bool rounded; // New parameter

  _CircularSolidProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.color,
    required this.rounded, // New parameter
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = rounded ? StrokeCap.round : StrokeCap.butt; // Apply rounded option

    final startAngle = -90 * (3.14159 / 180); // Start from top
    final sweepAngle = progress * 2 * 3.14159; // 0 to 360 degrees
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularSolidProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.rounded != rounded;
  }
}

class _CircularGradientProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Gradient gradient;
  final bool rounded; // New parameter

  _CircularGradientProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.gradient,
    required this.rounded, // New parameter
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    // Create a rect for the gradient
    final rect = Rect.fromCircle(center: center, radius: radius);
    // Create a shader from the gradient
    final shader = gradient.createShader(rect);
    final paint = Paint()
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = rounded ? StrokeCap.round : StrokeCap.butt; // Apply rounded option

    final startAngle = -90 * (3.14159 / 180); // Start from top
    final sweepAngle = progress * 2 * 3.14159; // 0 to 360 degrees
    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularGradientProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.gradient != gradient ||
        oldDelegate.rounded != rounded;
  }
}

// Segmented Circular Progress Painters
class _CircularSegmentedBackgroundPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final int segmentCount;
  final bool rounded; // New parameter

  _CircularSegmentedBackgroundPainter({
    required this.strokeWidth,
    required this.color,
    required this.segmentCount,
    required this.rounded, // New parameter
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = rounded ? StrokeCap.round : StrokeCap.butt; // Apply rounded option

    final segmentAngle = (2 * 3.14159) / segmentCount;
    for (int i = 0; i < segmentCount; i++) {
      final startAngle = i * segmentAngle - 3.14159 / 2;
      final sweepAngle = segmentAngle * 0.8; // 80% of segment, 20% gap
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CircularSegmentedBackgroundPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.color != color ||
        oldDelegate.segmentCount != segmentCount ||
        oldDelegate.rounded != rounded;
  }
}

class _CircularSegmentedSolidProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color color;
  final int segmentCount;
  final bool rounded; // New parameter

  _CircularSegmentedSolidProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.color,
    required this.segmentCount,
    required this.rounded, // New parameter
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = rounded ? StrokeCap.round : StrokeCap.butt; // Apply rounded option

    final segmentAngle = (2 * 3.14159) / segmentCount;
    final filledSegments = (progress * segmentCount).floor();
    final partialSegmentProgress = (progress * segmentCount) - filledSegments;

    // Draw filled segments
    for (int i = 0; i < filledSegments; i++) {
      final startAngle = i * segmentAngle - 3.14159 / 2;
      final sweepAngle = segmentAngle * 0.8; // 80% of segment, 20% gap
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }

    // Draw partial segment if needed
    if (partialSegmentProgress > 0 && filledSegments < segmentCount) {
      final startAngle = filledSegments * segmentAngle - 3.14159 / 2;
      final sweepAngle = segmentAngle * 0.8 * partialSegmentProgress;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CircularSegmentedSolidProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.segmentCount != segmentCount ||
        oldDelegate.rounded != rounded;
  }
}

class _CircularSegmentedGradientProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Gradient gradient;
  final int segmentCount;
  final bool rounded; // New parameter

  _CircularSegmentedGradientProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.gradient,
    required this.segmentCount,
    required this.rounded, // New parameter
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    // Create a rect for the gradient
    final rect = Rect.fromCircle(center: center, radius: radius);
    // Create a shader from the gradient
    final shader = gradient.createShader(rect);
    final paint = Paint()
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = rounded ? StrokeCap.round : StrokeCap.butt; // Apply rounded option

    final segmentAngle = (2 * 3.14159) / segmentCount;
    final filledSegments = (progress * segmentCount).floor();
    final partialSegmentProgress = (progress * segmentCount) - filledSegments;

    // Draw filled segments
    for (int i = 0; i < filledSegments; i++) {
      final startAngle = i * segmentAngle - 3.14159 / 2;
      final sweepAngle = segmentAngle * 0.8; // 80% of segment, 20% gap
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }

    // Draw partial segment if needed
    if (partialSegmentProgress > 0 && filledSegments < segmentCount) {
      final startAngle = filledSegments * segmentAngle - 3.14159 / 2;
      final sweepAngle = segmentAngle * 0.8 * partialSegmentProgress;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CircularSegmentedGradientProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.gradient != gradient ||
        oldDelegate.segmentCount != segmentCount ||
        oldDelegate.rounded != rounded;
  }
}

// Dashed Circular Progress Painters
class _CircularDashedBackgroundPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double dashWidth;
  final double dashGap;
  final bool rounded; // New parameter

  _CircularDashedBackgroundPainter({
    required this.strokeWidth,
    required this.color,
    required this.dashWidth,
    required this.dashGap,
    required this.rounded, // New parameter
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = rounded ? StrokeCap.round : StrokeCap.butt; // Apply rounded option

    final circumference = 2 * 3.14159 * radius;
    final dashCount = (circumference / (dashWidth + dashGap)).floor();

    for (int i = 0; i < dashCount; i++) {
      final startAngle = (i * (dashWidth + dashGap) / circumference) * 2 * 3.14159 - 3.14159 / 2;
      final sweepAngle = (dashWidth / circumference) * 2 * 3.14159;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CircularDashedBackgroundPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.color != color ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashGap != dashGap ||
        oldDelegate.rounded != rounded;
  }
}

class _CircularDashedSolidProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color color;
  final double dashWidth;
  final double dashGap;
  final bool rounded; // New parameter

  _CircularDashedSolidProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.color,
    required this.dashWidth,
    required this.dashGap,
    required this.rounded, // New parameter
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = rounded ? StrokeCap.round : StrokeCap.butt; // Apply rounded option

    final circumference = 2 * 3.14159 * radius;
    final dashCount = (circumference / (dashWidth + dashGap)).floor();
    final filledDashCount = (progress * dashCount).floor();
    final partialDashProgress = (progress * dashCount) - filledDashCount;

    // Draw filled dashes
    for (int i = 0; i < filledDashCount; i++) {
      final startAngle = (i * (dashWidth + dashGap) / circumference) * 2 * 3.14159 - 3.14159 / 2;
      final sweepAngle = (dashWidth / circumference) * 2 * 3.14159;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }

    // Draw partial dash if needed
    if (partialDashProgress > 0 && filledDashCount < dashCount) {
      final startAngle = (filledDashCount * (dashWidth + dashGap) / circumference) * 2 * 3.14159 - 3.14159 / 2;
      final sweepAngle = (dashWidth * partialDashProgress / circumference) * 2 * 3.14159;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CircularDashedSolidProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashGap != dashGap ||
        oldDelegate.rounded != rounded;
  }
}

class _CircularDashedGradientProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Gradient gradient;
  final double dashWidth;
  final double dashGap;
  final bool rounded; // New parameter

  _CircularDashedGradientProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.gradient,
    required this.dashWidth,
    required this.dashGap,
    required this.rounded, // New parameter
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    // Create a rect for the gradient
    final rect = Rect.fromCircle(center: center, radius: radius);
    // Create a shader from the gradient
    final shader = gradient.createShader(rect);
    final paint = Paint()
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = rounded ? StrokeCap.round : StrokeCap.butt; // Apply rounded option

    final circumference = 2 * 3.14159 * radius;
    final dashCount = (circumference / (dashWidth + dashGap)).floor();
    final filledDashCount = (progress * dashCount).floor();
    final partialDashProgress = (progress * dashCount) - filledDashCount;

    // Draw filled dashes
    for (int i = 0; i < filledDashCount; i++) {
      final startAngle = (i * (dashWidth + dashGap) / circumference) * 2 * 3.14159 - 3.14159 / 2;
      final sweepAngle = (dashWidth / circumference) * 2 * 3.14159;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }

    // Draw partial dash if needed
    if (partialDashProgress > 0 && filledDashCount < dashCount) {
      final startAngle = (filledDashCount * (dashWidth + dashGap) / circumference) * 2 * 3.14159 - 3.14159 / 2;
      final sweepAngle = (dashWidth * partialDashProgress / circumference) * 2 * 3.14159;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CircularDashedGradientProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.gradient != gradient ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashGap != dashGap ||
        oldDelegate.rounded != rounded;
  }
}