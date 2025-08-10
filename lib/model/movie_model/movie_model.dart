import 'package:freezed_annotation/freezed_annotation.dart';

import 'production_company.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
abstract class MovieModel with _$MovieModel {
  // Map'e dönüştürme
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': primaryTitle,
      'posterUrl': primaryImage,
      'description': description,
      'releaseDate': releaseDate,
    };
  }

  // Map'ten nesne oluşturma
  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id']?.toString(),
      primaryTitle: map['title'],
      primaryImage: map['posterUrl'],
      description: map['description'],
      releaseDate: map['releaseDate'],
    );
  }
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

extension MovieModelDatabase on MovieModel {
  Map<String, dynamic> toMapForDb() {
    return {
      'id': id,
      'title': primaryTitle,
      'imageUrl': primaryImage,
      'description': description,
      'genres': genres?.join(','),
    };
  }

  static MovieModel fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'],
      primaryTitle: map['title'],
      primaryImage: map['imageUrl'],
      description: map['description'],
      genres:
          map['genres'] != null ? (map['genres'] as String).split(',') : null,
    );
  }
}
