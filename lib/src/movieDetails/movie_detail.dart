import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/src/movieDetails/bloc/bloc.dart';
import 'package:flutter_movie/src/movieList/model/movie_items.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieDetail extends StatelessWidget {
  final Result result;
  const MovieDetail({required this.result}) : assert(result != null);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    BlocProvider.of<MovieDetailBloc>(context)
      ..add(FetchMovieDetail(id: result.id!));
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
        if (state.status.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.status.isSuccess &&
            state.movieDetailResponse!.results!.isNotEmpty) {
          print(state.movieDetailResponse!.results.toString());
          return ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Hero(
                    tag: result.id!,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500${result.backdrop_path}',
                      errorWidget: (context, url, error) => Image.network(
                          'https://azadchaiwala.pk/getImage?i=&t=course'),
                    ),
                  ),
                  Positioned.fill(
                      child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                          child:
                              Container(color: Colors.black.withOpacity(0.2)))),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.black12, shape: BoxShape.circle),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            state.movieDetailResponse!.results![0].name!,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '(${result.release_date})',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              _buildMovieDetals(size, result),
              SizedBox(
                height: 10,
              ),
              _overView(size, result),
            ],
          );
        }
        //  else {
        //   return Center(
        //       child: Text(
        //     'No Data Available!!',
        //     style: GoogleFonts.anton(),
        //   ));
        // }
      
        if (state.status.isFailure) {
          return Center(child: Text(state.message));
        }
        return Center(child: CircularProgressIndicator());
      })),
    );
  }

  _buildMovieDetals(Size size, Result result) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: size.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(0x14657786), //Color(0XD8D8FC),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: Colors.redAccent,
                  ),
                  Text(
                    '${result.vote_averages}',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Vote',
                    style: GoogleFonts.lexendMega(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text('${result.vote_count}',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                ],
              )
            ],
          ),
        ),
      );

  _overView(Size size, Result result) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: EdgeInsets.all(5),
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
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${result.overview}',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Color(0x14657786),
              borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
      );
}
