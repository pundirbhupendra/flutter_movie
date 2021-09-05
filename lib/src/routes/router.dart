//import 'package:auto_route/auto_route_annotations.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter_movie/src/movieDetails/movie_detail.dart';
import 'package:flutter_movie/src/movieList/movie_list.dart';

// @autoRouter
// class $Router {
//  @initial
//   MovieList movieList;
//   MovieDetail movieDetail;
// }

//flutter packages pub run build_runner watch    --delete-conflicting-outputs
@MaterialAutoRouter(    
  replaceInRouteName: 'Page,Route',    
  routes: <AutoRoute>[    
    AutoRoute(page: MovieList, initial: true),    
    AutoRoute(page: MovieDetail),    
  ],    
)    
class $AppRouter {} 