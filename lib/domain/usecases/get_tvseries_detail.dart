import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetTvSeriesDetail {
  final TvSeriesRepository _tvseriesRepository;

  GetTvSeriesDetail(this._tvseriesRepository);

  Future<Either<Failure, TvSeriesDetail>> execute(int id) {
    return _tvseriesRepository.getTvSeriesDetail(id);
  }
}
