import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';

class WatchlistMovieState extends Equatable {
  final List<Movie> watchlistMovies;
  final RequestState watchlistState;
  final String message;

  WatchlistMovieState({
    this.watchlistMovies = const [],
    this.watchlistState = RequestState.Empty,
    this.message = "",
  });

  WatchlistMovieState copyWith({
    List<Movie>? watchlistMovies,
    RequestState? watchlistState,
    String? message,
  }) {
    return WatchlistMovieState(
      watchlistMovies: watchlistMovies ?? this.watchlistMovies,
      watchlistState: watchlistState ?? this.watchlistState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [watchlistMovies, watchlistState, message];
}

class WatchListMovieCubit extends Cubit<WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;
  WatchListMovieCubit({
    required this.getWatchlistMovies,
  }) : super(WatchlistMovieState());

  fetchWatchlistMovies() async {
    emit(state.copyWith(watchlistState: RequestState.Loading));

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          watchlistState: RequestState.Error,
          message: failure.message,
        ));
      },
      (moviesData) {
        emit(state.copyWith(
          watchlistState: RequestState.Loaded,
          watchlistMovies: moviesData,
        ));
      },
    );
  }
}
