// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i1;

part 'impersonation.data.gql.g.dart';

abstract class GViewerImpersonationStateData
    implements
        Built<GViewerImpersonationStateData,
            GViewerImpersonationStateDataBuilder> {
  GViewerImpersonationStateData._();

  factory GViewerImpersonationStateData(
          [void Function(GViewerImpersonationStateDataBuilder b) updates]) =
      _$GViewerImpersonationStateData;

  static void _initializeBuilder(GViewerImpersonationStateDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GViewerImpersonationStateData_viewerImpersonationState
      get viewerImpersonationState;
  static Serializer<GViewerImpersonationStateData> get serializer =>
      _$gViewerImpersonationStateDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GViewerImpersonationStateData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GViewerImpersonationStateData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GViewerImpersonationStateData.serializer,
        json,
      );
}

abstract class GViewerImpersonationStateData_viewerImpersonationState
    implements
        Built<GViewerImpersonationStateData_viewerImpersonationState,
            GViewerImpersonationStateData_viewerImpersonationStateBuilder> {
  GViewerImpersonationStateData_viewerImpersonationState._();

  factory GViewerImpersonationStateData_viewerImpersonationState(
      [void Function(
              GViewerImpersonationStateData_viewerImpersonationStateBuilder b)
          updates]) = _$GViewerImpersonationStateData_viewerImpersonationState;

  static void _initializeBuilder(
          GViewerImpersonationStateData_viewerImpersonationStateBuilder b) =>
      b..G__typename = 'ImpersonationState';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get isImpersonating;
  GViewerImpersonationStateData_viewerImpersonationState_acting? get acting;
  GViewerImpersonationStateData_viewerImpersonationState_effective?
      get effective;
  static Serializer<GViewerImpersonationStateData_viewerImpersonationState>
      get serializer =>
          _$gViewerImpersonationStateDataViewerImpersonationStateSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GViewerImpersonationStateData_viewerImpersonationState.serializer,
        this,
      ) as Map<String, dynamic>);

  static GViewerImpersonationStateData_viewerImpersonationState? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GViewerImpersonationStateData_viewerImpersonationState.serializer,
        json,
      );
}

abstract class GViewerImpersonationStateData_viewerImpersonationState_acting
    implements
        Built<GViewerImpersonationStateData_viewerImpersonationState_acting,
            GViewerImpersonationStateData_viewerImpersonationState_actingBuilder> {
  GViewerImpersonationStateData_viewerImpersonationState_acting._();

  factory GViewerImpersonationStateData_viewerImpersonationState_acting(
          [void Function(
                  GViewerImpersonationStateData_viewerImpersonationState_actingBuilder
                      b)
              updates]) =
      _$GViewerImpersonationStateData_viewerImpersonationState_acting;

  static void _initializeBuilder(
          GViewerImpersonationStateData_viewerImpersonationState_actingBuilder
              b) =>
      b..G__typename = 'Principal';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get displayName;
  static Serializer<
          GViewerImpersonationStateData_viewerImpersonationState_acting>
      get serializer =>
          _$gViewerImpersonationStateDataViewerImpersonationStateActingSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GViewerImpersonationStateData_viewerImpersonationState_acting
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GViewerImpersonationStateData_viewerImpersonationState_acting?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GViewerImpersonationStateData_viewerImpersonationState_acting
                .serializer,
            json,
          );
}

abstract class GViewerImpersonationStateData_viewerImpersonationState_effective
    implements
        Built<GViewerImpersonationStateData_viewerImpersonationState_effective,
            GViewerImpersonationStateData_viewerImpersonationState_effectiveBuilder> {
  GViewerImpersonationStateData_viewerImpersonationState_effective._();

  factory GViewerImpersonationStateData_viewerImpersonationState_effective(
          [void Function(
                  GViewerImpersonationStateData_viewerImpersonationState_effectiveBuilder
                      b)
              updates]) =
      _$GViewerImpersonationStateData_viewerImpersonationState_effective;

  static void _initializeBuilder(
          GViewerImpersonationStateData_viewerImpersonationState_effectiveBuilder
              b) =>
      b..G__typename = 'Principal';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get displayName;
  static Serializer<
          GViewerImpersonationStateData_viewerImpersonationState_effective>
      get serializer =>
          _$gViewerImpersonationStateDataViewerImpersonationStateEffectiveSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GViewerImpersonationStateData_viewerImpersonationState_effective
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GViewerImpersonationStateData_viewerImpersonationState_effective?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GViewerImpersonationStateData_viewerImpersonationState_effective
                .serializer,
            json,
          );
}

abstract class GImpersonateData
    implements Built<GImpersonateData, GImpersonateDataBuilder> {
  GImpersonateData._();

  factory GImpersonateData([void Function(GImpersonateDataBuilder b) updates]) =
      _$GImpersonateData;

  static void _initializeBuilder(GImpersonateDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GImpersonateData_impersonate get impersonate;
  static Serializer<GImpersonateData> get serializer =>
      _$gImpersonateDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GImpersonateData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GImpersonateData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GImpersonateData.serializer,
        json,
      );
}

abstract class GImpersonateData_impersonate
    implements
        Built<GImpersonateData_impersonate,
            GImpersonateData_impersonateBuilder> {
  GImpersonateData_impersonate._();

  factory GImpersonateData_impersonate(
          [void Function(GImpersonateData_impersonateBuilder b) updates]) =
      _$GImpersonateData_impersonate;

  static void _initializeBuilder(GImpersonateData_impersonateBuilder b) =>
      b..G__typename = 'ImpersonationState';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get isImpersonating;
  GImpersonateData_impersonate_acting? get acting;
  GImpersonateData_impersonate_effective? get effective;
  static Serializer<GImpersonateData_impersonate> get serializer =>
      _$gImpersonateDataImpersonateSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GImpersonateData_impersonate.serializer,
        this,
      ) as Map<String, dynamic>);

  static GImpersonateData_impersonate? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GImpersonateData_impersonate.serializer,
        json,
      );
}

abstract class GImpersonateData_impersonate_acting
    implements
        Built<GImpersonateData_impersonate_acting,
            GImpersonateData_impersonate_actingBuilder> {
  GImpersonateData_impersonate_acting._();

  factory GImpersonateData_impersonate_acting(
      [void Function(GImpersonateData_impersonate_actingBuilder b)
          updates]) = _$GImpersonateData_impersonate_acting;

  static void _initializeBuilder(
          GImpersonateData_impersonate_actingBuilder b) =>
      b..G__typename = 'Principal';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get displayName;
  static Serializer<GImpersonateData_impersonate_acting> get serializer =>
      _$gImpersonateDataImpersonateActingSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GImpersonateData_impersonate_acting.serializer,
        this,
      ) as Map<String, dynamic>);

  static GImpersonateData_impersonate_acting? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GImpersonateData_impersonate_acting.serializer,
        json,
      );
}

abstract class GImpersonateData_impersonate_effective
    implements
        Built<GImpersonateData_impersonate_effective,
            GImpersonateData_impersonate_effectiveBuilder> {
  GImpersonateData_impersonate_effective._();

  factory GImpersonateData_impersonate_effective(
      [void Function(GImpersonateData_impersonate_effectiveBuilder b)
          updates]) = _$GImpersonateData_impersonate_effective;

  static void _initializeBuilder(
          GImpersonateData_impersonate_effectiveBuilder b) =>
      b..G__typename = 'Principal';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get displayName;
  static Serializer<GImpersonateData_impersonate_effective> get serializer =>
      _$gImpersonateDataImpersonateEffectiveSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GImpersonateData_impersonate_effective.serializer,
        this,
      ) as Map<String, dynamic>);

  static GImpersonateData_impersonate_effective? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GImpersonateData_impersonate_effective.serializer,
        json,
      );
}

abstract class GEndImpersonationData
    implements Built<GEndImpersonationData, GEndImpersonationDataBuilder> {
  GEndImpersonationData._();

  factory GEndImpersonationData(
          [void Function(GEndImpersonationDataBuilder b) updates]) =
      _$GEndImpersonationData;

  static void _initializeBuilder(GEndImpersonationDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GEndImpersonationData_endImpersonation get endImpersonation;
  static Serializer<GEndImpersonationData> get serializer =>
      _$gEndImpersonationDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEndImpersonationData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEndImpersonationData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEndImpersonationData.serializer,
        json,
      );
}

abstract class GEndImpersonationData_endImpersonation
    implements
        Built<GEndImpersonationData_endImpersonation,
            GEndImpersonationData_endImpersonationBuilder> {
  GEndImpersonationData_endImpersonation._();

  factory GEndImpersonationData_endImpersonation(
      [void Function(GEndImpersonationData_endImpersonationBuilder b)
          updates]) = _$GEndImpersonationData_endImpersonation;

  static void _initializeBuilder(
          GEndImpersonationData_endImpersonationBuilder b) =>
      b..G__typename = 'ImpersonationState';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get isImpersonating;
  GEndImpersonationData_endImpersonation_acting? get acting;
  GEndImpersonationData_endImpersonation_effective? get effective;
  static Serializer<GEndImpersonationData_endImpersonation> get serializer =>
      _$gEndImpersonationDataEndImpersonationSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEndImpersonationData_endImpersonation.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEndImpersonationData_endImpersonation? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEndImpersonationData_endImpersonation.serializer,
        json,
      );
}

abstract class GEndImpersonationData_endImpersonation_acting
    implements
        Built<GEndImpersonationData_endImpersonation_acting,
            GEndImpersonationData_endImpersonation_actingBuilder> {
  GEndImpersonationData_endImpersonation_acting._();

  factory GEndImpersonationData_endImpersonation_acting(
      [void Function(GEndImpersonationData_endImpersonation_actingBuilder b)
          updates]) = _$GEndImpersonationData_endImpersonation_acting;

  static void _initializeBuilder(
          GEndImpersonationData_endImpersonation_actingBuilder b) =>
      b..G__typename = 'Principal';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get displayName;
  static Serializer<GEndImpersonationData_endImpersonation_acting>
      get serializer => _$gEndImpersonationDataEndImpersonationActingSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEndImpersonationData_endImpersonation_acting.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEndImpersonationData_endImpersonation_acting? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEndImpersonationData_endImpersonation_acting.serializer,
        json,
      );
}

abstract class GEndImpersonationData_endImpersonation_effective
    implements
        Built<GEndImpersonationData_endImpersonation_effective,
            GEndImpersonationData_endImpersonation_effectiveBuilder> {
  GEndImpersonationData_endImpersonation_effective._();

  factory GEndImpersonationData_endImpersonation_effective(
      [void Function(GEndImpersonationData_endImpersonation_effectiveBuilder b)
          updates]) = _$GEndImpersonationData_endImpersonation_effective;

  static void _initializeBuilder(
          GEndImpersonationData_endImpersonation_effectiveBuilder b) =>
      b..G__typename = 'Principal';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get displayName;
  static Serializer<GEndImpersonationData_endImpersonation_effective>
      get serializer =>
          _$gEndImpersonationDataEndImpersonationEffectiveSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEndImpersonationData_endImpersonation_effective.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEndImpersonationData_endImpersonation_effective? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEndImpersonationData_endImpersonation_effective.serializer,
        json,
      );
}

abstract class GRegisterDeviceTokenData
    implements
        Built<GRegisterDeviceTokenData, GRegisterDeviceTokenDataBuilder> {
  GRegisterDeviceTokenData._();

  factory GRegisterDeviceTokenData(
          [void Function(GRegisterDeviceTokenDataBuilder b) updates]) =
      _$GRegisterDeviceTokenData;

  static void _initializeBuilder(GRegisterDeviceTokenDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get registerDeviceToken;
  static Serializer<GRegisterDeviceTokenData> get serializer =>
      _$gRegisterDeviceTokenDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRegisterDeviceTokenData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRegisterDeviceTokenData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRegisterDeviceTokenData.serializer,
        json,
      );
}

abstract class GUnregisterDeviceTokenData
    implements
        Built<GUnregisterDeviceTokenData, GUnregisterDeviceTokenDataBuilder> {
  GUnregisterDeviceTokenData._();

  factory GUnregisterDeviceTokenData(
          [void Function(GUnregisterDeviceTokenDataBuilder b) updates]) =
      _$GUnregisterDeviceTokenData;

  static void _initializeBuilder(GUnregisterDeviceTokenDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get unregisterDeviceToken;
  static Serializer<GUnregisterDeviceTokenData> get serializer =>
      _$gUnregisterDeviceTokenDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUnregisterDeviceTokenData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUnregisterDeviceTokenData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUnregisterDeviceTokenData.serializer,
        json,
      );
}
