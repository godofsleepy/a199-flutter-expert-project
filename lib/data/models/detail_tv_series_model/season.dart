import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  final String? airDate;
  final int? episodeCount;
  final int? id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;

  const SeasonModel({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        airDate: json['air_date'] as String?,
        episodeCount: json['episode_count'] as int?,
        id: json['id'] as int?,
        name: json['name'] as String?,
        overview: json['overview'] as String?,
        posterPath: json['poster_path'] as String?,
        seasonNumber: json['season_number'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'air_date': airDate,
        'episode_count': episodeCount,
        'id': id,
        'name': name,
        'overview': overview,
        'poster_path': posterPath,
        'season_number': seasonNumber,
      };

  @override
  List<Object?> get props {
    return [
      airDate,
      episodeCount,
      id,
      name,
      overview,
      posterPath,
      seasonNumber,
    ];
  }
}
