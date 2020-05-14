import 'dart:convert';
import 'dart:io';
import 'package:flutter_movie/src/constants/url_constant.dart';
import 'package:flutter_movie/src/movieDetails/model/movie_details.dart';
import 'package:flutter_movie/src/movieList/model/movie_items.dart';
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
        final jsonString = jsonDecode(response.body);
        return ItemList.fromJson(jsonString);
      } else {
        throw Exception('some error occurred');
      }
    } on SocketException catch (_)  {  
      throw Exception('some error occurred');
    } catch(e){
      print(e.toString());
    }
  }

  //fetch movie detais..
  Future<MovieDetailResponse> fechMovieDetails(int movieId) async {

  
    try {
      final response = await http.get(
          UrlConstant.BASE_URL + '/$movieId/videos?api_key=${UrlConstant.apiKey}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonString = jsonDecode(response.body);
        return MovieDetailResponse.fromJson(jsonString);
      }
    } on SocketException catch (_)  {  
      throw Exception('some error occurred');
    } catch(e){
      print(e.toString());
    }
  }
}

