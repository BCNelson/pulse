// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GPostsForTagVars> _$gPostsForTagVarsSerializer =
    _$GPostsForTagVarsSerializer();
Serializer<GPostDetailVars> _$gPostDetailVarsSerializer =
    _$GPostDetailVarsSerializer();
Serializer<GCreatePostVars> _$gCreatePostVarsSerializer =
    _$GCreatePostVarsSerializer();
Serializer<GCreateCommentVars> _$gCreateCommentVarsSerializer =
    _$GCreateCommentVarsSerializer();
Serializer<GMarkPostReadVars> _$gMarkPostReadVarsSerializer =
    _$GMarkPostReadVarsSerializer();
Serializer<GReactToPostVars> _$gReactToPostVarsSerializer =
    _$GReactToPostVarsSerializer();
Serializer<GUnreactToPostVars> _$gUnreactToPostVarsSerializer =
    _$GUnreactToPostVarsSerializer();
Serializer<GPostChangedVars> _$gPostChangedVarsSerializer =
    _$GPostChangedVarsSerializer();
Serializer<GPostSummaryVars> _$gPostSummaryVarsSerializer =
    _$GPostSummaryVarsSerializer();
Serializer<GCommentSummaryVars> _$gCommentSummaryVarsSerializer =
    _$GCommentSummaryVarsSerializer();

class _$GPostsForTagVarsSerializer
    implements StructuredSerializer<GPostsForTagVars> {
  @override
  final Iterable<Type> types = const [GPostsForTagVars, _$GPostsForTagVars];
  @override
  final String wireName = 'GPostsForTagVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GPostsForTagVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'tagId',
      serializers.serialize(object.tagId,
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
  GPostsForTagVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostsForTagVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'tagId':
          result.tagId = serializers.deserialize(value,
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

class _$GPostDetailVarsSerializer
    implements StructuredSerializer<GPostDetailVars> {
  @override
  final Iterable<Type> types = const [GPostDetailVars, _$GPostDetailVars];
  @override
  final String wireName = 'GPostDetailVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GPostDetailVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GPostDetailVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostDetailVarsBuilder();

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

class _$GCreatePostVarsSerializer
    implements StructuredSerializer<GCreatePostVars> {
  @override
  final Iterable<Type> types = const [GCreatePostVars, _$GCreatePostVars];
  @override
  final String wireName = 'GCreatePostVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GCreatePostVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i2.GCreatePostInput)),
    ];

    return result;
  }

  @override
  GCreatePostVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreatePostVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GCreatePostInput))!
              as _i2.GCreatePostInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateCommentVarsSerializer
    implements StructuredSerializer<GCreateCommentVars> {
  @override
  final Iterable<Type> types = const [GCreateCommentVars, _$GCreateCommentVars];
  @override
  final String wireName = 'GCreateCommentVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateCommentVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i2.GCreateCommentInput)),
    ];

    return result;
  }

  @override
  GCreateCommentVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreateCommentVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GCreateCommentInput))!
              as _i2.GCreateCommentInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GMarkPostReadVarsSerializer
    implements StructuredSerializer<GMarkPostReadVars> {
  @override
  final Iterable<Type> types = const [GMarkPostReadVars, _$GMarkPostReadVars];
  @override
  final String wireName = 'GMarkPostReadVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GMarkPostReadVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'postId',
      serializers.serialize(object.postId,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.seenAt;
    if (value != null) {
      result
        ..add('seenAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GTime)));
    }
    return result;
  }

  @override
  GMarkPostReadVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMarkPostReadVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'postId':
          result.postId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'seenAt':
          result.seenAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
      }
    }

    return result.build();
  }
}

class _$GReactToPostVarsSerializer
    implements StructuredSerializer<GReactToPostVars> {
  @override
  final Iterable<Type> types = const [GReactToPostVars, _$GReactToPostVars];
  @override
  final String wireName = 'GReactToPostVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GReactToPostVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'postId',
      serializers.serialize(object.postId,
          specifiedType: const FullType(String)),
      'emoji',
      serializers.serialize(object.emoji,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GReactToPostVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GReactToPostVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'postId':
          result.postId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'emoji':
          result.emoji = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GUnreactToPostVarsSerializer
    implements StructuredSerializer<GUnreactToPostVars> {
  @override
  final Iterable<Type> types = const [GUnreactToPostVars, _$GUnreactToPostVars];
  @override
  final String wireName = 'GUnreactToPostVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUnreactToPostVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'postId',
      serializers.serialize(object.postId,
          specifiedType: const FullType(String)),
      'emoji',
      serializers.serialize(object.emoji,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GUnreactToPostVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUnreactToPostVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'postId':
          result.postId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'emoji':
          result.emoji = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GPostChangedVarsSerializer
    implements StructuredSerializer<GPostChangedVars> {
  @override
  final Iterable<Type> types = const [GPostChangedVars, _$GPostChangedVars];
  @override
  final String wireName = 'GPostChangedVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GPostChangedVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'tagId',
      serializers.serialize(object.tagId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GPostChangedVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostChangedVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'tagId':
          result.tagId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GPostSummaryVarsSerializer
    implements StructuredSerializer<GPostSummaryVars> {
  @override
  final Iterable<Type> types = const [GPostSummaryVars, _$GPostSummaryVars];
  @override
  final String wireName = 'GPostSummaryVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GPostSummaryVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GPostSummaryVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GPostSummaryVarsBuilder().build();
  }
}

class _$GCommentSummaryVarsSerializer
    implements StructuredSerializer<GCommentSummaryVars> {
  @override
  final Iterable<Type> types = const [
    GCommentSummaryVars,
    _$GCommentSummaryVars
  ];
  @override
  final String wireName = 'GCommentSummaryVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCommentSummaryVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GCommentSummaryVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GCommentSummaryVarsBuilder().build();
  }
}

class _$GPostsForTagVars extends GPostsForTagVars {
  @override
  final String tagId;
  @override
  final int? first;

  factory _$GPostsForTagVars(
          [void Function(GPostsForTagVarsBuilder)? updates]) =>
      (GPostsForTagVarsBuilder()..update(updates))._build();

  _$GPostsForTagVars._({required this.tagId, this.first}) : super._();
  @override
  GPostsForTagVars rebuild(void Function(GPostsForTagVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostsForTagVarsBuilder toBuilder() =>
      GPostsForTagVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostsForTagVars &&
        tagId == other.tagId &&
        first == other.first;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tagId.hashCode);
    _$hash = $jc(_$hash, first.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostsForTagVars')
          ..add('tagId', tagId)
          ..add('first', first))
        .toString();
  }
}

class GPostsForTagVarsBuilder
    implements Builder<GPostsForTagVars, GPostsForTagVarsBuilder> {
  _$GPostsForTagVars? _$v;

  String? _tagId;
  String? get tagId => _$this._tagId;
  set tagId(String? tagId) => _$this._tagId = tagId;

  int? _first;
  int? get first => _$this._first;
  set first(int? first) => _$this._first = first;

  GPostsForTagVarsBuilder();

  GPostsForTagVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tagId = $v.tagId;
      _first = $v.first;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostsForTagVars other) {
    _$v = other as _$GPostsForTagVars;
  }

  @override
  void update(void Function(GPostsForTagVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostsForTagVars build() => _build();

  _$GPostsForTagVars _build() {
    final _$result = _$v ??
        _$GPostsForTagVars._(
          tagId: BuiltValueNullFieldError.checkNotNull(
              tagId, r'GPostsForTagVars', 'tagId'),
          first: first,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GPostDetailVars extends GPostDetailVars {
  @override
  final String id;

  factory _$GPostDetailVars([void Function(GPostDetailVarsBuilder)? updates]) =>
      (GPostDetailVarsBuilder()..update(updates))._build();

  _$GPostDetailVars._({required this.id}) : super._();
  @override
  GPostDetailVars rebuild(void Function(GPostDetailVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostDetailVarsBuilder toBuilder() => GPostDetailVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostDetailVars && id == other.id;
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
    return (newBuiltValueToStringHelper(r'GPostDetailVars')..add('id', id))
        .toString();
  }
}

class GPostDetailVarsBuilder
    implements Builder<GPostDetailVars, GPostDetailVarsBuilder> {
  _$GPostDetailVars? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GPostDetailVarsBuilder();

  GPostDetailVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostDetailVars other) {
    _$v = other as _$GPostDetailVars;
  }

  @override
  void update(void Function(GPostDetailVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostDetailVars build() => _build();

  _$GPostDetailVars _build() {
    final _$result = _$v ??
        _$GPostDetailVars._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GPostDetailVars', 'id'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCreatePostVars extends GCreatePostVars {
  @override
  final _i2.GCreatePostInput input;

  factory _$GCreatePostVars([void Function(GCreatePostVarsBuilder)? updates]) =>
      (GCreatePostVarsBuilder()..update(updates))._build();

  _$GCreatePostVars._({required this.input}) : super._();
  @override
  GCreatePostVars rebuild(void Function(GCreatePostVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreatePostVarsBuilder toBuilder() => GCreatePostVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreatePostVars && input == other.input;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, input.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreatePostVars')
          ..add('input', input))
        .toString();
  }
}

class GCreatePostVarsBuilder
    implements Builder<GCreatePostVars, GCreatePostVarsBuilder> {
  _$GCreatePostVars? _$v;

  _i2.GCreatePostInputBuilder? _input;
  _i2.GCreatePostInputBuilder get input =>
      _$this._input ??= _i2.GCreatePostInputBuilder();
  set input(_i2.GCreatePostInputBuilder? input) => _$this._input = input;

  GCreatePostVarsBuilder();

  GCreatePostVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreatePostVars other) {
    _$v = other as _$GCreatePostVars;
  }

  @override
  void update(void Function(GCreatePostVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreatePostVars build() => _build();

  _$GCreatePostVars _build() {
    _$GCreatePostVars _$result;
    try {
      _$result = _$v ??
          _$GCreatePostVars._(
            input: input.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GCreatePostVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateCommentVars extends GCreateCommentVars {
  @override
  final _i2.GCreateCommentInput input;

  factory _$GCreateCommentVars(
          [void Function(GCreateCommentVarsBuilder)? updates]) =>
      (GCreateCommentVarsBuilder()..update(updates))._build();

  _$GCreateCommentVars._({required this.input}) : super._();
  @override
  GCreateCommentVars rebuild(
          void Function(GCreateCommentVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateCommentVarsBuilder toBuilder() =>
      GCreateCommentVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateCommentVars && input == other.input;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, input.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateCommentVars')
          ..add('input', input))
        .toString();
  }
}

class GCreateCommentVarsBuilder
    implements Builder<GCreateCommentVars, GCreateCommentVarsBuilder> {
  _$GCreateCommentVars? _$v;

  _i2.GCreateCommentInputBuilder? _input;
  _i2.GCreateCommentInputBuilder get input =>
      _$this._input ??= _i2.GCreateCommentInputBuilder();
  set input(_i2.GCreateCommentInputBuilder? input) => _$this._input = input;

  GCreateCommentVarsBuilder();

  GCreateCommentVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateCommentVars other) {
    _$v = other as _$GCreateCommentVars;
  }

  @override
  void update(void Function(GCreateCommentVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateCommentVars build() => _build();

  _$GCreateCommentVars _build() {
    _$GCreateCommentVars _$result;
    try {
      _$result = _$v ??
          _$GCreateCommentVars._(
            input: input.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GCreateCommentVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMarkPostReadVars extends GMarkPostReadVars {
  @override
  final String postId;
  @override
  final _i2.GTime? seenAt;

  factory _$GMarkPostReadVars(
          [void Function(GMarkPostReadVarsBuilder)? updates]) =>
      (GMarkPostReadVarsBuilder()..update(updates))._build();

  _$GMarkPostReadVars._({required this.postId, this.seenAt}) : super._();
  @override
  GMarkPostReadVars rebuild(void Function(GMarkPostReadVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMarkPostReadVarsBuilder toBuilder() =>
      GMarkPostReadVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkPostReadVars &&
        postId == other.postId &&
        seenAt == other.seenAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, postId.hashCode);
    _$hash = $jc(_$hash, seenAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMarkPostReadVars')
          ..add('postId', postId)
          ..add('seenAt', seenAt))
        .toString();
  }
}

class GMarkPostReadVarsBuilder
    implements Builder<GMarkPostReadVars, GMarkPostReadVarsBuilder> {
  _$GMarkPostReadVars? _$v;

  String? _postId;
  String? get postId => _$this._postId;
  set postId(String? postId) => _$this._postId = postId;

  _i2.GTimeBuilder? _seenAt;
  _i2.GTimeBuilder get seenAt => _$this._seenAt ??= _i2.GTimeBuilder();
  set seenAt(_i2.GTimeBuilder? seenAt) => _$this._seenAt = seenAt;

  GMarkPostReadVarsBuilder();

  GMarkPostReadVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _postId = $v.postId;
      _seenAt = $v.seenAt?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMarkPostReadVars other) {
    _$v = other as _$GMarkPostReadVars;
  }

  @override
  void update(void Function(GMarkPostReadVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMarkPostReadVars build() => _build();

  _$GMarkPostReadVars _build() {
    _$GMarkPostReadVars _$result;
    try {
      _$result = _$v ??
          _$GMarkPostReadVars._(
            postId: BuiltValueNullFieldError.checkNotNull(
                postId, r'GMarkPostReadVars', 'postId'),
            seenAt: _seenAt?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'seenAt';
        _seenAt?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMarkPostReadVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GReactToPostVars extends GReactToPostVars {
  @override
  final String postId;
  @override
  final String emoji;

  factory _$GReactToPostVars(
          [void Function(GReactToPostVarsBuilder)? updates]) =>
      (GReactToPostVarsBuilder()..update(updates))._build();

  _$GReactToPostVars._({required this.postId, required this.emoji}) : super._();
  @override
  GReactToPostVars rebuild(void Function(GReactToPostVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GReactToPostVarsBuilder toBuilder() =>
      GReactToPostVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReactToPostVars &&
        postId == other.postId &&
        emoji == other.emoji;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, postId.hashCode);
    _$hash = $jc(_$hash, emoji.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GReactToPostVars')
          ..add('postId', postId)
          ..add('emoji', emoji))
        .toString();
  }
}

class GReactToPostVarsBuilder
    implements Builder<GReactToPostVars, GReactToPostVarsBuilder> {
  _$GReactToPostVars? _$v;

  String? _postId;
  String? get postId => _$this._postId;
  set postId(String? postId) => _$this._postId = postId;

  String? _emoji;
  String? get emoji => _$this._emoji;
  set emoji(String? emoji) => _$this._emoji = emoji;

  GReactToPostVarsBuilder();

  GReactToPostVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _postId = $v.postId;
      _emoji = $v.emoji;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GReactToPostVars other) {
    _$v = other as _$GReactToPostVars;
  }

  @override
  void update(void Function(GReactToPostVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GReactToPostVars build() => _build();

  _$GReactToPostVars _build() {
    final _$result = _$v ??
        _$GReactToPostVars._(
          postId: BuiltValueNullFieldError.checkNotNull(
              postId, r'GReactToPostVars', 'postId'),
          emoji: BuiltValueNullFieldError.checkNotNull(
              emoji, r'GReactToPostVars', 'emoji'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GUnreactToPostVars extends GUnreactToPostVars {
  @override
  final String postId;
  @override
  final String emoji;

  factory _$GUnreactToPostVars(
          [void Function(GUnreactToPostVarsBuilder)? updates]) =>
      (GUnreactToPostVarsBuilder()..update(updates))._build();

  _$GUnreactToPostVars._({required this.postId, required this.emoji})
      : super._();
  @override
  GUnreactToPostVars rebuild(
          void Function(GUnreactToPostVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUnreactToPostVarsBuilder toBuilder() =>
      GUnreactToPostVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUnreactToPostVars &&
        postId == other.postId &&
        emoji == other.emoji;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, postId.hashCode);
    _$hash = $jc(_$hash, emoji.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUnreactToPostVars')
          ..add('postId', postId)
          ..add('emoji', emoji))
        .toString();
  }
}

class GUnreactToPostVarsBuilder
    implements Builder<GUnreactToPostVars, GUnreactToPostVarsBuilder> {
  _$GUnreactToPostVars? _$v;

  String? _postId;
  String? get postId => _$this._postId;
  set postId(String? postId) => _$this._postId = postId;

  String? _emoji;
  String? get emoji => _$this._emoji;
  set emoji(String? emoji) => _$this._emoji = emoji;

  GUnreactToPostVarsBuilder();

  GUnreactToPostVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _postId = $v.postId;
      _emoji = $v.emoji;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUnreactToPostVars other) {
    _$v = other as _$GUnreactToPostVars;
  }

  @override
  void update(void Function(GUnreactToPostVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUnreactToPostVars build() => _build();

  _$GUnreactToPostVars _build() {
    final _$result = _$v ??
        _$GUnreactToPostVars._(
          postId: BuiltValueNullFieldError.checkNotNull(
              postId, r'GUnreactToPostVars', 'postId'),
          emoji: BuiltValueNullFieldError.checkNotNull(
              emoji, r'GUnreactToPostVars', 'emoji'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GPostChangedVars extends GPostChangedVars {
  @override
  final String tagId;

  factory _$GPostChangedVars(
          [void Function(GPostChangedVarsBuilder)? updates]) =>
      (GPostChangedVarsBuilder()..update(updates))._build();

  _$GPostChangedVars._({required this.tagId}) : super._();
  @override
  GPostChangedVars rebuild(void Function(GPostChangedVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostChangedVarsBuilder toBuilder() =>
      GPostChangedVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostChangedVars && tagId == other.tagId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tagId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostChangedVars')
          ..add('tagId', tagId))
        .toString();
  }
}

class GPostChangedVarsBuilder
    implements Builder<GPostChangedVars, GPostChangedVarsBuilder> {
  _$GPostChangedVars? _$v;

  String? _tagId;
  String? get tagId => _$this._tagId;
  set tagId(String? tagId) => _$this._tagId = tagId;

  GPostChangedVarsBuilder();

  GPostChangedVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tagId = $v.tagId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostChangedVars other) {
    _$v = other as _$GPostChangedVars;
  }

  @override
  void update(void Function(GPostChangedVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostChangedVars build() => _build();

  _$GPostChangedVars _build() {
    final _$result = _$v ??
        _$GPostChangedVars._(
          tagId: BuiltValueNullFieldError.checkNotNull(
              tagId, r'GPostChangedVars', 'tagId'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GPostSummaryVars extends GPostSummaryVars {
  factory _$GPostSummaryVars(
          [void Function(GPostSummaryVarsBuilder)? updates]) =>
      (GPostSummaryVarsBuilder()..update(updates))._build();

  _$GPostSummaryVars._() : super._();
  @override
  GPostSummaryVars rebuild(void Function(GPostSummaryVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostSummaryVarsBuilder toBuilder() =>
      GPostSummaryVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostSummaryVars;
  }

  @override
  int get hashCode {
    return 950405441;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GPostSummaryVars').toString();
  }
}

class GPostSummaryVarsBuilder
    implements Builder<GPostSummaryVars, GPostSummaryVarsBuilder> {
  _$GPostSummaryVars? _$v;

  GPostSummaryVarsBuilder();

  @override
  void replace(GPostSummaryVars other) {
    _$v = other as _$GPostSummaryVars;
  }

  @override
  void update(void Function(GPostSummaryVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostSummaryVars build() => _build();

  _$GPostSummaryVars _build() {
    final _$result = _$v ?? _$GPostSummaryVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GCommentSummaryVars extends GCommentSummaryVars {
  factory _$GCommentSummaryVars(
          [void Function(GCommentSummaryVarsBuilder)? updates]) =>
      (GCommentSummaryVarsBuilder()..update(updates))._build();

  _$GCommentSummaryVars._() : super._();
  @override
  GCommentSummaryVars rebuild(
          void Function(GCommentSummaryVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCommentSummaryVarsBuilder toBuilder() =>
      GCommentSummaryVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCommentSummaryVars;
  }

  @override
  int get hashCode {
    return 192038530;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GCommentSummaryVars').toString();
  }
}

class GCommentSummaryVarsBuilder
    implements Builder<GCommentSummaryVars, GCommentSummaryVarsBuilder> {
  _$GCommentSummaryVars? _$v;

  GCommentSummaryVarsBuilder();

  @override
  void replace(GCommentSummaryVars other) {
    _$v = other as _$GCommentSummaryVars;
  }

  @override
  void update(void Function(GCommentSummaryVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCommentSummaryVars build() => _build();

  _$GCommentSummaryVars _build() {
    final _$result = _$v ?? _$GCommentSummaryVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
