// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    as _i1;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i2;

part 'schema.schema.gql.g.dart';

abstract class GTime implements Built<GTime, GTimeBuilder> {
  GTime._();

  factory GTime([String? value]) =>
      _$GTime((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<GTime> get serializer => _i1.DefaultScalarSerializer<GTime>(
      (Object serialized) => GTime((serialized as String?)));
}

abstract class GJSON implements Built<GJSON, GJSONBuilder> {
  GJSON._();

  factory GJSON([String? value]) =>
      _$GJSON((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<GJSON> get serializer => _i1.DefaultScalarSerializer<GJSON>(
      (Object serialized) => GJSON((serialized as String?)));
}

class GTagRootKind extends EnumClass {
  const GTagRootKind._(String name) : super(name);

  static const GTagRootKind ORG = _$gTagRootKindORG;

  static const GTagRootKind USER = _$gTagRootKindUSER;

  static Serializer<GTagRootKind> get serializer => _$gTagRootKindSerializer;

  static BuiltSet<GTagRootKind> get values => _$gTagRootKindValues;

  static GTagRootKind valueOf(String name) => _$gTagRootKindValueOf(name);
}

class GPermissionBundle extends EnumClass {
  const GPermissionBundle._(String name) : super(name);

  static const GPermissionBundle VIEWER = _$gPermissionBundleVIEWER;

  static const GPermissionBundle CONTRIBUTOR = _$gPermissionBundleCONTRIBUTOR;

  static const GPermissionBundle MODERATOR = _$gPermissionBundleMODERATOR;

  static const GPermissionBundle OWNER = _$gPermissionBundleOWNER;

  static Serializer<GPermissionBundle> get serializer =>
      _$gPermissionBundleSerializer;

  static BuiltSet<GPermissionBundle> get values => _$gPermissionBundleValues;

  static GPermissionBundle valueOf(String name) =>
      _$gPermissionBundleValueOf(name);
}

class GSubscriptionUrgency extends EnumClass {
  const GSubscriptionUrgency._(String name) : super(name);

  static const GSubscriptionUrgency HIGH = _$gSubscriptionUrgencyHIGH;

  static const GSubscriptionUrgency NORMAL = _$gSubscriptionUrgencyNORMAL;

  static const GSubscriptionUrgency LOW = _$gSubscriptionUrgencyLOW;

  static const GSubscriptionUrgency MUTE = _$gSubscriptionUrgencyMUTE;

  static Serializer<GSubscriptionUrgency> get serializer =>
      _$gSubscriptionUrgencySerializer;

  static BuiltSet<GSubscriptionUrgency> get values =>
      _$gSubscriptionUrgencyValues;

  static GSubscriptionUrgency valueOf(String name) =>
      _$gSubscriptionUrgencyValueOf(name);
}

class GPrincipalKind extends EnumClass {
  const GPrincipalKind._(String name) : super(name);

  static const GPrincipalKind USER = _$gPrincipalKindUSER;

  static const GPrincipalKind BOT = _$gPrincipalKindBOT;

  static Serializer<GPrincipalKind> get serializer =>
      _$gPrincipalKindSerializer;

  static BuiltSet<GPrincipalKind> get values => _$gPrincipalKindValues;

  static GPrincipalKind valueOf(String name) => _$gPrincipalKindValueOf(name);
}

class GPrincipalStatus extends EnumClass {
  const GPrincipalStatus._(String name) : super(name);

  static const GPrincipalStatus ACTIVE = _$gPrincipalStatusACTIVE;

  static const GPrincipalStatus TOMBSTONED = _$gPrincipalStatusTOMBSTONED;

  static Serializer<GPrincipalStatus> get serializer =>
      _$gPrincipalStatusSerializer;

  static BuiltSet<GPrincipalStatus> get values => _$gPrincipalStatusValues;

  static GPrincipalStatus valueOf(String name) =>
      _$gPrincipalStatusValueOf(name);
}

abstract class GCreateTagInput
    implements Built<GCreateTagInput, GCreateTagInputBuilder> {
  GCreateTagInput._();

  factory GCreateTagInput([void Function(GCreateTagInputBuilder b) updates]) =
      _$GCreateTagInput;

  String get parentId;
  String get slug;
  String get displayName;
  GJSON? get defaults;
  static Serializer<GCreateTagInput> get serializer =>
      _$gCreateTagInputSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GCreateTagInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateTagInput? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GCreateTagInput.serializer,
        json,
      );
}

abstract class GGrantTagInput
    implements Built<GGrantTagInput, GGrantTagInputBuilder> {
  GGrantTagInput._();

  factory GGrantTagInput([void Function(GGrantTagInputBuilder b) updates]) =
      _$GGrantTagInput;

  String get tagId;
  String get principalId;
  GPermissionBundle get bundle;
  BuiltList<String>? get extras;
  bool? get cascade;
  static Serializer<GGrantTagInput> get serializer =>
      _$gGrantTagInputSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GGrantTagInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGrantTagInput? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GGrantTagInput.serializer,
        json,
      );
}

abstract class GSubscribeTagInput
    implements Built<GSubscribeTagInput, GSubscribeTagInputBuilder> {
  GSubscribeTagInput._();

  factory GSubscribeTagInput(
          [void Function(GSubscribeTagInputBuilder b) updates]) =
      _$GSubscribeTagInput;

  String get tagId;
  bool? get cascade;
  GSubscriptionUrgency? get urgency;
  BuiltList<String>? get reasonFilter;
  static Serializer<GSubscribeTagInput> get serializer =>
      _$gSubscribeTagInputSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GSubscribeTagInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSubscribeTagInput? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GSubscribeTagInput.serializer,
        json,
      );
}

const Map<String, Set<String>> possibleTypesMap = {
  'Principal': {
    'User',
    'Bot',
  }
};
