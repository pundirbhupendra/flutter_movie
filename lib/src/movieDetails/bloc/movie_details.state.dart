
import 'package:flutter_movie/src/movieDetails/model/movie_details.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
}
class MovieInitialState extends MovieDetailState {
  @override
  List<Object> get props => [];
}
class MovieDetailLoading extends MovieDetailState {
  @override
  List<Object> get props => [];
}
class MovieDetailLoaded extends MovieDetailState{
 final MovieDetailResponse  movieDetailResponse;
  MovieDetailLoaded({@required this.movieDetailResponse});

  @override
  List<Object> get props => [movieDetailResponse];
}
class MovieDetailError extends MovieDetailState {
  final message;
 MovieDetailError({@required this.message});
  @override
  List<Object> get props => [message];
}