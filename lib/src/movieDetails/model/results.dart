import 'package:json_annotation/json_annotation.dart';
part 'results.g.dart';
 @JsonSerializable()
class Results {
  String? id;
  @JsonKey(name:'iso_639_1')
  String? iso6391;
   @JsonKey(name:'iso_3166_1')
  String? iso31661;
  String? key;
  String? name;
  String? site;
  int? size;
  String? type;

  Results(
      {this.id,
      this.iso6391,
      this.iso31661,
      this.key,
      this.name,
      this.site,
      this.size,
      this.type});

      factory Results.fromJson(Map<String,dynamic> json)=>_$ResultsFromJson(json);
      Map<String,dynamic> toJosn()=>_$ResultsToJson(this);

}