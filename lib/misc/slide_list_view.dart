import 'dart:math';
import 'package:flutter/material.dart';

class SlideListView extends StatefulWidget {
  final Widget? view1;
  final Widget? view2;
  final String? defaultView;
  final Duration duration;
  final bool enabledSwipe;
  final Color floatingActionButtonColor;
  final bool showFloatingActionButton;
  final AnimatedIconData floatingActionButtonIcon;

  const SlideListView({
    Key? key,
    this.view1,
    this.view2,
    this.defaultView = "slides",
    this.floatingActionButtonColor = Colors.blue,
    this.showFloatingActionButton = true,
    this.enabledSwipe = false,
    this.floatingActionButtonIcon = AnimatedIcons.view_list,
    this.duration = const Duration(milliseconds: 400),
  }) : super(key: key);

  @override
  _SlideListViewState createState() => _SlideListViewState();
}

class _SlideListViewState extends State<SlideListView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late PageController _mainPageController;
  double currentPageValue = 0.0;
  double _viewportFraction = 0.95;
  String _currentView = "slides";

  @override
  void initState() {
    super.initState();
    _currentView = widget.defaultView ?? "slides";
    _mainPageController = PageController(
      initialPage: _currentView == "slides" ? 0 : 1,
      viewportFraction: 1.0,
    );
    _mainPageController.addListener(() {
      if (mounted) {
        setState(() {
          currentPageValue = _mainPageController.page ?? 0.0;
        });
      }
    });
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: _currentView == "slides" ? 0.0 : 1.0,
    );
  }

  @override
  void dispose() {
    _mainPageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            physics: widget.enabledSwipe
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            controller: _mainPageController,
            onPageChanged: (int newPage) {
              setState(() {
                _currentView = newPage == 0 ? "slides" : "list";
              });
            },
            itemCount: 2,
            itemBuilder: (ctx, index) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0005)
                  ..rotateY((currentPageValue - index) * sqrt(2)),
                origin: currentPageValue <= index
                    ? const Offset(0, 0)
                    : Offset(
                        MediaQuery.of(ctx).size.width * _viewportFraction, 0),
                child: index == 0 ? widget.view1 : widget.view2,
              );
            },
          ),
          if (widget.showFloatingActionButton)
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: FloatingActionButton(
                backgroundColor: widget.floatingActionButtonColor,
                child: AnimatedIcon(
                  icon: widget.floatingActionButtonIcon,
                  progress: _animationController,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (_currentView == "slides") {
                    _animationController.forward();
                    _mainPageController.animateToPage(
                      1,
                      duration: widget.duration,
                      curve: Curves.easeInOut,
                    );
                  } else {
                    _animationController.reverse();
                    _mainPageController.animateToPage(
                      0,
                      duration: widget.duration,
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}
