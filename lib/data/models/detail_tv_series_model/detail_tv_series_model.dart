import 'package:ditonton/data/models/genre_model.dart';
import 'package:equatable/equatable.dart';
import 'last_episode_to_air.dart';
import 'next_episode_to_air.dart';
import 'season.dart';

class DetailTvSeriesModel extends Equatable {
  final String? backdropPath;
  final List<int>? episodeRunTime;
  final String? firstAirDate;
  final List<GenreModel>? genres;
  final int? id;
  final String? lastAirDate;
  final LastEpisodeToAirModel? lastEpisodeToAir;
  final String? name;
  final NextEpisodeToAirModel? nextEpisodeToAir;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<SeasonModel>? seasons;
  final String? status;
  final String? tagline;
  final int? voteAverage;
  final int? voteCount;

  const DetailTvSeriesModel({
    this.backdropPath,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.id,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.seasons,
    this.status,
    this.tagline,
    this.voteAverage,
    this.voteCount,
  });

  factory DetailTvSeriesModel.fromJson(Map<String, dynamic> json) {
    return DetailTvSeriesModel(
      backdropPath: json['backdrop_path'] as String?,
      episodeRunTime: json['episode_run_time'] as List<int>?,
      firstAirDate: json['first_air_date'] as String?,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int?,
      lastAirDate: json['last_air_date'] as String?,
      lastEpisodeToAir: json['last_episode_to_air'] == null
          ? null
          : LastEpisodeToAirModel.fromJson(
              json['last_episode_to_air'] as Map<String, dynamic>),
      name: json['name'] as String?,
      nextEpisodeToAir: json['next_episode_to_air'] == null
          ? null
          : NextEpisodeToAirModel.fromJson(
              json['next_episode_to_air'] as Map<String, dynamic>),
      numberOfEpisodes: json['number_of_episodes'] as int?,
      numberOfSeasons: json['number_of_seasons'] as int?,
      originalLanguage: json['original_language'] as String?,
      originalName: json['original_name'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'] as String?,
      seasons: (json['seasons'] as List<dynamic>?)
          ?.map((e) => SeasonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      tagline: json['tagline'] as String?,
      voteAverage: json['vote_average'] as int?,
      voteCount: json['vote_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'backdrop_path': backdropPath,
        'episode_run_time': episodeRunTime,
        'first_air_date': firstAirDate,
        'genres': genres?.map((e) => e.toJson()).toList(),
        'id': id,
        'last_air_date': lastAirDate,
        'last_episode_to_air': lastEpisodeToAir?.toJson(),
        'name': name,
        'next_episode_to_air': nextEpisodeToAir?.toJson(),
        'number_of_episodes': numberOfEpisodes,
        'number_of_seasons': numberOfSeasons,
        'original_language': originalLanguage,
        'original_name': originalName,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'seasons': seasons?.map((e) => e.toJson()).toList(),
        'status': status,
        'tagline': tagline,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

  @override
  List<Object?> get props {
    return [
      backdropPath,
      episodeRunTime,
      firstAirDate,
      genres,
      id,
      lastAirDate,
      lastEpisodeToAir,
      name,
      nextEpisodeToAir,
      numberOfEpisodes,
      numberOfSeasons,
      originalLanguage,
      originalName,
      overview,
      popularity,
      posterPath,
      seasons,
      status,
      tagline,
      voteAverage,
      voteCount,
    ];
  }
}
