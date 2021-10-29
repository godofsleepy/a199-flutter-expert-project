import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

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
      when(repository.removeWatchlist()).thenAnswer((_) async => Right(data));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(data));
    });
  });
}
