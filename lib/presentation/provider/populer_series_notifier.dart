import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_populer_tvseries.dart';

class PopulerSeriesState extends Equatable {
  final RequestState state;
  final List<TvSeries> data;
  final String message;
  PopulerSeriesState({
    this.state = RequestState.Error,
    this.data = const [],
    this.message = "",
  });

  @override
  List<Object> get props => [state, data, message];

  PopulerSeriesState copyWith({
    RequestState? state,
    List<TvSeries>? data,
    String? message,
  }) {
    return PopulerSeriesState(
      state: state ?? this.state,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }
}

class PopulerSeriesCubit extends Cubit<PopulerSeriesState> {
  final GetPopulerTvSeries getPopularSeries;

  PopulerSeriesCubit({
    required this.getPopularSeries,
  }) : super(PopulerSeriesState());

  Future<void> fetchPopularSeries() async {
    emit(state.copyWith(state: RequestState.Loading));
    final result = await getPopularSeries.execute();

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
