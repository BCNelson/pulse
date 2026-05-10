// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GLoginData> _$gLoginDataSerializer = _$GLoginDataSerializer();
Serializer<GLoginData_login> _$gLoginDataLoginSerializer =
    _$GLoginData_loginSerializer();
Serializer<GLoginData_login_viewer> _$gLoginDataLoginViewerSerializer =
    _$GLoginData_login_viewerSerializer();

class _$GLoginDataSerializer implements StructuredSerializer<GLoginData> {
  @override
  final Iterable<Type> types = const [GLoginData, _$GLoginData];
  @override
  final String wireName = 'GLoginData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GLoginData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'login',
      serializers.serialize(object.login,
          specifiedType: const FullType(GLoginData_login)),
    ];

    return result;
  }

  @override
  GLoginData deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GLoginDataBuilder();

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
        case 'login':
          result.login.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GLoginData_login))!
              as GLoginData_login);
          break;
      }
    }

    return result.build();
  }
}

class _$GLoginData_loginSerializer
    implements StructuredSerializer<GLoginData_login> {
  @override
  final Iterable<Type> types = const [GLoginData_login, _$GLoginData_login];
  @override
  final String wireName = 'GLoginData_login';

  @override
  Iterable<Object?> serialize(Serializers serializers, GLoginData_login object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'token',
      serializers.serialize(object.token,
          specifiedType: const FullType(String)),
      'expiresAt',
      serializers.serialize(object.expiresAt,
          specifiedType: const FullType(_i2.GTime)),
      'viewer',
      serializers.serialize(object.viewer,
          specifiedType: const FullType(GLoginData_login_viewer)),
    ];

    return result;
  }

  @override
  GLoginData_login deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GLoginData_loginBuilder();

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
        case 'token':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'expiresAt':
          result.expiresAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'viewer':
          result.viewer.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GLoginData_login_viewer))!
              as GLoginData_login_viewer);
          break;
      }
    }

    return result.build();
  }
}

class _$GLoginData_login_viewerSerializer
    implements StructuredSerializer<GLoginData_login_viewer> {
  @override
  final Iterable<Type> types = const [
    GLoginData_login_viewer,
    _$GLoginData_login_viewer
  ];
  @override
  final String wireName = 'GLoginData_login_viewer';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GLoginData_login_viewer object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'displayName',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.email;
    if (value != null) {
      result
        ..add('email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GLoginData_login_viewer deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GLoginData_login_viewerBuilder();

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
        case 'displayName':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GLoginData extends GLoginData {
  @override
  final String G__typename;
  @override
  final GLoginData_login login;

  factory _$GLoginData([void Function(GLoginDataBuilder)? updates]) =>
      (GLoginDataBuilder()..update(updates))._build();

  _$GLoginData._({required this.G__typename, required this.login}) : super._();
  @override
  GLoginData rebuild(void Function(GLoginDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLoginDataBuilder toBuilder() => GLoginDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLoginData &&
        G__typename == other.G__typename &&
        login == other.login;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, login.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GLoginData')
          ..add('G__typename', G__typename)
          ..add('login', login))
        .toString();
  }
}

class GLoginDataBuilder implements Builder<GLoginData, GLoginDataBuilder> {
  _$GLoginData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GLoginData_loginBuilder? _login;
  GLoginData_loginBuilder get login =>
      _$this._login ??= GLoginData_loginBuilder();
  set login(GLoginData_loginBuilder? login) => _$this._login = login;

  GLoginDataBuilder() {
    GLoginData._initializeBuilder(this);
  }

  GLoginDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _login = $v.login.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GLoginData other) {
    _$v = other as _$GLoginData;
  }

  @override
  void update(void Function(GLoginDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GLoginData build() => _build();

  _$GLoginData _build() {
    _$GLoginData _$result;
    try {
      _$result = _$v ??
          _$GLoginData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GLoginData', 'G__typename'),
            login: login.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'login';
        login.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GLoginData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GLoginData_login extends GLoginData_login {
  @override
  final String G__typename;
  @override
  final String token;
  @override
  final _i2.GTime expiresAt;
  @override
  final GLoginData_login_viewer viewer;

  factory _$GLoginData_login(
          [void Function(GLoginData_loginBuilder)? updates]) =>
      (GLoginData_loginBuilder()..update(updates))._build();

  _$GLoginData_login._(
      {required this.G__typename,
      required this.token,
      required this.expiresAt,
      required this.viewer})
      : super._();
  @override
  GLoginData_login rebuild(void Function(GLoginData_loginBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLoginData_loginBuilder toBuilder() =>
      GLoginData_loginBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLoginData_login &&
        G__typename == other.G__typename &&
        token == other.token &&
        expiresAt == other.expiresAt &&
        viewer == other.viewer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, viewer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GLoginData_login')
          ..add('G__typename', G__typename)
          ..add('token', token)
          ..add('expiresAt', expiresAt)
          ..add('viewer', viewer))
        .toString();
  }
}

class GLoginData_loginBuilder
    implements Builder<GLoginData_login, GLoginData_loginBuilder> {
  _$GLoginData_login? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  _i2.GTimeBuilder? _expiresAt;
  _i2.GTimeBuilder get expiresAt => _$this._expiresAt ??= _i2.GTimeBuilder();
  set expiresAt(_i2.GTimeBuilder? expiresAt) => _$this._expiresAt = expiresAt;

  GLoginData_login_viewerBuilder? _viewer;
  GLoginData_login_viewerBuilder get viewer =>
      _$this._viewer ??= GLoginData_login_viewerBuilder();
  set viewer(GLoginData_login_viewerBuilder? viewer) => _$this._viewer = viewer;

  GLoginData_loginBuilder() {
    GLoginData_login._initializeBuilder(this);
  }

  GLoginData_loginBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _token = $v.token;
      _expiresAt = $v.expiresAt.toBuilder();
      _viewer = $v.viewer.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GLoginData_login other) {
    _$v = other as _$GLoginData_login;
  }

  @override
  void update(void Function(GLoginData_loginBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GLoginData_login build() => _build();

  _$GLoginData_login _build() {
    _$GLoginData_login _$result;
    try {
      _$result = _$v ??
          _$GLoginData_login._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GLoginData_login', 'G__typename'),
            token: BuiltValueNullFieldError.checkNotNull(
                token, r'GLoginData_login', 'token'),
            expiresAt: expiresAt.build(),
            viewer: viewer.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'expiresAt';
        expiresAt.build();
        _$failedField = 'viewer';
        viewer.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GLoginData_login', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GLoginData_login_viewer extends GLoginData_login_viewer {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;
  @override
  final String? email;

  factory _$GLoginData_login_viewer(
          [void Function(GLoginData_login_viewerBuilder)? updates]) =>
      (GLoginData_login_viewerBuilder()..update(updates))._build();

  _$GLoginData_login_viewer._(
      {required this.G__typename,
      required this.id,
      required this.displayName,
      this.email})
      : super._();
  @override
  GLoginData_login_viewer rebuild(
          void Function(GLoginData_login_viewerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLoginData_login_viewerBuilder toBuilder() =>
      GLoginData_login_viewerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLoginData_login_viewer &&
        G__typename == other.G__typename &&
        id == other.id &&
        displayName == other.displayName &&
        email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GLoginData_login_viewer')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName)
          ..add('email', email))
        .toString();
  }
}

class GLoginData_login_viewerBuilder
    implements
        Builder<GLoginData_login_viewer, GLoginData_login_viewerBuilder> {
  _$GLoginData_login_viewer? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  GLoginData_login_viewerBuilder() {
    GLoginData_login_viewer._initializeBuilder(this);
  }

  GLoginData_login_viewerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _displayName = $v.displayName;
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GLoginData_login_viewer other) {
    _$v = other as _$GLoginData_login_viewer;
  }

  @override
  void update(void Function(GLoginData_login_viewerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GLoginData_login_viewer build() => _build();

  _$GLoginData_login_viewer _build() {
    final _$result = _$v ??
        _$GLoginData_login_viewer._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GLoginData_login_viewer', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GLoginData_login_viewer', 'id'),
          displayName: BuiltValueNullFieldError.checkNotNull(
              displayName, r'GLoginData_login_viewer', 'displayName'),
          email: email,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
