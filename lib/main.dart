import 'package:flutter/material.dart';
import 'package:github_app_flutter/routes.dart';
import 'repositories/repo_list_page.dart';

void main() {
  Routes.initRoutes();
  runApp(new MaterialApp(
    title: "Github Repositories",
    home: new RepoListPage(),
  ));
}