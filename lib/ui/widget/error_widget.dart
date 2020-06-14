import 'package:flutter/widgets.dart';

class ErrorWidget extends StatelessWidget {
  final dynamic error;
  ErrorWidget({Key key,@required this.error}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('$error'),
    );
  }
}