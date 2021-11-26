import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvseries.dart';
import 'package:ditonton/domain/usecases/get_populer_tvseries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';

class SeriesListState extends Equatable {
  final List<TvSeries> nowPlayingSeries;
  final RequestState nowPlayingState;
  final List<TvSeries> popularSeries;
  final RequestState popularSeriesState;
  final List<TvSeries> topRatedSeries;
  final RequestState topRatedSeriesState;
  final String message;

  SeriesListState({
    this.nowPlayingSeries = const [],
    this.nowPlayingState = RequestState.Empty,
    this.popularSeries = const [],
    this.popularSeriesState = RequestState.Empty,
    this.topRatedSeries = const [],
    this.topRatedSeriesState = RequestState.Empty,
    this.message = "",
  });

  SeriesListState copyWith({
    List<TvSeries>? nowPlayingSeries,
    RequestState? nowPlayingState,
    List<TvSeries>? popularSeries,
    RequestState? popularSeriesState,
    List<TvSeries>? topRatedSeries,
    RequestState? topRatedSeriesState,
    String? message,
  }) {
    return SeriesListState(
      nowPlayingSeries: nowPlayingSeries ?? this.nowPlayingSeries,
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      popularSeries: popularSeries ?? this.popularSeries,
      popularSeriesState: popularSeriesState ?? this.popularSeriesState,
      topRatedSeries: topRatedSeries ?? this.topRatedSeries,
      topRatedSeriesState: topRatedSeriesState ?? this.topRatedSeriesState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props {
    return [
      nowPlayingSeries,
      nowPlayingState,
      popularSeries,
      popularSeriesState,
      topRatedSeries,
      topRatedSeriesState,
      message,
    ];
  }
}

class SeriesListCubit extends Cubit<SeriesListState> {
  final GetNowPlayingTvSeries getNowPlayingSeries;
  final GetPopulerTvSeries getPopulerTvSeries;
  final GetTopRatedTvSeries getTopRatedMovies;

  SeriesListCubit({
    required this.getNowPlayingSeries,
    required this.getPopulerTvSeries,
    required this.getTopRatedMovies,
  }) : super(SeriesListState());

  fetchNowPlayingSeries() async {
    emit(state.copyWith(
      nowPlayingState: RequestState.Loading,
    ));

    final result = await getNowPlayingSeries.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          nowPlayingState: RequestState.Error,
          message: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          nowPlayingState: RequestState.Loaded,
          nowPlayingSeries: data,
        ));
      },
    );
  }

  fetchPopularSeries() async {
    emit(state.copyWith(popularSeriesState: RequestState.Loading));

    final result = await getPopulerTvSeries.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          message: failure.message,
          popularSeriesState: RequestState.Error,
        ));
      },
      (data) {
        emit(state.copyWith(
          popularSeries: data,
          popularSeriesState: RequestState.Loaded,
        ));
      },
    );
  }

  fetchTopRatedSeries() async {
    emit(state.copyWith(topRatedSeriesState: RequestState.Loading));

    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          topRatedSeriesState: RequestState.Error,
          message: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          topRatedSeriesState: RequestState.Loaded,
          topRatedSeries: data,
        ));
      },
    );
  }
}
