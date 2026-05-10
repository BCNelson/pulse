// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GHealthData> _$gHealthDataSerializer = _$GHealthDataSerializer();

class _$GHealthDataSerializer implements StructuredSerializer<GHealthData> {
  @override
  final Iterable<Type> types = const [GHealthData, _$GHealthData];
  @override
  final String wireName = 'GHealthData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GHealthData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'health',
      serializers.serialize(object.health,
          specifiedType: const FullType(String)),
      'serverTime',
      serializers.serialize(object.serverTime,
          specifiedType: const FullType(_i1.GTime)),
    ];

    return result;
  }

  @override
  GHealthData deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GHealthDataBuilder();

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
        case 'health':
          result.health = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'serverTime':
          result.serverTime.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i1.GTime))! as _i1.GTime);
          break;
      }
    }

    return result.build();
  }
}

class _$GHealthData extends GHealthData {
  @override
  final String G__typename;
  @override
  final String health;
  @override
  final _i1.GTime serverTime;

  factory _$GHealthData([void Function(GHealthDataBuilder)? updates]) =>
      (GHealthDataBuilder()..update(updates))._build();

  _$GHealthData._(
      {required this.G__typename,
      required this.health,
      required this.serverTime})
      : super._();
  @override
  GHealthData rebuild(void Function(GHealthDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GHealthDataBuilder toBuilder() => GHealthDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GHealthData &&
        G__typename == other.G__typename &&
        health == other.health &&
        serverTime == other.serverTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, health.hashCode);
    _$hash = $jc(_$hash, serverTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GHealthData')
          ..add('G__typename', G__typename)
          ..add('health', health)
          ..add('serverTime', serverTime))
        .toString();
  }
}

class GHealthDataBuilder implements Builder<GHealthData, GHealthDataBuilder> {
  _$GHealthData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _health;
  String? get health => _$this._health;
  set health(String? health) => _$this._health = health;

  _i1.GTimeBuilder? _serverTime;
  _i1.GTimeBuilder get serverTime => _$this._serverTime ??= _i1.GTimeBuilder();
  set serverTime(_i1.GTimeBuilder? serverTime) =>
      _$this._serverTime = serverTime;

  GHealthDataBuilder() {
    GHealthData._initializeBuilder(this);
  }

  GHealthDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _health = $v.health;
      _serverTime = $v.serverTime.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GHealthData other) {
    _$v = other as _$GHealthData;
  }

  @override
  void update(void Function(GHealthDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GHealthData build() => _build();

  _$GHealthData _build() {
    _$GHealthData _$result;
    try {
      _$result = _$v ??
          _$GHealthData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GHealthData', 'G__typename'),
            health: BuiltValueNullFieldError.checkNotNull(
                health, r'GHealthData', 'health'),
            serverTime: serverTime.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'serverTime';
        serverTime.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GHealthData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
