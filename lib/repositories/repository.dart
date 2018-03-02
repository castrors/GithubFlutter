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
    name = getValue(jsonMap['name'], ""),
        description = getValue(jsonMap['description'], ""),
        forksCount = getValue(jsonMap['forks_count'], 0),
        stargazersCount = getValue(jsonMap['stargazers_count'], 0),
        ownerAvatar = getValue(jsonMap['owner']['avatar_url'], ""),
        ownerLogin = getValue(jsonMap['owner']['login'], "");
    
      String toString() => 'Repository: name: $name, description: $description, forksCount: $forksCount, stargazersCount: $stargazersCount, ownerAvatar: $ownerAvatar, ownerLogin: $ownerLogin';

      static getValue(key, defaultValue) {
        return key == null ? defaultValue : key;
      }
}

Future<List<Repository>> getRepositories(page) async {

  var url = 'https://api.github.com/search/repositories?q=language:Java&sort=stars&page=$page';

   var response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json"});

    
return JSON.decode(response.body)["items"]
    .map((jsonRepository) => new Repository.fromJson(jsonRepository)).toList();
}

main() {
  getRepositories(1);
}
