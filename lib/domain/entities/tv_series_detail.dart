import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/episode_to_air.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';

class TvSeriesDetail extends Equatable {
  TvSeriesDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.lastAirDate,
    this.numberOfEpisode,
    this.numberOfSeasons,
    required this.lastEpisodeToAir,
    required this.nextEpisodeToAir,
    required this.seasons,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String overview;
  final String posterPath;
  final DateTime? firstAirDate;
  final DateTime? lastAirDate;
  final int? numberOfEpisode;
  final int? numberOfSeasons;
  final EpisodeToAir? lastEpisodeToAir;
  final EpisodeToAir? nextEpisodeToAir;
  final List<Season> seasons;
  final String name;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props {
    return [
      backdropPath,
      genres,
      id,
      overview,
      posterPath,
      firstAirDate,
      lastAirDate,
      numberOfEpisode,
      numberOfSeasons,
      lastEpisodeToAir,
      nextEpisodeToAir,
      seasons,
      name,
      voteAverage,
      voteCount,
    ];
  }
}
