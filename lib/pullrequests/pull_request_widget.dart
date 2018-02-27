import 'package:flutter/material.dart';
import 'pull_request.dart';
import 'package:url_launcher/url_launcher.dart';

class PullRequestWidget extends StatelessWidget {
  PullRequestWidget(this.pullRequest);
  final PullRequest pullRequest;

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        title: new Text(pullRequest.title),
        subtitle: new Text(pullRequest.body),
        leading: new Column(children: <Widget>[
          new CircleAvatar(
            backgroundColor: Colors.white,
            child: new Image.network(pullRequest.userAvatar,
                fit: BoxFit.cover, width: 64.0, height: 64.0),
          ),
          new Text(pullRequest.userLogin)
        ]),
        isThreeLine: false,
        onTap: () =>_launchURL(pullRequest.url));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
