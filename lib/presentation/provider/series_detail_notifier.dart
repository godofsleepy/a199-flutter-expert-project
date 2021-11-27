import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_tvseries_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tvseries.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tvseries.dart';

class SeriesDetailState extends Equatable {
  final TvSeriesDetail? data;
  final RequestState dataState;
  final List<TvSeries> seriesRecommendations;
  final RequestState recommendationState;
  final String watchlistMessage;
  final String message;
  final bool isAddedToWatchlist;

  SeriesDetailState({
    this.data,
    this.dataState = RequestState.Empty,
    this.seriesRecommendations = const [],
    this.recommendationState = RequestState.Empty,
    this.watchlistMessage = "",
    this.message = "",
    this.isAddedToWatchlist = false,
  });

  SeriesDetailState copyWith({
    TvSeriesDetail? data,
    RequestState? dataState,
    List<TvSeries>? seriesRecommendations,
    RequestState? recommendationState,
    String? watchlistMessage,
    String? message,
    bool? isAddedToWatchlist,
  }) {
    return SeriesDetailState(
      data: data ?? this.data,
      dataState: dataState ?? this.dataState,
      seriesRecommendations:
          seriesRecommendations ?? this.seriesRecommendations,
      recommendationState: recommendationState ?? this.recommendationState,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      message: message ?? this.message,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  @override
  List<Object?> get props {
    return [
      data,
      dataState,
      seriesRecommendations,
      recommendationState,
      watchlistMessage,
      message,
      isAddedToWatchlist,
    ];
  }
}

class SeriesDetailCubit extends Cubit<SeriesDetailState> {
  final GetTvSeriesDetail getSeriesDetail;
  final GetTvSeriesRecommendations getSeriesRecommendations;
  final GetWatchListStatusTvSeries getWatchListStatus;
  final SaveWatchlistTvSeries saveWatchlist;
  final RemoveWatchlistTvSeries removeWatchlist;
  SeriesDetailCubit({
    required this.getSeriesDetail,
    required this.getSeriesRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(SeriesDetailState());

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  Future<void> fetchSeriesDetail(int id) async {
    emit(state.copyWith(dataState: RequestState.Loading));
    final detailResult = await getSeriesDetail.execute(id);
    final recommendationResult = await getSeriesRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        emit(state.copyWith(
          message: failure.message,
          dataState: RequestState.Error,
        ));
      },
      (data) {
        emit(state.copyWith(
          recommendationState: RequestState.Loading,
          data: data,
        ));
        recommendationResult.fold(
          (failure) {
            emit(state.copyWith(
                message: failure.message,
                recommendationState: RequestState.Error));
          },
          (series) {
            emit(state.copyWith(
              seriesRecommendations: series,
              recommendationState: RequestState.Loaded,
            ));
          },
        );

        emit(state.copyWith(
          dataState: RequestState.Loaded,
        ));
      },
    );
  }

  addWatchlist(TvSeriesDetail detail) async {
    final result = await saveWatchlist.execute(detail);

    await result.fold(
      (failure) async {
        emit(state.copyWith(
          watchlistMessage: failure.message,
        ));
      },
      (successMessage) async {
        emit(state.copyWith(watchlistMessage: successMessage));
      },
    );

    await loadWatchlistStatus(detail.id);
  }

  removeFromWatchlist(TvSeriesDetail detail) async {
    final result = await removeWatchlist.execute(detail);

    await result.fold(
      (failure) async {
        emit(state.copyWith(
          watchlistMessage: failure.message,
        ));
      },
      (successMessage) async {
        emit(state.copyWith(watchlistMessage: successMessage));
      },
    );

    await loadWatchlistStatus(detail.id);
  }

  loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);

    emit(state.copyWith(isAddedToWatchlist: result));
  }
}
