import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvSeries usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = SaveWatchlistTvSeries(repository);
  });

  final data = "";

  group('Save Watchlist Tv Series Tests', () {
    test(
        'should get empty String from the repository when execute function is called',
        () async {
      // arrange
      when(repository.saveWatchlist(testTvSeriesDetail))
          .thenAnswer((_) async => Right(data));
      // act
      final result = await usecase.execute(testTvSeriesDetail);
      // assert
      expect(result, Right(data));
    });
  });
}
