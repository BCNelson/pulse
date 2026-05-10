// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i1;

part 'health.var.gql.g.dart';

abstract class GHealthVars implements Built<GHealthVars, GHealthVarsBuilder> {
  GHealthVars._();

  factory GHealthVars([void Function(GHealthVarsBuilder b) updates]) =
      _$GHealthVars;

  static Serializer<GHealthVars> get serializer => _$gHealthVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GHealthVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GHealthVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GHealthVars.serializer,
        json,
      );
}
