import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';

class TopRatedMovieState extends Equatable {
  final List<Movie> movies;
  final RequestState state;
  final String message;
  TopRatedMovieState({
    this.movies = const [],
    this.state = RequestState.Empty,
    this.message = "",
  });

  @override
  List<Object> get props => [movies, state, message];

  TopRatedMovieState copyWith({
    List<Movie>? movies,
    RequestState? state,
    String? message,
  }) {
    return TopRatedMovieState(
      movies: movies ?? this.movies,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }
}

class TopRatedMovieCubit extends Cubit<TopRatedMovieState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedMovieCubit({
    required this.getTopRatedMovies,
  }) : super(TopRatedMovieState());

  fetchTopRatedMovies() async {
    emit(state.copyWith(state: RequestState.Loading));

    final result = await getTopRatedMovies.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
            state: RequestState.Error, message: failure.message));
      },
      (moviesData) {
        emit(state.copyWith(
          movies: moviesData,
          state: RequestState.Loaded,
        ));
      },
    );
  }
}
