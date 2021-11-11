import 'package:flutter/material.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_populer_tvseries.dart';

class PopularSeriesNotifier extends ChangeNotifier {
  final GetPopulerTvSeries getPopularSeries;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _data = [];
  List<TvSeries> get data => _data;

  String _message = '';
  PopularSeriesNotifier({
    required this.getPopularSeries,
  });
  String get message => _message;

  Future<void> fetchPopularSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularSeries.execute();

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
