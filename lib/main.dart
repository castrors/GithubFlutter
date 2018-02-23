import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
    home: new RepoListPage(),
//    routes: <String, WidgetBuilder>{
//      '/detail': (BuildContext context) => new PullRequestsPage(),
//    },
  ));
}

class Api {
  static var BASE_URL = "https://api.github.com";

  static requestRepositories() {
    return Uri
        .encodeFull("$BASE_URL/search/repositories?q=language:Java&sort=stars");
  }

  static requestPullRequests(String creator, String repository) {
    return Uri.encodeFull("$BASE_URL/repos/$creator/$repository/pulls");
  }
}

class RepoListPage extends StatefulWidget {
  @override
  RepoListPageState createState() => new RepoListPageState();
}

class RepoListPageState extends State<RepoListPage> {
  List data;

  Future<String> getData() async {
    var response = await http.get(Api.requestRepositories(),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = JSON.decode(response.body)["items"];
    });

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Github Repositories"),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return createListItem(context, data[index]);
        },
      ),
    );
  }

  Widget createListItem(context, data) => new GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (_) => new PullRequestsPage(
                creator: data["owner"]["login"], repository: data["name"]),
          ),
        );
      },
      child: new Container(
        padding: const EdgeInsets.all(16.0),
        child: new Row(
          children: [
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      data["name"],
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  new Text(
                    data["description"],
                    maxLines: 3,
                    style: new TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                  new Row(
                    children: <Widget>[
                      new Icon(
                        Icons.content_copy,
                        color: Colors.yellow[700],
                      ),
                      new Text('${data["forks_count"]}',
                          style: new TextStyle(color: Colors.yellow[700])),
                      new Icon(
                        Icons.star,
                        color: Colors.yellow[700],
                      ),
                      new Text('${data["stargazers_count"]}',
                          style: new TextStyle(color: Colors.yellow[700])),
                    ],
                  ),
                ],
              ),
            ),
            new Column(
              children: <Widget>[
                new Image.network(data["owner"]["avatar_url"],
                    fit: BoxFit.cover, width: 64.0, height: 64.0),
                new Text(data["owner"]["login"])
              ],
            )
          ],
        ),
      ));
}

class PullRequestsPage extends StatefulWidget {
  const PullRequestsPage({this.creator, this.repository});

  final String creator;
  final String repository;

  @override
  PullRequestPageState createState() =>
      new PullRequestPageState(creator: creator, repository: repository);
}

class PullRequestPageState extends State<PullRequestsPage> {
  PullRequestPageState({this.creator, this.repository});

  final String creator;
  final String repository;

  List data;

  Future<String> getData() async {
    var response = await http.get(Api.requestPullRequests(creator, repository),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = JSON.decode(response.body);
    });

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("$creator/$repository"),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return createListItem(context, data[index]);
        },
      ),
    );
  }

  Widget createListItem(context, data) => new FlatButton(
      onPressed: () { _launchURL(data["html_url"]);},
      child: new Container(
        padding: const EdgeInsets.all(16.0),
        child: new Row(
          children: [
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      data["title"],
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  new Text(
                    data["body"],
                    maxLines: 3,
                    style: new TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                  new Row(
                    children: <Widget>[
                      new CircleAvatar(
                          backgroundImage:
                              new NetworkImage(data["user"]["avatar_url"])),
                      new Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: new Text('${data["user"]["login"]}',
                            style: new TextStyle(color: Colors.blue[400])),
                      )
                    ],
                  ),
                  new Divider()
                ],
              ),
            ),
          ],
        ),
      ));

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
