import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class RemoveWatchlistTvSeries {
  final TvSeriesRepository _tvseriesRepository;

  RemoveWatchlistTvSeries(this._tvseriesRepository);

  Future<Either<Failure, String>> execute(TvSeries tv) {
    return _tvseriesRepository.removeWatchlist(tv);
  }
}
