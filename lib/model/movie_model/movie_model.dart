import 'package:freezed_annotation/freezed_annotation.dart';

import 'production_company.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
abstract class MovieModel with _$MovieModel {
  factory MovieModel({
    String? id,
    String? url,
    String? primaryTitle,
    String? originalTitle,
    String? type,
    String? description,
    String? primaryImage,
    String? trailer,
    String? contentRating,
    int? startYear,
    int? endYear,
    String? releaseDate,
    List<String>? interests,
    List<String>? countriesOfOrigin,
    List<String>? externalLinks,
    List<String>? spokenLanguages,
    List<String>? filmingLocations,
    List<ProductionCompany>? productionCompanies,
    dynamic budget,
    dynamic grossWorldwide,
    List<String>? genres,
    bool? isAdult,
    dynamic runtimeMinutes,
    double? averageRating,
    int? numVotes,
    dynamic metascore,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
}
