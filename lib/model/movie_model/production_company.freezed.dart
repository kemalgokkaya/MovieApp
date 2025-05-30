// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'production_company.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductionCompany {

 String? get id; String? get name;
/// Create a copy of ProductionCompany
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductionCompanyCopyWith<ProductionCompany> get copyWith => _$ProductionCompanyCopyWithImpl<ProductionCompany>(this as ProductionCompany, _$identity);

  /// Serializes this ProductionCompany to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductionCompany&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'ProductionCompany(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $ProductionCompanyCopyWith<$Res>  {
  factory $ProductionCompanyCopyWith(ProductionCompany value, $Res Function(ProductionCompany) _then) = _$ProductionCompanyCopyWithImpl;
@useResult
$Res call({
 String? id, String? name
});




}
/// @nodoc
class _$ProductionCompanyCopyWithImpl<$Res>
    implements $ProductionCompanyCopyWith<$Res> {
  _$ProductionCompanyCopyWithImpl(this._self, this._then);

  final ProductionCompany _self;
  final $Res Function(ProductionCompany) _then;

/// Create a copy of ProductionCompany
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ProductionCompany implements ProductionCompany {
   _ProductionCompany({this.id, this.name});
  factory _ProductionCompany.fromJson(Map<String, dynamic> json) => _$ProductionCompanyFromJson(json);

@override final  String? id;
@override final  String? name;

/// Create a copy of ProductionCompany
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductionCompanyCopyWith<_ProductionCompany> get copyWith => __$ProductionCompanyCopyWithImpl<_ProductionCompany>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductionCompanyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductionCompany&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'ProductionCompany(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$ProductionCompanyCopyWith<$Res> implements $ProductionCompanyCopyWith<$Res> {
  factory _$ProductionCompanyCopyWith(_ProductionCompany value, $Res Function(_ProductionCompany) _then) = __$ProductionCompanyCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? name
});




}
/// @nodoc
class __$ProductionCompanyCopyWithImpl<$Res>
    implements _$ProductionCompanyCopyWith<$Res> {
  __$ProductionCompanyCopyWithImpl(this._self, this._then);

  final _ProductionCompany _self;
  final $Res Function(_ProductionCompany) _then;

/// Create a copy of ProductionCompany
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,}) {
  return _then(_ProductionCompany(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
