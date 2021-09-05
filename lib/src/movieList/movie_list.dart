import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/src/constants/string_constant.dart';
import 'package:flutter_movie/src/movieList/bloc/bloc.dart';
import 'package:flutter_movie/src/network/repository/movie_api_client.dart';
import 'package:flutter_movie/src/routes/router.gr.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model/movie_items.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  void dispose() {
    super.dispose();
    searchController.clear();
  }

  TypeAheadFormField? searchTextField;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<MovieListBloc>(context)..add(LoadMovieList());
  }

  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: Scaffold(body:
          BlocBuilder<MovieListBloc, MovieListState>(builder: (context, state) {
        if (state is MovieListLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is MovieListLoaded) {
          return ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(StringConstan.movie_list,
                    style: GoogleFonts.lexendMega(fontSize: 18)),
              ),
              SizedBox(
                height: 10,
              ),
              _searchMovies(context),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left:20),
                child: Text(
                  'Popular Movies',
                  style:
                      GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GridView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: state.movieList.results.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        (orientation == Orientation.portrait) ? 2 : 3),
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: <Widget>[
                      InkWell(
                        onTap: () => navigateToMovieDetail(
                          context,
                          state.movieList.results[index],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _posterImage(state.movieList.results[index].poster_path)
                        ),
                      ),
                      Positioned(
                          bottom: 14,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              state.movieList.results[index].original_title!,
                              maxLines: 5,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lexendMega(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                    ],
                  );
                },
              ),
            ],
          );
        }
        if (state is MovieListError) {
          return Center(child: Text(state.message));
        }
        return Center(child: CircularProgressIndicator());
      })),
    );
  }

  void navigateToMovieDetail(BuildContext context, Result result) {
     AutoRouter.of(context).push(MovieDetail(result: result));
  //  Router.navigator.pushNamed(Router.movieDetail, arguments: result);
  }

  Widget _searchMovies(BuildContext context) {
    final MovieApiClient movieApiClient = MovieApiClient();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Color(0xfff5f8fd),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
              child: searchTextField = TypeAheadFormField<Result>(
            textFieldConfiguration: TextFieldConfiguration(
               //ss maxLines: null,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Search Movies."),
                controller: searchController),
            suggestionsCallback: (pattern) async {
              return await movieApiClient
                  .getSearchMovies(pattern)
                  .then((value) {
                return value.results;
              }).catchError((e){
                print(e);
              });
              },
            itemBuilder: (context, suggestion) {
              return ListTile(
                leading: CachedNetworkImage(
                  imageUrl:  'https://image.tmdb.org/t/p/w185${suggestion.poster_path}',
                  colorBlendMode: BlendMode.darken,
                   errorWidget: (context, url, error) => Image.network('https://azadchaiwala.pk/getImage?i=&t=course',width: 55,height: 80,),
                  ),
                title: Text(
                  suggestion.original_title!,
                  style: GoogleFonts.lexendMega(),
                ),
              );
            },
            onSuggestionSelected: (suggestion) async {
               AutoRouter.of(context).push(MovieDetail(result: suggestion));
            
            },
          )),
          InkWell(
              onTap: () {
                //..
              },
              child: Container(child: Icon(Icons.search)))
        ],
      ),
    );
  }

  _posterImage(String? path) => CachedNetworkImage(
        imageUrl:
            'https://image.tmdb.org/t/p/w185$path',
        imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter:
                  ColorFilter.mode(Colors.black12, BlendMode.colorBurn)),
        )),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
}
