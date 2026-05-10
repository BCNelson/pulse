// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GNotificationsInboxData> _$gNotificationsInboxDataSerializer =
    _$GNotificationsInboxDataSerializer();
Serializer<GNotificationsInboxData_notifications>
    _$gNotificationsInboxDataNotificationsSerializer =
    _$GNotificationsInboxData_notificationsSerializer();
Serializer<GNotificationsInboxData_notifications_edges>
    _$gNotificationsInboxDataNotificationsEdgesSerializer =
    _$GNotificationsInboxData_notifications_edgesSerializer();
Serializer<GNotificationsInboxData_notifications_edges_node>
    _$gNotificationsInboxDataNotificationsEdgesNodeSerializer =
    _$GNotificationsInboxData_notifications_edges_nodeSerializer();
Serializer<GNotificationsInboxData_notifications_edges_node_source__base>
    _$gNotificationsInboxDataNotificationsEdgesNodeSourceBaseSerializer =
    _$GNotificationsInboxData_notifications_edges_node_source__baseSerializer();
Serializer<GNotificationsInboxData_notifications_edges_node_source__asPost>
    _$gNotificationsInboxDataNotificationsEdgesNodeSourceAsPostSerializer =
    _$GNotificationsInboxData_notifications_edges_node_source__asPostSerializer();
Serializer<GNotificationsInboxData_notifications_edges_node_source__asComment>
    _$gNotificationsInboxDataNotificationsEdgesNodeSourceAsCommentSerializer =
    _$GNotificationsInboxData_notifications_edges_node_source__asCommentSerializer();
Serializer<GNotificationsInboxData_notifications_edges_node_source__asTask>
    _$gNotificationsInboxDataNotificationsEdgesNodeSourceAsTaskSerializer =
    _$GNotificationsInboxData_notifications_edges_node_source__asTaskSerializer();
Serializer<GNotificationsInboxData_notifications_edges_node_source__asMessage>
    _$gNotificationsInboxDataNotificationsEdgesNodeSourceAsMessageSerializer =
    _$GNotificationsInboxData_notifications_edges_node_source__asMessageSerializer();
Serializer<GNotificationsInboxData_notifications_edges_node_sourceTag>
    _$gNotificationsInboxDataNotificationsEdgesNodeSourceTagSerializer =
    _$GNotificationsInboxData_notifications_edges_node_sourceTagSerializer();
Serializer<GMarkNotificationReadData> _$gMarkNotificationReadDataSerializer =
    _$GMarkNotificationReadDataSerializer();
Serializer<GMarkAllNotificationsReadData>
    _$gMarkAllNotificationsReadDataSerializer =
    _$GMarkAllNotificationsReadDataSerializer();
Serializer<GNotificationReceivedData> _$gNotificationReceivedDataSerializer =
    _$GNotificationReceivedDataSerializer();
Serializer<GNotificationReceivedData_notificationReceived>
    _$gNotificationReceivedDataNotificationReceivedSerializer =
    _$GNotificationReceivedData_notificationReceivedSerializer();
Serializer<GNotificationReceivedData_notificationReceived_source__base>
    _$gNotificationReceivedDataNotificationReceivedSourceBaseSerializer =
    _$GNotificationReceivedData_notificationReceived_source__baseSerializer();
Serializer<GNotificationReceivedData_notificationReceived_source__asPost>
    _$gNotificationReceivedDataNotificationReceivedSourceAsPostSerializer =
    _$GNotificationReceivedData_notificationReceived_source__asPostSerializer();
Serializer<GNotificationReceivedData_notificationReceived_source__asComment>
    _$gNotificationReceivedDataNotificationReceivedSourceAsCommentSerializer =
    _$GNotificationReceivedData_notificationReceived_source__asCommentSerializer();
Serializer<GNotificationReceivedData_notificationReceived_source__asTask>
    _$gNotificationReceivedDataNotificationReceivedSourceAsTaskSerializer =
    _$GNotificationReceivedData_notificationReceived_source__asTaskSerializer();
Serializer<GNotificationReceivedData_notificationReceived_source__asMessage>
    _$gNotificationReceivedDataNotificationReceivedSourceAsMessageSerializer =
    _$GNotificationReceivedData_notificationReceived_source__asMessageSerializer();
Serializer<GNotificationReceivedData_notificationReceived_sourceTag>
    _$gNotificationReceivedDataNotificationReceivedSourceTagSerializer =
    _$GNotificationReceivedData_notificationReceived_sourceTagSerializer();
Serializer<GNotificationSummaryData> _$gNotificationSummaryDataSerializer =
    _$GNotificationSummaryDataSerializer();
Serializer<GNotificationSummaryData_source__base>
    _$gNotificationSummaryDataSourceBaseSerializer =
    _$GNotificationSummaryData_source__baseSerializer();
Serializer<GNotificationSummaryData_source__asPost>
    _$gNotificationSummaryDataSourceAsPostSerializer =
    _$GNotificationSummaryData_source__asPostSerializer();
Serializer<GNotificationSummaryData_source__asComment>
    _$gNotificationSummaryDataSourceAsCommentSerializer =
    _$GNotificationSummaryData_source__asCommentSerializer();
Serializer<GNotificationSummaryData_source__asTask>
    _$gNotificationSummaryDataSourceAsTaskSerializer =
    _$GNotificationSummaryData_source__asTaskSerializer();
Serializer<GNotificationSummaryData_source__asMessage>
    _$gNotificationSummaryDataSourceAsMessageSerializer =
    _$GNotificationSummaryData_source__asMessageSerializer();
Serializer<GNotificationSummaryData_sourceTag>
    _$gNotificationSummaryDataSourceTagSerializer =
    _$GNotificationSummaryData_sourceTagSerializer();

class _$GNotificationsInboxDataSerializer
    implements StructuredSerializer<GNotificationsInboxData> {
  @override
  final Iterable<Type> types = const [
    GNotificationsInboxData,
    _$GNotificationsInboxData
  ];
  @override
  final String wireName = 'GNotificationsInboxData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GNotificationsInboxData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'notifications',
      serializers.serialize(object.notifications,
          specifiedType: const FullType(GNotificationsInboxData_notifications)),
    ];

    return result;
  }

  @override
  GNotificationsInboxData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GNotificationsInboxDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'notifications':
          result.notifications.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GNotificationsInboxData_notifications))!
              as GNotificationsInboxData_notifications);
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationsInboxData_notificationsSerializer
    implements StructuredSerializer<GNotificationsInboxData_notifications> {
  @override
  final Iterable<Type> types = const [
    GNotificationsInboxData_notifications,
    _$GNotificationsInboxData_notifications
  ];
  @override
  final String wireName = 'GNotificationsInboxData_notifications';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GNotificationsInboxData_notifications object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'unreadCount',
      serializers.serialize(object.unreadCount,
          specifiedType: const FullType(int)),
      'edges',
      serializers.serialize(object.edges,
          specifiedType: const FullType(BuiltList, const [
            const FullType(GNotificationsInboxData_notifications_edges)
          ])),
    ];

    return result;
  }

  @override
  GNotificationsInboxData_notifications deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GNotificationsInboxData_notificationsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'unreadCount':
          result.unreadCount = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'edges':
          result.edges.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GNotificationsInboxData_notifications_edges)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationsInboxData_notifications_edgesSerializer
    implements
        StructuredSerializer<GNotificationsInboxData_notifications_edges> {
  @override
  final Iterable<Type> types = const [
    GNotificationsInboxData_notifications_edges,
    _$GNotificationsInboxData_notifications_edges
  ];
  @override
  final String wireName = 'GNotificationsInboxData_notifications_edges';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GNotificationsInboxData_notifications_edges object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'node',
      serializers.serialize(object.node,
          specifiedType:
              const FullType(GNotificationsInboxData_notifications_edges_node)),
    ];

    return result;
  }

  @override
  GNotificationsInboxData_notifications_edges deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GNotificationsInboxData_notifications_edgesBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'node':
          result.node.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GNotificationsInboxData_notifications_edges_node))!
              as GNotificationsInboxData_notifications_edges_node);
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationsInboxData_notifications_edges_nodeSerializer
    implements
        StructuredSerializer<GNotificationsInboxData_notifications_edges_node> {
  @override
  final Iterable<Type> types = const [
    GNotificationsInboxData_notifications_edges_node,
    _$GNotificationsInboxData_notifications_edges_node
  ];
  @override
  final String wireName = 'GNotificationsInboxData_notifications_edges_node';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GNotificationsInboxData_notifications_edges_node object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'reason',
      serializers.serialize(object.reason,
          specifiedType: const FullType(_i2.GNotificationReason)),
      'urgency',
      serializers.serialize(object.urgency,
          specifiedType: const FullType(_i2.GNotificationUrgency)),
      'sourceType',
      serializers.serialize(object.sourceType,
          specifiedType: const FullType(String)),
      'sourceId',
      serializers.serialize(object.sourceId,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GTime)),
    ];
    Object? value;
    value = object.readAt;
    if (value != null) {
      result
        ..add('readAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GTime)));
    }
    value = object.source;
    if (value != null) {
      result
        ..add('source')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GNotificationsInboxData_notifications_edges_node_source)));
    }
    value = object.sourceTag;
    if (value != null) {
      result
        ..add('sourceTag')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GNotificationsInboxData_notifications_edges_node_sourceTag)));
    }
    return result;
  }

  @override
  GNotificationsInboxData_notifications_edges_node deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GNotificationsInboxData_notifications_edges_nodeBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'reason':
          result.reason = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GNotificationReason))!
              as _i2.GNotificationReason;
          break;
        case 'urgency':
          result.urgency = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GNotificationUrgency))!
              as _i2.GNotificationUrgency;
          break;
        case 'sourceType':
          result.sourceType = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'sourceId':
          result.sourceId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'readAt':
          result.readAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'source':
          result.source = serializers.deserialize(value,
                  specifiedType: const FullType(
                      GNotificationsInboxData_notifications_edges_node_source))
              as GNotificationsInboxData_notifications_edges_node_source?;
          break;
        case 'sourceTag':
          result.sourceTag.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GNotificationsInboxData_notifications_edges_node_sourceTag))!
              as GNotificationsInboxData_notifications_edges_node_sourceTag);
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationsInboxData_notifications_edges_node_source__baseSerializer
    implements
        StructuredSerializer<
            GNotificationsInboxData_notifications_edges_node_source__base> {
  @override
  final Iterable<Type> types = const [
    GNotificationsInboxData_notifications_edges_node_source__base,
    _$GNotificationsInboxData_notifications_edges_node_source__base
  ];
  @override
  final String wireName =
      'GNotificationsInboxData_notifications_edges_node_source__base';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GNotificationsInboxData_notifications_edges_node_source__base object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GNotificationsInboxData_notifications_edges_node_source__base deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GNotificationsInboxData_notifications_edges_node_source__baseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationsInboxData_notifications_edges_node_source__asPostSerializer
    implements
        StructuredSerializer<
            GNotificationsInboxData_notifications_edges_node_source__asPost> {
  @override
  final Iterable<Type> types = const [
    GNotificationsInboxData_notifications_edges_node_source__asPost,
    _$GNotificationsInboxData_notifications_edges_node_source__asPost
  ];
  @override
  final String wireName =
      'GNotificationsInboxData_notifications_edges_node_source__asPost';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GNotificationsInboxData_notifications_edges_node_source__asPost object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GNotificationsInboxData_notifications_edges_node_source__asPost deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GNotificationsInboxData_notifications_edges_node_source__asPostBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationsInboxData_notifications_edges_node_source__asCommentSerializer
    implements
        StructuredSerializer<
            GNotificationsInboxData_notifications_edges_node_source__asComment> {
  @override
  final Iterable<Type> types = const [
    GNotificationsInboxData_notifications_edges_node_source__asComment,
    _$GNotificationsInboxData_notifications_edges_node_source__asComment
  ];
  @override
  final String wireName =
      'GNotificationsInboxData_notifications_edges_node_source__asComment';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GNotificationsInboxData_notifications_edges_node_source__asComment object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GNotificationsInboxData_notifications_edges_node_source__asComment
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        GNotificationsInboxData_notifications_edges_node_source__asCommentBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationsInboxData_notifications_edges_node_source__asTaskSerializer
    implements
        StructuredSerializer<
            GNotificationsInboxData_notifications_edges_node_source__asTask> {
  @override
  final Iterable<Type> types = const [
    GNotificationsInboxData_notifications_edges_node_source__asTask,
    _$GNotificationsInboxData_notifications_edges_node_source__asTask
  ];
  @override
  final String wireName =
      'GNotificationsInboxData_notifications_edges_node_source__asTask';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GNotificationsInboxData_notifications_edges_node_source__asTask object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(_i2.GTaskStatus)),
    ];

    return result;
  }

  @override
  GNotificationsInboxData_notifications_edges_node_source__asTask deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GNotificationsInboxData_notifications_edges_node_source__asTaskBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GTaskStatus))!
              as _i2.GTaskStatus;
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationsInboxData_notifications_edges_node_source__asMessageSerializer
    implements
        StructuredSerializer<
            GNotificationsInboxData_notifications_edges_node_source__asMessage> {
  @override
  final Iterable<Type> types = const [
    GNotificationsInboxData_notifications_edges_node_source__asMessage,
    _$GNotificationsInboxData_notifications_edges_node_source__asMessage
  ];
  @override
  final String wireName =
      'GNotificationsInboxData_notifications_edges_node_source__asMessage';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GNotificationsInboxData_notifications_edges_node_source__asMessage object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GNotificationsInboxData_notifications_edges_node_source__asMessage
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        GNotificationsInboxData_notifications_edges_node_source__asMessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationsInboxData_notifications_edges_node_sourceTagSerializer
    implements
        StructuredSerializer<
            GNotificationsInboxData_notifications_edges_node_sourceTag> {
  @override
  final Iterable<Type> types = const [
    GNotificationsInboxData_notifications_edges_node_sourceTag,
    _$GNotificationsInboxData_notifications_edges_node_sourceTag
  ];
  @override
  final String wireName =
      'GNotificationsInboxData_notifications_edges_node_sourceTag';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GNotificationsInboxData_notifications_edges_node_sourceTag object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'slug',
      serializers.serialize(object.slug, specifiedType: const FullType(String)),
      'displayName',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GNotificationsInboxData_notifications_edges_node_sourceTag deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GNotificationsInboxData_notifications_edges_node_sourceTagBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'slug':
          result.slug = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'displayName':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GMarkNotificationReadDataSerializer
    implements StructuredSerializer<GMarkNotificationReadData> {
  @override
  final Iterable<Type> types = const [
    GMarkNotificationReadData,
    _$GMarkNotificationReadData
  ];
  @override
  final String wireName = 'GMarkNotificationReadData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMarkNotificationReadData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'markNotificationRead',
      serializers.serialize(object.markNotificationRead,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GMarkNotificationReadData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMarkNotificationReadDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'markNotificationRead':
          result.markNotificationRead = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GMarkAllNotificationsReadDataSerializer
    implements StructuredSerializer<GMarkAllNotificationsReadData> {
  @override
  final Iterable<Type> types = const [
    GMarkAllNotificationsReadData,
    _$GMarkAllNotificationsReadData
  ];
  @override
  final String wireName = 'GMarkAllNotificationsReadData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMarkAllNotificationsReadData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'markAllNotificationsRead',
      serializers.serialize(object.markAllNotificationsRead,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GMarkAllNotificationsReadData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMarkAllNotificationsReadDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'markAllNotificationsRead':
          result.markAllNotificationsRead = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationReceivedDataSerializer
    implements StructuredSerializer<GNotificationReceivedData> {
  @override
  final Iterable<Type> types = const [
    GNotificationReceivedData,
    _$GNotificationReceivedData
  ];
  @override
  final String wireName = 'GNotificationReceivedData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GNotificationReceivedData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'notificationReceived',
      serializers.serialize(object.notificationReceived,
          specifiedType:
              const FullType(GNotificationReceivedData_notificationReceived)),
    ];

    return result;
  }

  @override
  GNotificationReceivedData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GNotificationReceivedDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'notificationReceived':
          result.notificationReceived.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GNotificationReceivedData_notificationReceived))!
              as GNotificationReceivedData_notificationReceived);
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationReceivedData_notificationReceivedSerializer
    implements
        StructuredSerializer<GNotificationReceivedData_notificationReceived> {
  @override
  final Iterable<Type> types = const [
    GNotificationReceivedData_notificationReceived,
    _$GNotificationReceivedData_notificationReceived
  ];
  @override
  final String wireName = 'GNotificationReceivedData_notificationReceived';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GNotificationReceivedData_notificationReceived object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'reason',
      serializers.serialize(object.reason,
          specifiedType: const FullType(_i2.GNotificationReason)),
      'urgency',
      serializers.serialize(object.urgency,
          specifiedType: const FullType(_i2.GNotificationUrgency)),
      'sourceType',
      serializers.serialize(object.sourceType,
          specifiedType: const FullType(String)),
      'sourceId',
      serializers.serialize(object.sourceId,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GTime)),
    ];
    Object? value;
    value = object.readAt;
    if (value != null) {
      result
        ..add('readAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GTime)));
    }
    value = object.source;
    if (value != null) {
      result
        ..add('source')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GNotificationReceivedData_notificationReceived_source)));
    }
    value = object.sourceTag;
    if (value != null) {
      result
        ..add('sourceTag')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GNotificationReceivedData_notificationReceived_sourceTag)));
    }
    return result;
  }

  @override
  GNotificationReceivedData_notificationReceived deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GNotificationReceivedData_notificationReceivedBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'reason':
          result.reason = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GNotificationReason))!
              as _i2.GNotificationReason;
          break;
        case 'urgency':
          result.urgency = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GNotificationUrgency))!
              as _i2.GNotificationUrgency;
          break;
        case 'sourceType':
          result.sourceType = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'sourceId':
          result.sourceId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'readAt':
          result.readAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'source':
          result.source = serializers.deserialize(value,
                  specifiedType: const FullType(
                      GNotificationReceivedData_notificationReceived_source))
              as GNotificationReceivedData_notificationReceived_source?;
          break;
        case 'sourceTag':
          result.sourceTag.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GNotificationReceivedData_notificationReceived_sourceTag))!
              as GNotificationReceivedData_notificationReceived_sourceTag);
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationReceivedData_notificationReceived_source__baseSerializer
    implements
        StructuredSerializer<
            GNotificationReceivedData_notificationReceived_source__base> {
  @override
  final Iterable<Type> types = const [
    GNotificationReceivedData_notificationReceived_source__base,
    _$GNotificationReceivedData_notificationReceived_source__base
  ];
  @override
  final String wireName =
      'GNotificationReceivedData_notificationReceived_source__base';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GNotificationReceivedData_notificationReceived_source__base object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GNotificationReceivedData_notificationReceived_source__base deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GNotificationReceivedData_notificationReceived_source__baseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationReceivedData_notificationReceived_source__asPostSerializer
    implements
        StructuredSerializer<
            GNotificationReceivedData_notificationReceived_source__asPost> {
  @override
  final Iterable<Type> types = const [
    GNotificationReceivedData_notificationReceived_source__asPost,
    _$GNotificationReceivedData_notificationReceived_source__asPost
  ];
  @override
  final String wireName =
      'GNotificationReceivedData_notificationReceived_source__asPost';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GNotificationReceivedData_notificationReceived_source__asPost object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GNotificationReceivedData_notificationReceived_source__asPost deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GNotificationReceivedData_notificationReceived_source__asPostBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationReceivedData_notificationReceived_source__asCommentSerializer
    implements
        StructuredSerializer<
            GNotificationReceivedData_notificationReceived_source__asComment> {
  @override
  final Iterable<Type> types = const [
    GNotificationReceivedData_notificationReceived_source__asComment,
    _$GNotificationReceivedData_notificationReceived_source__asComment
  ];
  @override
  final String wireName =
      'GNotificationReceivedData_notificationReceived_source__asComment';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GNotificationReceivedData_notificationReceived_source__asComment object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GNotificationReceivedData_notificationReceived_source__asComment deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GNotificationReceivedData_notificationReceived_source__asCommentBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationReceivedData_notificationReceived_source__asTaskSerializer
    implements
        StructuredSerializer<
            GNotificationReceivedData_notificationReceived_source__asTask> {
  @override
  final Iterable<Type> types = const [
    GNotificationReceivedData_notificationReceived_source__asTask,
    _$GNotificationReceivedData_notificationReceived_source__asTask
  ];
  @override
  final String wireName =
      'GNotificationReceivedData_notificationReceived_source__asTask';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GNotificationReceivedData_notificationReceived_source__asTask object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(_i2.GTaskStatus)),
    ];

    return result;
  }

  @override
  GNotificationReceivedData_notificationReceived_source__asTask deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GNotificationReceivedData_notificationReceived_source__asTaskBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GTaskStatus))!
              as _i2.GTaskStatus;
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationReceivedData_notificationReceived_source__asMessageSerializer
    implements
        StructuredSerializer<
            GNotificationReceivedData_notificationReceived_source__asMessage> {
  @override
  final Iterable<Type> types = const [
    GNotificationReceivedData_notificationReceived_source__asMessage,
    _$GNotificationReceivedData_notificationReceived_source__asMessage
  ];
  @override
  final String wireName =
      'GNotificationReceivedData_notificationReceived_source__asMessage';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GNotificationReceivedData_notificationReceived_source__asMessage object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GNotificationReceivedData_notificationReceived_source__asMessage deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GNotificationReceivedData_notificationReceived_source__asMessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationReceivedData_notificationReceived_sourceTagSerializer
    implements
        StructuredSerializer<
            GNotificationReceivedData_notificationReceived_sourceTag> {
  @override
  final Iterable<Type> types = const [
    GNotificationReceivedData_notificationReceived_sourceTag,
    _$GNotificationReceivedData_notificationReceived_sourceTag
  ];
  @override
  final String wireName =
      'GNotificationReceivedData_notificationReceived_sourceTag';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GNotificationReceivedData_notificationReceived_sourceTag object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'slug',
      serializers.serialize(object.slug, specifiedType: const FullType(String)),
      'displayName',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GNotificationReceivedData_notificationReceived_sourceTag deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GNotificationReceivedData_notificationReceived_sourceTagBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'slug':
          result.slug = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'displayName':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationSummaryDataSerializer
    implements StructuredSerializer<GNotificationSummaryData> {
  @override
  final Iterable<Type> types = const [
    GNotificationSummaryData,
    _$GNotificationSummaryData
  ];
  @override
  final String wireName = 'GNotificationSummaryData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GNotificationSummaryData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'reason',
      serializers.serialize(object.reason,
          specifiedType: const FullType(_i2.GNotificationReason)),
      'urgency',
      serializers.serialize(object.urgency,
          specifiedType: const FullType(_i2.GNotificationUrgency)),
      'sourceType',
      serializers.serialize(object.sourceType,
          specifiedType: const FullType(String)),
      'sourceId',
      serializers.serialize(object.sourceId,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GTime)),
    ];
    Object? value;
    value = object.readAt;
    if (value != null) {
      result
        ..add('readAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GTime)));
    }
    value = object.source;
    if (value != null) {
      result
        ..add('source')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GNotificationSummaryData_source)));
    }
    value = object.sourceTag;
    if (value != null) {
      result
        ..add('sourceTag')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GNotificationSummaryData_sourceTag)));
    }
    return result;
  }

  @override
  GNotificationSummaryData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GNotificationSummaryDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'reason':
          result.reason = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GNotificationReason))!
              as _i2.GNotificationReason;
          break;
        case 'urgency':
          result.urgency = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GNotificationUrgency))!
              as _i2.GNotificationUrgency;
          break;
        case 'sourceType':
          result.sourceType = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'sourceId':
          result.sourceId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'readAt':
          result.readAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'source':
          result.source = serializers.deserialize(value,
                  specifiedType:
                      const FullType(GNotificationSummaryData_source))
              as GNotificationSummaryData_source?;
          break;
        case 'sourceTag':
          result.sourceTag.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GNotificationSummaryData_sourceTag))!
              as GNotificationSummaryData_sourceTag);
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationSummaryData_source__baseSerializer
    implements StructuredSerializer<GNotificationSummaryData_source__base> {
  @override
  final Iterable<Type> types = const [
    GNotificationSummaryData_source__base,
    _$GNotificationSummaryData_source__base
  ];
  @override
  final String wireName = 'GNotificationSummaryData_source__base';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GNotificationSummaryData_source__base object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GNotificationSummaryData_source__base deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GNotificationSummaryData_source__baseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationSummaryData_source__asPostSerializer
    implements StructuredSerializer<GNotificationSummaryData_source__asPost> {
  @override
  final Iterable<Type> types = const [
    GNotificationSummaryData_source__asPost,
    _$GNotificationSummaryData_source__asPost
  ];
  @override
  final String wireName = 'GNotificationSummaryData_source__asPost';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GNotificationSummaryData_source__asPost object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GNotificationSummaryData_source__asPost deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GNotificationSummaryData_source__asPostBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationSummaryData_source__asCommentSerializer
    implements
        StructuredSerializer<GNotificationSummaryData_source__asComment> {
  @override
  final Iterable<Type> types = const [
    GNotificationSummaryData_source__asComment,
    _$GNotificationSummaryData_source__asComment
  ];
  @override
  final String wireName = 'GNotificationSummaryData_source__asComment';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GNotificationSummaryData_source__asComment object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GNotificationSummaryData_source__asComment deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GNotificationSummaryData_source__asCommentBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationSummaryData_source__asTaskSerializer
    implements StructuredSerializer<GNotificationSummaryData_source__asTask> {
  @override
  final Iterable<Type> types = const [
    GNotificationSummaryData_source__asTask,
    _$GNotificationSummaryData_source__asTask
  ];
  @override
  final String wireName = 'GNotificationSummaryData_source__asTask';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GNotificationSummaryData_source__asTask object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(_i2.GTaskStatus)),
    ];

    return result;
  }

  @override
  GNotificationSummaryData_source__asTask deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GNotificationSummaryData_source__asTaskBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GTaskStatus))!
              as _i2.GTaskStatus;
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationSummaryData_source__asMessageSerializer
    implements
        StructuredSerializer<GNotificationSummaryData_source__asMessage> {
  @override
  final Iterable<Type> types = const [
    GNotificationSummaryData_source__asMessage,
    _$GNotificationSummaryData_source__asMessage
  ];
  @override
  final String wireName = 'GNotificationSummaryData_source__asMessage';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GNotificationSummaryData_source__asMessage object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GNotificationSummaryData_source__asMessage deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GNotificationSummaryData_source__asMessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationSummaryData_sourceTagSerializer
    implements StructuredSerializer<GNotificationSummaryData_sourceTag> {
  @override
  final Iterable<Type> types = const [
    GNotificationSummaryData_sourceTag,
    _$GNotificationSummaryData_sourceTag
  ];
  @override
  final String wireName = 'GNotificationSummaryData_sourceTag';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GNotificationSummaryData_sourceTag object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'slug',
      serializers.serialize(object.slug, specifiedType: const FullType(String)),
      'displayName',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GNotificationSummaryData_sourceTag deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GNotificationSummaryData_sourceTagBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'slug':
          result.slug = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'displayName':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationsInboxData extends GNotificationsInboxData {
  @override
  final String G__typename;
  @override
  final GNotificationsInboxData_notifications notifications;

  factory _$GNotificationsInboxData(
          [void Function(GNotificationsInboxDataBuilder)? updates]) =>
      (GNotificationsInboxDataBuilder()..update(updates))._build();

  _$GNotificationsInboxData._(
      {required this.G__typename, required this.notifications})
      : super._();
  @override
  GNotificationsInboxData rebuild(
          void Function(GNotificationsInboxDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationsInboxDataBuilder toBuilder() =>
      GNotificationsInboxDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationsInboxData &&
        G__typename == other.G__typename &&
        notifications == other.notifications;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, notifications.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GNotificationsInboxData')
          ..add('G__typename', G__typename)
          ..add('notifications', notifications))
        .toString();
  }
}

class GNotificationsInboxDataBuilder
    implements
        Builder<GNotificationsInboxData, GNotificationsInboxDataBuilder> {
  _$GNotificationsInboxData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GNotificationsInboxData_notificationsBuilder? _notifications;
  GNotificationsInboxData_notificationsBuilder get notifications =>
      _$this._notifications ??= GNotificationsInboxData_notificationsBuilder();
  set notifications(
          GNotificationsInboxData_notificationsBuilder? notifications) =>
      _$this._notifications = notifications;

  GNotificationsInboxDataBuilder() {
    GNotificationsInboxData._initializeBuilder(this);
  }

  GNotificationsInboxDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _notifications = $v.notifications.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GNotificationsInboxData other) {
    _$v = other as _$GNotificationsInboxData;
  }

  @override
  void update(void Function(GNotificationsInboxDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationsInboxData build() => _build();

  _$GNotificationsInboxData _build() {
    _$GNotificationsInboxData _$result;
    try {
      _$result = _$v ??
          _$GNotificationsInboxData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GNotificationsInboxData', 'G__typename'),
            notifications: notifications.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'notifications';
        notifications.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GNotificationsInboxData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationsInboxData_notifications
    extends GNotificationsInboxData_notifications {
  @override
  final String G__typename;
  @override
  final int unreadCount;
  @override
  final BuiltList<GNotificationsInboxData_notifications_edges> edges;

  factory _$GNotificationsInboxData_notifications(
          [void Function(GNotificationsInboxData_notificationsBuilder)?
              updates]) =>
      (GNotificationsInboxData_notificationsBuilder()..update(updates))
          ._build();

  _$GNotificationsInboxData_notifications._(
      {required this.G__typename,
      required this.unreadCount,
      required this.edges})
      : super._();
  @override
  GNotificationsInboxData_notifications rebuild(
          void Function(GNotificationsInboxData_notificationsBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationsInboxData_notificationsBuilder toBuilder() =>
      GNotificationsInboxData_notificationsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationsInboxData_notifications &&
        G__typename == other.G__typename &&
        unreadCount == other.unreadCount &&
        edges == other.edges;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, unreadCount.hashCode);
    _$hash = $jc(_$hash, edges.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationsInboxData_notifications')
          ..add('G__typename', G__typename)
          ..add('unreadCount', unreadCount)
          ..add('edges', edges))
        .toString();
  }
}

class GNotificationsInboxData_notificationsBuilder
    implements
        Builder<GNotificationsInboxData_notifications,
            GNotificationsInboxData_notificationsBuilder> {
  _$GNotificationsInboxData_notifications? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _unreadCount;
  int? get unreadCount => _$this._unreadCount;
  set unreadCount(int? unreadCount) => _$this._unreadCount = unreadCount;

  ListBuilder<GNotificationsInboxData_notifications_edges>? _edges;
  ListBuilder<GNotificationsInboxData_notifications_edges> get edges =>
      _$this._edges ??=
          ListBuilder<GNotificationsInboxData_notifications_edges>();
  set edges(ListBuilder<GNotificationsInboxData_notifications_edges>? edges) =>
      _$this._edges = edges;

  GNotificationsInboxData_notificationsBuilder() {
    GNotificationsInboxData_notifications._initializeBuilder(this);
  }

  GNotificationsInboxData_notificationsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _unreadCount = $v.unreadCount;
      _edges = $v.edges.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GNotificationsInboxData_notifications other) {
    _$v = other as _$GNotificationsInboxData_notifications;
  }

  @override
  void update(
      void Function(GNotificationsInboxData_notificationsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationsInboxData_notifications build() => _build();

  _$GNotificationsInboxData_notifications _build() {
    _$GNotificationsInboxData_notifications _$result;
    try {
      _$result = _$v ??
          _$GNotificationsInboxData_notifications._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GNotificationsInboxData_notifications', 'G__typename'),
            unreadCount: BuiltValueNullFieldError.checkNotNull(unreadCount,
                r'GNotificationsInboxData_notifications', 'unreadCount'),
            edges: edges.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'edges';
        edges.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GNotificationsInboxData_notifications',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationsInboxData_notifications_edges
    extends GNotificationsInboxData_notifications_edges {
  @override
  final String G__typename;
  @override
  final GNotificationsInboxData_notifications_edges_node node;

  factory _$GNotificationsInboxData_notifications_edges(
          [void Function(GNotificationsInboxData_notifications_edgesBuilder)?
              updates]) =>
      (GNotificationsInboxData_notifications_edgesBuilder()..update(updates))
          ._build();

  _$GNotificationsInboxData_notifications_edges._(
      {required this.G__typename, required this.node})
      : super._();
  @override
  GNotificationsInboxData_notifications_edges rebuild(
          void Function(GNotificationsInboxData_notifications_edgesBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationsInboxData_notifications_edgesBuilder toBuilder() =>
      GNotificationsInboxData_notifications_edgesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationsInboxData_notifications_edges &&
        G__typename == other.G__typename &&
        node == other.node;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, node.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationsInboxData_notifications_edges')
          ..add('G__typename', G__typename)
          ..add('node', node))
        .toString();
  }
}

class GNotificationsInboxData_notifications_edgesBuilder
    implements
        Builder<GNotificationsInboxData_notifications_edges,
            GNotificationsInboxData_notifications_edgesBuilder> {
  _$GNotificationsInboxData_notifications_edges? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GNotificationsInboxData_notifications_edges_nodeBuilder? _node;
  GNotificationsInboxData_notifications_edges_nodeBuilder get node =>
      _$this._node ??=
          GNotificationsInboxData_notifications_edges_nodeBuilder();
  set node(GNotificationsInboxData_notifications_edges_nodeBuilder? node) =>
      _$this._node = node;

  GNotificationsInboxData_notifications_edgesBuilder() {
    GNotificationsInboxData_notifications_edges._initializeBuilder(this);
  }

  GNotificationsInboxData_notifications_edgesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _node = $v.node.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GNotificationsInboxData_notifications_edges other) {
    _$v = other as _$GNotificationsInboxData_notifications_edges;
  }

  @override
  void update(
      void Function(GNotificationsInboxData_notifications_edgesBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationsInboxData_notifications_edges build() => _build();

  _$GNotificationsInboxData_notifications_edges _build() {
    _$GNotificationsInboxData_notifications_edges _$result;
    try {
      _$result = _$v ??
          _$GNotificationsInboxData_notifications_edges._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GNotificationsInboxData_notifications_edges', 'G__typename'),
            node: node.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'node';
        node.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GNotificationsInboxData_notifications_edges',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationsInboxData_notifications_edges_node
    extends GNotificationsInboxData_notifications_edges_node {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final _i2.GNotificationReason reason;
  @override
  final _i2.GNotificationUrgency urgency;
  @override
  final String sourceType;
  @override
  final String sourceId;
  @override
  final _i2.GTime? readAt;
  @override
  final _i2.GTime createdAt;
  @override
  final GNotificationsInboxData_notifications_edges_node_source? source;
  @override
  final GNotificationsInboxData_notifications_edges_node_sourceTag? sourceTag;

  factory _$GNotificationsInboxData_notifications_edges_node(
          [void Function(
                  GNotificationsInboxData_notifications_edges_nodeBuilder)?
              updates]) =>
      (GNotificationsInboxData_notifications_edges_nodeBuilder()
            ..update(updates))
          ._build();

  _$GNotificationsInboxData_notifications_edges_node._(
      {required this.G__typename,
      required this.id,
      required this.reason,
      required this.urgency,
      required this.sourceType,
      required this.sourceId,
      this.readAt,
      required this.createdAt,
      this.source,
      this.sourceTag})
      : super._();
  @override
  GNotificationsInboxData_notifications_edges_node rebuild(
          void Function(GNotificationsInboxData_notifications_edges_nodeBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationsInboxData_notifications_edges_nodeBuilder toBuilder() =>
      GNotificationsInboxData_notifications_edges_nodeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationsInboxData_notifications_edges_node &&
        G__typename == other.G__typename &&
        id == other.id &&
        reason == other.reason &&
        urgency == other.urgency &&
        sourceType == other.sourceType &&
        sourceId == other.sourceId &&
        readAt == other.readAt &&
        createdAt == other.createdAt &&
        source == other.source &&
        sourceTag == other.sourceTag;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, urgency.hashCode);
    _$hash = $jc(_$hash, sourceType.hashCode);
    _$hash = $jc(_$hash, sourceId.hashCode);
    _$hash = $jc(_$hash, readAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, source.hashCode);
    _$hash = $jc(_$hash, sourceTag.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationsInboxData_notifications_edges_node')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('reason', reason)
          ..add('urgency', urgency)
          ..add('sourceType', sourceType)
          ..add('sourceId', sourceId)
          ..add('readAt', readAt)
          ..add('createdAt', createdAt)
          ..add('source', source)
          ..add('sourceTag', sourceTag))
        .toString();
  }
}

class GNotificationsInboxData_notifications_edges_nodeBuilder
    implements
        Builder<GNotificationsInboxData_notifications_edges_node,
            GNotificationsInboxData_notifications_edges_nodeBuilder> {
  _$GNotificationsInboxData_notifications_edges_node? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  _i2.GNotificationReason? _reason;
  _i2.GNotificationReason? get reason => _$this._reason;
  set reason(_i2.GNotificationReason? reason) => _$this._reason = reason;

  _i2.GNotificationUrgency? _urgency;
  _i2.GNotificationUrgency? get urgency => _$this._urgency;
  set urgency(_i2.GNotificationUrgency? urgency) => _$this._urgency = urgency;

  String? _sourceType;
  String? get sourceType => _$this._sourceType;
  set sourceType(String? sourceType) => _$this._sourceType = sourceType;

  String? _sourceId;
  String? get sourceId => _$this._sourceId;
  set sourceId(String? sourceId) => _$this._sourceId = sourceId;

  _i2.GTimeBuilder? _readAt;
  _i2.GTimeBuilder get readAt => _$this._readAt ??= _i2.GTimeBuilder();
  set readAt(_i2.GTimeBuilder? readAt) => _$this._readAt = readAt;

  _i2.GTimeBuilder? _createdAt;
  _i2.GTimeBuilder get createdAt => _$this._createdAt ??= _i2.GTimeBuilder();
  set createdAt(_i2.GTimeBuilder? createdAt) => _$this._createdAt = createdAt;

  GNotificationsInboxData_notifications_edges_node_source? _source;
  GNotificationsInboxData_notifications_edges_node_source? get source =>
      _$this._source;
  set source(GNotificationsInboxData_notifications_edges_node_source? source) =>
      _$this._source = source;

  GNotificationsInboxData_notifications_edges_node_sourceTagBuilder? _sourceTag;
  GNotificationsInboxData_notifications_edges_node_sourceTagBuilder
      get sourceTag => _$this._sourceTag ??=
          GNotificationsInboxData_notifications_edges_node_sourceTagBuilder();
  set sourceTag(
          GNotificationsInboxData_notifications_edges_node_sourceTagBuilder?
              sourceTag) =>
      _$this._sourceTag = sourceTag;

  GNotificationsInboxData_notifications_edges_nodeBuilder() {
    GNotificationsInboxData_notifications_edges_node._initializeBuilder(this);
  }

  GNotificationsInboxData_notifications_edges_nodeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _reason = $v.reason;
      _urgency = $v.urgency;
      _sourceType = $v.sourceType;
      _sourceId = $v.sourceId;
      _readAt = $v.readAt?.toBuilder();
      _createdAt = $v.createdAt.toBuilder();
      _source = $v.source;
      _sourceTag = $v.sourceTag?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GNotificationsInboxData_notifications_edges_node other) {
    _$v = other as _$GNotificationsInboxData_notifications_edges_node;
  }

  @override
  void update(
      void Function(GNotificationsInboxData_notifications_edges_nodeBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationsInboxData_notifications_edges_node build() => _build();

  _$GNotificationsInboxData_notifications_edges_node _build() {
    _$GNotificationsInboxData_notifications_edges_node _$result;
    try {
      _$result = _$v ??
          _$GNotificationsInboxData_notifications_edges_node._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GNotificationsInboxData_notifications_edges_node',
                'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GNotificationsInboxData_notifications_edges_node', 'id'),
            reason: BuiltValueNullFieldError.checkNotNull(reason,
                r'GNotificationsInboxData_notifications_edges_node', 'reason'),
            urgency: BuiltValueNullFieldError.checkNotNull(urgency,
                r'GNotificationsInboxData_notifications_edges_node', 'urgency'),
            sourceType: BuiltValueNullFieldError.checkNotNull(
                sourceType,
                r'GNotificationsInboxData_notifications_edges_node',
                'sourceType'),
            sourceId: BuiltValueNullFieldError.checkNotNull(
                sourceId,
                r'GNotificationsInboxData_notifications_edges_node',
                'sourceId'),
            readAt: _readAt?.build(),
            createdAt: createdAt.build(),
            source: source,
            sourceTag: _sourceTag?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'readAt';
        _readAt?.build();
        _$failedField = 'createdAt';
        createdAt.build();

        _$failedField = 'sourceTag';
        _sourceTag?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GNotificationsInboxData_notifications_edges_node',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationsInboxData_notifications_edges_node_source__base
    extends GNotificationsInboxData_notifications_edges_node_source__base {
  @override
  final String G__typename;

  factory _$GNotificationsInboxData_notifications_edges_node_source__base(
          [void Function(
                  GNotificationsInboxData_notifications_edges_node_source__baseBuilder)?
              updates]) =>
      (GNotificationsInboxData_notifications_edges_node_source__baseBuilder()
            ..update(updates))
          ._build();

  _$GNotificationsInboxData_notifications_edges_node_source__base._(
      {required this.G__typename})
      : super._();
  @override
  GNotificationsInboxData_notifications_edges_node_source__base rebuild(
          void Function(
                  GNotificationsInboxData_notifications_edges_node_source__baseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationsInboxData_notifications_edges_node_source__baseBuilder
      toBuilder() =>
          GNotificationsInboxData_notifications_edges_node_source__baseBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GNotificationsInboxData_notifications_edges_node_source__base &&
        G__typename == other.G__typename;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationsInboxData_notifications_edges_node_source__base')
          ..add('G__typename', G__typename))
        .toString();
  }
}

class GNotificationsInboxData_notifications_edges_node_source__baseBuilder
    implements
        Builder<GNotificationsInboxData_notifications_edges_node_source__base,
            GNotificationsInboxData_notifications_edges_node_source__baseBuilder> {
  _$GNotificationsInboxData_notifications_edges_node_source__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GNotificationsInboxData_notifications_edges_node_source__baseBuilder() {
    GNotificationsInboxData_notifications_edges_node_source__base
        ._initializeBuilder(this);
  }

  GNotificationsInboxData_notifications_edges_node_source__baseBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GNotificationsInboxData_notifications_edges_node_source__base other) {
    _$v = other
        as _$GNotificationsInboxData_notifications_edges_node_source__base;
  }

  @override
  void update(
      void Function(
              GNotificationsInboxData_notifications_edges_node_source__baseBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationsInboxData_notifications_edges_node_source__base build() =>
      _build();

  _$GNotificationsInboxData_notifications_edges_node_source__base _build() {
    final _$result = _$v ??
        _$GNotificationsInboxData_notifications_edges_node_source__base._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GNotificationsInboxData_notifications_edges_node_source__base',
              'G__typename'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationsInboxData_notifications_edges_node_source__asPost
    extends GNotificationsInboxData_notifications_edges_node_source__asPost {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String title;

  factory _$GNotificationsInboxData_notifications_edges_node_source__asPost(
          [void Function(
                  GNotificationsInboxData_notifications_edges_node_source__asPostBuilder)?
              updates]) =>
      (GNotificationsInboxData_notifications_edges_node_source__asPostBuilder()
            ..update(updates))
          ._build();

  _$GNotificationsInboxData_notifications_edges_node_source__asPost._(
      {required this.G__typename, required this.id, required this.title})
      : super._();
  @override
  GNotificationsInboxData_notifications_edges_node_source__asPost rebuild(
          void Function(
                  GNotificationsInboxData_notifications_edges_node_source__asPostBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationsInboxData_notifications_edges_node_source__asPostBuilder
      toBuilder() =>
          GNotificationsInboxData_notifications_edges_node_source__asPostBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GNotificationsInboxData_notifications_edges_node_source__asPost &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationsInboxData_notifications_edges_node_source__asPost')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title))
        .toString();
  }
}

class GNotificationsInboxData_notifications_edges_node_source__asPostBuilder
    implements
        Builder<GNotificationsInboxData_notifications_edges_node_source__asPost,
            GNotificationsInboxData_notifications_edges_node_source__asPostBuilder> {
  _$GNotificationsInboxData_notifications_edges_node_source__asPost? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  GNotificationsInboxData_notifications_edges_node_source__asPostBuilder() {
    GNotificationsInboxData_notifications_edges_node_source__asPost
        ._initializeBuilder(this);
  }

  GNotificationsInboxData_notifications_edges_node_source__asPostBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GNotificationsInboxData_notifications_edges_node_source__asPost other) {
    _$v = other
        as _$GNotificationsInboxData_notifications_edges_node_source__asPost;
  }

  @override
  void update(
      void Function(
              GNotificationsInboxData_notifications_edges_node_source__asPostBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationsInboxData_notifications_edges_node_source__asPost build() =>
      _build();

  _$GNotificationsInboxData_notifications_edges_node_source__asPost _build() {
    final _$result = _$v ??
        _$GNotificationsInboxData_notifications_edges_node_source__asPost._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GNotificationsInboxData_notifications_edges_node_source__asPost',
              'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GNotificationsInboxData_notifications_edges_node_source__asPost',
              'id'),
          title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'GNotificationsInboxData_notifications_edges_node_source__asPost',
              'title'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationsInboxData_notifications_edges_node_source__asComment
    extends GNotificationsInboxData_notifications_edges_node_source__asComment {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String body;

  factory _$GNotificationsInboxData_notifications_edges_node_source__asComment(
          [void Function(
                  GNotificationsInboxData_notifications_edges_node_source__asCommentBuilder)?
              updates]) =>
      (GNotificationsInboxData_notifications_edges_node_source__asCommentBuilder()
            ..update(updates))
          ._build();

  _$GNotificationsInboxData_notifications_edges_node_source__asComment._(
      {required this.G__typename, required this.id, required this.body})
      : super._();
  @override
  GNotificationsInboxData_notifications_edges_node_source__asComment rebuild(
          void Function(
                  GNotificationsInboxData_notifications_edges_node_source__asCommentBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationsInboxData_notifications_edges_node_source__asCommentBuilder
      toBuilder() =>
          GNotificationsInboxData_notifications_edges_node_source__asCommentBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GNotificationsInboxData_notifications_edges_node_source__asComment &&
        G__typename == other.G__typename &&
        id == other.id &&
        body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationsInboxData_notifications_edges_node_source__asComment')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('body', body))
        .toString();
  }
}

class GNotificationsInboxData_notifications_edges_node_source__asCommentBuilder
    implements
        Builder<
            GNotificationsInboxData_notifications_edges_node_source__asComment,
            GNotificationsInboxData_notifications_edges_node_source__asCommentBuilder> {
  _$GNotificationsInboxData_notifications_edges_node_source__asComment? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  GNotificationsInboxData_notifications_edges_node_source__asCommentBuilder() {
    GNotificationsInboxData_notifications_edges_node_source__asComment
        ._initializeBuilder(this);
  }

  GNotificationsInboxData_notifications_edges_node_source__asCommentBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _body = $v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GNotificationsInboxData_notifications_edges_node_source__asComment
          other) {
    _$v = other
        as _$GNotificationsInboxData_notifications_edges_node_source__asComment;
  }

  @override
  void update(
      void Function(
              GNotificationsInboxData_notifications_edges_node_source__asCommentBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationsInboxData_notifications_edges_node_source__asComment build() =>
      _build();

  _$GNotificationsInboxData_notifications_edges_node_source__asComment
      _build() {
    final _$result = _$v ??
        _$GNotificationsInboxData_notifications_edges_node_source__asComment._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GNotificationsInboxData_notifications_edges_node_source__asComment',
              'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GNotificationsInboxData_notifications_edges_node_source__asComment',
              'id'),
          body: BuiltValueNullFieldError.checkNotNull(
              body,
              r'GNotificationsInboxData_notifications_edges_node_source__asComment',
              'body'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationsInboxData_notifications_edges_node_source__asTask
    extends GNotificationsInboxData_notifications_edges_node_source__asTask {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String title;
  @override
  final _i2.GTaskStatus status;

  factory _$GNotificationsInboxData_notifications_edges_node_source__asTask(
          [void Function(
                  GNotificationsInboxData_notifications_edges_node_source__asTaskBuilder)?
              updates]) =>
      (GNotificationsInboxData_notifications_edges_node_source__asTaskBuilder()
            ..update(updates))
          ._build();

  _$GNotificationsInboxData_notifications_edges_node_source__asTask._(
      {required this.G__typename,
      required this.id,
      required this.title,
      required this.status})
      : super._();
  @override
  GNotificationsInboxData_notifications_edges_node_source__asTask rebuild(
          void Function(
                  GNotificationsInboxData_notifications_edges_node_source__asTaskBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationsInboxData_notifications_edges_node_source__asTaskBuilder
      toBuilder() =>
          GNotificationsInboxData_notifications_edges_node_source__asTaskBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GNotificationsInboxData_notifications_edges_node_source__asTask &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationsInboxData_notifications_edges_node_source__asTask')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('status', status))
        .toString();
  }
}

class GNotificationsInboxData_notifications_edges_node_source__asTaskBuilder
    implements
        Builder<GNotificationsInboxData_notifications_edges_node_source__asTask,
            GNotificationsInboxData_notifications_edges_node_source__asTaskBuilder> {
  _$GNotificationsInboxData_notifications_edges_node_source__asTask? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  _i2.GTaskStatus? _status;
  _i2.GTaskStatus? get status => _$this._status;
  set status(_i2.GTaskStatus? status) => _$this._status = status;

  GNotificationsInboxData_notifications_edges_node_source__asTaskBuilder() {
    GNotificationsInboxData_notifications_edges_node_source__asTask
        ._initializeBuilder(this);
  }

  GNotificationsInboxData_notifications_edges_node_source__asTaskBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GNotificationsInboxData_notifications_edges_node_source__asTask other) {
    _$v = other
        as _$GNotificationsInboxData_notifications_edges_node_source__asTask;
  }

  @override
  void update(
      void Function(
              GNotificationsInboxData_notifications_edges_node_source__asTaskBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationsInboxData_notifications_edges_node_source__asTask build() =>
      _build();

  _$GNotificationsInboxData_notifications_edges_node_source__asTask _build() {
    final _$result = _$v ??
        _$GNotificationsInboxData_notifications_edges_node_source__asTask._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GNotificationsInboxData_notifications_edges_node_source__asTask',
              'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GNotificationsInboxData_notifications_edges_node_source__asTask',
              'id'),
          title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'GNotificationsInboxData_notifications_edges_node_source__asTask',
              'title'),
          status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GNotificationsInboxData_notifications_edges_node_source__asTask',
              'status'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationsInboxData_notifications_edges_node_source__asMessage
    extends GNotificationsInboxData_notifications_edges_node_source__asMessage {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String body;

  factory _$GNotificationsInboxData_notifications_edges_node_source__asMessage(
          [void Function(
                  GNotificationsInboxData_notifications_edges_node_source__asMessageBuilder)?
              updates]) =>
      (GNotificationsInboxData_notifications_edges_node_source__asMessageBuilder()
            ..update(updates))
          ._build();

  _$GNotificationsInboxData_notifications_edges_node_source__asMessage._(
      {required this.G__typename, required this.id, required this.body})
      : super._();
  @override
  GNotificationsInboxData_notifications_edges_node_source__asMessage rebuild(
          void Function(
                  GNotificationsInboxData_notifications_edges_node_source__asMessageBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationsInboxData_notifications_edges_node_source__asMessageBuilder
      toBuilder() =>
          GNotificationsInboxData_notifications_edges_node_source__asMessageBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GNotificationsInboxData_notifications_edges_node_source__asMessage &&
        G__typename == other.G__typename &&
        id == other.id &&
        body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationsInboxData_notifications_edges_node_source__asMessage')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('body', body))
        .toString();
  }
}

class GNotificationsInboxData_notifications_edges_node_source__asMessageBuilder
    implements
        Builder<
            GNotificationsInboxData_notifications_edges_node_source__asMessage,
            GNotificationsInboxData_notifications_edges_node_source__asMessageBuilder> {
  _$GNotificationsInboxData_notifications_edges_node_source__asMessage? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  GNotificationsInboxData_notifications_edges_node_source__asMessageBuilder() {
    GNotificationsInboxData_notifications_edges_node_source__asMessage
        ._initializeBuilder(this);
  }

  GNotificationsInboxData_notifications_edges_node_source__asMessageBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _body = $v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GNotificationsInboxData_notifications_edges_node_source__asMessage
          other) {
    _$v = other
        as _$GNotificationsInboxData_notifications_edges_node_source__asMessage;
  }

  @override
  void update(
      void Function(
              GNotificationsInboxData_notifications_edges_node_source__asMessageBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationsInboxData_notifications_edges_node_source__asMessage build() =>
      _build();

  _$GNotificationsInboxData_notifications_edges_node_source__asMessage
      _build() {
    final _$result = _$v ??
        _$GNotificationsInboxData_notifications_edges_node_source__asMessage._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GNotificationsInboxData_notifications_edges_node_source__asMessage',
              'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GNotificationsInboxData_notifications_edges_node_source__asMessage',
              'id'),
          body: BuiltValueNullFieldError.checkNotNull(
              body,
              r'GNotificationsInboxData_notifications_edges_node_source__asMessage',
              'body'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationsInboxData_notifications_edges_node_sourceTag
    extends GNotificationsInboxData_notifications_edges_node_sourceTag {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String slug;
  @override
  final String displayName;

  factory _$GNotificationsInboxData_notifications_edges_node_sourceTag(
          [void Function(
                  GNotificationsInboxData_notifications_edges_node_sourceTagBuilder)?
              updates]) =>
      (GNotificationsInboxData_notifications_edges_node_sourceTagBuilder()
            ..update(updates))
          ._build();

  _$GNotificationsInboxData_notifications_edges_node_sourceTag._(
      {required this.G__typename,
      required this.id,
      required this.slug,
      required this.displayName})
      : super._();
  @override
  GNotificationsInboxData_notifications_edges_node_sourceTag rebuild(
          void Function(
                  GNotificationsInboxData_notifications_edges_node_sourceTagBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationsInboxData_notifications_edges_node_sourceTagBuilder
      toBuilder() =>
          GNotificationsInboxData_notifications_edges_node_sourceTagBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GNotificationsInboxData_notifications_edges_node_sourceTag &&
        G__typename == other.G__typename &&
        id == other.id &&
        slug == other.slug &&
        displayName == other.displayName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationsInboxData_notifications_edges_node_sourceTag')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('slug', slug)
          ..add('displayName', displayName))
        .toString();
  }
}

class GNotificationsInboxData_notifications_edges_node_sourceTagBuilder
    implements
        Builder<GNotificationsInboxData_notifications_edges_node_sourceTag,
            GNotificationsInboxData_notifications_edges_node_sourceTagBuilder> {
  _$GNotificationsInboxData_notifications_edges_node_sourceTag? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _slug;
  String? get slug => _$this._slug;
  set slug(String? slug) => _$this._slug = slug;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GNotificationsInboxData_notifications_edges_node_sourceTagBuilder() {
    GNotificationsInboxData_notifications_edges_node_sourceTag
        ._initializeBuilder(this);
  }

  GNotificationsInboxData_notifications_edges_node_sourceTagBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _slug = $v.slug;
      _displayName = $v.displayName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GNotificationsInboxData_notifications_edges_node_sourceTag other) {
    _$v = other as _$GNotificationsInboxData_notifications_edges_node_sourceTag;
  }

  @override
  void update(
      void Function(
              GNotificationsInboxData_notifications_edges_node_sourceTagBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationsInboxData_notifications_edges_node_sourceTag build() =>
      _build();

  _$GNotificationsInboxData_notifications_edges_node_sourceTag _build() {
    final _$result = _$v ??
        _$GNotificationsInboxData_notifications_edges_node_sourceTag._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GNotificationsInboxData_notifications_edges_node_sourceTag',
              'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GNotificationsInboxData_notifications_edges_node_sourceTag',
              'id'),
          slug: BuiltValueNullFieldError.checkNotNull(
              slug,
              r'GNotificationsInboxData_notifications_edges_node_sourceTag',
              'slug'),
          displayName: BuiltValueNullFieldError.checkNotNull(
              displayName,
              r'GNotificationsInboxData_notifications_edges_node_sourceTag',
              'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GMarkNotificationReadData extends GMarkNotificationReadData {
  @override
  final String G__typename;
  @override
  final int markNotificationRead;

  factory _$GMarkNotificationReadData(
          [void Function(GMarkNotificationReadDataBuilder)? updates]) =>
      (GMarkNotificationReadDataBuilder()..update(updates))._build();

  _$GMarkNotificationReadData._(
      {required this.G__typename, required this.markNotificationRead})
      : super._();
  @override
  GMarkNotificationReadData rebuild(
          void Function(GMarkNotificationReadDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMarkNotificationReadDataBuilder toBuilder() =>
      GMarkNotificationReadDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkNotificationReadData &&
        G__typename == other.G__typename &&
        markNotificationRead == other.markNotificationRead;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, markNotificationRead.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMarkNotificationReadData')
          ..add('G__typename', G__typename)
          ..add('markNotificationRead', markNotificationRead))
        .toString();
  }
}

class GMarkNotificationReadDataBuilder
    implements
        Builder<GMarkNotificationReadData, GMarkNotificationReadDataBuilder> {
  _$GMarkNotificationReadData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _markNotificationRead;
  int? get markNotificationRead => _$this._markNotificationRead;
  set markNotificationRead(int? markNotificationRead) =>
      _$this._markNotificationRead = markNotificationRead;

  GMarkNotificationReadDataBuilder() {
    GMarkNotificationReadData._initializeBuilder(this);
  }

  GMarkNotificationReadDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _markNotificationRead = $v.markNotificationRead;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMarkNotificationReadData other) {
    _$v = other as _$GMarkNotificationReadData;
  }

  @override
  void update(void Function(GMarkNotificationReadDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMarkNotificationReadData build() => _build();

  _$GMarkNotificationReadData _build() {
    final _$result = _$v ??
        _$GMarkNotificationReadData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GMarkNotificationReadData', 'G__typename'),
          markNotificationRead: BuiltValueNullFieldError.checkNotNull(
              markNotificationRead,
              r'GMarkNotificationReadData',
              'markNotificationRead'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GMarkAllNotificationsReadData extends GMarkAllNotificationsReadData {
  @override
  final String G__typename;
  @override
  final int markAllNotificationsRead;

  factory _$GMarkAllNotificationsReadData(
          [void Function(GMarkAllNotificationsReadDataBuilder)? updates]) =>
      (GMarkAllNotificationsReadDataBuilder()..update(updates))._build();

  _$GMarkAllNotificationsReadData._(
      {required this.G__typename, required this.markAllNotificationsRead})
      : super._();
  @override
  GMarkAllNotificationsReadData rebuild(
          void Function(GMarkAllNotificationsReadDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMarkAllNotificationsReadDataBuilder toBuilder() =>
      GMarkAllNotificationsReadDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkAllNotificationsReadData &&
        G__typename == other.G__typename &&
        markAllNotificationsRead == other.markAllNotificationsRead;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, markAllNotificationsRead.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMarkAllNotificationsReadData')
          ..add('G__typename', G__typename)
          ..add('markAllNotificationsRead', markAllNotificationsRead))
        .toString();
  }
}

class GMarkAllNotificationsReadDataBuilder
    implements
        Builder<GMarkAllNotificationsReadData,
            GMarkAllNotificationsReadDataBuilder> {
  _$GMarkAllNotificationsReadData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _markAllNotificationsRead;
  int? get markAllNotificationsRead => _$this._markAllNotificationsRead;
  set markAllNotificationsRead(int? markAllNotificationsRead) =>
      _$this._markAllNotificationsRead = markAllNotificationsRead;

  GMarkAllNotificationsReadDataBuilder() {
    GMarkAllNotificationsReadData._initializeBuilder(this);
  }

  GMarkAllNotificationsReadDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _markAllNotificationsRead = $v.markAllNotificationsRead;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMarkAllNotificationsReadData other) {
    _$v = other as _$GMarkAllNotificationsReadData;
  }

  @override
  void update(void Function(GMarkAllNotificationsReadDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMarkAllNotificationsReadData build() => _build();

  _$GMarkAllNotificationsReadData _build() {
    final _$result = _$v ??
        _$GMarkAllNotificationsReadData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GMarkAllNotificationsReadData', 'G__typename'),
          markAllNotificationsRead: BuiltValueNullFieldError.checkNotNull(
              markAllNotificationsRead,
              r'GMarkAllNotificationsReadData',
              'markAllNotificationsRead'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationReceivedData extends GNotificationReceivedData {
  @override
  final String G__typename;
  @override
  final GNotificationReceivedData_notificationReceived notificationReceived;

  factory _$GNotificationReceivedData(
          [void Function(GNotificationReceivedDataBuilder)? updates]) =>
      (GNotificationReceivedDataBuilder()..update(updates))._build();

  _$GNotificationReceivedData._(
      {required this.G__typename, required this.notificationReceived})
      : super._();
  @override
  GNotificationReceivedData rebuild(
          void Function(GNotificationReceivedDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationReceivedDataBuilder toBuilder() =>
      GNotificationReceivedDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationReceivedData &&
        G__typename == other.G__typename &&
        notificationReceived == other.notificationReceived;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, notificationReceived.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GNotificationReceivedData')
          ..add('G__typename', G__typename)
          ..add('notificationReceived', notificationReceived))
        .toString();
  }
}

class GNotificationReceivedDataBuilder
    implements
        Builder<GNotificationReceivedData, GNotificationReceivedDataBuilder> {
  _$GNotificationReceivedData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GNotificationReceivedData_notificationReceivedBuilder? _notificationReceived;
  GNotificationReceivedData_notificationReceivedBuilder
      get notificationReceived => _$this._notificationReceived ??=
          GNotificationReceivedData_notificationReceivedBuilder();
  set notificationReceived(
          GNotificationReceivedData_notificationReceivedBuilder?
              notificationReceived) =>
      _$this._notificationReceived = notificationReceived;

  GNotificationReceivedDataBuilder() {
    GNotificationReceivedData._initializeBuilder(this);
  }

  GNotificationReceivedDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _notificationReceived = $v.notificationReceived.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GNotificationReceivedData other) {
    _$v = other as _$GNotificationReceivedData;
  }

  @override
  void update(void Function(GNotificationReceivedDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationReceivedData build() => _build();

  _$GNotificationReceivedData _build() {
    _$GNotificationReceivedData _$result;
    try {
      _$result = _$v ??
          _$GNotificationReceivedData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GNotificationReceivedData', 'G__typename'),
            notificationReceived: notificationReceived.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'notificationReceived';
        notificationReceived.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GNotificationReceivedData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationReceivedData_notificationReceived
    extends GNotificationReceivedData_notificationReceived {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final _i2.GNotificationReason reason;
  @override
  final _i2.GNotificationUrgency urgency;
  @override
  final String sourceType;
  @override
  final String sourceId;
  @override
  final _i2.GTime? readAt;
  @override
  final _i2.GTime createdAt;
  @override
  final GNotificationReceivedData_notificationReceived_source? source;
  @override
  final GNotificationReceivedData_notificationReceived_sourceTag? sourceTag;

  factory _$GNotificationReceivedData_notificationReceived(
          [void Function(GNotificationReceivedData_notificationReceivedBuilder)?
              updates]) =>
      (GNotificationReceivedData_notificationReceivedBuilder()..update(updates))
          ._build();

  _$GNotificationReceivedData_notificationReceived._(
      {required this.G__typename,
      required this.id,
      required this.reason,
      required this.urgency,
      required this.sourceType,
      required this.sourceId,
      this.readAt,
      required this.createdAt,
      this.source,
      this.sourceTag})
      : super._();
  @override
  GNotificationReceivedData_notificationReceived rebuild(
          void Function(GNotificationReceivedData_notificationReceivedBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationReceivedData_notificationReceivedBuilder toBuilder() =>
      GNotificationReceivedData_notificationReceivedBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationReceivedData_notificationReceived &&
        G__typename == other.G__typename &&
        id == other.id &&
        reason == other.reason &&
        urgency == other.urgency &&
        sourceType == other.sourceType &&
        sourceId == other.sourceId &&
        readAt == other.readAt &&
        createdAt == other.createdAt &&
        source == other.source &&
        sourceTag == other.sourceTag;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, urgency.hashCode);
    _$hash = $jc(_$hash, sourceType.hashCode);
    _$hash = $jc(_$hash, sourceId.hashCode);
    _$hash = $jc(_$hash, readAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, source.hashCode);
    _$hash = $jc(_$hash, sourceTag.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationReceivedData_notificationReceived')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('reason', reason)
          ..add('urgency', urgency)
          ..add('sourceType', sourceType)
          ..add('sourceId', sourceId)
          ..add('readAt', readAt)
          ..add('createdAt', createdAt)
          ..add('source', source)
          ..add('sourceTag', sourceTag))
        .toString();
  }
}

class GNotificationReceivedData_notificationReceivedBuilder
    implements
        Builder<GNotificationReceivedData_notificationReceived,
            GNotificationReceivedData_notificationReceivedBuilder> {
  _$GNotificationReceivedData_notificationReceived? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  _i2.GNotificationReason? _reason;
  _i2.GNotificationReason? get reason => _$this._reason;
  set reason(_i2.GNotificationReason? reason) => _$this._reason = reason;

  _i2.GNotificationUrgency? _urgency;
  _i2.GNotificationUrgency? get urgency => _$this._urgency;
  set urgency(_i2.GNotificationUrgency? urgency) => _$this._urgency = urgency;

  String? _sourceType;
  String? get sourceType => _$this._sourceType;
  set sourceType(String? sourceType) => _$this._sourceType = sourceType;

  String? _sourceId;
  String? get sourceId => _$this._sourceId;
  set sourceId(String? sourceId) => _$this._sourceId = sourceId;

  _i2.GTimeBuilder? _readAt;
  _i2.GTimeBuilder get readAt => _$this._readAt ??= _i2.GTimeBuilder();
  set readAt(_i2.GTimeBuilder? readAt) => _$this._readAt = readAt;

  _i2.GTimeBuilder? _createdAt;
  _i2.GTimeBuilder get createdAt => _$this._createdAt ??= _i2.GTimeBuilder();
  set createdAt(_i2.GTimeBuilder? createdAt) => _$this._createdAt = createdAt;

  GNotificationReceivedData_notificationReceived_source? _source;
  GNotificationReceivedData_notificationReceived_source? get source =>
      _$this._source;
  set source(GNotificationReceivedData_notificationReceived_source? source) =>
      _$this._source = source;

  GNotificationReceivedData_notificationReceived_sourceTagBuilder? _sourceTag;
  GNotificationReceivedData_notificationReceived_sourceTagBuilder
      get sourceTag => _$this._sourceTag ??=
          GNotificationReceivedData_notificationReceived_sourceTagBuilder();
  set sourceTag(
          GNotificationReceivedData_notificationReceived_sourceTagBuilder?
              sourceTag) =>
      _$this._sourceTag = sourceTag;

  GNotificationReceivedData_notificationReceivedBuilder() {
    GNotificationReceivedData_notificationReceived._initializeBuilder(this);
  }

  GNotificationReceivedData_notificationReceivedBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _reason = $v.reason;
      _urgency = $v.urgency;
      _sourceType = $v.sourceType;
      _sourceId = $v.sourceId;
      _readAt = $v.readAt?.toBuilder();
      _createdAt = $v.createdAt.toBuilder();
      _source = $v.source;
      _sourceTag = $v.sourceTag?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GNotificationReceivedData_notificationReceived other) {
    _$v = other as _$GNotificationReceivedData_notificationReceived;
  }

  @override
  void update(
      void Function(GNotificationReceivedData_notificationReceivedBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationReceivedData_notificationReceived build() => _build();

  _$GNotificationReceivedData_notificationReceived _build() {
    _$GNotificationReceivedData_notificationReceived _$result;
    try {
      _$result = _$v ??
          _$GNotificationReceivedData_notificationReceived._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GNotificationReceivedData_notificationReceived',
                'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GNotificationReceivedData_notificationReceived', 'id'),
            reason: BuiltValueNullFieldError.checkNotNull(reason,
                r'GNotificationReceivedData_notificationReceived', 'reason'),
            urgency: BuiltValueNullFieldError.checkNotNull(urgency,
                r'GNotificationReceivedData_notificationReceived', 'urgency'),
            sourceType: BuiltValueNullFieldError.checkNotNull(
                sourceType,
                r'GNotificationReceivedData_notificationReceived',
                'sourceType'),
            sourceId: BuiltValueNullFieldError.checkNotNull(sourceId,
                r'GNotificationReceivedData_notificationReceived', 'sourceId'),
            readAt: _readAt?.build(),
            createdAt: createdAt.build(),
            source: source,
            sourceTag: _sourceTag?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'readAt';
        _readAt?.build();
        _$failedField = 'createdAt';
        createdAt.build();

        _$failedField = 'sourceTag';
        _sourceTag?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GNotificationReceivedData_notificationReceived',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationReceivedData_notificationReceived_source__base
    extends GNotificationReceivedData_notificationReceived_source__base {
  @override
  final String G__typename;

  factory _$GNotificationReceivedData_notificationReceived_source__base(
          [void Function(
                  GNotificationReceivedData_notificationReceived_source__baseBuilder)?
              updates]) =>
      (GNotificationReceivedData_notificationReceived_source__baseBuilder()
            ..update(updates))
          ._build();

  _$GNotificationReceivedData_notificationReceived_source__base._(
      {required this.G__typename})
      : super._();
  @override
  GNotificationReceivedData_notificationReceived_source__base rebuild(
          void Function(
                  GNotificationReceivedData_notificationReceived_source__baseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationReceivedData_notificationReceived_source__baseBuilder
      toBuilder() =>
          GNotificationReceivedData_notificationReceived_source__baseBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GNotificationReceivedData_notificationReceived_source__base &&
        G__typename == other.G__typename;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationReceivedData_notificationReceived_source__base')
          ..add('G__typename', G__typename))
        .toString();
  }
}

class GNotificationReceivedData_notificationReceived_source__baseBuilder
    implements
        Builder<GNotificationReceivedData_notificationReceived_source__base,
            GNotificationReceivedData_notificationReceived_source__baseBuilder> {
  _$GNotificationReceivedData_notificationReceived_source__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GNotificationReceivedData_notificationReceived_source__baseBuilder() {
    GNotificationReceivedData_notificationReceived_source__base
        ._initializeBuilder(this);
  }

  GNotificationReceivedData_notificationReceived_source__baseBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GNotificationReceivedData_notificationReceived_source__base other) {
    _$v =
        other as _$GNotificationReceivedData_notificationReceived_source__base;
  }

  @override
  void update(
      void Function(
              GNotificationReceivedData_notificationReceived_source__baseBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationReceivedData_notificationReceived_source__base build() =>
      _build();

  _$GNotificationReceivedData_notificationReceived_source__base _build() {
    final _$result = _$v ??
        _$GNotificationReceivedData_notificationReceived_source__base._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GNotificationReceivedData_notificationReceived_source__base',
              'G__typename'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationReceivedData_notificationReceived_source__asPost
    extends GNotificationReceivedData_notificationReceived_source__asPost {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String title;

  factory _$GNotificationReceivedData_notificationReceived_source__asPost(
          [void Function(
                  GNotificationReceivedData_notificationReceived_source__asPostBuilder)?
              updates]) =>
      (GNotificationReceivedData_notificationReceived_source__asPostBuilder()
            ..update(updates))
          ._build();

  _$GNotificationReceivedData_notificationReceived_source__asPost._(
      {required this.G__typename, required this.id, required this.title})
      : super._();
  @override
  GNotificationReceivedData_notificationReceived_source__asPost rebuild(
          void Function(
                  GNotificationReceivedData_notificationReceived_source__asPostBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationReceivedData_notificationReceived_source__asPostBuilder
      toBuilder() =>
          GNotificationReceivedData_notificationReceived_source__asPostBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GNotificationReceivedData_notificationReceived_source__asPost &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationReceivedData_notificationReceived_source__asPost')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title))
        .toString();
  }
}

class GNotificationReceivedData_notificationReceived_source__asPostBuilder
    implements
        Builder<GNotificationReceivedData_notificationReceived_source__asPost,
            GNotificationReceivedData_notificationReceived_source__asPostBuilder> {
  _$GNotificationReceivedData_notificationReceived_source__asPost? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  GNotificationReceivedData_notificationReceived_source__asPostBuilder() {
    GNotificationReceivedData_notificationReceived_source__asPost
        ._initializeBuilder(this);
  }

  GNotificationReceivedData_notificationReceived_source__asPostBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GNotificationReceivedData_notificationReceived_source__asPost other) {
    _$v = other
        as _$GNotificationReceivedData_notificationReceived_source__asPost;
  }

  @override
  void update(
      void Function(
              GNotificationReceivedData_notificationReceived_source__asPostBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationReceivedData_notificationReceived_source__asPost build() =>
      _build();

  _$GNotificationReceivedData_notificationReceived_source__asPost _build() {
    final _$result = _$v ??
        _$GNotificationReceivedData_notificationReceived_source__asPost._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GNotificationReceivedData_notificationReceived_source__asPost',
              'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GNotificationReceivedData_notificationReceived_source__asPost',
              'id'),
          title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'GNotificationReceivedData_notificationReceived_source__asPost',
              'title'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationReceivedData_notificationReceived_source__asComment
    extends GNotificationReceivedData_notificationReceived_source__asComment {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String body;

  factory _$GNotificationReceivedData_notificationReceived_source__asComment(
          [void Function(
                  GNotificationReceivedData_notificationReceived_source__asCommentBuilder)?
              updates]) =>
      (GNotificationReceivedData_notificationReceived_source__asCommentBuilder()
            ..update(updates))
          ._build();

  _$GNotificationReceivedData_notificationReceived_source__asComment._(
      {required this.G__typename, required this.id, required this.body})
      : super._();
  @override
  GNotificationReceivedData_notificationReceived_source__asComment rebuild(
          void Function(
                  GNotificationReceivedData_notificationReceived_source__asCommentBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationReceivedData_notificationReceived_source__asCommentBuilder
      toBuilder() =>
          GNotificationReceivedData_notificationReceived_source__asCommentBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GNotificationReceivedData_notificationReceived_source__asComment &&
        G__typename == other.G__typename &&
        id == other.id &&
        body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationReceivedData_notificationReceived_source__asComment')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('body', body))
        .toString();
  }
}

class GNotificationReceivedData_notificationReceived_source__asCommentBuilder
    implements
        Builder<
            GNotificationReceivedData_notificationReceived_source__asComment,
            GNotificationReceivedData_notificationReceived_source__asCommentBuilder> {
  _$GNotificationReceivedData_notificationReceived_source__asComment? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  GNotificationReceivedData_notificationReceived_source__asCommentBuilder() {
    GNotificationReceivedData_notificationReceived_source__asComment
        ._initializeBuilder(this);
  }

  GNotificationReceivedData_notificationReceived_source__asCommentBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _body = $v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GNotificationReceivedData_notificationReceived_source__asComment other) {
    _$v = other
        as _$GNotificationReceivedData_notificationReceived_source__asComment;
  }

  @override
  void update(
      void Function(
              GNotificationReceivedData_notificationReceived_source__asCommentBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationReceivedData_notificationReceived_source__asComment build() =>
      _build();

  _$GNotificationReceivedData_notificationReceived_source__asComment _build() {
    final _$result = _$v ??
        _$GNotificationReceivedData_notificationReceived_source__asComment._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GNotificationReceivedData_notificationReceived_source__asComment',
              'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GNotificationReceivedData_notificationReceived_source__asComment',
              'id'),
          body: BuiltValueNullFieldError.checkNotNull(
              body,
              r'GNotificationReceivedData_notificationReceived_source__asComment',
              'body'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationReceivedData_notificationReceived_source__asTask
    extends GNotificationReceivedData_notificationReceived_source__asTask {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String title;
  @override
  final _i2.GTaskStatus status;

  factory _$GNotificationReceivedData_notificationReceived_source__asTask(
          [void Function(
                  GNotificationReceivedData_notificationReceived_source__asTaskBuilder)?
              updates]) =>
      (GNotificationReceivedData_notificationReceived_source__asTaskBuilder()
            ..update(updates))
          ._build();

  _$GNotificationReceivedData_notificationReceived_source__asTask._(
      {required this.G__typename,
      required this.id,
      required this.title,
      required this.status})
      : super._();
  @override
  GNotificationReceivedData_notificationReceived_source__asTask rebuild(
          void Function(
                  GNotificationReceivedData_notificationReceived_source__asTaskBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationReceivedData_notificationReceived_source__asTaskBuilder
      toBuilder() =>
          GNotificationReceivedData_notificationReceived_source__asTaskBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GNotificationReceivedData_notificationReceived_source__asTask &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationReceivedData_notificationReceived_source__asTask')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('status', status))
        .toString();
  }
}

class GNotificationReceivedData_notificationReceived_source__asTaskBuilder
    implements
        Builder<GNotificationReceivedData_notificationReceived_source__asTask,
            GNotificationReceivedData_notificationReceived_source__asTaskBuilder> {
  _$GNotificationReceivedData_notificationReceived_source__asTask? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  _i2.GTaskStatus? _status;
  _i2.GTaskStatus? get status => _$this._status;
  set status(_i2.GTaskStatus? status) => _$this._status = status;

  GNotificationReceivedData_notificationReceived_source__asTaskBuilder() {
    GNotificationReceivedData_notificationReceived_source__asTask
        ._initializeBuilder(this);
  }

  GNotificationReceivedData_notificationReceived_source__asTaskBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GNotificationReceivedData_notificationReceived_source__asTask other) {
    _$v = other
        as _$GNotificationReceivedData_notificationReceived_source__asTask;
  }

  @override
  void update(
      void Function(
              GNotificationReceivedData_notificationReceived_source__asTaskBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationReceivedData_notificationReceived_source__asTask build() =>
      _build();

  _$GNotificationReceivedData_notificationReceived_source__asTask _build() {
    final _$result = _$v ??
        _$GNotificationReceivedData_notificationReceived_source__asTask._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GNotificationReceivedData_notificationReceived_source__asTask',
              'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GNotificationReceivedData_notificationReceived_source__asTask',
              'id'),
          title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'GNotificationReceivedData_notificationReceived_source__asTask',
              'title'),
          status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GNotificationReceivedData_notificationReceived_source__asTask',
              'status'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationReceivedData_notificationReceived_source__asMessage
    extends GNotificationReceivedData_notificationReceived_source__asMessage {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String body;

  factory _$GNotificationReceivedData_notificationReceived_source__asMessage(
          [void Function(
                  GNotificationReceivedData_notificationReceived_source__asMessageBuilder)?
              updates]) =>
      (GNotificationReceivedData_notificationReceived_source__asMessageBuilder()
            ..update(updates))
          ._build();

  _$GNotificationReceivedData_notificationReceived_source__asMessage._(
      {required this.G__typename, required this.id, required this.body})
      : super._();
  @override
  GNotificationReceivedData_notificationReceived_source__asMessage rebuild(
          void Function(
                  GNotificationReceivedData_notificationReceived_source__asMessageBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationReceivedData_notificationReceived_source__asMessageBuilder
      toBuilder() =>
          GNotificationReceivedData_notificationReceived_source__asMessageBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GNotificationReceivedData_notificationReceived_source__asMessage &&
        G__typename == other.G__typename &&
        id == other.id &&
        body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationReceivedData_notificationReceived_source__asMessage')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('body', body))
        .toString();
  }
}

class GNotificationReceivedData_notificationReceived_source__asMessageBuilder
    implements
        Builder<
            GNotificationReceivedData_notificationReceived_source__asMessage,
            GNotificationReceivedData_notificationReceived_source__asMessageBuilder> {
  _$GNotificationReceivedData_notificationReceived_source__asMessage? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  GNotificationReceivedData_notificationReceived_source__asMessageBuilder() {
    GNotificationReceivedData_notificationReceived_source__asMessage
        ._initializeBuilder(this);
  }

  GNotificationReceivedData_notificationReceived_source__asMessageBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _body = $v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GNotificationReceivedData_notificationReceived_source__asMessage other) {
    _$v = other
        as _$GNotificationReceivedData_notificationReceived_source__asMessage;
  }

  @override
  void update(
      void Function(
              GNotificationReceivedData_notificationReceived_source__asMessageBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationReceivedData_notificationReceived_source__asMessage build() =>
      _build();

  _$GNotificationReceivedData_notificationReceived_source__asMessage _build() {
    final _$result = _$v ??
        _$GNotificationReceivedData_notificationReceived_source__asMessage._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GNotificationReceivedData_notificationReceived_source__asMessage',
              'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GNotificationReceivedData_notificationReceived_source__asMessage',
              'id'),
          body: BuiltValueNullFieldError.checkNotNull(
              body,
              r'GNotificationReceivedData_notificationReceived_source__asMessage',
              'body'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationReceivedData_notificationReceived_sourceTag
    extends GNotificationReceivedData_notificationReceived_sourceTag {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String slug;
  @override
  final String displayName;

  factory _$GNotificationReceivedData_notificationReceived_sourceTag(
          [void Function(
                  GNotificationReceivedData_notificationReceived_sourceTagBuilder)?
              updates]) =>
      (GNotificationReceivedData_notificationReceived_sourceTagBuilder()
            ..update(updates))
          ._build();

  _$GNotificationReceivedData_notificationReceived_sourceTag._(
      {required this.G__typename,
      required this.id,
      required this.slug,
      required this.displayName})
      : super._();
  @override
  GNotificationReceivedData_notificationReceived_sourceTag rebuild(
          void Function(
                  GNotificationReceivedData_notificationReceived_sourceTagBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationReceivedData_notificationReceived_sourceTagBuilder toBuilder() =>
      GNotificationReceivedData_notificationReceived_sourceTagBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationReceivedData_notificationReceived_sourceTag &&
        G__typename == other.G__typename &&
        id == other.id &&
        slug == other.slug &&
        displayName == other.displayName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationReceivedData_notificationReceived_sourceTag')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('slug', slug)
          ..add('displayName', displayName))
        .toString();
  }
}

class GNotificationReceivedData_notificationReceived_sourceTagBuilder
    implements
        Builder<GNotificationReceivedData_notificationReceived_sourceTag,
            GNotificationReceivedData_notificationReceived_sourceTagBuilder> {
  _$GNotificationReceivedData_notificationReceived_sourceTag? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _slug;
  String? get slug => _$this._slug;
  set slug(String? slug) => _$this._slug = slug;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GNotificationReceivedData_notificationReceived_sourceTagBuilder() {
    GNotificationReceivedData_notificationReceived_sourceTag._initializeBuilder(
        this);
  }

  GNotificationReceivedData_notificationReceived_sourceTagBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _slug = $v.slug;
      _displayName = $v.displayName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GNotificationReceivedData_notificationReceived_sourceTag other) {
    _$v = other as _$GNotificationReceivedData_notificationReceived_sourceTag;
  }

  @override
  void update(
      void Function(
              GNotificationReceivedData_notificationReceived_sourceTagBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationReceivedData_notificationReceived_sourceTag build() => _build();

  _$GNotificationReceivedData_notificationReceived_sourceTag _build() {
    final _$result = _$v ??
        _$GNotificationReceivedData_notificationReceived_sourceTag._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GNotificationReceivedData_notificationReceived_sourceTag',
              'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GNotificationReceivedData_notificationReceived_sourceTag',
              'id'),
          slug: BuiltValueNullFieldError.checkNotNull(
              slug,
              r'GNotificationReceivedData_notificationReceived_sourceTag',
              'slug'),
          displayName: BuiltValueNullFieldError.checkNotNull(
              displayName,
              r'GNotificationReceivedData_notificationReceived_sourceTag',
              'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationSummaryData extends GNotificationSummaryData {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final _i2.GNotificationReason reason;
  @override
  final _i2.GNotificationUrgency urgency;
  @override
  final String sourceType;
  @override
  final String sourceId;
  @override
  final _i2.GTime? readAt;
  @override
  final _i2.GTime createdAt;
  @override
  final GNotificationSummaryData_source? source;
  @override
  final GNotificationSummaryData_sourceTag? sourceTag;

  factory _$GNotificationSummaryData(
          [void Function(GNotificationSummaryDataBuilder)? updates]) =>
      (GNotificationSummaryDataBuilder()..update(updates))._build();

  _$GNotificationSummaryData._(
      {required this.G__typename,
      required this.id,
      required this.reason,
      required this.urgency,
      required this.sourceType,
      required this.sourceId,
      this.readAt,
      required this.createdAt,
      this.source,
      this.sourceTag})
      : super._();
  @override
  GNotificationSummaryData rebuild(
          void Function(GNotificationSummaryDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationSummaryDataBuilder toBuilder() =>
      GNotificationSummaryDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationSummaryData &&
        G__typename == other.G__typename &&
        id == other.id &&
        reason == other.reason &&
        urgency == other.urgency &&
        sourceType == other.sourceType &&
        sourceId == other.sourceId &&
        readAt == other.readAt &&
        createdAt == other.createdAt &&
        source == other.source &&
        sourceTag == other.sourceTag;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, urgency.hashCode);
    _$hash = $jc(_$hash, sourceType.hashCode);
    _$hash = $jc(_$hash, sourceId.hashCode);
    _$hash = $jc(_$hash, readAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, source.hashCode);
    _$hash = $jc(_$hash, sourceTag.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GNotificationSummaryData')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('reason', reason)
          ..add('urgency', urgency)
          ..add('sourceType', sourceType)
          ..add('sourceId', sourceId)
          ..add('readAt', readAt)
          ..add('createdAt', createdAt)
          ..add('source', source)
          ..add('sourceTag', sourceTag))
        .toString();
  }
}

class GNotificationSummaryDataBuilder
    implements
        Builder<GNotificationSummaryData, GNotificationSummaryDataBuilder> {
  _$GNotificationSummaryData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  _i2.GNotificationReason? _reason;
  _i2.GNotificationReason? get reason => _$this._reason;
  set reason(_i2.GNotificationReason? reason) => _$this._reason = reason;

  _i2.GNotificationUrgency? _urgency;
  _i2.GNotificationUrgency? get urgency => _$this._urgency;
  set urgency(_i2.GNotificationUrgency? urgency) => _$this._urgency = urgency;

  String? _sourceType;
  String? get sourceType => _$this._sourceType;
  set sourceType(String? sourceType) => _$this._sourceType = sourceType;

  String? _sourceId;
  String? get sourceId => _$this._sourceId;
  set sourceId(String? sourceId) => _$this._sourceId = sourceId;

  _i2.GTimeBuilder? _readAt;
  _i2.GTimeBuilder get readAt => _$this._readAt ??= _i2.GTimeBuilder();
  set readAt(_i2.GTimeBuilder? readAt) => _$this._readAt = readAt;

  _i2.GTimeBuilder? _createdAt;
  _i2.GTimeBuilder get createdAt => _$this._createdAt ??= _i2.GTimeBuilder();
  set createdAt(_i2.GTimeBuilder? createdAt) => _$this._createdAt = createdAt;

  GNotificationSummaryData_source? _source;
  GNotificationSummaryData_source? get source => _$this._source;
  set source(GNotificationSummaryData_source? source) =>
      _$this._source = source;

  GNotificationSummaryData_sourceTagBuilder? _sourceTag;
  GNotificationSummaryData_sourceTagBuilder get sourceTag =>
      _$this._sourceTag ??= GNotificationSummaryData_sourceTagBuilder();
  set sourceTag(GNotificationSummaryData_sourceTagBuilder? sourceTag) =>
      _$this._sourceTag = sourceTag;

  GNotificationSummaryDataBuilder() {
    GNotificationSummaryData._initializeBuilder(this);
  }

  GNotificationSummaryDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _reason = $v.reason;
      _urgency = $v.urgency;
      _sourceType = $v.sourceType;
      _sourceId = $v.sourceId;
      _readAt = $v.readAt?.toBuilder();
      _createdAt = $v.createdAt.toBuilder();
      _source = $v.source;
      _sourceTag = $v.sourceTag?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GNotificationSummaryData other) {
    _$v = other as _$GNotificationSummaryData;
  }

  @override
  void update(void Function(GNotificationSummaryDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationSummaryData build() => _build();

  _$GNotificationSummaryData _build() {
    _$GNotificationSummaryData _$result;
    try {
      _$result = _$v ??
          _$GNotificationSummaryData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GNotificationSummaryData', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GNotificationSummaryData', 'id'),
            reason: BuiltValueNullFieldError.checkNotNull(
                reason, r'GNotificationSummaryData', 'reason'),
            urgency: BuiltValueNullFieldError.checkNotNull(
                urgency, r'GNotificationSummaryData', 'urgency'),
            sourceType: BuiltValueNullFieldError.checkNotNull(
                sourceType, r'GNotificationSummaryData', 'sourceType'),
            sourceId: BuiltValueNullFieldError.checkNotNull(
                sourceId, r'GNotificationSummaryData', 'sourceId'),
            readAt: _readAt?.build(),
            createdAt: createdAt.build(),
            source: source,
            sourceTag: _sourceTag?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'readAt';
        _readAt?.build();
        _$failedField = 'createdAt';
        createdAt.build();

        _$failedField = 'sourceTag';
        _sourceTag?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GNotificationSummaryData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationSummaryData_source__base
    extends GNotificationSummaryData_source__base {
  @override
  final String G__typename;

  factory _$GNotificationSummaryData_source__base(
          [void Function(GNotificationSummaryData_source__baseBuilder)?
              updates]) =>
      (GNotificationSummaryData_source__baseBuilder()..update(updates))
          ._build();

  _$GNotificationSummaryData_source__base._({required this.G__typename})
      : super._();
  @override
  GNotificationSummaryData_source__base rebuild(
          void Function(GNotificationSummaryData_source__baseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationSummaryData_source__baseBuilder toBuilder() =>
      GNotificationSummaryData_source__baseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationSummaryData_source__base &&
        G__typename == other.G__typename;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationSummaryData_source__base')
          ..add('G__typename', G__typename))
        .toString();
  }
}

class GNotificationSummaryData_source__baseBuilder
    implements
        Builder<GNotificationSummaryData_source__base,
            GNotificationSummaryData_source__baseBuilder> {
  _$GNotificationSummaryData_source__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GNotificationSummaryData_source__baseBuilder() {
    GNotificationSummaryData_source__base._initializeBuilder(this);
  }

  GNotificationSummaryData_source__baseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GNotificationSummaryData_source__base other) {
    _$v = other as _$GNotificationSummaryData_source__base;
  }

  @override
  void update(
      void Function(GNotificationSummaryData_source__baseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationSummaryData_source__base build() => _build();

  _$GNotificationSummaryData_source__base _build() {
    final _$result = _$v ??
        _$GNotificationSummaryData_source__base._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GNotificationSummaryData_source__base', 'G__typename'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationSummaryData_source__asPost
    extends GNotificationSummaryData_source__asPost {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String title;

  factory _$GNotificationSummaryData_source__asPost(
          [void Function(GNotificationSummaryData_source__asPostBuilder)?
              updates]) =>
      (GNotificationSummaryData_source__asPostBuilder()..update(updates))
          ._build();

  _$GNotificationSummaryData_source__asPost._(
      {required this.G__typename, required this.id, required this.title})
      : super._();
  @override
  GNotificationSummaryData_source__asPost rebuild(
          void Function(GNotificationSummaryData_source__asPostBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationSummaryData_source__asPostBuilder toBuilder() =>
      GNotificationSummaryData_source__asPostBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationSummaryData_source__asPost &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationSummaryData_source__asPost')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title))
        .toString();
  }
}

class GNotificationSummaryData_source__asPostBuilder
    implements
        Builder<GNotificationSummaryData_source__asPost,
            GNotificationSummaryData_source__asPostBuilder> {
  _$GNotificationSummaryData_source__asPost? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  GNotificationSummaryData_source__asPostBuilder() {
    GNotificationSummaryData_source__asPost._initializeBuilder(this);
  }

  GNotificationSummaryData_source__asPostBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GNotificationSummaryData_source__asPost other) {
    _$v = other as _$GNotificationSummaryData_source__asPost;
  }

  @override
  void update(
      void Function(GNotificationSummaryData_source__asPostBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationSummaryData_source__asPost build() => _build();

  _$GNotificationSummaryData_source__asPost _build() {
    final _$result = _$v ??
        _$GNotificationSummaryData_source__asPost._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GNotificationSummaryData_source__asPost', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GNotificationSummaryData_source__asPost', 'id'),
          title: BuiltValueNullFieldError.checkNotNull(
              title, r'GNotificationSummaryData_source__asPost', 'title'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationSummaryData_source__asComment
    extends GNotificationSummaryData_source__asComment {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String body;

  factory _$GNotificationSummaryData_source__asComment(
          [void Function(GNotificationSummaryData_source__asCommentBuilder)?
              updates]) =>
      (GNotificationSummaryData_source__asCommentBuilder()..update(updates))
          ._build();

  _$GNotificationSummaryData_source__asComment._(
      {required this.G__typename, required this.id, required this.body})
      : super._();
  @override
  GNotificationSummaryData_source__asComment rebuild(
          void Function(GNotificationSummaryData_source__asCommentBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationSummaryData_source__asCommentBuilder toBuilder() =>
      GNotificationSummaryData_source__asCommentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationSummaryData_source__asComment &&
        G__typename == other.G__typename &&
        id == other.id &&
        body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationSummaryData_source__asComment')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('body', body))
        .toString();
  }
}

class GNotificationSummaryData_source__asCommentBuilder
    implements
        Builder<GNotificationSummaryData_source__asComment,
            GNotificationSummaryData_source__asCommentBuilder> {
  _$GNotificationSummaryData_source__asComment? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  GNotificationSummaryData_source__asCommentBuilder() {
    GNotificationSummaryData_source__asComment._initializeBuilder(this);
  }

  GNotificationSummaryData_source__asCommentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _body = $v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GNotificationSummaryData_source__asComment other) {
    _$v = other as _$GNotificationSummaryData_source__asComment;
  }

  @override
  void update(
      void Function(GNotificationSummaryData_source__asCommentBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationSummaryData_source__asComment build() => _build();

  _$GNotificationSummaryData_source__asComment _build() {
    final _$result = _$v ??
        _$GNotificationSummaryData_source__asComment._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GNotificationSummaryData_source__asComment', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GNotificationSummaryData_source__asComment', 'id'),
          body: BuiltValueNullFieldError.checkNotNull(
              body, r'GNotificationSummaryData_source__asComment', 'body'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationSummaryData_source__asTask
    extends GNotificationSummaryData_source__asTask {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String title;
  @override
  final _i2.GTaskStatus status;

  factory _$GNotificationSummaryData_source__asTask(
          [void Function(GNotificationSummaryData_source__asTaskBuilder)?
              updates]) =>
      (GNotificationSummaryData_source__asTaskBuilder()..update(updates))
          ._build();

  _$GNotificationSummaryData_source__asTask._(
      {required this.G__typename,
      required this.id,
      required this.title,
      required this.status})
      : super._();
  @override
  GNotificationSummaryData_source__asTask rebuild(
          void Function(GNotificationSummaryData_source__asTaskBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationSummaryData_source__asTaskBuilder toBuilder() =>
      GNotificationSummaryData_source__asTaskBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationSummaryData_source__asTask &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationSummaryData_source__asTask')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('status', status))
        .toString();
  }
}

class GNotificationSummaryData_source__asTaskBuilder
    implements
        Builder<GNotificationSummaryData_source__asTask,
            GNotificationSummaryData_source__asTaskBuilder> {
  _$GNotificationSummaryData_source__asTask? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  _i2.GTaskStatus? _status;
  _i2.GTaskStatus? get status => _$this._status;
  set status(_i2.GTaskStatus? status) => _$this._status = status;

  GNotificationSummaryData_source__asTaskBuilder() {
    GNotificationSummaryData_source__asTask._initializeBuilder(this);
  }

  GNotificationSummaryData_source__asTaskBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GNotificationSummaryData_source__asTask other) {
    _$v = other as _$GNotificationSummaryData_source__asTask;
  }

  @override
  void update(
      void Function(GNotificationSummaryData_source__asTaskBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationSummaryData_source__asTask build() => _build();

  _$GNotificationSummaryData_source__asTask _build() {
    final _$result = _$v ??
        _$GNotificationSummaryData_source__asTask._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GNotificationSummaryData_source__asTask', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GNotificationSummaryData_source__asTask', 'id'),
          title: BuiltValueNullFieldError.checkNotNull(
              title, r'GNotificationSummaryData_source__asTask', 'title'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'GNotificationSummaryData_source__asTask', 'status'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationSummaryData_source__asMessage
    extends GNotificationSummaryData_source__asMessage {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String body;

  factory _$GNotificationSummaryData_source__asMessage(
          [void Function(GNotificationSummaryData_source__asMessageBuilder)?
              updates]) =>
      (GNotificationSummaryData_source__asMessageBuilder()..update(updates))
          ._build();

  _$GNotificationSummaryData_source__asMessage._(
      {required this.G__typename, required this.id, required this.body})
      : super._();
  @override
  GNotificationSummaryData_source__asMessage rebuild(
          void Function(GNotificationSummaryData_source__asMessageBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationSummaryData_source__asMessageBuilder toBuilder() =>
      GNotificationSummaryData_source__asMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationSummaryData_source__asMessage &&
        G__typename == other.G__typename &&
        id == other.id &&
        body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationSummaryData_source__asMessage')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('body', body))
        .toString();
  }
}

class GNotificationSummaryData_source__asMessageBuilder
    implements
        Builder<GNotificationSummaryData_source__asMessage,
            GNotificationSummaryData_source__asMessageBuilder> {
  _$GNotificationSummaryData_source__asMessage? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  GNotificationSummaryData_source__asMessageBuilder() {
    GNotificationSummaryData_source__asMessage._initializeBuilder(this);
  }

  GNotificationSummaryData_source__asMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _body = $v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GNotificationSummaryData_source__asMessage other) {
    _$v = other as _$GNotificationSummaryData_source__asMessage;
  }

  @override
  void update(
      void Function(GNotificationSummaryData_source__asMessageBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationSummaryData_source__asMessage build() => _build();

  _$GNotificationSummaryData_source__asMessage _build() {
    final _$result = _$v ??
        _$GNotificationSummaryData_source__asMessage._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GNotificationSummaryData_source__asMessage', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GNotificationSummaryData_source__asMessage', 'id'),
          body: BuiltValueNullFieldError.checkNotNull(
              body, r'GNotificationSummaryData_source__asMessage', 'body'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationSummaryData_sourceTag
    extends GNotificationSummaryData_sourceTag {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String slug;
  @override
  final String displayName;

  factory _$GNotificationSummaryData_sourceTag(
          [void Function(GNotificationSummaryData_sourceTagBuilder)?
              updates]) =>
      (GNotificationSummaryData_sourceTagBuilder()..update(updates))._build();

  _$GNotificationSummaryData_sourceTag._(
      {required this.G__typename,
      required this.id,
      required this.slug,
      required this.displayName})
      : super._();
  @override
  GNotificationSummaryData_sourceTag rebuild(
          void Function(GNotificationSummaryData_sourceTagBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationSummaryData_sourceTagBuilder toBuilder() =>
      GNotificationSummaryData_sourceTagBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationSummaryData_sourceTag &&
        G__typename == other.G__typename &&
        id == other.id &&
        slug == other.slug &&
        displayName == other.displayName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GNotificationSummaryData_sourceTag')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('slug', slug)
          ..add('displayName', displayName))
        .toString();
  }
}

class GNotificationSummaryData_sourceTagBuilder
    implements
        Builder<GNotificationSummaryData_sourceTag,
            GNotificationSummaryData_sourceTagBuilder> {
  _$GNotificationSummaryData_sourceTag? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _slug;
  String? get slug => _$this._slug;
  set slug(String? slug) => _$this._slug = slug;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GNotificationSummaryData_sourceTagBuilder() {
    GNotificationSummaryData_sourceTag._initializeBuilder(this);
  }

  GNotificationSummaryData_sourceTagBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _slug = $v.slug;
      _displayName = $v.displayName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GNotificationSummaryData_sourceTag other) {
    _$v = other as _$GNotificationSummaryData_sourceTag;
  }

  @override
  void update(
      void Function(GNotificationSummaryData_sourceTagBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationSummaryData_sourceTag build() => _build();

  _$GNotificationSummaryData_sourceTag _build() {
    final _$result = _$v ??
        _$GNotificationSummaryData_sourceTag._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GNotificationSummaryData_sourceTag', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GNotificationSummaryData_sourceTag', 'id'),
          slug: BuiltValueNullFieldError.checkNotNull(
              slug, r'GNotificationSummaryData_sourceTag', 'slug'),
          displayName: BuiltValueNullFieldError.checkNotNull(displayName,
              r'GNotificationSummaryData_sourceTag', 'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
