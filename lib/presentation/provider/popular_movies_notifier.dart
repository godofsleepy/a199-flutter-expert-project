import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';

class PopulerMovieState extends Equatable {
  final RequestState state;
  final List<Movie> movies;
  final String message;

  PopulerMovieState({
    this.state = RequestState.Empty,
    this.movies = const [],
    this.message = "",
  });

  @override
  List<Object> get props => [state, movies, message];

  PopulerMovieState copyWith({
    RequestState? state,
    List<Movie>? movies,
    String? message,
  }) {
    return PopulerMovieState(
      state: state ?? this.state,
      movies: movies ?? this.movies,
      message: message ?? this.message,
    );
  }
}

class PopulerMoviesCubit extends Cubit<PopulerMovieState> {
  final GetPopularMovies getPopularMovies;

  PopulerMoviesCubit({
    required this.getPopularMovies,
  }) : super(PopulerMovieState());

  fetchPopularMovies() async {
    emit(state.copyWith(state: RequestState.Loading));

    final result = await getPopularMovies.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
            message: failure.message, state: RequestState.Error));
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
