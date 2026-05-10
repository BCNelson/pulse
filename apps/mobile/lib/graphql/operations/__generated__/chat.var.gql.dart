// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pulse/graphql/__generated__/schema.schema.gql.dart' as _i2;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i1;

part 'chat.var.gql.g.dart';

abstract class GChatRoomDetailVars
    implements Built<GChatRoomDetailVars, GChatRoomDetailVarsBuilder> {
  GChatRoomDetailVars._();

  factory GChatRoomDetailVars(
          [void Function(GChatRoomDetailVarsBuilder b) updates]) =
      _$GChatRoomDetailVars;

  String get id;
  static Serializer<GChatRoomDetailVars> get serializer =>
      _$gChatRoomDetailVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatRoomDetailVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomDetailVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChatRoomDetailVars.serializer,
        json,
      );
}

abstract class GSendMessageVars
    implements Built<GSendMessageVars, GSendMessageVarsBuilder> {
  GSendMessageVars._();

  factory GSendMessageVars([void Function(GSendMessageVarsBuilder b) updates]) =
      _$GSendMessageVars;

  _i2.GSendMessageInput get input;
  static Serializer<GSendMessageVars> get serializer =>
      _$gSendMessageVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendMessageVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendMessageVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendMessageVars.serializer,
        json,
      );
}

abstract class GCreateChatRoomVars
    implements Built<GCreateChatRoomVars, GCreateChatRoomVarsBuilder> {
  GCreateChatRoomVars._();

  factory GCreateChatRoomVars(
          [void Function(GCreateChatRoomVarsBuilder b) updates]) =
      _$GCreateChatRoomVars;

  _i2.GCreateChatRoomInput get input;
  static Serializer<GCreateChatRoomVars> get serializer =>
      _$gCreateChatRoomVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateChatRoomVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateChatRoomVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateChatRoomVars.serializer,
        json,
      );
}

abstract class GMessageAddedVars
    implements Built<GMessageAddedVars, GMessageAddedVarsBuilder> {
  GMessageAddedVars._();

  factory GMessageAddedVars(
          [void Function(GMessageAddedVarsBuilder b) updates]) =
      _$GMessageAddedVars;

  String get roomId;
  static Serializer<GMessageAddedVars> get serializer =>
      _$gMessageAddedVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMessageAddedVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMessageAddedVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMessageAddedVars.serializer,
        json,
      );
}

abstract class GMessageSummaryVars
    implements Built<GMessageSummaryVars, GMessageSummaryVarsBuilder> {
  GMessageSummaryVars._();

  factory GMessageSummaryVars(
          [void Function(GMessageSummaryVarsBuilder b) updates]) =
      _$GMessageSummaryVars;

  static Serializer<GMessageSummaryVars> get serializer =>
      _$gMessageSummaryVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMessageSummaryVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMessageSummaryVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMessageSummaryVars.serializer,
        json,
      );
}

abstract class GChatRoomSummaryVars
    implements Built<GChatRoomSummaryVars, GChatRoomSummaryVarsBuilder> {
  GChatRoomSummaryVars._();

  factory GChatRoomSummaryVars(
          [void Function(GChatRoomSummaryVarsBuilder b) updates]) =
      _$GChatRoomSummaryVars;

  static Serializer<GChatRoomSummaryVars> get serializer =>
      _$gChatRoomSummaryVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatRoomSummaryVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomSummaryVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChatRoomSummaryVars.serializer,
        json,
      );
}
