// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i1;

part 'search.var.gql.g.dart';

abstract class GSearchVars implements Built<GSearchVars, GSearchVarsBuilder> {
  GSearchVars._();

  factory GSearchVars([void Function(GSearchVarsBuilder b) updates]) =
      _$GSearchVars;

  String get query;
  int? get first;
  static Serializer<GSearchVars> get serializer => _$gSearchVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchVars.serializer,
        json,
      );
}

abstract class GSearchTagsVars
    implements Built<GSearchTagsVars, GSearchTagsVarsBuilder> {
  GSearchTagsVars._();

  factory GSearchTagsVars([void Function(GSearchTagsVarsBuilder b) updates]) =
      _$GSearchTagsVars;

  String get query;
  int? get first;
  static Serializer<GSearchTagsVars> get serializer =>
      _$gSearchTagsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchTagsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchTagsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchTagsVars.serializer,
        json,
      );
}

abstract class GSearchUsersVars
    implements Built<GSearchUsersVars, GSearchUsersVarsBuilder> {
  GSearchUsersVars._();

  factory GSearchUsersVars([void Function(GSearchUsersVarsBuilder b) updates]) =
      _$GSearchUsersVars;

  String get query;
  int? get first;
  static Serializer<GSearchUsersVars> get serializer =>
      _$gSearchUsersVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchUsersVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchUsersVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchUsersVars.serializer,
        json,
      );
}
