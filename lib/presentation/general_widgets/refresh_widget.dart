import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class RefreshWidget extends StatefulWidget {
  const RefreshWidget(
      {super.key, required this.onRefresh, required this.child});
  final Future<void> Function() onRefresh;
  final Widget child;
  @override
  State<RefreshWidget> createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      color: Theme.of(context).primaryColor,
      key: _refreshIndicatorKey,
      showChildOpacityTransition: true, // key if you want to add
      onRefresh: widget.onRefresh,
      child: widget.child,
    );
  }
}
