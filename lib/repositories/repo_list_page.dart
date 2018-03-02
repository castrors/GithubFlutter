import 'package:flutter/material.dart';
import 'repository.dart';
import 'repo_widget.dart';

class RepoListPage extends StatefulWidget {
  @override
  RepoListPageState createState() => new RepoListPageState();
}

class RepoListPageState extends State<RepoListPage> {
  bool _loading = true;
  int _page = 0;
  List<Repository> _repositories = new List();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    _page++;
    var repositories = await getRepositories(_page);
    setState(() {
      _repositories.addAll(repositories);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Github Repositories"),
      ),
      body: _buildRepoList(),
    );
  }

  Widget _buildRepoList() {
    return new Center(
        child: _loading
            ? new CircularProgressIndicator()
            : new ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _repositories.length + 1,
                itemBuilder: (context, index) {
                  if (index == _repositories.length-1) {
                    _fetchData();
                  }

                  if(index == _repositories.length){
                    return new Center(child: new CircularProgressIndicator());
                  }

                  return new RepositoryWidget(_repositories[index]);
                },
              ));
  }
}
