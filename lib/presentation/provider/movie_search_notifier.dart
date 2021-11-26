import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';

class MovieSearchState extends Equatable {
  final RequestState state;
  final List<Movie> searchResult;
  final String message;

  MovieSearchState({
    this.state = RequestState.Empty,
    this.searchResult = const [],
    this.message = "",
  });

  @override
  List<Object> get props => [state, searchResult, message];

  MovieSearchState copyWith({
    RequestState? state,
    List<Movie>? searchResult,
    String? message,
  }) {
    return MovieSearchState(
      state: state ?? this.state,
      searchResult: searchResult ?? this.searchResult,
      message: message ?? this.message,
    );
  }
}

class MovieSearchCubit extends Cubit<MovieSearchState> {
  final SearchMovies searchMovies;
  MovieSearchCubit({
    required this.searchMovies,
  }) : super(MovieSearchState());

  fetchMovieSearch(String query) async {
    emit(state.copyWith(
      state: RequestState.Loading,
    ));

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        emit(state.copyWith(
          message: failure.message,
          state: RequestState.Error,
        ));
      },
      (data) {
        emit(state.copyWith(
          searchResult: data,
          state: RequestState.Loaded,
        ));
      },
    );
  }
}
