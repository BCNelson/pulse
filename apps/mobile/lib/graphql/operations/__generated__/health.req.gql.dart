// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:pulse/graphql/operations/__generated__/health.ast.gql.dart'
    as _i5;
import 'package:pulse/graphql/operations/__generated__/health.data.gql.dart'
    as _i2;
import 'package:pulse/graphql/operations/__generated__/health.var.gql.dart'
    as _i3;

part 'health.req.gql.g.dart';

abstract class GHealthReq
    implements
        Built<GHealthReq, GHealthReqBuilder>,
        _i1.OperationRequest<_i2.GHealthData, _i3.GHealthVars> {
  GHealthReq._();

  factory GHealthReq([void Function(GHealthReqBuilder b) updates]) =
      _$GHealthReq;

  static void _initializeBuilder(GHealthReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'Health',
    )
    ..executeOnListen = true;

  @override
  _i3.GHealthVars get vars;
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
  _i2.GHealthData? Function(
    _i2.GHealthData?,
    _i2.GHealthData?,
  )? get updateResult;
  @override
  _i2.GHealthData? get optimisticResponse;
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
  _i2.GHealthData? parseData(Map<String, dynamic> json) =>
      _i2.GHealthData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GHealthData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GHealthData, _i3.GHealthVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GHealthReq> get serializer => _$gHealthReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GHealthReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GHealthReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GHealthReq.serializer,
        json,
      );
}
