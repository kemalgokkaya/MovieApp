import 'package:freezed_annotation/freezed_annotation.dart';

part 'production_company.freezed.dart';
part 'production_company.g.dart';

@freezed
abstract class ProductionCompany with _$ProductionCompany {
  factory ProductionCompany({String? id, String? name}) = _ProductionCompany;

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyFromJson(json);
}
