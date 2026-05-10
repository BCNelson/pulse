// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    as _i3;
import 'package:pulse/graphql/__generated__/schema.schema.gql.dart' as _i2;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i1;

part 'notifications.data.gql.g.dart';

abstract class GNotificationsInboxData
    implements Built<GNotificationsInboxData, GNotificationsInboxDataBuilder> {
  GNotificationsInboxData._();

  factory GNotificationsInboxData(
          [void Function(GNotificationsInboxDataBuilder b) updates]) =
      _$GNotificationsInboxData;

  static void _initializeBuilder(GNotificationsInboxDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GNotificationsInboxData_notifications get notifications;
  static Serializer<GNotificationsInboxData> get serializer =>
      _$gNotificationsInboxDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationsInboxData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationsInboxData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationsInboxData.serializer,
        json,
      );
}

abstract class GNotificationsInboxData_notifications
    implements
        Built<GNotificationsInboxData_notifications,
            GNotificationsInboxData_notificationsBuilder> {
  GNotificationsInboxData_notifications._();

  factory GNotificationsInboxData_notifications(
      [void Function(GNotificationsInboxData_notificationsBuilder b)
          updates]) = _$GNotificationsInboxData_notifications;

  static void _initializeBuilder(
          GNotificationsInboxData_notificationsBuilder b) =>
      b..G__typename = 'NotificationConnection';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get unreadCount;
  BuiltList<GNotificationsInboxData_notifications_edges> get edges;
  static Serializer<GNotificationsInboxData_notifications> get serializer =>
      _$gNotificationsInboxDataNotificationsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationsInboxData_notifications.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationsInboxData_notifications? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationsInboxData_notifications.serializer,
        json,
      );
}

abstract class GNotificationsInboxData_notifications_edges
    implements
        Built<GNotificationsInboxData_notifications_edges,
            GNotificationsInboxData_notifications_edgesBuilder> {
  GNotificationsInboxData_notifications_edges._();

  factory GNotificationsInboxData_notifications_edges(
      [void Function(GNotificationsInboxData_notifications_edgesBuilder b)
          updates]) = _$GNotificationsInboxData_notifications_edges;

  static void _initializeBuilder(
          GNotificationsInboxData_notifications_edgesBuilder b) =>
      b..G__typename = 'NotificationEdge';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GNotificationsInboxData_notifications_edges_node get node;
  static Serializer<GNotificationsInboxData_notifications_edges>
      get serializer => _$gNotificationsInboxDataNotificationsEdgesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationsInboxData_notifications_edges.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationsInboxData_notifications_edges? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationsInboxData_notifications_edges.serializer,
        json,
      );
}

abstract class GNotificationsInboxData_notifications_edges_node
    implements
        Built<GNotificationsInboxData_notifications_edges_node,
            GNotificationsInboxData_notifications_edges_nodeBuilder>,
        GNotificationSummary {
  GNotificationsInboxData_notifications_edges_node._();

  factory GNotificationsInboxData_notifications_edges_node(
      [void Function(GNotificationsInboxData_notifications_edges_nodeBuilder b)
          updates]) = _$GNotificationsInboxData_notifications_edges_node;

  static void _initializeBuilder(
          GNotificationsInboxData_notifications_edges_nodeBuilder b) =>
      b..G__typename = 'Notification';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  _i2.GNotificationReason get reason;
  @override
  _i2.GNotificationUrgency get urgency;
  @override
  String get sourceType;
  @override
  String get sourceId;
  @override
  _i2.GTime? get readAt;
  @override
  _i2.GTime get createdAt;
  @override
  GNotificationsInboxData_notifications_edges_node_source? get source;
  @override
  GNotificationsInboxData_notifications_edges_node_sourceTag? get sourceTag;
  static Serializer<GNotificationsInboxData_notifications_edges_node>
      get serializer =>
          _$gNotificationsInboxDataNotificationsEdgesNodeSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationsInboxData_notifications_edges_node.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationsInboxData_notifications_edges_node? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationsInboxData_notifications_edges_node.serializer,
        json,
      );
}

abstract class GNotificationsInboxData_notifications_edges_node_source
    implements GNotificationSummary_source {
  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GNotificationsInboxData_notifications_edges_node_source>
      get serializer => _i3.InlineFragmentSerializer<
              GNotificationsInboxData_notifications_edges_node_source>(
            'GNotificationsInboxData_notifications_edges_node_source',
            GNotificationsInboxData_notifications_edges_node_source__base,
            {
              'Post':
                  GNotificationsInboxData_notifications_edges_node_source__asPost,
              'Comment':
                  GNotificationsInboxData_notifications_edges_node_source__asComment,
              'Task':
                  GNotificationsInboxData_notifications_edges_node_source__asTask,
              'Message':
                  GNotificationsInboxData_notifications_edges_node_source__asMessage,
            },
          );

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationsInboxData_notifications_edges_node_source.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationsInboxData_notifications_edges_node_source? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationsInboxData_notifications_edges_node_source.serializer,
        json,
      );
}

abstract class GNotificationsInboxData_notifications_edges_node_source__base
    implements
        Built<GNotificationsInboxData_notifications_edges_node_source__base,
            GNotificationsInboxData_notifications_edges_node_source__baseBuilder>,
        GNotificationsInboxData_notifications_edges_node_source {
  GNotificationsInboxData_notifications_edges_node_source__base._();

  factory GNotificationsInboxData_notifications_edges_node_source__base(
          [void Function(
                  GNotificationsInboxData_notifications_edges_node_source__baseBuilder
                      b)
              updates]) =
      _$GNotificationsInboxData_notifications_edges_node_source__base;

  static void _initializeBuilder(
          GNotificationsInboxData_notifications_edges_node_source__baseBuilder
              b) =>
      b..G__typename = 'NotificationSource';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<
          GNotificationsInboxData_notifications_edges_node_source__base>
      get serializer =>
          _$gNotificationsInboxDataNotificationsEdgesNodeSourceBaseSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationsInboxData_notifications_edges_node_source__base
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationsInboxData_notifications_edges_node_source__base?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GNotificationsInboxData_notifications_edges_node_source__base
                .serializer,
            json,
          );
}

abstract class GNotificationsInboxData_notifications_edges_node_source__asPost
    implements
        Built<GNotificationsInboxData_notifications_edges_node_source__asPost,
            GNotificationsInboxData_notifications_edges_node_source__asPostBuilder>,
        GNotificationsInboxData_notifications_edges_node_source {
  GNotificationsInboxData_notifications_edges_node_source__asPost._();

  factory GNotificationsInboxData_notifications_edges_node_source__asPost(
          [void Function(
                  GNotificationsInboxData_notifications_edges_node_source__asPostBuilder
                      b)
              updates]) =
      _$GNotificationsInboxData_notifications_edges_node_source__asPost;

  static void _initializeBuilder(
          GNotificationsInboxData_notifications_edges_node_source__asPostBuilder
              b) =>
      b..G__typename = 'Post';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get title;
  static Serializer<
          GNotificationsInboxData_notifications_edges_node_source__asPost>
      get serializer =>
          _$gNotificationsInboxDataNotificationsEdgesNodeSourceAsPostSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationsInboxData_notifications_edges_node_source__asPost
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationsInboxData_notifications_edges_node_source__asPost?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GNotificationsInboxData_notifications_edges_node_source__asPost
                .serializer,
            json,
          );
}

abstract class GNotificationsInboxData_notifications_edges_node_source__asComment
    implements
        Built<
            GNotificationsInboxData_notifications_edges_node_source__asComment,
            GNotificationsInboxData_notifications_edges_node_source__asCommentBuilder>,
        GNotificationsInboxData_notifications_edges_node_source {
  GNotificationsInboxData_notifications_edges_node_source__asComment._();

  factory GNotificationsInboxData_notifications_edges_node_source__asComment(
          [void Function(
                  GNotificationsInboxData_notifications_edges_node_source__asCommentBuilder
                      b)
              updates]) =
      _$GNotificationsInboxData_notifications_edges_node_source__asComment;

  static void _initializeBuilder(
          GNotificationsInboxData_notifications_edges_node_source__asCommentBuilder
              b) =>
      b..G__typename = 'Comment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get body;
  static Serializer<
          GNotificationsInboxData_notifications_edges_node_source__asComment>
      get serializer =>
          _$gNotificationsInboxDataNotificationsEdgesNodeSourceAsCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationsInboxData_notifications_edges_node_source__asComment
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationsInboxData_notifications_edges_node_source__asComment?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GNotificationsInboxData_notifications_edges_node_source__asComment
                .serializer,
            json,
          );
}

abstract class GNotificationsInboxData_notifications_edges_node_source__asTask
    implements
        Built<GNotificationsInboxData_notifications_edges_node_source__asTask,
            GNotificationsInboxData_notifications_edges_node_source__asTaskBuilder>,
        GNotificationsInboxData_notifications_edges_node_source {
  GNotificationsInboxData_notifications_edges_node_source__asTask._();

  factory GNotificationsInboxData_notifications_edges_node_source__asTask(
          [void Function(
                  GNotificationsInboxData_notifications_edges_node_source__asTaskBuilder
                      b)
              updates]) =
      _$GNotificationsInboxData_notifications_edges_node_source__asTask;

  static void _initializeBuilder(
          GNotificationsInboxData_notifications_edges_node_source__asTaskBuilder
              b) =>
      b..G__typename = 'Task';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get title;
  _i2.GTaskStatus get status;
  static Serializer<
          GNotificationsInboxData_notifications_edges_node_source__asTask>
      get serializer =>
          _$gNotificationsInboxDataNotificationsEdgesNodeSourceAsTaskSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationsInboxData_notifications_edges_node_source__asTask
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationsInboxData_notifications_edges_node_source__asTask?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GNotificationsInboxData_notifications_edges_node_source__asTask
                .serializer,
            json,
          );
}

abstract class GNotificationsInboxData_notifications_edges_node_source__asMessage
    implements
        Built<
            GNotificationsInboxData_notifications_edges_node_source__asMessage,
            GNotificationsInboxData_notifications_edges_node_source__asMessageBuilder>,
        GNotificationsInboxData_notifications_edges_node_source {
  GNotificationsInboxData_notifications_edges_node_source__asMessage._();

  factory GNotificationsInboxData_notifications_edges_node_source__asMessage(
          [void Function(
                  GNotificationsInboxData_notifications_edges_node_source__asMessageBuilder
                      b)
              updates]) =
      _$GNotificationsInboxData_notifications_edges_node_source__asMessage;

  static void _initializeBuilder(
          GNotificationsInboxData_notifications_edges_node_source__asMessageBuilder
              b) =>
      b..G__typename = 'Message';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get body;
  static Serializer<
          GNotificationsInboxData_notifications_edges_node_source__asMessage>
      get serializer =>
          _$gNotificationsInboxDataNotificationsEdgesNodeSourceAsMessageSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationsInboxData_notifications_edges_node_source__asMessage
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationsInboxData_notifications_edges_node_source__asMessage?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GNotificationsInboxData_notifications_edges_node_source__asMessage
                .serializer,
            json,
          );
}

abstract class GNotificationsInboxData_notifications_edges_node_sourceTag
    implements
        Built<GNotificationsInboxData_notifications_edges_node_sourceTag,
            GNotificationsInboxData_notifications_edges_node_sourceTagBuilder>,
        GNotificationSummary_sourceTag {
  GNotificationsInboxData_notifications_edges_node_sourceTag._();

  factory GNotificationsInboxData_notifications_edges_node_sourceTag(
      [void Function(
              GNotificationsInboxData_notifications_edges_node_sourceTagBuilder
                  b)
          updates]) = _$GNotificationsInboxData_notifications_edges_node_sourceTag;

  static void _initializeBuilder(
          GNotificationsInboxData_notifications_edges_node_sourceTagBuilder
              b) =>
      b..G__typename = 'Tag';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get slug;
  @override
  String get displayName;
  static Serializer<GNotificationsInboxData_notifications_edges_node_sourceTag>
      get serializer =>
          _$gNotificationsInboxDataNotificationsEdgesNodeSourceTagSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationsInboxData_notifications_edges_node_sourceTag.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationsInboxData_notifications_edges_node_sourceTag? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationsInboxData_notifications_edges_node_sourceTag.serializer,
        json,
      );
}

abstract class GMarkNotificationReadData
    implements
        Built<GMarkNotificationReadData, GMarkNotificationReadDataBuilder> {
  GMarkNotificationReadData._();

  factory GMarkNotificationReadData(
          [void Function(GMarkNotificationReadDataBuilder b) updates]) =
      _$GMarkNotificationReadData;

  static void _initializeBuilder(GMarkNotificationReadDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get markNotificationRead;
  static Serializer<GMarkNotificationReadData> get serializer =>
      _$gMarkNotificationReadDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMarkNotificationReadData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkNotificationReadData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMarkNotificationReadData.serializer,
        json,
      );
}

abstract class GMarkAllNotificationsReadData
    implements
        Built<GMarkAllNotificationsReadData,
            GMarkAllNotificationsReadDataBuilder> {
  GMarkAllNotificationsReadData._();

  factory GMarkAllNotificationsReadData(
          [void Function(GMarkAllNotificationsReadDataBuilder b) updates]) =
      _$GMarkAllNotificationsReadData;

  static void _initializeBuilder(GMarkAllNotificationsReadDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get markAllNotificationsRead;
  static Serializer<GMarkAllNotificationsReadData> get serializer =>
      _$gMarkAllNotificationsReadDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMarkAllNotificationsReadData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkAllNotificationsReadData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMarkAllNotificationsReadData.serializer,
        json,
      );
}

abstract class GNotificationReceivedData
    implements
        Built<GNotificationReceivedData, GNotificationReceivedDataBuilder> {
  GNotificationReceivedData._();

  factory GNotificationReceivedData(
          [void Function(GNotificationReceivedDataBuilder b) updates]) =
      _$GNotificationReceivedData;

  static void _initializeBuilder(GNotificationReceivedDataBuilder b) =>
      b..G__typename = 'Subscription';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GNotificationReceivedData_notificationReceived get notificationReceived;
  static Serializer<GNotificationReceivedData> get serializer =>
      _$gNotificationReceivedDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationReceivedData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationReceivedData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationReceivedData.serializer,
        json,
      );
}

abstract class GNotificationReceivedData_notificationReceived
    implements
        Built<GNotificationReceivedData_notificationReceived,
            GNotificationReceivedData_notificationReceivedBuilder>,
        GNotificationSummary {
  GNotificationReceivedData_notificationReceived._();

  factory GNotificationReceivedData_notificationReceived(
      [void Function(GNotificationReceivedData_notificationReceivedBuilder b)
          updates]) = _$GNotificationReceivedData_notificationReceived;

  static void _initializeBuilder(
          GNotificationReceivedData_notificationReceivedBuilder b) =>
      b..G__typename = 'Notification';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  _i2.GNotificationReason get reason;
  @override
  _i2.GNotificationUrgency get urgency;
  @override
  String get sourceType;
  @override
  String get sourceId;
  @override
  _i2.GTime? get readAt;
  @override
  _i2.GTime get createdAt;
  @override
  GNotificationReceivedData_notificationReceived_source? get source;
  @override
  GNotificationReceivedData_notificationReceived_sourceTag? get sourceTag;
  static Serializer<GNotificationReceivedData_notificationReceived>
      get serializer =>
          _$gNotificationReceivedDataNotificationReceivedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationReceivedData_notificationReceived.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationReceivedData_notificationReceived? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationReceivedData_notificationReceived.serializer,
        json,
      );
}

abstract class GNotificationReceivedData_notificationReceived_source
    implements GNotificationSummary_source {
  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GNotificationReceivedData_notificationReceived_source>
      get serializer => _i3.InlineFragmentSerializer<
              GNotificationReceivedData_notificationReceived_source>(
            'GNotificationReceivedData_notificationReceived_source',
            GNotificationReceivedData_notificationReceived_source__base,
            {
              'Post':
                  GNotificationReceivedData_notificationReceived_source__asPost,
              'Comment':
                  GNotificationReceivedData_notificationReceived_source__asComment,
              'Task':
                  GNotificationReceivedData_notificationReceived_source__asTask,
              'Message':
                  GNotificationReceivedData_notificationReceived_source__asMessage,
            },
          );

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationReceivedData_notificationReceived_source.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationReceivedData_notificationReceived_source? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationReceivedData_notificationReceived_source.serializer,
        json,
      );
}

abstract class GNotificationReceivedData_notificationReceived_source__base
    implements
        Built<GNotificationReceivedData_notificationReceived_source__base,
            GNotificationReceivedData_notificationReceived_source__baseBuilder>,
        GNotificationReceivedData_notificationReceived_source {
  GNotificationReceivedData_notificationReceived_source__base._();

  factory GNotificationReceivedData_notificationReceived_source__base(
      [void Function(
              GNotificationReceivedData_notificationReceived_source__baseBuilder
                  b)
          updates]) = _$GNotificationReceivedData_notificationReceived_source__base;

  static void _initializeBuilder(
          GNotificationReceivedData_notificationReceived_source__baseBuilder
              b) =>
      b..G__typename = 'NotificationSource';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GNotificationReceivedData_notificationReceived_source__base>
      get serializer =>
          _$gNotificationReceivedDataNotificationReceivedSourceBaseSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationReceivedData_notificationReceived_source__base.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationReceivedData_notificationReceived_source__base? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationReceivedData_notificationReceived_source__base.serializer,
        json,
      );
}

abstract class GNotificationReceivedData_notificationReceived_source__asPost
    implements
        Built<GNotificationReceivedData_notificationReceived_source__asPost,
            GNotificationReceivedData_notificationReceived_source__asPostBuilder>,
        GNotificationReceivedData_notificationReceived_source {
  GNotificationReceivedData_notificationReceived_source__asPost._();

  factory GNotificationReceivedData_notificationReceived_source__asPost(
          [void Function(
                  GNotificationReceivedData_notificationReceived_source__asPostBuilder
                      b)
              updates]) =
      _$GNotificationReceivedData_notificationReceived_source__asPost;

  static void _initializeBuilder(
          GNotificationReceivedData_notificationReceived_source__asPostBuilder
              b) =>
      b..G__typename = 'Post';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get title;
  static Serializer<
          GNotificationReceivedData_notificationReceived_source__asPost>
      get serializer =>
          _$gNotificationReceivedDataNotificationReceivedSourceAsPostSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationReceivedData_notificationReceived_source__asPost
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationReceivedData_notificationReceived_source__asPost?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GNotificationReceivedData_notificationReceived_source__asPost
                .serializer,
            json,
          );
}

abstract class GNotificationReceivedData_notificationReceived_source__asComment
    implements
        Built<GNotificationReceivedData_notificationReceived_source__asComment,
            GNotificationReceivedData_notificationReceived_source__asCommentBuilder>,
        GNotificationReceivedData_notificationReceived_source {
  GNotificationReceivedData_notificationReceived_source__asComment._();

  factory GNotificationReceivedData_notificationReceived_source__asComment(
          [void Function(
                  GNotificationReceivedData_notificationReceived_source__asCommentBuilder
                      b)
              updates]) =
      _$GNotificationReceivedData_notificationReceived_source__asComment;

  static void _initializeBuilder(
          GNotificationReceivedData_notificationReceived_source__asCommentBuilder
              b) =>
      b..G__typename = 'Comment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get body;
  static Serializer<
          GNotificationReceivedData_notificationReceived_source__asComment>
      get serializer =>
          _$gNotificationReceivedDataNotificationReceivedSourceAsCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationReceivedData_notificationReceived_source__asComment
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationReceivedData_notificationReceived_source__asComment?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GNotificationReceivedData_notificationReceived_source__asComment
                .serializer,
            json,
          );
}

abstract class GNotificationReceivedData_notificationReceived_source__asTask
    implements
        Built<GNotificationReceivedData_notificationReceived_source__asTask,
            GNotificationReceivedData_notificationReceived_source__asTaskBuilder>,
        GNotificationReceivedData_notificationReceived_source {
  GNotificationReceivedData_notificationReceived_source__asTask._();

  factory GNotificationReceivedData_notificationReceived_source__asTask(
          [void Function(
                  GNotificationReceivedData_notificationReceived_source__asTaskBuilder
                      b)
              updates]) =
      _$GNotificationReceivedData_notificationReceived_source__asTask;

  static void _initializeBuilder(
          GNotificationReceivedData_notificationReceived_source__asTaskBuilder
              b) =>
      b..G__typename = 'Task';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get title;
  _i2.GTaskStatus get status;
  static Serializer<
          GNotificationReceivedData_notificationReceived_source__asTask>
      get serializer =>
          _$gNotificationReceivedDataNotificationReceivedSourceAsTaskSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationReceivedData_notificationReceived_source__asTask
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationReceivedData_notificationReceived_source__asTask?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GNotificationReceivedData_notificationReceived_source__asTask
                .serializer,
            json,
          );
}

abstract class GNotificationReceivedData_notificationReceived_source__asMessage
    implements
        Built<GNotificationReceivedData_notificationReceived_source__asMessage,
            GNotificationReceivedData_notificationReceived_source__asMessageBuilder>,
        GNotificationReceivedData_notificationReceived_source {
  GNotificationReceivedData_notificationReceived_source__asMessage._();

  factory GNotificationReceivedData_notificationReceived_source__asMessage(
          [void Function(
                  GNotificationReceivedData_notificationReceived_source__asMessageBuilder
                      b)
              updates]) =
      _$GNotificationReceivedData_notificationReceived_source__asMessage;

  static void _initializeBuilder(
          GNotificationReceivedData_notificationReceived_source__asMessageBuilder
              b) =>
      b..G__typename = 'Message';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get body;
  static Serializer<
          GNotificationReceivedData_notificationReceived_source__asMessage>
      get serializer =>
          _$gNotificationReceivedDataNotificationReceivedSourceAsMessageSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationReceivedData_notificationReceived_source__asMessage
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationReceivedData_notificationReceived_source__asMessage?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GNotificationReceivedData_notificationReceived_source__asMessage
                .serializer,
            json,
          );
}

abstract class GNotificationReceivedData_notificationReceived_sourceTag
    implements
        Built<GNotificationReceivedData_notificationReceived_sourceTag,
            GNotificationReceivedData_notificationReceived_sourceTagBuilder>,
        GNotificationSummary_sourceTag {
  GNotificationReceivedData_notificationReceived_sourceTag._();

  factory GNotificationReceivedData_notificationReceived_sourceTag(
      [void Function(
              GNotificationReceivedData_notificationReceived_sourceTagBuilder b)
          updates]) = _$GNotificationReceivedData_notificationReceived_sourceTag;

  static void _initializeBuilder(
          GNotificationReceivedData_notificationReceived_sourceTagBuilder b) =>
      b..G__typename = 'Tag';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get slug;
  @override
  String get displayName;
  static Serializer<GNotificationReceivedData_notificationReceived_sourceTag>
      get serializer =>
          _$gNotificationReceivedDataNotificationReceivedSourceTagSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationReceivedData_notificationReceived_sourceTag.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationReceivedData_notificationReceived_sourceTag? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationReceivedData_notificationReceived_sourceTag.serializer,
        json,
      );
}

abstract class GNotificationSummary {
  String get G__typename;
  String get id;
  _i2.GNotificationReason get reason;
  _i2.GNotificationUrgency get urgency;
  String get sourceType;
  String get sourceId;
  _i2.GTime? get readAt;
  _i2.GTime get createdAt;
  GNotificationSummary_source? get source;
  GNotificationSummary_sourceTag? get sourceTag;
  Map<String, dynamic> toJson();
}

abstract class GNotificationSummary_source {
  String get G__typename;
}

abstract class GNotificationSummary_source__base
    implements GNotificationSummary_source {
  @override
  String get G__typename;
  @override
  Map<String, dynamic> toJson();
}

abstract class GNotificationSummary_source__asPost
    implements GNotificationSummary_source {
  @override
  String get G__typename;
  String get id;
  String get title;
  @override
  Map<String, dynamic> toJson();
}

abstract class GNotificationSummary_source__asComment
    implements GNotificationSummary_source {
  @override
  String get G__typename;
  String get id;
  String get body;
  @override
  Map<String, dynamic> toJson();
}

abstract class GNotificationSummary_source__asTask
    implements GNotificationSummary_source {
  @override
  String get G__typename;
  String get id;
  String get title;
  _i2.GTaskStatus get status;
  @override
  Map<String, dynamic> toJson();
}

abstract class GNotificationSummary_source__asMessage
    implements GNotificationSummary_source {
  @override
  String get G__typename;
  String get id;
  String get body;
  @override
  Map<String, dynamic> toJson();
}

abstract class GNotificationSummary_sourceTag {
  String get G__typename;
  String get id;
  String get slug;
  String get displayName;
  Map<String, dynamic> toJson();
}

abstract class GNotificationSummaryData
    implements
        Built<GNotificationSummaryData, GNotificationSummaryDataBuilder>,
        GNotificationSummary {
  GNotificationSummaryData._();

  factory GNotificationSummaryData(
          [void Function(GNotificationSummaryDataBuilder b) updates]) =
      _$GNotificationSummaryData;

  static void _initializeBuilder(GNotificationSummaryDataBuilder b) =>
      b..G__typename = 'Notification';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  _i2.GNotificationReason get reason;
  @override
  _i2.GNotificationUrgency get urgency;
  @override
  String get sourceType;
  @override
  String get sourceId;
  @override
  _i2.GTime? get readAt;
  @override
  _i2.GTime get createdAt;
  @override
  GNotificationSummaryData_source? get source;
  @override
  GNotificationSummaryData_sourceTag? get sourceTag;
  static Serializer<GNotificationSummaryData> get serializer =>
      _$gNotificationSummaryDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationSummaryData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationSummaryData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationSummaryData.serializer,
        json,
      );
}

abstract class GNotificationSummaryData_source
    implements GNotificationSummary_source {
  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GNotificationSummaryData_source> get serializer =>
      _i3.InlineFragmentSerializer<GNotificationSummaryData_source>(
        'GNotificationSummaryData_source',
        GNotificationSummaryData_source__base,
        {
          'Post': GNotificationSummaryData_source__asPost,
          'Comment': GNotificationSummaryData_source__asComment,
          'Task': GNotificationSummaryData_source__asTask,
          'Message': GNotificationSummaryData_source__asMessage,
        },
      );

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationSummaryData_source.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationSummaryData_source? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationSummaryData_source.serializer,
        json,
      );
}

abstract class GNotificationSummaryData_source__base
    implements
        Built<GNotificationSummaryData_source__base,
            GNotificationSummaryData_source__baseBuilder>,
        GNotificationSummaryData_source {
  GNotificationSummaryData_source__base._();

  factory GNotificationSummaryData_source__base(
      [void Function(GNotificationSummaryData_source__baseBuilder b)
          updates]) = _$GNotificationSummaryData_source__base;

  static void _initializeBuilder(
          GNotificationSummaryData_source__baseBuilder b) =>
      b..G__typename = 'NotificationSource';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GNotificationSummaryData_source__base> get serializer =>
      _$gNotificationSummaryDataSourceBaseSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationSummaryData_source__base.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationSummaryData_source__base? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationSummaryData_source__base.serializer,
        json,
      );
}

abstract class GNotificationSummaryData_source__asPost
    implements
        Built<GNotificationSummaryData_source__asPost,
            GNotificationSummaryData_source__asPostBuilder>,
        GNotificationSummaryData_source {
  GNotificationSummaryData_source__asPost._();

  factory GNotificationSummaryData_source__asPost(
      [void Function(GNotificationSummaryData_source__asPostBuilder b)
          updates]) = _$GNotificationSummaryData_source__asPost;

  static void _initializeBuilder(
          GNotificationSummaryData_source__asPostBuilder b) =>
      b..G__typename = 'Post';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get title;
  static Serializer<GNotificationSummaryData_source__asPost> get serializer =>
      _$gNotificationSummaryDataSourceAsPostSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationSummaryData_source__asPost.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationSummaryData_source__asPost? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationSummaryData_source__asPost.serializer,
        json,
      );
}

abstract class GNotificationSummaryData_source__asComment
    implements
        Built<GNotificationSummaryData_source__asComment,
            GNotificationSummaryData_source__asCommentBuilder>,
        GNotificationSummaryData_source {
  GNotificationSummaryData_source__asComment._();

  factory GNotificationSummaryData_source__asComment(
      [void Function(GNotificationSummaryData_source__asCommentBuilder b)
          updates]) = _$GNotificationSummaryData_source__asComment;

  static void _initializeBuilder(
          GNotificationSummaryData_source__asCommentBuilder b) =>
      b..G__typename = 'Comment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get body;
  static Serializer<GNotificationSummaryData_source__asComment>
      get serializer => _$gNotificationSummaryDataSourceAsCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationSummaryData_source__asComment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationSummaryData_source__asComment? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationSummaryData_source__asComment.serializer,
        json,
      );
}

abstract class GNotificationSummaryData_source__asTask
    implements
        Built<GNotificationSummaryData_source__asTask,
            GNotificationSummaryData_source__asTaskBuilder>,
        GNotificationSummaryData_source {
  GNotificationSummaryData_source__asTask._();

  factory GNotificationSummaryData_source__asTask(
      [void Function(GNotificationSummaryData_source__asTaskBuilder b)
          updates]) = _$GNotificationSummaryData_source__asTask;

  static void _initializeBuilder(
          GNotificationSummaryData_source__asTaskBuilder b) =>
      b..G__typename = 'Task';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get title;
  _i2.GTaskStatus get status;
  static Serializer<GNotificationSummaryData_source__asTask> get serializer =>
      _$gNotificationSummaryDataSourceAsTaskSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationSummaryData_source__asTask.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationSummaryData_source__asTask? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationSummaryData_source__asTask.serializer,
        json,
      );
}

abstract class GNotificationSummaryData_source__asMessage
    implements
        Built<GNotificationSummaryData_source__asMessage,
            GNotificationSummaryData_source__asMessageBuilder>,
        GNotificationSummaryData_source {
  GNotificationSummaryData_source__asMessage._();

  factory GNotificationSummaryData_source__asMessage(
      [void Function(GNotificationSummaryData_source__asMessageBuilder b)
          updates]) = _$GNotificationSummaryData_source__asMessage;

  static void _initializeBuilder(
          GNotificationSummaryData_source__asMessageBuilder b) =>
      b..G__typename = 'Message';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get body;
  static Serializer<GNotificationSummaryData_source__asMessage>
      get serializer => _$gNotificationSummaryDataSourceAsMessageSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationSummaryData_source__asMessage.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationSummaryData_source__asMessage? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationSummaryData_source__asMessage.serializer,
        json,
      );
}

abstract class GNotificationSummaryData_sourceTag
    implements
        Built<GNotificationSummaryData_sourceTag,
            GNotificationSummaryData_sourceTagBuilder>,
        GNotificationSummary_sourceTag {
  GNotificationSummaryData_sourceTag._();

  factory GNotificationSummaryData_sourceTag(
      [void Function(GNotificationSummaryData_sourceTagBuilder b)
          updates]) = _$GNotificationSummaryData_sourceTag;

  static void _initializeBuilder(GNotificationSummaryData_sourceTagBuilder b) =>
      b..G__typename = 'Tag';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get slug;
  @override
  String get displayName;
  static Serializer<GNotificationSummaryData_sourceTag> get serializer =>
      _$gNotificationSummaryDataSourceTagSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GNotificationSummaryData_sourceTag.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationSummaryData_sourceTag? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GNotificationSummaryData_sourceTag.serializer,
        json,
      );
}
