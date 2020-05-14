
import 'package:flutter_movie/src/movieDetails/model/movie_details.dart';
import 'package:flutter_movie/src/movieList/model/movie_items.dart';
import 'package:flutter_movie/src/network/repository/movie_api_client.dart';
import 'package:meta/meta.dart';
class MovieApiRepository {
  final MovieApiClient movieApiClient;

 MovieApiRepository ({@required this.movieApiClient})
: assert(movieApiClient != null);

      Future<ItemList> fetchAllMovieLists(){
        return movieApiClient.fechMovieList();
      }
       Future<MovieDetailResponse>fetchMovieDetails(int movieId){
        return movieApiClient.fechMovieDetails(movieId);
      }
}