import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';

class MovieDetailState extends Equatable {
  final MovieDetail? movie;
  final String message;
  final String watchlistMessage;
  final RequestState movieState;
  final RequestState recommendationState;
  final List<Movie> movieRecommendations;
  final bool isAddedToWatchlist;

  MovieDetailState({
    this.movie,
    this.message = "",
    this.watchlistMessage = "",
    this.movieState = RequestState.Empty,
    this.recommendationState = RequestState.Empty,
    this.movieRecommendations = const [],
    this.isAddedToWatchlist = false,
  });

  MovieDetailState copyWith({
    MovieDetail? movie,
    String? message,
    String? watchlistMessage,
    RequestState? movieState,
    RequestState? recommendationState,
    List<Movie>? movieRecommendations,
    bool? isAddedToWatchlist,
  }) {
    return MovieDetailState(
      movie: movie ?? this.movie,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      movieState: movieState ?? this.movieState,
      recommendationState: recommendationState ?? this.recommendationState,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  @override
  List<Object?> get props {
    return [
      movie,
      message,
      watchlistMessage,
      movieState,
      recommendationState,
      movieRecommendations,
      isAddedToWatchlist,
    ];
  }
}

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  MovieDetailCubit({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailState());

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  Future<void> fetchMovieDetail(int id) async {
    emit(state.copyWith(movieState: RequestState.Loading));

    final detailResult = await getMovieDetail.execute(id);
    final recommendationResult = await getMovieRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        emit(state.copyWith(
            movieState: RequestState.Error, message: failure.message));
      },
      (movie) {
        emit(state.copyWith(
            recommendationState: RequestState.Loading, movie: movie));

        recommendationResult.fold(
          (failure) {
            emit(state.copyWith(
                recommendationState: RequestState.Error,
                message: failure.message));
          },
          (movies) {
            emit(state.copyWith(
                recommendationState: RequestState.Loaded,
                movieRecommendations: movies));
          },
        );
        emit(state.copyWith(movieState: RequestState.Loaded));
      },
    );
  }

  addWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        emit(state.copyWith(watchlistMessage: failure.message));
      },
      (successMessage) async {
        emit(state.copyWith(watchlistMessage: successMessage));
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  removeFromWatchlist(MovieDetail movie) async {
    final result = await removeWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        emit(state.copyWith(watchlistMessage: failure.message));
      },
      (successMessage) async {
        emit(state.copyWith(watchlistMessage: successMessage));
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    emit(state.copyWith(isAddedToWatchlist: result));
  }
}
