// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_tree.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GTagTreeData> _$gTagTreeDataSerializer = _$GTagTreeDataSerializer();
Serializer<GTagTreeData_myTagRoots> _$gTagTreeDataMyTagRootsSerializer =
    _$GTagTreeData_myTagRootsSerializer();
Serializer<GTagTreeData_myTagRoots_children>
    _$gTagTreeDataMyTagRootsChildrenSerializer =
    _$GTagTreeData_myTagRoots_childrenSerializer();
Serializer<GTagTreeData_myTagRoots_children_children>
    _$gTagTreeDataMyTagRootsChildrenChildrenSerializer =
    _$GTagTreeData_myTagRoots_children_childrenSerializer();
Serializer<GTagTreeData_myTagRoots_children_children_children>
    _$gTagTreeDataMyTagRootsChildrenChildrenChildrenSerializer =
    _$GTagTreeData_myTagRoots_children_children_childrenSerializer();
Serializer<GTagChildrenData> _$gTagChildrenDataSerializer =
    _$GTagChildrenDataSerializer();
Serializer<GTagChildrenData_tag> _$gTagChildrenDataTagSerializer =
    _$GTagChildrenData_tagSerializer();
Serializer<GTagChildrenData_tag_children>
    _$gTagChildrenDataTagChildrenSerializer =
    _$GTagChildrenData_tag_childrenSerializer();
Serializer<GTagChildrenData_tag_children_children>
    _$gTagChildrenDataTagChildrenChildrenSerializer =
    _$GTagChildrenData_tag_children_childrenSerializer();
Serializer<GTagBySlugPathData> _$gTagBySlugPathDataSerializer =
    _$GTagBySlugPathDataSerializer();
Serializer<GTagBySlugPathData_tagBySlugPath>
    _$gTagBySlugPathDataTagBySlugPathSerializer =
    _$GTagBySlugPathData_tagBySlugPathSerializer();
Serializer<GTagSummaryData> _$gTagSummaryDataSerializer =
    _$GTagSummaryDataSerializer();

class _$GTagTreeDataSerializer implements StructuredSerializer<GTagTreeData> {
  @override
  final Iterable<Type> types = const [GTagTreeData, _$GTagTreeData];
  @override
  final String wireName = 'GTagTreeData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GTagTreeData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'myTagRoots',
      serializers.serialize(object.myTagRoots,
          specifiedType: const FullType(
              BuiltList, const [const FullType(GTagTreeData_myTagRoots)])),
    ];

    return result;
  }

  @override
  GTagTreeData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GTagTreeDataBuilder();

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
        case 'myTagRoots':
          result.myTagRoots.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GTagTreeData_myTagRoots)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GTagTreeData_myTagRootsSerializer
    implements StructuredSerializer<GTagTreeData_myTagRoots> {
  @override
  final Iterable<Type> types = const [
    GTagTreeData_myTagRoots,
    _$GTagTreeData_myTagRoots
  ];
  @override
  final String wireName = 'GTagTreeData_myTagRoots';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GTagTreeData_myTagRoots object,
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
      'rootKind',
      serializers.serialize(object.rootKind,
          specifiedType: const FullType(_i2.GTagRootKind)),
      'children',
      serializers.serialize(object.children,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GTagTreeData_myTagRoots_children)])),
    ];
    Object? value;
    value = object.archivedAt;
    if (value != null) {
      result
        ..add('archivedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GTime)));
    }
    return result;
  }

  @override
  GTagTreeData_myTagRoots deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GTagTreeData_myTagRootsBuilder();

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
        case 'rootKind':
          result.rootKind = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GTagRootKind))!
              as _i2.GTagRootKind;
          break;
        case 'archivedAt':
          result.archivedAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'children':
          result.children.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GTagTreeData_myTagRoots_children)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GTagTreeData_myTagRoots_childrenSerializer
    implements StructuredSerializer<GTagTreeData_myTagRoots_children> {
  @override
  final Iterable<Type> types = const [
    GTagTreeData_myTagRoots_children,
    _$GTagTreeData_myTagRoots_children
  ];
  @override
  final String wireName = 'GTagTreeData_myTagRoots_children';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GTagTreeData_myTagRoots_children object,
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
      'rootKind',
      serializers.serialize(object.rootKind,
          specifiedType: const FullType(_i2.GTagRootKind)),
      'children',
      serializers.serialize(object.children,
          specifiedType: const FullType(BuiltList, const [
            const FullType(GTagTreeData_myTagRoots_children_children)
          ])),
    ];
    Object? value;
    value = object.archivedAt;
    if (value != null) {
      result
        ..add('archivedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GTime)));
    }
    return result;
  }

  @override
  GTagTreeData_myTagRoots_children deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GTagTreeData_myTagRoots_childrenBuilder();

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
        case 'rootKind':
          result.rootKind = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GTagRootKind))!
              as _i2.GTagRootKind;
          break;
        case 'archivedAt':
          result.archivedAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'children':
          result.children.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GTagTreeData_myTagRoots_children_children)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GTagTreeData_myTagRoots_children_childrenSerializer
    implements StructuredSerializer<GTagTreeData_myTagRoots_children_children> {
  @override
  final Iterable<Type> types = const [
    GTagTreeData_myTagRoots_children_children,
    _$GTagTreeData_myTagRoots_children_children
  ];
  @override
  final String wireName = 'GTagTreeData_myTagRoots_children_children';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GTagTreeData_myTagRoots_children_children object,
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
      'rootKind',
      serializers.serialize(object.rootKind,
          specifiedType: const FullType(_i2.GTagRootKind)),
      'children',
      serializers.serialize(object.children,
          specifiedType: const FullType(BuiltList, const [
            const FullType(GTagTreeData_myTagRoots_children_children_children)
          ])),
    ];
    Object? value;
    value = object.archivedAt;
    if (value != null) {
      result
        ..add('archivedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GTime)));
    }
    return result;
  }

  @override
  GTagTreeData_myTagRoots_children_children deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GTagTreeData_myTagRoots_children_childrenBuilder();

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
        case 'rootKind':
          result.rootKind = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GTagRootKind))!
              as _i2.GTagRootKind;
          break;
        case 'archivedAt':
          result.archivedAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'children':
          result.children.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    GTagTreeData_myTagRoots_children_children_children)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GTagTreeData_myTagRoots_children_children_childrenSerializer
    implements
        StructuredSerializer<
            GTagTreeData_myTagRoots_children_children_children> {
  @override
  final Iterable<Type> types = const [
    GTagTreeData_myTagRoots_children_children_children,
    _$GTagTreeData_myTagRoots_children_children_children
  ];
  @override
  final String wireName = 'GTagTreeData_myTagRoots_children_children_children';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GTagTreeData_myTagRoots_children_children_children object,
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
      'rootKind',
      serializers.serialize(object.rootKind,
          specifiedType: const FullType(_i2.GTagRootKind)),
    ];
    Object? value;
    value = object.archivedAt;
    if (value != null) {
      result
        ..add('archivedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GTime)));
    }
    return result;
  }

  @override
  GTagTreeData_myTagRoots_children_children_children deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GTagTreeData_myTagRoots_children_children_childrenBuilder();

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
        case 'rootKind':
          result.rootKind = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GTagRootKind))!
              as _i2.GTagRootKind;
          break;
        case 'archivedAt':
          result.archivedAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
      }
    }

    return result.build();
  }
}

class _$GTagChildrenDataSerializer
    implements StructuredSerializer<GTagChildrenData> {
  @override
  final Iterable<Type> types = const [GTagChildrenData, _$GTagChildrenData];
  @override
  final String wireName = 'GTagChildrenData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GTagChildrenData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.tag;
    if (value != null) {
      result
        ..add('tag')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GTagChildrenData_tag)));
    }
    return result;
  }

  @override
  GTagChildrenData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GTagChildrenDataBuilder();

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
        case 'tag':
          result.tag.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GTagChildrenData_tag))!
              as GTagChildrenData_tag);
          break;
      }
    }

    return result.build();
  }
}

class _$GTagChildrenData_tagSerializer
    implements StructuredSerializer<GTagChildrenData_tag> {
  @override
  final Iterable<Type> types = const [
    GTagChildrenData_tag,
    _$GTagChildrenData_tag
  ];
  @override
  final String wireName = 'GTagChildrenData_tag';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GTagChildrenData_tag object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'children',
      serializers.serialize(object.children,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GTagChildrenData_tag_children)])),
    ];

    return result;
  }

  @override
  GTagChildrenData_tag deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GTagChildrenData_tagBuilder();

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
        case 'children':
          result.children.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GTagChildrenData_tag_children)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GTagChildrenData_tag_childrenSerializer
    implements StructuredSerializer<GTagChildrenData_tag_children> {
  @override
  final Iterable<Type> types = const [
    GTagChildrenData_tag_children,
    _$GTagChildrenData_tag_children
  ];
  @override
  final String wireName = 'GTagChildrenData_tag_children';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GTagChildrenData_tag_children object,
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
      'rootKind',
      serializers.serialize(object.rootKind,
          specifiedType: const FullType(_i2.GTagRootKind)),
      'children',
      serializers.serialize(object.children,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GTagChildrenData_tag_children_children)])),
    ];
    Object? value;
    value = object.archivedAt;
    if (value != null) {
      result
        ..add('archivedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GTime)));
    }
    return result;
  }

  @override
  GTagChildrenData_tag_children deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GTagChildrenData_tag_childrenBuilder();

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
        case 'rootKind':
          result.rootKind = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GTagRootKind))!
              as _i2.GTagRootKind;
          break;
        case 'archivedAt':
          result.archivedAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'children':
          result.children.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GTagChildrenData_tag_children_children)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GTagChildrenData_tag_children_childrenSerializer
    implements StructuredSerializer<GTagChildrenData_tag_children_children> {
  @override
  final Iterable<Type> types = const [
    GTagChildrenData_tag_children_children,
    _$GTagChildrenData_tag_children_children
  ];
  @override
  final String wireName = 'GTagChildrenData_tag_children_children';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GTagChildrenData_tag_children_children object,
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
      'rootKind',
      serializers.serialize(object.rootKind,
          specifiedType: const FullType(_i2.GTagRootKind)),
    ];
    Object? value;
    value = object.archivedAt;
    if (value != null) {
      result
        ..add('archivedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GTime)));
    }
    return result;
  }

  @override
  GTagChildrenData_tag_children_children deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GTagChildrenData_tag_children_childrenBuilder();

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
        case 'rootKind':
          result.rootKind = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GTagRootKind))!
              as _i2.GTagRootKind;
          break;
        case 'archivedAt':
          result.archivedAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
      }
    }

    return result.build();
  }
}

class _$GTagBySlugPathDataSerializer
    implements StructuredSerializer<GTagBySlugPathData> {
  @override
  final Iterable<Type> types = const [GTagBySlugPathData, _$GTagBySlugPathData];
  @override
  final String wireName = 'GTagBySlugPathData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GTagBySlugPathData object,
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
            specifiedType: const FullType(GTagBySlugPathData_tagBySlugPath)));
    }
    return result;
  }

  @override
  GTagBySlugPathData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GTagBySlugPathDataBuilder();

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
                      const FullType(GTagBySlugPathData_tagBySlugPath))!
              as GTagBySlugPathData_tagBySlugPath);
          break;
      }
    }

    return result.build();
  }
}

class _$GTagBySlugPathData_tagBySlugPathSerializer
    implements StructuredSerializer<GTagBySlugPathData_tagBySlugPath> {
  @override
  final Iterable<Type> types = const [
    GTagBySlugPathData_tagBySlugPath,
    _$GTagBySlugPathData_tagBySlugPath
  ];
  @override
  final String wireName = 'GTagBySlugPathData_tagBySlugPath';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GTagBySlugPathData_tagBySlugPath object,
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
      'rootKind',
      serializers.serialize(object.rootKind,
          specifiedType: const FullType(_i2.GTagRootKind)),
    ];
    Object? value;
    value = object.archivedAt;
    if (value != null) {
      result
        ..add('archivedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GTime)));
    }
    return result;
  }

  @override
  GTagBySlugPathData_tagBySlugPath deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GTagBySlugPathData_tagBySlugPathBuilder();

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
        case 'rootKind':
          result.rootKind = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GTagRootKind))!
              as _i2.GTagRootKind;
          break;
        case 'archivedAt':
          result.archivedAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
      }
    }

    return result.build();
  }
}

class _$GTagSummaryDataSerializer
    implements StructuredSerializer<GTagSummaryData> {
  @override
  final Iterable<Type> types = const [GTagSummaryData, _$GTagSummaryData];
  @override
  final String wireName = 'GTagSummaryData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GTagSummaryData object,
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
      'rootKind',
      serializers.serialize(object.rootKind,
          specifiedType: const FullType(_i2.GTagRootKind)),
    ];
    Object? value;
    value = object.archivedAt;
    if (value != null) {
      result
        ..add('archivedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GTime)));
    }
    return result;
  }

  @override
  GTagSummaryData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GTagSummaryDataBuilder();

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
        case 'rootKind':
          result.rootKind = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GTagRootKind))!
              as _i2.GTagRootKind;
          break;
        case 'archivedAt':
          result.archivedAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
      }
    }

    return result.build();
  }
}

class _$GTagTreeData extends GTagTreeData {
  @override
  final String G__typename;
  @override
  final BuiltList<GTagTreeData_myTagRoots> myTagRoots;

  factory _$GTagTreeData([void Function(GTagTreeDataBuilder)? updates]) =>
      (GTagTreeDataBuilder()..update(updates))._build();

  _$GTagTreeData._({required this.G__typename, required this.myTagRoots})
      : super._();
  @override
  GTagTreeData rebuild(void Function(GTagTreeDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GTagTreeDataBuilder toBuilder() => GTagTreeDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GTagTreeData &&
        G__typename == other.G__typename &&
        myTagRoots == other.myTagRoots;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, myTagRoots.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GTagTreeData')
          ..add('G__typename', G__typename)
          ..add('myTagRoots', myTagRoots))
        .toString();
  }
}

class GTagTreeDataBuilder
    implements Builder<GTagTreeData, GTagTreeDataBuilder> {
  _$GTagTreeData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GTagTreeData_myTagRoots>? _myTagRoots;
  ListBuilder<GTagTreeData_myTagRoots> get myTagRoots =>
      _$this._myTagRoots ??= ListBuilder<GTagTreeData_myTagRoots>();
  set myTagRoots(ListBuilder<GTagTreeData_myTagRoots>? myTagRoots) =>
      _$this._myTagRoots = myTagRoots;

  GTagTreeDataBuilder() {
    GTagTreeData._initializeBuilder(this);
  }

  GTagTreeDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _myTagRoots = $v.myTagRoots.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GTagTreeData other) {
    _$v = other as _$GTagTreeData;
  }

  @override
  void update(void Function(GTagTreeDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GTagTreeData build() => _build();

  _$GTagTreeData _build() {
    _$GTagTreeData _$result;
    try {
      _$result = _$v ??
          _$GTagTreeData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GTagTreeData', 'G__typename'),
            myTagRoots: myTagRoots.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'myTagRoots';
        myTagRoots.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GTagTreeData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GTagTreeData_myTagRoots extends GTagTreeData_myTagRoots {
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
  final _i2.GTagRootKind rootKind;
  @override
  final _i2.GTime? archivedAt;
  @override
  final BuiltList<GTagTreeData_myTagRoots_children> children;

  factory _$GTagTreeData_myTagRoots(
          [void Function(GTagTreeData_myTagRootsBuilder)? updates]) =>
      (GTagTreeData_myTagRootsBuilder()..update(updates))._build();

  _$GTagTreeData_myTagRoots._(
      {required this.G__typename,
      required this.id,
      required this.slug,
      required this.displayName,
      required this.path,
      required this.rootKind,
      this.archivedAt,
      required this.children})
      : super._();
  @override
  GTagTreeData_myTagRoots rebuild(
          void Function(GTagTreeData_myTagRootsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GTagTreeData_myTagRootsBuilder toBuilder() =>
      GTagTreeData_myTagRootsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GTagTreeData_myTagRoots &&
        G__typename == other.G__typename &&
        id == other.id &&
        slug == other.slug &&
        displayName == other.displayName &&
        path == other.path &&
        rootKind == other.rootKind &&
        archivedAt == other.archivedAt &&
        children == other.children;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jc(_$hash, rootKind.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jc(_$hash, children.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GTagTreeData_myTagRoots')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('slug', slug)
          ..add('displayName', displayName)
          ..add('path', path)
          ..add('rootKind', rootKind)
          ..add('archivedAt', archivedAt)
          ..add('children', children))
        .toString();
  }
}

class GTagTreeData_myTagRootsBuilder
    implements
        Builder<GTagTreeData_myTagRoots, GTagTreeData_myTagRootsBuilder> {
  _$GTagTreeData_myTagRoots? _$v;

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

  _i2.GTagRootKind? _rootKind;
  _i2.GTagRootKind? get rootKind => _$this._rootKind;
  set rootKind(_i2.GTagRootKind? rootKind) => _$this._rootKind = rootKind;

  _i2.GTimeBuilder? _archivedAt;
  _i2.GTimeBuilder get archivedAt => _$this._archivedAt ??= _i2.GTimeBuilder();
  set archivedAt(_i2.GTimeBuilder? archivedAt) =>
      _$this._archivedAt = archivedAt;

  ListBuilder<GTagTreeData_myTagRoots_children>? _children;
  ListBuilder<GTagTreeData_myTagRoots_children> get children =>
      _$this._children ??= ListBuilder<GTagTreeData_myTagRoots_children>();
  set children(ListBuilder<GTagTreeData_myTagRoots_children>? children) =>
      _$this._children = children;

  GTagTreeData_myTagRootsBuilder() {
    GTagTreeData_myTagRoots._initializeBuilder(this);
  }

  GTagTreeData_myTagRootsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _slug = $v.slug;
      _displayName = $v.displayName;
      _path = $v.path;
      _rootKind = $v.rootKind;
      _archivedAt = $v.archivedAt?.toBuilder();
      _children = $v.children.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GTagTreeData_myTagRoots other) {
    _$v = other as _$GTagTreeData_myTagRoots;
  }

  @override
  void update(void Function(GTagTreeData_myTagRootsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GTagTreeData_myTagRoots build() => _build();

  _$GTagTreeData_myTagRoots _build() {
    _$GTagTreeData_myTagRoots _$result;
    try {
      _$result = _$v ??
          _$GTagTreeData_myTagRoots._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GTagTreeData_myTagRoots', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GTagTreeData_myTagRoots', 'id'),
            slug: BuiltValueNullFieldError.checkNotNull(
                slug, r'GTagTreeData_myTagRoots', 'slug'),
            displayName: BuiltValueNullFieldError.checkNotNull(
                displayName, r'GTagTreeData_myTagRoots', 'displayName'),
            path: BuiltValueNullFieldError.checkNotNull(
                path, r'GTagTreeData_myTagRoots', 'path'),
            rootKind: BuiltValueNullFieldError.checkNotNull(
                rootKind, r'GTagTreeData_myTagRoots', 'rootKind'),
            archivedAt: _archivedAt?.build(),
            children: children.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'archivedAt';
        _archivedAt?.build();
        _$failedField = 'children';
        children.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GTagTreeData_myTagRoots', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GTagTreeData_myTagRoots_children
    extends GTagTreeData_myTagRoots_children {
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
  final _i2.GTagRootKind rootKind;
  @override
  final _i2.GTime? archivedAt;
  @override
  final BuiltList<GTagTreeData_myTagRoots_children_children> children;

  factory _$GTagTreeData_myTagRoots_children(
          [void Function(GTagTreeData_myTagRoots_childrenBuilder)? updates]) =>
      (GTagTreeData_myTagRoots_childrenBuilder()..update(updates))._build();

  _$GTagTreeData_myTagRoots_children._(
      {required this.G__typename,
      required this.id,
      required this.slug,
      required this.displayName,
      required this.path,
      required this.rootKind,
      this.archivedAt,
      required this.children})
      : super._();
  @override
  GTagTreeData_myTagRoots_children rebuild(
          void Function(GTagTreeData_myTagRoots_childrenBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GTagTreeData_myTagRoots_childrenBuilder toBuilder() =>
      GTagTreeData_myTagRoots_childrenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GTagTreeData_myTagRoots_children &&
        G__typename == other.G__typename &&
        id == other.id &&
        slug == other.slug &&
        displayName == other.displayName &&
        path == other.path &&
        rootKind == other.rootKind &&
        archivedAt == other.archivedAt &&
        children == other.children;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jc(_$hash, rootKind.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jc(_$hash, children.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GTagTreeData_myTagRoots_children')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('slug', slug)
          ..add('displayName', displayName)
          ..add('path', path)
          ..add('rootKind', rootKind)
          ..add('archivedAt', archivedAt)
          ..add('children', children))
        .toString();
  }
}

class GTagTreeData_myTagRoots_childrenBuilder
    implements
        Builder<GTagTreeData_myTagRoots_children,
            GTagTreeData_myTagRoots_childrenBuilder> {
  _$GTagTreeData_myTagRoots_children? _$v;

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

  _i2.GTagRootKind? _rootKind;
  _i2.GTagRootKind? get rootKind => _$this._rootKind;
  set rootKind(_i2.GTagRootKind? rootKind) => _$this._rootKind = rootKind;

  _i2.GTimeBuilder? _archivedAt;
  _i2.GTimeBuilder get archivedAt => _$this._archivedAt ??= _i2.GTimeBuilder();
  set archivedAt(_i2.GTimeBuilder? archivedAt) =>
      _$this._archivedAt = archivedAt;

  ListBuilder<GTagTreeData_myTagRoots_children_children>? _children;
  ListBuilder<GTagTreeData_myTagRoots_children_children> get children =>
      _$this._children ??=
          ListBuilder<GTagTreeData_myTagRoots_children_children>();
  set children(
          ListBuilder<GTagTreeData_myTagRoots_children_children>? children) =>
      _$this._children = children;

  GTagTreeData_myTagRoots_childrenBuilder() {
    GTagTreeData_myTagRoots_children._initializeBuilder(this);
  }

  GTagTreeData_myTagRoots_childrenBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _slug = $v.slug;
      _displayName = $v.displayName;
      _path = $v.path;
      _rootKind = $v.rootKind;
      _archivedAt = $v.archivedAt?.toBuilder();
      _children = $v.children.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GTagTreeData_myTagRoots_children other) {
    _$v = other as _$GTagTreeData_myTagRoots_children;
  }

  @override
  void update(void Function(GTagTreeData_myTagRoots_childrenBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GTagTreeData_myTagRoots_children build() => _build();

  _$GTagTreeData_myTagRoots_children _build() {
    _$GTagTreeData_myTagRoots_children _$result;
    try {
      _$result = _$v ??
          _$GTagTreeData_myTagRoots_children._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GTagTreeData_myTagRoots_children', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GTagTreeData_myTagRoots_children', 'id'),
            slug: BuiltValueNullFieldError.checkNotNull(
                slug, r'GTagTreeData_myTagRoots_children', 'slug'),
            displayName: BuiltValueNullFieldError.checkNotNull(displayName,
                r'GTagTreeData_myTagRoots_children', 'displayName'),
            path: BuiltValueNullFieldError.checkNotNull(
                path, r'GTagTreeData_myTagRoots_children', 'path'),
            rootKind: BuiltValueNullFieldError.checkNotNull(
                rootKind, r'GTagTreeData_myTagRoots_children', 'rootKind'),
            archivedAt: _archivedAt?.build(),
            children: children.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'archivedAt';
        _archivedAt?.build();
        _$failedField = 'children';
        children.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GTagTreeData_myTagRoots_children', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GTagTreeData_myTagRoots_children_children
    extends GTagTreeData_myTagRoots_children_children {
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
  final _i2.GTagRootKind rootKind;
  @override
  final _i2.GTime? archivedAt;
  @override
  final BuiltList<GTagTreeData_myTagRoots_children_children_children> children;

  factory _$GTagTreeData_myTagRoots_children_children(
          [void Function(GTagTreeData_myTagRoots_children_childrenBuilder)?
              updates]) =>
      (GTagTreeData_myTagRoots_children_childrenBuilder()..update(updates))
          ._build();

  _$GTagTreeData_myTagRoots_children_children._(
      {required this.G__typename,
      required this.id,
      required this.slug,
      required this.displayName,
      required this.path,
      required this.rootKind,
      this.archivedAt,
      required this.children})
      : super._();
  @override
  GTagTreeData_myTagRoots_children_children rebuild(
          void Function(GTagTreeData_myTagRoots_children_childrenBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GTagTreeData_myTagRoots_children_childrenBuilder toBuilder() =>
      GTagTreeData_myTagRoots_children_childrenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GTagTreeData_myTagRoots_children_children &&
        G__typename == other.G__typename &&
        id == other.id &&
        slug == other.slug &&
        displayName == other.displayName &&
        path == other.path &&
        rootKind == other.rootKind &&
        archivedAt == other.archivedAt &&
        children == other.children;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jc(_$hash, rootKind.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jc(_$hash, children.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GTagTreeData_myTagRoots_children_children')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('slug', slug)
          ..add('displayName', displayName)
          ..add('path', path)
          ..add('rootKind', rootKind)
          ..add('archivedAt', archivedAt)
          ..add('children', children))
        .toString();
  }
}

class GTagTreeData_myTagRoots_children_childrenBuilder
    implements
        Builder<GTagTreeData_myTagRoots_children_children,
            GTagTreeData_myTagRoots_children_childrenBuilder> {
  _$GTagTreeData_myTagRoots_children_children? _$v;

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

  _i2.GTagRootKind? _rootKind;
  _i2.GTagRootKind? get rootKind => _$this._rootKind;
  set rootKind(_i2.GTagRootKind? rootKind) => _$this._rootKind = rootKind;

  _i2.GTimeBuilder? _archivedAt;
  _i2.GTimeBuilder get archivedAt => _$this._archivedAt ??= _i2.GTimeBuilder();
  set archivedAt(_i2.GTimeBuilder? archivedAt) =>
      _$this._archivedAt = archivedAt;

  ListBuilder<GTagTreeData_myTagRoots_children_children_children>? _children;
  ListBuilder<GTagTreeData_myTagRoots_children_children_children>
      get children => _$this._children ??=
          ListBuilder<GTagTreeData_myTagRoots_children_children_children>();
  set children(
          ListBuilder<GTagTreeData_myTagRoots_children_children_children>?
              children) =>
      _$this._children = children;

  GTagTreeData_myTagRoots_children_childrenBuilder() {
    GTagTreeData_myTagRoots_children_children._initializeBuilder(this);
  }

  GTagTreeData_myTagRoots_children_childrenBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _slug = $v.slug;
      _displayName = $v.displayName;
      _path = $v.path;
      _rootKind = $v.rootKind;
      _archivedAt = $v.archivedAt?.toBuilder();
      _children = $v.children.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GTagTreeData_myTagRoots_children_children other) {
    _$v = other as _$GTagTreeData_myTagRoots_children_children;
  }

  @override
  void update(
      void Function(GTagTreeData_myTagRoots_children_childrenBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GTagTreeData_myTagRoots_children_children build() => _build();

  _$GTagTreeData_myTagRoots_children_children _build() {
    _$GTagTreeData_myTagRoots_children_children _$result;
    try {
      _$result = _$v ??
          _$GTagTreeData_myTagRoots_children_children._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GTagTreeData_myTagRoots_children_children', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GTagTreeData_myTagRoots_children_children', 'id'),
            slug: BuiltValueNullFieldError.checkNotNull(
                slug, r'GTagTreeData_myTagRoots_children_children', 'slug'),
            displayName: BuiltValueNullFieldError.checkNotNull(displayName,
                r'GTagTreeData_myTagRoots_children_children', 'displayName'),
            path: BuiltValueNullFieldError.checkNotNull(
                path, r'GTagTreeData_myTagRoots_children_children', 'path'),
            rootKind: BuiltValueNullFieldError.checkNotNull(rootKind,
                r'GTagTreeData_myTagRoots_children_children', 'rootKind'),
            archivedAt: _archivedAt?.build(),
            children: children.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'archivedAt';
        _archivedAt?.build();
        _$failedField = 'children';
        children.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GTagTreeData_myTagRoots_children_children',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GTagTreeData_myTagRoots_children_children_children
    extends GTagTreeData_myTagRoots_children_children_children {
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
  final _i2.GTagRootKind rootKind;
  @override
  final _i2.GTime? archivedAt;

  factory _$GTagTreeData_myTagRoots_children_children_children(
          [void Function(
                  GTagTreeData_myTagRoots_children_children_childrenBuilder)?
              updates]) =>
      (GTagTreeData_myTagRoots_children_children_childrenBuilder()
            ..update(updates))
          ._build();

  _$GTagTreeData_myTagRoots_children_children_children._(
      {required this.G__typename,
      required this.id,
      required this.slug,
      required this.displayName,
      required this.path,
      required this.rootKind,
      this.archivedAt})
      : super._();
  @override
  GTagTreeData_myTagRoots_children_children_children rebuild(
          void Function(
                  GTagTreeData_myTagRoots_children_children_childrenBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GTagTreeData_myTagRoots_children_children_childrenBuilder toBuilder() =>
      GTagTreeData_myTagRoots_children_children_childrenBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GTagTreeData_myTagRoots_children_children_children &&
        G__typename == other.G__typename &&
        id == other.id &&
        slug == other.slug &&
        displayName == other.displayName &&
        path == other.path &&
        rootKind == other.rootKind &&
        archivedAt == other.archivedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jc(_$hash, rootKind.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GTagTreeData_myTagRoots_children_children_children')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('slug', slug)
          ..add('displayName', displayName)
          ..add('path', path)
          ..add('rootKind', rootKind)
          ..add('archivedAt', archivedAt))
        .toString();
  }
}

class GTagTreeData_myTagRoots_children_children_childrenBuilder
    implements
        Builder<GTagTreeData_myTagRoots_children_children_children,
            GTagTreeData_myTagRoots_children_children_childrenBuilder> {
  _$GTagTreeData_myTagRoots_children_children_children? _$v;

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

  _i2.GTagRootKind? _rootKind;
  _i2.GTagRootKind? get rootKind => _$this._rootKind;
  set rootKind(_i2.GTagRootKind? rootKind) => _$this._rootKind = rootKind;

  _i2.GTimeBuilder? _archivedAt;
  _i2.GTimeBuilder get archivedAt => _$this._archivedAt ??= _i2.GTimeBuilder();
  set archivedAt(_i2.GTimeBuilder? archivedAt) =>
      _$this._archivedAt = archivedAt;

  GTagTreeData_myTagRoots_children_children_childrenBuilder() {
    GTagTreeData_myTagRoots_children_children_children._initializeBuilder(this);
  }

  GTagTreeData_myTagRoots_children_children_childrenBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _slug = $v.slug;
      _displayName = $v.displayName;
      _path = $v.path;
      _rootKind = $v.rootKind;
      _archivedAt = $v.archivedAt?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GTagTreeData_myTagRoots_children_children_children other) {
    _$v = other as _$GTagTreeData_myTagRoots_children_children_children;
  }

  @override
  void update(
      void Function(GTagTreeData_myTagRoots_children_children_childrenBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GTagTreeData_myTagRoots_children_children_children build() => _build();

  _$GTagTreeData_myTagRoots_children_children_children _build() {
    _$GTagTreeData_myTagRoots_children_children_children _$result;
    try {
      _$result = _$v ??
          _$GTagTreeData_myTagRoots_children_children_children._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GTagTreeData_myTagRoots_children_children_children',
                'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(id,
                r'GTagTreeData_myTagRoots_children_children_children', 'id'),
            slug: BuiltValueNullFieldError.checkNotNull(slug,
                r'GTagTreeData_myTagRoots_children_children_children', 'slug'),
            displayName: BuiltValueNullFieldError.checkNotNull(
                displayName,
                r'GTagTreeData_myTagRoots_children_children_children',
                'displayName'),
            path: BuiltValueNullFieldError.checkNotNull(path,
                r'GTagTreeData_myTagRoots_children_children_children', 'path'),
            rootKind: BuiltValueNullFieldError.checkNotNull(
                rootKind,
                r'GTagTreeData_myTagRoots_children_children_children',
                'rootKind'),
            archivedAt: _archivedAt?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'archivedAt';
        _archivedAt?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GTagTreeData_myTagRoots_children_children_children',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GTagChildrenData extends GTagChildrenData {
  @override
  final String G__typename;
  @override
  final GTagChildrenData_tag? tag;

  factory _$GTagChildrenData(
          [void Function(GTagChildrenDataBuilder)? updates]) =>
      (GTagChildrenDataBuilder()..update(updates))._build();

  _$GTagChildrenData._({required this.G__typename, this.tag}) : super._();
  @override
  GTagChildrenData rebuild(void Function(GTagChildrenDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GTagChildrenDataBuilder toBuilder() =>
      GTagChildrenDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GTagChildrenData &&
        G__typename == other.G__typename &&
        tag == other.tag;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, tag.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GTagChildrenData')
          ..add('G__typename', G__typename)
          ..add('tag', tag))
        .toString();
  }
}

class GTagChildrenDataBuilder
    implements Builder<GTagChildrenData, GTagChildrenDataBuilder> {
  _$GTagChildrenData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GTagChildrenData_tagBuilder? _tag;
  GTagChildrenData_tagBuilder get tag =>
      _$this._tag ??= GTagChildrenData_tagBuilder();
  set tag(GTagChildrenData_tagBuilder? tag) => _$this._tag = tag;

  GTagChildrenDataBuilder() {
    GTagChildrenData._initializeBuilder(this);
  }

  GTagChildrenDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _tag = $v.tag?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GTagChildrenData other) {
    _$v = other as _$GTagChildrenData;
  }

  @override
  void update(void Function(GTagChildrenDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GTagChildrenData build() => _build();

  _$GTagChildrenData _build() {
    _$GTagChildrenData _$result;
    try {
      _$result = _$v ??
          _$GTagChildrenData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GTagChildrenData', 'G__typename'),
            tag: _tag?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tag';
        _tag?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GTagChildrenData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GTagChildrenData_tag extends GTagChildrenData_tag {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final BuiltList<GTagChildrenData_tag_children> children;

  factory _$GTagChildrenData_tag(
          [void Function(GTagChildrenData_tagBuilder)? updates]) =>
      (GTagChildrenData_tagBuilder()..update(updates))._build();

  _$GTagChildrenData_tag._(
      {required this.G__typename, required this.id, required this.children})
      : super._();
  @override
  GTagChildrenData_tag rebuild(
          void Function(GTagChildrenData_tagBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GTagChildrenData_tagBuilder toBuilder() =>
      GTagChildrenData_tagBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GTagChildrenData_tag &&
        G__typename == other.G__typename &&
        id == other.id &&
        children == other.children;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, children.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GTagChildrenData_tag')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('children', children))
        .toString();
  }
}

class GTagChildrenData_tagBuilder
    implements Builder<GTagChildrenData_tag, GTagChildrenData_tagBuilder> {
  _$GTagChildrenData_tag? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  ListBuilder<GTagChildrenData_tag_children>? _children;
  ListBuilder<GTagChildrenData_tag_children> get children =>
      _$this._children ??= ListBuilder<GTagChildrenData_tag_children>();
  set children(ListBuilder<GTagChildrenData_tag_children>? children) =>
      _$this._children = children;

  GTagChildrenData_tagBuilder() {
    GTagChildrenData_tag._initializeBuilder(this);
  }

  GTagChildrenData_tagBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _children = $v.children.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GTagChildrenData_tag other) {
    _$v = other as _$GTagChildrenData_tag;
  }

  @override
  void update(void Function(GTagChildrenData_tagBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GTagChildrenData_tag build() => _build();

  _$GTagChildrenData_tag _build() {
    _$GTagChildrenData_tag _$result;
    try {
      _$result = _$v ??
          _$GTagChildrenData_tag._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GTagChildrenData_tag', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GTagChildrenData_tag', 'id'),
            children: children.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'children';
        children.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GTagChildrenData_tag', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GTagChildrenData_tag_children extends GTagChildrenData_tag_children {
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
  final _i2.GTagRootKind rootKind;
  @override
  final _i2.GTime? archivedAt;
  @override
  final BuiltList<GTagChildrenData_tag_children_children> children;

  factory _$GTagChildrenData_tag_children(
          [void Function(GTagChildrenData_tag_childrenBuilder)? updates]) =>
      (GTagChildrenData_tag_childrenBuilder()..update(updates))._build();

  _$GTagChildrenData_tag_children._(
      {required this.G__typename,
      required this.id,
      required this.slug,
      required this.displayName,
      required this.path,
      required this.rootKind,
      this.archivedAt,
      required this.children})
      : super._();
  @override
  GTagChildrenData_tag_children rebuild(
          void Function(GTagChildrenData_tag_childrenBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GTagChildrenData_tag_childrenBuilder toBuilder() =>
      GTagChildrenData_tag_childrenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GTagChildrenData_tag_children &&
        G__typename == other.G__typename &&
        id == other.id &&
        slug == other.slug &&
        displayName == other.displayName &&
        path == other.path &&
        rootKind == other.rootKind &&
        archivedAt == other.archivedAt &&
        children == other.children;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jc(_$hash, rootKind.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jc(_$hash, children.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GTagChildrenData_tag_children')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('slug', slug)
          ..add('displayName', displayName)
          ..add('path', path)
          ..add('rootKind', rootKind)
          ..add('archivedAt', archivedAt)
          ..add('children', children))
        .toString();
  }
}

class GTagChildrenData_tag_childrenBuilder
    implements
        Builder<GTagChildrenData_tag_children,
            GTagChildrenData_tag_childrenBuilder> {
  _$GTagChildrenData_tag_children? _$v;

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

  _i2.GTagRootKind? _rootKind;
  _i2.GTagRootKind? get rootKind => _$this._rootKind;
  set rootKind(_i2.GTagRootKind? rootKind) => _$this._rootKind = rootKind;

  _i2.GTimeBuilder? _archivedAt;
  _i2.GTimeBuilder get archivedAt => _$this._archivedAt ??= _i2.GTimeBuilder();
  set archivedAt(_i2.GTimeBuilder? archivedAt) =>
      _$this._archivedAt = archivedAt;

  ListBuilder<GTagChildrenData_tag_children_children>? _children;
  ListBuilder<GTagChildrenData_tag_children_children> get children =>
      _$this._children ??=
          ListBuilder<GTagChildrenData_tag_children_children>();
  set children(ListBuilder<GTagChildrenData_tag_children_children>? children) =>
      _$this._children = children;

  GTagChildrenData_tag_childrenBuilder() {
    GTagChildrenData_tag_children._initializeBuilder(this);
  }

  GTagChildrenData_tag_childrenBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _slug = $v.slug;
      _displayName = $v.displayName;
      _path = $v.path;
      _rootKind = $v.rootKind;
      _archivedAt = $v.archivedAt?.toBuilder();
      _children = $v.children.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GTagChildrenData_tag_children other) {
    _$v = other as _$GTagChildrenData_tag_children;
  }

  @override
  void update(void Function(GTagChildrenData_tag_childrenBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GTagChildrenData_tag_children build() => _build();

  _$GTagChildrenData_tag_children _build() {
    _$GTagChildrenData_tag_children _$result;
    try {
      _$result = _$v ??
          _$GTagChildrenData_tag_children._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GTagChildrenData_tag_children', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GTagChildrenData_tag_children', 'id'),
            slug: BuiltValueNullFieldError.checkNotNull(
                slug, r'GTagChildrenData_tag_children', 'slug'),
            displayName: BuiltValueNullFieldError.checkNotNull(
                displayName, r'GTagChildrenData_tag_children', 'displayName'),
            path: BuiltValueNullFieldError.checkNotNull(
                path, r'GTagChildrenData_tag_children', 'path'),
            rootKind: BuiltValueNullFieldError.checkNotNull(
                rootKind, r'GTagChildrenData_tag_children', 'rootKind'),
            archivedAt: _archivedAt?.build(),
            children: children.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'archivedAt';
        _archivedAt?.build();
        _$failedField = 'children';
        children.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GTagChildrenData_tag_children', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GTagChildrenData_tag_children_children
    extends GTagChildrenData_tag_children_children {
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
  final _i2.GTagRootKind rootKind;
  @override
  final _i2.GTime? archivedAt;

  factory _$GTagChildrenData_tag_children_children(
          [void Function(GTagChildrenData_tag_children_childrenBuilder)?
              updates]) =>
      (GTagChildrenData_tag_children_childrenBuilder()..update(updates))
          ._build();

  _$GTagChildrenData_tag_children_children._(
      {required this.G__typename,
      required this.id,
      required this.slug,
      required this.displayName,
      required this.path,
      required this.rootKind,
      this.archivedAt})
      : super._();
  @override
  GTagChildrenData_tag_children_children rebuild(
          void Function(GTagChildrenData_tag_children_childrenBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GTagChildrenData_tag_children_childrenBuilder toBuilder() =>
      GTagChildrenData_tag_children_childrenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GTagChildrenData_tag_children_children &&
        G__typename == other.G__typename &&
        id == other.id &&
        slug == other.slug &&
        displayName == other.displayName &&
        path == other.path &&
        rootKind == other.rootKind &&
        archivedAt == other.archivedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jc(_$hash, rootKind.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GTagChildrenData_tag_children_children')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('slug', slug)
          ..add('displayName', displayName)
          ..add('path', path)
          ..add('rootKind', rootKind)
          ..add('archivedAt', archivedAt))
        .toString();
  }
}

class GTagChildrenData_tag_children_childrenBuilder
    implements
        Builder<GTagChildrenData_tag_children_children,
            GTagChildrenData_tag_children_childrenBuilder> {
  _$GTagChildrenData_tag_children_children? _$v;

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

  _i2.GTagRootKind? _rootKind;
  _i2.GTagRootKind? get rootKind => _$this._rootKind;
  set rootKind(_i2.GTagRootKind? rootKind) => _$this._rootKind = rootKind;

  _i2.GTimeBuilder? _archivedAt;
  _i2.GTimeBuilder get archivedAt => _$this._archivedAt ??= _i2.GTimeBuilder();
  set archivedAt(_i2.GTimeBuilder? archivedAt) =>
      _$this._archivedAt = archivedAt;

  GTagChildrenData_tag_children_childrenBuilder() {
    GTagChildrenData_tag_children_children._initializeBuilder(this);
  }

  GTagChildrenData_tag_children_childrenBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _slug = $v.slug;
      _displayName = $v.displayName;
      _path = $v.path;
      _rootKind = $v.rootKind;
      _archivedAt = $v.archivedAt?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GTagChildrenData_tag_children_children other) {
    _$v = other as _$GTagChildrenData_tag_children_children;
  }

  @override
  void update(
      void Function(GTagChildrenData_tag_children_childrenBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GTagChildrenData_tag_children_children build() => _build();

  _$GTagChildrenData_tag_children_children _build() {
    _$GTagChildrenData_tag_children_children _$result;
    try {
      _$result = _$v ??
          _$GTagChildrenData_tag_children_children._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GTagChildrenData_tag_children_children', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GTagChildrenData_tag_children_children', 'id'),
            slug: BuiltValueNullFieldError.checkNotNull(
                slug, r'GTagChildrenData_tag_children_children', 'slug'),
            displayName: BuiltValueNullFieldError.checkNotNull(displayName,
                r'GTagChildrenData_tag_children_children', 'displayName'),
            path: BuiltValueNullFieldError.checkNotNull(
                path, r'GTagChildrenData_tag_children_children', 'path'),
            rootKind: BuiltValueNullFieldError.checkNotNull(rootKind,
                r'GTagChildrenData_tag_children_children', 'rootKind'),
            archivedAt: _archivedAt?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'archivedAt';
        _archivedAt?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GTagChildrenData_tag_children_children',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GTagBySlugPathData extends GTagBySlugPathData {
  @override
  final String G__typename;
  @override
  final GTagBySlugPathData_tagBySlugPath? tagBySlugPath;

  factory _$GTagBySlugPathData(
          [void Function(GTagBySlugPathDataBuilder)? updates]) =>
      (GTagBySlugPathDataBuilder()..update(updates))._build();

  _$GTagBySlugPathData._({required this.G__typename, this.tagBySlugPath})
      : super._();
  @override
  GTagBySlugPathData rebuild(
          void Function(GTagBySlugPathDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GTagBySlugPathDataBuilder toBuilder() =>
      GTagBySlugPathDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GTagBySlugPathData &&
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
    return (newBuiltValueToStringHelper(r'GTagBySlugPathData')
          ..add('G__typename', G__typename)
          ..add('tagBySlugPath', tagBySlugPath))
        .toString();
  }
}

class GTagBySlugPathDataBuilder
    implements Builder<GTagBySlugPathData, GTagBySlugPathDataBuilder> {
  _$GTagBySlugPathData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GTagBySlugPathData_tagBySlugPathBuilder? _tagBySlugPath;
  GTagBySlugPathData_tagBySlugPathBuilder get tagBySlugPath =>
      _$this._tagBySlugPath ??= GTagBySlugPathData_tagBySlugPathBuilder();
  set tagBySlugPath(GTagBySlugPathData_tagBySlugPathBuilder? tagBySlugPath) =>
      _$this._tagBySlugPath = tagBySlugPath;

  GTagBySlugPathDataBuilder() {
    GTagBySlugPathData._initializeBuilder(this);
  }

  GTagBySlugPathDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _tagBySlugPath = $v.tagBySlugPath?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GTagBySlugPathData other) {
    _$v = other as _$GTagBySlugPathData;
  }

  @override
  void update(void Function(GTagBySlugPathDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GTagBySlugPathData build() => _build();

  _$GTagBySlugPathData _build() {
    _$GTagBySlugPathData _$result;
    try {
      _$result = _$v ??
          _$GTagBySlugPathData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GTagBySlugPathData', 'G__typename'),
            tagBySlugPath: _tagBySlugPath?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tagBySlugPath';
        _tagBySlugPath?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GTagBySlugPathData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GTagBySlugPathData_tagBySlugPath
    extends GTagBySlugPathData_tagBySlugPath {
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
  final _i2.GTagRootKind rootKind;
  @override
  final _i2.GTime? archivedAt;

  factory _$GTagBySlugPathData_tagBySlugPath(
          [void Function(GTagBySlugPathData_tagBySlugPathBuilder)? updates]) =>
      (GTagBySlugPathData_tagBySlugPathBuilder()..update(updates))._build();

  _$GTagBySlugPathData_tagBySlugPath._(
      {required this.G__typename,
      required this.id,
      required this.slug,
      required this.displayName,
      required this.path,
      required this.rootKind,
      this.archivedAt})
      : super._();
  @override
  GTagBySlugPathData_tagBySlugPath rebuild(
          void Function(GTagBySlugPathData_tagBySlugPathBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GTagBySlugPathData_tagBySlugPathBuilder toBuilder() =>
      GTagBySlugPathData_tagBySlugPathBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GTagBySlugPathData_tagBySlugPath &&
        G__typename == other.G__typename &&
        id == other.id &&
        slug == other.slug &&
        displayName == other.displayName &&
        path == other.path &&
        rootKind == other.rootKind &&
        archivedAt == other.archivedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jc(_$hash, rootKind.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GTagBySlugPathData_tagBySlugPath')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('slug', slug)
          ..add('displayName', displayName)
          ..add('path', path)
          ..add('rootKind', rootKind)
          ..add('archivedAt', archivedAt))
        .toString();
  }
}

class GTagBySlugPathData_tagBySlugPathBuilder
    implements
        Builder<GTagBySlugPathData_tagBySlugPath,
            GTagBySlugPathData_tagBySlugPathBuilder> {
  _$GTagBySlugPathData_tagBySlugPath? _$v;

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

  _i2.GTagRootKind? _rootKind;
  _i2.GTagRootKind? get rootKind => _$this._rootKind;
  set rootKind(_i2.GTagRootKind? rootKind) => _$this._rootKind = rootKind;

  _i2.GTimeBuilder? _archivedAt;
  _i2.GTimeBuilder get archivedAt => _$this._archivedAt ??= _i2.GTimeBuilder();
  set archivedAt(_i2.GTimeBuilder? archivedAt) =>
      _$this._archivedAt = archivedAt;

  GTagBySlugPathData_tagBySlugPathBuilder() {
    GTagBySlugPathData_tagBySlugPath._initializeBuilder(this);
  }

  GTagBySlugPathData_tagBySlugPathBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _slug = $v.slug;
      _displayName = $v.displayName;
      _path = $v.path;
      _rootKind = $v.rootKind;
      _archivedAt = $v.archivedAt?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GTagBySlugPathData_tagBySlugPath other) {
    _$v = other as _$GTagBySlugPathData_tagBySlugPath;
  }

  @override
  void update(void Function(GTagBySlugPathData_tagBySlugPathBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GTagBySlugPathData_tagBySlugPath build() => _build();

  _$GTagBySlugPathData_tagBySlugPath _build() {
    _$GTagBySlugPathData_tagBySlugPath _$result;
    try {
      _$result = _$v ??
          _$GTagBySlugPathData_tagBySlugPath._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GTagBySlugPathData_tagBySlugPath', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GTagBySlugPathData_tagBySlugPath', 'id'),
            slug: BuiltValueNullFieldError.checkNotNull(
                slug, r'GTagBySlugPathData_tagBySlugPath', 'slug'),
            displayName: BuiltValueNullFieldError.checkNotNull(displayName,
                r'GTagBySlugPathData_tagBySlugPath', 'displayName'),
            path: BuiltValueNullFieldError.checkNotNull(
                path, r'GTagBySlugPathData_tagBySlugPath', 'path'),
            rootKind: BuiltValueNullFieldError.checkNotNull(
                rootKind, r'GTagBySlugPathData_tagBySlugPath', 'rootKind'),
            archivedAt: _archivedAt?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'archivedAt';
        _archivedAt?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GTagBySlugPathData_tagBySlugPath', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GTagSummaryData extends GTagSummaryData {
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
  final _i2.GTagRootKind rootKind;
  @override
  final _i2.GTime? archivedAt;

  factory _$GTagSummaryData([void Function(GTagSummaryDataBuilder)? updates]) =>
      (GTagSummaryDataBuilder()..update(updates))._build();

  _$GTagSummaryData._(
      {required this.G__typename,
      required this.id,
      required this.slug,
      required this.displayName,
      required this.path,
      required this.rootKind,
      this.archivedAt})
      : super._();
  @override
  GTagSummaryData rebuild(void Function(GTagSummaryDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GTagSummaryDataBuilder toBuilder() => GTagSummaryDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GTagSummaryData &&
        G__typename == other.G__typename &&
        id == other.id &&
        slug == other.slug &&
        displayName == other.displayName &&
        path == other.path &&
        rootKind == other.rootKind &&
        archivedAt == other.archivedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, slug.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jc(_$hash, rootKind.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GTagSummaryData')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('slug', slug)
          ..add('displayName', displayName)
          ..add('path', path)
          ..add('rootKind', rootKind)
          ..add('archivedAt', archivedAt))
        .toString();
  }
}

class GTagSummaryDataBuilder
    implements Builder<GTagSummaryData, GTagSummaryDataBuilder> {
  _$GTagSummaryData? _$v;

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

  _i2.GTagRootKind? _rootKind;
  _i2.GTagRootKind? get rootKind => _$this._rootKind;
  set rootKind(_i2.GTagRootKind? rootKind) => _$this._rootKind = rootKind;

  _i2.GTimeBuilder? _archivedAt;
  _i2.GTimeBuilder get archivedAt => _$this._archivedAt ??= _i2.GTimeBuilder();
  set archivedAt(_i2.GTimeBuilder? archivedAt) =>
      _$this._archivedAt = archivedAt;

  GTagSummaryDataBuilder() {
    GTagSummaryData._initializeBuilder(this);
  }

  GTagSummaryDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _slug = $v.slug;
      _displayName = $v.displayName;
      _path = $v.path;
      _rootKind = $v.rootKind;
      _archivedAt = $v.archivedAt?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GTagSummaryData other) {
    _$v = other as _$GTagSummaryData;
  }

  @override
  void update(void Function(GTagSummaryDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GTagSummaryData build() => _build();

  _$GTagSummaryData _build() {
    _$GTagSummaryData _$result;
    try {
      _$result = _$v ??
          _$GTagSummaryData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GTagSummaryData', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GTagSummaryData', 'id'),
            slug: BuiltValueNullFieldError.checkNotNull(
                slug, r'GTagSummaryData', 'slug'),
            displayName: BuiltValueNullFieldError.checkNotNull(
                displayName, r'GTagSummaryData', 'displayName'),
            path: BuiltValueNullFieldError.checkNotNull(
                path, r'GTagSummaryData', 'path'),
            rootKind: BuiltValueNullFieldError.checkNotNull(
                rootKind, r'GTagSummaryData', 'rootKind'),
            archivedAt: _archivedAt?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'archivedAt';
        _archivedAt?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GTagSummaryData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
