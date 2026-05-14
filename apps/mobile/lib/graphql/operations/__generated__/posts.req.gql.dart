// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql/ast.dart' as _i7;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:pulse/graphql/operations/__generated__/posts.ast.gql.dart'
    as _i5;
import 'package:pulse/graphql/operations/__generated__/posts.data.gql.dart'
    as _i2;
import 'package:pulse/graphql/operations/__generated__/posts.var.gql.dart'
    as _i3;

part 'posts.req.gql.g.dart';

abstract class GPostsForTagReq
    implements
        Built<GPostsForTagReq, GPostsForTagReqBuilder>,
        _i1.OperationRequest<_i2.GPostsForTagData, _i3.GPostsForTagVars> {
  GPostsForTagReq._();

  factory GPostsForTagReq([void Function(GPostsForTagReqBuilder b) updates]) =
      _$GPostsForTagReq;

  static void _initializeBuilder(GPostsForTagReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'PostsForTag',
    )
    ..executeOnListen = true;

  @override
  _i3.GPostsForTagVars get vars;
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
  _i2.GPostsForTagData? Function(
    _i2.GPostsForTagData?,
    _i2.GPostsForTagData?,
  )? get updateResult;
  @override
  _i2.GPostsForTagData? get optimisticResponse;
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
  _i2.GPostsForTagData? parseData(Map<String, dynamic> json) =>
      _i2.GPostsForTagData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GPostsForTagData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GPostsForTagData, _i3.GPostsForTagVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GPostsForTagReq> get serializer =>
      _$gPostsForTagReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GPostsForTagReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostsForTagReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GPostsForTagReq.serializer,
        json,
      );
}

abstract class GPostDetailReq
    implements
        Built<GPostDetailReq, GPostDetailReqBuilder>,
        _i1.OperationRequest<_i2.GPostDetailData, _i3.GPostDetailVars> {
  GPostDetailReq._();

  factory GPostDetailReq([void Function(GPostDetailReqBuilder b) updates]) =
      _$GPostDetailReq;

  static void _initializeBuilder(GPostDetailReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'PostDetail',
    )
    ..executeOnListen = true;

  @override
  _i3.GPostDetailVars get vars;
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
  _i2.GPostDetailData? Function(
    _i2.GPostDetailData?,
    _i2.GPostDetailData?,
  )? get updateResult;
  @override
  _i2.GPostDetailData? get optimisticResponse;
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
  _i2.GPostDetailData? parseData(Map<String, dynamic> json) =>
      _i2.GPostDetailData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GPostDetailData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GPostDetailData, _i3.GPostDetailVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GPostDetailReq> get serializer =>
      _$gPostDetailReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GPostDetailReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostDetailReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GPostDetailReq.serializer,
        json,
      );
}

abstract class GCreatePostReq
    implements
        Built<GCreatePostReq, GCreatePostReqBuilder>,
        _i1.OperationRequest<_i2.GCreatePostData, _i3.GCreatePostVars> {
  GCreatePostReq._();

  factory GCreatePostReq([void Function(GCreatePostReqBuilder b) updates]) =
      _$GCreatePostReq;

  static void _initializeBuilder(GCreatePostReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'CreatePost',
    )
    ..executeOnListen = true;

  @override
  _i3.GCreatePostVars get vars;
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
  _i2.GCreatePostData? Function(
    _i2.GCreatePostData?,
    _i2.GCreatePostData?,
  )? get updateResult;
  @override
  _i2.GCreatePostData? get optimisticResponse;
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
  _i2.GCreatePostData? parseData(Map<String, dynamic> json) =>
      _i2.GCreatePostData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GCreatePostData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GCreatePostData, _i3.GCreatePostVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GCreatePostReq> get serializer =>
      _$gCreatePostReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GCreatePostReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreatePostReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GCreatePostReq.serializer,
        json,
      );
}

abstract class GCreateCommentReq
    implements
        Built<GCreateCommentReq, GCreateCommentReqBuilder>,
        _i1.OperationRequest<_i2.GCreateCommentData, _i3.GCreateCommentVars> {
  GCreateCommentReq._();

  factory GCreateCommentReq(
          [void Function(GCreateCommentReqBuilder b) updates]) =
      _$GCreateCommentReq;

  static void _initializeBuilder(GCreateCommentReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'CreateComment',
    )
    ..executeOnListen = true;

  @override
  _i3.GCreateCommentVars get vars;
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
  _i2.GCreateCommentData? Function(
    _i2.GCreateCommentData?,
    _i2.GCreateCommentData?,
  )? get updateResult;
  @override
  _i2.GCreateCommentData? get optimisticResponse;
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
  _i2.GCreateCommentData? parseData(Map<String, dynamic> json) =>
      _i2.GCreateCommentData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GCreateCommentData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GCreateCommentData, _i3.GCreateCommentVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GCreateCommentReq> get serializer =>
      _$gCreateCommentReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GCreateCommentReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateCommentReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GCreateCommentReq.serializer,
        json,
      );
}

abstract class GMarkPostReadReq
    implements
        Built<GMarkPostReadReq, GMarkPostReadReqBuilder>,
        _i1.OperationRequest<_i2.GMarkPostReadData, _i3.GMarkPostReadVars> {
  GMarkPostReadReq._();

  factory GMarkPostReadReq([void Function(GMarkPostReadReqBuilder b) updates]) =
      _$GMarkPostReadReq;

  static void _initializeBuilder(GMarkPostReadReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'MarkPostRead',
    )
    ..executeOnListen = true;

  @override
  _i3.GMarkPostReadVars get vars;
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
  _i2.GMarkPostReadData? Function(
    _i2.GMarkPostReadData?,
    _i2.GMarkPostReadData?,
  )? get updateResult;
  @override
  _i2.GMarkPostReadData? get optimisticResponse;
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
  _i2.GMarkPostReadData? parseData(Map<String, dynamic> json) =>
      _i2.GMarkPostReadData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GMarkPostReadData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GMarkPostReadData, _i3.GMarkPostReadVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GMarkPostReadReq> get serializer =>
      _$gMarkPostReadReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GMarkPostReadReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkPostReadReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GMarkPostReadReq.serializer,
        json,
      );
}

abstract class GReactToPostReq
    implements
        Built<GReactToPostReq, GReactToPostReqBuilder>,
        _i1.OperationRequest<_i2.GReactToPostData, _i3.GReactToPostVars> {
  GReactToPostReq._();

  factory GReactToPostReq([void Function(GReactToPostReqBuilder b) updates]) =
      _$GReactToPostReq;

  static void _initializeBuilder(GReactToPostReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'ReactToPost',
    )
    ..executeOnListen = true;

  @override
  _i3.GReactToPostVars get vars;
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
  _i2.GReactToPostData? Function(
    _i2.GReactToPostData?,
    _i2.GReactToPostData?,
  )? get updateResult;
  @override
  _i2.GReactToPostData? get optimisticResponse;
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
  _i2.GReactToPostData? parseData(Map<String, dynamic> json) =>
      _i2.GReactToPostData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GReactToPostData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GReactToPostData, _i3.GReactToPostVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GReactToPostReq> get serializer =>
      _$gReactToPostReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GReactToPostReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReactToPostReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GReactToPostReq.serializer,
        json,
      );
}

abstract class GUnreactToPostReq
    implements
        Built<GUnreactToPostReq, GUnreactToPostReqBuilder>,
        _i1.OperationRequest<_i2.GUnreactToPostData, _i3.GUnreactToPostVars> {
  GUnreactToPostReq._();

  factory GUnreactToPostReq(
          [void Function(GUnreactToPostReqBuilder b) updates]) =
      _$GUnreactToPostReq;

  static void _initializeBuilder(GUnreactToPostReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'UnreactToPost',
    )
    ..executeOnListen = true;

  @override
  _i3.GUnreactToPostVars get vars;
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
  _i2.GUnreactToPostData? Function(
    _i2.GUnreactToPostData?,
    _i2.GUnreactToPostData?,
  )? get updateResult;
  @override
  _i2.GUnreactToPostData? get optimisticResponse;
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
  _i2.GUnreactToPostData? parseData(Map<String, dynamic> json) =>
      _i2.GUnreactToPostData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GUnreactToPostData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GUnreactToPostData, _i3.GUnreactToPostVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GUnreactToPostReq> get serializer =>
      _$gUnreactToPostReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GUnreactToPostReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUnreactToPostReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GUnreactToPostReq.serializer,
        json,
      );
}

abstract class GPostChangedReq
    implements
        Built<GPostChangedReq, GPostChangedReqBuilder>,
        _i1.OperationRequest<_i2.GPostChangedData, _i3.GPostChangedVars> {
  GPostChangedReq._();

  factory GPostChangedReq([void Function(GPostChangedReqBuilder b) updates]) =
      _$GPostChangedReq;

  static void _initializeBuilder(GPostChangedReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'PostChanged',
    )
    ..executeOnListen = true;

  @override
  _i3.GPostChangedVars get vars;
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
  _i2.GPostChangedData? Function(
    _i2.GPostChangedData?,
    _i2.GPostChangedData?,
  )? get updateResult;
  @override
  _i2.GPostChangedData? get optimisticResponse;
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
  _i2.GPostChangedData? parseData(Map<String, dynamic> json) =>
      _i2.GPostChangedData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GPostChangedData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GPostChangedData, _i3.GPostChangedVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GPostChangedReq> get serializer =>
      _$gPostChangedReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GPostChangedReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostChangedReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GPostChangedReq.serializer,
        json,
      );
}

abstract class GPostSummaryReq
    implements
        Built<GPostSummaryReq, GPostSummaryReqBuilder>,
        _i1.FragmentRequest<_i2.GPostSummaryData, _i3.GPostSummaryVars> {
  GPostSummaryReq._();

  factory GPostSummaryReq([void Function(GPostSummaryReqBuilder b) updates]) =
      _$GPostSummaryReq;

  static void _initializeBuilder(GPostSummaryReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'PostSummary';

  @override
  _i3.GPostSummaryVars get vars;
  @override
  _i7.DocumentNode get document;
  @override
  String? get fragmentName;
  @override
  Map<String, dynamic> get idFields;
  @override
  _i2.GPostSummaryData? parseData(Map<String, dynamic> json) =>
      _i2.GPostSummaryData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GPostSummaryData data) => data.toJson();

  static Serializer<GPostSummaryReq> get serializer =>
      _$gPostSummaryReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GPostSummaryReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostSummaryReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GPostSummaryReq.serializer,
        json,
      );
}

abstract class GCommentSummaryReq
    implements
        Built<GCommentSummaryReq, GCommentSummaryReqBuilder>,
        _i1.FragmentRequest<_i2.GCommentSummaryData, _i3.GCommentSummaryVars> {
  GCommentSummaryReq._();

  factory GCommentSummaryReq(
          [void Function(GCommentSummaryReqBuilder b) updates]) =
      _$GCommentSummaryReq;

  static void _initializeBuilder(GCommentSummaryReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'CommentSummary';

  @override
  _i3.GCommentSummaryVars get vars;
  @override
  _i7.DocumentNode get document;
  @override
  String? get fragmentName;
  @override
  Map<String, dynamic> get idFields;
  @override
  _i2.GCommentSummaryData? parseData(Map<String, dynamic> json) =>
      _i2.GCommentSummaryData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GCommentSummaryData data) =>
      data.toJson();

  static Serializer<GCommentSummaryReq> get serializer =>
      _$gCommentSummaryReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GCommentSummaryReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCommentSummaryReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GCommentSummaryReq.serializer,
        json,
      );
}
