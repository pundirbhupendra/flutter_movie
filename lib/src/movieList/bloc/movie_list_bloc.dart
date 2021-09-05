import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/src/movieList/bloc/movie_lisr_event.dart';
import 'package:flutter_movie/src/movieList/bloc/movie_list_state.dart';
import 'package:flutter_movie/src/movieList/model/movie_items.dart';
import 'package:flutter_movie/src/network/repository/movie_api_repository.dart';
import 'package:meta/meta.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MovieApiRepository movieApiRepository;

  MovieListBloc({required this.movieApiRepository})
      : super(MovieListLoading());


  @override
  Stream<MovieListState> mapEventToState(MovieListEvent event) async* {
    if (event is LoadMovieList) {
      yield* _mapFetchMovieListToState(event);
    }
  }

  Stream<MovieListState> _mapFetchMovieListToState(
      MovieListEvent event) async* {
    yield MovieListLoading();

    try {
      final ItemList movieList = await movieApiRepository.fetchAllMovieLists();
      yield MovieListLoaded(movieList: movieList);
    } catch (e) {
      yield MovieListError(message: e.toString());
    }
  }
}
