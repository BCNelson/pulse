// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i1;

part 'notifications.var.gql.g.dart';

abstract class GNotificationsInboxVars
    implements Built<GNotificationsInboxVars, GNotificationsInboxVarsBuilder> {
  GNotificationsInboxVars._();

  factory GNotificationsInboxVars(
          [void Function(GNotificationsInboxVarsBuilder b) updates]) =
      _$GNotificationsInboxVars;

  int? get first;
  bool? get unreadOnly;
  static Serializer<GNotificationsInboxVars> get serializer =>
      _$gNotificationsInboxVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationsInboxVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationsInboxVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationsInboxVars.serializer,
        json,
      );
}

abstract class GMarkNotificationReadVars
    implements
        Built<GMarkNotificationReadVars, GMarkNotificationReadVarsBuilder> {
  GMarkNotificationReadVars._();

  factory GMarkNotificationReadVars(
          [void Function(GMarkNotificationReadVarsBuilder b) updates]) =
      _$GMarkNotificationReadVars;

  BuiltList<String> get ids;
  static Serializer<GMarkNotificationReadVars> get serializer =>
      _$gMarkNotificationReadVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMarkNotificationReadVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkNotificationReadVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMarkNotificationReadVars.serializer,
        json,
      );
}

abstract class GMarkAllNotificationsReadVars
    implements
        Built<GMarkAllNotificationsReadVars,
            GMarkAllNotificationsReadVarsBuilder> {
  GMarkAllNotificationsReadVars._();

  factory GMarkAllNotificationsReadVars(
          [void Function(GMarkAllNotificationsReadVarsBuilder b) updates]) =
      _$GMarkAllNotificationsReadVars;

  static Serializer<GMarkAllNotificationsReadVars> get serializer =>
      _$gMarkAllNotificationsReadVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMarkAllNotificationsReadVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkAllNotificationsReadVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMarkAllNotificationsReadVars.serializer,
        json,
      );
}

abstract class GNotificationReceivedVars
    implements
        Built<GNotificationReceivedVars, GNotificationReceivedVarsBuilder> {
  GNotificationReceivedVars._();

  factory GNotificationReceivedVars(
          [void Function(GNotificationReceivedVarsBuilder b) updates]) =
      _$GNotificationReceivedVars;

  static Serializer<GNotificationReceivedVars> get serializer =>
      _$gNotificationReceivedVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationReceivedVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationReceivedVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationReceivedVars.serializer,
        json,
      );
}

abstract class GNotificationSummaryVars
    implements
        Built<GNotificationSummaryVars, GNotificationSummaryVarsBuilder> {
  GNotificationSummaryVars._();

  factory GNotificationSummaryVars(
          [void Function(GNotificationSummaryVarsBuilder b) updates]) =
      _$GNotificationSummaryVars;

  static Serializer<GNotificationSummaryVars> get serializer =>
      _$gNotificationSummaryVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationSummaryVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationSummaryVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationSummaryVars.serializer,
        json,
      );
}
