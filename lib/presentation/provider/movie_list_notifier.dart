import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';

class MovieListState extends Equatable {
  final List<Movie> nowPlayingMovies;
  final RequestState nowPlayingState;
  final List<Movie> popularMovies;
  final RequestState popularMoviesState;
  final List<Movie> topRatedMovies;
  final RequestState topRatedMoviesState;
  final String message;
  MovieListState({
    this.nowPlayingMovies = const [],
    this.nowPlayingState = RequestState.Empty,
    this.popularMovies = const [],
    this.popularMoviesState = RequestState.Empty,
    this.topRatedMovies = const [],
    this.topRatedMoviesState = RequestState.Empty,
    this.message = "",
  });

  MovieListState copyWith({
    List<Movie>? nowPlayingMovies,
    RequestState? nowPlayingState,
    List<Movie>? popularMovies,
    RequestState? popularMoviesState,
    List<Movie>? topRatedMovies,
    RequestState? topRatedMoviesState,
    String? message,
  }) {
    return MovieListState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      popularMovies: popularMovies ?? this.popularMovies,
      popularMoviesState: popularMoviesState ?? this.popularMoviesState,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      topRatedMoviesState: topRatedMoviesState ?? this.topRatedMoviesState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props {
    return [
      nowPlayingMovies,
      nowPlayingState,
      popularMovies,
      popularMoviesState,
      topRatedMovies,
      topRatedMoviesState,
      message,
    ];
  }
}

class MovieListCubit extends Cubit<MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListCubit({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MovieListState());

  fetchNowPlayingMovies() async {
    emit(state.copyWith(nowPlayingState: RequestState.Loading));
    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          nowPlayingState: RequestState.Error,
          message: failure.message,
        ));
      },
      (moviesData) {
        emit(state.copyWith(
            nowPlayingMovies: moviesData,
            nowPlayingState: RequestState.Loaded));
      },
    );
  }

  fetchPopularMovies() async {
    emit(state.copyWith(popularMoviesState: RequestState.Loading));

    final result = await getPopularMovies.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          message: failure.message,
          popularMoviesState: RequestState.Error,
        ));
      },
      (moviesData) {
        emit(state.copyWith(
          popularMovies: moviesData,
          popularMoviesState: RequestState.Loaded,
        ));
      },
    );
  }

  Future<void> fetchTopRatedMovies() async {
    emit(state.copyWith(topRatedMoviesState: RequestState.Loading));

    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          topRatedMoviesState: RequestState.Error,
          message: failure.message,
        ));
      },
      (moviesData) {
        emit(state.copyWith(
          topRatedMoviesState: RequestState.Loaded,
          topRatedMovies: moviesData,
        ));
      },
    );
  }
}
