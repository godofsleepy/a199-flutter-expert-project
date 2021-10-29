import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvSeries usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = GetTopRatedTvSeries(repository);
  });

  final data = <TvSeries>[];

  group('Get Top Rated Tv Series Tests', () {
    test(
        'should get list of [TvSeries] from the repository when execute function is called',
        () async {
      // arrange
      when(repository.getTopRatedTvseries())
          .thenAnswer((_) async => Right(data));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(data));
    });
  });
}
