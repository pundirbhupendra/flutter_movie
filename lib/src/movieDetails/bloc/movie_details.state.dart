import 'package:flutter_movie/src/movieDetails/model/movie_details.dart';
import 'package:equatable/equatable.dart';

enum MovieDetailStatus { initial, loading, success, failure }

extension MovieDetailst on MovieDetailStatus {
  bool get isInitial => this == MovieDetailStatus.initial;
  bool get isLoading => this == MovieDetailStatus.loading;
  bool get isSuccess => this == MovieDetailStatus.success;
  bool get isFailure => this == MovieDetailStatus.failure;
}

class MovieDetailState extends Equatable {
 const MovieDetailState._({
    this.status = MovieDetailStatus.initial,
    this.message,
    this.movieDetailResponse,
  });

const  MovieDetailState.initial() : this._();

  final MovieDetailResponse? movieDetailResponse;
  final message;
 final MovieDetailStatus status;

  MovieDetailState copyWith(
      {MovieDetailStatus? status,
      MovieDetailResponse? movieDetailResponse,
      String? message}) {
    return MovieDetailState._(
        status: status ?? this.status,
        movieDetailResponse: movieDetailResponse ?? this.movieDetailResponse);
  }

  @override
  List<Object?> get props => [message, movieDetailResponse];
}
