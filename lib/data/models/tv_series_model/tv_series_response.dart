import 'package:equatable/equatable.dart';

import 'tv_series_model.dart';

class TvSeriesResponse extends Equatable {
  final int? page;
  final List<TvSeriesModel>? results;
  final int? totalPages;
  final int? totalResults;

  const TvSeriesResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) {
    return TvSeriesResponse(
      page: json['page'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => TvSeriesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int?,
      totalResults: json['total_results'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'page': page,
        'results': results?.map((e) => e.toJson()).toList(),
        'total_pages': totalPages,
        'total_results': totalResults,
      };

  @override
  List<Object?> get props => [page, results, totalPages, totalResults];
}
