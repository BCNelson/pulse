// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i1;

part 'mention_preview.var.gql.g.dart';

abstract class GMentionPreviewUserVars
    implements Built<GMentionPreviewUserVars, GMentionPreviewUserVarsBuilder> {
  GMentionPreviewUserVars._();

  factory GMentionPreviewUserVars(
          [void Function(GMentionPreviewUserVarsBuilder b) updates]) =
      _$GMentionPreviewUserVars;

  String get slug;
  int? get first;
  static Serializer<GMentionPreviewUserVars> get serializer =>
      _$gMentionPreviewUserVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionPreviewUserVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionPreviewUserVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionPreviewUserVars.serializer,
        json,
      );
}

abstract class GMentionPreviewTagVars
    implements Built<GMentionPreviewTagVars, GMentionPreviewTagVarsBuilder> {
  GMentionPreviewTagVars._();

  factory GMentionPreviewTagVars(
          [void Function(GMentionPreviewTagVarsBuilder b) updates]) =
      _$GMentionPreviewTagVars;

  BuiltList<String> get path;
  int? get first;
  static Serializer<GMentionPreviewTagVars> get serializer =>
      _$gMentionPreviewTagVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionPreviewTagVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionPreviewTagVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionPreviewTagVars.serializer,
        json,
      );
}

abstract class GMentionPreviewPostVars
    implements Built<GMentionPreviewPostVars, GMentionPreviewPostVarsBuilder> {
  GMentionPreviewPostVars._();

  factory GMentionPreviewPostVars(
          [void Function(GMentionPreviewPostVarsBuilder b) updates]) =
      _$GMentionPreviewPostVars;

  static Serializer<GMentionPreviewPostVars> get serializer =>
      _$gMentionPreviewPostVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionPreviewPostVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionPreviewPostVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionPreviewPostVars.serializer,
        json,
      );
}
