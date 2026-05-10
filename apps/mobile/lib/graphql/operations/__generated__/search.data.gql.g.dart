// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GSearchData> _$gSearchDataSerializer = _$GSearchDataSerializer();
Serializer<GSearchData_search> _$gSearchDataSearchSerializer =
    _$GSearchData_searchSerializer();
Serializer<GSearchData_search_edges> _$gSearchDataSearchEdgesSerializer =
    _$GSearchData_search_edgesSerializer();
Serializer<GSearchData_search_edges_node__base>
    _$gSearchDataSearchEdgesNodeBaseSerializer =
    _$GSearchData_search_edges_node__baseSerializer();
Serializer<GSearchData_search_edges_node__asPost>
    _$gSearchDataSearchEdgesNodeAsPostSerializer =
    _$GSearchData_search_edges_node__asPostSerializer();
Serializer<GSearchData_search_edges_node__asPost_author>
    _$gSearchDataSearchEdgesNodeAsPostAuthorSerializer =
    _$GSearchData_search_edges_node__asPost_authorSerializer();
Serializer<GSearchData_search_edges_node__asComment>
    _$gSearchDataSearchEdgesNodeAsCommentSerializer =
    _$GSearchData_search_edges_node__asCommentSerializer();
Serializer<GSearchTagsData> _$gSearchTagsDataSerializer =
    _$GSearchTagsDataSerializer();
Serializer<GSearchTagsData_searchTags> _$gSearchTagsDataSearchTagsSerializer =
    _$GSearchTagsData_searchTagsSerializer();
Serializer<GSearchTagsData_searchTags_tag>
    _$gSearchTagsDataSearchTagsTagSerializer =
    _$GSearchTagsData_searchTags_tagSerializer();

class _$GSearchDataSerializer implements StructuredSerializer<GSearchData> {
  @override
  final Iterable<Type> types = const [GSearchData, _$GSearchData];
  @override
  final String wireName = 'GSearchData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GSearchData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'search',
      serializers.serialize(object.search,
          specifiedType: const FullType(GSearchData_search)),
    ];

    return result;
  }

  @override
  GSearchData deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GSearchDataBuilder();

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
        case 'search':
          result.search.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GSearchData_search))!
              as GSearchData_search);
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchData_searchSerializer
    implements StructuredSerializer<GSearchData_search> {
  @override
  final Iterable<Type> types = const [GSearchData_search, _$GSearchData_search];
  @override
  final String wireName = 'GSearchData_search';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchData_search object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'edges',
      serializers.serialize(object.edges,
          specifiedType: const FullType(
              BuiltList, const [const FullType(GSearchData_search_edges)])),
    ];

    return result;
  }

  @override
  GSearchData_search deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GSearchData_searchBuilder();

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
        case 'edges':
          result.edges.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GSearchData_search_edges)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchData_search_edgesSerializer
    implements StructuredSerializer<GSearchData_search_edges> {
  @override
  final Iterable<Type> types = const [
    GSearchData_search_edges,
    _$GSearchData_search_edges
  ];
  @override
  final String wireName = 'GSearchData_search_edges';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchData_search_edges object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'cursor',
      serializers.serialize(object.cursor,
          specifiedType: const FullType(String)),
      'score',
      serializers.serialize(object.score,
          specifiedType: const FullType(double)),
      'node',
      serializers.serialize(object.node,
          specifiedType: const FullType(GSearchData_search_edges_node)),
    ];

    return result;
  }

  @override
  GSearchData_search_edges deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GSearchData_search_edgesBuilder();

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
        case 'cursor':
          result.cursor = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'score':
          result.score = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'node':
          result.node = serializers.deserialize(value,
                  specifiedType: const FullType(GSearchData_search_edges_node))!
              as GSearchData_search_edges_node;
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchData_search_edges_node__baseSerializer
    implements StructuredSerializer<GSearchData_search_edges_node__base> {
  @override
  final Iterable<Type> types = const [
    GSearchData_search_edges_node__base,
    _$GSearchData_search_edges_node__base
  ];
  @override
  final String wireName = 'GSearchData_search_edges_node__base';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchData_search_edges_node__base object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GSearchData_search_edges_node__base deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GSearchData_search_edges_node__baseBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GSearchData_search_edges_node__asPostSerializer
    implements StructuredSerializer<GSearchData_search_edges_node__asPost> {
  @override
  final Iterable<Type> types = const [
    GSearchData_search_edges_node__asPost,
    _$GSearchData_search_edges_node__asPost
  ];
  @override
  final String wireName = 'GSearchData_search_edges_node__asPost';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchData_search_edges_node__asPost object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'author',
      serializers.serialize(object.author,
          specifiedType:
              const FullType(GSearchData_search_edges_node__asPost_author)),
    ];

    return result;
  }

  @override
  GSearchData_search_edges_node__asPost deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GSearchData_search_edges_node__asPostBuilder();

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
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'author':
          result.author.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GSearchData_search_edges_node__asPost_author))!
              as GSearchData_search_edges_node__asPost_author);
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchData_search_edges_node__asPost_authorSerializer
    implements
        StructuredSerializer<GSearchData_search_edges_node__asPost_author> {
  @override
  final Iterable<Type> types = const [
    GSearchData_search_edges_node__asPost_author,
    _$GSearchData_search_edges_node__asPost_author
  ];
  @override
  final String wireName = 'GSearchData_search_edges_node__asPost_author';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GSearchData_search_edges_node__asPost_author object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'displayName',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GSearchData_search_edges_node__asPost_author deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GSearchData_search_edges_node__asPost_authorBuilder();

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
        case 'displayName':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchData_search_edges_node__asCommentSerializer
    implements StructuredSerializer<GSearchData_search_edges_node__asComment> {
  @override
  final Iterable<Type> types = const [
    GSearchData_search_edges_node__asComment,
    _$GSearchData_search_edges_node__asComment
  ];
  @override
  final String wireName = 'GSearchData_search_edges_node__asComment';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchData_search_edges_node__asComment object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'postId',
      serializers.serialize(object.postId,
          specifiedType: const FullType(String)),
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GSearchData_search_edges_node__asComment deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GSearchData_search_edges_node__asCommentBuilder();

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
        case 'postId':
          result.postId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchTagsDataSerializer
    implements StructuredSerializer<GSearchTagsData> {
  @override
  final Iterable<Type> types = const [GSearchTagsData, _$GSearchTagsData];
  @override
  final String wireName = 'GSearchTagsData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GSearchTagsData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'searchTags',
      serializers.serialize(object.searchTags,
          specifiedType: const FullType(
              BuiltList, const [const FullType(GSearchTagsData_searchTags)])),
    ];

    return result;
  }

  @override
  GSearchTagsData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GSearchTagsDataBuilder();

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
        case 'searchTags':
          result.searchTags.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GSearchTagsData_searchTags)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchTagsData_searchTagsSerializer
    implements StructuredSerializer<GSearchTagsData_searchTags> {
  @override
  final Iterable<Type> types = const [
    GSearchTagsData_searchTags,
    _$GSearchTagsData_searchTags
  ];
  @override
  final String wireName = 'GSearchTagsData_searchTags';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchTagsData_searchTags object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'similarity',
      serializers.serialize(object.similarity,
          specifiedType: const FullType(double)),
      'tag',
      serializers.serialize(object.tag,
          specifiedType: const FullType(GSearchTagsData_searchTags_tag)),
    ];

    return result;
  }

  @override
  GSearchTagsData_searchTags deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GSearchTagsData_searchTagsBuilder();

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
        case 'similarity':
          result.similarity = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'tag':
          result.tag.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GSearchTagsData_searchTags_tag))!
              as GSearchTagsData_searchTags_tag);
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchTagsData_searchTags_tagSerializer
    implements StructuredSerializer<GSearchTagsData_searchTags_tag> {
  @override
  final Iterable<Type> types = const [
    GSearchTagsData_searchTags_tag,
    _$GSearchTagsData_searchTags_tag
  ];
  @override
  final String wireName = 'GSearchTagsData_searchTags_tag';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchTagsData_searchTags_tag object,
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

    return result;
  }

  @override
  GSearchTagsData_searchTags_tag deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GSearchTagsData_searchTags_tagBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GSearchData extends GSearchData {
  @override
  final String G__typename;
  @override
  final GSearchData_search search;

  factory _$GSearchData([void Function(GSearchDataBuilder)? updates]) =>
      (GSearchDataBuilder()..update(updates))._build();

  _$GSearchData._({required this.G__typename, required this.search})
      : super._();
  @override
  GSearchData rebuild(void Function(GSearchDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchDataBuilder toBuilder() => GSearchDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchData &&
        G__typename == other.G__typename &&
        search == other.search;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, search.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchData')
          ..add('G__typename', G__typename)
          ..add('search', search))
        .toString();
  }
}

class GSearchDataBuilder implements Builder<GSearchData, GSearchDataBuilder> {
  _$GSearchData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GSearchData_searchBuilder? _search;
  GSearchData_searchBuilder get search =>
      _$this._search ??= GSearchData_searchBuilder();
  set search(GSearchData_searchBuilder? search) => _$this._search = search;

  GSearchDataBuilder() {
    GSearchData._initializeBuilder(this);
  }

  GSearchDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _search = $v.search.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchData other) {
    _$v = other as _$GSearchData;
  }

  @override
  void update(void Function(GSearchDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchData build() => _build();

  _$GSearchData _build() {
    _$GSearchData _$result;
    try {
      _$result = _$v ??
          _$GSearchData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GSearchData', 'G__typename'),
            search: search.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'search';
        search.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GSearchData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSearchData_search extends GSearchData_search {
  @override
  final String G__typename;
  @override
  final BuiltList<GSearchData_search_edges> edges;

  factory _$GSearchData_search(
          [void Function(GSearchData_searchBuilder)? updates]) =>
      (GSearchData_searchBuilder()..update(updates))._build();

  _$GSearchData_search._({required this.G__typename, required this.edges})
      : super._();
  @override
  GSearchData_search rebuild(
          void Function(GSearchData_searchBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchData_searchBuilder toBuilder() =>
      GSearchData_searchBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchData_search &&
        G__typename == other.G__typename &&
        edges == other.edges;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, edges.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchData_search')
          ..add('G__typename', G__typename)
          ..add('edges', edges))
        .toString();
  }
}

class GSearchData_searchBuilder
    implements Builder<GSearchData_search, GSearchData_searchBuilder> {
  _$GSearchData_search? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GSearchData_search_edges>? _edges;
  ListBuilder<GSearchData_search_edges> get edges =>
      _$this._edges ??= ListBuilder<GSearchData_search_edges>();
  set edges(ListBuilder<GSearchData_search_edges>? edges) =>
      _$this._edges = edges;

  GSearchData_searchBuilder() {
    GSearchData_search._initializeBuilder(this);
  }

  GSearchData_searchBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _edges = $v.edges.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchData_search other) {
    _$v = other as _$GSearchData_search;
  }

  @override
  void update(void Function(GSearchData_searchBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchData_search build() => _build();

  _$GSearchData_search _build() {
    _$GSearchData_search _$result;
    try {
      _$result = _$v ??
          _$GSearchData_search._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GSearchData_search', 'G__typename'),
            edges: edges.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'edges';
        edges.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GSearchData_search', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSearchData_search_edges extends GSearchData_search_edges {
  @override
  final String G__typename;
  @override
  final String cursor;
  @override
  final double score;
  @override
  final GSearchData_search_edges_node node;

  factory _$GSearchData_search_edges(
          [void Function(GSearchData_search_edgesBuilder)? updates]) =>
      (GSearchData_search_edgesBuilder()..update(updates))._build();

  _$GSearchData_search_edges._(
      {required this.G__typename,
      required this.cursor,
      required this.score,
      required this.node})
      : super._();
  @override
  GSearchData_search_edges rebuild(
          void Function(GSearchData_search_edgesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchData_search_edgesBuilder toBuilder() =>
      GSearchData_search_edgesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchData_search_edges &&
        G__typename == other.G__typename &&
        cursor == other.cursor &&
        score == other.score &&
        node == other.node;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, cursor.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, node.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchData_search_edges')
          ..add('G__typename', G__typename)
          ..add('cursor', cursor)
          ..add('score', score)
          ..add('node', node))
        .toString();
  }
}

class GSearchData_search_edgesBuilder
    implements
        Builder<GSearchData_search_edges, GSearchData_search_edgesBuilder> {
  _$GSearchData_search_edges? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _cursor;
  String? get cursor => _$this._cursor;
  set cursor(String? cursor) => _$this._cursor = cursor;

  double? _score;
  double? get score => _$this._score;
  set score(double? score) => _$this._score = score;

  GSearchData_search_edges_node? _node;
  GSearchData_search_edges_node? get node => _$this._node;
  set node(GSearchData_search_edges_node? node) => _$this._node = node;

  GSearchData_search_edgesBuilder() {
    GSearchData_search_edges._initializeBuilder(this);
  }

  GSearchData_search_edgesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _cursor = $v.cursor;
      _score = $v.score;
      _node = $v.node;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchData_search_edges other) {
    _$v = other as _$GSearchData_search_edges;
  }

  @override
  void update(void Function(GSearchData_search_edgesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchData_search_edges build() => _build();

  _$GSearchData_search_edges _build() {
    final _$result = _$v ??
        _$GSearchData_search_edges._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GSearchData_search_edges', 'G__typename'),
          cursor: BuiltValueNullFieldError.checkNotNull(
              cursor, r'GSearchData_search_edges', 'cursor'),
          score: BuiltValueNullFieldError.checkNotNull(
              score, r'GSearchData_search_edges', 'score'),
          node: BuiltValueNullFieldError.checkNotNull(
              node, r'GSearchData_search_edges', 'node'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GSearchData_search_edges_node__base
    extends GSearchData_search_edges_node__base {
  @override
  final String G__typename;

  factory _$GSearchData_search_edges_node__base(
          [void Function(GSearchData_search_edges_node__baseBuilder)?
              updates]) =>
      (GSearchData_search_edges_node__baseBuilder()..update(updates))._build();

  _$GSearchData_search_edges_node__base._({required this.G__typename})
      : super._();
  @override
  GSearchData_search_edges_node__base rebuild(
          void Function(GSearchData_search_edges_node__baseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchData_search_edges_node__baseBuilder toBuilder() =>
      GSearchData_search_edges_node__baseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchData_search_edges_node__base &&
        G__typename == other.G__typename;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchData_search_edges_node__base')
          ..add('G__typename', G__typename))
        .toString();
  }
}

class GSearchData_search_edges_node__baseBuilder
    implements
        Builder<GSearchData_search_edges_node__base,
            GSearchData_search_edges_node__baseBuilder> {
  _$GSearchData_search_edges_node__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GSearchData_search_edges_node__baseBuilder() {
    GSearchData_search_edges_node__base._initializeBuilder(this);
  }

  GSearchData_search_edges_node__baseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchData_search_edges_node__base other) {
    _$v = other as _$GSearchData_search_edges_node__base;
  }

  @override
  void update(
      void Function(GSearchData_search_edges_node__baseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchData_search_edges_node__base build() => _build();

  _$GSearchData_search_edges_node__base _build() {
    final _$result = _$v ??
        _$GSearchData_search_edges_node__base._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GSearchData_search_edges_node__base', 'G__typename'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GSearchData_search_edges_node__asPost
    extends GSearchData_search_edges_node__asPost {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String title;
  @override
  final GSearchData_search_edges_node__asPost_author author;

  factory _$GSearchData_search_edges_node__asPost(
          [void Function(GSearchData_search_edges_node__asPostBuilder)?
              updates]) =>
      (GSearchData_search_edges_node__asPostBuilder()..update(updates))
          ._build();

  _$GSearchData_search_edges_node__asPost._(
      {required this.G__typename,
      required this.id,
      required this.title,
      required this.author})
      : super._();
  @override
  GSearchData_search_edges_node__asPost rebuild(
          void Function(GSearchData_search_edges_node__asPostBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchData_search_edges_node__asPostBuilder toBuilder() =>
      GSearchData_search_edges_node__asPostBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchData_search_edges_node__asPost &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        author == other.author;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GSearchData_search_edges_node__asPost')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('author', author))
        .toString();
  }
}

class GSearchData_search_edges_node__asPostBuilder
    implements
        Builder<GSearchData_search_edges_node__asPost,
            GSearchData_search_edges_node__asPostBuilder> {
  _$GSearchData_search_edges_node__asPost? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  GSearchData_search_edges_node__asPost_authorBuilder? _author;
  GSearchData_search_edges_node__asPost_authorBuilder get author =>
      _$this._author ??= GSearchData_search_edges_node__asPost_authorBuilder();
  set author(GSearchData_search_edges_node__asPost_authorBuilder? author) =>
      _$this._author = author;

  GSearchData_search_edges_node__asPostBuilder() {
    GSearchData_search_edges_node__asPost._initializeBuilder(this);
  }

  GSearchData_search_edges_node__asPostBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _author = $v.author.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchData_search_edges_node__asPost other) {
    _$v = other as _$GSearchData_search_edges_node__asPost;
  }

  @override
  void update(
      void Function(GSearchData_search_edges_node__asPostBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchData_search_edges_node__asPost build() => _build();

  _$GSearchData_search_edges_node__asPost _build() {
    _$GSearchData_search_edges_node__asPost _$result;
    try {
      _$result = _$v ??
          _$GSearchData_search_edges_node__asPost._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GSearchData_search_edges_node__asPost', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GSearchData_search_edges_node__asPost', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GSearchData_search_edges_node__asPost', 'title'),
            author: author.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'author';
        author.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GSearchData_search_edges_node__asPost',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSearchData_search_edges_node__asPost_author
    extends GSearchData_search_edges_node__asPost_author {
  @override
  final String G__typename;
  @override
  final String displayName;

  factory _$GSearchData_search_edges_node__asPost_author(
          [void Function(GSearchData_search_edges_node__asPost_authorBuilder)?
              updates]) =>
      (GSearchData_search_edges_node__asPost_authorBuilder()..update(updates))
          ._build();

  _$GSearchData_search_edges_node__asPost_author._(
      {required this.G__typename, required this.displayName})
      : super._();
  @override
  GSearchData_search_edges_node__asPost_author rebuild(
          void Function(GSearchData_search_edges_node__asPost_authorBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchData_search_edges_node__asPost_authorBuilder toBuilder() =>
      GSearchData_search_edges_node__asPost_authorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchData_search_edges_node__asPost_author &&
        G__typename == other.G__typename &&
        displayName == other.displayName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GSearchData_search_edges_node__asPost_author')
          ..add('G__typename', G__typename)
          ..add('displayName', displayName))
        .toString();
  }
}

class GSearchData_search_edges_node__asPost_authorBuilder
    implements
        Builder<GSearchData_search_edges_node__asPost_author,
            GSearchData_search_edges_node__asPost_authorBuilder> {
  _$GSearchData_search_edges_node__asPost_author? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GSearchData_search_edges_node__asPost_authorBuilder() {
    GSearchData_search_edges_node__asPost_author._initializeBuilder(this);
  }

  GSearchData_search_edges_node__asPost_authorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _displayName = $v.displayName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchData_search_edges_node__asPost_author other) {
    _$v = other as _$GSearchData_search_edges_node__asPost_author;
  }

  @override
  void update(
      void Function(GSearchData_search_edges_node__asPost_authorBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchData_search_edges_node__asPost_author build() => _build();

  _$GSearchData_search_edges_node__asPost_author _build() {
    final _$result = _$v ??
        _$GSearchData_search_edges_node__asPost_author._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GSearchData_search_edges_node__asPost_author', 'G__typename'),
          displayName: BuiltValueNullFieldError.checkNotNull(displayName,
              r'GSearchData_search_edges_node__asPost_author', 'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GSearchData_search_edges_node__asComment
    extends GSearchData_search_edges_node__asComment {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String postId;
  @override
  final String body;

  factory _$GSearchData_search_edges_node__asComment(
          [void Function(GSearchData_search_edges_node__asCommentBuilder)?
              updates]) =>
      (GSearchData_search_edges_node__asCommentBuilder()..update(updates))
          ._build();

  _$GSearchData_search_edges_node__asComment._(
      {required this.G__typename,
      required this.id,
      required this.postId,
      required this.body})
      : super._();
  @override
  GSearchData_search_edges_node__asComment rebuild(
          void Function(GSearchData_search_edges_node__asCommentBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchData_search_edges_node__asCommentBuilder toBuilder() =>
      GSearchData_search_edges_node__asCommentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchData_search_edges_node__asComment &&
        G__typename == other.G__typename &&
        id == other.id &&
        postId == other.postId &&
        body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, postId.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GSearchData_search_edges_node__asComment')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('postId', postId)
          ..add('body', body))
        .toString();
  }
}

class GSearchData_search_edges_node__asCommentBuilder
    implements
        Builder<GSearchData_search_edges_node__asComment,
            GSearchData_search_edges_node__asCommentBuilder> {
  _$GSearchData_search_edges_node__asComment? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _postId;
  String? get postId => _$this._postId;
  set postId(String? postId) => _$this._postId = postId;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  GSearchData_search_edges_node__asCommentBuilder() {
    GSearchData_search_edges_node__asComment._initializeBuilder(this);
  }

  GSearchData_search_edges_node__asCommentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _postId = $v.postId;
      _body = $v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchData_search_edges_node__asComment other) {
    _$v = other as _$GSearchData_search_edges_node__asComment;
  }

  @override
  void update(
      void Function(GSearchData_search_edges_node__asCommentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchData_search_edges_node__asComment build() => _build();

  _$GSearchData_search_edges_node__asComment _build() {
    final _$result = _$v ??
        _$GSearchData_search_edges_node__asComment._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GSearchData_search_edges_node__asComment', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GSearchData_search_edges_node__asComment', 'id'),
          postId: BuiltValueNullFieldError.checkNotNull(
              postId, r'GSearchData_search_edges_node__asComment', 'postId'),
          body: BuiltValueNullFieldError.checkNotNull(
              body, r'GSearchData_search_edges_node__asComment', 'body'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GSearchTagsData extends GSearchTagsData {
  @override
  final String G__typename;
  @override
  final BuiltList<GSearchTagsData_searchTags> searchTags;

  factory _$GSearchTagsData([void Function(GSearchTagsDataBuilder)? updates]) =>
      (GSearchTagsDataBuilder()..update(updates))._build();

  _$GSearchTagsData._({required this.G__typename, required this.searchTags})
      : super._();
  @override
  GSearchTagsData rebuild(void Function(GSearchTagsDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchTagsDataBuilder toBuilder() => GSearchTagsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchTagsData &&
        G__typename == other.G__typename &&
        searchTags == other.searchTags;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, searchTags.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchTagsData')
          ..add('G__typename', G__typename)
          ..add('searchTags', searchTags))
        .toString();
  }
}

class GSearchTagsDataBuilder
    implements Builder<GSearchTagsData, GSearchTagsDataBuilder> {
  _$GSearchTagsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GSearchTagsData_searchTags>? _searchTags;
  ListBuilder<GSearchTagsData_searchTags> get searchTags =>
      _$this._searchTags ??= ListBuilder<GSearchTagsData_searchTags>();
  set searchTags(ListBuilder<GSearchTagsData_searchTags>? searchTags) =>
      _$this._searchTags = searchTags;

  GSearchTagsDataBuilder() {
    GSearchTagsData._initializeBuilder(this);
  }

  GSearchTagsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _searchTags = $v.searchTags.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchTagsData other) {
    _$v = other as _$GSearchTagsData;
  }

  @override
  void update(void Function(GSearchTagsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchTagsData build() => _build();

  _$GSearchTagsData _build() {
    _$GSearchTagsData _$result;
    try {
      _$result = _$v ??
          _$GSearchTagsData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GSearchTagsData', 'G__typename'),
            searchTags: searchTags.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'searchTags';
        searchTags.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GSearchTagsData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSearchTagsData_searchTags extends GSearchTagsData_searchTags {
  @override
  final String G__typename;
  @override
  final double similarity;
  @override
  final GSearchTagsData_searchTags_tag tag;

  factory _$GSearchTagsData_searchTags(
          [void Function(GSearchTagsData_searchTagsBuilder)? updates]) =>
      (GSearchTagsData_searchTagsBuilder()..update(updates))._build();

  _$GSearchTagsData_searchTags._(
      {required this.G__typename, required this.similarity, required this.tag})
      : super._();
  @override
  GSearchTagsData_searchTags rebuild(
          void Function(GSearchTagsData_searchTagsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchTagsData_searchTagsBuilder toBuilder() =>
      GSearchTagsData_searchTagsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchTagsData_searchTags &&
        G__typename == other.G__typename &&
        similarity == other.similarity &&
        tag == other.tag;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, similarity.hashCode);
    _$hash = $jc(_$hash, tag.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchTagsData_searchTags')
          ..add('G__typename', G__typename)
          ..add('similarity', similarity)
          ..add('tag', tag))
        .toString();
  }
}

class GSearchTagsData_searchTagsBuilder
    implements
        Builder<GSearchTagsData_searchTags, GSearchTagsData_searchTagsBuilder> {
  _$GSearchTagsData_searchTags? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  double? _similarity;
  double? get similarity => _$this._similarity;
  set similarity(double? similarity) => _$this._similarity = similarity;

  GSearchTagsData_searchTags_tagBuilder? _tag;
  GSearchTagsData_searchTags_tagBuilder get tag =>
      _$this._tag ??= GSearchTagsData_searchTags_tagBuilder();
  set tag(GSearchTagsData_searchTags_tagBuilder? tag) => _$this._tag = tag;

  GSearchTagsData_searchTagsBuilder() {
    GSearchTagsData_searchTags._initializeBuilder(this);
  }

  GSearchTagsData_searchTagsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _similarity = $v.similarity;
      _tag = $v.tag.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchTagsData_searchTags other) {
    _$v = other as _$GSearchTagsData_searchTags;
  }

  @override
  void update(void Function(GSearchTagsData_searchTagsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchTagsData_searchTags build() => _build();

  _$GSearchTagsData_searchTags _build() {
    _$GSearchTagsData_searchTags _$result;
    try {
      _$result = _$v ??
          _$GSearchTagsData_searchTags._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GSearchTagsData_searchTags', 'G__typename'),
            similarity: BuiltValueNullFieldError.checkNotNull(
                similarity, r'GSearchTagsData_searchTags', 'similarity'),
            tag: tag.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tag';
        tag.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GSearchTagsData_searchTags', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSearchTagsData_searchTags_tag extends GSearchTagsData_searchTags_tag {
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

  factory _$GSearchTagsData_searchTags_tag(
          [void Function(GSearchTagsData_searchTags_tagBuilder)? updates]) =>
      (GSearchTagsData_searchTags_tagBuilder()..update(updates))._build();

  _$GSearchTagsData_searchTags_tag._(
      {required this.G__typename,
      required this.id,
      required this.slug,
      required this.displayName,
      required this.path})
      : super._();
  @override
  GSearchTagsData_searchTags_tag rebuild(
          void Function(GSearchTagsData_searchTags_tagBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchTagsData_searchTags_tagBuilder toBuilder() =>
      GSearchTagsData_searchTags_tagBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchTagsData_searchTags_tag &&
        G__typename == other.G__typename &&
        id == other.id &&
        slug == other.slug &&
        displayName == other.displayName &&
        path == other.path;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchTagsData_searchTags_tag')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('slug', slug)
          ..add('displayName', displayName)
          ..add('path', path))
        .toString();
  }
}

class GSearchTagsData_searchTags_tagBuilder
    implements
        Builder<GSearchTagsData_searchTags_tag,
            GSearchTagsData_searchTags_tagBuilder> {
  _$GSearchTagsData_searchTags_tag? _$v;

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

  GSearchTagsData_searchTags_tagBuilder() {
    GSearchTagsData_searchTags_tag._initializeBuilder(this);
  }

  GSearchTagsData_searchTags_tagBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _slug = $v.slug;
      _displayName = $v.displayName;
      _path = $v.path;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchTagsData_searchTags_tag other) {
    _$v = other as _$GSearchTagsData_searchTags_tag;
  }

  @override
  void update(void Function(GSearchTagsData_searchTags_tagBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchTagsData_searchTags_tag build() => _build();

  _$GSearchTagsData_searchTags_tag _build() {
    final _$result = _$v ??
        _$GSearchTagsData_searchTags_tag._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GSearchTagsData_searchTags_tag', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GSearchTagsData_searchTags_tag', 'id'),
          slug: BuiltValueNullFieldError.checkNotNull(
              slug, r'GSearchTagsData_searchTags_tag', 'slug'),
          displayName: BuiltValueNullFieldError.checkNotNull(
              displayName, r'GSearchTagsData_searchTags_tag', 'displayName'),
          path: BuiltValueNullFieldError.checkNotNull(
              path, r'GSearchTagsData_searchTags_tag', 'path'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
