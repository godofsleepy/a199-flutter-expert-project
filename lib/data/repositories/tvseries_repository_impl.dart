import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class TvSeriesRepositoryImpl implements TvSeriesRepository {
  @override
  Future<Either<Failure, List<TvSeries>>> getOnTheAirTvSeries() {
    // TODO: implement getOnTheAirTvSeries
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries() {
    // TODO: implement getPopularTvSeries
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvseries() {
    // TODO: implement getTopRatedTvseries
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id) {
    // TODO: implement getTvSeriesDetail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(int id) {
    // TODO: implement getTvSeriesRecommendations
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries() {
    // TODO: implement getWatchlistTvSeries
    throw UnimplementedError();
  }

  @override
  Future<bool> isAddedToWatchlist(int id) {
    // TODO: implement isAddedToWatchlist
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(TvSeriesDetail movie) {
    // TODO: implement removeWatchlist
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetail movie) {
    // TODO: implement saveWatchlist
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query) {
    // TODO: implement searchTvSeries
    throw UnimplementedError();
  }
}
