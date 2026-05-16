// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mention_hover.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMentionHoverUserData> _$gMentionHoverUserDataSerializer =
    _$GMentionHoverUserDataSerializer();
Serializer<GMentionHoverUserData_userByHandle>
    _$gMentionHoverUserDataUserByHandleSerializer =
    _$GMentionHoverUserData_userByHandleSerializer();
Serializer<GMentionHoverUserData_userByHandle_homeTag>
    _$gMentionHoverUserDataUserByHandleHomeTagSerializer =
    _$GMentionHoverUserData_userByHandle_homeTagSerializer();
Serializer<GMentionHoverTagData> _$gMentionHoverTagDataSerializer =
    _$GMentionHoverTagDataSerializer();
Serializer<GMentionHoverTagData_tagBySlugPath>
    _$gMentionHoverTagDataTagBySlugPathSerializer =
    _$GMentionHoverTagData_tagBySlugPathSerializer();
Serializer<GMentionHoverTagData_tagBySlugPath_parent>
    _$gMentionHoverTagDataTagBySlugPathParentSerializer =
    _$GMentionHoverTagData_tagBySlugPath_parentSerializer();

class _$GMentionHoverUserDataSerializer
    implements StructuredSerializer<GMentionHoverUserData> {
  @override
  final Iterable<Type> types = const [
    GMentionHoverUserData,
    _$GMentionHoverUserData
  ];
  @override
  final String wireName = 'GMentionHoverUserData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMentionHoverUserData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.userByHandle;
    if (value != null) {
      result
        ..add('userByHandle')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GMentionHoverUserData_userByHandle)));
    }
    return result;
  }

  @override
  GMentionHoverUserData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionHoverUserDataBuilder();

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
        case 'userByHandle':
          result.userByHandle.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GMentionHoverUserData_userByHandle))!
              as GMentionHoverUserData_userByHandle);
          break;
      }
    }

    return result.build();
  }
}

class _$GMentionHoverUserData_userByHandleSerializer
    implements StructuredSerializer<GMentionHoverUserData_userByHandle> {
  @override
  final Iterable<Type> types = const [
    GMentionHoverUserData_userByHandle,
    _$GMentionHoverUserData_userByHandle
  ];
  @override
  final String wireName = 'GMentionHoverUserData_userByHandle';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMentionHoverUserData_userByHandle object,
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
    value = object.homeTag;
    if (value != null) {
      result
        ..add('homeTag')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GMentionHoverUserData_userByHandle_homeTag)));
    }
    return result;
  }

  @override
  GMentionHoverUserData_userByHandle deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionHoverUserData_userByHandleBuilder();

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
        case 'homeTag':
          result.homeTag.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GMentionHoverUserData_userByHandle_homeTag))!
              as GMentionHoverUserData_userByHandle_homeTag);
          break;
      }
    }

    return result.build();
  }
}

class _$GMentionHoverUserData_userByHandle_homeTagSerializer
    implements
        StructuredSerializer<GMentionHoverUserData_userByHandle_homeTag> {
  @override
  final Iterable<Type> types = const [
    GMentionHoverUserData_userByHandle_homeTag,
    _$GMentionHoverUserData_userByHandle_homeTag
  ];
  @override
  final String wireName = 'GMentionHoverUserData_userByHandle_homeTag';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GMentionHoverUserData_userByHandle_homeTag object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'slug',
      serializers.serialize(object.slug, specifiedType: const FullType(String)),
      'path',
      serializers.serialize(object.path, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GMentionHoverUserData_userByHandle_homeTag deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionHoverUserData_userByHandle_homeTagBuilder();

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
        case 'slug':
          result.slug = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'path':
          result.path = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GMentionHoverTagDataSerializer
    implements StructuredSerializer<GMentionHoverTagData> {
  @override
  final Iterable<Type> types = const [
    GMentionHoverTagData,
    _$GMentionHoverTagData
  ];
  @override
  final String wireName = 'GMentionHoverTagData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMentionHoverTagData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.tagBySlugPath;
    if (value != null) {
      result
        ..add('tagBySlugPath')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GMentionHoverTagData_tagBySlugPath)));
    }
    return result;
  }

  @override
  GMentionHoverTagData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionHoverTagDataBuilder();

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
        case 'tagBySlugPath':
          result.tagBySlugPath.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GMentionHoverTagData_tagBySlugPath))!
              as GMentionHoverTagData_tagBySlugPath);
          break;
      }
    }

    return result.build();
  }
}

class _$GMentionHoverTagData_tagBySlugPathSerializer
    implements StructuredSerializer<GMentionHoverTagData_tagBySlugPath> {
  @override
  final Iterable<Type> types = const [
    GMentionHoverTagData_tagBySlugPath,
    _$GMentionHoverTagData_tagBySlugPath
  ];
  @override
  final String wireName = 'GMentionHoverTagData_tagBySlugPath';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMentionHoverTagData_tagBySlugPath object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'slug',
      serializers.serialize(object.slug, specifiedType: const FullType(String)),
      'displayName',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
      'path',
      serializers.serialize(object.path, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.parent;
    if (value != null) {
      result
        ..add('parent')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GMentionHoverTagData_tagBySlugPath_parent)));
    }
    return result;
  }

  @override
  GMentionHoverTagData_tagBySlugPath deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionHoverTagData_tagBySlugPathBuilder();

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
        case 'slug':
          result.slug = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'displayName':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'path':
          result.path = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'parent':
          result.parent.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GMentionHoverTagData_tagBySlugPath_parent))!
              as GMentionHoverTagData_tagBySlugPath_parent);
          break;
      }
    }

    return result.build();
  }
}

class _$GMentionHoverTagData_tagBySlugPath_parentSerializer
    implements StructuredSerializer<GMentionHoverTagData_tagBySlugPath_parent> {
  @override
  final Iterable<Type> types = const [
    GMentionHoverTagData_tagBySlugPath_parent,
    _$GMentionHoverTagData_tagBySlugPath_parent
  ];
  @override
  final String wireName = 'GMentionHoverTagData_tagBySlugPath_parent';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMentionHoverTagData_tagBySlugPath_parent object,
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

    return result;
  }

  @override
  GMentionHoverTagData_tagBySlugPath_parent deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionHoverTagData_tagBySlugPath_parentBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GMentionHoverUserData extends GMentionHoverUserData {
  @override
  final String G__typename;
  @override
  final GMentionHoverUserData_userByHandle? userByHandle;

  factory _$GMentionHoverUserData(
          [void Function(GMentionHoverUserDataBuilder)? updates]) =>
      (GMentionHoverUserDataBuilder()..update(updates))._build();

  _$GMentionHoverUserData._({required this.G__typename, this.userByHandle})
      : super._();
  @override
  GMentionHoverUserData rebuild(
          void Function(GMentionHoverUserDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionHoverUserDataBuilder toBuilder() =>
      GMentionHoverUserDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionHoverUserData &&
        G__typename == other.G__typename &&
        userByHandle == other.userByHandle;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, userByHandle.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMentionHoverUserData')
          ..add('G__typename', G__typename)
          ..add('userByHandle', userByHandle))
        .toString();
  }
}

class GMentionHoverUserDataBuilder
    implements Builder<GMentionHoverUserData, GMentionHoverUserDataBuilder> {
  _$GMentionHoverUserData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GMentionHoverUserData_userByHandleBuilder? _userByHandle;
  GMentionHoverUserData_userByHandleBuilder get userByHandle =>
      _$this._userByHandle ??= GMentionHoverUserData_userByHandleBuilder();
  set userByHandle(GMentionHoverUserData_userByHandleBuilder? userByHandle) =>
      _$this._userByHandle = userByHandle;

  GMentionHoverUserDataBuilder() {
    GMentionHoverUserData._initializeBuilder(this);
  }

  GMentionHoverUserDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _userByHandle = $v.userByHandle?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMentionHoverUserData other) {
    _$v = other as _$GMentionHoverUserData;
  }

  @override
  void update(void Function(GMentionHoverUserDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionHoverUserData build() => _build();

  _$GMentionHoverUserData _build() {
    _$GMentionHoverUserData _$result;
    try {
      _$result = _$v ??
          _$GMentionHoverUserData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GMentionHoverUserData', 'G__typename'),
            userByHandle: _userByHandle?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'userByHandle';
        _userByHandle?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMentionHoverUserData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMentionHoverUserData_userByHandle
    extends GMentionHoverUserData_userByHandle {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;
  @override
  final GMentionHoverUserData_userByHandle_homeTag? homeTag;

  factory _$GMentionHoverUserData_userByHandle(
          [void Function(GMentionHoverUserData_userByHandleBuilder)?
              updates]) =>
      (GMentionHoverUserData_userByHandleBuilder()..update(updates))._build();

  _$GMentionHoverUserData_userByHandle._(
      {required this.G__typename,
      required this.id,
      required this.displayName,
      this.homeTag})
      : super._();
  @override
  GMentionHoverUserData_userByHandle rebuild(
          void Function(GMentionHoverUserData_userByHandleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionHoverUserData_userByHandleBuilder toBuilder() =>
      GMentionHoverUserData_userByHandleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionHoverUserData_userByHandle &&
        G__typename == other.G__typename &&
        id == other.id &&
        displayName == other.displayName &&
        homeTag == other.homeTag;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, homeTag.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMentionHoverUserData_userByHandle')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName)
          ..add('homeTag', homeTag))
        .toString();
  }
}

class GMentionHoverUserData_userByHandleBuilder
    implements
        Builder<GMentionHoverUserData_userByHandle,
            GMentionHoverUserData_userByHandleBuilder> {
  _$GMentionHoverUserData_userByHandle? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GMentionHoverUserData_userByHandle_homeTagBuilder? _homeTag;
  GMentionHoverUserData_userByHandle_homeTagBuilder get homeTag =>
      _$this._homeTag ??= GMentionHoverUserData_userByHandle_homeTagBuilder();
  set homeTag(GMentionHoverUserData_userByHandle_homeTagBuilder? homeTag) =>
      _$this._homeTag = homeTag;

  GMentionHoverUserData_userByHandleBuilder() {
    GMentionHoverUserData_userByHandle._initializeBuilder(this);
  }

  GMentionHoverUserData_userByHandleBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _displayName = $v.displayName;
      _homeTag = $v.homeTag?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMentionHoverUserData_userByHandle other) {
    _$v = other as _$GMentionHoverUserData_userByHandle;
  }

  @override
  void update(
      void Function(GMentionHoverUserData_userByHandleBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionHoverUserData_userByHandle build() => _build();

  _$GMentionHoverUserData_userByHandle _build() {
    _$GMentionHoverUserData_userByHandle _$result;
    try {
      _$result = _$v ??
          _$GMentionHoverUserData_userByHandle._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GMentionHoverUserData_userByHandle', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GMentionHoverUserData_userByHandle', 'id'),
            displayName: BuiltValueNullFieldError.checkNotNull(displayName,
                r'GMentionHoverUserData_userByHandle', 'displayName'),
            homeTag: _homeTag?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'homeTag';
        _homeTag?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMentionHoverUserData_userByHandle', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMentionHoverUserData_userByHandle_homeTag
    extends GMentionHoverUserData_userByHandle_homeTag {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String slug;
  @override
  final String path;

  factory _$GMentionHoverUserData_userByHandle_homeTag(
          [void Function(GMentionHoverUserData_userByHandle_homeTagBuilder)?
              updates]) =>
      (GMentionHoverUserData_userByHandle_homeTagBuilder()..update(updates))
          ._build();

  _$GMentionHoverUserData_userByHandle_homeTag._(
      {required this.G__typename,
      required this.id,
      required this.slug,
      required this.path})
      : super._();
  @override
  GMentionHoverUserData_userByHandle_homeTag rebuild(
          void Function(GMentionHoverUserData_userByHandle_homeTagBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionHoverUserData_userByHandle_homeTagBuilder toBuilder() =>
      GMentionHoverUserData_userByHandle_homeTagBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionHoverUserData_userByHandle_homeTag &&
        G__typename == other.G__typename &&
        id == other.id &&
        slug == other.slug &&
        path == other.path;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GMentionHoverUserData_userByHandle_homeTag')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('slug', slug)
          ..add('path', path))
        .toString();
  }
}

class GMentionHoverUserData_userByHandle_homeTagBuilder
    implements
        Builder<GMentionHoverUserData_userByHandle_homeTag,
            GMentionHoverUserData_userByHandle_homeTagBuilder> {
  _$GMentionHoverUserData_userByHandle_homeTag? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _slug;
  String? get slug => _$this._slug;
  set slug(String? slug) => _$this._slug = slug;

  String? _path;
  String? get path => _$this._path;
  set path(String? path) => _$this._path = path;

  GMentionHoverUserData_userByHandle_homeTagBuilder() {
    GMentionHoverUserData_userByHandle_homeTag._initializeBuilder(this);
  }

  GMentionHoverUserData_userByHandle_homeTagBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _slug = $v.slug;
      _path = $v.path;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMentionHoverUserData_userByHandle_homeTag other) {
    _$v = other as _$GMentionHoverUserData_userByHandle_homeTag;
  }

  @override
  void update(
      void Function(GMentionHoverUserData_userByHandle_homeTagBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionHoverUserData_userByHandle_homeTag build() => _build();

  _$GMentionHoverUserData_userByHandle_homeTag _build() {
    final _$result = _$v ??
        _$GMentionHoverUserData_userByHandle_homeTag._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GMentionHoverUserData_userByHandle_homeTag', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GMentionHoverUserData_userByHandle_homeTag', 'id'),
          slug: BuiltValueNullFieldError.checkNotNull(
              slug, r'GMentionHoverUserData_userByHandle_homeTag', 'slug'),
          path: BuiltValueNullFieldError.checkNotNull(
              path, r'GMentionHoverUserData_userByHandle_homeTag', 'path'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GMentionHoverTagData extends GMentionHoverTagData {
  @override
  final String G__typename;
  @override
  final GMentionHoverTagData_tagBySlugPath? tagBySlugPath;

  factory _$GMentionHoverTagData(
          [void Function(GMentionHoverTagDataBuilder)? updates]) =>
      (GMentionHoverTagDataBuilder()..update(updates))._build();

  _$GMentionHoverTagData._({required this.G__typename, this.tagBySlugPath})
      : super._();
  @override
  GMentionHoverTagData rebuild(
          void Function(GMentionHoverTagDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionHoverTagDataBuilder toBuilder() =>
      GMentionHoverTagDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionHoverTagData &&
        G__typename == other.G__typename &&
        tagBySlugPath == other.tagBySlugPath;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, tagBySlugPath.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMentionHoverTagData')
          ..add('G__typename', G__typename)
          ..add('tagBySlugPath', tagBySlugPath))
        .toString();
  }
}

class GMentionHoverTagDataBuilder
    implements Builder<GMentionHoverTagData, GMentionHoverTagDataBuilder> {
  _$GMentionHoverTagData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GMentionHoverTagData_tagBySlugPathBuilder? _tagBySlugPath;
  GMentionHoverTagData_tagBySlugPathBuilder get tagBySlugPath =>
      _$this._tagBySlugPath ??= GMentionHoverTagData_tagBySlugPathBuilder();
  set tagBySlugPath(GMentionHoverTagData_tagBySlugPathBuilder? tagBySlugPath) =>
      _$this._tagBySlugPath = tagBySlugPath;

  GMentionHoverTagDataBuilder() {
    GMentionHoverTagData._initializeBuilder(this);
  }

  GMentionHoverTagDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _tagBySlugPath = $v.tagBySlugPath?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMentionHoverTagData other) {
    _$v = other as _$GMentionHoverTagData;
  }

  @override
  void update(void Function(GMentionHoverTagDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionHoverTagData build() => _build();

  _$GMentionHoverTagData _build() {
    _$GMentionHoverTagData _$result;
    try {
      _$result = _$v ??
          _$GMentionHoverTagData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GMentionHoverTagData', 'G__typename'),
            tagBySlugPath: _tagBySlugPath?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tagBySlugPath';
        _tagBySlugPath?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMentionHoverTagData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMentionHoverTagData_tagBySlugPath
    extends GMentionHoverTagData_tagBySlugPath {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String slug;
  @override
  final String displayName;
  @override
  final String path;
  @override
  final GMentionHoverTagData_tagBySlugPath_parent? parent;

  factory _$GMentionHoverTagData_tagBySlugPath(
          [void Function(GMentionHoverTagData_tagBySlugPathBuilder)?
              updates]) =>
      (GMentionHoverTagData_tagBySlugPathBuilder()..update(updates))._build();

  _$GMentionHoverTagData_tagBySlugPath._(
      {required this.G__typename,
      required this.id,
      required this.slug,
      required this.displayName,
      required this.path,
      this.parent})
      : super._();
  @override
  GMentionHoverTagData_tagBySlugPath rebuild(
          void Function(GMentionHoverTagData_tagBySlugPathBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionHoverTagData_tagBySlugPathBuilder toBuilder() =>
      GMentionHoverTagData_tagBySlugPathBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionHoverTagData_tagBySlugPath &&
        G__typename == other.G__typename &&
        id == other.id &&
        slug == other.slug &&
        displayName == other.displayName &&
        path == other.path &&
        parent == other.parent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jc(_$hash, parent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMentionHoverTagData_tagBySlugPath')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('slug', slug)
          ..add('displayName', displayName)
          ..add('path', path)
          ..add('parent', parent))
        .toString();
  }
}

class GMentionHoverTagData_tagBySlugPathBuilder
    implements
        Builder<GMentionHoverTagData_tagBySlugPath,
            GMentionHoverTagData_tagBySlugPathBuilder> {
  _$GMentionHoverTagData_tagBySlugPath? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _slug;
  String? get slug => _$this._slug;
  set slug(String? slug) => _$this._slug = slug;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _path;
  String? get path => _$this._path;
  set path(String? path) => _$this._path = path;

  GMentionHoverTagData_tagBySlugPath_parentBuilder? _parent;
  GMentionHoverTagData_tagBySlugPath_parentBuilder get parent =>
      _$this._parent ??= GMentionHoverTagData_tagBySlugPath_parentBuilder();
  set parent(GMentionHoverTagData_tagBySlugPath_parentBuilder? parent) =>
      _$this._parent = parent;

  GMentionHoverTagData_tagBySlugPathBuilder() {
    GMentionHoverTagData_tagBySlugPath._initializeBuilder(this);
  }

  GMentionHoverTagData_tagBySlugPathBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _slug = $v.slug;
      _displayName = $v.displayName;
      _path = $v.path;
      _parent = $v.parent?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMentionHoverTagData_tagBySlugPath other) {
    _$v = other as _$GMentionHoverTagData_tagBySlugPath;
  }

  @override
  void update(
      void Function(GMentionHoverTagData_tagBySlugPathBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionHoverTagData_tagBySlugPath build() => _build();

  _$GMentionHoverTagData_tagBySlugPath _build() {
    _$GMentionHoverTagData_tagBySlugPath _$result;
    try {
      _$result = _$v ??
          _$GMentionHoverTagData_tagBySlugPath._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GMentionHoverTagData_tagBySlugPath', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GMentionHoverTagData_tagBySlugPath', 'id'),
            slug: BuiltValueNullFieldError.checkNotNull(
                slug, r'GMentionHoverTagData_tagBySlugPath', 'slug'),
            displayName: BuiltValueNullFieldError.checkNotNull(displayName,
                r'GMentionHoverTagData_tagBySlugPath', 'displayName'),
            path: BuiltValueNullFieldError.checkNotNull(
                path, r'GMentionHoverTagData_tagBySlugPath', 'path'),
            parent: _parent?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'parent';
        _parent?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMentionHoverTagData_tagBySlugPath', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMentionHoverTagData_tagBySlugPath_parent
    extends GMentionHoverTagData_tagBySlugPath_parent {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;

  factory _$GMentionHoverTagData_tagBySlugPath_parent(
          [void Function(GMentionHoverTagData_tagBySlugPath_parentBuilder)?
              updates]) =>
      (GMentionHoverTagData_tagBySlugPath_parentBuilder()..update(updates))
          ._build();

  _$GMentionHoverTagData_tagBySlugPath_parent._(
      {required this.G__typename, required this.id, required this.displayName})
      : super._();
  @override
  GMentionHoverTagData_tagBySlugPath_parent rebuild(
          void Function(GMentionHoverTagData_tagBySlugPath_parentBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionHoverTagData_tagBySlugPath_parentBuilder toBuilder() =>
      GMentionHoverTagData_tagBySlugPath_parentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionHoverTagData_tagBySlugPath_parent &&
        G__typename == other.G__typename &&
        id == other.id &&
        displayName == other.displayName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GMentionHoverTagData_tagBySlugPath_parent')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName))
        .toString();
  }
}

class GMentionHoverTagData_tagBySlugPath_parentBuilder
    implements
        Builder<GMentionHoverTagData_tagBySlugPath_parent,
            GMentionHoverTagData_tagBySlugPath_parentBuilder> {
  _$GMentionHoverTagData_tagBySlugPath_parent? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GMentionHoverTagData_tagBySlugPath_parentBuilder() {
    GMentionHoverTagData_tagBySlugPath_parent._initializeBuilder(this);
  }

  GMentionHoverTagData_tagBySlugPath_parentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _displayName = $v.displayName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMentionHoverTagData_tagBySlugPath_parent other) {
    _$v = other as _$GMentionHoverTagData_tagBySlugPath_parent;
  }

  @override
  void update(
      void Function(GMentionHoverTagData_tagBySlugPath_parentBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionHoverTagData_tagBySlugPath_parent build() => _build();

  _$GMentionHoverTagData_tagBySlugPath_parent _build() {
    final _$result = _$v ??
        _$GMentionHoverTagData_tagBySlugPath_parent._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GMentionHoverTagData_tagBySlugPath_parent', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GMentionHoverTagData_tagBySlugPath_parent', 'id'),
          displayName: BuiltValueNullFieldError.checkNotNull(displayName,
              r'GMentionHoverTagData_tagBySlugPath_parent', 'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
