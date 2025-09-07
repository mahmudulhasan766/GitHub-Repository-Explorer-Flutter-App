import 'package:flutter/material.dart';

enum SnackBarPosition { top, bottom }
enum SnackBarAnimation { slide, fade, scale }

class CustomSnackBar {
  // Static reference to the current snackbar
  static OverlayEntry? _currentEntry;

  // Show method that returns a function to close the snackbar
  static VoidCallback show({
    required BuildContext context,
    Widget? content,
    SnackBarPosition position = SnackBarPosition.bottom,
    SnackBarAnimation animation = SnackBarAnimation.slide,
    Duration duration = const Duration(seconds: 3),
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    bool dismissible = true,
    bool safeArea = true,
    bool swipeToDismiss = true,
    bool dismissPrevious = true, // New parameter to control dismissing previous snackbar
    VoidCallback? onDismiss,
    Widget? customBuilder,
    Curve animationCurve = Curves.easeOut,
    Duration animationDuration = const Duration(milliseconds: 300),
  }) {
    // Close any existing snackbar if dismissPrevious is true
    if (dismissPrevious) {
      _currentEntry?.remove();
      _currentEntry = null;
    }

    final overlayState = Overlay.of(context);

    _currentEntry = OverlayEntry(
      builder: (context) => _CustomSnackBarWidget(
        content: content??SizedBox(),
        position: position,
        animation: animation,
        duration: duration,
        padding: padding,
        margin: margin,
        dismissible: dismissible,
        safeArea: safeArea,
        swipeToDismiss: swipeToDismiss,
        onDismiss: () {
          _currentEntry?.remove();
          _currentEntry = null;
          onDismiss?.call();
        },
        customBuilder: customBuilder,
        animationCurve: animationCurve,
        animationDuration: animationDuration,
      ),
    );

    overlayState.insert(_currentEntry!);

    // Return a function that can be used to close this snackbar
    return () {
      _currentEntry?.remove();
      _currentEntry = null;
      onDismiss?.call();
    };
  }

  // Static method to close the current snackbar
  static void close() {
    _currentEntry?.remove();
    _currentEntry = null;
  }
}

class _CustomSnackBarWidget extends StatefulWidget {
  final Widget content;
  final SnackBarPosition position;
  final SnackBarAnimation animation;
  final Duration duration;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool dismissible;
  final bool safeArea;
  final bool swipeToDismiss;
  final VoidCallback onDismiss;
  final Widget? customBuilder;
  final Curve animationCurve;
  final Duration animationDuration;

  const _CustomSnackBarWidget({
    required this.content,
    required this.position,
    required this.animation,
    required this.duration,
    required this.padding,
    required this.margin,
    required this.dismissible,
    required this.safeArea,
    required this.swipeToDismiss,
    required this.onDismiss,
    this.customBuilder,
    required this.animationCurve,
    required this.animationDuration,
  });

  @override
  _CustomSnackBarWidgetState createState() => _CustomSnackBarWidgetState();
}

class _CustomSnackBarWidgetState extends State<_CustomSnackBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  double _dragStartY = 0;
  double _dragStartX = 0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    // Setup animations based on selected type
    switch (widget.animation) {
      case SnackBarAnimation.slide:
        _slideAnimation = Tween<Offset>(
          begin: widget.position == SnackBarPosition.top
              ? const Offset(0.0, -1.0)
              : const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: widget.animationCurve,
          reverseCurve: widget.animationCurve.flipped,
        ));
        break;
      case SnackBarAnimation.fade:
        _fadeAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: widget.animationCurve,
          reverseCurve: widget.animationCurve.flipped,
        ));
        break;
      case SnackBarAnimation.scale:
        _scaleAnimation = Tween<double>(
          begin: 0.8,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: widget.animationCurve,
          reverseCurve: widget.animationCurve.flipped,
        ));
        break;
    }

    _animationController.forward();

    if (widget.duration != Duration.zero) {
      Future.delayed(widget.duration, () {
        if (mounted) {
          _dismiss();
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _dismiss() {
    _animationController.reverse().then((_) {
      if (mounted) {
        widget.onDismiss();
      }
    });
  }

  void _handleDragStart(DragStartDetails details) {
    if (!widget.swipeToDismiss) return;
    _isDragging = true;
    _dragStartY = details.localPosition.dy;
    _dragStartX = details.localPosition.dx;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!widget.swipeToDismiss || !_isDragging) return;

    final dy = details.localPosition.dy - _dragStartY;
    final dx = details.localPosition.dx - _dragStartX;

    // Check if swipe distance exceeds threshold
    if (dy.abs() > 50 || dx.abs() > 50) {
      _isDragging = false;
      _dismiss();
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    _isDragging = false;
  }

  @override
  Widget build(BuildContext context) {
    final isTop = widget.position == SnackBarPosition.top;
    final textDirection = Directionality.of(context);
    final resolvedMargin = widget.margin.resolve(textDirection);
    final mediaQueryPadding = widget.safeArea ? MediaQuery.of(context).padding : EdgeInsets.zero;

    // Use custom builder if provided, otherwise use default content
    Widget snackbarContent = widget.customBuilder ?? widget.content;

    // Wrap with gesture detector for swipe-to-dismiss
    if (widget.swipeToDismiss) {
      snackbarContent = GestureDetector(
        onPanStart: _handleDragStart,
        onPanUpdate: _handleDragUpdate,
        onPanEnd: _handleDragEnd,
        child: snackbarContent,
      );
    }

    // Wrap with gesture detector for tap-to-dismiss if dismissible
    if (widget.dismissible && widget.customBuilder == null) {
      snackbarContent = GestureDetector(
        onTap: _dismiss,
        child: snackbarContent,
      );
    }

    // Apply animation based on selected type
    Widget animatedContent;
    switch (widget.animation) {
      case SnackBarAnimation.slide:
        animatedContent = SlideTransition(
          position: _slideAnimation,
          child: snackbarContent,
        );
        break;
      case SnackBarAnimation.fade:
        animatedContent = FadeTransition(
          opacity: _fadeAnimation,
          child: snackbarContent,
        );
        break;
      case SnackBarAnimation.scale:
        animatedContent = ScaleTransition(
          scale: _scaleAnimation,
          child: snackbarContent,
        );
        break;
    }

    return Positioned(
      top: isTop
          ? resolvedMargin.top + mediaQueryPadding.top
          : null,
      bottom: !isTop
          ? resolvedMargin.bottom + mediaQueryPadding.bottom
          : null,
      left: resolvedMargin.left,
      right: resolvedMargin.right,
      child: animatedContent,
    );
  }
}