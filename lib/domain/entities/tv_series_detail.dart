import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';

class TvSeriesDetail extends Equatable {
  TvSeriesDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.lastAirDate,
    required this.tagline,
    required this.seasons,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final DateTime firstAirDate;
  final DateTime lastAirDate;
  final String tagline;
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
      originalTitle,
      overview,
      posterPath,
      firstAirDate,
      lastAirDate,
      tagline,
      seasons,
      name,
      voteAverage,
      voteCount,
    ];
  }
}
