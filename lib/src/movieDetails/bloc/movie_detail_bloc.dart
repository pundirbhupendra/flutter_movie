
import 'package:bloc/bloc.dart';
import 'package:flutter_movie/src/movieDetails/model/movie_details.dart';
import 'package:flutter_movie/src/network/repository/movie_api_repository.dart';

import 'bloc.dart';
import 'movie_details_event.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc({required MovieApiRepository movieRepository})
      : _movieRepository = movieRepository,
        super(MovieDetailState.initial()) {
    on<FetchMovieDetail>(_getMovieDetailList);
  }
  final MovieApiRepository _movieRepository;

  void _getMovieDetailList(
      FetchMovieDetail event, Emitter<MovieDetailState> emit) async {
    if (event is FetchMovieDetail) {
      emit(state.copyWith(status: MovieDetailStatus.loading));
      try {
        MovieDetailResponse movieDetailResponce =
            await _movieRepository.fetchMovieDetails(event.id);
        emit(state.copyWith(
            movieDetailResponse: movieDetailResponce,
            status: MovieDetailStatus.success));
      } catch (e) {
        emit(state.copyWith(
            message: e.toString(), status: MovieDetailStatus.failure));
      }
    }
  }
}
