import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/src/movieDetails/bloc/movie_details.state.dart';
import 'package:flutter_movie/src/movieDetails/bloc/movie_details_event.dart';
import 'package:flutter_movie/src/movieDetails/model/movie_details.dart';
import 'package:flutter_movie/src/network/repository/movie_api_repository.dart';
import 'package:meta/meta.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent,MovieDetailState>{
  final MovieApiRepository movieRepository;
  MovieDetailBloc({@required this.movieRepository}): assert(movieRepository!= null);
  @override
  MovieDetailState get initialState => MovieInitialState();

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) async*{
    if(event is FetchMovieDetail){
      yield MovieDetailLoading();
      try{
      MovieDetailResponse  movieDetailResponce =await movieRepository.fetchMovieDetails(event.id);
      yield MovieDetailLoaded(movieDetailResponse: movieDetailResponce);
      }catch(e){
       yield MovieDetailError(message: e.toString());
      }
    }
  }


}
