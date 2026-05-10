// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GLogoutData> _$gLogoutDataSerializer = _$GLogoutDataSerializer();

class _$GLogoutDataSerializer implements StructuredSerializer<GLogoutData> {
  @override
  final Iterable<Type> types = const [GLogoutData, _$GLogoutData];
  @override
  final String wireName = 'GLogoutData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GLogoutData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'logout',
      serializers.serialize(object.logout, specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GLogoutData deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GLogoutDataBuilder();

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
        case 'logout':
          result.logout = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GLogoutData extends GLogoutData {
  @override
  final String G__typename;
  @override
  final bool logout;

  factory _$GLogoutData([void Function(GLogoutDataBuilder)? updates]) =>
      (GLogoutDataBuilder()..update(updates))._build();

  _$GLogoutData._({required this.G__typename, required this.logout})
      : super._();
  @override
  GLogoutData rebuild(void Function(GLogoutDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLogoutDataBuilder toBuilder() => GLogoutDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLogoutData &&
        G__typename == other.G__typename &&
        logout == other.logout;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, logout.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GLogoutData')
          ..add('G__typename', G__typename)
          ..add('logout', logout))
        .toString();
  }
}

class GLogoutDataBuilder implements Builder<GLogoutData, GLogoutDataBuilder> {
  _$GLogoutData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _logout;
  bool? get logout => _$this._logout;
  set logout(bool? logout) => _$this._logout = logout;

  GLogoutDataBuilder() {
    GLogoutData._initializeBuilder(this);
  }

  GLogoutDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _logout = $v.logout;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GLogoutData other) {
    _$v = other as _$GLogoutData;
  }

  @override
  void update(void Function(GLogoutDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GLogoutData build() => _build();

  _$GLogoutData _build() {
    final _$result = _$v ??
        _$GLogoutData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GLogoutData', 'G__typename'),
          logout: BuiltValueNullFieldError.checkNotNull(
              logout, r'GLogoutData', 'logout'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
