import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTvSeries usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = RemoveWatchlistTvSeries(repository);
  });

  final data = "";

  group('Remove Watchlist Tv Series Tests', () {
    test(
        'should get empty [String] from the repository when execute function is called',
        () async {
      // arrange
      when(repository.removeWatchlist(testTvSeriesDetail))
          .thenAnswer((_) async => Right(data));
      // act
      final result = await usecase.execute(testTvSeriesDetail);
      // assert
      expect(result, Right(data));
    });
  });
}
