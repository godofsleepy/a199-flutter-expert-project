import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvSeries usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = GetWatchlistTvSeries(repository);
  });

  final data = <TvSeries>[];

  group('Get Watchlist TvSeries usecase Tests', () {
    test(
        'should get list of [TvSeries] from the repository when execute function is called',
        () async {
      // arrange
      when(repository.getWatchlistTvSeries())
          .thenAnswer((_) async => Right(data));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(data));
    });
  });
}
