// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../movieDetails/movie_detail.dart' as _i4;
import '../movieList/model/movie_items.dart' as _i5;
import '../movieList/movie_list.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    MovieList.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.MovieList();
        }),
    MovieDetail.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<MovieDetailArgs>(
              orElse: () => const MovieDetailArgs());
          return _i4.MovieDetail(result: args.result!);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(MovieList.name, path: '/'),
        _i1.RouteConfig(MovieDetail.name, path: '/movie-detail')
      ];
}

class MovieList extends _i1.PageRouteInfo {
  const MovieList() : super(name, path: '/');

  static const String name = 'MovieList';
}

class MovieDetail extends _i1.PageRouteInfo<MovieDetailArgs> {
  MovieDetail({_i5.Result? result})
      : super(name,
            path: '/movie-detail', args: MovieDetailArgs(result: result));

  static const String name = 'MovieDetail';
}

class MovieDetailArgs {
  const MovieDetailArgs({this.result});

  final _i5.Result? result;
}
