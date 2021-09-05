import 'package:auto_route/auto_route.dart';
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
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
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
      child: MaterialApp.router(
        title: StringConstan.app_name,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routerDelegate: AutoRouterDelegate(_appRouter),

        // or
        // routerDelegate:_appDelegate.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),

      // MaterialApp(
      //   title: StringConstan.app_name,
      //   debugShowCheckedModeBanner: false,
      //   theme: ThemeData(
      //     visualDensity: VisualDensity.adaptivePlatformDensity,
      //   ),
      //   // initialRoute: Router.movieList,
      //   // onGenerateRoute: Router.onGenerateRoute,
      //   // navigatorKey: Router.navigatorKey,
      // ),
    );
  }
}
