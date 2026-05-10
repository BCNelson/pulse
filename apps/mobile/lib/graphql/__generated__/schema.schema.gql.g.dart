// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.schema.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GTagRootKind _$gTagRootKindORG = const GTagRootKind._('ORG');
const GTagRootKind _$gTagRootKindUSER = const GTagRootKind._('USER');

GTagRootKind _$gTagRootKindValueOf(String name) {
  switch (name) {
    case 'ORG':
      return _$gTagRootKindORG;
    case 'USER':
      return _$gTagRootKindUSER;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GTagRootKind> _$gTagRootKindValues =
    BuiltSet<GTagRootKind>(const <GTagRootKind>[
  _$gTagRootKindORG,
  _$gTagRootKindUSER,
]);

const GPermissionBundle _$gPermissionBundleVIEWER =
    const GPermissionBundle._('VIEWER');
const GPermissionBundle _$gPermissionBundleCONTRIBUTOR =
    const GPermissionBundle._('CONTRIBUTOR');
const GPermissionBundle _$gPermissionBundleMODERATOR =
    const GPermissionBundle._('MODERATOR');
const GPermissionBundle _$gPermissionBundleOWNER =
    const GPermissionBundle._('OWNER');

GPermissionBundle _$gPermissionBundleValueOf(String name) {
  switch (name) {
    case 'VIEWER':
      return _$gPermissionBundleVIEWER;
    case 'CONTRIBUTOR':
      return _$gPermissionBundleCONTRIBUTOR;
    case 'MODERATOR':
      return _$gPermissionBundleMODERATOR;
    case 'OWNER':
      return _$gPermissionBundleOWNER;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GPermissionBundle> _$gPermissionBundleValues =
    BuiltSet<GPermissionBundle>(const <GPermissionBundle>[
  _$gPermissionBundleVIEWER,
  _$gPermissionBundleCONTRIBUTOR,
  _$gPermissionBundleMODERATOR,
  _$gPermissionBundleOWNER,
]);

const GSubscriptionUrgency _$gSubscriptionUrgencyHIGH =
    const GSubscriptionUrgency._('HIGH');
const GSubscriptionUrgency _$gSubscriptionUrgencyNORMAL =
    const GSubscriptionUrgency._('NORMAL');
const GSubscriptionUrgency _$gSubscriptionUrgencyLOW =
    const GSubscriptionUrgency._('LOW');
const GSubscriptionUrgency _$gSubscriptionUrgencyMUTE =
    const GSubscriptionUrgency._('MUTE');

GSubscriptionUrgency _$gSubscriptionUrgencyValueOf(String name) {
  switch (name) {
    case 'HIGH':
      return _$gSubscriptionUrgencyHIGH;
    case 'NORMAL':
      return _$gSubscriptionUrgencyNORMAL;
    case 'LOW':
      return _$gSubscriptionUrgencyLOW;
    case 'MUTE':
      return _$gSubscriptionUrgencyMUTE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GSubscriptionUrgency> _$gSubscriptionUrgencyValues =
    BuiltSet<GSubscriptionUrgency>(const <GSubscriptionUrgency>[
  _$gSubscriptionUrgencyHIGH,
  _$gSubscriptionUrgencyNORMAL,
  _$gSubscriptionUrgencyLOW,
  _$gSubscriptionUrgencyMUTE,
]);

const GPrincipalKind _$gPrincipalKindUSER = const GPrincipalKind._('USER');
const GPrincipalKind _$gPrincipalKindBOT = const GPrincipalKind._('BOT');

GPrincipalKind _$gPrincipalKindValueOf(String name) {
  switch (name) {
    case 'USER':
      return _$gPrincipalKindUSER;
    case 'BOT':
      return _$gPrincipalKindBOT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GPrincipalKind> _$gPrincipalKindValues =
    BuiltSet<GPrincipalKind>(const <GPrincipalKind>[
  _$gPrincipalKindUSER,
  _$gPrincipalKindBOT,
]);

const GPrincipalStatus _$gPrincipalStatusACTIVE =
    const GPrincipalStatus._('ACTIVE');
const GPrincipalStatus _$gPrincipalStatusTOMBSTONED =
    const GPrincipalStatus._('TOMBSTONED');

GPrincipalStatus _$gPrincipalStatusValueOf(String name) {
  switch (name) {
    case 'ACTIVE':
      return _$gPrincipalStatusACTIVE;
    case 'TOMBSTONED':
      return _$gPrincipalStatusTOMBSTONED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GPrincipalStatus> _$gPrincipalStatusValues =
    BuiltSet<GPrincipalStatus>(const <GPrincipalStatus>[
  _$gPrincipalStatusACTIVE,
  _$gPrincipalStatusTOMBSTONED,
]);

const GDecisionStatus _$gDecisionStatusDECISION =
    const GDecisionStatus._('DECISION');
const GDecisionStatus _$gDecisionStatusANSWER =
    const GDecisionStatus._('ANSWER');

GDecisionStatus _$gDecisionStatusValueOf(String name) {
  switch (name) {
    case 'DECISION':
      return _$gDecisionStatusDECISION;
    case 'ANSWER':
      return _$gDecisionStatusANSWER;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GDecisionStatus> _$gDecisionStatusValues =
    BuiltSet<GDecisionStatus>(const <GDecisionStatus>[
  _$gDecisionStatusDECISION,
  _$gDecisionStatusANSWER,
]);

const GSearchKind _$gSearchKindPOST = const GSearchKind._('POST');
const GSearchKind _$gSearchKindCOMMENT = const GSearchKind._('COMMENT');
const GSearchKind _$gSearchKindTASK = const GSearchKind._('TASK');
const GSearchKind _$gSearchKindMESSAGE = const GSearchKind._('MESSAGE');

GSearchKind _$gSearchKindValueOf(String name) {
  switch (name) {
    case 'POST':
      return _$gSearchKindPOST;
    case 'COMMENT':
      return _$gSearchKindCOMMENT;
    case 'TASK':
      return _$gSearchKindTASK;
    case 'MESSAGE':
      return _$gSearchKindMESSAGE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GSearchKind> _$gSearchKindValues =
    BuiltSet<GSearchKind>(const <GSearchKind>[
  _$gSearchKindPOST,
  _$gSearchKindCOMMENT,
  _$gSearchKindTASK,
  _$gSearchKindMESSAGE,
]);

const GTaskStatus _$gTaskStatusOPEN = const GTaskStatus._('OPEN');
const GTaskStatus _$gTaskStatusIN_PROGRESS = const GTaskStatus._('IN_PROGRESS');
const GTaskStatus _$gTaskStatusBLOCKED = const GTaskStatus._('BLOCKED');
const GTaskStatus _$gTaskStatusDONE = const GTaskStatus._('DONE');
const GTaskStatus _$gTaskStatusCANCELLED = const GTaskStatus._('CANCELLED');

GTaskStatus _$gTaskStatusValueOf(String name) {
  switch (name) {
    case 'OPEN':
      return _$gTaskStatusOPEN;
    case 'IN_PROGRESS':
      return _$gTaskStatusIN_PROGRESS;
    case 'BLOCKED':
      return _$gTaskStatusBLOCKED;
    case 'DONE':
      return _$gTaskStatusDONE;
    case 'CANCELLED':
      return _$gTaskStatusCANCELLED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GTaskStatus> _$gTaskStatusValues =
    BuiltSet<GTaskStatus>(const <GTaskStatus>[
  _$gTaskStatusOPEN,
  _$gTaskStatusIN_PROGRESS,
  _$gTaskStatusBLOCKED,
  _$gTaskStatusDONE,
  _$gTaskStatusCANCELLED,
]);

const GNotificationReason _$gNotificationReasonASSIGNMENT =
    const GNotificationReason._('ASSIGNMENT');
const GNotificationReason _$gNotificationReasonMENTION =
    const GNotificationReason._('MENTION');
const GNotificationReason _$gNotificationReasonWATCHER =
    const GNotificationReason._('WATCHER');
const GNotificationReason _$gNotificationReasonTAG_SUBSCRIPTION =
    const GNotificationReason._('TAG_SUBSCRIPTION');
const GNotificationReason _$gNotificationReasonDM =
    const GNotificationReason._('DM');

GNotificationReason _$gNotificationReasonValueOf(String name) {
  switch (name) {
    case 'ASSIGNMENT':
      return _$gNotificationReasonASSIGNMENT;
    case 'MENTION':
      return _$gNotificationReasonMENTION;
    case 'WATCHER':
      return _$gNotificationReasonWATCHER;
    case 'TAG_SUBSCRIPTION':
      return _$gNotificationReasonTAG_SUBSCRIPTION;
    case 'DM':
      return _$gNotificationReasonDM;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GNotificationReason> _$gNotificationReasonValues =
    BuiltSet<GNotificationReason>(const <GNotificationReason>[
  _$gNotificationReasonASSIGNMENT,
  _$gNotificationReasonMENTION,
  _$gNotificationReasonWATCHER,
  _$gNotificationReasonTAG_SUBSCRIPTION,
  _$gNotificationReasonDM,
]);

const GNotificationUrgency _$gNotificationUrgencyHIGH =
    const GNotificationUrgency._('HIGH');
const GNotificationUrgency _$gNotificationUrgencyNORMAL =
    const GNotificationUrgency._('NORMAL');
const GNotificationUrgency _$gNotificationUrgencyLOW =
    const GNotificationUrgency._('LOW');

GNotificationUrgency _$gNotificationUrgencyValueOf(String name) {
  switch (name) {
    case 'HIGH':
      return _$gNotificationUrgencyHIGH;
    case 'NORMAL':
      return _$gNotificationUrgencyNORMAL;
    case 'LOW':
      return _$gNotificationUrgencyLOW;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GNotificationUrgency> _$gNotificationUrgencyValues =
    BuiltSet<GNotificationUrgency>(const <GNotificationUrgency>[
  _$gNotificationUrgencyHIGH,
  _$gNotificationUrgencyNORMAL,
  _$gNotificationUrgencyLOW,
]);

const GDevicePlatform _$gDevicePlatformIOS = const GDevicePlatform._('IOS');
const GDevicePlatform _$gDevicePlatformANDROID =
    const GDevicePlatform._('ANDROID');
const GDevicePlatform _$gDevicePlatformWEB = const GDevicePlatform._('WEB');

GDevicePlatform _$gDevicePlatformValueOf(String name) {
  switch (name) {
    case 'IOS':
      return _$gDevicePlatformIOS;
    case 'ANDROID':
      return _$gDevicePlatformANDROID;
    case 'WEB':
      return _$gDevicePlatformWEB;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GDevicePlatform> _$gDevicePlatformValues =
    BuiltSet<GDevicePlatform>(const <GDevicePlatform>[
  _$gDevicePlatformIOS,
  _$gDevicePlatformANDROID,
  _$gDevicePlatformWEB,
]);

const GPostSort _$gPostSortRECENT = const GPostSort._('RECENT');
const GPostSort _$gPostSortACTIVE = const GPostSort._('ACTIVE');

GPostSort _$gPostSortValueOf(String name) {
  switch (name) {
    case 'RECENT':
      return _$gPostSortRECENT;
    case 'ACTIVE':
      return _$gPostSortACTIVE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GPostSort> _$gPostSortValues =
    BuiltSet<GPostSort>(const <GPostSort>[
  _$gPostSortRECENT,
  _$gPostSortACTIVE,
]);

Serializer<GTagRootKind> _$gTagRootKindSerializer = _$GTagRootKindSerializer();
Serializer<GPermissionBundle> _$gPermissionBundleSerializer =
    _$GPermissionBundleSerializer();
Serializer<GSubscriptionUrgency> _$gSubscriptionUrgencySerializer =
    _$GSubscriptionUrgencySerializer();
Serializer<GPrincipalKind> _$gPrincipalKindSerializer =
    _$GPrincipalKindSerializer();
Serializer<GPrincipalStatus> _$gPrincipalStatusSerializer =
    _$GPrincipalStatusSerializer();
Serializer<GDecisionStatus> _$gDecisionStatusSerializer =
    _$GDecisionStatusSerializer();
Serializer<GSearchKind> _$gSearchKindSerializer = _$GSearchKindSerializer();
Serializer<GTaskStatus> _$gTaskStatusSerializer = _$GTaskStatusSerializer();
Serializer<GNotificationReason> _$gNotificationReasonSerializer =
    _$GNotificationReasonSerializer();
Serializer<GNotificationUrgency> _$gNotificationUrgencySerializer =
    _$GNotificationUrgencySerializer();
Serializer<GDevicePlatform> _$gDevicePlatformSerializer =
    _$GDevicePlatformSerializer();
Serializer<GPostSort> _$gPostSortSerializer = _$GPostSortSerializer();
Serializer<GNotificationFilter> _$gNotificationFilterSerializer =
    _$GNotificationFilterSerializer();
Serializer<GCreateTagInput> _$gCreateTagInputSerializer =
    _$GCreateTagInputSerializer();
Serializer<GGrantTagInput> _$gGrantTagInputSerializer =
    _$GGrantTagInputSerializer();
Serializer<GSubscribeTagInput> _$gSubscribeTagInputSerializer =
    _$GSubscribeTagInputSerializer();
Serializer<GPostTagInput> _$gPostTagInputSerializer =
    _$GPostTagInputSerializer();
Serializer<GCreatePostInput> _$gCreatePostInputSerializer =
    _$GCreatePostInputSerializer();
Serializer<GEditPostInput> _$gEditPostInputSerializer =
    _$GEditPostInputSerializer();
Serializer<GCreateCommentInput> _$gCreateCommentInputSerializer =
    _$GCreateCommentInputSerializer();
Serializer<GCreateChatRoomInput> _$gCreateChatRoomInputSerializer =
    _$GCreateChatRoomInputSerializer();
Serializer<GSendMessageInput> _$gSendMessageInputSerializer =
    _$GSendMessageInputSerializer();
Serializer<GTaskTagInput> _$gTaskTagInputSerializer =
    _$GTaskTagInputSerializer();
Serializer<GCreateTaskInput> _$gCreateTaskInputSerializer =
    _$GCreateTaskInputSerializer();
Serializer<GEditTaskInput> _$gEditTaskInputSerializer =
    _$GEditTaskInputSerializer();

class _$GTagRootKindSerializer implements PrimitiveSerializer<GTagRootKind> {
  @override
  final Iterable<Type> types = const <Type>[GTagRootKind];
  @override
  final String wireName = 'GTagRootKind';

  @override
  Object serialize(Serializers serializers, GTagRootKind object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GTagRootKind deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GTagRootKind.valueOf(serialized as String);
}

class _$GPermissionBundleSerializer
    implements PrimitiveSerializer<GPermissionBundle> {
  @override
  final Iterable<Type> types = const <Type>[GPermissionBundle];
  @override
  final String wireName = 'GPermissionBundle';

  @override
  Object serialize(Serializers serializers, GPermissionBundle object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GPermissionBundle deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GPermissionBundle.valueOf(serialized as String);
}

class _$GSubscriptionUrgencySerializer
    implements PrimitiveSerializer<GSubscriptionUrgency> {
  @override
  final Iterable<Type> types = const <Type>[GSubscriptionUrgency];
  @override
  final String wireName = 'GSubscriptionUrgency';

  @override
  Object serialize(Serializers serializers, GSubscriptionUrgency object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GSubscriptionUrgency deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GSubscriptionUrgency.valueOf(serialized as String);
}

class _$GPrincipalKindSerializer
    implements PrimitiveSerializer<GPrincipalKind> {
  @override
  final Iterable<Type> types = const <Type>[GPrincipalKind];
  @override
  final String wireName = 'GPrincipalKind';

  @override
  Object serialize(Serializers serializers, GPrincipalKind object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GPrincipalKind deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GPrincipalKind.valueOf(serialized as String);
}

class _$GPrincipalStatusSerializer
    implements PrimitiveSerializer<GPrincipalStatus> {
  @override
  final Iterable<Type> types = const <Type>[GPrincipalStatus];
  @override
  final String wireName = 'GPrincipalStatus';

  @override
  Object serialize(Serializers serializers, GPrincipalStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GPrincipalStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GPrincipalStatus.valueOf(serialized as String);
}

class _$GDecisionStatusSerializer
    implements PrimitiveSerializer<GDecisionStatus> {
  @override
  final Iterable<Type> types = const <Type>[GDecisionStatus];
  @override
  final String wireName = 'GDecisionStatus';

  @override
  Object serialize(Serializers serializers, GDecisionStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GDecisionStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GDecisionStatus.valueOf(serialized as String);
}

class _$GSearchKindSerializer implements PrimitiveSerializer<GSearchKind> {
  @override
  final Iterable<Type> types = const <Type>[GSearchKind];
  @override
  final String wireName = 'GSearchKind';

  @override
  Object serialize(Serializers serializers, GSearchKind object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GSearchKind deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GSearchKind.valueOf(serialized as String);
}

class _$GTaskStatusSerializer implements PrimitiveSerializer<GTaskStatus> {
  @override
  final Iterable<Type> types = const <Type>[GTaskStatus];
  @override
  final String wireName = 'GTaskStatus';

  @override
  Object serialize(Serializers serializers, GTaskStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GTaskStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GTaskStatus.valueOf(serialized as String);
}

class _$GNotificationReasonSerializer
    implements PrimitiveSerializer<GNotificationReason> {
  @override
  final Iterable<Type> types = const <Type>[GNotificationReason];
  @override
  final String wireName = 'GNotificationReason';

  @override
  Object serialize(Serializers serializers, GNotificationReason object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GNotificationReason deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GNotificationReason.valueOf(serialized as String);
}

class _$GNotificationUrgencySerializer
    implements PrimitiveSerializer<GNotificationUrgency> {
  @override
  final Iterable<Type> types = const <Type>[GNotificationUrgency];
  @override
  final String wireName = 'GNotificationUrgency';

  @override
  Object serialize(Serializers serializers, GNotificationUrgency object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GNotificationUrgency deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GNotificationUrgency.valueOf(serialized as String);
}

class _$GDevicePlatformSerializer
    implements PrimitiveSerializer<GDevicePlatform> {
  @override
  final Iterable<Type> types = const <Type>[GDevicePlatform];
  @override
  final String wireName = 'GDevicePlatform';

  @override
  Object serialize(Serializers serializers, GDevicePlatform object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GDevicePlatform deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GDevicePlatform.valueOf(serialized as String);
}

class _$GPostSortSerializer implements PrimitiveSerializer<GPostSort> {
  @override
  final Iterable<Type> types = const <Type>[GPostSort];
  @override
  final String wireName = 'GPostSort';

  @override
  Object serialize(Serializers serializers, GPostSort object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GPostSort deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GPostSort.valueOf(serialized as String);
}

class _$GNotificationFilterSerializer
    implements StructuredSerializer<GNotificationFilter> {
  @override
  final Iterable<Type> types = const [
    GNotificationFilter,
    _$GNotificationFilter
  ];
  @override
  final String wireName = 'GNotificationFilter';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GNotificationFilter object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.unreadOnly;
    if (value != null) {
      result
        ..add('unreadOnly')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.reasons;
    if (value != null) {
      result
        ..add('reasons')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(GNotificationReason)])));
    }
    return result;
  }

  @override
  GNotificationFilter deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GNotificationFilterBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'unreadOnly':
          result.unreadOnly = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'reasons':
          result.reasons.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(GNotificationReason)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateTagInputSerializer
    implements StructuredSerializer<GCreateTagInput> {
  @override
  final Iterable<Type> types = const [GCreateTagInput, _$GCreateTagInput];
  @override
  final String wireName = 'GCreateTagInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GCreateTagInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'parentId',
      serializers.serialize(object.parentId,
          specifiedType: const FullType(String)),
      'slug',
      serializers.serialize(object.slug, specifiedType: const FullType(String)),
      'displayName',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.defaults;
    if (value != null) {
      result
        ..add('defaults')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(GJSON)));
    }
    return result;
  }

  @override
  GCreateTagInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreateTagInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'parentId':
          result.parentId = serializers.deserialize(value,
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
        case 'defaults':
          result.defaults.replace(serializers.deserialize(value,
              specifiedType: const FullType(GJSON))! as GJSON);
          break;
      }
    }

    return result.build();
  }
}

class _$GGrantTagInputSerializer
    implements StructuredSerializer<GGrantTagInput> {
  @override
  final Iterable<Type> types = const [GGrantTagInput, _$GGrantTagInput];
  @override
  final String wireName = 'GGrantTagInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GGrantTagInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'tagId',
      serializers.serialize(object.tagId,
          specifiedType: const FullType(String)),
      'principalId',
      serializers.serialize(object.principalId,
          specifiedType: const FullType(String)),
      'bundle',
      serializers.serialize(object.bundle,
          specifiedType: const FullType(GPermissionBundle)),
    ];
    Object? value;
    value = object.extras;
    if (value != null) {
      result
        ..add('extras')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.cascade;
    if (value != null) {
      result
        ..add('cascade')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  GGrantTagInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GGrantTagInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'tagId':
          result.tagId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'principalId':
          result.principalId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'bundle':
          result.bundle = serializers.deserialize(value,
                  specifiedType: const FullType(GPermissionBundle))!
              as GPermissionBundle;
          break;
        case 'extras':
          result.extras.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'cascade':
          result.cascade = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$GSubscribeTagInputSerializer
    implements StructuredSerializer<GSubscribeTagInput> {
  @override
  final Iterable<Type> types = const [GSubscribeTagInput, _$GSubscribeTagInput];
  @override
  final String wireName = 'GSubscribeTagInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSubscribeTagInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'tagId',
      serializers.serialize(object.tagId,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.cascade;
    if (value != null) {
      result
        ..add('cascade')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.urgency;
    if (value != null) {
      result
        ..add('urgency')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GSubscriptionUrgency)));
    }
    value = object.reasonFilter;
    if (value != null) {
      result
        ..add('reasonFilter')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    return result;
  }

  @override
  GSubscribeTagInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GSubscribeTagInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'tagId':
          result.tagId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'cascade':
          result.cascade = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'urgency':
          result.urgency = serializers.deserialize(value,
                  specifiedType: const FullType(GSubscriptionUrgency))
              as GSubscriptionUrgency?;
          break;
        case 'reasonFilter':
          result.reasonFilter.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GPostTagInputSerializer implements StructuredSerializer<GPostTagInput> {
  @override
  final Iterable<Type> types = const [GPostTagInput, _$GPostTagInput];
  @override
  final String wireName = 'GPostTagInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GPostTagInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'tagId',
      serializers.serialize(object.tagId,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.viewRole;
    if (value != null) {
      result
        ..add('viewRole')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.interactRole;
    if (value != null) {
      result
        ..add('interactRole')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.moderateRole;
    if (value != null) {
      result
        ..add('moderateRole')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  GPostTagInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostTagInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'tagId':
          result.tagId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'viewRole':
          result.viewRole = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'interactRole':
          result.interactRole = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'moderateRole':
          result.moderateRole = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$GCreatePostInputSerializer
    implements StructuredSerializer<GCreatePostInput> {
  @override
  final Iterable<Type> types = const [GCreatePostInput, _$GCreatePostInput];
  @override
  final String wireName = 'GCreatePostInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GCreatePostInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
      'tags',
      serializers.serialize(object.tags,
          specifiedType:
              const FullType(BuiltList, const [const FullType(GPostTagInput)])),
    ];

    return result;
  }

  @override
  GCreatePostInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreatePostInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'tags':
          result.tags.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(GPostTagInput)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GEditPostInputSerializer
    implements StructuredSerializer<GEditPostInput> {
  @override
  final Iterable<Type> types = const [GEditPostInput, _$GEditPostInput];
  @override
  final String wireName = 'GEditPostInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GEditPostInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'postId',
      serializers.serialize(object.postId,
          specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GEditPostInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GEditPostInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'postId':
          result.postId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
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

class _$GCreateCommentInputSerializer
    implements StructuredSerializer<GCreateCommentInput> {
  @override
  final Iterable<Type> types = const [
    GCreateCommentInput,
    _$GCreateCommentInput
  ];
  @override
  final String wireName = 'GCreateCommentInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateCommentInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'postId',
      serializers.serialize(object.postId,
          specifiedType: const FullType(String)),
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.parentId;
    if (value != null) {
      result
        ..add('parentId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GCreateCommentInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreateCommentInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'postId':
          result.postId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'parentId':
          result.parentId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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

class _$GCreateChatRoomInputSerializer
    implements StructuredSerializer<GCreateChatRoomInput> {
  @override
  final Iterable<Type> types = const [
    GCreateChatRoomInput,
    _$GCreateChatRoomInput
  ];
  @override
  final String wireName = 'GCreateChatRoomInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateChatRoomInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.tagIds;
    if (value != null) {
      result
        ..add('tagIds')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.participantIds;
    if (value != null) {
      result
        ..add('participantIds')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    return result;
  }

  @override
  GCreateChatRoomInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreateChatRoomInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'tagIds':
          result.tagIds.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'participantIds':
          result.participantIds.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GSendMessageInputSerializer
    implements StructuredSerializer<GSendMessageInput> {
  @override
  final Iterable<Type> types = const [GSendMessageInput, _$GSendMessageInput];
  @override
  final String wireName = 'GSendMessageInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GSendMessageInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'roomId',
      serializers.serialize(object.roomId,
          specifiedType: const FullType(String)),
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.replyTo;
    if (value != null) {
      result
        ..add('replyTo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GSendMessageInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GSendMessageInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'roomId':
          result.roomId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'replyTo':
          result.replyTo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GTaskTagInputSerializer implements StructuredSerializer<GTaskTagInput> {
  @override
  final Iterable<Type> types = const [GTaskTagInput, _$GTaskTagInput];
  @override
  final String wireName = 'GTaskTagInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GTaskTagInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'tagId',
      serializers.serialize(object.tagId,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.viewRole;
    if (value != null) {
      result
        ..add('viewRole')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.interactRole;
    if (value != null) {
      result
        ..add('interactRole')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.moderateRole;
    if (value != null) {
      result
        ..add('moderateRole')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  GTaskTagInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GTaskTagInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'tagId':
          result.tagId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'viewRole':
          result.viewRole = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'interactRole':
          result.interactRole = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'moderateRole':
          result.moderateRole = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateTaskInputSerializer
    implements StructuredSerializer<GCreateTaskInput> {
  @override
  final Iterable<Type> types = const [GCreateTaskInput, _$GCreateTaskInput];
  @override
  final String wireName = 'GCreateTaskInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GCreateTaskInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.dueAt;
    if (value != null) {
      result
        ..add('dueAt')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(GTime)));
    }
    value = object.tags;
    if (value != null) {
      result
        ..add('tags')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(GTaskTagInput)])));
    }
    value = object.assignees;
    if (value != null) {
      result
        ..add('assignees')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    return result;
  }

  @override
  GCreateTaskInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreateTaskInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'dueAt':
          result.dueAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(GTime))! as GTime);
          break;
        case 'tags':
          result.tags.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(GTaskTagInput)]))!
              as BuiltList<Object?>);
          break;
        case 'assignees':
          result.assignees.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GEditTaskInputSerializer
    implements StructuredSerializer<GEditTaskInput> {
  @override
  final Iterable<Type> types = const [GEditTaskInput, _$GEditTaskInput];
  @override
  final String wireName = 'GEditTaskInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GEditTaskInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'taskId',
      serializers.serialize(object.taskId,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.dueAt;
    if (value != null) {
      result
        ..add('dueAt')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(GTime)));
    }
    value = object.clearDueAt;
    if (value != null) {
      result
        ..add('clearDueAt')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  GEditTaskInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GEditTaskInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'taskId':
          result.taskId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'dueAt':
          result.dueAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(GTime))! as GTime);
          break;
        case 'clearDueAt':
          result.clearDueAt = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$GTime extends GTime {
  @override
  final String value;

  factory _$GTime([void Function(GTimeBuilder)? updates]) =>
      (GTimeBuilder()..update(updates))._build();

  _$GTime._({required this.value}) : super._();
  @override
  GTime rebuild(void Function(GTimeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GTimeBuilder toBuilder() => GTimeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GTime && value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GTime')..add('value', value))
        .toString();
  }
}

class GTimeBuilder implements Builder<GTime, GTimeBuilder> {
  _$GTime? _$v;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  GTimeBuilder();

  GTimeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GTime other) {
    _$v = other as _$GTime;
  }

  @override
  void update(void Function(GTimeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GTime build() => _build();

  _$GTime _build() {
    final _$result = _$v ??
        _$GTime._(
          value:
              BuiltValueNullFieldError.checkNotNull(value, r'GTime', 'value'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GJSON extends GJSON {
  @override
  final String value;

  factory _$GJSON([void Function(GJSONBuilder)? updates]) =>
      (GJSONBuilder()..update(updates))._build();

  _$GJSON._({required this.value}) : super._();
  @override
  GJSON rebuild(void Function(GJSONBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GJSONBuilder toBuilder() => GJSONBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GJSON && value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GJSON')..add('value', value))
        .toString();
  }
}

class GJSONBuilder implements Builder<GJSON, GJSONBuilder> {
  _$GJSON? _$v;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  GJSONBuilder();

  GJSONBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GJSON other) {
    _$v = other as _$GJSON;
  }

  @override
  void update(void Function(GJSONBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GJSON build() => _build();

  _$GJSON _build() {
    final _$result = _$v ??
        _$GJSON._(
          value:
              BuiltValueNullFieldError.checkNotNull(value, r'GJSON', 'value'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationFilter extends GNotificationFilter {
  @override
  final bool? unreadOnly;
  @override
  final BuiltList<GNotificationReason>? reasons;

  factory _$GNotificationFilter(
          [void Function(GNotificationFilterBuilder)? updates]) =>
      (GNotificationFilterBuilder()..update(updates))._build();

  _$GNotificationFilter._({this.unreadOnly, this.reasons}) : super._();
  @override
  GNotificationFilter rebuild(
          void Function(GNotificationFilterBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationFilterBuilder toBuilder() =>
      GNotificationFilterBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationFilter &&
        unreadOnly == other.unreadOnly &&
        reasons == other.reasons;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, unreadOnly.hashCode);
    _$hash = $jc(_$hash, reasons.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GNotificationFilter')
          ..add('unreadOnly', unreadOnly)
          ..add('reasons', reasons))
        .toString();
  }
}

class GNotificationFilterBuilder
    implements Builder<GNotificationFilter, GNotificationFilterBuilder> {
  _$GNotificationFilter? _$v;

  bool? _unreadOnly;
  bool? get unreadOnly => _$this._unreadOnly;
  set unreadOnly(bool? unreadOnly) => _$this._unreadOnly = unreadOnly;

  ListBuilder<GNotificationReason>? _reasons;
  ListBuilder<GNotificationReason> get reasons =>
      _$this._reasons ??= ListBuilder<GNotificationReason>();
  set reasons(ListBuilder<GNotificationReason>? reasons) =>
      _$this._reasons = reasons;

  GNotificationFilterBuilder();

  GNotificationFilterBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _unreadOnly = $v.unreadOnly;
      _reasons = $v.reasons?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GNotificationFilter other) {
    _$v = other as _$GNotificationFilter;
  }

  @override
  void update(void Function(GNotificationFilterBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationFilter build() => _build();

  _$GNotificationFilter _build() {
    _$GNotificationFilter _$result;
    try {
      _$result = _$v ??
          _$GNotificationFilter._(
            unreadOnly: unreadOnly,
            reasons: _reasons?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'reasons';
        _reasons?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GNotificationFilter', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateTagInput extends GCreateTagInput {
  @override
  final String parentId;
  @override
  final String slug;
  @override
  final String displayName;
  @override
  final GJSON? defaults;

  factory _$GCreateTagInput([void Function(GCreateTagInputBuilder)? updates]) =>
      (GCreateTagInputBuilder()..update(updates))._build();

  _$GCreateTagInput._(
      {required this.parentId,
      required this.slug,
      required this.displayName,
      this.defaults})
      : super._();
  @override
  GCreateTagInput rebuild(void Function(GCreateTagInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateTagInputBuilder toBuilder() => GCreateTagInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateTagInput &&
        parentId == other.parentId &&
        slug == other.slug &&
        displayName == other.displayName &&
        defaults == other.defaults;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, parentId.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, defaults.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateTagInput')
          ..add('parentId', parentId)
          ..add('slug', slug)
          ..add('displayName', displayName)
          ..add('defaults', defaults))
        .toString();
  }
}

class GCreateTagInputBuilder
    implements Builder<GCreateTagInput, GCreateTagInputBuilder> {
  _$GCreateTagInput? _$v;

  String? _parentId;
  String? get parentId => _$this._parentId;
  set parentId(String? parentId) => _$this._parentId = parentId;

  String? _slug;
  String? get slug => _$this._slug;
  set slug(String? slug) => _$this._slug = slug;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GJSONBuilder? _defaults;
  GJSONBuilder get defaults => _$this._defaults ??= GJSONBuilder();
  set defaults(GJSONBuilder? defaults) => _$this._defaults = defaults;

  GCreateTagInputBuilder();

  GCreateTagInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _parentId = $v.parentId;
      _slug = $v.slug;
      _displayName = $v.displayName;
      _defaults = $v.defaults?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateTagInput other) {
    _$v = other as _$GCreateTagInput;
  }

  @override
  void update(void Function(GCreateTagInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateTagInput build() => _build();

  _$GCreateTagInput _build() {
    _$GCreateTagInput _$result;
    try {
      _$result = _$v ??
          _$GCreateTagInput._(
            parentId: BuiltValueNullFieldError.checkNotNull(
                parentId, r'GCreateTagInput', 'parentId'),
            slug: BuiltValueNullFieldError.checkNotNull(
                slug, r'GCreateTagInput', 'slug'),
            displayName: BuiltValueNullFieldError.checkNotNull(
                displayName, r'GCreateTagInput', 'displayName'),
            defaults: _defaults?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'defaults';
        _defaults?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GCreateTagInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGrantTagInput extends GGrantTagInput {
  @override
  final String tagId;
  @override
  final String principalId;
  @override
  final GPermissionBundle bundle;
  @override
  final BuiltList<String>? extras;
  @override
  final bool? cascade;

  factory _$GGrantTagInput([void Function(GGrantTagInputBuilder)? updates]) =>
      (GGrantTagInputBuilder()..update(updates))._build();

  _$GGrantTagInput._(
      {required this.tagId,
      required this.principalId,
      required this.bundle,
      this.extras,
      this.cascade})
      : super._();
  @override
  GGrantTagInput rebuild(void Function(GGrantTagInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGrantTagInputBuilder toBuilder() => GGrantTagInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGrantTagInput &&
        tagId == other.tagId &&
        principalId == other.principalId &&
        bundle == other.bundle &&
        extras == other.extras &&
        cascade == other.cascade;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tagId.hashCode);
    _$hash = $jc(_$hash, principalId.hashCode);
    _$hash = $jc(_$hash, bundle.hashCode);
    _$hash = $jc(_$hash, extras.hashCode);
    _$hash = $jc(_$hash, cascade.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGrantTagInput')
          ..add('tagId', tagId)
          ..add('principalId', principalId)
          ..add('bundle', bundle)
          ..add('extras', extras)
          ..add('cascade', cascade))
        .toString();
  }
}

class GGrantTagInputBuilder
    implements Builder<GGrantTagInput, GGrantTagInputBuilder> {
  _$GGrantTagInput? _$v;

  String? _tagId;
  String? get tagId => _$this._tagId;
  set tagId(String? tagId) => _$this._tagId = tagId;

  String? _principalId;
  String? get principalId => _$this._principalId;
  set principalId(String? principalId) => _$this._principalId = principalId;

  GPermissionBundle? _bundle;
  GPermissionBundle? get bundle => _$this._bundle;
  set bundle(GPermissionBundle? bundle) => _$this._bundle = bundle;

  ListBuilder<String>? _extras;
  ListBuilder<String> get extras => _$this._extras ??= ListBuilder<String>();
  set extras(ListBuilder<String>? extras) => _$this._extras = extras;

  bool? _cascade;
  bool? get cascade => _$this._cascade;
  set cascade(bool? cascade) => _$this._cascade = cascade;

  GGrantTagInputBuilder();

  GGrantTagInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tagId = $v.tagId;
      _principalId = $v.principalId;
      _bundle = $v.bundle;
      _extras = $v.extras?.toBuilder();
      _cascade = $v.cascade;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGrantTagInput other) {
    _$v = other as _$GGrantTagInput;
  }

  @override
  void update(void Function(GGrantTagInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGrantTagInput build() => _build();

  _$GGrantTagInput _build() {
    _$GGrantTagInput _$result;
    try {
      _$result = _$v ??
          _$GGrantTagInput._(
            tagId: BuiltValueNullFieldError.checkNotNull(
                tagId, r'GGrantTagInput', 'tagId'),
            principalId: BuiltValueNullFieldError.checkNotNull(
                principalId, r'GGrantTagInput', 'principalId'),
            bundle: BuiltValueNullFieldError.checkNotNull(
                bundle, r'GGrantTagInput', 'bundle'),
            extras: _extras?.build(),
            cascade: cascade,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'extras';
        _extras?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GGrantTagInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSubscribeTagInput extends GSubscribeTagInput {
  @override
  final String tagId;
  @override
  final bool? cascade;
  @override
  final GSubscriptionUrgency? urgency;
  @override
  final BuiltList<String>? reasonFilter;

  factory _$GSubscribeTagInput(
          [void Function(GSubscribeTagInputBuilder)? updates]) =>
      (GSubscribeTagInputBuilder()..update(updates))._build();

  _$GSubscribeTagInput._(
      {required this.tagId, this.cascade, this.urgency, this.reasonFilter})
      : super._();
  @override
  GSubscribeTagInput rebuild(
          void Function(GSubscribeTagInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSubscribeTagInputBuilder toBuilder() =>
      GSubscribeTagInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSubscribeTagInput &&
        tagId == other.tagId &&
        cascade == other.cascade &&
        urgency == other.urgency &&
        reasonFilter == other.reasonFilter;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tagId.hashCode);
    _$hash = $jc(_$hash, cascade.hashCode);
    _$hash = $jc(_$hash, urgency.hashCode);
    _$hash = $jc(_$hash, reasonFilter.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSubscribeTagInput')
          ..add('tagId', tagId)
          ..add('cascade', cascade)
          ..add('urgency', urgency)
          ..add('reasonFilter', reasonFilter))
        .toString();
  }
}

class GSubscribeTagInputBuilder
    implements Builder<GSubscribeTagInput, GSubscribeTagInputBuilder> {
  _$GSubscribeTagInput? _$v;

  String? _tagId;
  String? get tagId => _$this._tagId;
  set tagId(String? tagId) => _$this._tagId = tagId;

  bool? _cascade;
  bool? get cascade => _$this._cascade;
  set cascade(bool? cascade) => _$this._cascade = cascade;

  GSubscriptionUrgency? _urgency;
  GSubscriptionUrgency? get urgency => _$this._urgency;
  set urgency(GSubscriptionUrgency? urgency) => _$this._urgency = urgency;

  ListBuilder<String>? _reasonFilter;
  ListBuilder<String> get reasonFilter =>
      _$this._reasonFilter ??= ListBuilder<String>();
  set reasonFilter(ListBuilder<String>? reasonFilter) =>
      _$this._reasonFilter = reasonFilter;

  GSubscribeTagInputBuilder();

  GSubscribeTagInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tagId = $v.tagId;
      _cascade = $v.cascade;
      _urgency = $v.urgency;
      _reasonFilter = $v.reasonFilter?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSubscribeTagInput other) {
    _$v = other as _$GSubscribeTagInput;
  }

  @override
  void update(void Function(GSubscribeTagInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSubscribeTagInput build() => _build();

  _$GSubscribeTagInput _build() {
    _$GSubscribeTagInput _$result;
    try {
      _$result = _$v ??
          _$GSubscribeTagInput._(
            tagId: BuiltValueNullFieldError.checkNotNull(
                tagId, r'GSubscribeTagInput', 'tagId'),
            cascade: cascade,
            urgency: urgency,
            reasonFilter: _reasonFilter?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'reasonFilter';
        _reasonFilter?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GSubscribeTagInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GPostTagInput extends GPostTagInput {
  @override
  final String tagId;
  @override
  final bool? viewRole;
  @override
  final bool? interactRole;
  @override
  final bool? moderateRole;

  factory _$GPostTagInput([void Function(GPostTagInputBuilder)? updates]) =>
      (GPostTagInputBuilder()..update(updates))._build();

  _$GPostTagInput._(
      {required this.tagId,
      this.viewRole,
      this.interactRole,
      this.moderateRole})
      : super._();
  @override
  GPostTagInput rebuild(void Function(GPostTagInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostTagInputBuilder toBuilder() => GPostTagInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostTagInput &&
        tagId == other.tagId &&
        viewRole == other.viewRole &&
        interactRole == other.interactRole &&
        moderateRole == other.moderateRole;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tagId.hashCode);
    _$hash = $jc(_$hash, viewRole.hashCode);
    _$hash = $jc(_$hash, interactRole.hashCode);
    _$hash = $jc(_$hash, moderateRole.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostTagInput')
          ..add('tagId', tagId)
          ..add('viewRole', viewRole)
          ..add('interactRole', interactRole)
          ..add('moderateRole', moderateRole))
        .toString();
  }
}

class GPostTagInputBuilder
    implements Builder<GPostTagInput, GPostTagInputBuilder> {
  _$GPostTagInput? _$v;

  String? _tagId;
  String? get tagId => _$this._tagId;
  set tagId(String? tagId) => _$this._tagId = tagId;

  bool? _viewRole;
  bool? get viewRole => _$this._viewRole;
  set viewRole(bool? viewRole) => _$this._viewRole = viewRole;

  bool? _interactRole;
  bool? get interactRole => _$this._interactRole;
  set interactRole(bool? interactRole) => _$this._interactRole = interactRole;

  bool? _moderateRole;
  bool? get moderateRole => _$this._moderateRole;
  set moderateRole(bool? moderateRole) => _$this._moderateRole = moderateRole;

  GPostTagInputBuilder();

  GPostTagInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tagId = $v.tagId;
      _viewRole = $v.viewRole;
      _interactRole = $v.interactRole;
      _moderateRole = $v.moderateRole;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostTagInput other) {
    _$v = other as _$GPostTagInput;
  }

  @override
  void update(void Function(GPostTagInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostTagInput build() => _build();

  _$GPostTagInput _build() {
    final _$result = _$v ??
        _$GPostTagInput._(
          tagId: BuiltValueNullFieldError.checkNotNull(
              tagId, r'GPostTagInput', 'tagId'),
          viewRole: viewRole,
          interactRole: interactRole,
          moderateRole: moderateRole,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCreatePostInput extends GCreatePostInput {
  @override
  final String title;
  @override
  final String body;
  @override
  final BuiltList<GPostTagInput> tags;

  factory _$GCreatePostInput(
          [void Function(GCreatePostInputBuilder)? updates]) =>
      (GCreatePostInputBuilder()..update(updates))._build();

  _$GCreatePostInput._(
      {required this.title, required this.body, required this.tags})
      : super._();
  @override
  GCreatePostInput rebuild(void Function(GCreatePostInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreatePostInputBuilder toBuilder() =>
      GCreatePostInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreatePostInput &&
        title == other.title &&
        body == other.body &&
        tags == other.tags;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreatePostInput')
          ..add('title', title)
          ..add('body', body)
          ..add('tags', tags))
        .toString();
  }
}

class GCreatePostInputBuilder
    implements Builder<GCreatePostInput, GCreatePostInputBuilder> {
  _$GCreatePostInput? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  ListBuilder<GPostTagInput>? _tags;
  ListBuilder<GPostTagInput> get tags =>
      _$this._tags ??= ListBuilder<GPostTagInput>();
  set tags(ListBuilder<GPostTagInput>? tags) => _$this._tags = tags;

  GCreatePostInputBuilder();

  GCreatePostInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _body = $v.body;
      _tags = $v.tags.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreatePostInput other) {
    _$v = other as _$GCreatePostInput;
  }

  @override
  void update(void Function(GCreatePostInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreatePostInput build() => _build();

  _$GCreatePostInput _build() {
    _$GCreatePostInput _$result;
    try {
      _$result = _$v ??
          _$GCreatePostInput._(
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GCreatePostInput', 'title'),
            body: BuiltValueNullFieldError.checkNotNull(
                body, r'GCreatePostInput', 'body'),
            tags: tags.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tags';
        tags.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GCreatePostInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GEditPostInput extends GEditPostInput {
  @override
  final String postId;
  @override
  final String title;
  @override
  final String body;

  factory _$GEditPostInput([void Function(GEditPostInputBuilder)? updates]) =>
      (GEditPostInputBuilder()..update(updates))._build();

  _$GEditPostInput._(
      {required this.postId, required this.title, required this.body})
      : super._();
  @override
  GEditPostInput rebuild(void Function(GEditPostInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GEditPostInputBuilder toBuilder() => GEditPostInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GEditPostInput &&
        postId == other.postId &&
        title == other.title &&
        body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, postId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GEditPostInput')
          ..add('postId', postId)
          ..add('title', title)
          ..add('body', body))
        .toString();
  }
}

class GEditPostInputBuilder
    implements Builder<GEditPostInput, GEditPostInputBuilder> {
  _$GEditPostInput? _$v;

  String? _postId;
  String? get postId => _$this._postId;
  set postId(String? postId) => _$this._postId = postId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  GEditPostInputBuilder();

  GEditPostInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _postId = $v.postId;
      _title = $v.title;
      _body = $v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GEditPostInput other) {
    _$v = other as _$GEditPostInput;
  }

  @override
  void update(void Function(GEditPostInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GEditPostInput build() => _build();

  _$GEditPostInput _build() {
    final _$result = _$v ??
        _$GEditPostInput._(
          postId: BuiltValueNullFieldError.checkNotNull(
              postId, r'GEditPostInput', 'postId'),
          title: BuiltValueNullFieldError.checkNotNull(
              title, r'GEditPostInput', 'title'),
          body: BuiltValueNullFieldError.checkNotNull(
              body, r'GEditPostInput', 'body'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCreateCommentInput extends GCreateCommentInput {
  @override
  final String postId;
  @override
  final String? parentId;
  @override
  final String body;

  factory _$GCreateCommentInput(
          [void Function(GCreateCommentInputBuilder)? updates]) =>
      (GCreateCommentInputBuilder()..update(updates))._build();

  _$GCreateCommentInput._(
      {required this.postId, this.parentId, required this.body})
      : super._();
  @override
  GCreateCommentInput rebuild(
          void Function(GCreateCommentInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateCommentInputBuilder toBuilder() =>
      GCreateCommentInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateCommentInput &&
        postId == other.postId &&
        parentId == other.parentId &&
        body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, postId.hashCode);
    _$hash = $jc(_$hash, parentId.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateCommentInput')
          ..add('postId', postId)
          ..add('parentId', parentId)
          ..add('body', body))
        .toString();
  }
}

class GCreateCommentInputBuilder
    implements Builder<GCreateCommentInput, GCreateCommentInputBuilder> {
  _$GCreateCommentInput? _$v;

  String? _postId;
  String? get postId => _$this._postId;
  set postId(String? postId) => _$this._postId = postId;

  String? _parentId;
  String? get parentId => _$this._parentId;
  set parentId(String? parentId) => _$this._parentId = parentId;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  GCreateCommentInputBuilder();

  GCreateCommentInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _postId = $v.postId;
      _parentId = $v.parentId;
      _body = $v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateCommentInput other) {
    _$v = other as _$GCreateCommentInput;
  }

  @override
  void update(void Function(GCreateCommentInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateCommentInput build() => _build();

  _$GCreateCommentInput _build() {
    final _$result = _$v ??
        _$GCreateCommentInput._(
          postId: BuiltValueNullFieldError.checkNotNull(
              postId, r'GCreateCommentInput', 'postId'),
          parentId: parentId,
          body: BuiltValueNullFieldError.checkNotNull(
              body, r'GCreateCommentInput', 'body'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCreateChatRoomInput extends GCreateChatRoomInput {
  @override
  final BuiltList<String>? tagIds;
  @override
  final BuiltList<String>? participantIds;

  factory _$GCreateChatRoomInput(
          [void Function(GCreateChatRoomInputBuilder)? updates]) =>
      (GCreateChatRoomInputBuilder()..update(updates))._build();

  _$GCreateChatRoomInput._({this.tagIds, this.participantIds}) : super._();
  @override
  GCreateChatRoomInput rebuild(
          void Function(GCreateChatRoomInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateChatRoomInputBuilder toBuilder() =>
      GCreateChatRoomInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateChatRoomInput &&
        tagIds == other.tagIds &&
        participantIds == other.participantIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tagIds.hashCode);
    _$hash = $jc(_$hash, participantIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateChatRoomInput')
          ..add('tagIds', tagIds)
          ..add('participantIds', participantIds))
        .toString();
  }
}

class GCreateChatRoomInputBuilder
    implements Builder<GCreateChatRoomInput, GCreateChatRoomInputBuilder> {
  _$GCreateChatRoomInput? _$v;

  ListBuilder<String>? _tagIds;
  ListBuilder<String> get tagIds => _$this._tagIds ??= ListBuilder<String>();
  set tagIds(ListBuilder<String>? tagIds) => _$this._tagIds = tagIds;

  ListBuilder<String>? _participantIds;
  ListBuilder<String> get participantIds =>
      _$this._participantIds ??= ListBuilder<String>();
  set participantIds(ListBuilder<String>? participantIds) =>
      _$this._participantIds = participantIds;

  GCreateChatRoomInputBuilder();

  GCreateChatRoomInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tagIds = $v.tagIds?.toBuilder();
      _participantIds = $v.participantIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateChatRoomInput other) {
    _$v = other as _$GCreateChatRoomInput;
  }

  @override
  void update(void Function(GCreateChatRoomInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateChatRoomInput build() => _build();

  _$GCreateChatRoomInput _build() {
    _$GCreateChatRoomInput _$result;
    try {
      _$result = _$v ??
          _$GCreateChatRoomInput._(
            tagIds: _tagIds?.build(),
            participantIds: _participantIds?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tagIds';
        _tagIds?.build();
        _$failedField = 'participantIds';
        _participantIds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GCreateChatRoomInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSendMessageInput extends GSendMessageInput {
  @override
  final String roomId;
  @override
  final String body;
  @override
  final String? replyTo;

  factory _$GSendMessageInput(
          [void Function(GSendMessageInputBuilder)? updates]) =>
      (GSendMessageInputBuilder()..update(updates))._build();

  _$GSendMessageInput._(
      {required this.roomId, required this.body, this.replyTo})
      : super._();
  @override
  GSendMessageInput rebuild(void Function(GSendMessageInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendMessageInputBuilder toBuilder() =>
      GSendMessageInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendMessageInput &&
        roomId == other.roomId &&
        body == other.body &&
        replyTo == other.replyTo;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, roomId.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, replyTo.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSendMessageInput')
          ..add('roomId', roomId)
          ..add('body', body)
          ..add('replyTo', replyTo))
        .toString();
  }
}

class GSendMessageInputBuilder
    implements Builder<GSendMessageInput, GSendMessageInputBuilder> {
  _$GSendMessageInput? _$v;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  String? _replyTo;
  String? get replyTo => _$this._replyTo;
  set replyTo(String? replyTo) => _$this._replyTo = replyTo;

  GSendMessageInputBuilder();

  GSendMessageInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roomId = $v.roomId;
      _body = $v.body;
      _replyTo = $v.replyTo;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendMessageInput other) {
    _$v = other as _$GSendMessageInput;
  }

  @override
  void update(void Function(GSendMessageInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendMessageInput build() => _build();

  _$GSendMessageInput _build() {
    final _$result = _$v ??
        _$GSendMessageInput._(
          roomId: BuiltValueNullFieldError.checkNotNull(
              roomId, r'GSendMessageInput', 'roomId'),
          body: BuiltValueNullFieldError.checkNotNull(
              body, r'GSendMessageInput', 'body'),
          replyTo: replyTo,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GTaskTagInput extends GTaskTagInput {
  @override
  final String tagId;
  @override
  final bool? viewRole;
  @override
  final bool? interactRole;
  @override
  final bool? moderateRole;

  factory _$GTaskTagInput([void Function(GTaskTagInputBuilder)? updates]) =>
      (GTaskTagInputBuilder()..update(updates))._build();

  _$GTaskTagInput._(
      {required this.tagId,
      this.viewRole,
      this.interactRole,
      this.moderateRole})
      : super._();
  @override
  GTaskTagInput rebuild(void Function(GTaskTagInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GTaskTagInputBuilder toBuilder() => GTaskTagInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GTaskTagInput &&
        tagId == other.tagId &&
        viewRole == other.viewRole &&
        interactRole == other.interactRole &&
        moderateRole == other.moderateRole;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tagId.hashCode);
    _$hash = $jc(_$hash, viewRole.hashCode);
    _$hash = $jc(_$hash, interactRole.hashCode);
    _$hash = $jc(_$hash, moderateRole.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GTaskTagInput')
          ..add('tagId', tagId)
          ..add('viewRole', viewRole)
          ..add('interactRole', interactRole)
          ..add('moderateRole', moderateRole))
        .toString();
  }
}

class GTaskTagInputBuilder
    implements Builder<GTaskTagInput, GTaskTagInputBuilder> {
  _$GTaskTagInput? _$v;

  String? _tagId;
  String? get tagId => _$this._tagId;
  set tagId(String? tagId) => _$this._tagId = tagId;

  bool? _viewRole;
  bool? get viewRole => _$this._viewRole;
  set viewRole(bool? viewRole) => _$this._viewRole = viewRole;

  bool? _interactRole;
  bool? get interactRole => _$this._interactRole;
  set interactRole(bool? interactRole) => _$this._interactRole = interactRole;

  bool? _moderateRole;
  bool? get moderateRole => _$this._moderateRole;
  set moderateRole(bool? moderateRole) => _$this._moderateRole = moderateRole;

  GTaskTagInputBuilder();

  GTaskTagInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tagId = $v.tagId;
      _viewRole = $v.viewRole;
      _interactRole = $v.interactRole;
      _moderateRole = $v.moderateRole;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GTaskTagInput other) {
    _$v = other as _$GTaskTagInput;
  }

  @override
  void update(void Function(GTaskTagInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GTaskTagInput build() => _build();

  _$GTaskTagInput _build() {
    final _$result = _$v ??
        _$GTaskTagInput._(
          tagId: BuiltValueNullFieldError.checkNotNull(
              tagId, r'GTaskTagInput', 'tagId'),
          viewRole: viewRole,
          interactRole: interactRole,
          moderateRole: moderateRole,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCreateTaskInput extends GCreateTaskInput {
  @override
  final String title;
  @override
  final String? description;
  @override
  final GTime? dueAt;
  @override
  final BuiltList<GTaskTagInput>? tags;
  @override
  final BuiltList<String>? assignees;

  factory _$GCreateTaskInput(
          [void Function(GCreateTaskInputBuilder)? updates]) =>
      (GCreateTaskInputBuilder()..update(updates))._build();

  _$GCreateTaskInput._(
      {required this.title,
      this.description,
      this.dueAt,
      this.tags,
      this.assignees})
      : super._();
  @override
  GCreateTaskInput rebuild(void Function(GCreateTaskInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateTaskInputBuilder toBuilder() =>
      GCreateTaskInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateTaskInput &&
        title == other.title &&
        description == other.description &&
        dueAt == other.dueAt &&
        tags == other.tags &&
        assignees == other.assignees;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, dueAt.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, assignees.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateTaskInput')
          ..add('title', title)
          ..add('description', description)
          ..add('dueAt', dueAt)
          ..add('tags', tags)
          ..add('assignees', assignees))
        .toString();
  }
}

class GCreateTaskInputBuilder
    implements Builder<GCreateTaskInput, GCreateTaskInputBuilder> {
  _$GCreateTaskInput? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  GTimeBuilder? _dueAt;
  GTimeBuilder get dueAt => _$this._dueAt ??= GTimeBuilder();
  set dueAt(GTimeBuilder? dueAt) => _$this._dueAt = dueAt;

  ListBuilder<GTaskTagInput>? _tags;
  ListBuilder<GTaskTagInput> get tags =>
      _$this._tags ??= ListBuilder<GTaskTagInput>();
  set tags(ListBuilder<GTaskTagInput>? tags) => _$this._tags = tags;

  ListBuilder<String>? _assignees;
  ListBuilder<String> get assignees =>
      _$this._assignees ??= ListBuilder<String>();
  set assignees(ListBuilder<String>? assignees) =>
      _$this._assignees = assignees;

  GCreateTaskInputBuilder();

  GCreateTaskInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _description = $v.description;
      _dueAt = $v.dueAt?.toBuilder();
      _tags = $v.tags?.toBuilder();
      _assignees = $v.assignees?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateTaskInput other) {
    _$v = other as _$GCreateTaskInput;
  }

  @override
  void update(void Function(GCreateTaskInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateTaskInput build() => _build();

  _$GCreateTaskInput _build() {
    _$GCreateTaskInput _$result;
    try {
      _$result = _$v ??
          _$GCreateTaskInput._(
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GCreateTaskInput', 'title'),
            description: description,
            dueAt: _dueAt?.build(),
            tags: _tags?.build(),
            assignees: _assignees?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'dueAt';
        _dueAt?.build();
        _$failedField = 'tags';
        _tags?.build();
        _$failedField = 'assignees';
        _assignees?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GCreateTaskInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GEditTaskInput extends GEditTaskInput {
  @override
  final String taskId;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final GTime? dueAt;
  @override
  final bool? clearDueAt;

  factory _$GEditTaskInput([void Function(GEditTaskInputBuilder)? updates]) =>
      (GEditTaskInputBuilder()..update(updates))._build();

  _$GEditTaskInput._(
      {required this.taskId,
      this.title,
      this.description,
      this.dueAt,
      this.clearDueAt})
      : super._();
  @override
  GEditTaskInput rebuild(void Function(GEditTaskInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GEditTaskInputBuilder toBuilder() => GEditTaskInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GEditTaskInput &&
        taskId == other.taskId &&
        title == other.title &&
        description == other.description &&
        dueAt == other.dueAt &&
        clearDueAt == other.clearDueAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, taskId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, dueAt.hashCode);
    _$hash = $jc(_$hash, clearDueAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GEditTaskInput')
          ..add('taskId', taskId)
          ..add('title', title)
          ..add('description', description)
          ..add('dueAt', dueAt)
          ..add('clearDueAt', clearDueAt))
        .toString();
  }
}

class GEditTaskInputBuilder
    implements Builder<GEditTaskInput, GEditTaskInputBuilder> {
  _$GEditTaskInput? _$v;

  String? _taskId;
  String? get taskId => _$this._taskId;
  set taskId(String? taskId) => _$this._taskId = taskId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  GTimeBuilder? _dueAt;
  GTimeBuilder get dueAt => _$this._dueAt ??= GTimeBuilder();
  set dueAt(GTimeBuilder? dueAt) => _$this._dueAt = dueAt;

  bool? _clearDueAt;
  bool? get clearDueAt => _$this._clearDueAt;
  set clearDueAt(bool? clearDueAt) => _$this._clearDueAt = clearDueAt;

  GEditTaskInputBuilder();

  GEditTaskInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _taskId = $v.taskId;
      _title = $v.title;
      _description = $v.description;
      _dueAt = $v.dueAt?.toBuilder();
      _clearDueAt = $v.clearDueAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GEditTaskInput other) {
    _$v = other as _$GEditTaskInput;
  }

  @override
  void update(void Function(GEditTaskInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GEditTaskInput build() => _build();

  _$GEditTaskInput _build() {
    _$GEditTaskInput _$result;
    try {
      _$result = _$v ??
          _$GEditTaskInput._(
            taskId: BuiltValueNullFieldError.checkNotNull(
                taskId, r'GEditTaskInput', 'taskId'),
            title: title,
            description: description,
            dueAt: _dueAt?.build(),
            clearDueAt: clearDueAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'dueAt';
        _dueAt?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GEditTaskInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
