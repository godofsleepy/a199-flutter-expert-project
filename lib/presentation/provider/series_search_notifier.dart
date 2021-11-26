import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tvseries.dart';

class SeriesSearchState extends Equatable {
  final RequestState state;
  final List<TvSeries> searchResult;
  final String message;

  SeriesSearchState({
    this.state = RequestState.Empty,
    this.searchResult = const [],
    this.message = "",
  });

  SeriesSearchState copyWith({
    RequestState? state,
    List<TvSeries>? searchResult,
    String? message,
  }) {
    return SeriesSearchState(
      state: state ?? this.state,
      searchResult: searchResult ?? this.searchResult,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [state, searchResult, message];
}

class SeriesSearchCubit extends Cubit<SeriesSearchState> {
  final SearchTvSeries searchTvSeries;
  SeriesSearchCubit({
    required this.searchTvSeries,
  }) : super(SeriesSearchState());

  fetchSeriesSearch(String query) async {
    emit(state.copyWith(state: RequestState.Loading));

    final result = await searchTvSeries.execute(query);
    result.fold(
      (failure) {
        emit(state.copyWith(
          message: failure.message,
          state: RequestState.Error,
        ));
      },
      (data) {
        emit(state.copyWith(searchResult: data, state: RequestState.Loaded));
      },
    );
  }
}
