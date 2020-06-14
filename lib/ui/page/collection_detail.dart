import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CollectionDetailPage extends StatefulWidget {
  @override
  _CollectionDetailPageState createState() => _CollectionDetailPageState();
}

class _CollectionDetailPageState extends State<CollectionDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Collection Detail'),),
    );
  }
}