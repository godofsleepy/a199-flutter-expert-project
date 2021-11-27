import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopulerMoviesCubit])
void main() {
  late MockPopulerMoviesCubit mockNotifier;

  setUp(() {
    mockNotifier = MockPopulerMoviesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopulerMoviesCubit>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(PopulerMovieState(
      state: RequestState.Loading,
    ));

    when(mockNotifier.stream).thenAnswer((_) => Stream.value(PopulerMovieState(
          state: RequestState.Loaded,
        )));
    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(PopulerMovieState(
      state: RequestState.Loaded,
      movies: const [],
    ));
    when(mockNotifier.stream).thenAnswer((_) => Stream.value(PopulerMovieState(
          state: RequestState.Loaded,
          movies: const [],
        )));
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(PopulerMovieState(
      state: RequestState.Error,
      message: "Error message",
    ));
    when(mockNotifier.stream).thenAnswer((_) => Stream.value(PopulerMovieState(
          state: RequestState.Error,
          message: "Error message",
        )));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
