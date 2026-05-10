// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    as _i1;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i2;

part 'schema.schema.gql.g.dart';

abstract class GTime implements Built<GTime, GTimeBuilder> {
  GTime._();

  factory GTime([String? value]) =>
      _$GTime((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<GTime> get serializer => _i1.DefaultScalarSerializer<GTime>(
      (Object serialized) => GTime((serialized as String?)));
}

abstract class GJSON implements Built<GJSON, GJSONBuilder> {
  GJSON._();

  factory GJSON([String? value]) =>
      _$GJSON((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<GJSON> get serializer => _i1.DefaultScalarSerializer<GJSON>(
      (Object serialized) => GJSON((serialized as String?)));
}

class GTagRootKind extends EnumClass {
  const GTagRootKind._(String name) : super(name);

  static const GTagRootKind ORG = _$gTagRootKindORG;

  static const GTagRootKind USER = _$gTagRootKindUSER;

  static Serializer<GTagRootKind> get serializer => _$gTagRootKindSerializer;

  static BuiltSet<GTagRootKind> get values => _$gTagRootKindValues;

  static GTagRootKind valueOf(String name) => _$gTagRootKindValueOf(name);
}

class GPermissionBundle extends EnumClass {
  const GPermissionBundle._(String name) : super(name);

  static const GPermissionBundle VIEWER = _$gPermissionBundleVIEWER;

  static const GPermissionBundle CONTRIBUTOR = _$gPermissionBundleCONTRIBUTOR;

  static const GPermissionBundle MODERATOR = _$gPermissionBundleMODERATOR;

  static const GPermissionBundle OWNER = _$gPermissionBundleOWNER;

  static Serializer<GPermissionBundle> get serializer =>
      _$gPermissionBundleSerializer;

  static BuiltSet<GPermissionBundle> get values => _$gPermissionBundleValues;

  static GPermissionBundle valueOf(String name) =>
      _$gPermissionBundleValueOf(name);
}

class GSubscriptionUrgency extends EnumClass {
  const GSubscriptionUrgency._(String name) : super(name);

  static const GSubscriptionUrgency HIGH = _$gSubscriptionUrgencyHIGH;

  static const GSubscriptionUrgency NORMAL = _$gSubscriptionUrgencyNORMAL;

  static const GSubscriptionUrgency LOW = _$gSubscriptionUrgencyLOW;

  static const GSubscriptionUrgency MUTE = _$gSubscriptionUrgencyMUTE;

  static Serializer<GSubscriptionUrgency> get serializer =>
      _$gSubscriptionUrgencySerializer;

  static BuiltSet<GSubscriptionUrgency> get values =>
      _$gSubscriptionUrgencyValues;

  static GSubscriptionUrgency valueOf(String name) =>
      _$gSubscriptionUrgencyValueOf(name);
}

class GPrincipalKind extends EnumClass {
  const GPrincipalKind._(String name) : super(name);

  static const GPrincipalKind USER = _$gPrincipalKindUSER;

  static const GPrincipalKind BOT = _$gPrincipalKindBOT;

  static Serializer<GPrincipalKind> get serializer =>
      _$gPrincipalKindSerializer;

  static BuiltSet<GPrincipalKind> get values => _$gPrincipalKindValues;

  static GPrincipalKind valueOf(String name) => _$gPrincipalKindValueOf(name);
}

class GPrincipalStatus extends EnumClass {
  const GPrincipalStatus._(String name) : super(name);

  static const GPrincipalStatus ACTIVE = _$gPrincipalStatusACTIVE;

  static const GPrincipalStatus TOMBSTONED = _$gPrincipalStatusTOMBSTONED;

  static Serializer<GPrincipalStatus> get serializer =>
      _$gPrincipalStatusSerializer;

  static BuiltSet<GPrincipalStatus> get values => _$gPrincipalStatusValues;

  static GPrincipalStatus valueOf(String name) =>
      _$gPrincipalStatusValueOf(name);
}

class GDecisionStatus extends EnumClass {
  const GDecisionStatus._(String name) : super(name);

  static const GDecisionStatus DECISION = _$gDecisionStatusDECISION;

  static const GDecisionStatus ANSWER = _$gDecisionStatusANSWER;

  static Serializer<GDecisionStatus> get serializer =>
      _$gDecisionStatusSerializer;

  static BuiltSet<GDecisionStatus> get values => _$gDecisionStatusValues;

  static GDecisionStatus valueOf(String name) => _$gDecisionStatusValueOf(name);
}

class GSearchKind extends EnumClass {
  const GSearchKind._(String name) : super(name);

  static const GSearchKind POST = _$gSearchKindPOST;

  static const GSearchKind COMMENT = _$gSearchKindCOMMENT;

  static const GSearchKind TASK = _$gSearchKindTASK;

  static const GSearchKind MESSAGE = _$gSearchKindMESSAGE;

  static Serializer<GSearchKind> get serializer => _$gSearchKindSerializer;

  static BuiltSet<GSearchKind> get values => _$gSearchKindValues;

  static GSearchKind valueOf(String name) => _$gSearchKindValueOf(name);
}

class GTaskStatus extends EnumClass {
  const GTaskStatus._(String name) : super(name);

  static const GTaskStatus OPEN = _$gTaskStatusOPEN;

  static const GTaskStatus IN_PROGRESS = _$gTaskStatusIN_PROGRESS;

  static const GTaskStatus BLOCKED = _$gTaskStatusBLOCKED;

  static const GTaskStatus DONE = _$gTaskStatusDONE;

  static const GTaskStatus CANCELLED = _$gTaskStatusCANCELLED;

  static Serializer<GTaskStatus> get serializer => _$gTaskStatusSerializer;

  static BuiltSet<GTaskStatus> get values => _$gTaskStatusValues;

  static GTaskStatus valueOf(String name) => _$gTaskStatusValueOf(name);
}

class GNotificationReason extends EnumClass {
  const GNotificationReason._(String name) : super(name);

  static const GNotificationReason ASSIGNMENT = _$gNotificationReasonASSIGNMENT;

  static const GNotificationReason MENTION = _$gNotificationReasonMENTION;

  static const GNotificationReason WATCHER = _$gNotificationReasonWATCHER;

  static const GNotificationReason TAG_SUBSCRIPTION =
      _$gNotificationReasonTAG_SUBSCRIPTION;

  static const GNotificationReason DM = _$gNotificationReasonDM;

  static Serializer<GNotificationReason> get serializer =>
      _$gNotificationReasonSerializer;

  static BuiltSet<GNotificationReason> get values =>
      _$gNotificationReasonValues;

  static GNotificationReason valueOf(String name) =>
      _$gNotificationReasonValueOf(name);
}

class GNotificationUrgency extends EnumClass {
  const GNotificationUrgency._(String name) : super(name);

  static const GNotificationUrgency HIGH = _$gNotificationUrgencyHIGH;

  static const GNotificationUrgency NORMAL = _$gNotificationUrgencyNORMAL;

  static const GNotificationUrgency LOW = _$gNotificationUrgencyLOW;

  static Serializer<GNotificationUrgency> get serializer =>
      _$gNotificationUrgencySerializer;

  static BuiltSet<GNotificationUrgency> get values =>
      _$gNotificationUrgencyValues;

  static GNotificationUrgency valueOf(String name) =>
      _$gNotificationUrgencyValueOf(name);
}

class GDevicePlatform extends EnumClass {
  const GDevicePlatform._(String name) : super(name);

  static const GDevicePlatform IOS = _$gDevicePlatformIOS;

  static const GDevicePlatform ANDROID = _$gDevicePlatformANDROID;

  static const GDevicePlatform WEB = _$gDevicePlatformWEB;

  static Serializer<GDevicePlatform> get serializer =>
      _$gDevicePlatformSerializer;

  static BuiltSet<GDevicePlatform> get values => _$gDevicePlatformValues;

  static GDevicePlatform valueOf(String name) => _$gDevicePlatformValueOf(name);
}

class GAttachmentOwnerKind extends EnumClass {
  const GAttachmentOwnerKind._(String name) : super(name);

  static const GAttachmentOwnerKind POST = _$gAttachmentOwnerKindPOST;

  static const GAttachmentOwnerKind COMMENT = _$gAttachmentOwnerKindCOMMENT;

  static const GAttachmentOwnerKind MESSAGE = _$gAttachmentOwnerKindMESSAGE;

  static Serializer<GAttachmentOwnerKind> get serializer =>
      _$gAttachmentOwnerKindSerializer;

  static BuiltSet<GAttachmentOwnerKind> get values =>
      _$gAttachmentOwnerKindValues;

  static GAttachmentOwnerKind valueOf(String name) =>
      _$gAttachmentOwnerKindValueOf(name);
}

class GPostSort extends EnumClass {
  const GPostSort._(String name) : super(name);

  static const GPostSort RECENT = _$gPostSortRECENT;

  static const GPostSort ACTIVE = _$gPostSortACTIVE;

  static Serializer<GPostSort> get serializer => _$gPostSortSerializer;

  static BuiltSet<GPostSort> get values => _$gPostSortValues;

  static GPostSort valueOf(String name) => _$gPostSortValueOf(name);
}

abstract class GNotificationFilter
    implements Built<GNotificationFilter, GNotificationFilterBuilder> {
  GNotificationFilter._();

  factory GNotificationFilter(
          [void Function(GNotificationFilterBuilder b) updates]) =
      _$GNotificationFilter;

  bool? get unreadOnly;
  BuiltList<GNotificationReason>? get reasons;
  static Serializer<GNotificationFilter> get serializer =>
      _$gNotificationFilterSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GNotificationFilter.serializer,
        this,
      ) as Map<String, dynamic>);

  static GNotificationFilter? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GNotificationFilter.serializer,
        json,
      );
}

abstract class GIssueAttachmentUploadInput
    implements
        Built<GIssueAttachmentUploadInput, GIssueAttachmentUploadInputBuilder> {
  GIssueAttachmentUploadInput._();

  factory GIssueAttachmentUploadInput(
          [void Function(GIssueAttachmentUploadInputBuilder b) updates]) =
      _$GIssueAttachmentUploadInput;

  GAttachmentOwnerKind get ownerType;
  String get ownerId;
  String get filename;
  String get mimeType;
  int get sizeBytes;
  static Serializer<GIssueAttachmentUploadInput> get serializer =>
      _$gIssueAttachmentUploadInputSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GIssueAttachmentUploadInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GIssueAttachmentUploadInput? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GIssueAttachmentUploadInput.serializer,
        json,
      );
}

abstract class GCreateTagInput
    implements Built<GCreateTagInput, GCreateTagInputBuilder> {
  GCreateTagInput._();

  factory GCreateTagInput([void Function(GCreateTagInputBuilder b) updates]) =
      _$GCreateTagInput;

  String get parentId;
  String get slug;
  String get displayName;
  GJSON? get defaults;
  static Serializer<GCreateTagInput> get serializer =>
      _$gCreateTagInputSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GCreateTagInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateTagInput? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GCreateTagInput.serializer,
        json,
      );
}

abstract class GGrantTagInput
    implements Built<GGrantTagInput, GGrantTagInputBuilder> {
  GGrantTagInput._();

  factory GGrantTagInput([void Function(GGrantTagInputBuilder b) updates]) =
      _$GGrantTagInput;

  String get tagId;
  String get principalId;
  GPermissionBundle get bundle;
  BuiltList<String>? get extras;
  bool? get cascade;
  static Serializer<GGrantTagInput> get serializer =>
      _$gGrantTagInputSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GGrantTagInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGrantTagInput? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GGrantTagInput.serializer,
        json,
      );
}

abstract class GSubscribeTagInput
    implements Built<GSubscribeTagInput, GSubscribeTagInputBuilder> {
  GSubscribeTagInput._();

  factory GSubscribeTagInput(
          [void Function(GSubscribeTagInputBuilder b) updates]) =
      _$GSubscribeTagInput;

  String get tagId;
  bool? get cascade;
  GSubscriptionUrgency? get urgency;
  BuiltList<String>? get reasonFilter;
  static Serializer<GSubscribeTagInput> get serializer =>
      _$gSubscribeTagInputSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GSubscribeTagInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSubscribeTagInput? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GSubscribeTagInput.serializer,
        json,
      );
}

abstract class GPostTagInput
    implements Built<GPostTagInput, GPostTagInputBuilder> {
  GPostTagInput._();

  factory GPostTagInput([void Function(GPostTagInputBuilder b) updates]) =
      _$GPostTagInput;

  String get tagId;
  bool? get viewRole;
  bool? get interactRole;
  bool? get moderateRole;
  static Serializer<GPostTagInput> get serializer => _$gPostTagInputSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GPostTagInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostTagInput? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GPostTagInput.serializer,
        json,
      );
}

abstract class GCreatePostInput
    implements Built<GCreatePostInput, GCreatePostInputBuilder> {
  GCreatePostInput._();

  factory GCreatePostInput([void Function(GCreatePostInputBuilder b) updates]) =
      _$GCreatePostInput;

  String get title;
  String get body;
  BuiltList<GPostTagInput> get tags;
  static Serializer<GCreatePostInput> get serializer =>
      _$gCreatePostInputSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GCreatePostInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreatePostInput? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GCreatePostInput.serializer,
        json,
      );
}

abstract class GEditPostInput
    implements Built<GEditPostInput, GEditPostInputBuilder> {
  GEditPostInput._();

  factory GEditPostInput([void Function(GEditPostInputBuilder b) updates]) =
      _$GEditPostInput;

  String get postId;
  String get title;
  String get body;
  static Serializer<GEditPostInput> get serializer =>
      _$gEditPostInputSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GEditPostInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEditPostInput? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GEditPostInput.serializer,
        json,
      );
}

abstract class GCreateCommentInput
    implements Built<GCreateCommentInput, GCreateCommentInputBuilder> {
  GCreateCommentInput._();

  factory GCreateCommentInput(
          [void Function(GCreateCommentInputBuilder b) updates]) =
      _$GCreateCommentInput;

  String get postId;
  String? get parentId;
  String get body;
  static Serializer<GCreateCommentInput> get serializer =>
      _$gCreateCommentInputSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GCreateCommentInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateCommentInput? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GCreateCommentInput.serializer,
        json,
      );
}

abstract class GCreateChatRoomInput
    implements Built<GCreateChatRoomInput, GCreateChatRoomInputBuilder> {
  GCreateChatRoomInput._();

  factory GCreateChatRoomInput(
          [void Function(GCreateChatRoomInputBuilder b) updates]) =
      _$GCreateChatRoomInput;

  BuiltList<String>? get tagIds;
  BuiltList<String>? get participantIds;
  static Serializer<GCreateChatRoomInput> get serializer =>
      _$gCreateChatRoomInputSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GCreateChatRoomInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateChatRoomInput? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GCreateChatRoomInput.serializer,
        json,
      );
}

abstract class GSendMessageInput
    implements Built<GSendMessageInput, GSendMessageInputBuilder> {
  GSendMessageInput._();

  factory GSendMessageInput(
          [void Function(GSendMessageInputBuilder b) updates]) =
      _$GSendMessageInput;

  String get roomId;
  String get body;
  String? get replyTo;
  static Serializer<GSendMessageInput> get serializer =>
      _$gSendMessageInputSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GSendMessageInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendMessageInput? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GSendMessageInput.serializer,
        json,
      );
}

abstract class GTaskTagInput
    implements Built<GTaskTagInput, GTaskTagInputBuilder> {
  GTaskTagInput._();

  factory GTaskTagInput([void Function(GTaskTagInputBuilder b) updates]) =
      _$GTaskTagInput;

  String get tagId;
  bool? get viewRole;
  bool? get interactRole;
  bool? get moderateRole;
  static Serializer<GTaskTagInput> get serializer => _$gTaskTagInputSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GTaskTagInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTaskTagInput? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GTaskTagInput.serializer,
        json,
      );
}

abstract class GCreateTaskInput
    implements Built<GCreateTaskInput, GCreateTaskInputBuilder> {
  GCreateTaskInput._();

  factory GCreateTaskInput([void Function(GCreateTaskInputBuilder b) updates]) =
      _$GCreateTaskInput;

  String get title;
  String? get description;
  GTime? get dueAt;
  BuiltList<GTaskTagInput>? get tags;
  BuiltList<String>? get assignees;
  static Serializer<GCreateTaskInput> get serializer =>
      _$gCreateTaskInputSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GCreateTaskInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateTaskInput? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GCreateTaskInput.serializer,
        json,
      );
}

abstract class GEditTaskInput
    implements Built<GEditTaskInput, GEditTaskInputBuilder> {
  GEditTaskInput._();

  factory GEditTaskInput([void Function(GEditTaskInputBuilder b) updates]) =
      _$GEditTaskInput;

  String get taskId;
  String? get title;
  String? get description;
  GTime? get dueAt;
  bool? get clearDueAt;
  static Serializer<GEditTaskInput> get serializer =>
      _$gEditTaskInputSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GEditTaskInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GEditTaskInput? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GEditTaskInput.serializer,
        json,
      );
}

const Map<String, Set<String>> possibleTypesMap = {
  'Principal': {
    'User',
    'Bot',
  },
  'SearchResult': {
    'Post',
    'Comment',
  },
  'NotificationSource': {
    'Post',
    'Comment',
    'Task',
    'Message',
  },
};
