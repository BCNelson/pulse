// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewer.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GViewerData> _$gViewerDataSerializer = _$GViewerDataSerializer();
Serializer<GViewerData_viewer> _$gViewerDataViewerSerializer =
    _$GViewerData_viewerSerializer();
Serializer<GViewerData_viewer_homeTag> _$gViewerDataViewerHomeTagSerializer =
    _$GViewerData_viewer_homeTagSerializer();

class _$GViewerDataSerializer implements StructuredSerializer<GViewerData> {
  @override
  final Iterable<Type> types = const [GViewerData, _$GViewerData];
  @override
  final String wireName = 'GViewerData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GViewerData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.viewer;
    if (value != null) {
      result
        ..add('viewer')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GViewerData_viewer)));
    }
    return result;
  }

  @override
  GViewerData deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GViewerDataBuilder();

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
        case 'viewer':
          result.viewer.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GViewerData_viewer))!
              as GViewerData_viewer);
          break;
      }
    }

    return result.build();
  }
}

class _$GViewerData_viewerSerializer
    implements StructuredSerializer<GViewerData_viewer> {
  @override
  final Iterable<Type> types = const [GViewerData_viewer, _$GViewerData_viewer];
  @override
  final String wireName = 'GViewerData_viewer';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GViewerData_viewer object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'globalUri',
      serializers.serialize(object.globalUri,
          specifiedType: const FullType(String)),
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
    value = object.homeTag;
    if (value != null) {
      result
        ..add('homeTag')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GViewerData_viewer_homeTag)));
    }
    return result;
  }

  @override
  GViewerData_viewer deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GViewerData_viewerBuilder();

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
        case 'globalUri':
          result.globalUri = serializers.deserialize(value,
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
        case 'homeTag':
          result.homeTag.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GViewerData_viewer_homeTag))!
              as GViewerData_viewer_homeTag);
          break;
      }
    }

    return result.build();
  }
}

class _$GViewerData_viewer_homeTagSerializer
    implements StructuredSerializer<GViewerData_viewer_homeTag> {
  @override
  final Iterable<Type> types = const [
    GViewerData_viewer_homeTag,
    _$GViewerData_viewer_homeTag
  ];
  @override
  final String wireName = 'GViewerData_viewer_homeTag';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GViewerData_viewer_homeTag object,
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
    ];

    return result;
  }

  @override
  GViewerData_viewer_homeTag deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GViewerData_viewer_homeTagBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GViewerData extends GViewerData {
  @override
  final String G__typename;
  @override
  final GViewerData_viewer? viewer;

  factory _$GViewerData([void Function(GViewerDataBuilder)? updates]) =>
      (GViewerDataBuilder()..update(updates))._build();

  _$GViewerData._({required this.G__typename, this.viewer}) : super._();
  @override
  GViewerData rebuild(void Function(GViewerDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GViewerDataBuilder toBuilder() => GViewerDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GViewerData &&
        G__typename == other.G__typename &&
        viewer == other.viewer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, viewer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GViewerData')
          ..add('G__typename', G__typename)
          ..add('viewer', viewer))
        .toString();
  }
}

class GViewerDataBuilder implements Builder<GViewerData, GViewerDataBuilder> {
  _$GViewerData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GViewerData_viewerBuilder? _viewer;
  GViewerData_viewerBuilder get viewer =>
      _$this._viewer ??= GViewerData_viewerBuilder();
  set viewer(GViewerData_viewerBuilder? viewer) => _$this._viewer = viewer;

  GViewerDataBuilder() {
    GViewerData._initializeBuilder(this);
  }

  GViewerDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _viewer = $v.viewer?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GViewerData other) {
    _$v = other as _$GViewerData;
  }

  @override
  void update(void Function(GViewerDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GViewerData build() => _build();

  _$GViewerData _build() {
    _$GViewerData _$result;
    try {
      _$result = _$v ??
          _$GViewerData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GViewerData', 'G__typename'),
            viewer: _viewer?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'viewer';
        _viewer?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GViewerData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GViewerData_viewer extends GViewerData_viewer {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String globalUri;
  @override
  final String displayName;
  @override
  final String? email;
  @override
  final GViewerData_viewer_homeTag? homeTag;

  factory _$GViewerData_viewer(
          [void Function(GViewerData_viewerBuilder)? updates]) =>
      (GViewerData_viewerBuilder()..update(updates))._build();

  _$GViewerData_viewer._(
      {required this.G__typename,
      required this.id,
      required this.globalUri,
      required this.displayName,
      this.email,
      this.homeTag})
      : super._();
  @override
  GViewerData_viewer rebuild(
          void Function(GViewerData_viewerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GViewerData_viewerBuilder toBuilder() =>
      GViewerData_viewerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GViewerData_viewer &&
        G__typename == other.G__typename &&
        id == other.id &&
        globalUri == other.globalUri &&
        displayName == other.displayName &&
        email == other.email &&
        homeTag == other.homeTag;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, globalUri.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, homeTag.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GViewerData_viewer')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('globalUri', globalUri)
          ..add('displayName', displayName)
          ..add('email', email)
          ..add('homeTag', homeTag))
        .toString();
  }
}

class GViewerData_viewerBuilder
    implements Builder<GViewerData_viewer, GViewerData_viewerBuilder> {
  _$GViewerData_viewer? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _globalUri;
  String? get globalUri => _$this._globalUri;
  set globalUri(String? globalUri) => _$this._globalUri = globalUri;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  GViewerData_viewer_homeTagBuilder? _homeTag;
  GViewerData_viewer_homeTagBuilder get homeTag =>
      _$this._homeTag ??= GViewerData_viewer_homeTagBuilder();
  set homeTag(GViewerData_viewer_homeTagBuilder? homeTag) =>
      _$this._homeTag = homeTag;

  GViewerData_viewerBuilder() {
    GViewerData_viewer._initializeBuilder(this);
  }

  GViewerData_viewerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _globalUri = $v.globalUri;
      _displayName = $v.displayName;
      _email = $v.email;
      _homeTag = $v.homeTag?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GViewerData_viewer other) {
    _$v = other as _$GViewerData_viewer;
  }

  @override
  void update(void Function(GViewerData_viewerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GViewerData_viewer build() => _build();

  _$GViewerData_viewer _build() {
    _$GViewerData_viewer _$result;
    try {
      _$result = _$v ??
          _$GViewerData_viewer._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GViewerData_viewer', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GViewerData_viewer', 'id'),
            globalUri: BuiltValueNullFieldError.checkNotNull(
                globalUri, r'GViewerData_viewer', 'globalUri'),
            displayName: BuiltValueNullFieldError.checkNotNull(
                displayName, r'GViewerData_viewer', 'displayName'),
            email: email,
            homeTag: _homeTag?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'homeTag';
        _homeTag?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GViewerData_viewer', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GViewerData_viewer_homeTag extends GViewerData_viewer_homeTag {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String slug;
  @override
  final String displayName;

  factory _$GViewerData_viewer_homeTag(
          [void Function(GViewerData_viewer_homeTagBuilder)? updates]) =>
      (GViewerData_viewer_homeTagBuilder()..update(updates))._build();

  _$GViewerData_viewer_homeTag._(
      {required this.G__typename,
      required this.id,
      required this.slug,
      required this.displayName})
      : super._();
  @override
  GViewerData_viewer_homeTag rebuild(
          void Function(GViewerData_viewer_homeTagBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GViewerData_viewer_homeTagBuilder toBuilder() =>
      GViewerData_viewer_homeTagBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GViewerData_viewer_homeTag &&
        G__typename == other.G__typename &&
        id == other.id &&
        slug == other.slug &&
        displayName == other.displayName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GViewerData_viewer_homeTag')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('slug', slug)
          ..add('displayName', displayName))
        .toString();
  }
}

class GViewerData_viewer_homeTagBuilder
    implements
        Builder<GViewerData_viewer_homeTag, GViewerData_viewer_homeTagBuilder> {
  _$GViewerData_viewer_homeTag? _$v;

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

  GViewerData_viewer_homeTagBuilder() {
    GViewerData_viewer_homeTag._initializeBuilder(this);
  }

  GViewerData_viewer_homeTagBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _slug = $v.slug;
      _displayName = $v.displayName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GViewerData_viewer_homeTag other) {
    _$v = other as _$GViewerData_viewer_homeTag;
  }

  @override
  void update(void Function(GViewerData_viewer_homeTagBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GViewerData_viewer_homeTag build() => _build();

  _$GViewerData_viewer_homeTag _build() {
    final _$result = _$v ??
        _$GViewerData_viewer_homeTag._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GViewerData_viewer_homeTag', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GViewerData_viewer_homeTag', 'id'),
          slug: BuiltValueNullFieldError.checkNotNull(
              slug, r'GViewerData_viewer_homeTag', 'slug'),
          displayName: BuiltValueNullFieldError.checkNotNull(
              displayName, r'GViewerData_viewer_homeTag', 'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
