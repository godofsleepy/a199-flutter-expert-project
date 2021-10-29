import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = SearchTvSeries(repository);
  });

  final data = <TvSeries>[];

  group('Search Tv Series Usecase Tests', () {
    test(
        'should get list of _ from the repository when execute function is called',
        () async {
      // arrange
      when(repository.searchTvSeries("query"))
          .thenAnswer((_) async => Right(data));
      // act
      final result = await usecase.execute("query");
      // assert
      expect(result, Right(data));
    });
  });
}
