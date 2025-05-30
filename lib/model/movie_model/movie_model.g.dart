// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => _MovieModel(
  id: json['id'] as String?,
  url: json['url'] as String?,
  primaryTitle: json['primaryTitle'] as String?,
  originalTitle: json['originalTitle'] as String?,
  type: json['type'] as String?,
  description: json['description'] as String?,
  primaryImage: json['primaryImage'] as String?,
  trailer: json['trailer'] as String?,
  contentRating: json['contentRating'] as String?,
  startYear: (json['startYear'] as num?)?.toInt(),
  endYear: (json['endYear'] as num?)?.toInt(),
  releaseDate: json['releaseDate'] as String?,
  interests:
      (json['interests'] as List<dynamic>?)?.map((e) => e as String).toList(),
  countriesOfOrigin:
      (json['countriesOfOrigin'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  externalLinks:
      (json['externalLinks'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  spokenLanguages:
      (json['spokenLanguages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  filmingLocations:
      (json['filmingLocations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  productionCompanies:
      (json['productionCompanies'] as List<dynamic>?)
          ?.map((e) => ProductionCompany.fromJson(e as Map<String, dynamic>))
          .toList(),
  budget: json['budget'],
  grossWorldwide: json['grossWorldwide'],
  genres: (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
  isAdult: json['isAdult'] as bool?,
  runtimeMinutes: json['runtimeMinutes'],
  averageRating: (json['averageRating'] as num?)?.toDouble(),
  numVotes: (json['numVotes'] as num?)?.toInt(),
  metascore: json['metascore'],
);

Map<String, dynamic> _$MovieModelToJson(_MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'primaryTitle': instance.primaryTitle,
      'originalTitle': instance.originalTitle,
      'type': instance.type,
      'description': instance.description,
      'primaryImage': instance.primaryImage,
      'trailer': instance.trailer,
      'contentRating': instance.contentRating,
      'startYear': instance.startYear,
      'endYear': instance.endYear,
      'releaseDate': instance.releaseDate,
      'interests': instance.interests,
      'countriesOfOrigin': instance.countriesOfOrigin,
      'externalLinks': instance.externalLinks,
      'spokenLanguages': instance.spokenLanguages,
      'filmingLocations': instance.filmingLocations,
      'productionCompanies': instance.productionCompanies,
      'budget': instance.budget,
      'grossWorldwide': instance.grossWorldwide,
      'genres': instance.genres,
      'isAdult': instance.isAdult,
      'runtimeMinutes': instance.runtimeMinutes,
      'averageRating': instance.averageRating,
      'numVotes': instance.numVotes,
      'metascore': instance.metascore,
    };
