// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql/ast.dart' as _i7;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:pulse/graphql/operations/__generated__/notifications.ast.gql.dart'
    as _i5;
import 'package:pulse/graphql/operations/__generated__/notifications.data.gql.dart'
    as _i2;
import 'package:pulse/graphql/operations/__generated__/notifications.var.gql.dart'
    as _i3;

part 'notifications.req.gql.g.dart';

abstract class GNotificationsInboxReq
    implements
        Built<GNotificationsInboxReq, GNotificationsInboxReqBuilder>,
        _i1.OperationRequest<_i2.GNotificationsInboxData,
            _i3.GNotificationsInboxVars> {
  GNotificationsInboxReq._();

  factory GNotificationsInboxReq(
          [void Function(GNotificationsInboxReqBuilder b) updates]) =
      _$GNotificationsInboxReq;

  static void _initializeBuilder(GNotificationsInboxReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'NotificationsInbox',
    )
    ..executeOnListen = true;

  @override
  _i3.GNotificationsInboxVars get vars;
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
  _i2.GNotificationsInboxData? Function(
    _i2.GNotificationsInboxData?,
    _i2.GNotificationsInboxData?,
  )? get updateResult;
  @override
  _i2.GNotificationsInboxData? get optimisticResponse;
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
  _i2.GNotificationsInboxData? parseData(Map<String, dynamic> json) =>
      _i2.GNotificationsInboxData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GNotificationsInboxData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GNotificationsInboxData, _i3.GNotificationsInboxVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GNotificationsInboxReq> get serializer =>
      _$gNotificationsInboxReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GNotificationsInboxReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationsInboxReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GNotificationsInboxReq.serializer,
        json,
      );
}

abstract class GMarkNotificationReadReq
    implements
        Built<GMarkNotificationReadReq, GMarkNotificationReadReqBuilder>,
        _i1.OperationRequest<_i2.GMarkNotificationReadData,
            _i3.GMarkNotificationReadVars> {
  GMarkNotificationReadReq._();

  factory GMarkNotificationReadReq(
          [void Function(GMarkNotificationReadReqBuilder b) updates]) =
      _$GMarkNotificationReadReq;

  static void _initializeBuilder(GMarkNotificationReadReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'MarkNotificationRead',
    )
    ..executeOnListen = true;

  @override
  _i3.GMarkNotificationReadVars get vars;
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
  _i2.GMarkNotificationReadData? Function(
    _i2.GMarkNotificationReadData?,
    _i2.GMarkNotificationReadData?,
  )? get updateResult;
  @override
  _i2.GMarkNotificationReadData? get optimisticResponse;
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
  _i2.GMarkNotificationReadData? parseData(Map<String, dynamic> json) =>
      _i2.GMarkNotificationReadData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GMarkNotificationReadData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GMarkNotificationReadData,
      _i3.GMarkNotificationReadVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GMarkNotificationReadReq> get serializer =>
      _$gMarkNotificationReadReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GMarkNotificationReadReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkNotificationReadReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GMarkNotificationReadReq.serializer,
        json,
      );
}

abstract class GMarkAllNotificationsReadReq
    implements
        Built<GMarkAllNotificationsReadReq,
            GMarkAllNotificationsReadReqBuilder>,
        _i1.OperationRequest<_i2.GMarkAllNotificationsReadData,
            _i3.GMarkAllNotificationsReadVars> {
  GMarkAllNotificationsReadReq._();

  factory GMarkAllNotificationsReadReq(
          [void Function(GMarkAllNotificationsReadReqBuilder b) updates]) =
      _$GMarkAllNotificationsReadReq;

  static void _initializeBuilder(GMarkAllNotificationsReadReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'MarkAllNotificationsRead',
    )
    ..executeOnListen = true;

  @override
  _i3.GMarkAllNotificationsReadVars get vars;
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
  _i2.GMarkAllNotificationsReadData? Function(
    _i2.GMarkAllNotificationsReadData?,
    _i2.GMarkAllNotificationsReadData?,
  )? get updateResult;
  @override
  _i2.GMarkAllNotificationsReadData? get optimisticResponse;
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
  _i2.GMarkAllNotificationsReadData? parseData(Map<String, dynamic> json) =>
      _i2.GMarkAllNotificationsReadData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GMarkAllNotificationsReadData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GMarkAllNotificationsReadData,
      _i3.GMarkAllNotificationsReadVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GMarkAllNotificationsReadReq> get serializer =>
      _$gMarkAllNotificationsReadReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GMarkAllNotificationsReadReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkAllNotificationsReadReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GMarkAllNotificationsReadReq.serializer,
        json,
      );
}

abstract class GNotificationReceivedReq
    implements
        Built<GNotificationReceivedReq, GNotificationReceivedReqBuilder>,
        _i1.OperationRequest<_i2.GNotificationReceivedData,
            _i3.GNotificationReceivedVars> {
  GNotificationReceivedReq._();

  factory GNotificationReceivedReq(
          [void Function(GNotificationReceivedReqBuilder b) updates]) =
      _$GNotificationReceivedReq;

  static void _initializeBuilder(GNotificationReceivedReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'NotificationReceived',
    )
    ..executeOnListen = true;

  @override
  _i3.GNotificationReceivedVars get vars;
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
  _i2.GNotificationReceivedData? Function(
    _i2.GNotificationReceivedData?,
    _i2.GNotificationReceivedData?,
  )? get updateResult;
  @override
  _i2.GNotificationReceivedData? get optimisticResponse;
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
  _i2.GNotificationReceivedData? parseData(Map<String, dynamic> json) =>
      _i2.GNotificationReceivedData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GNotificationReceivedData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GNotificationReceivedData,
      _i3.GNotificationReceivedVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GNotificationReceivedReq> get serializer =>
      _$gNotificationReceivedReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GNotificationReceivedReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationReceivedReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GNotificationReceivedReq.serializer,
        json,
      );
}

abstract class GNotificationSummaryReq
    implements
        Built<GNotificationSummaryReq, GNotificationSummaryReqBuilder>,
        _i1.FragmentRequest<_i2.GNotificationSummaryData,
            _i3.GNotificationSummaryVars> {
  GNotificationSummaryReq._();

  factory GNotificationSummaryReq(
          [void Function(GNotificationSummaryReqBuilder b) updates]) =
      _$GNotificationSummaryReq;

  static void _initializeBuilder(GNotificationSummaryReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'NotificationSummary';

  @override
  _i3.GNotificationSummaryVars get vars;
  @override
  _i7.DocumentNode get document;
  @override
  String? get fragmentName;
  @override
  Map<String, dynamic> get idFields;
  @override
  _i2.GNotificationSummaryData? parseData(Map<String, dynamic> json) =>
      _i2.GNotificationSummaryData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GNotificationSummaryData data) =>
      data.toJson();

  static Serializer<GNotificationSummaryReq> get serializer =>
      _$gNotificationSummaryReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GNotificationSummaryReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationSummaryReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GNotificationSummaryReq.serializer,
        json,
      );
}
