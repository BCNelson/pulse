// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:pulse/graphql/operations/__generated__/impersonation.ast.gql.dart'
    as _i5;
import 'package:pulse/graphql/operations/__generated__/impersonation.data.gql.dart'
    as _i2;
import 'package:pulse/graphql/operations/__generated__/impersonation.var.gql.dart'
    as _i3;

part 'impersonation.req.gql.g.dart';

abstract class GViewerImpersonationStateReq
    implements
        Built<GViewerImpersonationStateReq,
            GViewerImpersonationStateReqBuilder>,
        _i1.OperationRequest<_i2.GViewerImpersonationStateData,
            _i3.GViewerImpersonationStateVars> {
  GViewerImpersonationStateReq._();

  factory GViewerImpersonationStateReq(
          [void Function(GViewerImpersonationStateReqBuilder b) updates]) =
      _$GViewerImpersonationStateReq;

  static void _initializeBuilder(GViewerImpersonationStateReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'ViewerImpersonationState',
    )
    ..executeOnListen = true;

  @override
  _i3.GViewerImpersonationStateVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GViewerImpersonationStateData? Function(
    _i2.GViewerImpersonationStateData?,
    _i2.GViewerImpersonationStateData?,
  )? get updateResult;
  @override
  _i2.GViewerImpersonationStateData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GViewerImpersonationStateData? parseData(Map<String, dynamic> json) =>
      _i2.GViewerImpersonationStateData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GViewerImpersonationStateData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GViewerImpersonationStateData,
      _i3.GViewerImpersonationStateVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GViewerImpersonationStateReq> get serializer =>
      _$gViewerImpersonationStateReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GViewerImpersonationStateReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GViewerImpersonationStateReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GViewerImpersonationStateReq.serializer,
        json,
      );
}

abstract class GImpersonateReq
    implements
        Built<GImpersonateReq, GImpersonateReqBuilder>,
        _i1.OperationRequest<_i2.GImpersonateData, _i3.GImpersonateVars> {
  GImpersonateReq._();

  factory GImpersonateReq([void Function(GImpersonateReqBuilder b) updates]) =
      _$GImpersonateReq;

  static void _initializeBuilder(GImpersonateReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'Impersonate',
    )
    ..executeOnListen = true;

  @override
  _i3.GImpersonateVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GImpersonateData? Function(
    _i2.GImpersonateData?,
    _i2.GImpersonateData?,
  )? get updateResult;
  @override
  _i2.GImpersonateData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GImpersonateData? parseData(Map<String, dynamic> json) =>
      _i2.GImpersonateData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GImpersonateData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GImpersonateData, _i3.GImpersonateVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GImpersonateReq> get serializer =>
      _$gImpersonateReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GImpersonateReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GImpersonateReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GImpersonateReq.serializer,
        json,
      );
}

abstract class GEndImpersonationReq
    implements
        Built<GEndImpersonationReq, GEndImpersonationReqBuilder>,
        _i1.OperationRequest<_i2.GEndImpersonationData,
            _i3.GEndImpersonationVars> {
  GEndImpersonationReq._();

  factory GEndImpersonationReq(
          [void Function(GEndImpersonationReqBuilder b) updates]) =
      _$GEndImpersonationReq;

  static void _initializeBuilder(GEndImpersonationReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'EndImpersonation',
    )
    ..executeOnListen = true;

  @override
  _i3.GEndImpersonationVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GEndImpersonationData? Function(
    _i2.GEndImpersonationData?,
    _i2.GEndImpersonationData?,
  )? get updateResult;
  @override
  _i2.GEndImpersonationData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GEndImpersonationData? parseData(Map<String, dynamic> json) =>
      _i2.GEndImpersonationData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GEndImpersonationData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GEndImpersonationData, _i3.GEndImpersonationVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GEndImpersonationReq> get serializer =>
      _$gEndImpersonationReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GEndImpersonationReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEndImpersonationReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GEndImpersonationReq.serializer,
        json,
      );
}

abstract class GRegisterDeviceTokenReq
    implements
        Built<GRegisterDeviceTokenReq, GRegisterDeviceTokenReqBuilder>,
        _i1.OperationRequest<_i2.GRegisterDeviceTokenData,
            _i3.GRegisterDeviceTokenVars> {
  GRegisterDeviceTokenReq._();

  factory GRegisterDeviceTokenReq(
          [void Function(GRegisterDeviceTokenReqBuilder b) updates]) =
      _$GRegisterDeviceTokenReq;

  static void _initializeBuilder(GRegisterDeviceTokenReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'RegisterDeviceToken',
    )
    ..executeOnListen = true;

  @override
  _i3.GRegisterDeviceTokenVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GRegisterDeviceTokenData? Function(
    _i2.GRegisterDeviceTokenData?,
    _i2.GRegisterDeviceTokenData?,
  )? get updateResult;
  @override
  _i2.GRegisterDeviceTokenData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GRegisterDeviceTokenData? parseData(Map<String, dynamic> json) =>
      _i2.GRegisterDeviceTokenData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GRegisterDeviceTokenData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GRegisterDeviceTokenData,
      _i3.GRegisterDeviceTokenVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GRegisterDeviceTokenReq> get serializer =>
      _$gRegisterDeviceTokenReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GRegisterDeviceTokenReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRegisterDeviceTokenReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GRegisterDeviceTokenReq.serializer,
        json,
      );
}

abstract class GUnregisterDeviceTokenReq
    implements
        Built<GUnregisterDeviceTokenReq, GUnregisterDeviceTokenReqBuilder>,
        _i1.OperationRequest<_i2.GUnregisterDeviceTokenData,
            _i3.GUnregisterDeviceTokenVars> {
  GUnregisterDeviceTokenReq._();

  factory GUnregisterDeviceTokenReq(
          [void Function(GUnregisterDeviceTokenReqBuilder b) updates]) =
      _$GUnregisterDeviceTokenReq;

  static void _initializeBuilder(GUnregisterDeviceTokenReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'UnregisterDeviceToken',
    )
    ..executeOnListen = true;

  @override
  _i3.GUnregisterDeviceTokenVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GUnregisterDeviceTokenData? Function(
    _i2.GUnregisterDeviceTokenData?,
    _i2.GUnregisterDeviceTokenData?,
  )? get updateResult;
  @override
  _i2.GUnregisterDeviceTokenData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GUnregisterDeviceTokenData? parseData(Map<String, dynamic> json) =>
      _i2.GUnregisterDeviceTokenData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GUnregisterDeviceTokenData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GUnregisterDeviceTokenData,
      _i3.GUnregisterDeviceTokenVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GUnregisterDeviceTokenReq> get serializer =>
      _$gUnregisterDeviceTokenReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GUnregisterDeviceTokenReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUnregisterDeviceTokenReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GUnregisterDeviceTokenReq.serializer,
        json,
      );
}
