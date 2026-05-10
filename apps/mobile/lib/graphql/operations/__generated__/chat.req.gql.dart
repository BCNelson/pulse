// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql/ast.dart' as _i7;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:pulse/graphql/operations/__generated__/chat.ast.gql.dart'
    as _i5;
import 'package:pulse/graphql/operations/__generated__/chat.data.gql.dart'
    as _i2;
import 'package:pulse/graphql/operations/__generated__/chat.var.gql.dart'
    as _i3;

part 'chat.req.gql.g.dart';

abstract class GChatRoomDetailReq
    implements
        Built<GChatRoomDetailReq, GChatRoomDetailReqBuilder>,
        _i1.OperationRequest<_i2.GChatRoomDetailData, _i3.GChatRoomDetailVars> {
  GChatRoomDetailReq._();

  factory GChatRoomDetailReq(
          [void Function(GChatRoomDetailReqBuilder b) updates]) =
      _$GChatRoomDetailReq;

  static void _initializeBuilder(GChatRoomDetailReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'ChatRoomDetail',
    )
    ..executeOnListen = true;

  @override
  _i3.GChatRoomDetailVars get vars;
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
  _i2.GChatRoomDetailData? Function(
    _i2.GChatRoomDetailData?,
    _i2.GChatRoomDetailData?,
  )? get updateResult;
  @override
  _i2.GChatRoomDetailData? get optimisticResponse;
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
  _i2.GChatRoomDetailData? parseData(Map<String, dynamic> json) =>
      _i2.GChatRoomDetailData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GChatRoomDetailData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GChatRoomDetailData, _i3.GChatRoomDetailVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GChatRoomDetailReq> get serializer =>
      _$gChatRoomDetailReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GChatRoomDetailReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomDetailReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GChatRoomDetailReq.serializer,
        json,
      );
}

abstract class GSendMessageReq
    implements
        Built<GSendMessageReq, GSendMessageReqBuilder>,
        _i1.OperationRequest<_i2.GSendMessageData, _i3.GSendMessageVars> {
  GSendMessageReq._();

  factory GSendMessageReq([void Function(GSendMessageReqBuilder b) updates]) =
      _$GSendMessageReq;

  static void _initializeBuilder(GSendMessageReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'SendMessage',
    )
    ..executeOnListen = true;

  @override
  _i3.GSendMessageVars get vars;
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
  _i2.GSendMessageData? Function(
    _i2.GSendMessageData?,
    _i2.GSendMessageData?,
  )? get updateResult;
  @override
  _i2.GSendMessageData? get optimisticResponse;
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
  _i2.GSendMessageData? parseData(Map<String, dynamic> json) =>
      _i2.GSendMessageData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GSendMessageData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GSendMessageData, _i3.GSendMessageVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GSendMessageReq> get serializer =>
      _$gSendMessageReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GSendMessageReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendMessageReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GSendMessageReq.serializer,
        json,
      );
}

abstract class GCreateChatRoomReq
    implements
        Built<GCreateChatRoomReq, GCreateChatRoomReqBuilder>,
        _i1.OperationRequest<_i2.GCreateChatRoomData, _i3.GCreateChatRoomVars> {
  GCreateChatRoomReq._();

  factory GCreateChatRoomReq(
          [void Function(GCreateChatRoomReqBuilder b) updates]) =
      _$GCreateChatRoomReq;

  static void _initializeBuilder(GCreateChatRoomReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'CreateChatRoom',
    )
    ..executeOnListen = true;

  @override
  _i3.GCreateChatRoomVars get vars;
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
  _i2.GCreateChatRoomData? Function(
    _i2.GCreateChatRoomData?,
    _i2.GCreateChatRoomData?,
  )? get updateResult;
  @override
  _i2.GCreateChatRoomData? get optimisticResponse;
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
  _i2.GCreateChatRoomData? parseData(Map<String, dynamic> json) =>
      _i2.GCreateChatRoomData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GCreateChatRoomData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GCreateChatRoomData, _i3.GCreateChatRoomVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GCreateChatRoomReq> get serializer =>
      _$gCreateChatRoomReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GCreateChatRoomReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateChatRoomReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GCreateChatRoomReq.serializer,
        json,
      );
}

abstract class GMessageAddedReq
    implements
        Built<GMessageAddedReq, GMessageAddedReqBuilder>,
        _i1.OperationRequest<_i2.GMessageAddedData, _i3.GMessageAddedVars> {
  GMessageAddedReq._();

  factory GMessageAddedReq([void Function(GMessageAddedReqBuilder b) updates]) =
      _$GMessageAddedReq;

  static void _initializeBuilder(GMessageAddedReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'MessageAdded',
    )
    ..executeOnListen = true;

  @override
  _i3.GMessageAddedVars get vars;
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
  _i2.GMessageAddedData? Function(
    _i2.GMessageAddedData?,
    _i2.GMessageAddedData?,
  )? get updateResult;
  @override
  _i2.GMessageAddedData? get optimisticResponse;
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
  _i2.GMessageAddedData? parseData(Map<String, dynamic> json) =>
      _i2.GMessageAddedData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GMessageAddedData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GMessageAddedData, _i3.GMessageAddedVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GMessageAddedReq> get serializer =>
      _$gMessageAddedReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GMessageAddedReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMessageAddedReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GMessageAddedReq.serializer,
        json,
      );
}

abstract class GMessageSummaryReq
    implements
        Built<GMessageSummaryReq, GMessageSummaryReqBuilder>,
        _i1.FragmentRequest<_i2.GMessageSummaryData, _i3.GMessageSummaryVars> {
  GMessageSummaryReq._();

  factory GMessageSummaryReq(
          [void Function(GMessageSummaryReqBuilder b) updates]) =
      _$GMessageSummaryReq;

  static void _initializeBuilder(GMessageSummaryReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'MessageSummary';

  @override
  _i3.GMessageSummaryVars get vars;
  @override
  _i7.DocumentNode get document;
  @override
  String? get fragmentName;
  @override
  Map<String, dynamic> get idFields;
  @override
  _i2.GMessageSummaryData? parseData(Map<String, dynamic> json) =>
      _i2.GMessageSummaryData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GMessageSummaryData data) =>
      data.toJson();

  static Serializer<GMessageSummaryReq> get serializer =>
      _$gMessageSummaryReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GMessageSummaryReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMessageSummaryReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GMessageSummaryReq.serializer,
        json,
      );
}

abstract class GChatRoomSummaryReq
    implements
        Built<GChatRoomSummaryReq, GChatRoomSummaryReqBuilder>,
        _i1
        .FragmentRequest<_i2.GChatRoomSummaryData, _i3.GChatRoomSummaryVars> {
  GChatRoomSummaryReq._();

  factory GChatRoomSummaryReq(
          [void Function(GChatRoomSummaryReqBuilder b) updates]) =
      _$GChatRoomSummaryReq;

  static void _initializeBuilder(GChatRoomSummaryReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'ChatRoomSummary';

  @override
  _i3.GChatRoomSummaryVars get vars;
  @override
  _i7.DocumentNode get document;
  @override
  String? get fragmentName;
  @override
  Map<String, dynamic> get idFields;
  @override
  _i2.GChatRoomSummaryData? parseData(Map<String, dynamic> json) =>
      _i2.GChatRoomSummaryData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GChatRoomSummaryData data) =>
      data.toJson();

  static Serializer<GChatRoomSummaryReq> get serializer =>
      _$gChatRoomSummaryReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GChatRoomSummaryReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomSummaryReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GChatRoomSummaryReq.serializer,
        json,
      );
}
