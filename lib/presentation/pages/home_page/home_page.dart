import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_clean_architecture_test/core/utils/api_service.dart';
import 'package:movies_clean_architecture_test/data/data_source/remote_movies_data_source.dart';
import 'package:movies_clean_architecture_test/data/repository/movies_repository.dart';
import 'package:movies_clean_architecture_test/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:movies_clean_architecture_test/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movies_clean_architecture_test/domain/usecases/get_top_rated_movies_usecase.dart';
import 'package:movies_clean_architecture_test/presentation/manager/home_movies_bloc/home_movies_bloc.dart';
import 'package:movies_clean_architecture_test/presentation/pages/home_page/components/now_playing_movies_component.dart';
import 'package:movies_clean_architecture_test/presentation/pages/home_page/components/top_movies_component.dart';
import 'package:movies_clean_architecture_test/presentation/pages/home_page/components/top_rated_movies_component.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeMoviesBloc(
        GetNowPlayingMoviesUseCase(
          MoviesRepository(RemoteMoviesDataSource(ApiService(Dio()))),
        ),
        GetPopularMoviesUseCase(
          MoviesRepository(RemoteMoviesDataSource(ApiService(Dio()))),
        ),
        GetTopRatedMoviesUseCase(
          MoviesRepository(RemoteMoviesDataSource(ApiService(Dio()))),
        ),
      )
        ..add(GetNowPlayingMoviesEvent())
        ..add(GetPopularMoviesEvent())
        ..add(GetTopMoviesEvent()),
      child: Scaffold(
        body: SingleChildScrollView(
          key: const Key('movieScrollView'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NowPlayingMoviesComponent(),
              Container(
                margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular",
                      style: GoogleFonts.poppins(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.15,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        /// TODO : NAVIGATION TO POPULAR SCREEN
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            Text(
                              'See More',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const TopMoviesComponent(),
              Container(
                margin: const EdgeInsets.fromLTRB(
                  16.0,
                  24.0,
                  16.0,
                  8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top Rated",
                      style: GoogleFonts.poppins(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.15,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        /// TODO : NAVIGATION TO Top Rated Movies Screen
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            Text(
                              'See More',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const TopRatedMoviesComponent(),
              const SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
