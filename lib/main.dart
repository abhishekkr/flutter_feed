import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

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
  var topStories;

  Future<String> _getJsonBody(String url) async  {
    var client = new http.Client();
    var response = await client.get(
          Uri.encodeFull(url),
          headers: {
            "Accept": "application/json",
            "Connection": "keep-alive",
            "X-Source-App": "Fly-On-Feeds",
          }
        );
    await client.close();
    if (response.statusCode == 200) {
      print(convert.jsonDecode(response.body).length);
      return response.body;
    }
    print("request failed with status: ${response.statusCode}.");
    return '{}';
  }

  _fetchStory(String storyId) async {
     print(storyId);
     final storyBaseUrl = 'https://hacker-news.firebaseio.com/v0/item/';
     final storyUrl = storyBaseUrl + storyId + '.json';

     String storyJsonBody = await _getJsonBody(storyUrl);
     print(storyJsonBody.toString());
     return convert.jsonDecode(storyJsonBody.toString());
  }

  _fetchFeeds() async {
    setState(() { _isLoading = true; });

    final topStoriesUrl = 'https://hacker-news.firebaseio.com/v0/topstories.json';

    var topStoriesIdJson = await _getJsonBody(topStoriesUrl);
    print(convert.jsonDecode(topStoriesIdJson).length);
    final List<dynamic> topStoriesId = convert.jsonDecode(topStoriesIdJson.toString());
    print(topStoriesId.length);

    final List<dynamic> topStoriesList = [];
    for (var i = 0; i < topStoriesId.length; i = i+1){
      var id = topStoriesId[i].toString();
      print(id);
      var storyForId = await _fetchStory(id);
      topStoriesList.add(storyForId);
    }

    setState(() {
      _isLoading = false;
      this.topStories = topStoriesList;
    });
  }

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
                _fetchFeeds();
              },
          )
        ],
      ),
      body: new Center(
          child: _isLoading ? new CircularProgressIndicator() :
            new ListView.builder(
              itemCount: this.topStories != null ? this.topStories.length : 0,
              itemBuilder: (context, idx) {
                return new Text(this.topStories[idx].toString());
              },
            ),
      )
    );
  }
}
