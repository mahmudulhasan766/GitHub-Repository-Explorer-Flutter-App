import 'dart:ui' as ui show Gradient;

import 'package:flutter/material.dart';

class FadedText extends StatelessWidget {
  const FadedText(
    String this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.textScaler,
    this.maxLines = 1,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : textSpan = null;

  /// Creates a faded text widget with a [InlineSpan].
  const FadedText.rich(
    InlineSpan this.textSpan, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.textScaler,
    this.maxLines = 1,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : data = null;

  final String? data;

  final InlineSpan? textSpan;
  final TextStyle? style;

  final StrutStyle? strutStyle;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  final TextDirection? textDirection;

  final Locale? locale;

  final TextScaler? textScaler;

  final int maxLines;

  final String? semanticsLabel;
  final TextHeightBehavior? textHeightBehavior;

  final TextWidthBasis? textWidthBasis;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    var effectiveTextStyle = style;

    if (style == null || style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(style);
    }
    if (MediaQuery.boldTextOf(context)) {
      effectiveTextStyle = effectiveTextStyle!
          .merge(const TextStyle(fontWeight: FontWeight.bold));
    }

    return CustomPaint(
      size: Size.infinite,
      painter: _FadedTextPainer(
        textPainter: TextPainter(
          text: TextSpan(
            style: effectiveTextStyle,
            text: data,
            children: textSpan != null ? <InlineSpan>[textSpan!] : null,
            locale: locale,
            semanticsLabel: semanticsLabel,
          ),
          textAlign: textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
          textDirection: textDirection ?? Directionality.of(context),
          textScaler:
              // ignore: use_named_constants
              textScaler == null ? const TextScaler.linear(1) : textScaler!,
          maxLines: maxLines,
          locale: locale,
          strutStyle: strutStyle,
          textWidthBasis: textWidthBasis ?? defaultTextStyle.textWidthBasis,
          ellipsis: ' ',
          textHeightBehavior: textHeightBehavior ??
              defaultTextStyle.textHeightBehavior ??
              DefaultTextHeightBehavior.maybeOf(context),
        ),
      ),
    );
  }
}

class _FadedTextPainer extends CustomPainter {
  final TextPainter textPainter;

  const _FadedTextPainer({required this.textPainter});

  @override
  void paint(Canvas canvas, Size size) {
    const offset = Offset.zero;
    final overflowShader = _overflowShader(size);

    if (overflowShader != null) {
      canvas.saveLayer(offset & size, Paint());
    }

    textPainter.paint(canvas, offset);

    if (overflowShader == null) return;

    final paint = Paint()
      ..blendMode = BlendMode.modulate
      ..shader = overflowShader;

    final textLineHeight = textPainter.preferredLineHeight;

    canvas
      ..drawRect(
          Offset(0, textPainter.size.height - textLineHeight) &
              Size(size.width, textLineHeight),
          paint)
      ..restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  /// This method is used to create a gradient shader to fade the text.
  Shader? _overflowShader(Size size) {
    textPainter.layout(maxWidth: size.width);

    final textSize = textPainter.size;
    final textDidExceedMaxLines = textPainter.didExceedMaxLines;
    final didOverflowHeight =
        size.height < textSize.height || textDidExceedMaxLines;

    if (!didOverflowHeight) return null;

    final fadeSizePainter = TextPainter(
      text: TextSpan(
          style: textPainter.text?.style,
          text: '\u2026\u2026\u2026\u2026\u2026'),
      textDirection: textPainter.textDirection,
      textScaler: textPainter.textScaler,
      locale: textPainter.locale,
    )..layout();

    double fadeEnd;
    double fadeStart;

    switch (textPainter.textDirection) {
      case TextDirection.rtl:
        fadeEnd = 0.0;
        fadeStart = fadeSizePainter.width;
      case TextDirection.ltr || null:
        fadeEnd = size.width;
        fadeStart = fadeEnd - fadeSizePainter.width;
    }

    fadeSizePainter.dispose();

    return ui.Gradient.linear(
      Offset(fadeStart, 0),
      Offset(fadeEnd, 0),
      <Color>[const Color(0xFFFFFFFF), const Color(0x00FFFFFF)],
    );
  }
}
