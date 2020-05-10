import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/src/constants/string_constant.dart';
import 'package:flutter_movie/src/movieDetails/bloc/bloc.dart';
import 'package:meta/meta.dart';

class MovieDetail extends StatefulWidget {
  final int movieId;
  final String movieTitle;
  final String posterUrl;
  final String description;
  final String releaseDate;
  final String voteAverag;
  const MovieDetail(
      {@required this.movieId,
      @required this.movieTitle,
      @required this.releaseDate,
      @required this.voteAverag,
      @required this.posterUrl,
      @required this.description});

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  MovieDetailBloc _movieDetailBloc;
  @override
  void initState() {
    super.initState();
    _movieDetailBloc = BlocProvider.of<MovieDetailBloc>(context)
      ..add(FetchMovieDetail(id: widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
              centerTitle: true,
              brightness: Brightness.light,
              backgroundColor: Colors.white10,
              elevation: 0.0,
              title: Text(widget.movieTitle,
                  style: Theme.of(context).textTheme.headline6)) ??
          Text(StringConstan.movie_details),
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          bloc: _movieDetailBloc,
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is MovieDetailLoaded) {
              return ListView(
                children: <Widget>[
                  SizedBox(height: 10,),
                 
                 
                  Hero(
                      tag: widget.movieTitle,
                      child: Image.network(
                          'https://image.tmdb.org/t/p/w500${widget.posterUrl}',
                          fit: BoxFit.cover)),
                           Center(
                             child: Text(state.movieDetailResponse.results[0].name,style: 
                             
                             TextStyle( color: Theme.of(context).primaryColor),),
                           ),
                  Container(
                    height: size.height * 0.15,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Color(0x14657786),
                          offset: Offset(0, 8),
                          blurRadius: 16.0,
                          spreadRadius: 0)
                    ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Rate',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor),
                            ),
                           Text('${widget.voteAverag}'),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'ReleaseDate',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor),
                            ),
                           Text('${widget.releaseDate}'),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "OverView",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${widget.description}',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            color: Color(0x14657786),
                            offset: Offset(0, 8),
                            blurRadius: 16.0,
                            spreadRadius: 0)
                      ]),
                    ),
                  )
                ],
              );
            }
            if (state is MovieDetailError) {
              return Center(
                  child: Text(
                      state.message.substring(state.message.indexOf('s'))));
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
