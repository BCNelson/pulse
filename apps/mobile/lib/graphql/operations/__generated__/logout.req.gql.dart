// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:pulse/graphql/operations/__generated__/logout.ast.gql.dart'
    as _i5;
import 'package:pulse/graphql/operations/__generated__/logout.data.gql.dart'
    as _i2;
import 'package:pulse/graphql/operations/__generated__/logout.var.gql.dart'
    as _i3;

part 'logout.req.gql.g.dart';

abstract class GLogoutReq
    implements
        Built<GLogoutReq, GLogoutReqBuilder>,
        _i1.OperationRequest<_i2.GLogoutData, _i3.GLogoutVars> {
  GLogoutReq._();

  factory GLogoutReq([void Function(GLogoutReqBuilder b) updates]) =
      _$GLogoutReq;

  static void _initializeBuilder(GLogoutReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'Logout',
    )
    ..executeOnListen = true;

  @override
  _i3.GLogoutVars get vars;
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
  _i2.GLogoutData? Function(
    _i2.GLogoutData?,
    _i2.GLogoutData?,
  )? get updateResult;
  @override
  _i2.GLogoutData? get optimisticResponse;
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
  _i2.GLogoutData? parseData(Map<String, dynamic> json) =>
      _i2.GLogoutData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GLogoutData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GLogoutData, _i3.GLogoutVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GLogoutReq> get serializer => _$gLogoutReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GLogoutReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLogoutReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GLogoutReq.serializer,
        json,
      );
}
