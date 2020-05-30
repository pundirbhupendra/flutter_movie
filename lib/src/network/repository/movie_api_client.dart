import 'dart:convert';
import 'dart:io';
import 'package:flutter_movie/src/constants/url_constant.dart';
import 'package:flutter_movie/src/movieDetails/model/movie_details.dart';
import 'package:flutter_movie/src/movieList/model/movie_items.dart';
import 'package:flutter_movie/src/utils/api_exception.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class MovieApiClient {
  static final MovieApiClient _instance = MovieApiClient._internal();
  MovieApiClient._internal();
  factory MovieApiClient() => _instance;

  Future<ItemList> fechMovieList() async {
    try {
      final response = await http.get(UrlConstant.BASE_URL +
          '/movie/popular?api_key=${UrlConstant.apiKey}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonString = jsonDecode(response.body);
        return ItemList.fromJson(jsonString);
      } else {
        throw Exception('some error occurred');
      }
    } on SocketException catch (_) {
      throw FetchDataException(
          'No Internet Connection'); //Exception('some error occurred');
    } catch (e) {
      print(e.toString());
    }
  }

  //fetch movie detais..
  Future<MovieDetailResponse> fechMovieDetails(int movieId) async {
    try {
      final response = await http.get(UrlConstant.BASE_URL +
          '/movie/$movieId/videos?api_key=${UrlConstant.apiKey}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonString = jsonDecode(response.body);
        return MovieDetailResponse.fromJson(jsonString);
      }
    } on SocketException catch (_) {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<ItemList> getSearchMovies(String query) async {
    try {
      final response = await http.get(UrlConstant.BASE_URL +
          '/search/movie/?api_key=${UrlConstant.apiKey}&query=$query');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonString = jsonDecode(response.body);
        return ItemList.fromJson(jsonString);
      }
    } on SocketException catch (_) {
    } catch (e) {
      print(e.toString());
    }
  }
}
