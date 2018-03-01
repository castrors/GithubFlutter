import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Repository {
  final String name;
  final String description;
  final int forksCount;
  final int stargazersCount;
  final String ownerAvatar;
  final String ownerLogin;

  Repository.fromJson(Map jsonMap) :
    name = jsonMap['name'],
    description = jsonMap['description'],
    forksCount = jsonMap['forks_count'],
    stargazersCount = jsonMap['stargazers_count'],
    ownerAvatar = jsonMap['owner']['avatar_url'],
    ownerLogin = jsonMap['owner']['login'];

  String toString() => 'Repository: $name';
}

Future<List<Repository>> getRepositories() async {

  var url = 'https://api.github.com/search/repositories?q=language:Java&sort=stars';

   var response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json"});

    
return JSON.decode(response.body)["items"]
    .map((jsonRepository) => new Repository.fromJson(jsonRepository)).toList();
}

main() {
  getRepositories();
}
