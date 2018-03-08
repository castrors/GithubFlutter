import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:github_app_flutter/routes.dart';
import 'repository.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RepositoryWidget extends StatelessWidget {
  RepositoryWidget(this.repository);

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        title: new Text(repository.name),
        subtitle: new Column(children: <Widget>[
          new Text(repository.description),
          new Row(
            children: <Widget>[
              new Image.asset(
                'images/ic_fork.png',
                fit: BoxFit.scaleDown,
                width: 24.0,
                height: 24.0,
              ),
              new Text(repository.forksCount.toString(),
                  style: new TextStyle(color: Colors.yellow[700])),
              new Container(
                padding: new EdgeInsets.only(left: 16.0),
              ),
              new Image.asset(
                'images/ic_star.png',
                fit: BoxFit.scaleDown,
                width: 24.0,
                height: 24.0,
              ),
              new Text(repository.stargazersCount.toString(),
                  style: new TextStyle(color: Colors.yellow[700])),
            ],
          ),
        ]),
        trailing: new Column(children: <Widget>[
          new CircleAvatar(
              backgroundColor: Colors.white,
              child: new CachedNetworkImage(
                imageUrl: repository.ownerAvatar,
                placeholder: new CircularProgressIndicator(),
                errorWidget: new Image.asset(
                  'images/img_placeholder_40dp.png',
                  fit: BoxFit.scaleDown,
                  width: 64.0,
                  height: 64.0,
                ),
              )),
          new Text(repository.ownerLogin)
        ]),
        isThreeLine: true,
        onTap: () =>
            _navigateTo(context, repository.ownerLogin, repository.name));
  }

  _navigateTo(context, String creator, String repository) {
    Routes.navigateTo(context, '/pullrequest/$creator/$repository',
        transition: TransitionType.fadeIn);
  }
}
