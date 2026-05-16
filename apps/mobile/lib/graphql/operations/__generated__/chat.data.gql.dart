// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pulse/graphql/__generated__/schema.schema.gql.dart' as _i2;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i1;

part 'chat.data.gql.g.dart';

abstract class GChatRoomDetailData
    implements Built<GChatRoomDetailData, GChatRoomDetailDataBuilder> {
  GChatRoomDetailData._();

  factory GChatRoomDetailData(
          [void Function(GChatRoomDetailDataBuilder b) updates]) =
      _$GChatRoomDetailData;

  static void _initializeBuilder(GChatRoomDetailDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GChatRoomDetailData_chatRoom? get chatRoom;
  static Serializer<GChatRoomDetailData> get serializer =>
      _$gChatRoomDetailDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatRoomDetailData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomDetailData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChatRoomDetailData.serializer,
        json,
      );
}

abstract class GChatRoomDetailData_chatRoom
    implements
        Built<GChatRoomDetailData_chatRoom,
            GChatRoomDetailData_chatRoomBuilder>,
        GChatRoomSummary {
  GChatRoomDetailData_chatRoom._();

  factory GChatRoomDetailData_chatRoom(
          [void Function(GChatRoomDetailData_chatRoomBuilder b) updates]) =
      _$GChatRoomDetailData_chatRoom;

  static void _initializeBuilder(GChatRoomDetailData_chatRoomBuilder b) =>
      b..G__typename = 'ChatRoom';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  bool get isDM;
  @override
  _i2.GTime get createdAt;
  @override
  _i2.GTime? get archivedAt;
  @override
  BuiltList<GChatRoomDetailData_chatRoom_tags> get tags;
  @override
  BuiltList<GChatRoomDetailData_chatRoom_participants> get participants;
  GChatRoomDetailData_chatRoom_messages get messages;
  static Serializer<GChatRoomDetailData_chatRoom> get serializer =>
      _$gChatRoomDetailDataChatRoomSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatRoomDetailData_chatRoom.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomDetailData_chatRoom? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChatRoomDetailData_chatRoom.serializer,
        json,
      );
}

abstract class GChatRoomDetailData_chatRoom_tags
    implements
        Built<GChatRoomDetailData_chatRoom_tags,
            GChatRoomDetailData_chatRoom_tagsBuilder>,
        GChatRoomSummary_tags {
  GChatRoomDetailData_chatRoom_tags._();

  factory GChatRoomDetailData_chatRoom_tags(
          [void Function(GChatRoomDetailData_chatRoom_tagsBuilder b) updates]) =
      _$GChatRoomDetailData_chatRoom_tags;

  static void _initializeBuilder(GChatRoomDetailData_chatRoom_tagsBuilder b) =>
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
  static Serializer<GChatRoomDetailData_chatRoom_tags> get serializer =>
      _$gChatRoomDetailDataChatRoomTagsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatRoomDetailData_chatRoom_tags.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomDetailData_chatRoom_tags? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChatRoomDetailData_chatRoom_tags.serializer,
        json,
      );
}

abstract class GChatRoomDetailData_chatRoom_participants
    implements
        Built<GChatRoomDetailData_chatRoom_participants,
            GChatRoomDetailData_chatRoom_participantsBuilder>,
        GChatRoomSummary_participants {
  GChatRoomDetailData_chatRoom_participants._();

  factory GChatRoomDetailData_chatRoom_participants(
      [void Function(GChatRoomDetailData_chatRoom_participantsBuilder b)
          updates]) = _$GChatRoomDetailData_chatRoom_participants;

  static void _initializeBuilder(
          GChatRoomDetailData_chatRoom_participantsBuilder b) =>
      b..G__typename = 'ChatRoomParticipant';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GChatRoomDetailData_chatRoom_participants_principal get principal;
  static Serializer<GChatRoomDetailData_chatRoom_participants> get serializer =>
      _$gChatRoomDetailDataChatRoomParticipantsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatRoomDetailData_chatRoom_participants.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomDetailData_chatRoom_participants? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChatRoomDetailData_chatRoom_participants.serializer,
        json,
      );
}

abstract class GChatRoomDetailData_chatRoom_participants_principal
    implements
        Built<GChatRoomDetailData_chatRoom_participants_principal,
            GChatRoomDetailData_chatRoom_participants_principalBuilder>,
        GChatRoomSummary_participants_principal {
  GChatRoomDetailData_chatRoom_participants_principal._();

  factory GChatRoomDetailData_chatRoom_participants_principal(
      [void Function(
              GChatRoomDetailData_chatRoom_participants_principalBuilder b)
          updates]) = _$GChatRoomDetailData_chatRoom_participants_principal;

  static void _initializeBuilder(
          GChatRoomDetailData_chatRoom_participants_principalBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  static Serializer<GChatRoomDetailData_chatRoom_participants_principal>
      get serializer =>
          _$gChatRoomDetailDataChatRoomParticipantsPrincipalSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatRoomDetailData_chatRoom_participants_principal.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomDetailData_chatRoom_participants_principal? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChatRoomDetailData_chatRoom_participants_principal.serializer,
        json,
      );
}

abstract class GChatRoomDetailData_chatRoom_messages
    implements
        Built<GChatRoomDetailData_chatRoom_messages,
            GChatRoomDetailData_chatRoom_messagesBuilder> {
  GChatRoomDetailData_chatRoom_messages._();

  factory GChatRoomDetailData_chatRoom_messages(
      [void Function(GChatRoomDetailData_chatRoom_messagesBuilder b)
          updates]) = _$GChatRoomDetailData_chatRoom_messages;

  static void _initializeBuilder(
          GChatRoomDetailData_chatRoom_messagesBuilder b) =>
      b..G__typename = 'MessageConnection';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GChatRoomDetailData_chatRoom_messages_edges> get edges;
  static Serializer<GChatRoomDetailData_chatRoom_messages> get serializer =>
      _$gChatRoomDetailDataChatRoomMessagesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatRoomDetailData_chatRoom_messages.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomDetailData_chatRoom_messages? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChatRoomDetailData_chatRoom_messages.serializer,
        json,
      );
}

abstract class GChatRoomDetailData_chatRoom_messages_edges
    implements
        Built<GChatRoomDetailData_chatRoom_messages_edges,
            GChatRoomDetailData_chatRoom_messages_edgesBuilder> {
  GChatRoomDetailData_chatRoom_messages_edges._();

  factory GChatRoomDetailData_chatRoom_messages_edges(
      [void Function(GChatRoomDetailData_chatRoom_messages_edgesBuilder b)
          updates]) = _$GChatRoomDetailData_chatRoom_messages_edges;

  static void _initializeBuilder(
          GChatRoomDetailData_chatRoom_messages_edgesBuilder b) =>
      b..G__typename = 'MessageEdge';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get cursor;
  GChatRoomDetailData_chatRoom_messages_edges_node get node;
  static Serializer<GChatRoomDetailData_chatRoom_messages_edges>
      get serializer => _$gChatRoomDetailDataChatRoomMessagesEdgesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatRoomDetailData_chatRoom_messages_edges.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomDetailData_chatRoom_messages_edges? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChatRoomDetailData_chatRoom_messages_edges.serializer,
        json,
      );
}

abstract class GChatRoomDetailData_chatRoom_messages_edges_node
    implements
        Built<GChatRoomDetailData_chatRoom_messages_edges_node,
            GChatRoomDetailData_chatRoom_messages_edges_nodeBuilder>,
        GMessageSummary {
  GChatRoomDetailData_chatRoom_messages_edges_node._();

  factory GChatRoomDetailData_chatRoom_messages_edges_node(
      [void Function(GChatRoomDetailData_chatRoom_messages_edges_nodeBuilder b)
          updates]) = _$GChatRoomDetailData_chatRoom_messages_edges_node;

  static void _initializeBuilder(
          GChatRoomDetailData_chatRoom_messages_edges_nodeBuilder b) =>
      b..G__typename = 'Message';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get body;
  @override
  _i2.GTime get createdAt;
  @override
  _i2.GTime? get editedAt;
  @override
  GChatRoomDetailData_chatRoom_messages_edges_node_author get author;
  @override
  BuiltList<GChatRoomDetailData_chatRoom_messages_edges_node_mentions>
      get mentions;
  @override
  BuiltList<GChatRoomDetailData_chatRoom_messages_edges_node_referencedTags>
      get referencedTags;
  @override
  GChatRoomDetailData_chatRoom_messages_edges_node_replyTo? get replyTo;
  static Serializer<GChatRoomDetailData_chatRoom_messages_edges_node>
      get serializer =>
          _$gChatRoomDetailDataChatRoomMessagesEdgesNodeSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatRoomDetailData_chatRoom_messages_edges_node.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomDetailData_chatRoom_messages_edges_node? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChatRoomDetailData_chatRoom_messages_edges_node.serializer,
        json,
      );
}

abstract class GChatRoomDetailData_chatRoom_messages_edges_node_author
    implements
        Built<GChatRoomDetailData_chatRoom_messages_edges_node_author,
            GChatRoomDetailData_chatRoom_messages_edges_node_authorBuilder>,
        GMessageSummary_author {
  GChatRoomDetailData_chatRoom_messages_edges_node_author._();

  factory GChatRoomDetailData_chatRoom_messages_edges_node_author(
      [void Function(
              GChatRoomDetailData_chatRoom_messages_edges_node_authorBuilder b)
          updates]) = _$GChatRoomDetailData_chatRoom_messages_edges_node_author;

  static void _initializeBuilder(
          GChatRoomDetailData_chatRoom_messages_edges_node_authorBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  @override
  GChatRoomDetailData_chatRoom_messages_edges_node_author_homeTag? get homeTag;
  static Serializer<GChatRoomDetailData_chatRoom_messages_edges_node_author>
      get serializer =>
          _$gChatRoomDetailDataChatRoomMessagesEdgesNodeAuthorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatRoomDetailData_chatRoom_messages_edges_node_author.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomDetailData_chatRoom_messages_edges_node_author? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChatRoomDetailData_chatRoom_messages_edges_node_author.serializer,
        json,
      );
}

abstract class GChatRoomDetailData_chatRoom_messages_edges_node_author_homeTag
    implements
        Built<GChatRoomDetailData_chatRoom_messages_edges_node_author_homeTag,
            GChatRoomDetailData_chatRoom_messages_edges_node_author_homeTagBuilder>,
        GMessageSummary_author_homeTag {
  GChatRoomDetailData_chatRoom_messages_edges_node_author_homeTag._();

  factory GChatRoomDetailData_chatRoom_messages_edges_node_author_homeTag(
          [void Function(
                  GChatRoomDetailData_chatRoom_messages_edges_node_author_homeTagBuilder
                      b)
              updates]) =
      _$GChatRoomDetailData_chatRoom_messages_edges_node_author_homeTag;

  static void _initializeBuilder(
          GChatRoomDetailData_chatRoom_messages_edges_node_author_homeTagBuilder
              b) =>
      b..G__typename = 'Tag';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get slug;
  @override
  String get path;
  static Serializer<
          GChatRoomDetailData_chatRoom_messages_edges_node_author_homeTag>
      get serializer =>
          _$gChatRoomDetailDataChatRoomMessagesEdgesNodeAuthorHomeTagSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatRoomDetailData_chatRoom_messages_edges_node_author_homeTag
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomDetailData_chatRoom_messages_edges_node_author_homeTag?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GChatRoomDetailData_chatRoom_messages_edges_node_author_homeTag
                .serializer,
            json,
          );
}

abstract class GChatRoomDetailData_chatRoom_messages_edges_node_mentions
    implements
        Built<GChatRoomDetailData_chatRoom_messages_edges_node_mentions,
            GChatRoomDetailData_chatRoom_messages_edges_node_mentionsBuilder>,
        GMessageSummary_mentions {
  GChatRoomDetailData_chatRoom_messages_edges_node_mentions._();

  factory GChatRoomDetailData_chatRoom_messages_edges_node_mentions(
      [void Function(
              GChatRoomDetailData_chatRoom_messages_edges_node_mentionsBuilder
                  b)
          updates]) = _$GChatRoomDetailData_chatRoom_messages_edges_node_mentions;

  static void _initializeBuilder(
          GChatRoomDetailData_chatRoom_messages_edges_node_mentionsBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  @override
  GChatRoomDetailData_chatRoom_messages_edges_node_mentions_homeTag?
      get homeTag;
  static Serializer<GChatRoomDetailData_chatRoom_messages_edges_node_mentions>
      get serializer =>
          _$gChatRoomDetailDataChatRoomMessagesEdgesNodeMentionsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatRoomDetailData_chatRoom_messages_edges_node_mentions.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomDetailData_chatRoom_messages_edges_node_mentions? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChatRoomDetailData_chatRoom_messages_edges_node_mentions.serializer,
        json,
      );
}

abstract class GChatRoomDetailData_chatRoom_messages_edges_node_mentions_homeTag
    implements
        Built<GChatRoomDetailData_chatRoom_messages_edges_node_mentions_homeTag,
            GChatRoomDetailData_chatRoom_messages_edges_node_mentions_homeTagBuilder>,
        GMessageSummary_mentions_homeTag {
  GChatRoomDetailData_chatRoom_messages_edges_node_mentions_homeTag._();

  factory GChatRoomDetailData_chatRoom_messages_edges_node_mentions_homeTag(
          [void Function(
                  GChatRoomDetailData_chatRoom_messages_edges_node_mentions_homeTagBuilder
                      b)
              updates]) =
      _$GChatRoomDetailData_chatRoom_messages_edges_node_mentions_homeTag;

  static void _initializeBuilder(
          GChatRoomDetailData_chatRoom_messages_edges_node_mentions_homeTagBuilder
              b) =>
      b..G__typename = 'Tag';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get slug;
  @override
  String get path;
  static Serializer<
          GChatRoomDetailData_chatRoom_messages_edges_node_mentions_homeTag>
      get serializer =>
          _$gChatRoomDetailDataChatRoomMessagesEdgesNodeMentionsHomeTagSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatRoomDetailData_chatRoom_messages_edges_node_mentions_homeTag
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomDetailData_chatRoom_messages_edges_node_mentions_homeTag?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GChatRoomDetailData_chatRoom_messages_edges_node_mentions_homeTag
                .serializer,
            json,
          );
}

abstract class GChatRoomDetailData_chatRoom_messages_edges_node_referencedTags
    implements
        Built<GChatRoomDetailData_chatRoom_messages_edges_node_referencedTags,
            GChatRoomDetailData_chatRoom_messages_edges_node_referencedTagsBuilder>,
        GMessageSummary_referencedTags {
  GChatRoomDetailData_chatRoom_messages_edges_node_referencedTags._();

  factory GChatRoomDetailData_chatRoom_messages_edges_node_referencedTags(
          [void Function(
                  GChatRoomDetailData_chatRoom_messages_edges_node_referencedTagsBuilder
                      b)
              updates]) =
      _$GChatRoomDetailData_chatRoom_messages_edges_node_referencedTags;

  static void _initializeBuilder(
          GChatRoomDetailData_chatRoom_messages_edges_node_referencedTagsBuilder
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
  @override
  String get path;
  static Serializer<
          GChatRoomDetailData_chatRoom_messages_edges_node_referencedTags>
      get serializer =>
          _$gChatRoomDetailDataChatRoomMessagesEdgesNodeReferencedTagsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatRoomDetailData_chatRoom_messages_edges_node_referencedTags
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomDetailData_chatRoom_messages_edges_node_referencedTags?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GChatRoomDetailData_chatRoom_messages_edges_node_referencedTags
                .serializer,
            json,
          );
}

abstract class GChatRoomDetailData_chatRoom_messages_edges_node_replyTo
    implements
        Built<GChatRoomDetailData_chatRoom_messages_edges_node_replyTo,
            GChatRoomDetailData_chatRoom_messages_edges_node_replyToBuilder>,
        GMessageSummary_replyTo {
  GChatRoomDetailData_chatRoom_messages_edges_node_replyTo._();

  factory GChatRoomDetailData_chatRoom_messages_edges_node_replyTo(
      [void Function(
              GChatRoomDetailData_chatRoom_messages_edges_node_replyToBuilder b)
          updates]) = _$GChatRoomDetailData_chatRoom_messages_edges_node_replyTo;

  static void _initializeBuilder(
          GChatRoomDetailData_chatRoom_messages_edges_node_replyToBuilder b) =>
      b..G__typename = 'Message';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get body;
  static Serializer<GChatRoomDetailData_chatRoom_messages_edges_node_replyTo>
      get serializer =>
          _$gChatRoomDetailDataChatRoomMessagesEdgesNodeReplyToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatRoomDetailData_chatRoom_messages_edges_node_replyTo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomDetailData_chatRoom_messages_edges_node_replyTo? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChatRoomDetailData_chatRoom_messages_edges_node_replyTo.serializer,
        json,
      );
}

abstract class GSendMessageData
    implements Built<GSendMessageData, GSendMessageDataBuilder> {
  GSendMessageData._();

  factory GSendMessageData([void Function(GSendMessageDataBuilder b) updates]) =
      _$GSendMessageData;

  static void _initializeBuilder(GSendMessageDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GSendMessageData_sendMessage get sendMessage;
  static Serializer<GSendMessageData> get serializer =>
      _$gSendMessageDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendMessageData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendMessageData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendMessageData.serializer,
        json,
      );
}

abstract class GSendMessageData_sendMessage
    implements
        Built<GSendMessageData_sendMessage,
            GSendMessageData_sendMessageBuilder>,
        GMessageSummary {
  GSendMessageData_sendMessage._();

  factory GSendMessageData_sendMessage(
          [void Function(GSendMessageData_sendMessageBuilder b) updates]) =
      _$GSendMessageData_sendMessage;

  static void _initializeBuilder(GSendMessageData_sendMessageBuilder b) =>
      b..G__typename = 'Message';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get body;
  @override
  _i2.GTime get createdAt;
  @override
  _i2.GTime? get editedAt;
  @override
  GSendMessageData_sendMessage_author get author;
  @override
  BuiltList<GSendMessageData_sendMessage_mentions> get mentions;
  @override
  BuiltList<GSendMessageData_sendMessage_referencedTags> get referencedTags;
  @override
  GSendMessageData_sendMessage_replyTo? get replyTo;
  static Serializer<GSendMessageData_sendMessage> get serializer =>
      _$gSendMessageDataSendMessageSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendMessageData_sendMessage.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendMessageData_sendMessage? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendMessageData_sendMessage.serializer,
        json,
      );
}

abstract class GSendMessageData_sendMessage_author
    implements
        Built<GSendMessageData_sendMessage_author,
            GSendMessageData_sendMessage_authorBuilder>,
        GMessageSummary_author {
  GSendMessageData_sendMessage_author._();

  factory GSendMessageData_sendMessage_author(
      [void Function(GSendMessageData_sendMessage_authorBuilder b)
          updates]) = _$GSendMessageData_sendMessage_author;

  static void _initializeBuilder(
          GSendMessageData_sendMessage_authorBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  @override
  GSendMessageData_sendMessage_author_homeTag? get homeTag;
  static Serializer<GSendMessageData_sendMessage_author> get serializer =>
      _$gSendMessageDataSendMessageAuthorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendMessageData_sendMessage_author.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendMessageData_sendMessage_author? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendMessageData_sendMessage_author.serializer,
        json,
      );
}

abstract class GSendMessageData_sendMessage_author_homeTag
    implements
        Built<GSendMessageData_sendMessage_author_homeTag,
            GSendMessageData_sendMessage_author_homeTagBuilder>,
        GMessageSummary_author_homeTag {
  GSendMessageData_sendMessage_author_homeTag._();

  factory GSendMessageData_sendMessage_author_homeTag(
      [void Function(GSendMessageData_sendMessage_author_homeTagBuilder b)
          updates]) = _$GSendMessageData_sendMessage_author_homeTag;

  static void _initializeBuilder(
          GSendMessageData_sendMessage_author_homeTagBuilder b) =>
      b..G__typename = 'Tag';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get slug;
  @override
  String get path;
  static Serializer<GSendMessageData_sendMessage_author_homeTag>
      get serializer => _$gSendMessageDataSendMessageAuthorHomeTagSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendMessageData_sendMessage_author_homeTag.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendMessageData_sendMessage_author_homeTag? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendMessageData_sendMessage_author_homeTag.serializer,
        json,
      );
}

abstract class GSendMessageData_sendMessage_mentions
    implements
        Built<GSendMessageData_sendMessage_mentions,
            GSendMessageData_sendMessage_mentionsBuilder>,
        GMessageSummary_mentions {
  GSendMessageData_sendMessage_mentions._();

  factory GSendMessageData_sendMessage_mentions(
      [void Function(GSendMessageData_sendMessage_mentionsBuilder b)
          updates]) = _$GSendMessageData_sendMessage_mentions;

  static void _initializeBuilder(
          GSendMessageData_sendMessage_mentionsBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  @override
  GSendMessageData_sendMessage_mentions_homeTag? get homeTag;
  static Serializer<GSendMessageData_sendMessage_mentions> get serializer =>
      _$gSendMessageDataSendMessageMentionsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendMessageData_sendMessage_mentions.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendMessageData_sendMessage_mentions? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendMessageData_sendMessage_mentions.serializer,
        json,
      );
}

abstract class GSendMessageData_sendMessage_mentions_homeTag
    implements
        Built<GSendMessageData_sendMessage_mentions_homeTag,
            GSendMessageData_sendMessage_mentions_homeTagBuilder>,
        GMessageSummary_mentions_homeTag {
  GSendMessageData_sendMessage_mentions_homeTag._();

  factory GSendMessageData_sendMessage_mentions_homeTag(
      [void Function(GSendMessageData_sendMessage_mentions_homeTagBuilder b)
          updates]) = _$GSendMessageData_sendMessage_mentions_homeTag;

  static void _initializeBuilder(
          GSendMessageData_sendMessage_mentions_homeTagBuilder b) =>
      b..G__typename = 'Tag';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get slug;
  @override
  String get path;
  static Serializer<GSendMessageData_sendMessage_mentions_homeTag>
      get serializer => _$gSendMessageDataSendMessageMentionsHomeTagSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendMessageData_sendMessage_mentions_homeTag.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendMessageData_sendMessage_mentions_homeTag? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendMessageData_sendMessage_mentions_homeTag.serializer,
        json,
      );
}

abstract class GSendMessageData_sendMessage_referencedTags
    implements
        Built<GSendMessageData_sendMessage_referencedTags,
            GSendMessageData_sendMessage_referencedTagsBuilder>,
        GMessageSummary_referencedTags {
  GSendMessageData_sendMessage_referencedTags._();

  factory GSendMessageData_sendMessage_referencedTags(
      [void Function(GSendMessageData_sendMessage_referencedTagsBuilder b)
          updates]) = _$GSendMessageData_sendMessage_referencedTags;

  static void _initializeBuilder(
          GSendMessageData_sendMessage_referencedTagsBuilder b) =>
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
  @override
  String get path;
  static Serializer<GSendMessageData_sendMessage_referencedTags>
      get serializer => _$gSendMessageDataSendMessageReferencedTagsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendMessageData_sendMessage_referencedTags.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendMessageData_sendMessage_referencedTags? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendMessageData_sendMessage_referencedTags.serializer,
        json,
      );
}

abstract class GSendMessageData_sendMessage_replyTo
    implements
        Built<GSendMessageData_sendMessage_replyTo,
            GSendMessageData_sendMessage_replyToBuilder>,
        GMessageSummary_replyTo {
  GSendMessageData_sendMessage_replyTo._();

  factory GSendMessageData_sendMessage_replyTo(
      [void Function(GSendMessageData_sendMessage_replyToBuilder b)
          updates]) = _$GSendMessageData_sendMessage_replyTo;

  static void _initializeBuilder(
          GSendMessageData_sendMessage_replyToBuilder b) =>
      b..G__typename = 'Message';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get body;
  static Serializer<GSendMessageData_sendMessage_replyTo> get serializer =>
      _$gSendMessageDataSendMessageReplyToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendMessageData_sendMessage_replyTo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendMessageData_sendMessage_replyTo? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendMessageData_sendMessage_replyTo.serializer,
        json,
      );
}

abstract class GCreateChatRoomData
    implements Built<GCreateChatRoomData, GCreateChatRoomDataBuilder> {
  GCreateChatRoomData._();

  factory GCreateChatRoomData(
          [void Function(GCreateChatRoomDataBuilder b) updates]) =
      _$GCreateChatRoomData;

  static void _initializeBuilder(GCreateChatRoomDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GCreateChatRoomData_createChatRoom get createChatRoom;
  static Serializer<GCreateChatRoomData> get serializer =>
      _$gCreateChatRoomDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateChatRoomData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateChatRoomData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateChatRoomData.serializer,
        json,
      );
}

abstract class GCreateChatRoomData_createChatRoom
    implements
        Built<GCreateChatRoomData_createChatRoom,
            GCreateChatRoomData_createChatRoomBuilder>,
        GChatRoomSummary {
  GCreateChatRoomData_createChatRoom._();

  factory GCreateChatRoomData_createChatRoom(
      [void Function(GCreateChatRoomData_createChatRoomBuilder b)
          updates]) = _$GCreateChatRoomData_createChatRoom;

  static void _initializeBuilder(GCreateChatRoomData_createChatRoomBuilder b) =>
      b..G__typename = 'ChatRoom';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  bool get isDM;
  @override
  _i2.GTime get createdAt;
  @override
  _i2.GTime? get archivedAt;
  @override
  BuiltList<GCreateChatRoomData_createChatRoom_tags> get tags;
  @override
  BuiltList<GCreateChatRoomData_createChatRoom_participants> get participants;
  static Serializer<GCreateChatRoomData_createChatRoom> get serializer =>
      _$gCreateChatRoomDataCreateChatRoomSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateChatRoomData_createChatRoom.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateChatRoomData_createChatRoom? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateChatRoomData_createChatRoom.serializer,
        json,
      );
}

abstract class GCreateChatRoomData_createChatRoom_tags
    implements
        Built<GCreateChatRoomData_createChatRoom_tags,
            GCreateChatRoomData_createChatRoom_tagsBuilder>,
        GChatRoomSummary_tags {
  GCreateChatRoomData_createChatRoom_tags._();

  factory GCreateChatRoomData_createChatRoom_tags(
      [void Function(GCreateChatRoomData_createChatRoom_tagsBuilder b)
          updates]) = _$GCreateChatRoomData_createChatRoom_tags;

  static void _initializeBuilder(
          GCreateChatRoomData_createChatRoom_tagsBuilder b) =>
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
  static Serializer<GCreateChatRoomData_createChatRoom_tags> get serializer =>
      _$gCreateChatRoomDataCreateChatRoomTagsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateChatRoomData_createChatRoom_tags.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateChatRoomData_createChatRoom_tags? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateChatRoomData_createChatRoom_tags.serializer,
        json,
      );
}

abstract class GCreateChatRoomData_createChatRoom_participants
    implements
        Built<GCreateChatRoomData_createChatRoom_participants,
            GCreateChatRoomData_createChatRoom_participantsBuilder>,
        GChatRoomSummary_participants {
  GCreateChatRoomData_createChatRoom_participants._();

  factory GCreateChatRoomData_createChatRoom_participants(
      [void Function(GCreateChatRoomData_createChatRoom_participantsBuilder b)
          updates]) = _$GCreateChatRoomData_createChatRoom_participants;

  static void _initializeBuilder(
          GCreateChatRoomData_createChatRoom_participantsBuilder b) =>
      b..G__typename = 'ChatRoomParticipant';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GCreateChatRoomData_createChatRoom_participants_principal get principal;
  static Serializer<GCreateChatRoomData_createChatRoom_participants>
      get serializer =>
          _$gCreateChatRoomDataCreateChatRoomParticipantsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateChatRoomData_createChatRoom_participants.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateChatRoomData_createChatRoom_participants? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateChatRoomData_createChatRoom_participants.serializer,
        json,
      );
}

abstract class GCreateChatRoomData_createChatRoom_participants_principal
    implements
        Built<GCreateChatRoomData_createChatRoom_participants_principal,
            GCreateChatRoomData_createChatRoom_participants_principalBuilder>,
        GChatRoomSummary_participants_principal {
  GCreateChatRoomData_createChatRoom_participants_principal._();

  factory GCreateChatRoomData_createChatRoom_participants_principal(
      [void Function(
              GCreateChatRoomData_createChatRoom_participants_principalBuilder
                  b)
          updates]) = _$GCreateChatRoomData_createChatRoom_participants_principal;

  static void _initializeBuilder(
          GCreateChatRoomData_createChatRoom_participants_principalBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  static Serializer<GCreateChatRoomData_createChatRoom_participants_principal>
      get serializer =>
          _$gCreateChatRoomDataCreateChatRoomParticipantsPrincipalSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateChatRoomData_createChatRoom_participants_principal.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateChatRoomData_createChatRoom_participants_principal? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateChatRoomData_createChatRoom_participants_principal.serializer,
        json,
      );
}

abstract class GMessageAddedData
    implements Built<GMessageAddedData, GMessageAddedDataBuilder> {
  GMessageAddedData._();

  factory GMessageAddedData(
          [void Function(GMessageAddedDataBuilder b) updates]) =
      _$GMessageAddedData;

  static void _initializeBuilder(GMessageAddedDataBuilder b) =>
      b..G__typename = 'Subscription';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GMessageAddedData_messageAdded get messageAdded;
  static Serializer<GMessageAddedData> get serializer =>
      _$gMessageAddedDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMessageAddedData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMessageAddedData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMessageAddedData.serializer,
        json,
      );
}

abstract class GMessageAddedData_messageAdded
    implements
        Built<GMessageAddedData_messageAdded,
            GMessageAddedData_messageAddedBuilder>,
        GMessageSummary {
  GMessageAddedData_messageAdded._();

  factory GMessageAddedData_messageAdded(
          [void Function(GMessageAddedData_messageAddedBuilder b) updates]) =
      _$GMessageAddedData_messageAdded;

  static void _initializeBuilder(GMessageAddedData_messageAddedBuilder b) =>
      b..G__typename = 'Message';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get body;
  @override
  _i2.GTime get createdAt;
  @override
  _i2.GTime? get editedAt;
  @override
  GMessageAddedData_messageAdded_author get author;
  @override
  BuiltList<GMessageAddedData_messageAdded_mentions> get mentions;
  @override
  BuiltList<GMessageAddedData_messageAdded_referencedTags> get referencedTags;
  @override
  GMessageAddedData_messageAdded_replyTo? get replyTo;
  static Serializer<GMessageAddedData_messageAdded> get serializer =>
      _$gMessageAddedDataMessageAddedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMessageAddedData_messageAdded.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMessageAddedData_messageAdded? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMessageAddedData_messageAdded.serializer,
        json,
      );
}

abstract class GMessageAddedData_messageAdded_author
    implements
        Built<GMessageAddedData_messageAdded_author,
            GMessageAddedData_messageAdded_authorBuilder>,
        GMessageSummary_author {
  GMessageAddedData_messageAdded_author._();

  factory GMessageAddedData_messageAdded_author(
      [void Function(GMessageAddedData_messageAdded_authorBuilder b)
          updates]) = _$GMessageAddedData_messageAdded_author;

  static void _initializeBuilder(
          GMessageAddedData_messageAdded_authorBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  @override
  GMessageAddedData_messageAdded_author_homeTag? get homeTag;
  static Serializer<GMessageAddedData_messageAdded_author> get serializer =>
      _$gMessageAddedDataMessageAddedAuthorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMessageAddedData_messageAdded_author.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMessageAddedData_messageAdded_author? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMessageAddedData_messageAdded_author.serializer,
        json,
      );
}

abstract class GMessageAddedData_messageAdded_author_homeTag
    implements
        Built<GMessageAddedData_messageAdded_author_homeTag,
            GMessageAddedData_messageAdded_author_homeTagBuilder>,
        GMessageSummary_author_homeTag {
  GMessageAddedData_messageAdded_author_homeTag._();

  factory GMessageAddedData_messageAdded_author_homeTag(
      [void Function(GMessageAddedData_messageAdded_author_homeTagBuilder b)
          updates]) = _$GMessageAddedData_messageAdded_author_homeTag;

  static void _initializeBuilder(
          GMessageAddedData_messageAdded_author_homeTagBuilder b) =>
      b..G__typename = 'Tag';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get slug;
  @override
  String get path;
  static Serializer<GMessageAddedData_messageAdded_author_homeTag>
      get serializer => _$gMessageAddedDataMessageAddedAuthorHomeTagSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMessageAddedData_messageAdded_author_homeTag.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMessageAddedData_messageAdded_author_homeTag? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMessageAddedData_messageAdded_author_homeTag.serializer,
        json,
      );
}

abstract class GMessageAddedData_messageAdded_mentions
    implements
        Built<GMessageAddedData_messageAdded_mentions,
            GMessageAddedData_messageAdded_mentionsBuilder>,
        GMessageSummary_mentions {
  GMessageAddedData_messageAdded_mentions._();

  factory GMessageAddedData_messageAdded_mentions(
      [void Function(GMessageAddedData_messageAdded_mentionsBuilder b)
          updates]) = _$GMessageAddedData_messageAdded_mentions;

  static void _initializeBuilder(
          GMessageAddedData_messageAdded_mentionsBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  @override
  GMessageAddedData_messageAdded_mentions_homeTag? get homeTag;
  static Serializer<GMessageAddedData_messageAdded_mentions> get serializer =>
      _$gMessageAddedDataMessageAddedMentionsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMessageAddedData_messageAdded_mentions.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMessageAddedData_messageAdded_mentions? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMessageAddedData_messageAdded_mentions.serializer,
        json,
      );
}

abstract class GMessageAddedData_messageAdded_mentions_homeTag
    implements
        Built<GMessageAddedData_messageAdded_mentions_homeTag,
            GMessageAddedData_messageAdded_mentions_homeTagBuilder>,
        GMessageSummary_mentions_homeTag {
  GMessageAddedData_messageAdded_mentions_homeTag._();

  factory GMessageAddedData_messageAdded_mentions_homeTag(
      [void Function(GMessageAddedData_messageAdded_mentions_homeTagBuilder b)
          updates]) = _$GMessageAddedData_messageAdded_mentions_homeTag;

  static void _initializeBuilder(
          GMessageAddedData_messageAdded_mentions_homeTagBuilder b) =>
      b..G__typename = 'Tag';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get slug;
  @override
  String get path;
  static Serializer<GMessageAddedData_messageAdded_mentions_homeTag>
      get serializer =>
          _$gMessageAddedDataMessageAddedMentionsHomeTagSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMessageAddedData_messageAdded_mentions_homeTag.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMessageAddedData_messageAdded_mentions_homeTag? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMessageAddedData_messageAdded_mentions_homeTag.serializer,
        json,
      );
}

abstract class GMessageAddedData_messageAdded_referencedTags
    implements
        Built<GMessageAddedData_messageAdded_referencedTags,
            GMessageAddedData_messageAdded_referencedTagsBuilder>,
        GMessageSummary_referencedTags {
  GMessageAddedData_messageAdded_referencedTags._();

  factory GMessageAddedData_messageAdded_referencedTags(
      [void Function(GMessageAddedData_messageAdded_referencedTagsBuilder b)
          updates]) = _$GMessageAddedData_messageAdded_referencedTags;

  static void _initializeBuilder(
          GMessageAddedData_messageAdded_referencedTagsBuilder b) =>
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
  @override
  String get path;
  static Serializer<GMessageAddedData_messageAdded_referencedTags>
      get serializer => _$gMessageAddedDataMessageAddedReferencedTagsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMessageAddedData_messageAdded_referencedTags.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMessageAddedData_messageAdded_referencedTags? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMessageAddedData_messageAdded_referencedTags.serializer,
        json,
      );
}

abstract class GMessageAddedData_messageAdded_replyTo
    implements
        Built<GMessageAddedData_messageAdded_replyTo,
            GMessageAddedData_messageAdded_replyToBuilder>,
        GMessageSummary_replyTo {
  GMessageAddedData_messageAdded_replyTo._();

  factory GMessageAddedData_messageAdded_replyTo(
      [void Function(GMessageAddedData_messageAdded_replyToBuilder b)
          updates]) = _$GMessageAddedData_messageAdded_replyTo;

  static void _initializeBuilder(
          GMessageAddedData_messageAdded_replyToBuilder b) =>
      b..G__typename = 'Message';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get body;
  static Serializer<GMessageAddedData_messageAdded_replyTo> get serializer =>
      _$gMessageAddedDataMessageAddedReplyToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMessageAddedData_messageAdded_replyTo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMessageAddedData_messageAdded_replyTo? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMessageAddedData_messageAdded_replyTo.serializer,
        json,
      );
}

abstract class GMessageSummary {
  String get G__typename;
  String get id;
  String get body;
  _i2.GTime get createdAt;
  _i2.GTime? get editedAt;
  GMessageSummary_author get author;
  BuiltList<GMessageSummary_mentions> get mentions;
  BuiltList<GMessageSummary_referencedTags> get referencedTags;
  GMessageSummary_replyTo? get replyTo;
  Map<String, dynamic> toJson();
}

abstract class GMessageSummary_author {
  String get G__typename;
  String get id;
  String get displayName;
  GMessageSummary_author_homeTag? get homeTag;
  Map<String, dynamic> toJson();
}

abstract class GMessageSummary_author_homeTag {
  String get G__typename;
  String get slug;
  String get path;
  Map<String, dynamic> toJson();
}

abstract class GMessageSummary_mentions {
  String get G__typename;
  String get id;
  String get displayName;
  GMessageSummary_mentions_homeTag? get homeTag;
  Map<String, dynamic> toJson();
}

abstract class GMessageSummary_mentions_homeTag {
  String get G__typename;
  String get slug;
  String get path;
  Map<String, dynamic> toJson();
}

abstract class GMessageSummary_referencedTags {
  String get G__typename;
  String get id;
  String get slug;
  String get displayName;
  String get path;
  Map<String, dynamic> toJson();
}

abstract class GMessageSummary_replyTo {
  String get G__typename;
  String get id;
  String get body;
  Map<String, dynamic> toJson();
}

abstract class GMessageSummaryData
    implements
        Built<GMessageSummaryData, GMessageSummaryDataBuilder>,
        GMessageSummary {
  GMessageSummaryData._();

  factory GMessageSummaryData(
          [void Function(GMessageSummaryDataBuilder b) updates]) =
      _$GMessageSummaryData;

  static void _initializeBuilder(GMessageSummaryDataBuilder b) =>
      b..G__typename = 'Message';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get body;
  @override
  _i2.GTime get createdAt;
  @override
  _i2.GTime? get editedAt;
  @override
  GMessageSummaryData_author get author;
  @override
  BuiltList<GMessageSummaryData_mentions> get mentions;
  @override
  BuiltList<GMessageSummaryData_referencedTags> get referencedTags;
  @override
  GMessageSummaryData_replyTo? get replyTo;
  static Serializer<GMessageSummaryData> get serializer =>
      _$gMessageSummaryDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMessageSummaryData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMessageSummaryData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMessageSummaryData.serializer,
        json,
      );
}

abstract class GMessageSummaryData_author
    implements
        Built<GMessageSummaryData_author, GMessageSummaryData_authorBuilder>,
        GMessageSummary_author {
  GMessageSummaryData_author._();

  factory GMessageSummaryData_author(
          [void Function(GMessageSummaryData_authorBuilder b) updates]) =
      _$GMessageSummaryData_author;

  static void _initializeBuilder(GMessageSummaryData_authorBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  @override
  GMessageSummaryData_author_homeTag? get homeTag;
  static Serializer<GMessageSummaryData_author> get serializer =>
      _$gMessageSummaryDataAuthorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMessageSummaryData_author.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMessageSummaryData_author? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMessageSummaryData_author.serializer,
        json,
      );
}

abstract class GMessageSummaryData_author_homeTag
    implements
        Built<GMessageSummaryData_author_homeTag,
            GMessageSummaryData_author_homeTagBuilder>,
        GMessageSummary_author_homeTag {
  GMessageSummaryData_author_homeTag._();

  factory GMessageSummaryData_author_homeTag(
      [void Function(GMessageSummaryData_author_homeTagBuilder b)
          updates]) = _$GMessageSummaryData_author_homeTag;

  static void _initializeBuilder(GMessageSummaryData_author_homeTagBuilder b) =>
      b..G__typename = 'Tag';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get slug;
  @override
  String get path;
  static Serializer<GMessageSummaryData_author_homeTag> get serializer =>
      _$gMessageSummaryDataAuthorHomeTagSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMessageSummaryData_author_homeTag.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMessageSummaryData_author_homeTag? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMessageSummaryData_author_homeTag.serializer,
        json,
      );
}

abstract class GMessageSummaryData_mentions
    implements
        Built<GMessageSummaryData_mentions,
            GMessageSummaryData_mentionsBuilder>,
        GMessageSummary_mentions {
  GMessageSummaryData_mentions._();

  factory GMessageSummaryData_mentions(
          [void Function(GMessageSummaryData_mentionsBuilder b) updates]) =
      _$GMessageSummaryData_mentions;

  static void _initializeBuilder(GMessageSummaryData_mentionsBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  @override
  GMessageSummaryData_mentions_homeTag? get homeTag;
  static Serializer<GMessageSummaryData_mentions> get serializer =>
      _$gMessageSummaryDataMentionsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMessageSummaryData_mentions.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMessageSummaryData_mentions? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMessageSummaryData_mentions.serializer,
        json,
      );
}

abstract class GMessageSummaryData_mentions_homeTag
    implements
        Built<GMessageSummaryData_mentions_homeTag,
            GMessageSummaryData_mentions_homeTagBuilder>,
        GMessageSummary_mentions_homeTag {
  GMessageSummaryData_mentions_homeTag._();

  factory GMessageSummaryData_mentions_homeTag(
      [void Function(GMessageSummaryData_mentions_homeTagBuilder b)
          updates]) = _$GMessageSummaryData_mentions_homeTag;

  static void _initializeBuilder(
          GMessageSummaryData_mentions_homeTagBuilder b) =>
      b..G__typename = 'Tag';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get slug;
  @override
  String get path;
  static Serializer<GMessageSummaryData_mentions_homeTag> get serializer =>
      _$gMessageSummaryDataMentionsHomeTagSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMessageSummaryData_mentions_homeTag.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMessageSummaryData_mentions_homeTag? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMessageSummaryData_mentions_homeTag.serializer,
        json,
      );
}

abstract class GMessageSummaryData_referencedTags
    implements
        Built<GMessageSummaryData_referencedTags,
            GMessageSummaryData_referencedTagsBuilder>,
        GMessageSummary_referencedTags {
  GMessageSummaryData_referencedTags._();

  factory GMessageSummaryData_referencedTags(
      [void Function(GMessageSummaryData_referencedTagsBuilder b)
          updates]) = _$GMessageSummaryData_referencedTags;

  static void _initializeBuilder(GMessageSummaryData_referencedTagsBuilder b) =>
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
  @override
  String get path;
  static Serializer<GMessageSummaryData_referencedTags> get serializer =>
      _$gMessageSummaryDataReferencedTagsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMessageSummaryData_referencedTags.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMessageSummaryData_referencedTags? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMessageSummaryData_referencedTags.serializer,
        json,
      );
}

abstract class GMessageSummaryData_replyTo
    implements
        Built<GMessageSummaryData_replyTo, GMessageSummaryData_replyToBuilder>,
        GMessageSummary_replyTo {
  GMessageSummaryData_replyTo._();

  factory GMessageSummaryData_replyTo(
          [void Function(GMessageSummaryData_replyToBuilder b) updates]) =
      _$GMessageSummaryData_replyTo;

  static void _initializeBuilder(GMessageSummaryData_replyToBuilder b) =>
      b..G__typename = 'Message';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get body;
  static Serializer<GMessageSummaryData_replyTo> get serializer =>
      _$gMessageSummaryDataReplyToSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMessageSummaryData_replyTo.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMessageSummaryData_replyTo? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMessageSummaryData_replyTo.serializer,
        json,
      );
}

abstract class GChatRoomSummary {
  String get G__typename;
  String get id;
  bool get isDM;
  _i2.GTime get createdAt;
  _i2.GTime? get archivedAt;
  BuiltList<GChatRoomSummary_tags> get tags;
  BuiltList<GChatRoomSummary_participants> get participants;
  Map<String, dynamic> toJson();
}

abstract class GChatRoomSummary_tags {
  String get G__typename;
  String get id;
  String get slug;
  String get displayName;
  Map<String, dynamic> toJson();
}

abstract class GChatRoomSummary_participants {
  String get G__typename;
  GChatRoomSummary_participants_principal get principal;
  Map<String, dynamic> toJson();
}

abstract class GChatRoomSummary_participants_principal {
  String get G__typename;
  String get id;
  String get displayName;
  Map<String, dynamic> toJson();
}

abstract class GChatRoomSummaryData
    implements
        Built<GChatRoomSummaryData, GChatRoomSummaryDataBuilder>,
        GChatRoomSummary {
  GChatRoomSummaryData._();

  factory GChatRoomSummaryData(
          [void Function(GChatRoomSummaryDataBuilder b) updates]) =
      _$GChatRoomSummaryData;

  static void _initializeBuilder(GChatRoomSummaryDataBuilder b) =>
      b..G__typename = 'ChatRoom';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  bool get isDM;
  @override
  _i2.GTime get createdAt;
  @override
  _i2.GTime? get archivedAt;
  @override
  BuiltList<GChatRoomSummaryData_tags> get tags;
  @override
  BuiltList<GChatRoomSummaryData_participants> get participants;
  static Serializer<GChatRoomSummaryData> get serializer =>
      _$gChatRoomSummaryDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatRoomSummaryData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomSummaryData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChatRoomSummaryData.serializer,
        json,
      );
}

abstract class GChatRoomSummaryData_tags
    implements
        Built<GChatRoomSummaryData_tags, GChatRoomSummaryData_tagsBuilder>,
        GChatRoomSummary_tags {
  GChatRoomSummaryData_tags._();

  factory GChatRoomSummaryData_tags(
          [void Function(GChatRoomSummaryData_tagsBuilder b) updates]) =
      _$GChatRoomSummaryData_tags;

  static void _initializeBuilder(GChatRoomSummaryData_tagsBuilder b) =>
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
  static Serializer<GChatRoomSummaryData_tags> get serializer =>
      _$gChatRoomSummaryDataTagsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatRoomSummaryData_tags.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomSummaryData_tags? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChatRoomSummaryData_tags.serializer,
        json,
      );
}

abstract class GChatRoomSummaryData_participants
    implements
        Built<GChatRoomSummaryData_participants,
            GChatRoomSummaryData_participantsBuilder>,
        GChatRoomSummary_participants {
  GChatRoomSummaryData_participants._();

  factory GChatRoomSummaryData_participants(
          [void Function(GChatRoomSummaryData_participantsBuilder b) updates]) =
      _$GChatRoomSummaryData_participants;

  static void _initializeBuilder(GChatRoomSummaryData_participantsBuilder b) =>
      b..G__typename = 'ChatRoomParticipant';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  GChatRoomSummaryData_participants_principal get principal;
  static Serializer<GChatRoomSummaryData_participants> get serializer =>
      _$gChatRoomSummaryDataParticipantsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatRoomSummaryData_participants.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomSummaryData_participants? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChatRoomSummaryData_participants.serializer,
        json,
      );
}

abstract class GChatRoomSummaryData_participants_principal
    implements
        Built<GChatRoomSummaryData_participants_principal,
            GChatRoomSummaryData_participants_principalBuilder>,
        GChatRoomSummary_participants_principal {
  GChatRoomSummaryData_participants_principal._();

  factory GChatRoomSummaryData_participants_principal(
      [void Function(GChatRoomSummaryData_participants_principalBuilder b)
          updates]) = _$GChatRoomSummaryData_participants_principal;

  static void _initializeBuilder(
          GChatRoomSummaryData_participants_principalBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  static Serializer<GChatRoomSummaryData_participants_principal>
      get serializer => _$gChatRoomSummaryDataParticipantsPrincipalSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatRoomSummaryData_participants_principal.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatRoomSummaryData_participants_principal? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChatRoomSummaryData_participants_principal.serializer,
        json,
      );
}
