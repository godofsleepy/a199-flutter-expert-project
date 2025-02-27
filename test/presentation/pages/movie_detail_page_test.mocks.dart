// Mocks generated by Mockito 5.0.16 from annotations
// in ditonton/test/presentation/pages/movie_detail_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i8;

import 'package:ditonton/domain/entities/movie_detail.dart' as _i9;
import 'package:ditonton/domain/usecases/get_movie_detail.dart' as _i2;
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart' as _i3;
import 'package:ditonton/domain/usecases/get_watchlist_status.dart' as _i4;
import 'package:ditonton/domain/usecases/remove_watchlist.dart' as _i6;
import 'package:ditonton/domain/usecases/save_watchlist.dart' as _i5;
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart'
    as _i7;
import 'package:flutter_bloc/flutter_bloc.dart' as _i10;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGetMovieDetail_0 extends _i1.Fake implements _i2.GetMovieDetail {}

class _FakeGetMovieRecommendations_1 extends _i1.Fake
    implements _i3.GetMovieRecommendations {}

class _FakeGetWatchListStatus_2 extends _i1.Fake
    implements _i4.GetWatchListStatus {}

class _FakeSaveWatchlist_3 extends _i1.Fake implements _i5.SaveWatchlist {}

class _FakeRemoveWatchlist_4 extends _i1.Fake implements _i6.RemoveWatchlist {}

class _FakeMovieDetailState_5 extends _i1.Fake implements _i7.MovieDetailState {
}

class _FakeStreamSubscription_6<T> extends _i1.Fake
    implements _i8.StreamSubscription<T> {}

/// A class which mocks [MovieDetailCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieDetailCubit extends _i1.Mock implements _i7.MovieDetailCubit {
  MockMovieDetailCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetMovieDetail get getMovieDetail =>
      (super.noSuchMethod(Invocation.getter(#getMovieDetail),
          returnValue: _FakeGetMovieDetail_0()) as _i2.GetMovieDetail);
  @override
  _i3.GetMovieRecommendations get getMovieRecommendations =>
      (super.noSuchMethod(Invocation.getter(#getMovieRecommendations),
              returnValue: _FakeGetMovieRecommendations_1())
          as _i3.GetMovieRecommendations);
  @override
  _i4.GetWatchListStatus get getWatchListStatus =>
      (super.noSuchMethod(Invocation.getter(#getWatchListStatus),
          returnValue: _FakeGetWatchListStatus_2()) as _i4.GetWatchListStatus);
  @override
  _i5.SaveWatchlist get saveWatchlist =>
      (super.noSuchMethod(Invocation.getter(#saveWatchlist),
          returnValue: _FakeSaveWatchlist_3()) as _i5.SaveWatchlist);
  @override
  _i6.RemoveWatchlist get removeWatchlist =>
      (super.noSuchMethod(Invocation.getter(#removeWatchlist),
          returnValue: _FakeRemoveWatchlist_4()) as _i6.RemoveWatchlist);
  @override
  _i7.MovieDetailState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
          returnValue: _FakeMovieDetailState_5()) as _i7.MovieDetailState);
  @override
  _i8.Stream<_i7.MovieDetailState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i7.MovieDetailState>.empty())
          as _i8.Stream<_i7.MovieDetailState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  _i8.Future<void> fetchMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#fetchMovieDetail, [id]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> addWatchlist(_i9.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#addWatchlist, [movie]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> removeFromWatchlist(_i9.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeFromWatchlist, [movie]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> loadWatchlistStatus(int? id) =>
      (super.noSuchMethod(Invocation.method(#loadWatchlistStatus, [id]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i8.Future<void>);
  @override
  _i8.StreamSubscription<_i7.MovieDetailState> listen(
          void Function(_i7.MovieDetailState)? onData,
          {Function? onError,
          void Function()? onDone,
          bool? cancelOnError}) =>
      (super.noSuchMethod(
              Invocation.method(#listen, [
                onData
              ], {
                #onError: onError,
                #onDone: onDone,
                #cancelOnError: cancelOnError
              }),
              returnValue: _FakeStreamSubscription_6<_i7.MovieDetailState>())
          as _i8.StreamSubscription<_i7.MovieDetailState>);
  @override
  void emit(_i7.MovieDetailState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i10.Change<_i7.MovieDetailState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  _i8.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i8.Future<void>);
  @override
  String toString() => super.toString();
}
