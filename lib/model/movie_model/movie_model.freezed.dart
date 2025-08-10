// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MovieModel {

 String? get id; String? get url; String? get primaryTitle; String? get originalTitle; String? get type; String? get description; String? get primaryImage; String? get trailer; String? get contentRating; int? get startYear; int? get endYear; String? get releaseDate; List<String>? get interests; List<String>? get countriesOfOrigin; List<String>? get externalLinks; List<String>? get spokenLanguages; List<String>? get filmingLocations; List<ProductionCompany>? get productionCompanies; dynamic get budget; dynamic get grossWorldwide; List<String>? get genres; bool? get isAdult; dynamic get runtimeMinutes; double? get averageRating; int? get numVotes; dynamic get metascore;
/// Create a copy of MovieModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovieModelCopyWith<MovieModel> get copyWith => _$MovieModelCopyWithImpl<MovieModel>(this as MovieModel, _$identity);

  /// Serializes this MovieModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieModel&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.primaryTitle, primaryTitle) || other.primaryTitle == primaryTitle)&&(identical(other.originalTitle, originalTitle) || other.originalTitle == originalTitle)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.primaryImage, primaryImage) || other.primaryImage == primaryImage)&&(identical(other.trailer, trailer) || other.trailer == trailer)&&(identical(other.contentRating, contentRating) || other.contentRating == contentRating)&&(identical(other.startYear, startYear) || other.startYear == startYear)&&(identical(other.endYear, endYear) || other.endYear == endYear)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate)&&const DeepCollectionEquality().equals(other.interests, interests)&&const DeepCollectionEquality().equals(other.countriesOfOrigin, countriesOfOrigin)&&const DeepCollectionEquality().equals(other.externalLinks, externalLinks)&&const DeepCollectionEquality().equals(other.spokenLanguages, spokenLanguages)&&const DeepCollectionEquality().equals(other.filmingLocations, filmingLocations)&&const DeepCollectionEquality().equals(other.productionCompanies, productionCompanies)&&const DeepCollectionEquality().equals(other.budget, budget)&&const DeepCollectionEquality().equals(other.grossWorldwide, grossWorldwide)&&const DeepCollectionEquality().equals(other.genres, genres)&&(identical(other.isAdult, isAdult) || other.isAdult == isAdult)&&const DeepCollectionEquality().equals(other.runtimeMinutes, runtimeMinutes)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.numVotes, numVotes) || other.numVotes == numVotes)&&const DeepCollectionEquality().equals(other.metascore, metascore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,url,primaryTitle,originalTitle,type,description,primaryImage,trailer,contentRating,startYear,endYear,releaseDate,const DeepCollectionEquality().hash(interests),const DeepCollectionEquality().hash(countriesOfOrigin),const DeepCollectionEquality().hash(externalLinks),const DeepCollectionEquality().hash(spokenLanguages),const DeepCollectionEquality().hash(filmingLocations),const DeepCollectionEquality().hash(productionCompanies),const DeepCollectionEquality().hash(budget),const DeepCollectionEquality().hash(grossWorldwide),const DeepCollectionEquality().hash(genres),isAdult,const DeepCollectionEquality().hash(runtimeMinutes),averageRating,numVotes,const DeepCollectionEquality().hash(metascore)]);

@override
String toString() {
  return 'MovieModel(id: $id, url: $url, primaryTitle: $primaryTitle, originalTitle: $originalTitle, type: $type, description: $description, primaryImage: $primaryImage, trailer: $trailer, contentRating: $contentRating, startYear: $startYear, endYear: $endYear, releaseDate: $releaseDate, interests: $interests, countriesOfOrigin: $countriesOfOrigin, externalLinks: $externalLinks, spokenLanguages: $spokenLanguages, filmingLocations: $filmingLocations, productionCompanies: $productionCompanies, budget: $budget, grossWorldwide: $grossWorldwide, genres: $genres, isAdult: $isAdult, runtimeMinutes: $runtimeMinutes, averageRating: $averageRating, numVotes: $numVotes, metascore: $metascore)';
}


}

/// @nodoc
abstract mixin class $MovieModelCopyWith<$Res>  {
  factory $MovieModelCopyWith(MovieModel value, $Res Function(MovieModel) _then) = _$MovieModelCopyWithImpl;
@useResult
$Res call({
 String? id, String? url, String? primaryTitle, String? originalTitle, String? type, String? description, String? primaryImage, String? trailer, String? contentRating, int? startYear, int? endYear, String? releaseDate, List<String>? interests, List<String>? countriesOfOrigin, List<String>? externalLinks, List<String>? spokenLanguages, List<String>? filmingLocations, List<ProductionCompany>? productionCompanies, dynamic budget, dynamic grossWorldwide, List<String>? genres, bool? isAdult, dynamic runtimeMinutes, double? averageRating, int? numVotes, dynamic metascore
});




}
/// @nodoc
class _$MovieModelCopyWithImpl<$Res>
    implements $MovieModelCopyWith<$Res> {
  _$MovieModelCopyWithImpl(this._self, this._then);

  final MovieModel _self;
  final $Res Function(MovieModel) _then;

/// Create a copy of MovieModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? url = freezed,Object? primaryTitle = freezed,Object? originalTitle = freezed,Object? type = freezed,Object? description = freezed,Object? primaryImage = freezed,Object? trailer = freezed,Object? contentRating = freezed,Object? startYear = freezed,Object? endYear = freezed,Object? releaseDate = freezed,Object? interests = freezed,Object? countriesOfOrigin = freezed,Object? externalLinks = freezed,Object? spokenLanguages = freezed,Object? filmingLocations = freezed,Object? productionCompanies = freezed,Object? budget = freezed,Object? grossWorldwide = freezed,Object? genres = freezed,Object? isAdult = freezed,Object? runtimeMinutes = freezed,Object? averageRating = freezed,Object? numVotes = freezed,Object? metascore = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,primaryTitle: freezed == primaryTitle ? _self.primaryTitle : primaryTitle // ignore: cast_nullable_to_non_nullable
as String?,originalTitle: freezed == originalTitle ? _self.originalTitle : originalTitle // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,primaryImage: freezed == primaryImage ? _self.primaryImage : primaryImage // ignore: cast_nullable_to_non_nullable
as String?,trailer: freezed == trailer ? _self.trailer : trailer // ignore: cast_nullable_to_non_nullable
as String?,contentRating: freezed == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as String?,startYear: freezed == startYear ? _self.startYear : startYear // ignore: cast_nullable_to_non_nullable
as int?,endYear: freezed == endYear ? _self.endYear : endYear // ignore: cast_nullable_to_non_nullable
as int?,releaseDate: freezed == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as String?,interests: freezed == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>?,countriesOfOrigin: freezed == countriesOfOrigin ? _self.countriesOfOrigin : countriesOfOrigin // ignore: cast_nullable_to_non_nullable
as List<String>?,externalLinks: freezed == externalLinks ? _self.externalLinks : externalLinks // ignore: cast_nullable_to_non_nullable
as List<String>?,spokenLanguages: freezed == spokenLanguages ? _self.spokenLanguages : spokenLanguages // ignore: cast_nullable_to_non_nullable
as List<String>?,filmingLocations: freezed == filmingLocations ? _self.filmingLocations : filmingLocations // ignore: cast_nullable_to_non_nullable
as List<String>?,productionCompanies: freezed == productionCompanies ? _self.productionCompanies : productionCompanies // ignore: cast_nullable_to_non_nullable
as List<ProductionCompany>?,budget: freezed == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as dynamic,grossWorldwide: freezed == grossWorldwide ? _self.grossWorldwide : grossWorldwide // ignore: cast_nullable_to_non_nullable
as dynamic,genres: freezed == genres ? _self.genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>?,isAdult: freezed == isAdult ? _self.isAdult : isAdult // ignore: cast_nullable_to_non_nullable
as bool?,runtimeMinutes: freezed == runtimeMinutes ? _self.runtimeMinutes : runtimeMinutes // ignore: cast_nullable_to_non_nullable
as dynamic,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,numVotes: freezed == numVotes ? _self.numVotes : numVotes // ignore: cast_nullable_to_non_nullable
as int?,metascore: freezed == metascore ? _self.metascore : metascore // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MovieModel implements MovieModel {
   _MovieModel({this.id, this.url, this.primaryTitle, this.originalTitle, this.type, this.description, this.primaryImage, this.trailer, this.contentRating, this.startYear, this.endYear, this.releaseDate, final  List<String>? interests, final  List<String>? countriesOfOrigin, final  List<String>? externalLinks, final  List<String>? spokenLanguages, final  List<String>? filmingLocations, final  List<ProductionCompany>? productionCompanies, this.budget, this.grossWorldwide, final  List<String>? genres, this.isAdult, this.runtimeMinutes, this.averageRating, this.numVotes, this.metascore}): _interests = interests,_countriesOfOrigin = countriesOfOrigin,_externalLinks = externalLinks,_spokenLanguages = spokenLanguages,_filmingLocations = filmingLocations,_productionCompanies = productionCompanies,_genres = genres;
  factory _MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);

@override final  String? id;
@override final  String? url;
@override final  String? primaryTitle;
@override final  String? originalTitle;
@override final  String? type;
@override final  String? description;
@override final  String? primaryImage;
@override final  String? trailer;
@override final  String? contentRating;
@override final  int? startYear;
@override final  int? endYear;
@override final  String? releaseDate;
 final  List<String>? _interests;
@override List<String>? get interests {
  final value = _interests;
  if (value == null) return null;
  if (_interests is EqualUnmodifiableListView) return _interests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _countriesOfOrigin;
@override List<String>? get countriesOfOrigin {
  final value = _countriesOfOrigin;
  if (value == null) return null;
  if (_countriesOfOrigin is EqualUnmodifiableListView) return _countriesOfOrigin;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _externalLinks;
@override List<String>? get externalLinks {
  final value = _externalLinks;
  if (value == null) return null;
  if (_externalLinks is EqualUnmodifiableListView) return _externalLinks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _spokenLanguages;
@override List<String>? get spokenLanguages {
  final value = _spokenLanguages;
  if (value == null) return null;
  if (_spokenLanguages is EqualUnmodifiableListView) return _spokenLanguages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _filmingLocations;
@override List<String>? get filmingLocations {
  final value = _filmingLocations;
  if (value == null) return null;
  if (_filmingLocations is EqualUnmodifiableListView) return _filmingLocations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<ProductionCompany>? _productionCompanies;
@override List<ProductionCompany>? get productionCompanies {
  final value = _productionCompanies;
  if (value == null) return null;
  if (_productionCompanies is EqualUnmodifiableListView) return _productionCompanies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  dynamic budget;
@override final  dynamic grossWorldwide;
 final  List<String>? _genres;
@override List<String>? get genres {
  final value = _genres;
  if (value == null) return null;
  if (_genres is EqualUnmodifiableListView) return _genres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  bool? isAdult;
@override final  dynamic runtimeMinutes;
@override final  double? averageRating;
@override final  int? numVotes;
@override final  dynamic metascore;

/// Create a copy of MovieModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MovieModelCopyWith<_MovieModel> get copyWith => __$MovieModelCopyWithImpl<_MovieModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MovieModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MovieModel&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.primaryTitle, primaryTitle) || other.primaryTitle == primaryTitle)&&(identical(other.originalTitle, originalTitle) || other.originalTitle == originalTitle)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.primaryImage, primaryImage) || other.primaryImage == primaryImage)&&(identical(other.trailer, trailer) || other.trailer == trailer)&&(identical(other.contentRating, contentRating) || other.contentRating == contentRating)&&(identical(other.startYear, startYear) || other.startYear == startYear)&&(identical(other.endYear, endYear) || other.endYear == endYear)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate)&&const DeepCollectionEquality().equals(other._interests, _interests)&&const DeepCollectionEquality().equals(other._countriesOfOrigin, _countriesOfOrigin)&&const DeepCollectionEquality().equals(other._externalLinks, _externalLinks)&&const DeepCollectionEquality().equals(other._spokenLanguages, _spokenLanguages)&&const DeepCollectionEquality().equals(other._filmingLocations, _filmingLocations)&&const DeepCollectionEquality().equals(other._productionCompanies, _productionCompanies)&&const DeepCollectionEquality().equals(other.budget, budget)&&const DeepCollectionEquality().equals(other.grossWorldwide, grossWorldwide)&&const DeepCollectionEquality().equals(other._genres, _genres)&&(identical(other.isAdult, isAdult) || other.isAdult == isAdult)&&const DeepCollectionEquality().equals(other.runtimeMinutes, runtimeMinutes)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.numVotes, numVotes) || other.numVotes == numVotes)&&const DeepCollectionEquality().equals(other.metascore, metascore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,url,primaryTitle,originalTitle,type,description,primaryImage,trailer,contentRating,startYear,endYear,releaseDate,const DeepCollectionEquality().hash(_interests),const DeepCollectionEquality().hash(_countriesOfOrigin),const DeepCollectionEquality().hash(_externalLinks),const DeepCollectionEquality().hash(_spokenLanguages),const DeepCollectionEquality().hash(_filmingLocations),const DeepCollectionEquality().hash(_productionCompanies),const DeepCollectionEquality().hash(budget),const DeepCollectionEquality().hash(grossWorldwide),const DeepCollectionEquality().hash(_genres),isAdult,const DeepCollectionEquality().hash(runtimeMinutes),averageRating,numVotes,const DeepCollectionEquality().hash(metascore)]);

@override
String toString() {
  return 'MovieModel(id: $id, url: $url, primaryTitle: $primaryTitle, originalTitle: $originalTitle, type: $type, description: $description, primaryImage: $primaryImage, trailer: $trailer, contentRating: $contentRating, startYear: $startYear, endYear: $endYear, releaseDate: $releaseDate, interests: $interests, countriesOfOrigin: $countriesOfOrigin, externalLinks: $externalLinks, spokenLanguages: $spokenLanguages, filmingLocations: $filmingLocations, productionCompanies: $productionCompanies, budget: $budget, grossWorldwide: $grossWorldwide, genres: $genres, isAdult: $isAdult, runtimeMinutes: $runtimeMinutes, averageRating: $averageRating, numVotes: $numVotes, metascore: $metascore)';
}

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': primaryTitle,
      'posterUrl': primaryImage,
      'description': description,
      'releaseDate': releaseDate,
    };
  }


}

/// @nodoc
abstract mixin class _$MovieModelCopyWith<$Res> implements $MovieModelCopyWith<$Res> {
  factory _$MovieModelCopyWith(_MovieModel value, $Res Function(_MovieModel) _then) = __$MovieModelCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? url, String? primaryTitle, String? originalTitle, String? type, String? description, String? primaryImage, String? trailer, String? contentRating, int? startYear, int? endYear, String? releaseDate, List<String>? interests, List<String>? countriesOfOrigin, List<String>? externalLinks, List<String>? spokenLanguages, List<String>? filmingLocations, List<ProductionCompany>? productionCompanies, dynamic budget, dynamic grossWorldwide, List<String>? genres, bool? isAdult, dynamic runtimeMinutes, double? averageRating, int? numVotes, dynamic metascore
});




}
/// @nodoc
class __$MovieModelCopyWithImpl<$Res>
    implements _$MovieModelCopyWith<$Res> {
  __$MovieModelCopyWithImpl(this._self, this._then);

  final _MovieModel _self;
  final $Res Function(_MovieModel) _then;

/// Create a copy of MovieModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? url = freezed,Object? primaryTitle = freezed,Object? originalTitle = freezed,Object? type = freezed,Object? description = freezed,Object? primaryImage = freezed,Object? trailer = freezed,Object? contentRating = freezed,Object? startYear = freezed,Object? endYear = freezed,Object? releaseDate = freezed,Object? interests = freezed,Object? countriesOfOrigin = freezed,Object? externalLinks = freezed,Object? spokenLanguages = freezed,Object? filmingLocations = freezed,Object? productionCompanies = freezed,Object? budget = freezed,Object? grossWorldwide = freezed,Object? genres = freezed,Object? isAdult = freezed,Object? runtimeMinutes = freezed,Object? averageRating = freezed,Object? numVotes = freezed,Object? metascore = freezed,}) {
  return _then(_MovieModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,primaryTitle: freezed == primaryTitle ? _self.primaryTitle : primaryTitle // ignore: cast_nullable_to_non_nullable
as String?,originalTitle: freezed == originalTitle ? _self.originalTitle : originalTitle // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,primaryImage: freezed == primaryImage ? _self.primaryImage : primaryImage // ignore: cast_nullable_to_non_nullable
as String?,trailer: freezed == trailer ? _self.trailer : trailer // ignore: cast_nullable_to_non_nullable
as String?,contentRating: freezed == contentRating ? _self.contentRating : contentRating // ignore: cast_nullable_to_non_nullable
as String?,startYear: freezed == startYear ? _self.startYear : startYear // ignore: cast_nullable_to_non_nullable
as int?,endYear: freezed == endYear ? _self.endYear : endYear // ignore: cast_nullable_to_non_nullable
as int?,releaseDate: freezed == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as String?,interests: freezed == interests ? _self._interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>?,countriesOfOrigin: freezed == countriesOfOrigin ? _self._countriesOfOrigin : countriesOfOrigin // ignore: cast_nullable_to_non_nullable
as List<String>?,externalLinks: freezed == externalLinks ? _self._externalLinks : externalLinks // ignore: cast_nullable_to_non_nullable
as List<String>?,spokenLanguages: freezed == spokenLanguages ? _self._spokenLanguages : spokenLanguages // ignore: cast_nullable_to_non_nullable
as List<String>?,filmingLocations: freezed == filmingLocations ? _self._filmingLocations : filmingLocations // ignore: cast_nullable_to_non_nullable
as List<String>?,productionCompanies: freezed == productionCompanies ? _self._productionCompanies : productionCompanies // ignore: cast_nullable_to_non_nullable
as List<ProductionCompany>?,budget: freezed == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as dynamic,grossWorldwide: freezed == grossWorldwide ? _self.grossWorldwide : grossWorldwide // ignore: cast_nullable_to_non_nullable
as dynamic,genres: freezed == genres ? _self._genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>?,isAdult: freezed == isAdult ? _self.isAdult : isAdult // ignore: cast_nullable_to_non_nullable
as bool?,runtimeMinutes: freezed == runtimeMinutes ? _self.runtimeMinutes : runtimeMinutes // ignore: cast_nullable_to_non_nullable
as dynamic,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,numVotes: freezed == numVotes ? _self.numVotes : numVotes // ignore: cast_nullable_to_non_nullable
as int?,metascore: freezed == metascore ? _self.metascore : metascore // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
