import 'package:flutter/material.dart';
import 'pull_request.dart';
import 'pull_request_widget.dart';

class PullRequestsPage extends StatefulWidget {
  final String creator;
  final String repository;

  PullRequestsPage({this.creator, this.repository});

  @override
  PullRequestsPageState createState() =>
      new PullRequestsPageState(creator, repository);
}

class PullRequestsPageState extends State<PullRequestsPage> {
  bool _loading = true;
  final String creator;
  final String repository;
  List<PullRequest> _pullRequests;

  PullRequestsPageState(this.creator, this.repository);

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    var pullRequests = await getPullRequests(creator, repository);
    setState(() {
      _pullRequests = pullRequests;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('$creator/$repository'),
        ),
        body: new Center(
            child: _loading
                ? new CircularProgressIndicator()
                : new ListView(
                    children: _pullRequests
                        .map(
                            (pullRequest) => new PullRequestWidget(pullRequest))
                        .toList(),
                  )));
  }
}
