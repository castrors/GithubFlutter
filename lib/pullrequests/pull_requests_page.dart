import 'package:flutter/material.dart';
import 'package:async_loader/async_loader.dart';
import 'pull_request.dart';
import 'pull_request_widget.dart';

class PullRequestsPage extends StatelessWidget {
  PullRequestsPage({this.creator, this.repository});

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();
  
  final String creator;
  final String repository;
  
  @override
  Widget build(BuildContext context) {
    AsyncLoader _asyncLoader = new AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await getPullRequests(creator, repository),
      renderLoad: () => new CircularProgressIndicator(),
      renderError: ([error]) => new Text('Error loading pullRequests'),
      renderSuccess: ({data}) => _renderData(data),
    );

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('$creator/$repository'),
        ),
        body: new Center(
          child: _asyncLoader,
        ));
  }

  Widget _renderData(data) => new ListView(
        children: data.map((pullRequest) => new PullRequestWidget(pullRequest)).toList(),
      );
}
