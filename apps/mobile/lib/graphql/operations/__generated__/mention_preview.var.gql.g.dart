// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mention_preview.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMentionPreviewUserVars> _$gMentionPreviewUserVarsSerializer =
    _$GMentionPreviewUserVarsSerializer();
Serializer<GMentionPreviewTagVars> _$gMentionPreviewTagVarsSerializer =
    _$GMentionPreviewTagVarsSerializer();
Serializer<GMentionPreviewPostVars> _$gMentionPreviewPostVarsSerializer =
    _$GMentionPreviewPostVarsSerializer();

class _$GMentionPreviewUserVarsSerializer
    implements StructuredSerializer<GMentionPreviewUserVars> {
  @override
  final Iterable<Type> types = const [
    GMentionPreviewUserVars,
    _$GMentionPreviewUserVars
  ];
  @override
  final String wireName = 'GMentionPreviewUserVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMentionPreviewUserVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'slug',
      serializers.serialize(object.slug, specifiedType: const FullType(String)),
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
  GMentionPreviewUserVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionPreviewUserVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'slug':
          result.slug = serializers.deserialize(value,
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

class _$GMentionPreviewTagVarsSerializer
    implements StructuredSerializer<GMentionPreviewTagVars> {
  @override
  final Iterable<Type> types = const [
    GMentionPreviewTagVars,
    _$GMentionPreviewTagVars
  ];
  @override
  final String wireName = 'GMentionPreviewTagVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMentionPreviewTagVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'path',
      serializers.serialize(object.path,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
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
  GMentionPreviewTagVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionPreviewTagVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'path':
          result.path.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
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

class _$GMentionPreviewPostVarsSerializer
    implements StructuredSerializer<GMentionPreviewPostVars> {
  @override
  final Iterable<Type> types = const [
    GMentionPreviewPostVars,
    _$GMentionPreviewPostVars
  ];
  @override
  final String wireName = 'GMentionPreviewPostVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMentionPreviewPostVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GMentionPreviewPostVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GMentionPreviewPostVarsBuilder().build();
  }
}

class _$GMentionPreviewUserVars extends GMentionPreviewUserVars {
  @override
  final String slug;
  @override
  final int? first;

  factory _$GMentionPreviewUserVars(
          [void Function(GMentionPreviewUserVarsBuilder)? updates]) =>
      (GMentionPreviewUserVarsBuilder()..update(updates))._build();

  _$GMentionPreviewUserVars._({required this.slug, this.first}) : super._();
  @override
  GMentionPreviewUserVars rebuild(
          void Function(GMentionPreviewUserVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionPreviewUserVarsBuilder toBuilder() =>
      GMentionPreviewUserVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionPreviewUserVars &&
        slug == other.slug &&
        first == other.first;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, first.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMentionPreviewUserVars')
          ..add('slug', slug)
          ..add('first', first))
        .toString();
  }
}

class GMentionPreviewUserVarsBuilder
    implements
        Builder<GMentionPreviewUserVars, GMentionPreviewUserVarsBuilder> {
  _$GMentionPreviewUserVars? _$v;

  String? _slug;
  String? get slug => _$this._slug;
  set slug(String? slug) => _$this._slug = slug;

  int? _first;
  int? get first => _$this._first;
  set first(int? first) => _$this._first = first;

  GMentionPreviewUserVarsBuilder();

  GMentionPreviewUserVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _slug = $v.slug;
      _first = $v.first;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMentionPreviewUserVars other) {
    _$v = other as _$GMentionPreviewUserVars;
  }

  @override
  void update(void Function(GMentionPreviewUserVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionPreviewUserVars build() => _build();

  _$GMentionPreviewUserVars _build() {
    final _$result = _$v ??
        _$GMentionPreviewUserVars._(
          slug: BuiltValueNullFieldError.checkNotNull(
              slug, r'GMentionPreviewUserVars', 'slug'),
          first: first,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GMentionPreviewTagVars extends GMentionPreviewTagVars {
  @override
  final BuiltList<String> path;
  @override
  final int? first;

  factory _$GMentionPreviewTagVars(
          [void Function(GMentionPreviewTagVarsBuilder)? updates]) =>
      (GMentionPreviewTagVarsBuilder()..update(updates))._build();

  _$GMentionPreviewTagVars._({required this.path, this.first}) : super._();
  @override
  GMentionPreviewTagVars rebuild(
          void Function(GMentionPreviewTagVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionPreviewTagVarsBuilder toBuilder() =>
      GMentionPreviewTagVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionPreviewTagVars &&
        path == other.path &&
        first == other.first;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jc(_$hash, first.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMentionPreviewTagVars')
          ..add('path', path)
          ..add('first', first))
        .toString();
  }
}

class GMentionPreviewTagVarsBuilder
    implements Builder<GMentionPreviewTagVars, GMentionPreviewTagVarsBuilder> {
  _$GMentionPreviewTagVars? _$v;

  ListBuilder<String>? _path;
  ListBuilder<String> get path => _$this._path ??= ListBuilder<String>();
  set path(ListBuilder<String>? path) => _$this._path = path;

  int? _first;
  int? get first => _$this._first;
  set first(int? first) => _$this._first = first;

  GMentionPreviewTagVarsBuilder();

  GMentionPreviewTagVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _path = $v.path.toBuilder();
      _first = $v.first;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMentionPreviewTagVars other) {
    _$v = other as _$GMentionPreviewTagVars;
  }

  @override
  void update(void Function(GMentionPreviewTagVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionPreviewTagVars build() => _build();

  _$GMentionPreviewTagVars _build() {
    _$GMentionPreviewTagVars _$result;
    try {
      _$result = _$v ??
          _$GMentionPreviewTagVars._(
            path: path.build(),
            first: first,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'path';
        path.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMentionPreviewTagVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMentionPreviewPostVars extends GMentionPreviewPostVars {
  factory _$GMentionPreviewPostVars(
          [void Function(GMentionPreviewPostVarsBuilder)? updates]) =>
      (GMentionPreviewPostVarsBuilder()..update(updates))._build();

  _$GMentionPreviewPostVars._() : super._();
  @override
  GMentionPreviewPostVars rebuild(
          void Function(GMentionPreviewPostVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionPreviewPostVarsBuilder toBuilder() =>
      GMentionPreviewPostVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionPreviewPostVars;
  }

  @override
  int get hashCode {
    return 791765718;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GMentionPreviewPostVars').toString();
  }
}

class GMentionPreviewPostVarsBuilder
    implements
        Builder<GMentionPreviewPostVars, GMentionPreviewPostVarsBuilder> {
  _$GMentionPreviewPostVars? _$v;

  GMentionPreviewPostVarsBuilder();

  @override
  void replace(GMentionPreviewPostVars other) {
    _$v = other as _$GMentionPreviewPostVars;
  }

  @override
  void update(void Function(GMentionPreviewPostVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionPreviewPostVars build() => _build();

  _$GMentionPreviewPostVars _build() {
    final _$result = _$v ?? _$GMentionPreviewPostVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
