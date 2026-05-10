// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pulse/graphql/__generated__/schema.schema.gql.dart' as _i2;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i1;

part 'impersonation.var.gql.g.dart';

abstract class GViewerImpersonationStateVars
    implements
        Built<GViewerImpersonationStateVars,
            GViewerImpersonationStateVarsBuilder> {
  GViewerImpersonationStateVars._();

  factory GViewerImpersonationStateVars(
          [void Function(GViewerImpersonationStateVarsBuilder b) updates]) =
      _$GViewerImpersonationStateVars;

  static Serializer<GViewerImpersonationStateVars> get serializer =>
      _$gViewerImpersonationStateVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GViewerImpersonationStateVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GViewerImpersonationStateVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GViewerImpersonationStateVars.serializer,
        json,
      );
}

abstract class GImpersonateVars
    implements Built<GImpersonateVars, GImpersonateVarsBuilder> {
  GImpersonateVars._();

  factory GImpersonateVars([void Function(GImpersonateVarsBuilder b) updates]) =
      _$GImpersonateVars;

  String get principalId;
  String get reason;
  static Serializer<GImpersonateVars> get serializer =>
      _$gImpersonateVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GImpersonateVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GImpersonateVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GImpersonateVars.serializer,
        json,
      );
}

abstract class GEndImpersonationVars
    implements Built<GEndImpersonationVars, GEndImpersonationVarsBuilder> {
  GEndImpersonationVars._();

  factory GEndImpersonationVars(
          [void Function(GEndImpersonationVarsBuilder b) updates]) =
      _$GEndImpersonationVars;

  static Serializer<GEndImpersonationVars> get serializer =>
      _$gEndImpersonationVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GEndImpersonationVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEndImpersonationVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GEndImpersonationVars.serializer,
        json,
      );
}

abstract class GRegisterDeviceTokenVars
    implements
        Built<GRegisterDeviceTokenVars, GRegisterDeviceTokenVarsBuilder> {
  GRegisterDeviceTokenVars._();

  factory GRegisterDeviceTokenVars(
          [void Function(GRegisterDeviceTokenVarsBuilder b) updates]) =
      _$GRegisterDeviceTokenVars;

  String get token;
  _i2.GDevicePlatform get platform;
  static Serializer<GRegisterDeviceTokenVars> get serializer =>
      _$gRegisterDeviceTokenVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRegisterDeviceTokenVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRegisterDeviceTokenVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRegisterDeviceTokenVars.serializer,
        json,
      );
}

abstract class GUnregisterDeviceTokenVars
    implements
        Built<GUnregisterDeviceTokenVars, GUnregisterDeviceTokenVarsBuilder> {
  GUnregisterDeviceTokenVars._();

  factory GUnregisterDeviceTokenVars(
          [void Function(GUnregisterDeviceTokenVarsBuilder b) updates]) =
      _$GUnregisterDeviceTokenVars;

  String get token;
  static Serializer<GUnregisterDeviceTokenVars> get serializer =>
      _$gUnregisterDeviceTokenVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUnregisterDeviceTokenVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUnregisterDeviceTokenVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUnregisterDeviceTokenVars.serializer,
        json,
      );
}
