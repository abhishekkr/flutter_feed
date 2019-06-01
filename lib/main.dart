import 'package:flutter/material.dart';

void main() => runApp(HomeApp());

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feeds',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: FeedApp(),
    );
  }
}

class FeedApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new FeedAppState();
  }
}

class FeedAppState extends State<FeedApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feeds'),
      ),
      body: new Center(
          child: new CircularProgressIndicator(),
      )
    );
  }
}
