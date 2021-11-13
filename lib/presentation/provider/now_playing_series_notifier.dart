import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvseries.dart';
import 'package:flutter/material.dart';

class NowPlayingSeriesNotifier extends ChangeNotifier {
  final GetNowPlayingTvSeries getNowPlaying;

  NowPlayingSeriesNotifier({required this.getNowPlaying});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _data = [];
  List<TvSeries> get data => _data;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlaying() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlaying.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _data = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
