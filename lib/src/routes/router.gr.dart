// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:flutter_movie/src/movieList/movie_list.dart';
import 'package:flutter_movie/src/movieDetails/movie_detail.dart';

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
        if (hasInvalidArgs<MovieDetailArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<MovieDetailArguments>(args);
        }
        final typedArgs = args as MovieDetailArguments;
        return MaterialPageRoute(
          builder: (_) => MovieDetail(
              movieId: typedArgs.movieId,
              movieTitle: typedArgs.movieTitle,
              releaseDate: typedArgs.releaseDate,
              voteAverag: typedArgs.voteAverag,
              posterUrl: typedArgs.posterUrl,
              description: typedArgs.description),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//MovieDetail arguments holder class
class MovieDetailArguments {
  final int movieId;
  final String movieTitle;
  final String releaseDate;
  final String voteAverag;
  final String posterUrl;
  final String description;
  MovieDetailArguments(
      {@required this.movieId,
      @required this.movieTitle,
      @required this.releaseDate,
      @required this.voteAverag,
      @required this.posterUrl,
      @required this.description});
}
