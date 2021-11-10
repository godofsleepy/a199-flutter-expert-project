import 'package:equatable/equatable.dart';

class EpisodeToAir extends Equatable {
  final String? airDate;
  final int? episodeNumber;
  final int? id;
  final String? name;
  final String? overview;
  final String? productionCode;
  final int? seasonNumber;

  final double? voteAverage;
  final int? voteCount;

  const EpisodeToAir({
    this.airDate,
    this.episodeNumber,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.seasonNumber,
    this.voteAverage,
    this.voteCount,
  });

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
      voteAverage,
      voteCount,
    ];
  }
}
