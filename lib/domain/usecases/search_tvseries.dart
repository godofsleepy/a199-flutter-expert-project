import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class SearchTvSeries {
  final TvSeriesRepository _tvseriesRepository;

  SearchTvSeries(this._tvseriesRepository);

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return _tvseriesRepository.searchTvSeries(query);
  }
}
