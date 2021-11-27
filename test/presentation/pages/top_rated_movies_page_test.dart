import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([TopRatedMovieCubit])
void main() {
  late MockTopRatedMovieCubit mockNotifier;

  setUp(() {
    mockNotifier = MockTopRatedMovieCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMovieCubit>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(TopRatedMovieState(
      state: RequestState.Loading,
    ));

    when(mockNotifier.stream).thenAnswer((_) => Stream.value(TopRatedMovieState(
          state: RequestState.Loaded,
        )));

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(TopRatedMovieState(
      state: RequestState.Loaded,
      movies: const [],
    ));

    when(mockNotifier.stream).thenAnswer((_) => Stream.value(TopRatedMovieState(
          state: RequestState.Loaded,
          movies: const [],
        )));
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(TopRatedMovieState(
      state: RequestState.Error,
      message: "Error message",
    ));

    when(mockNotifier.stream).thenAnswer((_) => Stream.value(TopRatedMovieState(
          state: RequestState.Error,
          message: "Error message",
        )));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
