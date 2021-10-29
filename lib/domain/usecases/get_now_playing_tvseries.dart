import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetNowPlayingTvSeries {
  final TvSeriesRepository _tvseriesRepository;

  GetNowPlayingTvSeries(this._tvseriesRepository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return _tvseriesRepository.getOnTheAirTvSeries();
  }
}
