import 'package:flutter/material.dart';
import 'repositories/repo_list_page.dart';

void main() {
  runApp(new MaterialApp(
    title: "Github Repositories",
    home: new RepoListPage(),
  ));
}