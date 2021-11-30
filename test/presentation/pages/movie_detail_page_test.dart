import 'dart:async';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailCubit])
void main() {
  late MockMovieDetailCubit mockNotifier;

  setUp(() {
    mockNotifier = MockMovieDetailCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailCubit>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(MovieDetailState(
      movieState: RequestState.Loaded,
      movie: testMovieDetail,
      recommendationState: RequestState.Loaded,
      movieRecommendations: [],
      isAddedToWatchlist: false,
    ));

    when(mockNotifier.stream).thenAnswer((_) => Stream.value(MovieDetailState(
          movieState: RequestState.Loaded,
          movie: testMovieDetail,
          recommendationState: RequestState.Loaded,
          movieRecommendations: [],
          isAddedToWatchlist: false,
        )));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(MovieDetailState(
      movieState: RequestState.Loaded,
      movie: testMovieDetail,
      recommendationState: RequestState.Loaded,
      movieRecommendations: [],
      isAddedToWatchlist: true,
    ));

    when(mockNotifier.stream).thenAnswer((_) => Stream.value(MovieDetailState(
          movieState: RequestState.Loaded,
          movie: testMovieDetail,
          recommendationState: RequestState.Loaded,
          movieRecommendations: [],
          isAddedToWatchlist: false,
        )));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(MovieDetailState(
      movieState: RequestState.Loaded,
      movie: testMovieDetail,
      recommendationState: RequestState.Loaded,
      movieRecommendations: [],
      isAddedToWatchlist: false,
      watchlistMessage: "",
    ));

    when(mockNotifier.stream).thenAnswer((_) => Stream.value(MovieDetailState(
          movieState: RequestState.Loaded,
          movie: testMovieDetail,
          recommendationState: RequestState.Loaded,
          movieRecommendations: [],
          isAddedToWatchlist: false,
          watchlistMessage: "Added to Watchlist",
        )));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expectLater(find.byType(SnackBar), findsOneWidget);
    expectLater(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(MovieDetailState(
      movieState: RequestState.Loaded,
      movie: testMovieDetail,
      recommendationState: RequestState.Loaded,
      movieRecommendations: [],
      isAddedToWatchlist: false,
      watchlistMessage: "",
    ));

    when(mockNotifier.stream).thenAnswer((_) => Stream.value(MovieDetailState(
          movieState: RequestState.Loaded,
          movie: testMovieDetail,
          recommendationState: RequestState.Loaded,
          movieRecommendations: [],
          isAddedToWatchlist: false,
          watchlistMessage: "Failed",
        )));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expectLater(find.byType(AlertDialog), findsOneWidget);
    expectLater(find.text('Failed'), findsOneWidget);
  });
}
