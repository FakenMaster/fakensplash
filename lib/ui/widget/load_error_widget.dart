import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadErrorWidget extends StatelessWidget {
  final dynamic error;
  final VoidCallback clickCallback;
  LoadErrorWidget({Key key, @required this.error, this.clickCallback})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: clickCallback,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error,
              color: Colors.red[300],
              size: 50.0,
            ),
            // Text('$error'),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'Oops.',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text('There seems to be a problem with your internet'),
          ],
        ),
      ),
    );
  }
}
