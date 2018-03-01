import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:github_app_flutter/pullrequests/pull_requests_page.dart';

class Routes {
  static final Router _router = new Router();


  static var planetDetailHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new PullRequestsPage(creator: params["creator"], repository: params["repository"]);
    });

  static void initRoutes() {
    _router.define("/pullrequest/:creator/:repository", handler: planetDetailHandler);
  }

  static void navigateTo(context, String route, {TransitionType transition}) {
    _router.navigateTo(context, route, transition: transition);
  }

}