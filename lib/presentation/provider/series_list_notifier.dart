import 'package:flutter/material.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvseries.dart';
import 'package:ditonton/domain/usecases/get_populer_tvseries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';

class SeriesListNotifier extends ChangeNotifier {
  var _nowPlayingSeries = <TvSeries>[];
  List<TvSeries> get nowPlayingSeries => _nowPlayingSeries;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularSeries = <TvSeries>[];
  List<TvSeries> get popularSeries => _popularSeries;

  RequestState _popularSeriesState = RequestState.Empty;
  RequestState get popularSeriesState => _popularSeriesState;

  var _topRatedSeries = <TvSeries>[];
  List<TvSeries> get topRatedSeries => _topRatedSeries;

  RequestState _topRatedSeriesState = RequestState.Empty;
  RequestState get topRatedSeriesState => _topRatedSeriesState;

  String _message = '';
  String get message => _message;

  final GetNowPlayingTvSeries getNowPlayingSeries;
  final GetPopulerTvSeries getPopulerTvSeries;
  final GetTopRatedTvSeries getTopRatedMovies;
  SeriesListNotifier({
    required this.getNowPlayingSeries,
    required this.getPopulerTvSeries,
    required this.getTopRatedMovies,
  });

  Future<void> fetchNowPlayingSeries() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingSeries.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingSeries = data;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularSeries() async {
    _popularSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopulerTvSeries.execute();
    result.fold(
      (failure) {
        _popularSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _popularSeriesState = RequestState.Loaded;
        _popularSeries = data;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedSeries() async {
    _topRatedSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) {
        _topRatedSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _topRatedSeriesState = RequestState.Loaded;
        _topRatedSeries = data;
        notifyListeners();
      },
    );
  }
}
