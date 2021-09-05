import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class MovieDetailEvent extends Equatable{
 const MovieDetailEvent();
}
class FetchMovieDetail extends  MovieDetailEvent {
  final int id;

  const FetchMovieDetail({required this.id}) : assert(id != null);

  @override
  List<Object> get props => [id];
}