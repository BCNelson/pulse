// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'impersonation.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GViewerImpersonationStateVars>
    _$gViewerImpersonationStateVarsSerializer =
    _$GViewerImpersonationStateVarsSerializer();
Serializer<GImpersonateVars> _$gImpersonateVarsSerializer =
    _$GImpersonateVarsSerializer();
Serializer<GEndImpersonationVars> _$gEndImpersonationVarsSerializer =
    _$GEndImpersonationVarsSerializer();
Serializer<GRegisterDeviceTokenVars> _$gRegisterDeviceTokenVarsSerializer =
    _$GRegisterDeviceTokenVarsSerializer();
Serializer<GUnregisterDeviceTokenVars> _$gUnregisterDeviceTokenVarsSerializer =
    _$GUnregisterDeviceTokenVarsSerializer();

class _$GViewerImpersonationStateVarsSerializer
    implements StructuredSerializer<GViewerImpersonationStateVars> {
  @override
  final Iterable<Type> types = const [
    GViewerImpersonationStateVars,
    _$GViewerImpersonationStateVars
  ];
  @override
  final String wireName = 'GViewerImpersonationStateVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GViewerImpersonationStateVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GViewerImpersonationStateVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GViewerImpersonationStateVarsBuilder().build();
  }
}

class _$GImpersonateVarsSerializer
    implements StructuredSerializer<GImpersonateVars> {
  @override
  final Iterable<Type> types = const [GImpersonateVars, _$GImpersonateVars];
  @override
  final String wireName = 'GImpersonateVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GImpersonateVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'principalId',
      serializers.serialize(object.principalId,
          specifiedType: const FullType(String)),
      'reason',
      serializers.serialize(object.reason,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GImpersonateVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GImpersonateVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'principalId':
          result.principalId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'reason':
          result.reason = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GEndImpersonationVarsSerializer
    implements StructuredSerializer<GEndImpersonationVars> {
  @override
  final Iterable<Type> types = const [
    GEndImpersonationVars,
    _$GEndImpersonationVars
  ];
  @override
  final String wireName = 'GEndImpersonationVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GEndImpersonationVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GEndImpersonationVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GEndImpersonationVarsBuilder().build();
  }
}

class _$GRegisterDeviceTokenVarsSerializer
    implements StructuredSerializer<GRegisterDeviceTokenVars> {
  @override
  final Iterable<Type> types = const [
    GRegisterDeviceTokenVars,
    _$GRegisterDeviceTokenVars
  ];
  @override
  final String wireName = 'GRegisterDeviceTokenVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRegisterDeviceTokenVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'token',
      serializers.serialize(object.token,
          specifiedType: const FullType(String)),
      'platform',
      serializers.serialize(object.platform,
          specifiedType: const FullType(_i2.GDevicePlatform)),
    ];

    return result;
  }

  @override
  GRegisterDeviceTokenVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GRegisterDeviceTokenVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'token':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'platform':
          result.platform = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GDevicePlatform))!
              as _i2.GDevicePlatform;
          break;
      }
    }

    return result.build();
  }
}

class _$GUnregisterDeviceTokenVarsSerializer
    implements StructuredSerializer<GUnregisterDeviceTokenVars> {
  @override
  final Iterable<Type> types = const [
    GUnregisterDeviceTokenVars,
    _$GUnregisterDeviceTokenVars
  ];
  @override
  final String wireName = 'GUnregisterDeviceTokenVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUnregisterDeviceTokenVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'token',
      serializers.serialize(object.token,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GUnregisterDeviceTokenVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUnregisterDeviceTokenVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'token':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GViewerImpersonationStateVars extends GViewerImpersonationStateVars {
  factory _$GViewerImpersonationStateVars(
          [void Function(GViewerImpersonationStateVarsBuilder)? updates]) =>
      (GViewerImpersonationStateVarsBuilder()..update(updates))._build();

  _$GViewerImpersonationStateVars._() : super._();
  @override
  GViewerImpersonationStateVars rebuild(
          void Function(GViewerImpersonationStateVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GViewerImpersonationStateVarsBuilder toBuilder() =>
      GViewerImpersonationStateVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GViewerImpersonationStateVars;
  }

  @override
  int get hashCode {
    return 299402247;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GViewerImpersonationStateVars')
        .toString();
  }
}

class GViewerImpersonationStateVarsBuilder
    implements
        Builder<GViewerImpersonationStateVars,
            GViewerImpersonationStateVarsBuilder> {
  _$GViewerImpersonationStateVars? _$v;

  GViewerImpersonationStateVarsBuilder();

  @override
  void replace(GViewerImpersonationStateVars other) {
    _$v = other as _$GViewerImpersonationStateVars;
  }

  @override
  void update(void Function(GViewerImpersonationStateVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GViewerImpersonationStateVars build() => _build();

  _$GViewerImpersonationStateVars _build() {
    final _$result = _$v ?? _$GViewerImpersonationStateVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GImpersonateVars extends GImpersonateVars {
  @override
  final String principalId;
  @override
  final String reason;

  factory _$GImpersonateVars(
          [void Function(GImpersonateVarsBuilder)? updates]) =>
      (GImpersonateVarsBuilder()..update(updates))._build();

  _$GImpersonateVars._({required this.principalId, required this.reason})
      : super._();
  @override
  GImpersonateVars rebuild(void Function(GImpersonateVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GImpersonateVarsBuilder toBuilder() =>
      GImpersonateVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GImpersonateVars &&
        principalId == other.principalId &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, principalId.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GImpersonateVars')
          ..add('principalId', principalId)
          ..add('reason', reason))
        .toString();
  }
}

class GImpersonateVarsBuilder
    implements Builder<GImpersonateVars, GImpersonateVarsBuilder> {
  _$GImpersonateVars? _$v;

  String? _principalId;
  String? get principalId => _$this._principalId;
  set principalId(String? principalId) => _$this._principalId = principalId;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  GImpersonateVarsBuilder();

  GImpersonateVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _principalId = $v.principalId;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GImpersonateVars other) {
    _$v = other as _$GImpersonateVars;
  }

  @override
  void update(void Function(GImpersonateVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GImpersonateVars build() => _build();

  _$GImpersonateVars _build() {
    final _$result = _$v ??
        _$GImpersonateVars._(
          principalId: BuiltValueNullFieldError.checkNotNull(
              principalId, r'GImpersonateVars', 'principalId'),
          reason: BuiltValueNullFieldError.checkNotNull(
              reason, r'GImpersonateVars', 'reason'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GEndImpersonationVars extends GEndImpersonationVars {
  factory _$GEndImpersonationVars(
          [void Function(GEndImpersonationVarsBuilder)? updates]) =>
      (GEndImpersonationVarsBuilder()..update(updates))._build();

  _$GEndImpersonationVars._() : super._();
  @override
  GEndImpersonationVars rebuild(
          void Function(GEndImpersonationVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GEndImpersonationVarsBuilder toBuilder() =>
      GEndImpersonationVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GEndImpersonationVars;
  }

  @override
  int get hashCode {
    return 235074718;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GEndImpersonationVars').toString();
  }
}

class GEndImpersonationVarsBuilder
    implements Builder<GEndImpersonationVars, GEndImpersonationVarsBuilder> {
  _$GEndImpersonationVars? _$v;

  GEndImpersonationVarsBuilder();

  @override
  void replace(GEndImpersonationVars other) {
    _$v = other as _$GEndImpersonationVars;
  }

  @override
  void update(void Function(GEndImpersonationVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GEndImpersonationVars build() => _build();

  _$GEndImpersonationVars _build() {
    final _$result = _$v ?? _$GEndImpersonationVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GRegisterDeviceTokenVars extends GRegisterDeviceTokenVars {
  @override
  final String token;
  @override
  final _i2.GDevicePlatform platform;

  factory _$GRegisterDeviceTokenVars(
          [void Function(GRegisterDeviceTokenVarsBuilder)? updates]) =>
      (GRegisterDeviceTokenVarsBuilder()..update(updates))._build();

  _$GRegisterDeviceTokenVars._({required this.token, required this.platform})
      : super._();
  @override
  GRegisterDeviceTokenVars rebuild(
          void Function(GRegisterDeviceTokenVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRegisterDeviceTokenVarsBuilder toBuilder() =>
      GRegisterDeviceTokenVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRegisterDeviceTokenVars &&
        token == other.token &&
        platform == other.platform;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRegisterDeviceTokenVars')
          ..add('token', token)
          ..add('platform', platform))
        .toString();
  }
}

class GRegisterDeviceTokenVarsBuilder
    implements
        Builder<GRegisterDeviceTokenVars, GRegisterDeviceTokenVarsBuilder> {
  _$GRegisterDeviceTokenVars? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  _i2.GDevicePlatform? _platform;
  _i2.GDevicePlatform? get platform => _$this._platform;
  set platform(_i2.GDevicePlatform? platform) => _$this._platform = platform;

  GRegisterDeviceTokenVarsBuilder();

  GRegisterDeviceTokenVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _platform = $v.platform;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRegisterDeviceTokenVars other) {
    _$v = other as _$GRegisterDeviceTokenVars;
  }

  @override
  void update(void Function(GRegisterDeviceTokenVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterDeviceTokenVars build() => _build();

  _$GRegisterDeviceTokenVars _build() {
    final _$result = _$v ??
        _$GRegisterDeviceTokenVars._(
          token: BuiltValueNullFieldError.checkNotNull(
              token, r'GRegisterDeviceTokenVars', 'token'),
          platform: BuiltValueNullFieldError.checkNotNull(
              platform, r'GRegisterDeviceTokenVars', 'platform'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GUnregisterDeviceTokenVars extends GUnregisterDeviceTokenVars {
  @override
  final String token;

  factory _$GUnregisterDeviceTokenVars(
          [void Function(GUnregisterDeviceTokenVarsBuilder)? updates]) =>
      (GUnregisterDeviceTokenVarsBuilder()..update(updates))._build();

  _$GUnregisterDeviceTokenVars._({required this.token}) : super._();
  @override
  GUnregisterDeviceTokenVars rebuild(
          void Function(GUnregisterDeviceTokenVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUnregisterDeviceTokenVarsBuilder toBuilder() =>
      GUnregisterDeviceTokenVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUnregisterDeviceTokenVars && token == other.token;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUnregisterDeviceTokenVars')
          ..add('token', token))
        .toString();
  }
}

class GUnregisterDeviceTokenVarsBuilder
    implements
        Builder<GUnregisterDeviceTokenVars, GUnregisterDeviceTokenVarsBuilder> {
  _$GUnregisterDeviceTokenVars? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  GUnregisterDeviceTokenVarsBuilder();

  GUnregisterDeviceTokenVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUnregisterDeviceTokenVars other) {
    _$v = other as _$GUnregisterDeviceTokenVars;
  }

  @override
  void update(void Function(GUnregisterDeviceTokenVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUnregisterDeviceTokenVars build() => _build();

  _$GUnregisterDeviceTokenVars _build() {
    final _$result = _$v ??
        _$GUnregisterDeviceTokenVars._(
          token: BuiltValueNullFieldError.checkNotNull(
              token, r'GUnregisterDeviceTokenVars', 'token'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
