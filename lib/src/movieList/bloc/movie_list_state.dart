import 'package:equatable/equatable.dart';
import 'package:flutter_movie/src/movieList/model/movie_items.dart';
import 'package:meta/meta.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();
}

class MovieListLoading extends MovieListState {
  @override
  List<Object> get props => [];
}

class MovieListLoaded extends MovieListState {
  final ItemList movieList;
  MovieListLoaded({required this.movieList});

  @override
  List<Object> get props => [movieList];
}

class MovieListError extends MovieListState {
  final message;
  MovieListError({required this.message});
  @override
  List<Object> get props => [message];
}
