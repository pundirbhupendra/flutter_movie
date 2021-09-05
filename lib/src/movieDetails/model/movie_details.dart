

 import 'package:flutter_movie/src/movieDetails/model/results.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_details.g.dart';
 @JsonSerializable()
class MovieDetailResponse {
  int? id;
  List<Results>? results;

  MovieDetailResponse({this.id, this.results});
 factory MovieDetailResponse.fromJson(Map<String,dynamic> json) => _$MovieDetailResponseFromJson(json);
  Map<String,dynamic> toJson() => _$MovieDetailResponseToJson(this); 

}

