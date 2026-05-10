// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GSearchVars> _$gSearchVarsSerializer = _$GSearchVarsSerializer();
Serializer<GSearchTagsVars> _$gSearchTagsVarsSerializer =
    _$GSearchTagsVarsSerializer();

class _$GSearchVarsSerializer implements StructuredSerializer<GSearchVars> {
  @override
  final Iterable<Type> types = const [GSearchVars, _$GSearchVars];
  @override
  final String wireName = 'GSearchVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GSearchVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'query',
      serializers.serialize(object.query,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.first;
    if (value != null) {
      result
        ..add('first')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GSearchVars deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GSearchVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'query':
          result.query = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'first':
          result.first = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchTagsVarsSerializer
    implements StructuredSerializer<GSearchTagsVars> {
  @override
  final Iterable<Type> types = const [GSearchTagsVars, _$GSearchTagsVars];
  @override
  final String wireName = 'GSearchTagsVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GSearchTagsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'query',
      serializers.serialize(object.query,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.first;
    if (value != null) {
      result
        ..add('first')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GSearchTagsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GSearchTagsVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'query':
          result.query = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'first':
          result.first = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchVars extends GSearchVars {
  @override
  final String query;
  @override
  final int? first;

  factory _$GSearchVars([void Function(GSearchVarsBuilder)? updates]) =>
      (GSearchVarsBuilder()..update(updates))._build();

  _$GSearchVars._({required this.query, this.first}) : super._();
  @override
  GSearchVars rebuild(void Function(GSearchVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchVarsBuilder toBuilder() => GSearchVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchVars && query == other.query && first == other.first;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, query.hashCode);
    _$hash = $jc(_$hash, first.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchVars')
          ..add('query', query)
          ..add('first', first))
        .toString();
  }
}

class GSearchVarsBuilder implements Builder<GSearchVars, GSearchVarsBuilder> {
  _$GSearchVars? _$v;

  String? _query;
  String? get query => _$this._query;
  set query(String? query) => _$this._query = query;

  int? _first;
  int? get first => _$this._first;
  set first(int? first) => _$this._first = first;

  GSearchVarsBuilder();

  GSearchVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _query = $v.query;
      _first = $v.first;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchVars other) {
    _$v = other as _$GSearchVars;
  }

  @override
  void update(void Function(GSearchVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchVars build() => _build();

  _$GSearchVars _build() {
    final _$result = _$v ??
        _$GSearchVars._(
          query: BuiltValueNullFieldError.checkNotNull(
              query, r'GSearchVars', 'query'),
          first: first,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GSearchTagsVars extends GSearchTagsVars {
  @override
  final String query;
  @override
  final int? first;

  factory _$GSearchTagsVars([void Function(GSearchTagsVarsBuilder)? updates]) =>
      (GSearchTagsVarsBuilder()..update(updates))._build();

  _$GSearchTagsVars._({required this.query, this.first}) : super._();
  @override
  GSearchTagsVars rebuild(void Function(GSearchTagsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchTagsVarsBuilder toBuilder() => GSearchTagsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchTagsVars &&
        query == other.query &&
        first == other.first;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, query.hashCode);
    _$hash = $jc(_$hash, first.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchTagsVars')
          ..add('query', query)
          ..add('first', first))
        .toString();
  }
}

class GSearchTagsVarsBuilder
    implements Builder<GSearchTagsVars, GSearchTagsVarsBuilder> {
  _$GSearchTagsVars? _$v;

  String? _query;
  String? get query => _$this._query;
  set query(String? query) => _$this._query = query;

  int? _first;
  int? get first => _$this._first;
  set first(int? first) => _$this._first = first;

  GSearchTagsVarsBuilder();

  GSearchTagsVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _query = $v.query;
      _first = $v.first;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchTagsVars other) {
    _$v = other as _$GSearchTagsVars;
  }

  @override
  void update(void Function(GSearchTagsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchTagsVars build() => _build();

  _$GSearchTagsVars _build() {
    final _$result = _$v ??
        _$GSearchTagsVars._(
          query: BuiltValueNullFieldError.checkNotNull(
              query, r'GSearchTagsVars', 'query'),
          first: first,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
