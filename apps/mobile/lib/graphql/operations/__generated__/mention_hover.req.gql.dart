// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:pulse/graphql/operations/__generated__/mention_hover.ast.gql.dart'
    as _i5;
import 'package:pulse/graphql/operations/__generated__/mention_hover.data.gql.dart'
    as _i2;
import 'package:pulse/graphql/operations/__generated__/mention_hover.var.gql.dart'
    as _i3;

part 'mention_hover.req.gql.g.dart';

abstract class GMentionHoverUserReq
    implements
        Built<GMentionHoverUserReq, GMentionHoverUserReqBuilder>,
        _i1.OperationRequest<_i2.GMentionHoverUserData,
            _i3.GMentionHoverUserVars> {
  GMentionHoverUserReq._();

  factory GMentionHoverUserReq(
          [void Function(GMentionHoverUserReqBuilder b) updates]) =
      _$GMentionHoverUserReq;

  static void _initializeBuilder(GMentionHoverUserReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'MentionHoverUser',
    )
    ..executeOnListen = true;

  @override
  _i3.GMentionHoverUserVars get vars;
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
  _i2.GMentionHoverUserData? Function(
    _i2.GMentionHoverUserData?,
    _i2.GMentionHoverUserData?,
  )? get updateResult;
  @override
  _i2.GMentionHoverUserData? get optimisticResponse;
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
  _i2.GMentionHoverUserData? parseData(Map<String, dynamic> json) =>
      _i2.GMentionHoverUserData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GMentionHoverUserData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GMentionHoverUserData, _i3.GMentionHoverUserVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GMentionHoverUserReq> get serializer =>
      _$gMentionHoverUserReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GMentionHoverUserReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionHoverUserReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GMentionHoverUserReq.serializer,
        json,
      );
}

abstract class GMentionHoverTagReq
    implements
        Built<GMentionHoverTagReq, GMentionHoverTagReqBuilder>,
        _i1
        .OperationRequest<_i2.GMentionHoverTagData, _i3.GMentionHoverTagVars> {
  GMentionHoverTagReq._();

  factory GMentionHoverTagReq(
          [void Function(GMentionHoverTagReqBuilder b) updates]) =
      _$GMentionHoverTagReq;

  static void _initializeBuilder(GMentionHoverTagReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'MentionHoverTag',
    )
    ..executeOnListen = true;

  @override
  _i3.GMentionHoverTagVars get vars;
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
  _i2.GMentionHoverTagData? Function(
    _i2.GMentionHoverTagData?,
    _i2.GMentionHoverTagData?,
  )? get updateResult;
  @override
  _i2.GMentionHoverTagData? get optimisticResponse;
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
  _i2.GMentionHoverTagData? parseData(Map<String, dynamic> json) =>
      _i2.GMentionHoverTagData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GMentionHoverTagData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GMentionHoverTagData, _i3.GMentionHoverTagVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GMentionHoverTagReq> get serializer =>
      _$gMentionHoverTagReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GMentionHoverTagReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionHoverTagReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GMentionHoverTagReq.serializer,
        json,
      );
}
