import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;
  TvSeriesTable({
    required this.id,
    this.name,
    this.posterPath,
    this.overview,
  });

  TvSeries toEntity() => TvSeries.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  factory TvSeriesTable.fromEntity(TvSeriesDetail data) => TvSeriesTable(
        id: data.id,
        name: data.name,
        posterPath: data.posterPath,
        overview: data.overview,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'posterPath': posterPath,
      'overview': overview,
    };
  }

  factory TvSeriesTable.fromJson(Map<String, dynamic> map) {
    return TvSeriesTable(
      id: map['id'],
      name: map['name'] != null ? map['name'] : null,
      posterPath: map['posterPath'] != null ? map['posterPath'] : null,
      overview: map['overview'] != null ? map['overview'] : null,
    );
  }

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}
