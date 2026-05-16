// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pulse/graphql/__generated__/schema.schema.gql.dart' as _i2;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i1;

part 'posts.var.gql.g.dart';

abstract class GPostsForTagVars
    implements Built<GPostsForTagVars, GPostsForTagVarsBuilder> {
  GPostsForTagVars._();

  factory GPostsForTagVars([void Function(GPostsForTagVarsBuilder b) updates]) =
      _$GPostsForTagVars;

  String get tagId;
  int? get first;
  static Serializer<GPostsForTagVars> get serializer =>
      _$gPostsForTagVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostsForTagVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostsForTagVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostsForTagVars.serializer,
        json,
      );
}

abstract class GPostDetailVars
    implements Built<GPostDetailVars, GPostDetailVarsBuilder> {
  GPostDetailVars._();

  factory GPostDetailVars([void Function(GPostDetailVarsBuilder b) updates]) =
      _$GPostDetailVars;

  String get id;
  static Serializer<GPostDetailVars> get serializer =>
      _$gPostDetailVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostDetailVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostDetailVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostDetailVars.serializer,
        json,
      );
}

abstract class GCreatePostVars
    implements Built<GCreatePostVars, GCreatePostVarsBuilder> {
  GCreatePostVars._();

  factory GCreatePostVars([void Function(GCreatePostVarsBuilder b) updates]) =
      _$GCreatePostVars;

  _i2.GCreatePostInput get input;
  static Serializer<GCreatePostVars> get serializer =>
      _$gCreatePostVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreatePostVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreatePostVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreatePostVars.serializer,
        json,
      );
}

abstract class GCreateCommentVars
    implements Built<GCreateCommentVars, GCreateCommentVarsBuilder> {
  GCreateCommentVars._();

  factory GCreateCommentVars(
          [void Function(GCreateCommentVarsBuilder b) updates]) =
      _$GCreateCommentVars;

  _i2.GCreateCommentInput get input;
  static Serializer<GCreateCommentVars> get serializer =>
      _$gCreateCommentVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateCommentVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateCommentVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateCommentVars.serializer,
        json,
      );
}

abstract class GMarkPostReadVars
    implements Built<GMarkPostReadVars, GMarkPostReadVarsBuilder> {
  GMarkPostReadVars._();

  factory GMarkPostReadVars(
          [void Function(GMarkPostReadVarsBuilder b) updates]) =
      _$GMarkPostReadVars;

  String get postId;
  _i2.GTime? get seenAt;
  static Serializer<GMarkPostReadVars> get serializer =>
      _$gMarkPostReadVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMarkPostReadVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkPostReadVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMarkPostReadVars.serializer,
        json,
      );
}

abstract class GReactToPostVars
    implements Built<GReactToPostVars, GReactToPostVarsBuilder> {
  GReactToPostVars._();

  factory GReactToPostVars([void Function(GReactToPostVarsBuilder b) updates]) =
      _$GReactToPostVars;

  String get postId;
  String get emoji;
  static Serializer<GReactToPostVars> get serializer =>
      _$gReactToPostVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReactToPostVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReactToPostVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReactToPostVars.serializer,
        json,
      );
}

abstract class GUnreactToPostVars
    implements Built<GUnreactToPostVars, GUnreactToPostVarsBuilder> {
  GUnreactToPostVars._();

  factory GUnreactToPostVars(
          [void Function(GUnreactToPostVarsBuilder b) updates]) =
      _$GUnreactToPostVars;

  String get postId;
  String get emoji;
  static Serializer<GUnreactToPostVars> get serializer =>
      _$gUnreactToPostVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUnreactToPostVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUnreactToPostVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUnreactToPostVars.serializer,
        json,
      );
}

abstract class GPostChangedVars
    implements Built<GPostChangedVars, GPostChangedVarsBuilder> {
  GPostChangedVars._();

  factory GPostChangedVars([void Function(GPostChangedVarsBuilder b) updates]) =
      _$GPostChangedVars;

  String get tagId;
  static Serializer<GPostChangedVars> get serializer =>
      _$gPostChangedVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostChangedVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostChangedVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostChangedVars.serializer,
        json,
      );
}

abstract class GSetTagFeedSettingsVars
    implements Built<GSetTagFeedSettingsVars, GSetTagFeedSettingsVarsBuilder> {
  GSetTagFeedSettingsVars._();

  factory GSetTagFeedSettingsVars(
          [void Function(GSetTagFeedSettingsVarsBuilder b) updates]) =
      _$GSetTagFeedSettingsVars;

  _i2.GSetTagFeedSettingsInput get input;
  static Serializer<GSetTagFeedSettingsVars> get serializer =>
      _$gSetTagFeedSettingsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSetTagFeedSettingsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSetTagFeedSettingsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSetTagFeedSettingsVars.serializer,
        json,
      );
}

abstract class GPostSummaryVars
    implements Built<GPostSummaryVars, GPostSummaryVarsBuilder> {
  GPostSummaryVars._();

  factory GPostSummaryVars([void Function(GPostSummaryVarsBuilder b) updates]) =
      _$GPostSummaryVars;

  static Serializer<GPostSummaryVars> get serializer =>
      _$gPostSummaryVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostSummaryVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostSummaryVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostSummaryVars.serializer,
        json,
      );
}

abstract class GCommentSummaryVars
    implements Built<GCommentSummaryVars, GCommentSummaryVarsBuilder> {
  GCommentSummaryVars._();

  factory GCommentSummaryVars(
          [void Function(GCommentSummaryVarsBuilder b) updates]) =
      _$GCommentSummaryVars;

  static Serializer<GCommentSummaryVars> get serializer =>
      _$gCommentSummaryVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCommentSummaryVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCommentSummaryVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCommentSummaryVars.serializer,
        json,
      );
}
