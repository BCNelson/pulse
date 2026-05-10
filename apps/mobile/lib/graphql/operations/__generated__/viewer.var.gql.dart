// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i1;

part 'viewer.var.gql.g.dart';

abstract class GViewerVars implements Built<GViewerVars, GViewerVarsBuilder> {
  GViewerVars._();

  factory GViewerVars([void Function(GViewerVarsBuilder b) updates]) =
      _$GViewerVars;

  static Serializer<GViewerVars> get serializer => _$gViewerVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GViewerVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GViewerVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GViewerVars.serializer,
        json,
      );
}
