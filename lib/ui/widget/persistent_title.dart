import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PersistentTitle extends SliverPersistentHeaderDelegate {
  final Widget widget;

  PersistentTitle(this.widget);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Colors.white, child: widget);
  }

  @override
  double get maxExtent => kTextTabBarHeight;

  @override
  double get minExtent => kTextTabBarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
