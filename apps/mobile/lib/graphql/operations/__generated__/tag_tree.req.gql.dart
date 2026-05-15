// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql/ast.dart' as _i7;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:pulse/graphql/operations/__generated__/tag_tree.ast.gql.dart'
    as _i5;
import 'package:pulse/graphql/operations/__generated__/tag_tree.data.gql.dart'
    as _i2;
import 'package:pulse/graphql/operations/__generated__/tag_tree.var.gql.dart'
    as _i3;

part 'tag_tree.req.gql.g.dart';

abstract class GTagTreeReq
    implements
        Built<GTagTreeReq, GTagTreeReqBuilder>,
        _i1.OperationRequest<_i2.GTagTreeData, _i3.GTagTreeVars> {
  GTagTreeReq._();

  factory GTagTreeReq([void Function(GTagTreeReqBuilder b) updates]) =
      _$GTagTreeReq;

  static void _initializeBuilder(GTagTreeReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'TagTree',
    )
    ..executeOnListen = true;

  @override
  _i3.GTagTreeVars get vars;
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
  _i2.GTagTreeData? Function(
    _i2.GTagTreeData?,
    _i2.GTagTreeData?,
  )? get updateResult;
  @override
  _i2.GTagTreeData? get optimisticResponse;
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
  _i2.GTagTreeData? parseData(Map<String, dynamic> json) =>
      _i2.GTagTreeData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GTagTreeData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GTagTreeData, _i3.GTagTreeVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GTagTreeReq> get serializer => _$gTagTreeReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GTagTreeReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTagTreeReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GTagTreeReq.serializer,
        json,
      );
}

abstract class GTagChildrenReq
    implements
        Built<GTagChildrenReq, GTagChildrenReqBuilder>,
        _i1.OperationRequest<_i2.GTagChildrenData, _i3.GTagChildrenVars> {
  GTagChildrenReq._();

  factory GTagChildrenReq([void Function(GTagChildrenReqBuilder b) updates]) =
      _$GTagChildrenReq;

  static void _initializeBuilder(GTagChildrenReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'TagChildren',
    )
    ..executeOnListen = true;

  @override
  _i3.GTagChildrenVars get vars;
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
  _i2.GTagChildrenData? Function(
    _i2.GTagChildrenData?,
    _i2.GTagChildrenData?,
  )? get updateResult;
  @override
  _i2.GTagChildrenData? get optimisticResponse;
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
  _i2.GTagChildrenData? parseData(Map<String, dynamic> json) =>
      _i2.GTagChildrenData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GTagChildrenData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GTagChildrenData, _i3.GTagChildrenVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GTagChildrenReq> get serializer =>
      _$gTagChildrenReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GTagChildrenReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTagChildrenReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GTagChildrenReq.serializer,
        json,
      );
}

abstract class GTagBySlugPathReq
    implements
        Built<GTagBySlugPathReq, GTagBySlugPathReqBuilder>,
        _i1.OperationRequest<_i2.GTagBySlugPathData, _i3.GTagBySlugPathVars> {
  GTagBySlugPathReq._();

  factory GTagBySlugPathReq(
          [void Function(GTagBySlugPathReqBuilder b) updates]) =
      _$GTagBySlugPathReq;

  static void _initializeBuilder(GTagBySlugPathReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'TagBySlugPath',
    )
    ..executeOnListen = true;

  @override
  _i3.GTagBySlugPathVars get vars;
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
  _i2.GTagBySlugPathData? Function(
    _i2.GTagBySlugPathData?,
    _i2.GTagBySlugPathData?,
  )? get updateResult;
  @override
  _i2.GTagBySlugPathData? get optimisticResponse;
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
  _i2.GTagBySlugPathData? parseData(Map<String, dynamic> json) =>
      _i2.GTagBySlugPathData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GTagBySlugPathData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GTagBySlugPathData, _i3.GTagBySlugPathVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GTagBySlugPathReq> get serializer =>
      _$gTagBySlugPathReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GTagBySlugPathReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTagBySlugPathReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GTagBySlugPathReq.serializer,
        json,
      );
}

abstract class GTagSummaryReq
    implements
        Built<GTagSummaryReq, GTagSummaryReqBuilder>,
        _i1.FragmentRequest<_i2.GTagSummaryData, _i3.GTagSummaryVars> {
  GTagSummaryReq._();

  factory GTagSummaryReq([void Function(GTagSummaryReqBuilder b) updates]) =
      _$GTagSummaryReq;

  static void _initializeBuilder(GTagSummaryReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'TagSummary';

  @override
  _i3.GTagSummaryVars get vars;
  @override
  _i7.DocumentNode get document;
  @override
  String? get fragmentName;
  @override
  Map<String, dynamic> get idFields;
  @override
  _i2.GTagSummaryData? parseData(Map<String, dynamic> json) =>
      _i2.GTagSummaryData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GTagSummaryData data) => data.toJson();

  static Serializer<GTagSummaryReq> get serializer =>
      _$gTagSummaryReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GTagSummaryReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTagSummaryReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GTagSummaryReq.serializer,
        json,
      );
}
