// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mention_hover.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMentionHoverUserVars> _$gMentionHoverUserVarsSerializer =
    _$GMentionHoverUserVarsSerializer();
Serializer<GMentionHoverTagVars> _$gMentionHoverTagVarsSerializer =
    _$GMentionHoverTagVarsSerializer();

class _$GMentionHoverUserVarsSerializer
    implements StructuredSerializer<GMentionHoverUserVars> {
  @override
  final Iterable<Type> types = const [
    GMentionHoverUserVars,
    _$GMentionHoverUserVars
  ];
  @override
  final String wireName = 'GMentionHoverUserVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMentionHoverUserVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'slug',
      serializers.serialize(object.slug, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GMentionHoverUserVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionHoverUserVarsBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GMentionHoverTagVarsSerializer
    implements StructuredSerializer<GMentionHoverTagVars> {
  @override
  final Iterable<Type> types = const [
    GMentionHoverTagVars,
    _$GMentionHoverTagVars
  ];
  @override
  final String wireName = 'GMentionHoverTagVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMentionHoverTagVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'path',
      serializers.serialize(object.path,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  GMentionHoverTagVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionHoverTagVarsBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GMentionHoverUserVars extends GMentionHoverUserVars {
  @override
  final String slug;

  factory _$GMentionHoverUserVars(
          [void Function(GMentionHoverUserVarsBuilder)? updates]) =>
      (GMentionHoverUserVarsBuilder()..update(updates))._build();

  _$GMentionHoverUserVars._({required this.slug}) : super._();
  @override
  GMentionHoverUserVars rebuild(
          void Function(GMentionHoverUserVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionHoverUserVarsBuilder toBuilder() =>
      GMentionHoverUserVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionHoverUserVars && slug == other.slug;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMentionHoverUserVars')
          ..add('slug', slug))
        .toString();
  }
}

class GMentionHoverUserVarsBuilder
    implements Builder<GMentionHoverUserVars, GMentionHoverUserVarsBuilder> {
  _$GMentionHoverUserVars? _$v;

  String? _slug;
  String? get slug => _$this._slug;
  set slug(String? slug) => _$this._slug = slug;

  GMentionHoverUserVarsBuilder();

  GMentionHoverUserVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _slug = $v.slug;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMentionHoverUserVars other) {
    _$v = other as _$GMentionHoverUserVars;
  }

  @override
  void update(void Function(GMentionHoverUserVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionHoverUserVars build() => _build();

  _$GMentionHoverUserVars _build() {
    final _$result = _$v ??
        _$GMentionHoverUserVars._(
          slug: BuiltValueNullFieldError.checkNotNull(
              slug, r'GMentionHoverUserVars', 'slug'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GMentionHoverTagVars extends GMentionHoverTagVars {
  @override
  final BuiltList<String> path;

  factory _$GMentionHoverTagVars(
          [void Function(GMentionHoverTagVarsBuilder)? updates]) =>
      (GMentionHoverTagVarsBuilder()..update(updates))._build();

  _$GMentionHoverTagVars._({required this.path}) : super._();
  @override
  GMentionHoverTagVars rebuild(
          void Function(GMentionHoverTagVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionHoverTagVarsBuilder toBuilder() =>
      GMentionHoverTagVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionHoverTagVars && path == other.path;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMentionHoverTagVars')
          ..add('path', path))
        .toString();
  }
}

class GMentionHoverTagVarsBuilder
    implements Builder<GMentionHoverTagVars, GMentionHoverTagVarsBuilder> {
  _$GMentionHoverTagVars? _$v;

  ListBuilder<String>? _path;
  ListBuilder<String> get path => _$this._path ??= ListBuilder<String>();
  set path(ListBuilder<String>? path) => _$this._path = path;

  GMentionHoverTagVarsBuilder();

  GMentionHoverTagVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _path = $v.path.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMentionHoverTagVars other) {
    _$v = other as _$GMentionHoverTagVars;
  }

  @override
  void update(void Function(GMentionHoverTagVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionHoverTagVars build() => _build();

  _$GMentionHoverTagVars _build() {
    _$GMentionHoverTagVars _$result;
    try {
      _$result = _$v ??
          _$GMentionHoverTagVars._(
            path: path.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'path';
        path.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMentionHoverTagVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
