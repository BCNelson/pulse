// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts.req.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GPostsForTagReq> _$gPostsForTagReqSerializer =
    _$GPostsForTagReqSerializer();
Serializer<GPostDetailReq> _$gPostDetailReqSerializer =
    _$GPostDetailReqSerializer();
Serializer<GCreatePostReq> _$gCreatePostReqSerializer =
    _$GCreatePostReqSerializer();
Serializer<GCreateCommentReq> _$gCreateCommentReqSerializer =
    _$GCreateCommentReqSerializer();
Serializer<GMarkPostReadReq> _$gMarkPostReadReqSerializer =
    _$GMarkPostReadReqSerializer();
Serializer<GReactToPostReq> _$gReactToPostReqSerializer =
    _$GReactToPostReqSerializer();
Serializer<GUnreactToPostReq> _$gUnreactToPostReqSerializer =
    _$GUnreactToPostReqSerializer();
Serializer<GPostChangedReq> _$gPostChangedReqSerializer =
    _$GPostChangedReqSerializer();
Serializer<GPostSummaryReq> _$gPostSummaryReqSerializer =
    _$GPostSummaryReqSerializer();
Serializer<GCommentSummaryReq> _$gCommentSummaryReqSerializer =
    _$GCommentSummaryReqSerializer();

class _$GPostsForTagReqSerializer
    implements StructuredSerializer<GPostsForTagReq> {
  @override
  final Iterable<Type> types = const [GPostsForTagReq, _$GPostsForTagReq];
  @override
  final String wireName = 'GPostsForTagReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GPostsForTagReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GPostsForTagVars)),
      'operation',
      serializers.serialize(object.operation,
          specifiedType: const FullType(_i4.Operation)),
      'executeOnListen',
      serializers.serialize(object.executeOnListen,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.requestId;
    if (value != null) {
      result
        ..add('requestId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.optimisticResponse;
    if (value != null) {
      result
        ..add('optimisticResponse')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GPostsForTagData)));
    }
    value = object.updateCacheHandlerKey;
    if (value != null) {
      result
        ..add('updateCacheHandlerKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updateCacheHandlerContext;
    if (value != null) {
      result
        ..add('updateCacheHandlerContext')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    value = object.fetchPolicy;
    if (value != null) {
      result
        ..add('fetchPolicy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.FetchPolicy)));
    }
    return result;
  }

  @override
  GPostsForTagReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostsForTagReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GPostsForTagVars))!
              as _i3.GPostsForTagVars);
          break;
        case 'operation':
          result.operation = serializers.deserialize(value,
              specifiedType: const FullType(_i4.Operation))! as _i4.Operation;
          break;
        case 'requestId':
          result.requestId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'optimisticResponse':
          result.optimisticResponse.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GPostsForTagData))!
              as _i2.GPostsForTagData);
          break;
        case 'updateCacheHandlerKey':
          result.updateCacheHandlerKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updateCacheHandlerContext':
          result.updateCacheHandlerContext = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>?;
          break;
        case 'fetchPolicy':
          result.fetchPolicy = serializers.deserialize(value,
                  specifiedType: const FullType(_i1.FetchPolicy))
              as _i1.FetchPolicy?;
          break;
        case 'executeOnListen':
          result.executeOnListen = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GPostDetailReqSerializer
    implements StructuredSerializer<GPostDetailReq> {
  @override
  final Iterable<Type> types = const [GPostDetailReq, _$GPostDetailReq];
  @override
  final String wireName = 'GPostDetailReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GPostDetailReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GPostDetailVars)),
      'operation',
      serializers.serialize(object.operation,
          specifiedType: const FullType(_i4.Operation)),
      'executeOnListen',
      serializers.serialize(object.executeOnListen,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.requestId;
    if (value != null) {
      result
        ..add('requestId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.optimisticResponse;
    if (value != null) {
      result
        ..add('optimisticResponse')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GPostDetailData)));
    }
    value = object.updateCacheHandlerKey;
    if (value != null) {
      result
        ..add('updateCacheHandlerKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updateCacheHandlerContext;
    if (value != null) {
      result
        ..add('updateCacheHandlerContext')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    value = object.fetchPolicy;
    if (value != null) {
      result
        ..add('fetchPolicy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.FetchPolicy)));
    }
    return result;
  }

  @override
  GPostDetailReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostDetailReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GPostDetailVars))!
              as _i3.GPostDetailVars);
          break;
        case 'operation':
          result.operation = serializers.deserialize(value,
              specifiedType: const FullType(_i4.Operation))! as _i4.Operation;
          break;
        case 'requestId':
          result.requestId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'optimisticResponse':
          result.optimisticResponse.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GPostDetailData))!
              as _i2.GPostDetailData);
          break;
        case 'updateCacheHandlerKey':
          result.updateCacheHandlerKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updateCacheHandlerContext':
          result.updateCacheHandlerContext = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>?;
          break;
        case 'fetchPolicy':
          result.fetchPolicy = serializers.deserialize(value,
                  specifiedType: const FullType(_i1.FetchPolicy))
              as _i1.FetchPolicy?;
          break;
        case 'executeOnListen':
          result.executeOnListen = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GCreatePostReqSerializer
    implements StructuredSerializer<GCreatePostReq> {
  @override
  final Iterable<Type> types = const [GCreatePostReq, _$GCreatePostReq];
  @override
  final String wireName = 'GCreatePostReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GCreatePostReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GCreatePostVars)),
      'operation',
      serializers.serialize(object.operation,
          specifiedType: const FullType(_i4.Operation)),
      'executeOnListen',
      serializers.serialize(object.executeOnListen,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.requestId;
    if (value != null) {
      result
        ..add('requestId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.optimisticResponse;
    if (value != null) {
      result
        ..add('optimisticResponse')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GCreatePostData)));
    }
    value = object.updateCacheHandlerKey;
    if (value != null) {
      result
        ..add('updateCacheHandlerKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updateCacheHandlerContext;
    if (value != null) {
      result
        ..add('updateCacheHandlerContext')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    value = object.fetchPolicy;
    if (value != null) {
      result
        ..add('fetchPolicy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.FetchPolicy)));
    }
    return result;
  }

  @override
  GCreatePostReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreatePostReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GCreatePostVars))!
              as _i3.GCreatePostVars);
          break;
        case 'operation':
          result.operation = serializers.deserialize(value,
              specifiedType: const FullType(_i4.Operation))! as _i4.Operation;
          break;
        case 'requestId':
          result.requestId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'optimisticResponse':
          result.optimisticResponse.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GCreatePostData))!
              as _i2.GCreatePostData);
          break;
        case 'updateCacheHandlerKey':
          result.updateCacheHandlerKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updateCacheHandlerContext':
          result.updateCacheHandlerContext = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>?;
          break;
        case 'fetchPolicy':
          result.fetchPolicy = serializers.deserialize(value,
                  specifiedType: const FullType(_i1.FetchPolicy))
              as _i1.FetchPolicy?;
          break;
        case 'executeOnListen':
          result.executeOnListen = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateCommentReqSerializer
    implements StructuredSerializer<GCreateCommentReq> {
  @override
  final Iterable<Type> types = const [GCreateCommentReq, _$GCreateCommentReq];
  @override
  final String wireName = 'GCreateCommentReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GCreateCommentReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GCreateCommentVars)),
      'operation',
      serializers.serialize(object.operation,
          specifiedType: const FullType(_i4.Operation)),
      'executeOnListen',
      serializers.serialize(object.executeOnListen,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.requestId;
    if (value != null) {
      result
        ..add('requestId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.optimisticResponse;
    if (value != null) {
      result
        ..add('optimisticResponse')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GCreateCommentData)));
    }
    value = object.updateCacheHandlerKey;
    if (value != null) {
      result
        ..add('updateCacheHandlerKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updateCacheHandlerContext;
    if (value != null) {
      result
        ..add('updateCacheHandlerContext')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    value = object.fetchPolicy;
    if (value != null) {
      result
        ..add('fetchPolicy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.FetchPolicy)));
    }
    return result;
  }

  @override
  GCreateCommentReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreateCommentReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GCreateCommentVars))!
              as _i3.GCreateCommentVars);
          break;
        case 'operation':
          result.operation = serializers.deserialize(value,
              specifiedType: const FullType(_i4.Operation))! as _i4.Operation;
          break;
        case 'requestId':
          result.requestId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'optimisticResponse':
          result.optimisticResponse.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GCreateCommentData))!
              as _i2.GCreateCommentData);
          break;
        case 'updateCacheHandlerKey':
          result.updateCacheHandlerKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updateCacheHandlerContext':
          result.updateCacheHandlerContext = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>?;
          break;
        case 'fetchPolicy':
          result.fetchPolicy = serializers.deserialize(value,
                  specifiedType: const FullType(_i1.FetchPolicy))
              as _i1.FetchPolicy?;
          break;
        case 'executeOnListen':
          result.executeOnListen = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GMarkPostReadReqSerializer
    implements StructuredSerializer<GMarkPostReadReq> {
  @override
  final Iterable<Type> types = const [GMarkPostReadReq, _$GMarkPostReadReq];
  @override
  final String wireName = 'GMarkPostReadReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GMarkPostReadReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GMarkPostReadVars)),
      'operation',
      serializers.serialize(object.operation,
          specifiedType: const FullType(_i4.Operation)),
      'executeOnListen',
      serializers.serialize(object.executeOnListen,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.requestId;
    if (value != null) {
      result
        ..add('requestId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.optimisticResponse;
    if (value != null) {
      result
        ..add('optimisticResponse')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GMarkPostReadData)));
    }
    value = object.updateCacheHandlerKey;
    if (value != null) {
      result
        ..add('updateCacheHandlerKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updateCacheHandlerContext;
    if (value != null) {
      result
        ..add('updateCacheHandlerContext')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    value = object.fetchPolicy;
    if (value != null) {
      result
        ..add('fetchPolicy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.FetchPolicy)));
    }
    return result;
  }

  @override
  GMarkPostReadReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMarkPostReadReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GMarkPostReadVars))!
              as _i3.GMarkPostReadVars);
          break;
        case 'operation':
          result.operation = serializers.deserialize(value,
              specifiedType: const FullType(_i4.Operation))! as _i4.Operation;
          break;
        case 'requestId':
          result.requestId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'optimisticResponse':
          result.optimisticResponse.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GMarkPostReadData))!
              as _i2.GMarkPostReadData);
          break;
        case 'updateCacheHandlerKey':
          result.updateCacheHandlerKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updateCacheHandlerContext':
          result.updateCacheHandlerContext = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>?;
          break;
        case 'fetchPolicy':
          result.fetchPolicy = serializers.deserialize(value,
                  specifiedType: const FullType(_i1.FetchPolicy))
              as _i1.FetchPolicy?;
          break;
        case 'executeOnListen':
          result.executeOnListen = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GReactToPostReqSerializer
    implements StructuredSerializer<GReactToPostReq> {
  @override
  final Iterable<Type> types = const [GReactToPostReq, _$GReactToPostReq];
  @override
  final String wireName = 'GReactToPostReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GReactToPostReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GReactToPostVars)),
      'operation',
      serializers.serialize(object.operation,
          specifiedType: const FullType(_i4.Operation)),
      'executeOnListen',
      serializers.serialize(object.executeOnListen,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.requestId;
    if (value != null) {
      result
        ..add('requestId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.optimisticResponse;
    if (value != null) {
      result
        ..add('optimisticResponse')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GReactToPostData)));
    }
    value = object.updateCacheHandlerKey;
    if (value != null) {
      result
        ..add('updateCacheHandlerKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updateCacheHandlerContext;
    if (value != null) {
      result
        ..add('updateCacheHandlerContext')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    value = object.fetchPolicy;
    if (value != null) {
      result
        ..add('fetchPolicy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.FetchPolicy)));
    }
    return result;
  }

  @override
  GReactToPostReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GReactToPostReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GReactToPostVars))!
              as _i3.GReactToPostVars);
          break;
        case 'operation':
          result.operation = serializers.deserialize(value,
              specifiedType: const FullType(_i4.Operation))! as _i4.Operation;
          break;
        case 'requestId':
          result.requestId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'optimisticResponse':
          result.optimisticResponse.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GReactToPostData))!
              as _i2.GReactToPostData);
          break;
        case 'updateCacheHandlerKey':
          result.updateCacheHandlerKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updateCacheHandlerContext':
          result.updateCacheHandlerContext = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>?;
          break;
        case 'fetchPolicy':
          result.fetchPolicy = serializers.deserialize(value,
                  specifiedType: const FullType(_i1.FetchPolicy))
              as _i1.FetchPolicy?;
          break;
        case 'executeOnListen':
          result.executeOnListen = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GUnreactToPostReqSerializer
    implements StructuredSerializer<GUnreactToPostReq> {
  @override
  final Iterable<Type> types = const [GUnreactToPostReq, _$GUnreactToPostReq];
  @override
  final String wireName = 'GUnreactToPostReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GUnreactToPostReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GUnreactToPostVars)),
      'operation',
      serializers.serialize(object.operation,
          specifiedType: const FullType(_i4.Operation)),
      'executeOnListen',
      serializers.serialize(object.executeOnListen,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.requestId;
    if (value != null) {
      result
        ..add('requestId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.optimisticResponse;
    if (value != null) {
      result
        ..add('optimisticResponse')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GUnreactToPostData)));
    }
    value = object.updateCacheHandlerKey;
    if (value != null) {
      result
        ..add('updateCacheHandlerKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updateCacheHandlerContext;
    if (value != null) {
      result
        ..add('updateCacheHandlerContext')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    value = object.fetchPolicy;
    if (value != null) {
      result
        ..add('fetchPolicy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.FetchPolicy)));
    }
    return result;
  }

  @override
  GUnreactToPostReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUnreactToPostReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GUnreactToPostVars))!
              as _i3.GUnreactToPostVars);
          break;
        case 'operation':
          result.operation = serializers.deserialize(value,
              specifiedType: const FullType(_i4.Operation))! as _i4.Operation;
          break;
        case 'requestId':
          result.requestId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'optimisticResponse':
          result.optimisticResponse.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GUnreactToPostData))!
              as _i2.GUnreactToPostData);
          break;
        case 'updateCacheHandlerKey':
          result.updateCacheHandlerKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updateCacheHandlerContext':
          result.updateCacheHandlerContext = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>?;
          break;
        case 'fetchPolicy':
          result.fetchPolicy = serializers.deserialize(value,
                  specifiedType: const FullType(_i1.FetchPolicy))
              as _i1.FetchPolicy?;
          break;
        case 'executeOnListen':
          result.executeOnListen = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GPostChangedReqSerializer
    implements StructuredSerializer<GPostChangedReq> {
  @override
  final Iterable<Type> types = const [GPostChangedReq, _$GPostChangedReq];
  @override
  final String wireName = 'GPostChangedReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GPostChangedReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GPostChangedVars)),
      'operation',
      serializers.serialize(object.operation,
          specifiedType: const FullType(_i4.Operation)),
      'executeOnListen',
      serializers.serialize(object.executeOnListen,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.requestId;
    if (value != null) {
      result
        ..add('requestId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.optimisticResponse;
    if (value != null) {
      result
        ..add('optimisticResponse')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GPostChangedData)));
    }
    value = object.updateCacheHandlerKey;
    if (value != null) {
      result
        ..add('updateCacheHandlerKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updateCacheHandlerContext;
    if (value != null) {
      result
        ..add('updateCacheHandlerContext')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    value = object.fetchPolicy;
    if (value != null) {
      result
        ..add('fetchPolicy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.FetchPolicy)));
    }
    return result;
  }

  @override
  GPostChangedReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostChangedReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GPostChangedVars))!
              as _i3.GPostChangedVars);
          break;
        case 'operation':
          result.operation = serializers.deserialize(value,
              specifiedType: const FullType(_i4.Operation))! as _i4.Operation;
          break;
        case 'requestId':
          result.requestId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'optimisticResponse':
          result.optimisticResponse.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GPostChangedData))!
              as _i2.GPostChangedData);
          break;
        case 'updateCacheHandlerKey':
          result.updateCacheHandlerKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updateCacheHandlerContext':
          result.updateCacheHandlerContext = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>?;
          break;
        case 'fetchPolicy':
          result.fetchPolicy = serializers.deserialize(value,
                  specifiedType: const FullType(_i1.FetchPolicy))
              as _i1.FetchPolicy?;
          break;
        case 'executeOnListen':
          result.executeOnListen = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GPostSummaryReqSerializer
    implements StructuredSerializer<GPostSummaryReq> {
  @override
  final Iterable<Type> types = const [GPostSummaryReq, _$GPostSummaryReq];
  @override
  final String wireName = 'GPostSummaryReq';

  @override
  Iterable<Object?> serialize(Serializers serializers, GPostSummaryReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GPostSummaryVars)),
      'document',
      serializers.serialize(object.document,
          specifiedType: const FullType(_i7.DocumentNode)),
      'idFields',
      serializers.serialize(object.idFields,
          specifiedType: const FullType(
              Map, const [const FullType(String), const FullType(dynamic)])),
    ];
    Object? value;
    value = object.fragmentName;
    if (value != null) {
      result
        ..add('fragmentName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GPostSummaryReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostSummaryReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GPostSummaryVars))!
              as _i3.GPostSummaryVars);
          break;
        case 'document':
          result.document = serializers.deserialize(value,
                  specifiedType: const FullType(_i7.DocumentNode))!
              as _i7.DocumentNode;
          break;
        case 'fragmentName':
          result.fragmentName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'idFields':
          result.idFields = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ]))! as Map<String, dynamic>;
          break;
      }
    }

    return result.build();
  }
}

class _$GCommentSummaryReqSerializer
    implements StructuredSerializer<GCommentSummaryReq> {
  @override
  final Iterable<Type> types = const [GCommentSummaryReq, _$GCommentSummaryReq];
  @override
  final String wireName = 'GCommentSummaryReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCommentSummaryReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GCommentSummaryVars)),
      'document',
      serializers.serialize(object.document,
          specifiedType: const FullType(_i7.DocumentNode)),
      'idFields',
      serializers.serialize(object.idFields,
          specifiedType: const FullType(
              Map, const [const FullType(String), const FullType(dynamic)])),
    ];
    Object? value;
    value = object.fragmentName;
    if (value != null) {
      result
        ..add('fragmentName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GCommentSummaryReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCommentSummaryReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GCommentSummaryVars))!
              as _i3.GCommentSummaryVars);
          break;
        case 'document':
          result.document = serializers.deserialize(value,
                  specifiedType: const FullType(_i7.DocumentNode))!
              as _i7.DocumentNode;
          break;
        case 'fragmentName':
          result.fragmentName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'idFields':
          result.idFields = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ]))! as Map<String, dynamic>;
          break;
      }
    }

    return result.build();
  }
}

class _$GPostsForTagReq extends GPostsForTagReq {
  @override
  final _i3.GPostsForTagVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GPostsForTagData? Function(
      _i2.GPostsForTagData?, _i2.GPostsForTagData?)? updateResult;
  @override
  final _i2.GPostsForTagData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;
  @override
  final _i4.Context? context;

  factory _$GPostsForTagReq([void Function(GPostsForTagReqBuilder)? updates]) =>
      (GPostsForTagReqBuilder()..update(updates))._build();

  _$GPostsForTagReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen,
      this.context})
      : super._();
  @override
  GPostsForTagReq rebuild(void Function(GPostsForTagReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostsForTagReqBuilder toBuilder() => GPostsForTagReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostsForTagReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == other.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen &&
        context == other.context;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, requestId.hashCode);
    _$hash = $jc(_$hash, updateResult.hashCode);
    _$hash = $jc(_$hash, optimisticResponse.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerKey.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerContext.hashCode);
    _$hash = $jc(_$hash, fetchPolicy.hashCode);
    _$hash = $jc(_$hash, executeOnListen.hashCode);
    _$hash = $jc(_$hash, context.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostsForTagReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen)
          ..add('context', context))
        .toString();
  }
}

class GPostsForTagReqBuilder
    implements Builder<GPostsForTagReq, GPostsForTagReqBuilder> {
  _$GPostsForTagReq? _$v;

  _i3.GPostsForTagVarsBuilder? _vars;
  _i3.GPostsForTagVarsBuilder get vars =>
      _$this._vars ??= _i3.GPostsForTagVarsBuilder();
  set vars(_i3.GPostsForTagVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GPostsForTagData? Function(_i2.GPostsForTagData?, _i2.GPostsForTagData?)?
      _updateResult;
  _i2.GPostsForTagData? Function(_i2.GPostsForTagData?, _i2.GPostsForTagData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GPostsForTagData? Function(
                  _i2.GPostsForTagData?, _i2.GPostsForTagData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GPostsForTagDataBuilder? _optimisticResponse;
  _i2.GPostsForTagDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= _i2.GPostsForTagDataBuilder();
  set optimisticResponse(_i2.GPostsForTagDataBuilder? optimisticResponse) =>
      _$this._optimisticResponse = optimisticResponse;

  String? _updateCacheHandlerKey;
  String? get updateCacheHandlerKey => _$this._updateCacheHandlerKey;
  set updateCacheHandlerKey(String? updateCacheHandlerKey) =>
      _$this._updateCacheHandlerKey = updateCacheHandlerKey;

  Map<String, dynamic>? _updateCacheHandlerContext;
  Map<String, dynamic>? get updateCacheHandlerContext =>
      _$this._updateCacheHandlerContext;
  set updateCacheHandlerContext(
          Map<String, dynamic>? updateCacheHandlerContext) =>
      _$this._updateCacheHandlerContext = updateCacheHandlerContext;

  _i1.FetchPolicy? _fetchPolicy;
  _i1.FetchPolicy? get fetchPolicy => _$this._fetchPolicy;
  set fetchPolicy(_i1.FetchPolicy? fetchPolicy) =>
      _$this._fetchPolicy = fetchPolicy;

  bool? _executeOnListen;
  bool? get executeOnListen => _$this._executeOnListen;
  set executeOnListen(bool? executeOnListen) =>
      _$this._executeOnListen = executeOnListen;

  _i4.Context? _context;
  _i4.Context? get context => _$this._context;
  set context(_i4.Context? context) => _$this._context = context;

  GPostsForTagReqBuilder() {
    GPostsForTagReq._initializeBuilder(this);
  }

  GPostsForTagReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _operation = $v.operation;
      _requestId = $v.requestId;
      _updateResult = $v.updateResult;
      _optimisticResponse = $v.optimisticResponse?.toBuilder();
      _updateCacheHandlerKey = $v.updateCacheHandlerKey;
      _updateCacheHandlerContext = $v.updateCacheHandlerContext;
      _fetchPolicy = $v.fetchPolicy;
      _executeOnListen = $v.executeOnListen;
      _context = $v.context;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostsForTagReq other) {
    _$v = other as _$GPostsForTagReq;
  }

  @override
  void update(void Function(GPostsForTagReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostsForTagReq build() => _build();

  _$GPostsForTagReq _build() {
    _$GPostsForTagReq _$result;
    try {
      _$result = _$v ??
          _$GPostsForTagReq._(
            vars: vars.build(),
            operation: BuiltValueNullFieldError.checkNotNull(
                operation, r'GPostsForTagReq', 'operation'),
            requestId: requestId,
            updateResult: updateResult,
            optimisticResponse: _optimisticResponse?.build(),
            updateCacheHandlerKey: updateCacheHandlerKey,
            updateCacheHandlerContext: updateCacheHandlerContext,
            fetchPolicy: fetchPolicy,
            executeOnListen: BuiltValueNullFieldError.checkNotNull(
                executeOnListen, r'GPostsForTagReq', 'executeOnListen'),
            context: context,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GPostsForTagReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GPostDetailReq extends GPostDetailReq {
  @override
  final _i3.GPostDetailVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GPostDetailData? Function(
      _i2.GPostDetailData?, _i2.GPostDetailData?)? updateResult;
  @override
  final _i2.GPostDetailData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;
  @override
  final _i4.Context? context;

  factory _$GPostDetailReq([void Function(GPostDetailReqBuilder)? updates]) =>
      (GPostDetailReqBuilder()..update(updates))._build();

  _$GPostDetailReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen,
      this.context})
      : super._();
  @override
  GPostDetailReq rebuild(void Function(GPostDetailReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostDetailReqBuilder toBuilder() => GPostDetailReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostDetailReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == other.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen &&
        context == other.context;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, requestId.hashCode);
    _$hash = $jc(_$hash, updateResult.hashCode);
    _$hash = $jc(_$hash, optimisticResponse.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerKey.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerContext.hashCode);
    _$hash = $jc(_$hash, fetchPolicy.hashCode);
    _$hash = $jc(_$hash, executeOnListen.hashCode);
    _$hash = $jc(_$hash, context.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostDetailReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen)
          ..add('context', context))
        .toString();
  }
}

class GPostDetailReqBuilder
    implements Builder<GPostDetailReq, GPostDetailReqBuilder> {
  _$GPostDetailReq? _$v;

  _i3.GPostDetailVarsBuilder? _vars;
  _i3.GPostDetailVarsBuilder get vars =>
      _$this._vars ??= _i3.GPostDetailVarsBuilder();
  set vars(_i3.GPostDetailVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GPostDetailData? Function(_i2.GPostDetailData?, _i2.GPostDetailData?)?
      _updateResult;
  _i2.GPostDetailData? Function(_i2.GPostDetailData?, _i2.GPostDetailData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GPostDetailData? Function(
                  _i2.GPostDetailData?, _i2.GPostDetailData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GPostDetailDataBuilder? _optimisticResponse;
  _i2.GPostDetailDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= _i2.GPostDetailDataBuilder();
  set optimisticResponse(_i2.GPostDetailDataBuilder? optimisticResponse) =>
      _$this._optimisticResponse = optimisticResponse;

  String? _updateCacheHandlerKey;
  String? get updateCacheHandlerKey => _$this._updateCacheHandlerKey;
  set updateCacheHandlerKey(String? updateCacheHandlerKey) =>
      _$this._updateCacheHandlerKey = updateCacheHandlerKey;

  Map<String, dynamic>? _updateCacheHandlerContext;
  Map<String, dynamic>? get updateCacheHandlerContext =>
      _$this._updateCacheHandlerContext;
  set updateCacheHandlerContext(
          Map<String, dynamic>? updateCacheHandlerContext) =>
      _$this._updateCacheHandlerContext = updateCacheHandlerContext;

  _i1.FetchPolicy? _fetchPolicy;
  _i1.FetchPolicy? get fetchPolicy => _$this._fetchPolicy;
  set fetchPolicy(_i1.FetchPolicy? fetchPolicy) =>
      _$this._fetchPolicy = fetchPolicy;

  bool? _executeOnListen;
  bool? get executeOnListen => _$this._executeOnListen;
  set executeOnListen(bool? executeOnListen) =>
      _$this._executeOnListen = executeOnListen;

  _i4.Context? _context;
  _i4.Context? get context => _$this._context;
  set context(_i4.Context? context) => _$this._context = context;

  GPostDetailReqBuilder() {
    GPostDetailReq._initializeBuilder(this);
  }

  GPostDetailReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _operation = $v.operation;
      _requestId = $v.requestId;
      _updateResult = $v.updateResult;
      _optimisticResponse = $v.optimisticResponse?.toBuilder();
      _updateCacheHandlerKey = $v.updateCacheHandlerKey;
      _updateCacheHandlerContext = $v.updateCacheHandlerContext;
      _fetchPolicy = $v.fetchPolicy;
      _executeOnListen = $v.executeOnListen;
      _context = $v.context;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostDetailReq other) {
    _$v = other as _$GPostDetailReq;
  }

  @override
  void update(void Function(GPostDetailReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostDetailReq build() => _build();

  _$GPostDetailReq _build() {
    _$GPostDetailReq _$result;
    try {
      _$result = _$v ??
          _$GPostDetailReq._(
            vars: vars.build(),
            operation: BuiltValueNullFieldError.checkNotNull(
                operation, r'GPostDetailReq', 'operation'),
            requestId: requestId,
            updateResult: updateResult,
            optimisticResponse: _optimisticResponse?.build(),
            updateCacheHandlerKey: updateCacheHandlerKey,
            updateCacheHandlerContext: updateCacheHandlerContext,
            fetchPolicy: fetchPolicy,
            executeOnListen: BuiltValueNullFieldError.checkNotNull(
                executeOnListen, r'GPostDetailReq', 'executeOnListen'),
            context: context,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GPostDetailReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreatePostReq extends GCreatePostReq {
  @override
  final _i3.GCreatePostVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GCreatePostData? Function(
      _i2.GCreatePostData?, _i2.GCreatePostData?)? updateResult;
  @override
  final _i2.GCreatePostData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;
  @override
  final _i4.Context? context;

  factory _$GCreatePostReq([void Function(GCreatePostReqBuilder)? updates]) =>
      (GCreatePostReqBuilder()..update(updates))._build();

  _$GCreatePostReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen,
      this.context})
      : super._();
  @override
  GCreatePostReq rebuild(void Function(GCreatePostReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreatePostReqBuilder toBuilder() => GCreatePostReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreatePostReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == other.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen &&
        context == other.context;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, requestId.hashCode);
    _$hash = $jc(_$hash, updateResult.hashCode);
    _$hash = $jc(_$hash, optimisticResponse.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerKey.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerContext.hashCode);
    _$hash = $jc(_$hash, fetchPolicy.hashCode);
    _$hash = $jc(_$hash, executeOnListen.hashCode);
    _$hash = $jc(_$hash, context.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreatePostReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen)
          ..add('context', context))
        .toString();
  }
}

class GCreatePostReqBuilder
    implements Builder<GCreatePostReq, GCreatePostReqBuilder> {
  _$GCreatePostReq? _$v;

  _i3.GCreatePostVarsBuilder? _vars;
  _i3.GCreatePostVarsBuilder get vars =>
      _$this._vars ??= _i3.GCreatePostVarsBuilder();
  set vars(_i3.GCreatePostVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GCreatePostData? Function(_i2.GCreatePostData?, _i2.GCreatePostData?)?
      _updateResult;
  _i2.GCreatePostData? Function(_i2.GCreatePostData?, _i2.GCreatePostData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GCreatePostData? Function(
                  _i2.GCreatePostData?, _i2.GCreatePostData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GCreatePostDataBuilder? _optimisticResponse;
  _i2.GCreatePostDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= _i2.GCreatePostDataBuilder();
  set optimisticResponse(_i2.GCreatePostDataBuilder? optimisticResponse) =>
      _$this._optimisticResponse = optimisticResponse;

  String? _updateCacheHandlerKey;
  String? get updateCacheHandlerKey => _$this._updateCacheHandlerKey;
  set updateCacheHandlerKey(String? updateCacheHandlerKey) =>
      _$this._updateCacheHandlerKey = updateCacheHandlerKey;

  Map<String, dynamic>? _updateCacheHandlerContext;
  Map<String, dynamic>? get updateCacheHandlerContext =>
      _$this._updateCacheHandlerContext;
  set updateCacheHandlerContext(
          Map<String, dynamic>? updateCacheHandlerContext) =>
      _$this._updateCacheHandlerContext = updateCacheHandlerContext;

  _i1.FetchPolicy? _fetchPolicy;
  _i1.FetchPolicy? get fetchPolicy => _$this._fetchPolicy;
  set fetchPolicy(_i1.FetchPolicy? fetchPolicy) =>
      _$this._fetchPolicy = fetchPolicy;

  bool? _executeOnListen;
  bool? get executeOnListen => _$this._executeOnListen;
  set executeOnListen(bool? executeOnListen) =>
      _$this._executeOnListen = executeOnListen;

  _i4.Context? _context;
  _i4.Context? get context => _$this._context;
  set context(_i4.Context? context) => _$this._context = context;

  GCreatePostReqBuilder() {
    GCreatePostReq._initializeBuilder(this);
  }

  GCreatePostReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _operation = $v.operation;
      _requestId = $v.requestId;
      _updateResult = $v.updateResult;
      _optimisticResponse = $v.optimisticResponse?.toBuilder();
      _updateCacheHandlerKey = $v.updateCacheHandlerKey;
      _updateCacheHandlerContext = $v.updateCacheHandlerContext;
      _fetchPolicy = $v.fetchPolicy;
      _executeOnListen = $v.executeOnListen;
      _context = $v.context;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreatePostReq other) {
    _$v = other as _$GCreatePostReq;
  }

  @override
  void update(void Function(GCreatePostReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreatePostReq build() => _build();

  _$GCreatePostReq _build() {
    _$GCreatePostReq _$result;
    try {
      _$result = _$v ??
          _$GCreatePostReq._(
            vars: vars.build(),
            operation: BuiltValueNullFieldError.checkNotNull(
                operation, r'GCreatePostReq', 'operation'),
            requestId: requestId,
            updateResult: updateResult,
            optimisticResponse: _optimisticResponse?.build(),
            updateCacheHandlerKey: updateCacheHandlerKey,
            updateCacheHandlerContext: updateCacheHandlerContext,
            fetchPolicy: fetchPolicy,
            executeOnListen: BuiltValueNullFieldError.checkNotNull(
                executeOnListen, r'GCreatePostReq', 'executeOnListen'),
            context: context,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GCreatePostReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateCommentReq extends GCreateCommentReq {
  @override
  final _i3.GCreateCommentVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GCreateCommentData? Function(
      _i2.GCreateCommentData?, _i2.GCreateCommentData?)? updateResult;
  @override
  final _i2.GCreateCommentData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;
  @override
  final _i4.Context? context;

  factory _$GCreateCommentReq(
          [void Function(GCreateCommentReqBuilder)? updates]) =>
      (GCreateCommentReqBuilder()..update(updates))._build();

  _$GCreateCommentReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen,
      this.context})
      : super._();
  @override
  GCreateCommentReq rebuild(void Function(GCreateCommentReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateCommentReqBuilder toBuilder() =>
      GCreateCommentReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateCommentReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == other.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen &&
        context == other.context;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, requestId.hashCode);
    _$hash = $jc(_$hash, updateResult.hashCode);
    _$hash = $jc(_$hash, optimisticResponse.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerKey.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerContext.hashCode);
    _$hash = $jc(_$hash, fetchPolicy.hashCode);
    _$hash = $jc(_$hash, executeOnListen.hashCode);
    _$hash = $jc(_$hash, context.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateCommentReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen)
          ..add('context', context))
        .toString();
  }
}

class GCreateCommentReqBuilder
    implements Builder<GCreateCommentReq, GCreateCommentReqBuilder> {
  _$GCreateCommentReq? _$v;

  _i3.GCreateCommentVarsBuilder? _vars;
  _i3.GCreateCommentVarsBuilder get vars =>
      _$this._vars ??= _i3.GCreateCommentVarsBuilder();
  set vars(_i3.GCreateCommentVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GCreateCommentData? Function(
      _i2.GCreateCommentData?, _i2.GCreateCommentData?)? _updateResult;
  _i2.GCreateCommentData? Function(
          _i2.GCreateCommentData?, _i2.GCreateCommentData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GCreateCommentData? Function(
                  _i2.GCreateCommentData?, _i2.GCreateCommentData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GCreateCommentDataBuilder? _optimisticResponse;
  _i2.GCreateCommentDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= _i2.GCreateCommentDataBuilder();
  set optimisticResponse(_i2.GCreateCommentDataBuilder? optimisticResponse) =>
      _$this._optimisticResponse = optimisticResponse;

  String? _updateCacheHandlerKey;
  String? get updateCacheHandlerKey => _$this._updateCacheHandlerKey;
  set updateCacheHandlerKey(String? updateCacheHandlerKey) =>
      _$this._updateCacheHandlerKey = updateCacheHandlerKey;

  Map<String, dynamic>? _updateCacheHandlerContext;
  Map<String, dynamic>? get updateCacheHandlerContext =>
      _$this._updateCacheHandlerContext;
  set updateCacheHandlerContext(
          Map<String, dynamic>? updateCacheHandlerContext) =>
      _$this._updateCacheHandlerContext = updateCacheHandlerContext;

  _i1.FetchPolicy? _fetchPolicy;
  _i1.FetchPolicy? get fetchPolicy => _$this._fetchPolicy;
  set fetchPolicy(_i1.FetchPolicy? fetchPolicy) =>
      _$this._fetchPolicy = fetchPolicy;

  bool? _executeOnListen;
  bool? get executeOnListen => _$this._executeOnListen;
  set executeOnListen(bool? executeOnListen) =>
      _$this._executeOnListen = executeOnListen;

  _i4.Context? _context;
  _i4.Context? get context => _$this._context;
  set context(_i4.Context? context) => _$this._context = context;

  GCreateCommentReqBuilder() {
    GCreateCommentReq._initializeBuilder(this);
  }

  GCreateCommentReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _operation = $v.operation;
      _requestId = $v.requestId;
      _updateResult = $v.updateResult;
      _optimisticResponse = $v.optimisticResponse?.toBuilder();
      _updateCacheHandlerKey = $v.updateCacheHandlerKey;
      _updateCacheHandlerContext = $v.updateCacheHandlerContext;
      _fetchPolicy = $v.fetchPolicy;
      _executeOnListen = $v.executeOnListen;
      _context = $v.context;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateCommentReq other) {
    _$v = other as _$GCreateCommentReq;
  }

  @override
  void update(void Function(GCreateCommentReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateCommentReq build() => _build();

  _$GCreateCommentReq _build() {
    _$GCreateCommentReq _$result;
    try {
      _$result = _$v ??
          _$GCreateCommentReq._(
            vars: vars.build(),
            operation: BuiltValueNullFieldError.checkNotNull(
                operation, r'GCreateCommentReq', 'operation'),
            requestId: requestId,
            updateResult: updateResult,
            optimisticResponse: _optimisticResponse?.build(),
            updateCacheHandlerKey: updateCacheHandlerKey,
            updateCacheHandlerContext: updateCacheHandlerContext,
            fetchPolicy: fetchPolicy,
            executeOnListen: BuiltValueNullFieldError.checkNotNull(
                executeOnListen, r'GCreateCommentReq', 'executeOnListen'),
            context: context,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GCreateCommentReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMarkPostReadReq extends GMarkPostReadReq {
  @override
  final _i3.GMarkPostReadVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GMarkPostReadData? Function(
      _i2.GMarkPostReadData?, _i2.GMarkPostReadData?)? updateResult;
  @override
  final _i2.GMarkPostReadData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;
  @override
  final _i4.Context? context;

  factory _$GMarkPostReadReq(
          [void Function(GMarkPostReadReqBuilder)? updates]) =>
      (GMarkPostReadReqBuilder()..update(updates))._build();

  _$GMarkPostReadReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen,
      this.context})
      : super._();
  @override
  GMarkPostReadReq rebuild(void Function(GMarkPostReadReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMarkPostReadReqBuilder toBuilder() =>
      GMarkPostReadReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkPostReadReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == other.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen &&
        context == other.context;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, requestId.hashCode);
    _$hash = $jc(_$hash, updateResult.hashCode);
    _$hash = $jc(_$hash, optimisticResponse.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerKey.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerContext.hashCode);
    _$hash = $jc(_$hash, fetchPolicy.hashCode);
    _$hash = $jc(_$hash, executeOnListen.hashCode);
    _$hash = $jc(_$hash, context.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMarkPostReadReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen)
          ..add('context', context))
        .toString();
  }
}

class GMarkPostReadReqBuilder
    implements Builder<GMarkPostReadReq, GMarkPostReadReqBuilder> {
  _$GMarkPostReadReq? _$v;

  _i3.GMarkPostReadVarsBuilder? _vars;
  _i3.GMarkPostReadVarsBuilder get vars =>
      _$this._vars ??= _i3.GMarkPostReadVarsBuilder();
  set vars(_i3.GMarkPostReadVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GMarkPostReadData? Function(
      _i2.GMarkPostReadData?, _i2.GMarkPostReadData?)? _updateResult;
  _i2.GMarkPostReadData? Function(
          _i2.GMarkPostReadData?, _i2.GMarkPostReadData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GMarkPostReadData? Function(
                  _i2.GMarkPostReadData?, _i2.GMarkPostReadData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GMarkPostReadDataBuilder? _optimisticResponse;
  _i2.GMarkPostReadDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= _i2.GMarkPostReadDataBuilder();
  set optimisticResponse(_i2.GMarkPostReadDataBuilder? optimisticResponse) =>
      _$this._optimisticResponse = optimisticResponse;

  String? _updateCacheHandlerKey;
  String? get updateCacheHandlerKey => _$this._updateCacheHandlerKey;
  set updateCacheHandlerKey(String? updateCacheHandlerKey) =>
      _$this._updateCacheHandlerKey = updateCacheHandlerKey;

  Map<String, dynamic>? _updateCacheHandlerContext;
  Map<String, dynamic>? get updateCacheHandlerContext =>
      _$this._updateCacheHandlerContext;
  set updateCacheHandlerContext(
          Map<String, dynamic>? updateCacheHandlerContext) =>
      _$this._updateCacheHandlerContext = updateCacheHandlerContext;

  _i1.FetchPolicy? _fetchPolicy;
  _i1.FetchPolicy? get fetchPolicy => _$this._fetchPolicy;
  set fetchPolicy(_i1.FetchPolicy? fetchPolicy) =>
      _$this._fetchPolicy = fetchPolicy;

  bool? _executeOnListen;
  bool? get executeOnListen => _$this._executeOnListen;
  set executeOnListen(bool? executeOnListen) =>
      _$this._executeOnListen = executeOnListen;

  _i4.Context? _context;
  _i4.Context? get context => _$this._context;
  set context(_i4.Context? context) => _$this._context = context;

  GMarkPostReadReqBuilder() {
    GMarkPostReadReq._initializeBuilder(this);
  }

  GMarkPostReadReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _operation = $v.operation;
      _requestId = $v.requestId;
      _updateResult = $v.updateResult;
      _optimisticResponse = $v.optimisticResponse?.toBuilder();
      _updateCacheHandlerKey = $v.updateCacheHandlerKey;
      _updateCacheHandlerContext = $v.updateCacheHandlerContext;
      _fetchPolicy = $v.fetchPolicy;
      _executeOnListen = $v.executeOnListen;
      _context = $v.context;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMarkPostReadReq other) {
    _$v = other as _$GMarkPostReadReq;
  }

  @override
  void update(void Function(GMarkPostReadReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMarkPostReadReq build() => _build();

  _$GMarkPostReadReq _build() {
    _$GMarkPostReadReq _$result;
    try {
      _$result = _$v ??
          _$GMarkPostReadReq._(
            vars: vars.build(),
            operation: BuiltValueNullFieldError.checkNotNull(
                operation, r'GMarkPostReadReq', 'operation'),
            requestId: requestId,
            updateResult: updateResult,
            optimisticResponse: _optimisticResponse?.build(),
            updateCacheHandlerKey: updateCacheHandlerKey,
            updateCacheHandlerContext: updateCacheHandlerContext,
            fetchPolicy: fetchPolicy,
            executeOnListen: BuiltValueNullFieldError.checkNotNull(
                executeOnListen, r'GMarkPostReadReq', 'executeOnListen'),
            context: context,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMarkPostReadReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GReactToPostReq extends GReactToPostReq {
  @override
  final _i3.GReactToPostVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GReactToPostData? Function(
      _i2.GReactToPostData?, _i2.GReactToPostData?)? updateResult;
  @override
  final _i2.GReactToPostData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;
  @override
  final _i4.Context? context;

  factory _$GReactToPostReq([void Function(GReactToPostReqBuilder)? updates]) =>
      (GReactToPostReqBuilder()..update(updates))._build();

  _$GReactToPostReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen,
      this.context})
      : super._();
  @override
  GReactToPostReq rebuild(void Function(GReactToPostReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GReactToPostReqBuilder toBuilder() => GReactToPostReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReactToPostReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == other.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen &&
        context == other.context;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, requestId.hashCode);
    _$hash = $jc(_$hash, updateResult.hashCode);
    _$hash = $jc(_$hash, optimisticResponse.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerKey.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerContext.hashCode);
    _$hash = $jc(_$hash, fetchPolicy.hashCode);
    _$hash = $jc(_$hash, executeOnListen.hashCode);
    _$hash = $jc(_$hash, context.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GReactToPostReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen)
          ..add('context', context))
        .toString();
  }
}

class GReactToPostReqBuilder
    implements Builder<GReactToPostReq, GReactToPostReqBuilder> {
  _$GReactToPostReq? _$v;

  _i3.GReactToPostVarsBuilder? _vars;
  _i3.GReactToPostVarsBuilder get vars =>
      _$this._vars ??= _i3.GReactToPostVarsBuilder();
  set vars(_i3.GReactToPostVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GReactToPostData? Function(_i2.GReactToPostData?, _i2.GReactToPostData?)?
      _updateResult;
  _i2.GReactToPostData? Function(_i2.GReactToPostData?, _i2.GReactToPostData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GReactToPostData? Function(
                  _i2.GReactToPostData?, _i2.GReactToPostData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GReactToPostDataBuilder? _optimisticResponse;
  _i2.GReactToPostDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= _i2.GReactToPostDataBuilder();
  set optimisticResponse(_i2.GReactToPostDataBuilder? optimisticResponse) =>
      _$this._optimisticResponse = optimisticResponse;

  String? _updateCacheHandlerKey;
  String? get updateCacheHandlerKey => _$this._updateCacheHandlerKey;
  set updateCacheHandlerKey(String? updateCacheHandlerKey) =>
      _$this._updateCacheHandlerKey = updateCacheHandlerKey;

  Map<String, dynamic>? _updateCacheHandlerContext;
  Map<String, dynamic>? get updateCacheHandlerContext =>
      _$this._updateCacheHandlerContext;
  set updateCacheHandlerContext(
          Map<String, dynamic>? updateCacheHandlerContext) =>
      _$this._updateCacheHandlerContext = updateCacheHandlerContext;

  _i1.FetchPolicy? _fetchPolicy;
  _i1.FetchPolicy? get fetchPolicy => _$this._fetchPolicy;
  set fetchPolicy(_i1.FetchPolicy? fetchPolicy) =>
      _$this._fetchPolicy = fetchPolicy;

  bool? _executeOnListen;
  bool? get executeOnListen => _$this._executeOnListen;
  set executeOnListen(bool? executeOnListen) =>
      _$this._executeOnListen = executeOnListen;

  _i4.Context? _context;
  _i4.Context? get context => _$this._context;
  set context(_i4.Context? context) => _$this._context = context;

  GReactToPostReqBuilder() {
    GReactToPostReq._initializeBuilder(this);
  }

  GReactToPostReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _operation = $v.operation;
      _requestId = $v.requestId;
      _updateResult = $v.updateResult;
      _optimisticResponse = $v.optimisticResponse?.toBuilder();
      _updateCacheHandlerKey = $v.updateCacheHandlerKey;
      _updateCacheHandlerContext = $v.updateCacheHandlerContext;
      _fetchPolicy = $v.fetchPolicy;
      _executeOnListen = $v.executeOnListen;
      _context = $v.context;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GReactToPostReq other) {
    _$v = other as _$GReactToPostReq;
  }

  @override
  void update(void Function(GReactToPostReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GReactToPostReq build() => _build();

  _$GReactToPostReq _build() {
    _$GReactToPostReq _$result;
    try {
      _$result = _$v ??
          _$GReactToPostReq._(
            vars: vars.build(),
            operation: BuiltValueNullFieldError.checkNotNull(
                operation, r'GReactToPostReq', 'operation'),
            requestId: requestId,
            updateResult: updateResult,
            optimisticResponse: _optimisticResponse?.build(),
            updateCacheHandlerKey: updateCacheHandlerKey,
            updateCacheHandlerContext: updateCacheHandlerContext,
            fetchPolicy: fetchPolicy,
            executeOnListen: BuiltValueNullFieldError.checkNotNull(
                executeOnListen, r'GReactToPostReq', 'executeOnListen'),
            context: context,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GReactToPostReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUnreactToPostReq extends GUnreactToPostReq {
  @override
  final _i3.GUnreactToPostVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GUnreactToPostData? Function(
      _i2.GUnreactToPostData?, _i2.GUnreactToPostData?)? updateResult;
  @override
  final _i2.GUnreactToPostData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;
  @override
  final _i4.Context? context;

  factory _$GUnreactToPostReq(
          [void Function(GUnreactToPostReqBuilder)? updates]) =>
      (GUnreactToPostReqBuilder()..update(updates))._build();

  _$GUnreactToPostReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen,
      this.context})
      : super._();
  @override
  GUnreactToPostReq rebuild(void Function(GUnreactToPostReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUnreactToPostReqBuilder toBuilder() =>
      GUnreactToPostReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUnreactToPostReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == other.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen &&
        context == other.context;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, requestId.hashCode);
    _$hash = $jc(_$hash, updateResult.hashCode);
    _$hash = $jc(_$hash, optimisticResponse.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerKey.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerContext.hashCode);
    _$hash = $jc(_$hash, fetchPolicy.hashCode);
    _$hash = $jc(_$hash, executeOnListen.hashCode);
    _$hash = $jc(_$hash, context.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUnreactToPostReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen)
          ..add('context', context))
        .toString();
  }
}

class GUnreactToPostReqBuilder
    implements Builder<GUnreactToPostReq, GUnreactToPostReqBuilder> {
  _$GUnreactToPostReq? _$v;

  _i3.GUnreactToPostVarsBuilder? _vars;
  _i3.GUnreactToPostVarsBuilder get vars =>
      _$this._vars ??= _i3.GUnreactToPostVarsBuilder();
  set vars(_i3.GUnreactToPostVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GUnreactToPostData? Function(
      _i2.GUnreactToPostData?, _i2.GUnreactToPostData?)? _updateResult;
  _i2.GUnreactToPostData? Function(
          _i2.GUnreactToPostData?, _i2.GUnreactToPostData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GUnreactToPostData? Function(
                  _i2.GUnreactToPostData?, _i2.GUnreactToPostData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GUnreactToPostDataBuilder? _optimisticResponse;
  _i2.GUnreactToPostDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= _i2.GUnreactToPostDataBuilder();
  set optimisticResponse(_i2.GUnreactToPostDataBuilder? optimisticResponse) =>
      _$this._optimisticResponse = optimisticResponse;

  String? _updateCacheHandlerKey;
  String? get updateCacheHandlerKey => _$this._updateCacheHandlerKey;
  set updateCacheHandlerKey(String? updateCacheHandlerKey) =>
      _$this._updateCacheHandlerKey = updateCacheHandlerKey;

  Map<String, dynamic>? _updateCacheHandlerContext;
  Map<String, dynamic>? get updateCacheHandlerContext =>
      _$this._updateCacheHandlerContext;
  set updateCacheHandlerContext(
          Map<String, dynamic>? updateCacheHandlerContext) =>
      _$this._updateCacheHandlerContext = updateCacheHandlerContext;

  _i1.FetchPolicy? _fetchPolicy;
  _i1.FetchPolicy? get fetchPolicy => _$this._fetchPolicy;
  set fetchPolicy(_i1.FetchPolicy? fetchPolicy) =>
      _$this._fetchPolicy = fetchPolicy;

  bool? _executeOnListen;
  bool? get executeOnListen => _$this._executeOnListen;
  set executeOnListen(bool? executeOnListen) =>
      _$this._executeOnListen = executeOnListen;

  _i4.Context? _context;
  _i4.Context? get context => _$this._context;
  set context(_i4.Context? context) => _$this._context = context;

  GUnreactToPostReqBuilder() {
    GUnreactToPostReq._initializeBuilder(this);
  }

  GUnreactToPostReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _operation = $v.operation;
      _requestId = $v.requestId;
      _updateResult = $v.updateResult;
      _optimisticResponse = $v.optimisticResponse?.toBuilder();
      _updateCacheHandlerKey = $v.updateCacheHandlerKey;
      _updateCacheHandlerContext = $v.updateCacheHandlerContext;
      _fetchPolicy = $v.fetchPolicy;
      _executeOnListen = $v.executeOnListen;
      _context = $v.context;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUnreactToPostReq other) {
    _$v = other as _$GUnreactToPostReq;
  }

  @override
  void update(void Function(GUnreactToPostReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUnreactToPostReq build() => _build();

  _$GUnreactToPostReq _build() {
    _$GUnreactToPostReq _$result;
    try {
      _$result = _$v ??
          _$GUnreactToPostReq._(
            vars: vars.build(),
            operation: BuiltValueNullFieldError.checkNotNull(
                operation, r'GUnreactToPostReq', 'operation'),
            requestId: requestId,
            updateResult: updateResult,
            optimisticResponse: _optimisticResponse?.build(),
            updateCacheHandlerKey: updateCacheHandlerKey,
            updateCacheHandlerContext: updateCacheHandlerContext,
            fetchPolicy: fetchPolicy,
            executeOnListen: BuiltValueNullFieldError.checkNotNull(
                executeOnListen, r'GUnreactToPostReq', 'executeOnListen'),
            context: context,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GUnreactToPostReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GPostChangedReq extends GPostChangedReq {
  @override
  final _i3.GPostChangedVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GPostChangedData? Function(
      _i2.GPostChangedData?, _i2.GPostChangedData?)? updateResult;
  @override
  final _i2.GPostChangedData? optimisticResponse;
  @override
  final String? updateCacheHandlerKey;
  @override
  final Map<String, dynamic>? updateCacheHandlerContext;
  @override
  final _i1.FetchPolicy? fetchPolicy;
  @override
  final bool executeOnListen;
  @override
  final _i4.Context? context;

  factory _$GPostChangedReq([void Function(GPostChangedReqBuilder)? updates]) =>
      (GPostChangedReqBuilder()..update(updates))._build();

  _$GPostChangedReq._(
      {required this.vars,
      required this.operation,
      this.requestId,
      this.updateResult,
      this.optimisticResponse,
      this.updateCacheHandlerKey,
      this.updateCacheHandlerContext,
      this.fetchPolicy,
      required this.executeOnListen,
      this.context})
      : super._();
  @override
  GPostChangedReq rebuild(void Function(GPostChangedReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostChangedReqBuilder toBuilder() => GPostChangedReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostChangedReq &&
        vars == other.vars &&
        operation == other.operation &&
        requestId == other.requestId &&
        updateResult == other.updateResult &&
        optimisticResponse == other.optimisticResponse &&
        updateCacheHandlerKey == other.updateCacheHandlerKey &&
        updateCacheHandlerContext == other.updateCacheHandlerContext &&
        fetchPolicy == other.fetchPolicy &&
        executeOnListen == other.executeOnListen &&
        context == other.context;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, requestId.hashCode);
    _$hash = $jc(_$hash, updateResult.hashCode);
    _$hash = $jc(_$hash, optimisticResponse.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerKey.hashCode);
    _$hash = $jc(_$hash, updateCacheHandlerContext.hashCode);
    _$hash = $jc(_$hash, fetchPolicy.hashCode);
    _$hash = $jc(_$hash, executeOnListen.hashCode);
    _$hash = $jc(_$hash, context.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostChangedReq')
          ..add('vars', vars)
          ..add('operation', operation)
          ..add('requestId', requestId)
          ..add('updateResult', updateResult)
          ..add('optimisticResponse', optimisticResponse)
          ..add('updateCacheHandlerKey', updateCacheHandlerKey)
          ..add('updateCacheHandlerContext', updateCacheHandlerContext)
          ..add('fetchPolicy', fetchPolicy)
          ..add('executeOnListen', executeOnListen)
          ..add('context', context))
        .toString();
  }
}

class GPostChangedReqBuilder
    implements Builder<GPostChangedReq, GPostChangedReqBuilder> {
  _$GPostChangedReq? _$v;

  _i3.GPostChangedVarsBuilder? _vars;
  _i3.GPostChangedVarsBuilder get vars =>
      _$this._vars ??= _i3.GPostChangedVarsBuilder();
  set vars(_i3.GPostChangedVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GPostChangedData? Function(_i2.GPostChangedData?, _i2.GPostChangedData?)?
      _updateResult;
  _i2.GPostChangedData? Function(_i2.GPostChangedData?, _i2.GPostChangedData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GPostChangedData? Function(
                  _i2.GPostChangedData?, _i2.GPostChangedData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GPostChangedDataBuilder? _optimisticResponse;
  _i2.GPostChangedDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= _i2.GPostChangedDataBuilder();
  set optimisticResponse(_i2.GPostChangedDataBuilder? optimisticResponse) =>
      _$this._optimisticResponse = optimisticResponse;

  String? _updateCacheHandlerKey;
  String? get updateCacheHandlerKey => _$this._updateCacheHandlerKey;
  set updateCacheHandlerKey(String? updateCacheHandlerKey) =>
      _$this._updateCacheHandlerKey = updateCacheHandlerKey;

  Map<String, dynamic>? _updateCacheHandlerContext;
  Map<String, dynamic>? get updateCacheHandlerContext =>
      _$this._updateCacheHandlerContext;
  set updateCacheHandlerContext(
          Map<String, dynamic>? updateCacheHandlerContext) =>
      _$this._updateCacheHandlerContext = updateCacheHandlerContext;

  _i1.FetchPolicy? _fetchPolicy;
  _i1.FetchPolicy? get fetchPolicy => _$this._fetchPolicy;
  set fetchPolicy(_i1.FetchPolicy? fetchPolicy) =>
      _$this._fetchPolicy = fetchPolicy;

  bool? _executeOnListen;
  bool? get executeOnListen => _$this._executeOnListen;
  set executeOnListen(bool? executeOnListen) =>
      _$this._executeOnListen = executeOnListen;

  _i4.Context? _context;
  _i4.Context? get context => _$this._context;
  set context(_i4.Context? context) => _$this._context = context;

  GPostChangedReqBuilder() {
    GPostChangedReq._initializeBuilder(this);
  }

  GPostChangedReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _operation = $v.operation;
      _requestId = $v.requestId;
      _updateResult = $v.updateResult;
      _optimisticResponse = $v.optimisticResponse?.toBuilder();
      _updateCacheHandlerKey = $v.updateCacheHandlerKey;
      _updateCacheHandlerContext = $v.updateCacheHandlerContext;
      _fetchPolicy = $v.fetchPolicy;
      _executeOnListen = $v.executeOnListen;
      _context = $v.context;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostChangedReq other) {
    _$v = other as _$GPostChangedReq;
  }

  @override
  void update(void Function(GPostChangedReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostChangedReq build() => _build();

  _$GPostChangedReq _build() {
    _$GPostChangedReq _$result;
    try {
      _$result = _$v ??
          _$GPostChangedReq._(
            vars: vars.build(),
            operation: BuiltValueNullFieldError.checkNotNull(
                operation, r'GPostChangedReq', 'operation'),
            requestId: requestId,
            updateResult: updateResult,
            optimisticResponse: _optimisticResponse?.build(),
            updateCacheHandlerKey: updateCacheHandlerKey,
            updateCacheHandlerContext: updateCacheHandlerContext,
            fetchPolicy: fetchPolicy,
            executeOnListen: BuiltValueNullFieldError.checkNotNull(
                executeOnListen, r'GPostChangedReq', 'executeOnListen'),
            context: context,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();

        _$failedField = 'optimisticResponse';
        _optimisticResponse?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GPostChangedReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GPostSummaryReq extends GPostSummaryReq {
  @override
  final _i3.GPostSummaryVars vars;
  @override
  final _i7.DocumentNode document;
  @override
  final String? fragmentName;
  @override
  final Map<String, dynamic> idFields;

  factory _$GPostSummaryReq([void Function(GPostSummaryReqBuilder)? updates]) =>
      (GPostSummaryReqBuilder()..update(updates))._build();

  _$GPostSummaryReq._(
      {required this.vars,
      required this.document,
      this.fragmentName,
      required this.idFields})
      : super._();
  @override
  GPostSummaryReq rebuild(void Function(GPostSummaryReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostSummaryReqBuilder toBuilder() => GPostSummaryReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostSummaryReq &&
        vars == other.vars &&
        document == other.document &&
        fragmentName == other.fragmentName &&
        idFields == other.idFields;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, document.hashCode);
    _$hash = $jc(_$hash, fragmentName.hashCode);
    _$hash = $jc(_$hash, idFields.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostSummaryReq')
          ..add('vars', vars)
          ..add('document', document)
          ..add('fragmentName', fragmentName)
          ..add('idFields', idFields))
        .toString();
  }
}

class GPostSummaryReqBuilder
    implements Builder<GPostSummaryReq, GPostSummaryReqBuilder> {
  _$GPostSummaryReq? _$v;

  _i3.GPostSummaryVarsBuilder? _vars;
  _i3.GPostSummaryVarsBuilder get vars =>
      _$this._vars ??= _i3.GPostSummaryVarsBuilder();
  set vars(_i3.GPostSummaryVarsBuilder? vars) => _$this._vars = vars;

  _i7.DocumentNode? _document;
  _i7.DocumentNode? get document => _$this._document;
  set document(_i7.DocumentNode? document) => _$this._document = document;

  String? _fragmentName;
  String? get fragmentName => _$this._fragmentName;
  set fragmentName(String? fragmentName) => _$this._fragmentName = fragmentName;

  Map<String, dynamic>? _idFields;
  Map<String, dynamic>? get idFields => _$this._idFields;
  set idFields(Map<String, dynamic>? idFields) => _$this._idFields = idFields;

  GPostSummaryReqBuilder() {
    GPostSummaryReq._initializeBuilder(this);
  }

  GPostSummaryReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _document = $v.document;
      _fragmentName = $v.fragmentName;
      _idFields = $v.idFields;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostSummaryReq other) {
    _$v = other as _$GPostSummaryReq;
  }

  @override
  void update(void Function(GPostSummaryReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostSummaryReq build() => _build();

  _$GPostSummaryReq _build() {
    _$GPostSummaryReq _$result;
    try {
      _$result = _$v ??
          _$GPostSummaryReq._(
            vars: vars.build(),
            document: BuiltValueNullFieldError.checkNotNull(
                document, r'GPostSummaryReq', 'document'),
            fragmentName: fragmentName,
            idFields: BuiltValueNullFieldError.checkNotNull(
                idFields, r'GPostSummaryReq', 'idFields'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GPostSummaryReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCommentSummaryReq extends GCommentSummaryReq {
  @override
  final _i3.GCommentSummaryVars vars;
  @override
  final _i7.DocumentNode document;
  @override
  final String? fragmentName;
  @override
  final Map<String, dynamic> idFields;

  factory _$GCommentSummaryReq(
          [void Function(GCommentSummaryReqBuilder)? updates]) =>
      (GCommentSummaryReqBuilder()..update(updates))._build();

  _$GCommentSummaryReq._(
      {required this.vars,
      required this.document,
      this.fragmentName,
      required this.idFields})
      : super._();
  @override
  GCommentSummaryReq rebuild(
          void Function(GCommentSummaryReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCommentSummaryReqBuilder toBuilder() =>
      GCommentSummaryReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCommentSummaryReq &&
        vars == other.vars &&
        document == other.document &&
        fragmentName == other.fragmentName &&
        idFields == other.idFields;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vars.hashCode);
    _$hash = $jc(_$hash, document.hashCode);
    _$hash = $jc(_$hash, fragmentName.hashCode);
    _$hash = $jc(_$hash, idFields.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCommentSummaryReq')
          ..add('vars', vars)
          ..add('document', document)
          ..add('fragmentName', fragmentName)
          ..add('idFields', idFields))
        .toString();
  }
}

class GCommentSummaryReqBuilder
    implements Builder<GCommentSummaryReq, GCommentSummaryReqBuilder> {
  _$GCommentSummaryReq? _$v;

  _i3.GCommentSummaryVarsBuilder? _vars;
  _i3.GCommentSummaryVarsBuilder get vars =>
      _$this._vars ??= _i3.GCommentSummaryVarsBuilder();
  set vars(_i3.GCommentSummaryVarsBuilder? vars) => _$this._vars = vars;

  _i7.DocumentNode? _document;
  _i7.DocumentNode? get document => _$this._document;
  set document(_i7.DocumentNode? document) => _$this._document = document;

  String? _fragmentName;
  String? get fragmentName => _$this._fragmentName;
  set fragmentName(String? fragmentName) => _$this._fragmentName = fragmentName;

  Map<String, dynamic>? _idFields;
  Map<String, dynamic>? get idFields => _$this._idFields;
  set idFields(Map<String, dynamic>? idFields) => _$this._idFields = idFields;

  GCommentSummaryReqBuilder() {
    GCommentSummaryReq._initializeBuilder(this);
  }

  GCommentSummaryReqBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vars = $v.vars.toBuilder();
      _document = $v.document;
      _fragmentName = $v.fragmentName;
      _idFields = $v.idFields;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCommentSummaryReq other) {
    _$v = other as _$GCommentSummaryReq;
  }

  @override
  void update(void Function(GCommentSummaryReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCommentSummaryReq build() => _build();

  _$GCommentSummaryReq _build() {
    _$GCommentSummaryReq _$result;
    try {
      _$result = _$v ??
          _$GCommentSummaryReq._(
            vars: vars.build(),
            document: BuiltValueNullFieldError.checkNotNull(
                document, r'GCommentSummaryReq', 'document'),
            fragmentName: fragmentName,
            idFields: BuiltValueNullFieldError.checkNotNull(
                idFields, r'GCommentSummaryReq', 'idFields'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GCommentSummaryReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
