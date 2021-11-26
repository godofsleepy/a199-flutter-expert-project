import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvseries.dart';

class WatchlistSeriesState extends Equatable {
  final List<TvSeries> watchlistSeries;
  final RequestState watchlistState;
  final String message;

  WatchlistSeriesState({
    this.watchlistSeries = const [],
    this.watchlistState = RequestState.Empty,
    this.message = "",
  });

  WatchlistSeriesState copyWith({
    List<TvSeries>? watchlistSeries,
    RequestState? watchlistState,
    String? message,
  }) {
    return WatchlistSeriesState(
      watchlistSeries: watchlistSeries ?? this.watchlistSeries,
      watchlistState: watchlistState ?? this.watchlistState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [watchlistSeries, watchlistState, message];
}

class WatchListSeriesCubit extends Cubit<WatchlistSeriesState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;
  WatchListSeriesCubit({
    required this.getWatchlistTvSeries,
  }) : super(WatchlistSeriesState());

  fetchWatchlistSeries() async {
    emit(state.copyWith(watchlistState: RequestState.Loading));

    final result = await getWatchlistTvSeries.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          watchlistState: RequestState.Error,
          message: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          watchlistSeries: data,
          watchlistState: RequestState.Loaded,
        ));
      },
    );
  }
}
