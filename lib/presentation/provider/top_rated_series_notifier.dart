import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';

class TopRatedSeriesState extends Equatable {
  final RequestState state;
  final List<TvSeries> data;
  final String message;

  TopRatedSeriesState({
    this.state = RequestState.Empty,
    this.data = const [],
    this.message = "",
  });

  @override
  List<Object> get props => [state, data, message];

  TopRatedSeriesState copyWith({
    RequestState? state,
    List<TvSeries>? data,
    String? message,
  }) {
    return TopRatedSeriesState(
      state: state ?? this.state,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }
}

class TopRatedSeriesCubit extends Cubit<TopRatedSeriesState> {
  final GetTopRatedTvSeries getTopRatedSeries;
  TopRatedSeriesCubit({
    required this.getTopRatedSeries,
  }) : super(TopRatedSeriesState());

  fetchTopRatedSeries() async {
    emit(state.copyWith(state: RequestState.Loading));

    final result = await getTopRatedSeries.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          message: failure.message,
          state: RequestState.Error,
        ));
      },
      (data) {
        emit(state.copyWith(data: data, state: RequestState.Loaded));
      },
    );
  }
}
