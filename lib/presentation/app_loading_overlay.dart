import 'package:flutter/material.dart';

class AppLoadingOverlay extends StatefulWidget {
  final bool isLoading;
  final Widget progressIndicator;
  final double progressIndicatorMinHeight;
  final Widget child;

  const AppLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.progressIndicator = const CircularProgressIndicator(),
    this.progressIndicatorMinHeight = 50,
  });
  @override
  State<AppLoadingOverlay> createState() => _AppLoadingOverlayState();
}

class _AppLoadingOverlayState extends State<AppLoadingOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool? _overlayVisible;

  _AppLoadingOverlayState();

  @override
  void initState() {
    super.initState();
    _overlayVisible = false;
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((status) {
      // ignore: unnecessary_statements
      status == AnimationStatus.forward ? setState(() => _overlayVisible = true) : null;
      // ignore: unnecessary_statements
      status == AnimationStatus.dismissed ? setState(() => _overlayVisible = false) : null;
    });
    if (widget.isLoading) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(AppLoadingOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isLoading && widget.isLoading) {
      _controller.forward();
    }

    if (oldWidget.isLoading && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    widgets.add(widget.child);
    if (_overlayVisible == true) {
      final modal = FadeTransition(
        opacity: _animation,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            SizedOverflowBox(
              size: Size.fromHeight(widget.progressIndicatorMinHeight),
              child: widget.progressIndicator,
            ),
          ],
        ),
      );

      widgets.add(modal);
    }
    if (widget.isLoading) {
      widgets.add(
        Positioned.fill(
          child: AbsorbPointer(
            child: Container(),
          ),
        ),
      );
    }
    return Stack(alignment: AlignmentDirectional.center, children: widgets);
  }
}
