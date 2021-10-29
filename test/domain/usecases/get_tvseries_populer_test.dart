import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_populer_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopulerTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetPopulerTvSeries(mockTvSeriesRepository);
  });

  final tSeries = <TvSeries>[];

  group('GetPopularMovies Tests', () {
    test(
        'should get list of series from the repository when execute function is called',
        () async {
      // arrange
      when(mockTvSeriesRepository.getPopularTvSeries())
          .thenAnswer((_) async => Right(tSeries));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(tSeries));
    });
  });
}
