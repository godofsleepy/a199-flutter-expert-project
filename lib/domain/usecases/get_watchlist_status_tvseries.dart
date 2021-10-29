import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetWatchListStatusTvSeries {
  final TvSeriesRepository _tvseriesRepository;

  GetWatchListStatusTvSeries(this._tvseriesRepository);

  Future<bool> execute(int id) {
    return _tvseriesRepository.isAddedToWatchlist(id);
  }
}
