// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:pulse/graphql/operations/__generated__/search.ast.gql.dart'
    as _i5;
import 'package:pulse/graphql/operations/__generated__/search.data.gql.dart'
    as _i2;
import 'package:pulse/graphql/operations/__generated__/search.var.gql.dart'
    as _i3;

part 'search.req.gql.g.dart';

abstract class GSearchReq
    implements
        Built<GSearchReq, GSearchReqBuilder>,
        _i1.OperationRequest<_i2.GSearchData, _i3.GSearchVars> {
  GSearchReq._();

  factory GSearchReq([void Function(GSearchReqBuilder b) updates]) =
      _$GSearchReq;

  static void _initializeBuilder(GSearchReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'Search',
    )
    ..executeOnListen = true;

  @override
  _i3.GSearchVars get vars;
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
  _i2.GSearchData? Function(
    _i2.GSearchData?,
    _i2.GSearchData?,
  )? get updateResult;
  @override
  _i2.GSearchData? get optimisticResponse;
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
  _i2.GSearchData? parseData(Map<String, dynamic> json) =>
      _i2.GSearchData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GSearchData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GSearchData, _i3.GSearchVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GSearchReq> get serializer => _$gSearchReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GSearchReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GSearchReq.serializer,
        json,
      );
}

abstract class GSearchTagsReq
    implements
        Built<GSearchTagsReq, GSearchTagsReqBuilder>,
        _i1.OperationRequest<_i2.GSearchTagsData, _i3.GSearchTagsVars> {
  GSearchTagsReq._();

  factory GSearchTagsReq([void Function(GSearchTagsReqBuilder b) updates]) =
      _$GSearchTagsReq;

  static void _initializeBuilder(GSearchTagsReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'SearchTags',
    )
    ..executeOnListen = true;

  @override
  _i3.GSearchTagsVars get vars;
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
  _i2.GSearchTagsData? Function(
    _i2.GSearchTagsData?,
    _i2.GSearchTagsData?,
  )? get updateResult;
  @override
  _i2.GSearchTagsData? get optimisticResponse;
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
  _i2.GSearchTagsData? parseData(Map<String, dynamic> json) =>
      _i2.GSearchTagsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GSearchTagsData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GSearchTagsData, _i3.GSearchTagsVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GSearchTagsReq> get serializer =>
      _$gSearchTagsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GSearchTagsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchTagsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GSearchTagsReq.serializer,
        json,
      );
}
