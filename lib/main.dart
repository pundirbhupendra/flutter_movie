import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/simple_bloc_delegate.dart';
import 'package:flutter_movie/src/constants/string_constant.dart';
import 'package:flutter_movie/src/movieDetails/bloc/movie_detail_bloc.dart';
import 'package:flutter_movie/src/movieList/bloc/movie_list_bloc.dart';
import 'package:flutter_movie/src/network/repository/movie_api_repository.dart';
import 'src/network/repository/movie_api_client.dart';
import 'src/routes/router.gr.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _movieApiClient = MovieApiClient();
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieListBloc>(
          create: (context) => MovieListBloc(
              movieApiRepository:
                  MovieApiRepository(movieApiClient: _movieApiClient)),
        ),
        BlocProvider<MovieDetailBloc>(
          create: (context) => MovieDetailBloc(
              movieRepository:
                  MovieApiRepository(movieApiClient: _movieApiClient)),
        ),
      ],
      child: MaterialApp(
        title: StringConstan.app_name,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: Router.movieList,
        onGenerateRoute: Router.onGenerateRoute,
        navigatorKey: Router.navigatorKey,
      ),
    );
  }
}
