import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingWidget extends StatelessWidget {
  final bool center;
  LoadingWidget({this.center = true});
  @override
  Widget build(BuildContext context) {
    return center
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            ),
          );
  }
}
