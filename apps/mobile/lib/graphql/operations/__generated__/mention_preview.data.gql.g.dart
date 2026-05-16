// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mention_preview.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMentionPreviewUserData> _$gMentionPreviewUserDataSerializer =
    _$GMentionPreviewUserDataSerializer();
Serializer<GMentionPreviewUserData_userByHandle>
    _$gMentionPreviewUserDataUserByHandleSerializer =
    _$GMentionPreviewUserData_userByHandleSerializer();
Serializer<GMentionPreviewUserData_userByHandle_homeTag>
    _$gMentionPreviewUserDataUserByHandleHomeTagSerializer =
    _$GMentionPreviewUserData_userByHandle_homeTagSerializer();
Serializer<GMentionPreviewUserData_userByHandle_recentPosts>
    _$gMentionPreviewUserDataUserByHandleRecentPostsSerializer =
    _$GMentionPreviewUserData_userByHandle_recentPostsSerializer();
Serializer<GMentionPreviewUserData_userByHandle_recentPosts_author>
    _$gMentionPreviewUserDataUserByHandleRecentPostsAuthorSerializer =
    _$GMentionPreviewUserData_userByHandle_recentPosts_authorSerializer();
Serializer<GMentionPreviewTagData> _$gMentionPreviewTagDataSerializer =
    _$GMentionPreviewTagDataSerializer();
Serializer<GMentionPreviewTagData_tagBySlugPath>
    _$gMentionPreviewTagDataTagBySlugPathSerializer =
    _$GMentionPreviewTagData_tagBySlugPathSerializer();
Serializer<GMentionPreviewTagData_tagBySlugPath_parent>
    _$gMentionPreviewTagDataTagBySlugPathParentSerializer =
    _$GMentionPreviewTagData_tagBySlugPath_parentSerializer();
Serializer<GMentionPreviewTagData_tagBySlugPath_posts>
    _$gMentionPreviewTagDataTagBySlugPathPostsSerializer =
    _$GMentionPreviewTagData_tagBySlugPath_postsSerializer();
Serializer<GMentionPreviewTagData_tagBySlugPath_posts_edges>
    _$gMentionPreviewTagDataTagBySlugPathPostsEdgesSerializer =
    _$GMentionPreviewTagData_tagBySlugPath_posts_edgesSerializer();
Serializer<GMentionPreviewTagData_tagBySlugPath_posts_edges_node>
    _$gMentionPreviewTagDataTagBySlugPathPostsEdgesNodeSerializer =
    _$GMentionPreviewTagData_tagBySlugPath_posts_edges_nodeSerializer();
Serializer<GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author>
    _$gMentionPreviewTagDataTagBySlugPathPostsEdgesNodeAuthorSerializer =
    _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node_authorSerializer();
Serializer<GMentionPreviewPostData> _$gMentionPreviewPostDataSerializer =
    _$GMentionPreviewPostDataSerializer();
Serializer<GMentionPreviewPostData_author>
    _$gMentionPreviewPostDataAuthorSerializer =
    _$GMentionPreviewPostData_authorSerializer();

class _$GMentionPreviewUserDataSerializer
    implements StructuredSerializer<GMentionPreviewUserData> {
  @override
  final Iterable<Type> types = const [
    GMentionPreviewUserData,
    _$GMentionPreviewUserData
  ];
  @override
  final String wireName = 'GMentionPreviewUserData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMentionPreviewUserData object,
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
            specifiedType:
                const FullType(GMentionPreviewUserData_userByHandle)));
    }
    return result;
  }

  @override
  GMentionPreviewUserData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionPreviewUserDataBuilder();

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
                      const FullType(GMentionPreviewUserData_userByHandle))!
              as GMentionPreviewUserData_userByHandle);
          break;
      }
    }

    return result.build();
  }
}

class _$GMentionPreviewUserData_userByHandleSerializer
    implements StructuredSerializer<GMentionPreviewUserData_userByHandle> {
  @override
  final Iterable<Type> types = const [
    GMentionPreviewUserData_userByHandle,
    _$GMentionPreviewUserData_userByHandle
  ];
  @override
  final String wireName = 'GMentionPreviewUserData_userByHandle';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMentionPreviewUserData_userByHandle object,
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
      'recentPosts',
      serializers.serialize(object.recentPosts,
          specifiedType: const FullType(BuiltList, const [
            const FullType(GMentionPreviewUserData_userByHandle_recentPosts)
          ])),
    ];
    Object? value;
    value = object.homeTag;
    if (value != null) {
      result
        ..add('homeTag')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GMentionPreviewUserData_userByHandle_homeTag)));
    }
    return result;
  }

  @override
  GMentionPreviewUserData_userByHandle deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionPreviewUserData_userByHandleBuilder();

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
                      GMentionPreviewUserData_userByHandle_homeTag))!
              as GMentionPreviewUserData_userByHandle_homeTag);
          break;
        case 'recentPosts':
          result.recentPosts.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GMentionPreviewUserData_userByHandle_recentPosts)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GMentionPreviewUserData_userByHandle_homeTagSerializer
    implements
        StructuredSerializer<GMentionPreviewUserData_userByHandle_homeTag> {
  @override
  final Iterable<Type> types = const [
    GMentionPreviewUserData_userByHandle_homeTag,
    _$GMentionPreviewUserData_userByHandle_homeTag
  ];
  @override
  final String wireName = 'GMentionPreviewUserData_userByHandle_homeTag';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GMentionPreviewUserData_userByHandle_homeTag object,
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
  GMentionPreviewUserData_userByHandle_homeTag deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionPreviewUserData_userByHandle_homeTagBuilder();

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

class _$GMentionPreviewUserData_userByHandle_recentPostsSerializer
    implements
        StructuredSerializer<GMentionPreviewUserData_userByHandle_recentPosts> {
  @override
  final Iterable<Type> types = const [
    GMentionPreviewUserData_userByHandle_recentPosts,
    _$GMentionPreviewUserData_userByHandle_recentPosts
  ];
  @override
  final String wireName = 'GMentionPreviewUserData_userByHandle_recentPosts';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GMentionPreviewUserData_userByHandle_recentPosts object,
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
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GTime)),
      'author',
      serializers.serialize(object.author,
          specifiedType: const FullType(
              GMentionPreviewUserData_userByHandle_recentPosts_author)),
    ];

    return result;
  }

  @override
  GMentionPreviewUserData_userByHandle_recentPosts deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionPreviewUserData_userByHandle_recentPostsBuilder();

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
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'author':
          result.author.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GMentionPreviewUserData_userByHandle_recentPosts_author))!
              as GMentionPreviewUserData_userByHandle_recentPosts_author);
          break;
      }
    }

    return result.build();
  }
}

class _$GMentionPreviewUserData_userByHandle_recentPosts_authorSerializer
    implements
        StructuredSerializer<
            GMentionPreviewUserData_userByHandle_recentPosts_author> {
  @override
  final Iterable<Type> types = const [
    GMentionPreviewUserData_userByHandle_recentPosts_author,
    _$GMentionPreviewUserData_userByHandle_recentPosts_author
  ];
  @override
  final String wireName =
      'GMentionPreviewUserData_userByHandle_recentPosts_author';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GMentionPreviewUserData_userByHandle_recentPosts_author object,
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
  GMentionPreviewUserData_userByHandle_recentPosts_author deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GMentionPreviewUserData_userByHandle_recentPosts_authorBuilder();

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

class _$GMentionPreviewTagDataSerializer
    implements StructuredSerializer<GMentionPreviewTagData> {
  @override
  final Iterable<Type> types = const [
    GMentionPreviewTagData,
    _$GMentionPreviewTagData
  ];
  @override
  final String wireName = 'GMentionPreviewTagData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMentionPreviewTagData object,
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
            specifiedType:
                const FullType(GMentionPreviewTagData_tagBySlugPath)));
    }
    return result;
  }

  @override
  GMentionPreviewTagData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionPreviewTagDataBuilder();

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
                      const FullType(GMentionPreviewTagData_tagBySlugPath))!
              as GMentionPreviewTagData_tagBySlugPath);
          break;
      }
    }

    return result.build();
  }
}

class _$GMentionPreviewTagData_tagBySlugPathSerializer
    implements StructuredSerializer<GMentionPreviewTagData_tagBySlugPath> {
  @override
  final Iterable<Type> types = const [
    GMentionPreviewTagData_tagBySlugPath,
    _$GMentionPreviewTagData_tagBySlugPath
  ];
  @override
  final String wireName = 'GMentionPreviewTagData_tagBySlugPath';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMentionPreviewTagData_tagBySlugPath object,
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
      'posts',
      serializers.serialize(object.posts,
          specifiedType:
              const FullType(GMentionPreviewTagData_tagBySlugPath_posts)),
    ];
    Object? value;
    value = object.parent;
    if (value != null) {
      result
        ..add('parent')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GMentionPreviewTagData_tagBySlugPath_parent)));
    }
    return result;
  }

  @override
  GMentionPreviewTagData_tagBySlugPath deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionPreviewTagData_tagBySlugPathBuilder();

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
        case 'parent':
          result.parent.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GMentionPreviewTagData_tagBySlugPath_parent))!
              as GMentionPreviewTagData_tagBySlugPath_parent);
          break;
        case 'posts':
          result.posts.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GMentionPreviewTagData_tagBySlugPath_posts))!
              as GMentionPreviewTagData_tagBySlugPath_posts);
          break;
      }
    }

    return result.build();
  }
}

class _$GMentionPreviewTagData_tagBySlugPath_parentSerializer
    implements
        StructuredSerializer<GMentionPreviewTagData_tagBySlugPath_parent> {
  @override
  final Iterable<Type> types = const [
    GMentionPreviewTagData_tagBySlugPath_parent,
    _$GMentionPreviewTagData_tagBySlugPath_parent
  ];
  @override
  final String wireName = 'GMentionPreviewTagData_tagBySlugPath_parent';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GMentionPreviewTagData_tagBySlugPath_parent object,
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
  GMentionPreviewTagData_tagBySlugPath_parent deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionPreviewTagData_tagBySlugPath_parentBuilder();

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

class _$GMentionPreviewTagData_tagBySlugPath_postsSerializer
    implements
        StructuredSerializer<GMentionPreviewTagData_tagBySlugPath_posts> {
  @override
  final Iterable<Type> types = const [
    GMentionPreviewTagData_tagBySlugPath_posts,
    _$GMentionPreviewTagData_tagBySlugPath_posts
  ];
  @override
  final String wireName = 'GMentionPreviewTagData_tagBySlugPath_posts';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GMentionPreviewTagData_tagBySlugPath_posts object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'edges',
      serializers.serialize(object.edges,
          specifiedType: const FullType(BuiltList, const [
            const FullType(GMentionPreviewTagData_tagBySlugPath_posts_edges)
          ])),
    ];

    return result;
  }

  @override
  GMentionPreviewTagData_tagBySlugPath_posts deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionPreviewTagData_tagBySlugPath_postsBuilder();

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
                const FullType(GMentionPreviewTagData_tagBySlugPath_posts_edges)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GMentionPreviewTagData_tagBySlugPath_posts_edgesSerializer
    implements
        StructuredSerializer<GMentionPreviewTagData_tagBySlugPath_posts_edges> {
  @override
  final Iterable<Type> types = const [
    GMentionPreviewTagData_tagBySlugPath_posts_edges,
    _$GMentionPreviewTagData_tagBySlugPath_posts_edges
  ];
  @override
  final String wireName = 'GMentionPreviewTagData_tagBySlugPath_posts_edges';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GMentionPreviewTagData_tagBySlugPath_posts_edges object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'node',
      serializers.serialize(object.node,
          specifiedType: const FullType(
              GMentionPreviewTagData_tagBySlugPath_posts_edges_node)),
    ];

    return result;
  }

  @override
  GMentionPreviewTagData_tagBySlugPath_posts_edges deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionPreviewTagData_tagBySlugPath_posts_edgesBuilder();

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
        case 'node':
          result.node.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GMentionPreviewTagData_tagBySlugPath_posts_edges_node))!
              as GMentionPreviewTagData_tagBySlugPath_posts_edges_node);
          break;
      }
    }

    return result.build();
  }
}

class _$GMentionPreviewTagData_tagBySlugPath_posts_edges_nodeSerializer
    implements
        StructuredSerializer<
            GMentionPreviewTagData_tagBySlugPath_posts_edges_node> {
  @override
  final Iterable<Type> types = const [
    GMentionPreviewTagData_tagBySlugPath_posts_edges_node,
    _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node
  ];
  @override
  final String wireName =
      'GMentionPreviewTagData_tagBySlugPath_posts_edges_node';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GMentionPreviewTagData_tagBySlugPath_posts_edges_node object,
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
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GTime)),
      'author',
      serializers.serialize(object.author,
          specifiedType: const FullType(
              GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author)),
    ];

    return result;
  }

  @override
  GMentionPreviewTagData_tagBySlugPath_posts_edges_node deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GMentionPreviewTagData_tagBySlugPath_posts_edges_nodeBuilder();

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
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'author':
          result.author.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author))!
              as GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author);
          break;
      }
    }

    return result.build();
  }
}

class _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node_authorSerializer
    implements
        StructuredSerializer<
            GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author> {
  @override
  final Iterable<Type> types = const [
    GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author,
    _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author
  ];
  @override
  final String wireName =
      'GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author object,
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
  GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GMentionPreviewTagData_tagBySlugPath_posts_edges_node_authorBuilder();

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

class _$GMentionPreviewPostDataSerializer
    implements StructuredSerializer<GMentionPreviewPostData> {
  @override
  final Iterable<Type> types = const [
    GMentionPreviewPostData,
    _$GMentionPreviewPostData
  ];
  @override
  final String wireName = 'GMentionPreviewPostData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMentionPreviewPostData object,
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
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GTime)),
      'author',
      serializers.serialize(object.author,
          specifiedType: const FullType(GMentionPreviewPostData_author)),
    ];

    return result;
  }

  @override
  GMentionPreviewPostData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionPreviewPostDataBuilder();

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
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'author':
          result.author.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GMentionPreviewPostData_author))!
              as GMentionPreviewPostData_author);
          break;
      }
    }

    return result.build();
  }
}

class _$GMentionPreviewPostData_authorSerializer
    implements StructuredSerializer<GMentionPreviewPostData_author> {
  @override
  final Iterable<Type> types = const [
    GMentionPreviewPostData_author,
    _$GMentionPreviewPostData_author
  ];
  @override
  final String wireName = 'GMentionPreviewPostData_author';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMentionPreviewPostData_author object,
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
  GMentionPreviewPostData_author deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMentionPreviewPostData_authorBuilder();

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

class _$GMentionPreviewUserData extends GMentionPreviewUserData {
  @override
  final String G__typename;
  @override
  final GMentionPreviewUserData_userByHandle? userByHandle;

  factory _$GMentionPreviewUserData(
          [void Function(GMentionPreviewUserDataBuilder)? updates]) =>
      (GMentionPreviewUserDataBuilder()..update(updates))._build();

  _$GMentionPreviewUserData._({required this.G__typename, this.userByHandle})
      : super._();
  @override
  GMentionPreviewUserData rebuild(
          void Function(GMentionPreviewUserDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionPreviewUserDataBuilder toBuilder() =>
      GMentionPreviewUserDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionPreviewUserData &&
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
    return (newBuiltValueToStringHelper(r'GMentionPreviewUserData')
          ..add('G__typename', G__typename)
          ..add('userByHandle', userByHandle))
        .toString();
  }
}

class GMentionPreviewUserDataBuilder
    implements
        Builder<GMentionPreviewUserData, GMentionPreviewUserDataBuilder> {
  _$GMentionPreviewUserData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GMentionPreviewUserData_userByHandleBuilder? _userByHandle;
  GMentionPreviewUserData_userByHandleBuilder get userByHandle =>
      _$this._userByHandle ??= GMentionPreviewUserData_userByHandleBuilder();
  set userByHandle(GMentionPreviewUserData_userByHandleBuilder? userByHandle) =>
      _$this._userByHandle = userByHandle;

  GMentionPreviewUserDataBuilder() {
    GMentionPreviewUserData._initializeBuilder(this);
  }

  GMentionPreviewUserDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _userByHandle = $v.userByHandle?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMentionPreviewUserData other) {
    _$v = other as _$GMentionPreviewUserData;
  }

  @override
  void update(void Function(GMentionPreviewUserDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionPreviewUserData build() => _build();

  _$GMentionPreviewUserData _build() {
    _$GMentionPreviewUserData _$result;
    try {
      _$result = _$v ??
          _$GMentionPreviewUserData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GMentionPreviewUserData', 'G__typename'),
            userByHandle: _userByHandle?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'userByHandle';
        _userByHandle?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMentionPreviewUserData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMentionPreviewUserData_userByHandle
    extends GMentionPreviewUserData_userByHandle {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;
  @override
  final GMentionPreviewUserData_userByHandle_homeTag? homeTag;
  @override
  final BuiltList<GMentionPreviewUserData_userByHandle_recentPosts> recentPosts;

  factory _$GMentionPreviewUserData_userByHandle(
          [void Function(GMentionPreviewUserData_userByHandleBuilder)?
              updates]) =>
      (GMentionPreviewUserData_userByHandleBuilder()..update(updates))._build();

  _$GMentionPreviewUserData_userByHandle._(
      {required this.G__typename,
      required this.id,
      required this.displayName,
      this.homeTag,
      required this.recentPosts})
      : super._();
  @override
  GMentionPreviewUserData_userByHandle rebuild(
          void Function(GMentionPreviewUserData_userByHandleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionPreviewUserData_userByHandleBuilder toBuilder() =>
      GMentionPreviewUserData_userByHandleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionPreviewUserData_userByHandle &&
        G__typename == other.G__typename &&
        id == other.id &&
        displayName == other.displayName &&
        homeTag == other.homeTag &&
        recentPosts == other.recentPosts;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, homeTag.hashCode);
    _$hash = $jc(_$hash, recentPosts.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMentionPreviewUserData_userByHandle')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName)
          ..add('homeTag', homeTag)
          ..add('recentPosts', recentPosts))
        .toString();
  }
}

class GMentionPreviewUserData_userByHandleBuilder
    implements
        Builder<GMentionPreviewUserData_userByHandle,
            GMentionPreviewUserData_userByHandleBuilder> {
  _$GMentionPreviewUserData_userByHandle? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GMentionPreviewUserData_userByHandle_homeTagBuilder? _homeTag;
  GMentionPreviewUserData_userByHandle_homeTagBuilder get homeTag =>
      _$this._homeTag ??= GMentionPreviewUserData_userByHandle_homeTagBuilder();
  set homeTag(GMentionPreviewUserData_userByHandle_homeTagBuilder? homeTag) =>
      _$this._homeTag = homeTag;

  ListBuilder<GMentionPreviewUserData_userByHandle_recentPosts>? _recentPosts;
  ListBuilder<GMentionPreviewUserData_userByHandle_recentPosts>
      get recentPosts => _$this._recentPosts ??=
          ListBuilder<GMentionPreviewUserData_userByHandle_recentPosts>();
  set recentPosts(
          ListBuilder<GMentionPreviewUserData_userByHandle_recentPosts>?
              recentPosts) =>
      _$this._recentPosts = recentPosts;

  GMentionPreviewUserData_userByHandleBuilder() {
    GMentionPreviewUserData_userByHandle._initializeBuilder(this);
  }

  GMentionPreviewUserData_userByHandleBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _displayName = $v.displayName;
      _homeTag = $v.homeTag?.toBuilder();
      _recentPosts = $v.recentPosts.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMentionPreviewUserData_userByHandle other) {
    _$v = other as _$GMentionPreviewUserData_userByHandle;
  }

  @override
  void update(
      void Function(GMentionPreviewUserData_userByHandleBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionPreviewUserData_userByHandle build() => _build();

  _$GMentionPreviewUserData_userByHandle _build() {
    _$GMentionPreviewUserData_userByHandle _$result;
    try {
      _$result = _$v ??
          _$GMentionPreviewUserData_userByHandle._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GMentionPreviewUserData_userByHandle', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GMentionPreviewUserData_userByHandle', 'id'),
            displayName: BuiltValueNullFieldError.checkNotNull(displayName,
                r'GMentionPreviewUserData_userByHandle', 'displayName'),
            homeTag: _homeTag?.build(),
            recentPosts: recentPosts.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'homeTag';
        _homeTag?.build();
        _$failedField = 'recentPosts';
        recentPosts.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMentionPreviewUserData_userByHandle',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMentionPreviewUserData_userByHandle_homeTag
    extends GMentionPreviewUserData_userByHandle_homeTag {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String slug;
  @override
  final String path;

  factory _$GMentionPreviewUserData_userByHandle_homeTag(
          [void Function(GMentionPreviewUserData_userByHandle_homeTagBuilder)?
              updates]) =>
      (GMentionPreviewUserData_userByHandle_homeTagBuilder()..update(updates))
          ._build();

  _$GMentionPreviewUserData_userByHandle_homeTag._(
      {required this.G__typename,
      required this.id,
      required this.slug,
      required this.path})
      : super._();
  @override
  GMentionPreviewUserData_userByHandle_homeTag rebuild(
          void Function(GMentionPreviewUserData_userByHandle_homeTagBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionPreviewUserData_userByHandle_homeTagBuilder toBuilder() =>
      GMentionPreviewUserData_userByHandle_homeTagBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionPreviewUserData_userByHandle_homeTag &&
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
            r'GMentionPreviewUserData_userByHandle_homeTag')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('slug', slug)
          ..add('path', path))
        .toString();
  }
}

class GMentionPreviewUserData_userByHandle_homeTagBuilder
    implements
        Builder<GMentionPreviewUserData_userByHandle_homeTag,
            GMentionPreviewUserData_userByHandle_homeTagBuilder> {
  _$GMentionPreviewUserData_userByHandle_homeTag? _$v;

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

  GMentionPreviewUserData_userByHandle_homeTagBuilder() {
    GMentionPreviewUserData_userByHandle_homeTag._initializeBuilder(this);
  }

  GMentionPreviewUserData_userByHandle_homeTagBuilder get _$this {
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
  void replace(GMentionPreviewUserData_userByHandle_homeTag other) {
    _$v = other as _$GMentionPreviewUserData_userByHandle_homeTag;
  }

  @override
  void update(
      void Function(GMentionPreviewUserData_userByHandle_homeTagBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionPreviewUserData_userByHandle_homeTag build() => _build();

  _$GMentionPreviewUserData_userByHandle_homeTag _build() {
    final _$result = _$v ??
        _$GMentionPreviewUserData_userByHandle_homeTag._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GMentionPreviewUserData_userByHandle_homeTag', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GMentionPreviewUserData_userByHandle_homeTag', 'id'),
          slug: BuiltValueNullFieldError.checkNotNull(
              slug, r'GMentionPreviewUserData_userByHandle_homeTag', 'slug'),
          path: BuiltValueNullFieldError.checkNotNull(
              path, r'GMentionPreviewUserData_userByHandle_homeTag', 'path'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GMentionPreviewUserData_userByHandle_recentPosts
    extends GMentionPreviewUserData_userByHandle_recentPosts {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String title;
  @override
  final _i2.GTime createdAt;
  @override
  final GMentionPreviewUserData_userByHandle_recentPosts_author author;

  factory _$GMentionPreviewUserData_userByHandle_recentPosts(
          [void Function(
                  GMentionPreviewUserData_userByHandle_recentPostsBuilder)?
              updates]) =>
      (GMentionPreviewUserData_userByHandle_recentPostsBuilder()
            ..update(updates))
          ._build();

  _$GMentionPreviewUserData_userByHandle_recentPosts._(
      {required this.G__typename,
      required this.id,
      required this.title,
      required this.createdAt,
      required this.author})
      : super._();
  @override
  GMentionPreviewUserData_userByHandle_recentPosts rebuild(
          void Function(GMentionPreviewUserData_userByHandle_recentPostsBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionPreviewUserData_userByHandle_recentPostsBuilder toBuilder() =>
      GMentionPreviewUserData_userByHandle_recentPostsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionPreviewUserData_userByHandle_recentPosts &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        createdAt == other.createdAt &&
        author == other.author;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GMentionPreviewUserData_userByHandle_recentPosts')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('createdAt', createdAt)
          ..add('author', author))
        .toString();
  }
}

class GMentionPreviewUserData_userByHandle_recentPostsBuilder
    implements
        Builder<GMentionPreviewUserData_userByHandle_recentPosts,
            GMentionPreviewUserData_userByHandle_recentPostsBuilder> {
  _$GMentionPreviewUserData_userByHandle_recentPosts? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  _i2.GTimeBuilder? _createdAt;
  _i2.GTimeBuilder get createdAt => _$this._createdAt ??= _i2.GTimeBuilder();
  set createdAt(_i2.GTimeBuilder? createdAt) => _$this._createdAt = createdAt;

  GMentionPreviewUserData_userByHandle_recentPosts_authorBuilder? _author;
  GMentionPreviewUserData_userByHandle_recentPosts_authorBuilder get author =>
      _$this._author ??=
          GMentionPreviewUserData_userByHandle_recentPosts_authorBuilder();
  set author(
          GMentionPreviewUserData_userByHandle_recentPosts_authorBuilder?
              author) =>
      _$this._author = author;

  GMentionPreviewUserData_userByHandle_recentPostsBuilder() {
    GMentionPreviewUserData_userByHandle_recentPosts._initializeBuilder(this);
  }

  GMentionPreviewUserData_userByHandle_recentPostsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _createdAt = $v.createdAt.toBuilder();
      _author = $v.author.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMentionPreviewUserData_userByHandle_recentPosts other) {
    _$v = other as _$GMentionPreviewUserData_userByHandle_recentPosts;
  }

  @override
  void update(
      void Function(GMentionPreviewUserData_userByHandle_recentPostsBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionPreviewUserData_userByHandle_recentPosts build() => _build();

  _$GMentionPreviewUserData_userByHandle_recentPosts _build() {
    _$GMentionPreviewUserData_userByHandle_recentPosts _$result;
    try {
      _$result = _$v ??
          _$GMentionPreviewUserData_userByHandle_recentPosts._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GMentionPreviewUserData_userByHandle_recentPosts',
                'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GMentionPreviewUserData_userByHandle_recentPosts', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(title,
                r'GMentionPreviewUserData_userByHandle_recentPosts', 'title'),
            createdAt: createdAt.build(),
            author: author.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'author';
        author.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMentionPreviewUserData_userByHandle_recentPosts',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMentionPreviewUserData_userByHandle_recentPosts_author
    extends GMentionPreviewUserData_userByHandle_recentPosts_author {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;

  factory _$GMentionPreviewUserData_userByHandle_recentPosts_author(
          [void Function(
                  GMentionPreviewUserData_userByHandle_recentPosts_authorBuilder)?
              updates]) =>
      (GMentionPreviewUserData_userByHandle_recentPosts_authorBuilder()
            ..update(updates))
          ._build();

  _$GMentionPreviewUserData_userByHandle_recentPosts_author._(
      {required this.G__typename, required this.id, required this.displayName})
      : super._();
  @override
  GMentionPreviewUserData_userByHandle_recentPosts_author rebuild(
          void Function(
                  GMentionPreviewUserData_userByHandle_recentPosts_authorBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionPreviewUserData_userByHandle_recentPosts_authorBuilder toBuilder() =>
      GMentionPreviewUserData_userByHandle_recentPosts_authorBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionPreviewUserData_userByHandle_recentPosts_author &&
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
            r'GMentionPreviewUserData_userByHandle_recentPosts_author')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName))
        .toString();
  }
}

class GMentionPreviewUserData_userByHandle_recentPosts_authorBuilder
    implements
        Builder<GMentionPreviewUserData_userByHandle_recentPosts_author,
            GMentionPreviewUserData_userByHandle_recentPosts_authorBuilder> {
  _$GMentionPreviewUserData_userByHandle_recentPosts_author? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GMentionPreviewUserData_userByHandle_recentPosts_authorBuilder() {
    GMentionPreviewUserData_userByHandle_recentPosts_author._initializeBuilder(
        this);
  }

  GMentionPreviewUserData_userByHandle_recentPosts_authorBuilder get _$this {
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
  void replace(GMentionPreviewUserData_userByHandle_recentPosts_author other) {
    _$v = other as _$GMentionPreviewUserData_userByHandle_recentPosts_author;
  }

  @override
  void update(
      void Function(
              GMentionPreviewUserData_userByHandle_recentPosts_authorBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionPreviewUserData_userByHandle_recentPosts_author build() => _build();

  _$GMentionPreviewUserData_userByHandle_recentPosts_author _build() {
    final _$result = _$v ??
        _$GMentionPreviewUserData_userByHandle_recentPosts_author._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GMentionPreviewUserData_userByHandle_recentPosts_author',
              'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(id,
              r'GMentionPreviewUserData_userByHandle_recentPosts_author', 'id'),
          displayName: BuiltValueNullFieldError.checkNotNull(
              displayName,
              r'GMentionPreviewUserData_userByHandle_recentPosts_author',
              'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GMentionPreviewTagData extends GMentionPreviewTagData {
  @override
  final String G__typename;
  @override
  final GMentionPreviewTagData_tagBySlugPath? tagBySlugPath;

  factory _$GMentionPreviewTagData(
          [void Function(GMentionPreviewTagDataBuilder)? updates]) =>
      (GMentionPreviewTagDataBuilder()..update(updates))._build();

  _$GMentionPreviewTagData._({required this.G__typename, this.tagBySlugPath})
      : super._();
  @override
  GMentionPreviewTagData rebuild(
          void Function(GMentionPreviewTagDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionPreviewTagDataBuilder toBuilder() =>
      GMentionPreviewTagDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionPreviewTagData &&
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
    return (newBuiltValueToStringHelper(r'GMentionPreviewTagData')
          ..add('G__typename', G__typename)
          ..add('tagBySlugPath', tagBySlugPath))
        .toString();
  }
}

class GMentionPreviewTagDataBuilder
    implements Builder<GMentionPreviewTagData, GMentionPreviewTagDataBuilder> {
  _$GMentionPreviewTagData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GMentionPreviewTagData_tagBySlugPathBuilder? _tagBySlugPath;
  GMentionPreviewTagData_tagBySlugPathBuilder get tagBySlugPath =>
      _$this._tagBySlugPath ??= GMentionPreviewTagData_tagBySlugPathBuilder();
  set tagBySlugPath(
          GMentionPreviewTagData_tagBySlugPathBuilder? tagBySlugPath) =>
      _$this._tagBySlugPath = tagBySlugPath;

  GMentionPreviewTagDataBuilder() {
    GMentionPreviewTagData._initializeBuilder(this);
  }

  GMentionPreviewTagDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _tagBySlugPath = $v.tagBySlugPath?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMentionPreviewTagData other) {
    _$v = other as _$GMentionPreviewTagData;
  }

  @override
  void update(void Function(GMentionPreviewTagDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionPreviewTagData build() => _build();

  _$GMentionPreviewTagData _build() {
    _$GMentionPreviewTagData _$result;
    try {
      _$result = _$v ??
          _$GMentionPreviewTagData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GMentionPreviewTagData', 'G__typename'),
            tagBySlugPath: _tagBySlugPath?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tagBySlugPath';
        _tagBySlugPath?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMentionPreviewTagData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMentionPreviewTagData_tagBySlugPath
    extends GMentionPreviewTagData_tagBySlugPath {
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
  final GMentionPreviewTagData_tagBySlugPath_parent? parent;
  @override
  final GMentionPreviewTagData_tagBySlugPath_posts posts;

  factory _$GMentionPreviewTagData_tagBySlugPath(
          [void Function(GMentionPreviewTagData_tagBySlugPathBuilder)?
              updates]) =>
      (GMentionPreviewTagData_tagBySlugPathBuilder()..update(updates))._build();

  _$GMentionPreviewTagData_tagBySlugPath._(
      {required this.G__typename,
      required this.id,
      required this.slug,
      required this.displayName,
      required this.path,
      required this.rootKind,
      this.parent,
      required this.posts})
      : super._();
  @override
  GMentionPreviewTagData_tagBySlugPath rebuild(
          void Function(GMentionPreviewTagData_tagBySlugPathBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionPreviewTagData_tagBySlugPathBuilder toBuilder() =>
      GMentionPreviewTagData_tagBySlugPathBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionPreviewTagData_tagBySlugPath &&
        G__typename == other.G__typename &&
        id == other.id &&
        slug == other.slug &&
        displayName == other.displayName &&
        path == other.path &&
        rootKind == other.rootKind &&
        parent == other.parent &&
        posts == other.posts;
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
    _$hash = $jc(_$hash, parent.hashCode);
    _$hash = $jc(_$hash, posts.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMentionPreviewTagData_tagBySlugPath')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('slug', slug)
          ..add('displayName', displayName)
          ..add('path', path)
          ..add('rootKind', rootKind)
          ..add('parent', parent)
          ..add('posts', posts))
        .toString();
  }
}

class GMentionPreviewTagData_tagBySlugPathBuilder
    implements
        Builder<GMentionPreviewTagData_tagBySlugPath,
            GMentionPreviewTagData_tagBySlugPathBuilder> {
  _$GMentionPreviewTagData_tagBySlugPath? _$v;

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

  GMentionPreviewTagData_tagBySlugPath_parentBuilder? _parent;
  GMentionPreviewTagData_tagBySlugPath_parentBuilder get parent =>
      _$this._parent ??= GMentionPreviewTagData_tagBySlugPath_parentBuilder();
  set parent(GMentionPreviewTagData_tagBySlugPath_parentBuilder? parent) =>
      _$this._parent = parent;

  GMentionPreviewTagData_tagBySlugPath_postsBuilder? _posts;
  GMentionPreviewTagData_tagBySlugPath_postsBuilder get posts =>
      _$this._posts ??= GMentionPreviewTagData_tagBySlugPath_postsBuilder();
  set posts(GMentionPreviewTagData_tagBySlugPath_postsBuilder? posts) =>
      _$this._posts = posts;

  GMentionPreviewTagData_tagBySlugPathBuilder() {
    GMentionPreviewTagData_tagBySlugPath._initializeBuilder(this);
  }

  GMentionPreviewTagData_tagBySlugPathBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _slug = $v.slug;
      _displayName = $v.displayName;
      _path = $v.path;
      _rootKind = $v.rootKind;
      _parent = $v.parent?.toBuilder();
      _posts = $v.posts.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMentionPreviewTagData_tagBySlugPath other) {
    _$v = other as _$GMentionPreviewTagData_tagBySlugPath;
  }

  @override
  void update(
      void Function(GMentionPreviewTagData_tagBySlugPathBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionPreviewTagData_tagBySlugPath build() => _build();

  _$GMentionPreviewTagData_tagBySlugPath _build() {
    _$GMentionPreviewTagData_tagBySlugPath _$result;
    try {
      _$result = _$v ??
          _$GMentionPreviewTagData_tagBySlugPath._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GMentionPreviewTagData_tagBySlugPath', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GMentionPreviewTagData_tagBySlugPath', 'id'),
            slug: BuiltValueNullFieldError.checkNotNull(
                slug, r'GMentionPreviewTagData_tagBySlugPath', 'slug'),
            displayName: BuiltValueNullFieldError.checkNotNull(displayName,
                r'GMentionPreviewTagData_tagBySlugPath', 'displayName'),
            path: BuiltValueNullFieldError.checkNotNull(
                path, r'GMentionPreviewTagData_tagBySlugPath', 'path'),
            rootKind: BuiltValueNullFieldError.checkNotNull(
                rootKind, r'GMentionPreviewTagData_tagBySlugPath', 'rootKind'),
            parent: _parent?.build(),
            posts: posts.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'parent';
        _parent?.build();
        _$failedField = 'posts';
        posts.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMentionPreviewTagData_tagBySlugPath',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMentionPreviewTagData_tagBySlugPath_parent
    extends GMentionPreviewTagData_tagBySlugPath_parent {
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

  factory _$GMentionPreviewTagData_tagBySlugPath_parent(
          [void Function(GMentionPreviewTagData_tagBySlugPath_parentBuilder)?
              updates]) =>
      (GMentionPreviewTagData_tagBySlugPath_parentBuilder()..update(updates))
          ._build();

  _$GMentionPreviewTagData_tagBySlugPath_parent._(
      {required this.G__typename,
      required this.id,
      required this.slug,
      required this.displayName,
      required this.path})
      : super._();
  @override
  GMentionPreviewTagData_tagBySlugPath_parent rebuild(
          void Function(GMentionPreviewTagData_tagBySlugPath_parentBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionPreviewTagData_tagBySlugPath_parentBuilder toBuilder() =>
      GMentionPreviewTagData_tagBySlugPath_parentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionPreviewTagData_tagBySlugPath_parent &&
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
    return (newBuiltValueToStringHelper(
            r'GMentionPreviewTagData_tagBySlugPath_parent')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('slug', slug)
          ..add('displayName', displayName)
          ..add('path', path))
        .toString();
  }
}

class GMentionPreviewTagData_tagBySlugPath_parentBuilder
    implements
        Builder<GMentionPreviewTagData_tagBySlugPath_parent,
            GMentionPreviewTagData_tagBySlugPath_parentBuilder> {
  _$GMentionPreviewTagData_tagBySlugPath_parent? _$v;

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

  GMentionPreviewTagData_tagBySlugPath_parentBuilder() {
    GMentionPreviewTagData_tagBySlugPath_parent._initializeBuilder(this);
  }

  GMentionPreviewTagData_tagBySlugPath_parentBuilder get _$this {
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
  void replace(GMentionPreviewTagData_tagBySlugPath_parent other) {
    _$v = other as _$GMentionPreviewTagData_tagBySlugPath_parent;
  }

  @override
  void update(
      void Function(GMentionPreviewTagData_tagBySlugPath_parentBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionPreviewTagData_tagBySlugPath_parent build() => _build();

  _$GMentionPreviewTagData_tagBySlugPath_parent _build() {
    final _$result = _$v ??
        _$GMentionPreviewTagData_tagBySlugPath_parent._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GMentionPreviewTagData_tagBySlugPath_parent', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GMentionPreviewTagData_tagBySlugPath_parent', 'id'),
          slug: BuiltValueNullFieldError.checkNotNull(
              slug, r'GMentionPreviewTagData_tagBySlugPath_parent', 'slug'),
          displayName: BuiltValueNullFieldError.checkNotNull(displayName,
              r'GMentionPreviewTagData_tagBySlugPath_parent', 'displayName'),
          path: BuiltValueNullFieldError.checkNotNull(
              path, r'GMentionPreviewTagData_tagBySlugPath_parent', 'path'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GMentionPreviewTagData_tagBySlugPath_posts
    extends GMentionPreviewTagData_tagBySlugPath_posts {
  @override
  final String G__typename;
  @override
  final BuiltList<GMentionPreviewTagData_tagBySlugPath_posts_edges> edges;

  factory _$GMentionPreviewTagData_tagBySlugPath_posts(
          [void Function(GMentionPreviewTagData_tagBySlugPath_postsBuilder)?
              updates]) =>
      (GMentionPreviewTagData_tagBySlugPath_postsBuilder()..update(updates))
          ._build();

  _$GMentionPreviewTagData_tagBySlugPath_posts._(
      {required this.G__typename, required this.edges})
      : super._();
  @override
  GMentionPreviewTagData_tagBySlugPath_posts rebuild(
          void Function(GMentionPreviewTagData_tagBySlugPath_postsBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionPreviewTagData_tagBySlugPath_postsBuilder toBuilder() =>
      GMentionPreviewTagData_tagBySlugPath_postsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionPreviewTagData_tagBySlugPath_posts &&
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
    return (newBuiltValueToStringHelper(
            r'GMentionPreviewTagData_tagBySlugPath_posts')
          ..add('G__typename', G__typename)
          ..add('edges', edges))
        .toString();
  }
}

class GMentionPreviewTagData_tagBySlugPath_postsBuilder
    implements
        Builder<GMentionPreviewTagData_tagBySlugPath_posts,
            GMentionPreviewTagData_tagBySlugPath_postsBuilder> {
  _$GMentionPreviewTagData_tagBySlugPath_posts? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GMentionPreviewTagData_tagBySlugPath_posts_edges>? _edges;
  ListBuilder<GMentionPreviewTagData_tagBySlugPath_posts_edges> get edges =>
      _$this._edges ??=
          ListBuilder<GMentionPreviewTagData_tagBySlugPath_posts_edges>();
  set edges(
          ListBuilder<GMentionPreviewTagData_tagBySlugPath_posts_edges>?
              edges) =>
      _$this._edges = edges;

  GMentionPreviewTagData_tagBySlugPath_postsBuilder() {
    GMentionPreviewTagData_tagBySlugPath_posts._initializeBuilder(this);
  }

  GMentionPreviewTagData_tagBySlugPath_postsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _edges = $v.edges.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMentionPreviewTagData_tagBySlugPath_posts other) {
    _$v = other as _$GMentionPreviewTagData_tagBySlugPath_posts;
  }

  @override
  void update(
      void Function(GMentionPreviewTagData_tagBySlugPath_postsBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionPreviewTagData_tagBySlugPath_posts build() => _build();

  _$GMentionPreviewTagData_tagBySlugPath_posts _build() {
    _$GMentionPreviewTagData_tagBySlugPath_posts _$result;
    try {
      _$result = _$v ??
          _$GMentionPreviewTagData_tagBySlugPath_posts._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GMentionPreviewTagData_tagBySlugPath_posts', 'G__typename'),
            edges: edges.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'edges';
        edges.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMentionPreviewTagData_tagBySlugPath_posts',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMentionPreviewTagData_tagBySlugPath_posts_edges
    extends GMentionPreviewTagData_tagBySlugPath_posts_edges {
  @override
  final String G__typename;
  @override
  final GMentionPreviewTagData_tagBySlugPath_posts_edges_node node;

  factory _$GMentionPreviewTagData_tagBySlugPath_posts_edges(
          [void Function(
                  GMentionPreviewTagData_tagBySlugPath_posts_edgesBuilder)?
              updates]) =>
      (GMentionPreviewTagData_tagBySlugPath_posts_edgesBuilder()
            ..update(updates))
          ._build();

  _$GMentionPreviewTagData_tagBySlugPath_posts_edges._(
      {required this.G__typename, required this.node})
      : super._();
  @override
  GMentionPreviewTagData_tagBySlugPath_posts_edges rebuild(
          void Function(GMentionPreviewTagData_tagBySlugPath_posts_edgesBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionPreviewTagData_tagBySlugPath_posts_edgesBuilder toBuilder() =>
      GMentionPreviewTagData_tagBySlugPath_posts_edgesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionPreviewTagData_tagBySlugPath_posts_edges &&
        G__typename == other.G__typename &&
        node == other.node;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, node.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GMentionPreviewTagData_tagBySlugPath_posts_edges')
          ..add('G__typename', G__typename)
          ..add('node', node))
        .toString();
  }
}

class GMentionPreviewTagData_tagBySlugPath_posts_edgesBuilder
    implements
        Builder<GMentionPreviewTagData_tagBySlugPath_posts_edges,
            GMentionPreviewTagData_tagBySlugPath_posts_edgesBuilder> {
  _$GMentionPreviewTagData_tagBySlugPath_posts_edges? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GMentionPreviewTagData_tagBySlugPath_posts_edges_nodeBuilder? _node;
  GMentionPreviewTagData_tagBySlugPath_posts_edges_nodeBuilder get node =>
      _$this._node ??=
          GMentionPreviewTagData_tagBySlugPath_posts_edges_nodeBuilder();
  set node(
          GMentionPreviewTagData_tagBySlugPath_posts_edges_nodeBuilder? node) =>
      _$this._node = node;

  GMentionPreviewTagData_tagBySlugPath_posts_edgesBuilder() {
    GMentionPreviewTagData_tagBySlugPath_posts_edges._initializeBuilder(this);
  }

  GMentionPreviewTagData_tagBySlugPath_posts_edgesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _node = $v.node.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMentionPreviewTagData_tagBySlugPath_posts_edges other) {
    _$v = other as _$GMentionPreviewTagData_tagBySlugPath_posts_edges;
  }

  @override
  void update(
      void Function(GMentionPreviewTagData_tagBySlugPath_posts_edgesBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionPreviewTagData_tagBySlugPath_posts_edges build() => _build();

  _$GMentionPreviewTagData_tagBySlugPath_posts_edges _build() {
    _$GMentionPreviewTagData_tagBySlugPath_posts_edges _$result;
    try {
      _$result = _$v ??
          _$GMentionPreviewTagData_tagBySlugPath_posts_edges._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GMentionPreviewTagData_tagBySlugPath_posts_edges',
                'G__typename'),
            node: node.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'node';
        node.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMentionPreviewTagData_tagBySlugPath_posts_edges',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node
    extends GMentionPreviewTagData_tagBySlugPath_posts_edges_node {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String title;
  @override
  final _i2.GTime createdAt;
  @override
  final GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author author;

  factory _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node(
          [void Function(
                  GMentionPreviewTagData_tagBySlugPath_posts_edges_nodeBuilder)?
              updates]) =>
      (GMentionPreviewTagData_tagBySlugPath_posts_edges_nodeBuilder()
            ..update(updates))
          ._build();

  _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node._(
      {required this.G__typename,
      required this.id,
      required this.title,
      required this.createdAt,
      required this.author})
      : super._();
  @override
  GMentionPreviewTagData_tagBySlugPath_posts_edges_node rebuild(
          void Function(
                  GMentionPreviewTagData_tagBySlugPath_posts_edges_nodeBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionPreviewTagData_tagBySlugPath_posts_edges_nodeBuilder toBuilder() =>
      GMentionPreviewTagData_tagBySlugPath_posts_edges_nodeBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionPreviewTagData_tagBySlugPath_posts_edges_node &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        createdAt == other.createdAt &&
        author == other.author;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GMentionPreviewTagData_tagBySlugPath_posts_edges_node')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('createdAt', createdAt)
          ..add('author', author))
        .toString();
  }
}

class GMentionPreviewTagData_tagBySlugPath_posts_edges_nodeBuilder
    implements
        Builder<GMentionPreviewTagData_tagBySlugPath_posts_edges_node,
            GMentionPreviewTagData_tagBySlugPath_posts_edges_nodeBuilder> {
  _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  _i2.GTimeBuilder? _createdAt;
  _i2.GTimeBuilder get createdAt => _$this._createdAt ??= _i2.GTimeBuilder();
  set createdAt(_i2.GTimeBuilder? createdAt) => _$this._createdAt = createdAt;

  GMentionPreviewTagData_tagBySlugPath_posts_edges_node_authorBuilder? _author;
  GMentionPreviewTagData_tagBySlugPath_posts_edges_node_authorBuilder
      get author => _$this._author ??=
          GMentionPreviewTagData_tagBySlugPath_posts_edges_node_authorBuilder();
  set author(
          GMentionPreviewTagData_tagBySlugPath_posts_edges_node_authorBuilder?
              author) =>
      _$this._author = author;

  GMentionPreviewTagData_tagBySlugPath_posts_edges_nodeBuilder() {
    GMentionPreviewTagData_tagBySlugPath_posts_edges_node._initializeBuilder(
        this);
  }

  GMentionPreviewTagData_tagBySlugPath_posts_edges_nodeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _createdAt = $v.createdAt.toBuilder();
      _author = $v.author.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMentionPreviewTagData_tagBySlugPath_posts_edges_node other) {
    _$v = other as _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node;
  }

  @override
  void update(
      void Function(
              GMentionPreviewTagData_tagBySlugPath_posts_edges_nodeBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionPreviewTagData_tagBySlugPath_posts_edges_node build() => _build();

  _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node _build() {
    _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node _$result;
    try {
      _$result = _$v ??
          _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GMentionPreviewTagData_tagBySlugPath_posts_edges_node',
                'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(id,
                r'GMentionPreviewTagData_tagBySlugPath_posts_edges_node', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title,
                r'GMentionPreviewTagData_tagBySlugPath_posts_edges_node',
                'title'),
            createdAt: createdAt.build(),
            author: author.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'author';
        author.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMentionPreviewTagData_tagBySlugPath_posts_edges_node',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author
    extends GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;

  factory _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author(
          [void Function(
                  GMentionPreviewTagData_tagBySlugPath_posts_edges_node_authorBuilder)?
              updates]) =>
      (GMentionPreviewTagData_tagBySlugPath_posts_edges_node_authorBuilder()
            ..update(updates))
          ._build();

  _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author._(
      {required this.G__typename, required this.id, required this.displayName})
      : super._();
  @override
  GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author rebuild(
          void Function(
                  GMentionPreviewTagData_tagBySlugPath_posts_edges_node_authorBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionPreviewTagData_tagBySlugPath_posts_edges_node_authorBuilder
      toBuilder() =>
          GMentionPreviewTagData_tagBySlugPath_posts_edges_node_authorBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author &&
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
            r'GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName))
        .toString();
  }
}

class GMentionPreviewTagData_tagBySlugPath_posts_edges_node_authorBuilder
    implements
        Builder<GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author,
            GMentionPreviewTagData_tagBySlugPath_posts_edges_node_authorBuilder> {
  _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GMentionPreviewTagData_tagBySlugPath_posts_edges_node_authorBuilder() {
    GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author
        ._initializeBuilder(this);
  }

  GMentionPreviewTagData_tagBySlugPath_posts_edges_node_authorBuilder
      get _$this {
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
  void replace(
      GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author other) {
    _$v =
        other as _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author;
  }

  @override
  void update(
      void Function(
              GMentionPreviewTagData_tagBySlugPath_posts_edges_node_authorBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author build() =>
      _build();

  _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author _build() {
    final _$result = _$v ??
        _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author',
              'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author',
              'id'),
          displayName: BuiltValueNullFieldError.checkNotNull(
              displayName,
              r'GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author',
              'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GMentionPreviewPostData extends GMentionPreviewPostData {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String title;
  @override
  final _i2.GTime createdAt;
  @override
  final GMentionPreviewPostData_author author;

  factory _$GMentionPreviewPostData(
          [void Function(GMentionPreviewPostDataBuilder)? updates]) =>
      (GMentionPreviewPostDataBuilder()..update(updates))._build();

  _$GMentionPreviewPostData._(
      {required this.G__typename,
      required this.id,
      required this.title,
      required this.createdAt,
      required this.author})
      : super._();
  @override
  GMentionPreviewPostData rebuild(
          void Function(GMentionPreviewPostDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionPreviewPostDataBuilder toBuilder() =>
      GMentionPreviewPostDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionPreviewPostData &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        createdAt == other.createdAt &&
        author == other.author;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMentionPreviewPostData')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('createdAt', createdAt)
          ..add('author', author))
        .toString();
  }
}

class GMentionPreviewPostDataBuilder
    implements
        Builder<GMentionPreviewPostData, GMentionPreviewPostDataBuilder> {
  _$GMentionPreviewPostData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  _i2.GTimeBuilder? _createdAt;
  _i2.GTimeBuilder get createdAt => _$this._createdAt ??= _i2.GTimeBuilder();
  set createdAt(_i2.GTimeBuilder? createdAt) => _$this._createdAt = createdAt;

  GMentionPreviewPostData_authorBuilder? _author;
  GMentionPreviewPostData_authorBuilder get author =>
      _$this._author ??= GMentionPreviewPostData_authorBuilder();
  set author(GMentionPreviewPostData_authorBuilder? author) =>
      _$this._author = author;

  GMentionPreviewPostDataBuilder() {
    GMentionPreviewPostData._initializeBuilder(this);
  }

  GMentionPreviewPostDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _createdAt = $v.createdAt.toBuilder();
      _author = $v.author.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMentionPreviewPostData other) {
    _$v = other as _$GMentionPreviewPostData;
  }

  @override
  void update(void Function(GMentionPreviewPostDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionPreviewPostData build() => _build();

  _$GMentionPreviewPostData _build() {
    _$GMentionPreviewPostData _$result;
    try {
      _$result = _$v ??
          _$GMentionPreviewPostData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GMentionPreviewPostData', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GMentionPreviewPostData', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GMentionPreviewPostData', 'title'),
            createdAt: createdAt.build(),
            author: author.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'author';
        author.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMentionPreviewPostData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMentionPreviewPostData_author extends GMentionPreviewPostData_author {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;

  factory _$GMentionPreviewPostData_author(
          [void Function(GMentionPreviewPostData_authorBuilder)? updates]) =>
      (GMentionPreviewPostData_authorBuilder()..update(updates))._build();

  _$GMentionPreviewPostData_author._(
      {required this.G__typename, required this.id, required this.displayName})
      : super._();
  @override
  GMentionPreviewPostData_author rebuild(
          void Function(GMentionPreviewPostData_authorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMentionPreviewPostData_authorBuilder toBuilder() =>
      GMentionPreviewPostData_authorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMentionPreviewPostData_author &&
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
    return (newBuiltValueToStringHelper(r'GMentionPreviewPostData_author')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName))
        .toString();
  }
}

class GMentionPreviewPostData_authorBuilder
    implements
        Builder<GMentionPreviewPostData_author,
            GMentionPreviewPostData_authorBuilder> {
  _$GMentionPreviewPostData_author? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GMentionPreviewPostData_authorBuilder() {
    GMentionPreviewPostData_author._initializeBuilder(this);
  }

  GMentionPreviewPostData_authorBuilder get _$this {
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
  void replace(GMentionPreviewPostData_author other) {
    _$v = other as _$GMentionPreviewPostData_author;
  }

  @override
  void update(void Function(GMentionPreviewPostData_authorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMentionPreviewPostData_author build() => _build();

  _$GMentionPreviewPostData_author _build() {
    final _$result = _$v ??
        _$GMentionPreviewPostData_author._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GMentionPreviewPostData_author', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GMentionPreviewPostData_author', 'id'),
          displayName: BuiltValueNullFieldError.checkNotNull(
              displayName, r'GMentionPreviewPostData_author', 'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
