import 'package:equatable/equatable.dart';

class EpisodeToAirModel extends Equatable {
  final String? airDate;
  final int? episodeNumber;
  final int? id;
  final String? name;
  final String? overview;
  final String? productionCode;
  final int? seasonNumber;
  final dynamic stillPath;
  final double? voteAverage;
  final int? voteCount;

  const EpisodeToAirModel({
    this.airDate,
    this.episodeNumber,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.seasonNumber,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
  });

  factory EpisodeToAirModel.fromJson(Map<String, dynamic> json) {
    return EpisodeToAirModel(
      airDate: json['air_date'] as String?,
      episodeNumber: json['episode_number'] as int?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      overview: json['overview'] as String?,
      productionCode: json['production_code'] as String?,
      seasonNumber: json['season_number'] as int?,
      stillPath: json['still_path'] as dynamic?,
      voteAverage: json['vote_average'] as double?,
      voteCount: json['vote_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'air_date': airDate,
        'episode_number': episodeNumber,
        'id': id,
        'name': name,
        'overview': overview,
        'production_code': productionCode,
        'season_number': seasonNumber,
        'still_path': stillPath,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

  @override
  List<Object?> get props {
    return [
      airDate,
      episodeNumber,
      id,
      name,
      overview,
      productionCode,
      seasonNumber,
      stillPath,
      voteAverage,
      voteCount,
    ];
  }
}
