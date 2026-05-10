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

GSearchKind _$gSearchKindValueOf(String name) {
  switch (name) {
    case 'POST':
      return _$gSearchKindPOST;
    case 'COMMENT':
      return _$gSearchKindCOMMENT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GSearchKind> _$gSearchKindValues =
    BuiltSet<GSearchKind>(const <GSearchKind>[
  _$gSearchKindPOST,
  _$gSearchKindCOMMENT,
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
Serializer<GPostSort> _$gPostSortSerializer = _$GPostSortSerializer();
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

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
