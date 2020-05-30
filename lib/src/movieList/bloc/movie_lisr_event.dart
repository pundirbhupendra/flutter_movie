import 'package:equatable/equatable.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();
}

class LoadMovieList extends MovieListEvent {
  @override
  List<Object> get props => [];
}
