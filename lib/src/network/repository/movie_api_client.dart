import 'dart:convert';
import 'package:flutter_movie/src/constants/url_constant.dart';
import 'package:flutter_movie/src/movieDetails/model/movie_details.dart';
import 'package:flutter_movie/src/movieList/model/Movie_list.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class MovieApiClient {
  final http.Client httpClient;
 MovieApiClient({@required this.httpClient}) : assert(httpClient != null);
 
  Future<ItemList> fechMovieList() async {
    try {
      final response = await http.get(UrlConstant.BASE_URL + '/popular?api_key=${UrlConstant.apiKey}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonString = jsonDecode(response.body);
        return ItemList.fromJson(jsonString);
      } else {
        throw Exception('some error occurred');
      }
    } catch (ex) {
      throw Exception('some error occurred');
    }
  }

  //fetch movie detais..
  Future<MovieDetailResponse> fechMovieDetails(int movieId) async {
    var id = 419704;
    try {
      final response = await http.get(
          UrlConstant.BASE_URL + '/$id/videos?api_key=${UrlConstant.apiKey}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonString = jsonDecode(response.body);
        return MovieDetailResponse.fromJson(jsonString);
      } else {
        throw Exception('some error occurred');
      }
    } catch (ex) {  
      throw Exception('some error occurred');
    }
  }
}
