import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tvseries_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(repository);
  });

  final data = <TvSeries>[];

  group('GetTvseriesRecommendations Usecase Tests', () {
    test(
        'should get list of [TvSeries] from the repository when execute function is called',
        () async {
      // arrange
      when(repository.getTvSeriesRecommendations(20912))
          .thenAnswer((_) async => Right(data));
      // act
      final result = await usecase.execute(20912);
      // assert
      expect(result, Right(data));
    });
  });
}
