// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:flutter_movie/src/movieList/movie_list.dart';
import 'package:flutter_movie/src/movieDetails/movie_detail.dart';
import 'package:flutter_movie/src/movieList/model/movie_items.dart';

class Router {
  static const movieList = '/';
  static const movieDetail = '/movie-detail';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.movieList:
        return MaterialPageRoute(
          builder: (_) => MovieList(),
          settings: settings,
        );
      case Router.movieDetail:
        if (hasInvalidArgs<Result>(args, isRequired: true)) {
          return misTypedArgsRoute<Result>(args);
        }
        final typedArgs = args as Result;
        return MaterialPageRoute(
          builder: (_) => MovieDetail(result: typedArgs),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
