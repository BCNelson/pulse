// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mention_preview.req.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMentionPreviewUserReq> _$gMentionPreviewUserReqSerializer =
    _$GMentionPreviewUserReqSerializer();
Serializer<GMentionPreviewTagReq> _$gMentionPreviewTagReqSerializer =
    _$GMentionPreviewTagReqSerializer();
Serializer<GMentionPreviewPostReq> _$gMentionPreviewPostReqSerializer =
    _$GMentionPreviewPostReqSerializer();

class _$GMentionPreviewUserReqSerializer
    implements StructuredSerializer<GMentionPreviewUserReq> {
  @override
  final Iterable<Type> types = const [
    GMentionPreviewUserReq,
    _$GMentionPreviewUserReq
  ];
  @override
  final String wireName = 'GMentionPreviewUserReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMentionPreviewUserReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GMentionPreviewUserVars)),
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
            specifiedType: const FullType(_i2.GMentionPreviewUserData)));
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
  GMentionPreviewUserReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionPreviewUserReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GMentionPreviewUserVars))!
              as _i3.GMentionPreviewUserVars);
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
                  specifiedType: const FullType(_i2.GMentionPreviewUserData))!
              as _i2.GMentionPreviewUserData);
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

class _$GMentionPreviewTagReqSerializer
    implements StructuredSerializer<GMentionPreviewTagReq> {
  @override
  final Iterable<Type> types = const [
    GMentionPreviewTagReq,
    _$GMentionPreviewTagReq
  ];
  @override
  final String wireName = 'GMentionPreviewTagReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMentionPreviewTagReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GMentionPreviewTagVars)),
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
            specifiedType: const FullType(_i2.GMentionPreviewTagData)));
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
  GMentionPreviewTagReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionPreviewTagReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GMentionPreviewTagVars))!
              as _i3.GMentionPreviewTagVars);
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
                  specifiedType: const FullType(_i2.GMentionPreviewTagData))!
              as _i2.GMentionPreviewTagData);
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

class _$GMentionPreviewPostReqSerializer
    implements StructuredSerializer<GMentionPreviewPostReq> {
  @override
  final Iterable<Type> types = const [
    GMentionPreviewPostReq,
    _$GMentionPreviewPostReq
  ];
  @override
  final String wireName = 'GMentionPreviewPostReq';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMentionPreviewPostReq object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'vars',
      serializers.serialize(object.vars,
          specifiedType: const FullType(_i3.GMentionPreviewPostVars)),
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
  GMentionPreviewPostReq deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionPreviewPostReqBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'vars':
          result.vars.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GMentionPreviewPostVars))!
              as _i3.GMentionPreviewPostVars);
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

class _$GMentionPreviewUserReq extends GMentionPreviewUserReq {
  @override
  final _i3.GMentionPreviewUserVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GMentionPreviewUserData? Function(
      _i2.GMentionPreviewUserData?, _i2.GMentionPreviewUserData?)? updateResult;
  @override
  final _i2.GMentionPreviewUserData? optimisticResponse;
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

  factory _$GMentionPreviewUserReq(
          [void Function(GMentionPreviewUserReqBuilder)? updates]) =>
      (GMentionPreviewUserReqBuilder()..update(updates))._build();

  _$GMentionPreviewUserReq._(
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
  GMentionPreviewUserReq rebuild(
          void Function(GMentionPreviewUserReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionPreviewUserReqBuilder toBuilder() =>
      GMentionPreviewUserReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionPreviewUserReq &&
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
    return (newBuiltValueToStringHelper(r'GMentionPreviewUserReq')
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

class GMentionPreviewUserReqBuilder
    implements Builder<GMentionPreviewUserReq, GMentionPreviewUserReqBuilder> {
  _$GMentionPreviewUserReq? _$v;

  _i3.GMentionPreviewUserVarsBuilder? _vars;
  _i3.GMentionPreviewUserVarsBuilder get vars =>
      _$this._vars ??= _i3.GMentionPreviewUserVarsBuilder();
  set vars(_i3.GMentionPreviewUserVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GMentionPreviewUserData? Function(
          _i2.GMentionPreviewUserData?, _i2.GMentionPreviewUserData?)?
      _updateResult;
  _i2.GMentionPreviewUserData? Function(
          _i2.GMentionPreviewUserData?, _i2.GMentionPreviewUserData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GMentionPreviewUserData? Function(
                  _i2.GMentionPreviewUserData?, _i2.GMentionPreviewUserData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GMentionPreviewUserDataBuilder? _optimisticResponse;
  _i2.GMentionPreviewUserDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= _i2.GMentionPreviewUserDataBuilder();
  set optimisticResponse(
          _i2.GMentionPreviewUserDataBuilder? optimisticResponse) =>
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

  GMentionPreviewUserReqBuilder() {
    GMentionPreviewUserReq._initializeBuilder(this);
  }

  GMentionPreviewUserReqBuilder get _$this {
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
  void replace(GMentionPreviewUserReq other) {
    _$v = other as _$GMentionPreviewUserReq;
  }

  @override
  void update(void Function(GMentionPreviewUserReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionPreviewUserReq build() => _build();

  _$GMentionPreviewUserReq _build() {
    _$GMentionPreviewUserReq _$result;
    try {
      _$result = _$v ??
          _$GMentionPreviewUserReq._(
            vars: vars.build(),
            operation: BuiltValueNullFieldError.checkNotNull(
                operation, r'GMentionPreviewUserReq', 'operation'),
            requestId: requestId,
            updateResult: updateResult,
            optimisticResponse: _optimisticResponse?.build(),
            updateCacheHandlerKey: updateCacheHandlerKey,
            updateCacheHandlerContext: updateCacheHandlerContext,
            fetchPolicy: fetchPolicy,
            executeOnListen: BuiltValueNullFieldError.checkNotNull(
                executeOnListen, r'GMentionPreviewUserReq', 'executeOnListen'),
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
            r'GMentionPreviewUserReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMentionPreviewTagReq extends GMentionPreviewTagReq {
  @override
  final _i3.GMentionPreviewTagVars vars;
  @override
  final _i4.Operation operation;
  @override
  final String? requestId;
  @override
  final _i2.GMentionPreviewTagData? Function(
      _i2.GMentionPreviewTagData?, _i2.GMentionPreviewTagData?)? updateResult;
  @override
  final _i2.GMentionPreviewTagData? optimisticResponse;
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

  factory _$GMentionPreviewTagReq(
          [void Function(GMentionPreviewTagReqBuilder)? updates]) =>
      (GMentionPreviewTagReqBuilder()..update(updates))._build();

  _$GMentionPreviewTagReq._(
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
  GMentionPreviewTagReq rebuild(
          void Function(GMentionPreviewTagReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionPreviewTagReqBuilder toBuilder() =>
      GMentionPreviewTagReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionPreviewTagReq &&
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
    return (newBuiltValueToStringHelper(r'GMentionPreviewTagReq')
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

class GMentionPreviewTagReqBuilder
    implements Builder<GMentionPreviewTagReq, GMentionPreviewTagReqBuilder> {
  _$GMentionPreviewTagReq? _$v;

  _i3.GMentionPreviewTagVarsBuilder? _vars;
  _i3.GMentionPreviewTagVarsBuilder get vars =>
      _$this._vars ??= _i3.GMentionPreviewTagVarsBuilder();
  set vars(_i3.GMentionPreviewTagVarsBuilder? vars) => _$this._vars = vars;

  _i4.Operation? _operation;
  _i4.Operation? get operation => _$this._operation;
  set operation(_i4.Operation? operation) => _$this._operation = operation;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  _i2.GMentionPreviewTagData? Function(
      _i2.GMentionPreviewTagData?, _i2.GMentionPreviewTagData?)? _updateResult;
  _i2.GMentionPreviewTagData? Function(
          _i2.GMentionPreviewTagData?, _i2.GMentionPreviewTagData?)?
      get updateResult => _$this._updateResult;
  set updateResult(
          _i2.GMentionPreviewTagData? Function(
                  _i2.GMentionPreviewTagData?, _i2.GMentionPreviewTagData?)?
              updateResult) =>
      _$this._updateResult = updateResult;

  _i2.GMentionPreviewTagDataBuilder? _optimisticResponse;
  _i2.GMentionPreviewTagDataBuilder get optimisticResponse =>
      _$this._optimisticResponse ??= _i2.GMentionPreviewTagDataBuilder();
  set optimisticResponse(
          _i2.GMentionPreviewTagDataBuilder? optimisticResponse) =>
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

  GMentionPreviewTagReqBuilder() {
    GMentionPreviewTagReq._initializeBuilder(this);
  }

  GMentionPreviewTagReqBuilder get _$this {
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
  void replace(GMentionPreviewTagReq other) {
    _$v = other as _$GMentionPreviewTagReq;
  }

  @override
  void update(void Function(GMentionPreviewTagReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionPreviewTagReq build() => _build();

  _$GMentionPreviewTagReq _build() {
    _$GMentionPreviewTagReq _$result;
    try {
      _$result = _$v ??
          _$GMentionPreviewTagReq._(
            vars: vars.build(),
            operation: BuiltValueNullFieldError.checkNotNull(
                operation, r'GMentionPreviewTagReq', 'operation'),
            requestId: requestId,
            updateResult: updateResult,
            optimisticResponse: _optimisticResponse?.build(),
            updateCacheHandlerKey: updateCacheHandlerKey,
            updateCacheHandlerContext: updateCacheHandlerContext,
            fetchPolicy: fetchPolicy,
            executeOnListen: BuiltValueNullFieldError.checkNotNull(
                executeOnListen, r'GMentionPreviewTagReq', 'executeOnListen'),
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
            r'GMentionPreviewTagReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMentionPreviewPostReq extends GMentionPreviewPostReq {
  @override
  final _i3.GMentionPreviewPostVars vars;
  @override
  final _i7.DocumentNode document;
  @override
  final String? fragmentName;
  @override
  final Map<String, dynamic> idFields;

  factory _$GMentionPreviewPostReq(
          [void Function(GMentionPreviewPostReqBuilder)? updates]) =>
      (GMentionPreviewPostReqBuilder()..update(updates))._build();

  _$GMentionPreviewPostReq._(
      {required this.vars,
      required this.document,
      this.fragmentName,
      required this.idFields})
      : super._();
  @override
  GMentionPreviewPostReq rebuild(
          void Function(GMentionPreviewPostReqBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionPreviewPostReqBuilder toBuilder() =>
      GMentionPreviewPostReqBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionPreviewPostReq &&
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
    return (newBuiltValueToStringHelper(r'GMentionPreviewPostReq')
          ..add('vars', vars)
          ..add('document', document)
          ..add('fragmentName', fragmentName)
          ..add('idFields', idFields))
        .toString();
  }
}

class GMentionPreviewPostReqBuilder
    implements Builder<GMentionPreviewPostReq, GMentionPreviewPostReqBuilder> {
  _$GMentionPreviewPostReq? _$v;

  _i3.GMentionPreviewPostVarsBuilder? _vars;
  _i3.GMentionPreviewPostVarsBuilder get vars =>
      _$this._vars ??= _i3.GMentionPreviewPostVarsBuilder();
  set vars(_i3.GMentionPreviewPostVarsBuilder? vars) => _$this._vars = vars;

  _i7.DocumentNode? _document;
  _i7.DocumentNode? get document => _$this._document;
  set document(_i7.DocumentNode? document) => _$this._document = document;

  String? _fragmentName;
  String? get fragmentName => _$this._fragmentName;
  set fragmentName(String? fragmentName) => _$this._fragmentName = fragmentName;

  Map<String, dynamic>? _idFields;
  Map<String, dynamic>? get idFields => _$this._idFields;
  set idFields(Map<String, dynamic>? idFields) => _$this._idFields = idFields;

  GMentionPreviewPostReqBuilder() {
    GMentionPreviewPostReq._initializeBuilder(this);
  }

  GMentionPreviewPostReqBuilder get _$this {
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
  void replace(GMentionPreviewPostReq other) {
    _$v = other as _$GMentionPreviewPostReq;
  }

  @override
  void update(void Function(GMentionPreviewPostReqBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionPreviewPostReq build() => _build();

  _$GMentionPreviewPostReq _build() {
    _$GMentionPreviewPostReq _$result;
    try {
      _$result = _$v ??
          _$GMentionPreviewPostReq._(
            vars: vars.build(),
            document: BuiltValueNullFieldError.checkNotNull(
                document, r'GMentionPreviewPostReq', 'document'),
            fragmentName: fragmentName,
            idFields: BuiltValueNullFieldError.checkNotNull(
                idFields, r'GMentionPreviewPostReq', 'idFields'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vars';
        vars.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMentionPreviewPostReq', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
