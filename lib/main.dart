import 'package:flutter/material.dart';

void main() => runApp(HomeApp());

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fly on Feeds',
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
  var _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feeds'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: () {
                print('reloading...');
                setState(() {
                  _isLoading = _isLoading ? false : true;
                });
              },
          )
        ],
      ),
      body: new Center(
          child: _isLoading ? new CircularProgressIndicator() :
                              new Text('finished reloading'),
      )
    );
  }
}
