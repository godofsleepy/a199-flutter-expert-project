import 'package:ditonton/data/models/detail_tv_series_model/detail_tv_series_model.dart';
import 'package:ditonton/data/models/detail_tv_series_model/episode_to_air_model.dart';
import 'package:ditonton/data/models/detail_tv_series_model/season.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_model/movie_table.dart';
import 'package:ditonton/data/models/tv_series_model/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_model/tv_series_table.dart';
import 'package:ditonton/domain/entities/episode_to_air.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:intl/intl.dart';

final testMovieList = [testMovie];
final testTvSeriesList = [testTvSeries];
final testTvSeriesModelList = [testTvSeriesModel];

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testTvSeriesModel = TvSeriesModel(
  backdropPath: "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
  firstAirDate: "2021-10-12",
  genreIds: [10765, 35, 80],
  name: "Chucky",
  originCountry: ["US"],
  originalLanguage: "en",
  originalName: "Chucky",
  overview:
      "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
  voteAverage: 8,
  id: 90462,
  popularity: 5211.783,
  posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
  voteCount: 1797,
);

final testTvSeries = TvSeries(
  backdropPath: "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
  firstAirDate: "2021-10-12",
  genreIds: [10765, 35, 80],
  id: 90462,
  name: "Chucky",
  originCountry: ["US"],
  originalLanguage: "en",
  originalName: "Chucky",
  overview:
      "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
  popularity: 5211.783,
  posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
  voteAverage: 8,
  voteCount: 1797,
);

final testWatchlistTv = TvSeries.watchlist(
  id: 90462,
  posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
  name: "Chucky",
  overview:
      "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
);

final testTvSeriesTable = TvSeriesTable(
  id: 90462,
  name: "Chucky",
  overview:
      "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
  posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
);

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testTvSeriesDetailModel = DetailTvSeriesModel(
  backdropPath: "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
  genres: [GenreModel(id: 10765, name: 'Sci-Fi & Fantasy')],
  id: 90462,
  overview:
      "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
  posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
  firstAirDate: "2021-10-12",
  lastAirDate: "2021-11-09",
  lastEpisodeToAir: EpisodeToAirModel(
    airDate: "2021-11-09",
    episodeNumber: 5,
    id: 3256397,
    name: "Little Little Lies",
    overview: "",
    productionCode: "",
    seasonNumber: 1,
    voteAverage: 0.0,
    voteCount: 0,
  ),
  nextEpisodeToAir: EpisodeToAirModel(
    airDate: "2021-11-16",
    episodeNumber: 6,
    id: 3280228,
    name: "Episode 06",
    overview: "",
    productionCode: "",
    seasonNumber: 1,
    voteAverage: 0.0,
    voteCount: 0,
  ),
  seasons: [
    SeasonModel(
      airDate: "2021-10-12",
      episodeCount: 10,
      id: 126146,
      name: "Season 1",
      overview: "",
      posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
      seasonNumber: 1,
    ),
  ],
  name: "Chucky",
  voteAverage: 8.0,
  voteCount: 1812,
);

final testTvSeriesDetail = TvSeriesDetail(
  backdropPath: "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
  genres: [Genre(id: 10765, name: 'Sci-Fi & Fantasy')],
  id: 90462,
  overview:
      "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
  posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
  firstAirDate: DateFormat("yyyy-MM-dd").parse("2021-10-12"),
  lastAirDate: DateFormat("yyyy-MM-dd").parse("2021-11-09"),
  lastEpisodeToAir: EpisodeToAir(
    airDate: "2021-11-09",
    episodeNumber: 5,
    id: 3256397,
    name: "Little Little Lies",
    overview: "",
    productionCode: "",
    seasonNumber: 1,
    voteAverage: 0.0,
    voteCount: 0,
  ),
  nextEpisodeToAir: EpisodeToAir(
    airDate: "2021-11-16",
    episodeNumber: 6,
    id: 3280228,
    name: "Episode 06",
    overview: "",
    productionCode: "",
    seasonNumber: 1,
    voteAverage: 0.0,
    voteCount: 0,
  ),
  seasons: [
    Season(
      airDate: "2021-10-12",
      episodeCount: 10,
      id: 126146,
      name: "Season 1",
      overview: "",
      posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
      seasonNumber: 1,
    ),
  ],
  name: "Chucky",
  voteAverage: 8.0,
  voteCount: 1812,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};
