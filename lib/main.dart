import 'dart:async';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_series_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/now_playing_series_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/populer_series_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/search_series_page.dart';
import 'package:ditonton/presentation/pages/series_detail_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_series_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_series_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/now_playing_series_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/populer_series_notifier.dart';
import 'package:ditonton/presentation/provider/series_detail_notifier.dart';
import 'package:ditonton/presentation/provider/series_list_notifier.dart';
import 'package:ditonton/presentation/provider/series_search_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_series_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_series_notifier.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase.
  await Firebase.initializeApp();

  await di.init();
  runZonedGuarded<Future<void>>(() async {
    runApp(MyApp());
    // The following lines are the same as previously explained in "Handling uncaught errors"
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class MyApp extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.locator<MovieListCubit>()),
        BlocProvider(create: (context) => di.locator<MovieSearchCubit>()),
        BlocProvider(create: (context) => di.locator<SeriesListCubit>()),
        BlocProvider(create: (context) => di.locator<TopRatedMovieCubit>()),
        BlocProvider(create: (context) => di.locator<PopulerMoviesCubit>()),
        BlocProvider(create: (context) => di.locator<WatchListMovieCubit>()),
        BlocProvider(create: (context) => di.locator<WatchListSeriesCubit>()),
        BlocProvider(create: (context) => di.locator<PopulerSeriesCubit>()),
        BlocProvider(create: (context) => di.locator<TopRatedSeriesCubit>()),
        BlocProvider(create: (context) => di.locator<SeriesSearchCubit>()),
        BlocProvider(create: (context) => di.locator<NowPlayingSeriesCubit>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(
            secondary: kMikadoYellow,
          ),
        ),
        home: HomeMoviePage(),
        navigatorObservers: [
          routeObserver,
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case HomeSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => HomeSeriesPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case NowPlayingSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => NowPlayingSeriesPage());

            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => BlocProvider(
                    create: (context) => di.locator<MovieDetailCubit>(),
                    child: MovieDetailPage(id: id)),
                settings: settings,
              );
            case SeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => BlocProvider(
                    create: (context) => di.locator<SeriesDetailCubit>(),
                    child: SeriesDetailPage(id: id)),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SearchSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchSeriesPage());
            case PopularSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularSeriesPage());
            case TopRatedSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedSeriesPage());
            case WatchlistSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => WatchlistSeriesPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
