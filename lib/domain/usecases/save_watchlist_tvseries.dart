import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class SaveWatchlistTvSeries {
  final TvSeriesRepository _tvseriesRepository;

  SaveWatchlistTvSeries(this._tvseriesRepository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tv) {
    return _tvseriesRepository.saveWatchlist(tv);
  }
}
