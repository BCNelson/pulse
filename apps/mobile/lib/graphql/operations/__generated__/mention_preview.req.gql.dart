// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql/ast.dart' as _i7;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:pulse/graphql/operations/__generated__/mention_preview.ast.gql.dart'
    as _i5;
import 'package:pulse/graphql/operations/__generated__/mention_preview.data.gql.dart'
    as _i2;
import 'package:pulse/graphql/operations/__generated__/mention_preview.var.gql.dart'
    as _i3;

part 'mention_preview.req.gql.g.dart';

abstract class GMentionPreviewUserReq
    implements
        Built<GMentionPreviewUserReq, GMentionPreviewUserReqBuilder>,
        _i1.OperationRequest<_i2.GMentionPreviewUserData,
            _i3.GMentionPreviewUserVars> {
  GMentionPreviewUserReq._();

  factory GMentionPreviewUserReq(
          [void Function(GMentionPreviewUserReqBuilder b) updates]) =
      _$GMentionPreviewUserReq;

  static void _initializeBuilder(GMentionPreviewUserReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'MentionPreviewUser',
    )
    ..executeOnListen = true;

  @override
  _i3.GMentionPreviewUserVars get vars;
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
  _i2.GMentionPreviewUserData? Function(
    _i2.GMentionPreviewUserData?,
    _i2.GMentionPreviewUserData?,
  )? get updateResult;
  @override
  _i2.GMentionPreviewUserData? get optimisticResponse;
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
  _i2.GMentionPreviewUserData? parseData(Map<String, dynamic> json) =>
      _i2.GMentionPreviewUserData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GMentionPreviewUserData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GMentionPreviewUserData, _i3.GMentionPreviewUserVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GMentionPreviewUserReq> get serializer =>
      _$gMentionPreviewUserReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GMentionPreviewUserReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionPreviewUserReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GMentionPreviewUserReq.serializer,
        json,
      );
}

abstract class GMentionPreviewTagReq
    implements
        Built<GMentionPreviewTagReq, GMentionPreviewTagReqBuilder>,
        _i1.OperationRequest<_i2.GMentionPreviewTagData,
            _i3.GMentionPreviewTagVars> {
  GMentionPreviewTagReq._();

  factory GMentionPreviewTagReq(
          [void Function(GMentionPreviewTagReqBuilder b) updates]) =
      _$GMentionPreviewTagReq;

  static void _initializeBuilder(GMentionPreviewTagReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'MentionPreviewTag',
    )
    ..executeOnListen = true;

  @override
  _i3.GMentionPreviewTagVars get vars;
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
  _i2.GMentionPreviewTagData? Function(
    _i2.GMentionPreviewTagData?,
    _i2.GMentionPreviewTagData?,
  )? get updateResult;
  @override
  _i2.GMentionPreviewTagData? get optimisticResponse;
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
  _i2.GMentionPreviewTagData? parseData(Map<String, dynamic> json) =>
      _i2.GMentionPreviewTagData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GMentionPreviewTagData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GMentionPreviewTagData, _i3.GMentionPreviewTagVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GMentionPreviewTagReq> get serializer =>
      _$gMentionPreviewTagReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GMentionPreviewTagReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionPreviewTagReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GMentionPreviewTagReq.serializer,
        json,
      );
}

abstract class GMentionPreviewPostReq
    implements
        Built<GMentionPreviewPostReq, GMentionPreviewPostReqBuilder>,
        _i1.FragmentRequest<_i2.GMentionPreviewPostData,
            _i3.GMentionPreviewPostVars> {
  GMentionPreviewPostReq._();

  factory GMentionPreviewPostReq(
          [void Function(GMentionPreviewPostReqBuilder b) updates]) =
      _$GMentionPreviewPostReq;

  static void _initializeBuilder(GMentionPreviewPostReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'MentionPreviewPost';

  @override
  _i3.GMentionPreviewPostVars get vars;
  @override
  _i7.DocumentNode get document;
  @override
  String? get fragmentName;
  @override
  Map<String, dynamic> get idFields;
  @override
  _i2.GMentionPreviewPostData? parseData(Map<String, dynamic> json) =>
      _i2.GMentionPreviewPostData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GMentionPreviewPostData data) =>
      data.toJson();

  static Serializer<GMentionPreviewPostReq> get serializer =>
      _$gMentionPreviewPostReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GMentionPreviewPostReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionPreviewPostReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GMentionPreviewPostReq.serializer,
        json,
      );
}
