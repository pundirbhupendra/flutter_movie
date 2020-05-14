import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/src/constants/string_constant.dart';
import 'package:flutter_movie/src/movieList/bloc/bloc.dart';
import 'package:flutter_movie/src/routes/router.gr.dart';

import 'model/movie_items.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  MovieListBloc _movieListBloc;

  @override
  void initState() {
    super.initState();
    _movieListBloc = BlocProvider.of<MovieListBloc>(context)
      ..add(LoadMovieList());
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            brightness: Brightness.light,
            backgroundColor: Colors.white10,
            elevation: 0.0,
            title: Text(StringConstan.movie_list,
                style: Theme.of(context).textTheme.headline6)),
        body: Center(
          child: BlocBuilder<MovieListBloc, MovieListState>(
              bloc: _movieListBloc,
              builder: (context, state) {
                if (state is MovieListLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is MovieListLoaded) {
                  return ListView.builder(
                      itemCount: state.movieList.results.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Material(
                                child: InkWell(
                                    onTap: () {
                                      navigateToMovieDetail(
                                        context,
                                        state.movieList.results[index],
                                      );
                                    },
                                    child: ListTile(
                                      leading: Hero(
                                        tag: state
                                            .movieList.results[index].titles,
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: NetworkImage(
                                              'https://image.tmdb.org/t/p/w185${state.movieList.results[index].poster_path}'),
                                        ),
                                      ),
                                      title: Text(
                                        state.movieList.results[index]
                                            .original_title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      subtitle: Text(state.movieList
                                          .results[index].release_date),
                                      trailing: Text(state.movieList
                                          .results[index].original_language),
                                    ))));
                      });
                }
                if (state is MovieListError) {
                  return Center(
                      child: Text(
                          state.message.substring(state.message.indexOf('s'))));
                }
                return Center(child: CircularProgressIndicator());
              }),
        ));
  }

  void navigateToMovieDetail(BuildContext context, Result result) {
    Router.navigator.pushNamed(
      Router.movieDetail,
      arguments: MovieDetailArguments(
          movieId: result.id,
          movieTitle: result.title,
          posterUrl: result.backdrop_paths,
          description: result.overview,
          releaseDate: result.release_date,
          voteAverag: result.vote_average),
    );
  }
}
