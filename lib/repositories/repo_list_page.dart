import 'package:flutter/material.dart';
import 'repository.dart';
import 'repo_widget.dart';

class RepoListPage extends StatefulWidget {
  @override
  RepoListPageState createState() => new RepoListPageState();
}

class RepoListPageState extends State<RepoListPage> {
  bool _loading = true;
  List<Repository> _repositories;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    var repositories = await getRepositories();
    setState(() {
      _repositories = repositories;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Github Repositories"),
        ),
        body: new Center(
            child: _loading
                ? new CircularProgressIndicator()
                : new ListView(
                    children: _repositories
                        .map((repo) => new RepositoryWidget(repo))
                        .toList(),
                  )));
  }
}
