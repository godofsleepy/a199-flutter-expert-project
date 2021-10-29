import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetTvSeriesRecommendations {
  final TvSeriesRepository _tvseriesRepository;

  GetTvSeriesRecommendations(this._tvseriesRepository);

  Future<Either<Failure, List<TvSeries>>> execute(int id) {
    return _tvseriesRepository.getTvSeriesRecommendations(id);
  }
}
