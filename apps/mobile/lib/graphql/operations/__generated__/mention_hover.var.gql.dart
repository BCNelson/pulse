// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i1;

part 'mention_hover.var.gql.g.dart';

abstract class GMentionHoverUserVars
    implements Built<GMentionHoverUserVars, GMentionHoverUserVarsBuilder> {
  GMentionHoverUserVars._();

  factory GMentionHoverUserVars(
          [void Function(GMentionHoverUserVarsBuilder b) updates]) =
      _$GMentionHoverUserVars;

  String get slug;
  static Serializer<GMentionHoverUserVars> get serializer =>
      _$gMentionHoverUserVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionHoverUserVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionHoverUserVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionHoverUserVars.serializer,
        json,
      );
}

abstract class GMentionHoverTagVars
    implements Built<GMentionHoverTagVars, GMentionHoverTagVarsBuilder> {
  GMentionHoverTagVars._();

  factory GMentionHoverTagVars(
          [void Function(GMentionHoverTagVarsBuilder b) updates]) =
      _$GMentionHoverTagVars;

  BuiltList<String> get path;
  static Serializer<GMentionHoverTagVars> get serializer =>
      _$gMentionHoverTagVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionHoverTagVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionHoverTagVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionHoverTagVars.serializer,
        json,
      );
}
