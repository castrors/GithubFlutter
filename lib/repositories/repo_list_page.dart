import 'package:flutter/material.dart';
import 'package:async_loader/async_loader.dart';
import 'repository.dart';
import 'repo_widget.dart';

class RepoListPage extends StatelessWidget {
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();

  @override
  Widget build(BuildContext context) {
    AsyncLoader _asyncLoader = new AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await getRepositories(),
      renderLoad: () => new CircularProgressIndicator(),
      renderError: ([error]) => new Text('Error loading repositories'),
      renderSuccess: ({data}) => _renderData(data),
    );

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Github Repositories"),
        ),
        body: new Center(
          child: _asyncLoader,
        ));
  }

  Widget _renderData(data) => new ListView(
        children: data.map((repo) => new RepositoryWidget(repo)).toList(),
      );
}
