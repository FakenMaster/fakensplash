import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {},
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('#$index'),
          );
        },
        itemCount: 3,
      ),
    );
  }
}
