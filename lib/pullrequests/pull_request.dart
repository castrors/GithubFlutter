import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PullRequest {
  final String title;
  final String body;
  final String url;
  final String userAvatar;
  final String userLogin;

  PullRequest.fromJson(Map jsonMap) :
    title = jsonMap['title'],
    body = jsonMap['body'],
    url = jsonMap['html_url'],
    userAvatar = jsonMap['user']['avatar_url'],
    userLogin = jsonMap['user']['login'];

  String toString() => 'PullRequest: $title';
}

Future<List<PullRequest>> getPullRequests(String creator, String repository) async {

  var url = 'https://api.github.com/repos/$creator/$repository/pulls';

   var response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json"});

    
return JSON.decode(response.body)
    .map((jsonPullRequest) => new PullRequest.fromJson(jsonPullRequest)).toList();
}

main() {
  getPullRequests("elastic", "elasticsearch");
}
