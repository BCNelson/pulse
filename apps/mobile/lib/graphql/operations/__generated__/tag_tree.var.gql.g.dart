// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_tree.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GTagTreeVars> _$gTagTreeVarsSerializer = _$GTagTreeVarsSerializer();
Serializer<GTagChildrenVars> _$gTagChildrenVarsSerializer =
    _$GTagChildrenVarsSerializer();
Serializer<GTagSummaryVars> _$gTagSummaryVarsSerializer =
    _$GTagSummaryVarsSerializer();

class _$GTagTreeVarsSerializer implements StructuredSerializer<GTagTreeVars> {
  @override
  final Iterable<Type> types = const [GTagTreeVars, _$GTagTreeVars];
  @override
  final String wireName = 'GTagTreeVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GTagTreeVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GTagTreeVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GTagTreeVarsBuilder().build();
  }
}

class _$GTagChildrenVarsSerializer
    implements StructuredSerializer<GTagChildrenVars> {
  @override
  final Iterable<Type> types = const [GTagChildrenVars, _$GTagChildrenVars];
  @override
  final String wireName = 'GTagChildrenVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GTagChildrenVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GTagChildrenVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GTagChildrenVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GTagSummaryVarsSerializer
    implements StructuredSerializer<GTagSummaryVars> {
  @override
  final Iterable<Type> types = const [GTagSummaryVars, _$GTagSummaryVars];
  @override
  final String wireName = 'GTagSummaryVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GTagSummaryVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GTagSummaryVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GTagSummaryVarsBuilder().build();
  }
}

class _$GTagTreeVars extends GTagTreeVars {
  factory _$GTagTreeVars([void Function(GTagTreeVarsBuilder)? updates]) =>
      (GTagTreeVarsBuilder()..update(updates))._build();

  _$GTagTreeVars._() : super._();
  @override
  GTagTreeVars rebuild(void Function(GTagTreeVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GTagTreeVarsBuilder toBuilder() => GTagTreeVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GTagTreeVars;
  }

  @override
  int get hashCode {
    return 513855738;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GTagTreeVars').toString();
  }
}

class GTagTreeVarsBuilder
    implements Builder<GTagTreeVars, GTagTreeVarsBuilder> {
  _$GTagTreeVars? _$v;

  GTagTreeVarsBuilder();

  @override
  void replace(GTagTreeVars other) {
    _$v = other as _$GTagTreeVars;
  }

  @override
  void update(void Function(GTagTreeVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GTagTreeVars build() => _build();

  _$GTagTreeVars _build() {
    final _$result = _$v ?? _$GTagTreeVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GTagChildrenVars extends GTagChildrenVars {
  @override
  final String id;

  factory _$GTagChildrenVars(
          [void Function(GTagChildrenVarsBuilder)? updates]) =>
      (GTagChildrenVarsBuilder()..update(updates))._build();

  _$GTagChildrenVars._({required this.id}) : super._();
  @override
  GTagChildrenVars rebuild(void Function(GTagChildrenVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GTagChildrenVarsBuilder toBuilder() =>
      GTagChildrenVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GTagChildrenVars && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GTagChildrenVars')..add('id', id))
        .toString();
  }
}

class GTagChildrenVarsBuilder
    implements Builder<GTagChildrenVars, GTagChildrenVarsBuilder> {
  _$GTagChildrenVars? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GTagChildrenVarsBuilder();

  GTagChildrenVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GTagChildrenVars other) {
    _$v = other as _$GTagChildrenVars;
  }

  @override
  void update(void Function(GTagChildrenVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GTagChildrenVars build() => _build();

  _$GTagChildrenVars _build() {
    final _$result = _$v ??
        _$GTagChildrenVars._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GTagChildrenVars', 'id'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GTagSummaryVars extends GTagSummaryVars {
  factory _$GTagSummaryVars([void Function(GTagSummaryVarsBuilder)? updates]) =>
      (GTagSummaryVarsBuilder()..update(updates))._build();

  _$GTagSummaryVars._() : super._();
  @override
  GTagSummaryVars rebuild(void Function(GTagSummaryVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GTagSummaryVarsBuilder toBuilder() => GTagSummaryVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GTagSummaryVars;
  }

  @override
  int get hashCode {
    return 861041119;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GTagSummaryVars').toString();
  }
}

class GTagSummaryVarsBuilder
    implements Builder<GTagSummaryVars, GTagSummaryVarsBuilder> {
  _$GTagSummaryVars? _$v;

  GTagSummaryVarsBuilder();

  @override
  void replace(GTagSummaryVars other) {
    _$v = other as _$GTagSummaryVars;
  }

  @override
  void update(void Function(GTagSummaryVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GTagSummaryVars build() => _build();

  _$GTagSummaryVars _build() {
    final _$result = _$v ?? _$GTagSummaryVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
