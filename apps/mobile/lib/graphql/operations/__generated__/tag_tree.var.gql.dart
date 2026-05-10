// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i1;

part 'tag_tree.var.gql.g.dart';

abstract class GTagTreeVars
    implements Built<GTagTreeVars, GTagTreeVarsBuilder> {
  GTagTreeVars._();

  factory GTagTreeVars([void Function(GTagTreeVarsBuilder b) updates]) =
      _$GTagTreeVars;

  static Serializer<GTagTreeVars> get serializer => _$gTagTreeVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTagTreeVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTagTreeVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTagTreeVars.serializer,
        json,
      );
}

abstract class GTagChildrenVars
    implements Built<GTagChildrenVars, GTagChildrenVarsBuilder> {
  GTagChildrenVars._();

  factory GTagChildrenVars([void Function(GTagChildrenVarsBuilder b) updates]) =
      _$GTagChildrenVars;

  String get id;
  static Serializer<GTagChildrenVars> get serializer =>
      _$gTagChildrenVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTagChildrenVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTagChildrenVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTagChildrenVars.serializer,
        json,
      );
}

abstract class GTagSummaryVars
    implements Built<GTagSummaryVars, GTagSummaryVarsBuilder> {
  GTagSummaryVars._();

  factory GTagSummaryVars([void Function(GTagSummaryVarsBuilder b) updates]) =
      _$GTagSummaryVars;

  static Serializer<GTagSummaryVars> get serializer =>
      _$gTagSummaryVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTagSummaryVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTagSummaryVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTagSummaryVars.serializer,
        json,
      );
}
