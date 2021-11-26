import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvseries.dart';

class NowPlayingSeriesState extends Equatable {
  final RequestState state;
  final List<TvSeries> data;
  final String message;

  NowPlayingSeriesState({
    this.state = RequestState.Empty,
    this.data = const [],
    this.message = "",
  });

  @override
  List<Object> get props => [state, data, message];

  NowPlayingSeriesState copyWith({
    RequestState? state,
    List<TvSeries>? data,
    String? message,
  }) {
    return NowPlayingSeriesState(
      state: state ?? this.state,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }
}

class NowPlayingSeriesCubit extends Cubit<NowPlayingSeriesState> {
  final GetNowPlayingTvSeries getNowPlaying;

  NowPlayingSeriesCubit({
    required this.getNowPlaying,
  }) : super(NowPlayingSeriesState());

  fetchNowPlaying() async {
    emit(state.copyWith(state: RequestState.Loading));

    final result = await getNowPlaying.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          message: failure.message,
          state: RequestState.Error,
        ));
      },
      (data) {
        emit(state.copyWith(
          data: data,
          state: RequestState.Loaded,
        ));
      },
    );
  }
}
