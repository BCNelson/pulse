// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GPostsForTagData> _$gPostsForTagDataSerializer =
    _$GPostsForTagDataSerializer();
Serializer<GPostsForTagData_tag> _$gPostsForTagDataTagSerializer =
    _$GPostsForTagData_tagSerializer();
Serializer<GPostsForTagData_tag_posts> _$gPostsForTagDataTagPostsSerializer =
    _$GPostsForTagData_tag_postsSerializer();
Serializer<GPostsForTagData_tag_posts_edges>
    _$gPostsForTagDataTagPostsEdgesSerializer =
    _$GPostsForTagData_tag_posts_edgesSerializer();
Serializer<GPostsForTagData_tag_posts_edges_node>
    _$gPostsForTagDataTagPostsEdgesNodeSerializer =
    _$GPostsForTagData_tag_posts_edges_nodeSerializer();
Serializer<GPostsForTagData_tag_posts_edges_node_author>
    _$gPostsForTagDataTagPostsEdgesNodeAuthorSerializer =
    _$GPostsForTagData_tag_posts_edges_node_authorSerializer();
Serializer<GPostsForTagData_tag_posts_edges_node_reactions>
    _$gPostsForTagDataTagPostsEdgesNodeReactionsSerializer =
    _$GPostsForTagData_tag_posts_edges_node_reactionsSerializer();
Serializer<GPostDetailData> _$gPostDetailDataSerializer =
    _$GPostDetailDataSerializer();
Serializer<GPostDetailData_post> _$gPostDetailDataPostSerializer =
    _$GPostDetailData_postSerializer();
Serializer<GPostDetailData_post_author> _$gPostDetailDataPostAuthorSerializer =
    _$GPostDetailData_post_authorSerializer();
Serializer<GPostDetailData_post_reactions>
    _$gPostDetailDataPostReactionsSerializer =
    _$GPostDetailData_post_reactionsSerializer();
Serializer<GPostDetailData_post_tags> _$gPostDetailDataPostTagsSerializer =
    _$GPostDetailData_post_tagsSerializer();
Serializer<GPostDetailData_post_tags_tag>
    _$gPostDetailDataPostTagsTagSerializer =
    _$GPostDetailData_post_tags_tagSerializer();
Serializer<GPostDetailData_post_comments>
    _$gPostDetailDataPostCommentsSerializer =
    _$GPostDetailData_post_commentsSerializer();
Serializer<GPostDetailData_post_comments_edges>
    _$gPostDetailDataPostCommentsEdgesSerializer =
    _$GPostDetailData_post_comments_edgesSerializer();
Serializer<GPostDetailData_post_comments_edges_node>
    _$gPostDetailDataPostCommentsEdgesNodeSerializer =
    _$GPostDetailData_post_comments_edges_nodeSerializer();
Serializer<GPostDetailData_post_comments_edges_node_author>
    _$gPostDetailDataPostCommentsEdgesNodeAuthorSerializer =
    _$GPostDetailData_post_comments_edges_node_authorSerializer();
Serializer<GPostDetailData_post_comments_edges_node_reactions>
    _$gPostDetailDataPostCommentsEdgesNodeReactionsSerializer =
    _$GPostDetailData_post_comments_edges_node_reactionsSerializer();
Serializer<GPostDetailData_post_myPermissions>
    _$gPostDetailDataPostMyPermissionsSerializer =
    _$GPostDetailData_post_myPermissionsSerializer();
Serializer<GCreatePostData> _$gCreatePostDataSerializer =
    _$GCreatePostDataSerializer();
Serializer<GCreatePostData_createPost> _$gCreatePostDataCreatePostSerializer =
    _$GCreatePostData_createPostSerializer();
Serializer<GCreatePostData_createPost_author>
    _$gCreatePostDataCreatePostAuthorSerializer =
    _$GCreatePostData_createPost_authorSerializer();
Serializer<GCreatePostData_createPost_reactions>
    _$gCreatePostDataCreatePostReactionsSerializer =
    _$GCreatePostData_createPost_reactionsSerializer();
Serializer<GCreateCommentData> _$gCreateCommentDataSerializer =
    _$GCreateCommentDataSerializer();
Serializer<GCreateCommentData_createComment>
    _$gCreateCommentDataCreateCommentSerializer =
    _$GCreateCommentData_createCommentSerializer();
Serializer<GCreateCommentData_createComment_author>
    _$gCreateCommentDataCreateCommentAuthorSerializer =
    _$GCreateCommentData_createComment_authorSerializer();
Serializer<GCreateCommentData_createComment_reactions>
    _$gCreateCommentDataCreateCommentReactionsSerializer =
    _$GCreateCommentData_createComment_reactionsSerializer();
Serializer<GReactToPostData> _$gReactToPostDataSerializer =
    _$GReactToPostDataSerializer();
Serializer<GReactToPostData_reactToPost>
    _$gReactToPostDataReactToPostSerializer =
    _$GReactToPostData_reactToPostSerializer();
Serializer<GReactToPostData_reactToPost_reactions>
    _$gReactToPostDataReactToPostReactionsSerializer =
    _$GReactToPostData_reactToPost_reactionsSerializer();
Serializer<GUnreactToPostData> _$gUnreactToPostDataSerializer =
    _$GUnreactToPostDataSerializer();
Serializer<GUnreactToPostData_unreactToPost>
    _$gUnreactToPostDataUnreactToPostSerializer =
    _$GUnreactToPostData_unreactToPostSerializer();
Serializer<GUnreactToPostData_unreactToPost_reactions>
    _$gUnreactToPostDataUnreactToPostReactionsSerializer =
    _$GUnreactToPostData_unreactToPost_reactionsSerializer();
Serializer<GPostChangedData> _$gPostChangedDataSerializer =
    _$GPostChangedDataSerializer();
Serializer<GPostChangedData_postChanged>
    _$gPostChangedDataPostChangedSerializer =
    _$GPostChangedData_postChangedSerializer();
Serializer<GPostChangedData_postChanged_author>
    _$gPostChangedDataPostChangedAuthorSerializer =
    _$GPostChangedData_postChanged_authorSerializer();
Serializer<GPostChangedData_postChanged_reactions>
    _$gPostChangedDataPostChangedReactionsSerializer =
    _$GPostChangedData_postChanged_reactionsSerializer();
Serializer<GPostSummaryData> _$gPostSummaryDataSerializer =
    _$GPostSummaryDataSerializer();
Serializer<GPostSummaryData_author> _$gPostSummaryDataAuthorSerializer =
    _$GPostSummaryData_authorSerializer();
Serializer<GPostSummaryData_reactions> _$gPostSummaryDataReactionsSerializer =
    _$GPostSummaryData_reactionsSerializer();
Serializer<GCommentSummaryData> _$gCommentSummaryDataSerializer =
    _$GCommentSummaryDataSerializer();
Serializer<GCommentSummaryData_author> _$gCommentSummaryDataAuthorSerializer =
    _$GCommentSummaryData_authorSerializer();
Serializer<GCommentSummaryData_reactions>
    _$gCommentSummaryDataReactionsSerializer =
    _$GCommentSummaryData_reactionsSerializer();

class _$GPostsForTagDataSerializer
    implements StructuredSerializer<GPostsForTagData> {
  @override
  final Iterable<Type> types = const [GPostsForTagData, _$GPostsForTagData];
  @override
  final String wireName = 'GPostsForTagData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GPostsForTagData object,
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
            specifiedType: const FullType(GPostsForTagData_tag)));
    }
    return result;
  }

  @override
  GPostsForTagData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostsForTagDataBuilder();

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
                  specifiedType: const FullType(GPostsForTagData_tag))!
              as GPostsForTagData_tag);
          break;
      }
    }

    return result.build();
  }
}

class _$GPostsForTagData_tagSerializer
    implements StructuredSerializer<GPostsForTagData_tag> {
  @override
  final Iterable<Type> types = const [
    GPostsForTagData_tag,
    _$GPostsForTagData_tag
  ];
  @override
  final String wireName = 'GPostsForTagData_tag';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPostsForTagData_tag object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'posts',
      serializers.serialize(object.posts,
          specifiedType: const FullType(GPostsForTagData_tag_posts)),
    ];

    return result;
  }

  @override
  GPostsForTagData_tag deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostsForTagData_tagBuilder();

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
        case 'posts':
          result.posts.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GPostsForTagData_tag_posts))!
              as GPostsForTagData_tag_posts);
          break;
      }
    }

    return result.build();
  }
}

class _$GPostsForTagData_tag_postsSerializer
    implements StructuredSerializer<GPostsForTagData_tag_posts> {
  @override
  final Iterable<Type> types = const [
    GPostsForTagData_tag_posts,
    _$GPostsForTagData_tag_posts
  ];
  @override
  final String wireName = 'GPostsForTagData_tag_posts';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPostsForTagData_tag_posts object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'edges',
      serializers.serialize(object.edges,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GPostsForTagData_tag_posts_edges)])),
    ];

    return result;
  }

  @override
  GPostsForTagData_tag_posts deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostsForTagData_tag_postsBuilder();

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
                const FullType(GPostsForTagData_tag_posts_edges)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GPostsForTagData_tag_posts_edgesSerializer
    implements StructuredSerializer<GPostsForTagData_tag_posts_edges> {
  @override
  final Iterable<Type> types = const [
    GPostsForTagData_tag_posts_edges,
    _$GPostsForTagData_tag_posts_edges
  ];
  @override
  final String wireName = 'GPostsForTagData_tag_posts_edges';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPostsForTagData_tag_posts_edges object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'cursor',
      serializers.serialize(object.cursor,
          specifiedType: const FullType(String)),
      'node',
      serializers.serialize(object.node,
          specifiedType: const FullType(GPostsForTagData_tag_posts_edges_node)),
    ];

    return result;
  }

  @override
  GPostsForTagData_tag_posts_edges deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostsForTagData_tag_posts_edgesBuilder();

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
        case 'node':
          result.node.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GPostsForTagData_tag_posts_edges_node))!
              as GPostsForTagData_tag_posts_edges_node);
          break;
      }
    }

    return result.build();
  }
}

class _$GPostsForTagData_tag_posts_edges_nodeSerializer
    implements StructuredSerializer<GPostsForTagData_tag_posts_edges_node> {
  @override
  final Iterable<Type> types = const [
    GPostsForTagData_tag_posts_edges_node,
    _$GPostsForTagData_tag_posts_edges_node
  ];
  @override
  final String wireName = 'GPostsForTagData_tag_posts_edges_node';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPostsForTagData_tag_posts_edges_node object,
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
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GTime)),
      'denyFlag',
      serializers.serialize(object.denyFlag,
          specifiedType: const FullType(bool)),
      'author',
      serializers.serialize(object.author,
          specifiedType:
              const FullType(GPostsForTagData_tag_posts_edges_node_author)),
      'reactions',
      serializers.serialize(object.reactions,
          specifiedType: const FullType(BuiltList, const [
            const FullType(GPostsForTagData_tag_posts_edges_node_reactions)
          ])),
    ];
    Object? value;
    value = object.editedAt;
    if (value != null) {
      result
        ..add('editedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GTime)));
    }
    value = object.decisionStatus;
    if (value != null) {
      result
        ..add('decisionStatus')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GDecisionStatus)));
    }
    return result;
  }

  @override
  GPostsForTagData_tag_posts_edges_node deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostsForTagData_tag_posts_edges_nodeBuilder();

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
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'editedAt':
          result.editedAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'decisionStatus':
          result.decisionStatus = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GDecisionStatus))
              as _i2.GDecisionStatus?;
          break;
        case 'denyFlag':
          result.denyFlag = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'author':
          result.author.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GPostsForTagData_tag_posts_edges_node_author))!
              as GPostsForTagData_tag_posts_edges_node_author);
          break;
        case 'reactions':
          result.reactions.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GPostsForTagData_tag_posts_edges_node_reactions)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GPostsForTagData_tag_posts_edges_node_authorSerializer
    implements
        StructuredSerializer<GPostsForTagData_tag_posts_edges_node_author> {
  @override
  final Iterable<Type> types = const [
    GPostsForTagData_tag_posts_edges_node_author,
    _$GPostsForTagData_tag_posts_edges_node_author
  ];
  @override
  final String wireName = 'GPostsForTagData_tag_posts_edges_node_author';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GPostsForTagData_tag_posts_edges_node_author object,
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
  GPostsForTagData_tag_posts_edges_node_author deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostsForTagData_tag_posts_edges_node_authorBuilder();

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

class _$GPostsForTagData_tag_posts_edges_node_reactionsSerializer
    implements
        StructuredSerializer<GPostsForTagData_tag_posts_edges_node_reactions> {
  @override
  final Iterable<Type> types = const [
    GPostsForTagData_tag_posts_edges_node_reactions,
    _$GPostsForTagData_tag_posts_edges_node_reactions
  ];
  @override
  final String wireName = 'GPostsForTagData_tag_posts_edges_node_reactions';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GPostsForTagData_tag_posts_edges_node_reactions object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'emoji',
      serializers.serialize(object.emoji,
          specifiedType: const FullType(String)),
      'count',
      serializers.serialize(object.count, specifiedType: const FullType(int)),
      'byViewer',
      serializers.serialize(object.byViewer,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GPostsForTagData_tag_posts_edges_node_reactions deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostsForTagData_tag_posts_edges_node_reactionsBuilder();

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
        case 'emoji':
          result.emoji = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'count':
          result.count = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'byViewer':
          result.byViewer = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GPostDetailDataSerializer
    implements StructuredSerializer<GPostDetailData> {
  @override
  final Iterable<Type> types = const [GPostDetailData, _$GPostDetailData];
  @override
  final String wireName = 'GPostDetailData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GPostDetailData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.post;
    if (value != null) {
      result
        ..add('post')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GPostDetailData_post)));
    }
    return result;
  }

  @override
  GPostDetailData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostDetailDataBuilder();

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
        case 'post':
          result.post.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GPostDetailData_post))!
              as GPostDetailData_post);
          break;
      }
    }

    return result.build();
  }
}

class _$GPostDetailData_postSerializer
    implements StructuredSerializer<GPostDetailData_post> {
  @override
  final Iterable<Type> types = const [
    GPostDetailData_post,
    _$GPostDetailData_post
  ];
  @override
  final String wireName = 'GPostDetailData_post';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPostDetailData_post object,
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
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GTime)),
      'denyFlag',
      serializers.serialize(object.denyFlag,
          specifiedType: const FullType(bool)),
      'author',
      serializers.serialize(object.author,
          specifiedType: const FullType(GPostDetailData_post_author)),
      'reactions',
      serializers.serialize(object.reactions,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GPostDetailData_post_reactions)])),
      'tags',
      serializers.serialize(object.tags,
          specifiedType: const FullType(
              BuiltList, const [const FullType(GPostDetailData_post_tags)])),
      'comments',
      serializers.serialize(object.comments,
          specifiedType: const FullType(GPostDetailData_post_comments)),
      'myPermissions',
      serializers.serialize(object.myPermissions,
          specifiedType: const FullType(GPostDetailData_post_myPermissions)),
    ];
    Object? value;
    value = object.editedAt;
    if (value != null) {
      result
        ..add('editedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GTime)));
    }
    value = object.decisionStatus;
    if (value != null) {
      result
        ..add('decisionStatus')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GDecisionStatus)));
    }
    return result;
  }

  @override
  GPostDetailData_post deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostDetailData_postBuilder();

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
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'editedAt':
          result.editedAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'decisionStatus':
          result.decisionStatus = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GDecisionStatus))
              as _i2.GDecisionStatus?;
          break;
        case 'denyFlag':
          result.denyFlag = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'author':
          result.author.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GPostDetailData_post_author))!
              as GPostDetailData_post_author);
          break;
        case 'reactions':
          result.reactions.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GPostDetailData_post_reactions)
              ]))! as BuiltList<Object?>);
          break;
        case 'tags':
          result.tags.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GPostDetailData_post_tags)
              ]))! as BuiltList<Object?>);
          break;
        case 'comments':
          result.comments.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GPostDetailData_post_comments))!
              as GPostDetailData_post_comments);
          break;
        case 'myPermissions':
          result.myPermissions.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GPostDetailData_post_myPermissions))!
              as GPostDetailData_post_myPermissions);
          break;
      }
    }

    return result.build();
  }
}

class _$GPostDetailData_post_authorSerializer
    implements StructuredSerializer<GPostDetailData_post_author> {
  @override
  final Iterable<Type> types = const [
    GPostDetailData_post_author,
    _$GPostDetailData_post_author
  ];
  @override
  final String wireName = 'GPostDetailData_post_author';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPostDetailData_post_author object,
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
  GPostDetailData_post_author deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostDetailData_post_authorBuilder();

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

class _$GPostDetailData_post_reactionsSerializer
    implements StructuredSerializer<GPostDetailData_post_reactions> {
  @override
  final Iterable<Type> types = const [
    GPostDetailData_post_reactions,
    _$GPostDetailData_post_reactions
  ];
  @override
  final String wireName = 'GPostDetailData_post_reactions';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPostDetailData_post_reactions object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'emoji',
      serializers.serialize(object.emoji,
          specifiedType: const FullType(String)),
      'count',
      serializers.serialize(object.count, specifiedType: const FullType(int)),
      'byViewer',
      serializers.serialize(object.byViewer,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GPostDetailData_post_reactions deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostDetailData_post_reactionsBuilder();

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
        case 'emoji':
          result.emoji = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'count':
          result.count = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'byViewer':
          result.byViewer = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GPostDetailData_post_tagsSerializer
    implements StructuredSerializer<GPostDetailData_post_tags> {
  @override
  final Iterable<Type> types = const [
    GPostDetailData_post_tags,
    _$GPostDetailData_post_tags
  ];
  @override
  final String wireName = 'GPostDetailData_post_tags';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPostDetailData_post_tags object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'tag',
      serializers.serialize(object.tag,
          specifiedType: const FullType(GPostDetailData_post_tags_tag)),
    ];

    return result;
  }

  @override
  GPostDetailData_post_tags deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostDetailData_post_tagsBuilder();

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
                  specifiedType: const FullType(GPostDetailData_post_tags_tag))!
              as GPostDetailData_post_tags_tag);
          break;
      }
    }

    return result.build();
  }
}

class _$GPostDetailData_post_tags_tagSerializer
    implements StructuredSerializer<GPostDetailData_post_tags_tag> {
  @override
  final Iterable<Type> types = const [
    GPostDetailData_post_tags_tag,
    _$GPostDetailData_post_tags_tag
  ];
  @override
  final String wireName = 'GPostDetailData_post_tags_tag';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPostDetailData_post_tags_tag object,
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
  GPostDetailData_post_tags_tag deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostDetailData_post_tags_tagBuilder();

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

class _$GPostDetailData_post_commentsSerializer
    implements StructuredSerializer<GPostDetailData_post_comments> {
  @override
  final Iterable<Type> types = const [
    GPostDetailData_post_comments,
    _$GPostDetailData_post_comments
  ];
  @override
  final String wireName = 'GPostDetailData_post_comments';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPostDetailData_post_comments object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'edges',
      serializers.serialize(object.edges,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GPostDetailData_post_comments_edges)])),
    ];

    return result;
  }

  @override
  GPostDetailData_post_comments deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostDetailData_post_commentsBuilder();

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
                const FullType(GPostDetailData_post_comments_edges)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GPostDetailData_post_comments_edgesSerializer
    implements StructuredSerializer<GPostDetailData_post_comments_edges> {
  @override
  final Iterable<Type> types = const [
    GPostDetailData_post_comments_edges,
    _$GPostDetailData_post_comments_edges
  ];
  @override
  final String wireName = 'GPostDetailData_post_comments_edges';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPostDetailData_post_comments_edges object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'node',
      serializers.serialize(object.node,
          specifiedType:
              const FullType(GPostDetailData_post_comments_edges_node)),
    ];

    return result;
  }

  @override
  GPostDetailData_post_comments_edges deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostDetailData_post_comments_edgesBuilder();

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
                  specifiedType:
                      const FullType(GPostDetailData_post_comments_edges_node))!
              as GPostDetailData_post_comments_edges_node);
          break;
      }
    }

    return result.build();
  }
}

class _$GPostDetailData_post_comments_edges_nodeSerializer
    implements StructuredSerializer<GPostDetailData_post_comments_edges_node> {
  @override
  final Iterable<Type> types = const [
    GPostDetailData_post_comments_edges_node,
    _$GPostDetailData_post_comments_edges_node
  ];
  @override
  final String wireName = 'GPostDetailData_post_comments_edges_node';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPostDetailData_post_comments_edges_node object,
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
      'depth',
      serializers.serialize(object.depth, specifiedType: const FullType(int)),
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GTime)),
      'author',
      serializers.serialize(object.author,
          specifiedType:
              const FullType(GPostDetailData_post_comments_edges_node_author)),
      'reactions',
      serializers.serialize(object.reactions,
          specifiedType: const FullType(BuiltList, const [
            const FullType(GPostDetailData_post_comments_edges_node_reactions)
          ])),
    ];
    Object? value;
    value = object.parentId;
    if (value != null) {
      result
        ..add('parentId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.editedAt;
    if (value != null) {
      result
        ..add('editedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GTime)));
    }
    return result;
  }

  @override
  GPostDetailData_post_comments_edges_node deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostDetailData_post_comments_edges_nodeBuilder();

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
        case 'parentId':
          result.parentId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'depth':
          result.depth = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'editedAt':
          result.editedAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'author':
          result.author.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GPostDetailData_post_comments_edges_node_author))!
              as GPostDetailData_post_comments_edges_node_author);
          break;
        case 'reactions':
          result.reactions.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    GPostDetailData_post_comments_edges_node_reactions)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GPostDetailData_post_comments_edges_node_authorSerializer
    implements
        StructuredSerializer<GPostDetailData_post_comments_edges_node_author> {
  @override
  final Iterable<Type> types = const [
    GPostDetailData_post_comments_edges_node_author,
    _$GPostDetailData_post_comments_edges_node_author
  ];
  @override
  final String wireName = 'GPostDetailData_post_comments_edges_node_author';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GPostDetailData_post_comments_edges_node_author object,
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
  GPostDetailData_post_comments_edges_node_author deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostDetailData_post_comments_edges_node_authorBuilder();

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

class _$GPostDetailData_post_comments_edges_node_reactionsSerializer
    implements
        StructuredSerializer<
            GPostDetailData_post_comments_edges_node_reactions> {
  @override
  final Iterable<Type> types = const [
    GPostDetailData_post_comments_edges_node_reactions,
    _$GPostDetailData_post_comments_edges_node_reactions
  ];
  @override
  final String wireName = 'GPostDetailData_post_comments_edges_node_reactions';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GPostDetailData_post_comments_edges_node_reactions object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'emoji',
      serializers.serialize(object.emoji,
          specifiedType: const FullType(String)),
      'count',
      serializers.serialize(object.count, specifiedType: const FullType(int)),
      'byViewer',
      serializers.serialize(object.byViewer,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GPostDetailData_post_comments_edges_node_reactions deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostDetailData_post_comments_edges_node_reactionsBuilder();

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
        case 'emoji':
          result.emoji = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'count':
          result.count = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'byViewer':
          result.byViewer = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GPostDetailData_post_myPermissionsSerializer
    implements StructuredSerializer<GPostDetailData_post_myPermissions> {
  @override
  final Iterable<Type> types = const [
    GPostDetailData_post_myPermissions,
    _$GPostDetailData_post_myPermissions
  ];
  @override
  final String wireName = 'GPostDetailData_post_myPermissions';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPostDetailData_post_myPermissions object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'canView',
      serializers.serialize(object.canView,
          specifiedType: const FullType(bool)),
      'canContribute',
      serializers.serialize(object.canContribute,
          specifiedType: const FullType(bool)),
      'canModerate',
      serializers.serialize(object.canModerate,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GPostDetailData_post_myPermissions deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostDetailData_post_myPermissionsBuilder();

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
        case 'canView':
          result.canView = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'canContribute':
          result.canContribute = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'canModerate':
          result.canModerate = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GCreatePostDataSerializer
    implements StructuredSerializer<GCreatePostData> {
  @override
  final Iterable<Type> types = const [GCreatePostData, _$GCreatePostData];
  @override
  final String wireName = 'GCreatePostData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GCreatePostData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'createPost',
      serializers.serialize(object.createPost,
          specifiedType: const FullType(GCreatePostData_createPost)),
    ];

    return result;
  }

  @override
  GCreatePostData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreatePostDataBuilder();

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
        case 'createPost':
          result.createPost.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GCreatePostData_createPost))!
              as GCreatePostData_createPost);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreatePostData_createPostSerializer
    implements StructuredSerializer<GCreatePostData_createPost> {
  @override
  final Iterable<Type> types = const [
    GCreatePostData_createPost,
    _$GCreatePostData_createPost
  ];
  @override
  final String wireName = 'GCreatePostData_createPost';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreatePostData_createPost object,
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
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GTime)),
      'denyFlag',
      serializers.serialize(object.denyFlag,
          specifiedType: const FullType(bool)),
      'author',
      serializers.serialize(object.author,
          specifiedType: const FullType(GCreatePostData_createPost_author)),
      'reactions',
      serializers.serialize(object.reactions,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GCreatePostData_createPost_reactions)])),
    ];
    Object? value;
    value = object.editedAt;
    if (value != null) {
      result
        ..add('editedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GTime)));
    }
    value = object.decisionStatus;
    if (value != null) {
      result
        ..add('decisionStatus')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GDecisionStatus)));
    }
    return result;
  }

  @override
  GCreatePostData_createPost deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreatePostData_createPostBuilder();

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
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'editedAt':
          result.editedAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'decisionStatus':
          result.decisionStatus = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GDecisionStatus))
              as _i2.GDecisionStatus?;
          break;
        case 'denyFlag':
          result.denyFlag = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'author':
          result.author.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GCreatePostData_createPost_author))!
              as GCreatePostData_createPost_author);
          break;
        case 'reactions':
          result.reactions.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GCreatePostData_createPost_reactions)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreatePostData_createPost_authorSerializer
    implements StructuredSerializer<GCreatePostData_createPost_author> {
  @override
  final Iterable<Type> types = const [
    GCreatePostData_createPost_author,
    _$GCreatePostData_createPost_author
  ];
  @override
  final String wireName = 'GCreatePostData_createPost_author';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreatePostData_createPost_author object,
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
  GCreatePostData_createPost_author deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreatePostData_createPost_authorBuilder();

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

class _$GCreatePostData_createPost_reactionsSerializer
    implements StructuredSerializer<GCreatePostData_createPost_reactions> {
  @override
  final Iterable<Type> types = const [
    GCreatePostData_createPost_reactions,
    _$GCreatePostData_createPost_reactions
  ];
  @override
  final String wireName = 'GCreatePostData_createPost_reactions';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreatePostData_createPost_reactions object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'emoji',
      serializers.serialize(object.emoji,
          specifiedType: const FullType(String)),
      'count',
      serializers.serialize(object.count, specifiedType: const FullType(int)),
      'byViewer',
      serializers.serialize(object.byViewer,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GCreatePostData_createPost_reactions deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreatePostData_createPost_reactionsBuilder();

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
        case 'emoji':
          result.emoji = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'count':
          result.count = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'byViewer':
          result.byViewer = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateCommentDataSerializer
    implements StructuredSerializer<GCreateCommentData> {
  @override
  final Iterable<Type> types = const [GCreateCommentData, _$GCreateCommentData];
  @override
  final String wireName = 'GCreateCommentData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateCommentData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'createComment',
      serializers.serialize(object.createComment,
          specifiedType: const FullType(GCreateCommentData_createComment)),
    ];

    return result;
  }

  @override
  GCreateCommentData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreateCommentDataBuilder();

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
        case 'createComment':
          result.createComment.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GCreateCommentData_createComment))!
              as GCreateCommentData_createComment);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateCommentData_createCommentSerializer
    implements StructuredSerializer<GCreateCommentData_createComment> {
  @override
  final Iterable<Type> types = const [
    GCreateCommentData_createComment,
    _$GCreateCommentData_createComment
  ];
  @override
  final String wireName = 'GCreateCommentData_createComment';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateCommentData_createComment object,
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
      'depth',
      serializers.serialize(object.depth, specifiedType: const FullType(int)),
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GTime)),
      'author',
      serializers.serialize(object.author,
          specifiedType:
              const FullType(GCreateCommentData_createComment_author)),
      'reactions',
      serializers.serialize(object.reactions,
          specifiedType: const FullType(BuiltList, const [
            const FullType(GCreateCommentData_createComment_reactions)
          ])),
    ];
    Object? value;
    value = object.parentId;
    if (value != null) {
      result
        ..add('parentId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.editedAt;
    if (value != null) {
      result
        ..add('editedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GTime)));
    }
    return result;
  }

  @override
  GCreateCommentData_createComment deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreateCommentData_createCommentBuilder();

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
        case 'parentId':
          result.parentId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'depth':
          result.depth = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'editedAt':
          result.editedAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'author':
          result.author.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GCreateCommentData_createComment_author))!
              as GCreateCommentData_createComment_author);
          break;
        case 'reactions':
          result.reactions.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GCreateCommentData_createComment_reactions)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateCommentData_createComment_authorSerializer
    implements StructuredSerializer<GCreateCommentData_createComment_author> {
  @override
  final Iterable<Type> types = const [
    GCreateCommentData_createComment_author,
    _$GCreateCommentData_createComment_author
  ];
  @override
  final String wireName = 'GCreateCommentData_createComment_author';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateCommentData_createComment_author object,
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
  GCreateCommentData_createComment_author deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreateCommentData_createComment_authorBuilder();

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

class _$GCreateCommentData_createComment_reactionsSerializer
    implements
        StructuredSerializer<GCreateCommentData_createComment_reactions> {
  @override
  final Iterable<Type> types = const [
    GCreateCommentData_createComment_reactions,
    _$GCreateCommentData_createComment_reactions
  ];
  @override
  final String wireName = 'GCreateCommentData_createComment_reactions';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GCreateCommentData_createComment_reactions object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'emoji',
      serializers.serialize(object.emoji,
          specifiedType: const FullType(String)),
      'count',
      serializers.serialize(object.count, specifiedType: const FullType(int)),
      'byViewer',
      serializers.serialize(object.byViewer,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GCreateCommentData_createComment_reactions deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreateCommentData_createComment_reactionsBuilder();

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
        case 'emoji':
          result.emoji = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'count':
          result.count = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'byViewer':
          result.byViewer = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GReactToPostDataSerializer
    implements StructuredSerializer<GReactToPostData> {
  @override
  final Iterable<Type> types = const [GReactToPostData, _$GReactToPostData];
  @override
  final String wireName = 'GReactToPostData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GReactToPostData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'reactToPost',
      serializers.serialize(object.reactToPost,
          specifiedType: const FullType(GReactToPostData_reactToPost)),
    ];

    return result;
  }

  @override
  GReactToPostData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GReactToPostDataBuilder();

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
        case 'reactToPost':
          result.reactToPost.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GReactToPostData_reactToPost))!
              as GReactToPostData_reactToPost);
          break;
      }
    }

    return result.build();
  }
}

class _$GReactToPostData_reactToPostSerializer
    implements StructuredSerializer<GReactToPostData_reactToPost> {
  @override
  final Iterable<Type> types = const [
    GReactToPostData_reactToPost,
    _$GReactToPostData_reactToPost
  ];
  @override
  final String wireName = 'GReactToPostData_reactToPost';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GReactToPostData_reactToPost object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'reactions',
      serializers.serialize(object.reactions,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GReactToPostData_reactToPost_reactions)])),
    ];

    return result;
  }

  @override
  GReactToPostData_reactToPost deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GReactToPostData_reactToPostBuilder();

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
        case 'reactions':
          result.reactions.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GReactToPostData_reactToPost_reactions)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GReactToPostData_reactToPost_reactionsSerializer
    implements StructuredSerializer<GReactToPostData_reactToPost_reactions> {
  @override
  final Iterable<Type> types = const [
    GReactToPostData_reactToPost_reactions,
    _$GReactToPostData_reactToPost_reactions
  ];
  @override
  final String wireName = 'GReactToPostData_reactToPost_reactions';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GReactToPostData_reactToPost_reactions object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'emoji',
      serializers.serialize(object.emoji,
          specifiedType: const FullType(String)),
      'count',
      serializers.serialize(object.count, specifiedType: const FullType(int)),
      'byViewer',
      serializers.serialize(object.byViewer,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GReactToPostData_reactToPost_reactions deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GReactToPostData_reactToPost_reactionsBuilder();

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
        case 'emoji':
          result.emoji = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'count':
          result.count = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'byViewer':
          result.byViewer = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GUnreactToPostDataSerializer
    implements StructuredSerializer<GUnreactToPostData> {
  @override
  final Iterable<Type> types = const [GUnreactToPostData, _$GUnreactToPostData];
  @override
  final String wireName = 'GUnreactToPostData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUnreactToPostData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'unreactToPost',
      serializers.serialize(object.unreactToPost,
          specifiedType: const FullType(GUnreactToPostData_unreactToPost)),
    ];

    return result;
  }

  @override
  GUnreactToPostData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUnreactToPostDataBuilder();

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
        case 'unreactToPost':
          result.unreactToPost.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GUnreactToPostData_unreactToPost))!
              as GUnreactToPostData_unreactToPost);
          break;
      }
    }

    return result.build();
  }
}

class _$GUnreactToPostData_unreactToPostSerializer
    implements StructuredSerializer<GUnreactToPostData_unreactToPost> {
  @override
  final Iterable<Type> types = const [
    GUnreactToPostData_unreactToPost,
    _$GUnreactToPostData_unreactToPost
  ];
  @override
  final String wireName = 'GUnreactToPostData_unreactToPost';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUnreactToPostData_unreactToPost object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'reactions',
      serializers.serialize(object.reactions,
          specifiedType: const FullType(BuiltList, const [
            const FullType(GUnreactToPostData_unreactToPost_reactions)
          ])),
    ];

    return result;
  }

  @override
  GUnreactToPostData_unreactToPost deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUnreactToPostData_unreactToPostBuilder();

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
        case 'reactions':
          result.reactions.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GUnreactToPostData_unreactToPost_reactions)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GUnreactToPostData_unreactToPost_reactionsSerializer
    implements
        StructuredSerializer<GUnreactToPostData_unreactToPost_reactions> {
  @override
  final Iterable<Type> types = const [
    GUnreactToPostData_unreactToPost_reactions,
    _$GUnreactToPostData_unreactToPost_reactions
  ];
  @override
  final String wireName = 'GUnreactToPostData_unreactToPost_reactions';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GUnreactToPostData_unreactToPost_reactions object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'emoji',
      serializers.serialize(object.emoji,
          specifiedType: const FullType(String)),
      'count',
      serializers.serialize(object.count, specifiedType: const FullType(int)),
      'byViewer',
      serializers.serialize(object.byViewer,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GUnreactToPostData_unreactToPost_reactions deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUnreactToPostData_unreactToPost_reactionsBuilder();

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
        case 'emoji':
          result.emoji = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'count':
          result.count = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'byViewer':
          result.byViewer = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GPostChangedDataSerializer
    implements StructuredSerializer<GPostChangedData> {
  @override
  final Iterable<Type> types = const [GPostChangedData, _$GPostChangedData];
  @override
  final String wireName = 'GPostChangedData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GPostChangedData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'postChanged',
      serializers.serialize(object.postChanged,
          specifiedType: const FullType(GPostChangedData_postChanged)),
    ];

    return result;
  }

  @override
  GPostChangedData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostChangedDataBuilder();

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
        case 'postChanged':
          result.postChanged.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GPostChangedData_postChanged))!
              as GPostChangedData_postChanged);
          break;
      }
    }

    return result.build();
  }
}

class _$GPostChangedData_postChangedSerializer
    implements StructuredSerializer<GPostChangedData_postChanged> {
  @override
  final Iterable<Type> types = const [
    GPostChangedData_postChanged,
    _$GPostChangedData_postChanged
  ];
  @override
  final String wireName = 'GPostChangedData_postChanged';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPostChangedData_postChanged object,
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
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GTime)),
      'denyFlag',
      serializers.serialize(object.denyFlag,
          specifiedType: const FullType(bool)),
      'author',
      serializers.serialize(object.author,
          specifiedType: const FullType(GPostChangedData_postChanged_author)),
      'reactions',
      serializers.serialize(object.reactions,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GPostChangedData_postChanged_reactions)])),
    ];
    Object? value;
    value = object.editedAt;
    if (value != null) {
      result
        ..add('editedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GTime)));
    }
    value = object.decisionStatus;
    if (value != null) {
      result
        ..add('decisionStatus')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GDecisionStatus)));
    }
    return result;
  }

  @override
  GPostChangedData_postChanged deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostChangedData_postChangedBuilder();

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
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'editedAt':
          result.editedAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'decisionStatus':
          result.decisionStatus = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GDecisionStatus))
              as _i2.GDecisionStatus?;
          break;
        case 'denyFlag':
          result.denyFlag = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'author':
          result.author.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GPostChangedData_postChanged_author))!
              as GPostChangedData_postChanged_author);
          break;
        case 'reactions':
          result.reactions.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GPostChangedData_postChanged_reactions)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GPostChangedData_postChanged_authorSerializer
    implements StructuredSerializer<GPostChangedData_postChanged_author> {
  @override
  final Iterable<Type> types = const [
    GPostChangedData_postChanged_author,
    _$GPostChangedData_postChanged_author
  ];
  @override
  final String wireName = 'GPostChangedData_postChanged_author';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPostChangedData_postChanged_author object,
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
  GPostChangedData_postChanged_author deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostChangedData_postChanged_authorBuilder();

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

class _$GPostChangedData_postChanged_reactionsSerializer
    implements StructuredSerializer<GPostChangedData_postChanged_reactions> {
  @override
  final Iterable<Type> types = const [
    GPostChangedData_postChanged_reactions,
    _$GPostChangedData_postChanged_reactions
  ];
  @override
  final String wireName = 'GPostChangedData_postChanged_reactions';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPostChangedData_postChanged_reactions object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'emoji',
      serializers.serialize(object.emoji,
          specifiedType: const FullType(String)),
      'count',
      serializers.serialize(object.count, specifiedType: const FullType(int)),
      'byViewer',
      serializers.serialize(object.byViewer,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GPostChangedData_postChanged_reactions deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostChangedData_postChanged_reactionsBuilder();

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
        case 'emoji':
          result.emoji = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'count':
          result.count = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'byViewer':
          result.byViewer = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GPostSummaryDataSerializer
    implements StructuredSerializer<GPostSummaryData> {
  @override
  final Iterable<Type> types = const [GPostSummaryData, _$GPostSummaryData];
  @override
  final String wireName = 'GPostSummaryData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GPostSummaryData object,
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
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GTime)),
      'denyFlag',
      serializers.serialize(object.denyFlag,
          specifiedType: const FullType(bool)),
      'author',
      serializers.serialize(object.author,
          specifiedType: const FullType(GPostSummaryData_author)),
      'reactions',
      serializers.serialize(object.reactions,
          specifiedType: const FullType(
              BuiltList, const [const FullType(GPostSummaryData_reactions)])),
    ];
    Object? value;
    value = object.editedAt;
    if (value != null) {
      result
        ..add('editedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GTime)));
    }
    value = object.decisionStatus;
    if (value != null) {
      result
        ..add('decisionStatus')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GDecisionStatus)));
    }
    return result;
  }

  @override
  GPostSummaryData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostSummaryDataBuilder();

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
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'editedAt':
          result.editedAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'decisionStatus':
          result.decisionStatus = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GDecisionStatus))
              as _i2.GDecisionStatus?;
          break;
        case 'denyFlag':
          result.denyFlag = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'author':
          result.author.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GPostSummaryData_author))!
              as GPostSummaryData_author);
          break;
        case 'reactions':
          result.reactions.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GPostSummaryData_reactions)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GPostSummaryData_authorSerializer
    implements StructuredSerializer<GPostSummaryData_author> {
  @override
  final Iterable<Type> types = const [
    GPostSummaryData_author,
    _$GPostSummaryData_author
  ];
  @override
  final String wireName = 'GPostSummaryData_author';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPostSummaryData_author object,
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
  GPostSummaryData_author deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostSummaryData_authorBuilder();

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

class _$GPostSummaryData_reactionsSerializer
    implements StructuredSerializer<GPostSummaryData_reactions> {
  @override
  final Iterable<Type> types = const [
    GPostSummaryData_reactions,
    _$GPostSummaryData_reactions
  ];
  @override
  final String wireName = 'GPostSummaryData_reactions';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPostSummaryData_reactions object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'emoji',
      serializers.serialize(object.emoji,
          specifiedType: const FullType(String)),
      'count',
      serializers.serialize(object.count, specifiedType: const FullType(int)),
      'byViewer',
      serializers.serialize(object.byViewer,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GPostSummaryData_reactions deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPostSummaryData_reactionsBuilder();

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
        case 'emoji':
          result.emoji = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'count':
          result.count = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'byViewer':
          result.byViewer = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GCommentSummaryDataSerializer
    implements StructuredSerializer<GCommentSummaryData> {
  @override
  final Iterable<Type> types = const [
    GCommentSummaryData,
    _$GCommentSummaryData
  ];
  @override
  final String wireName = 'GCommentSummaryData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCommentSummaryData object,
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
      'depth',
      serializers.serialize(object.depth, specifiedType: const FullType(int)),
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(_i2.GTime)),
      'author',
      serializers.serialize(object.author,
          specifiedType: const FullType(GCommentSummaryData_author)),
      'reactions',
      serializers.serialize(object.reactions,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GCommentSummaryData_reactions)])),
    ];
    Object? value;
    value = object.parentId;
    if (value != null) {
      result
        ..add('parentId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.editedAt;
    if (value != null) {
      result
        ..add('editedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i2.GTime)));
    }
    return result;
  }

  @override
  GCommentSummaryData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCommentSummaryDataBuilder();

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
        case 'parentId':
          result.parentId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'depth':
          result.depth = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'createdAt':
          result.createdAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'editedAt':
          result.editedAt.replace(serializers.deserialize(value,
              specifiedType: const FullType(_i2.GTime))! as _i2.GTime);
          break;
        case 'author':
          result.author.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GCommentSummaryData_author))!
              as GCommentSummaryData_author);
          break;
        case 'reactions':
          result.reactions.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GCommentSummaryData_reactions)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GCommentSummaryData_authorSerializer
    implements StructuredSerializer<GCommentSummaryData_author> {
  @override
  final Iterable<Type> types = const [
    GCommentSummaryData_author,
    _$GCommentSummaryData_author
  ];
  @override
  final String wireName = 'GCommentSummaryData_author';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCommentSummaryData_author object,
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
  GCommentSummaryData_author deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCommentSummaryData_authorBuilder();

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

class _$GCommentSummaryData_reactionsSerializer
    implements StructuredSerializer<GCommentSummaryData_reactions> {
  @override
  final Iterable<Type> types = const [
    GCommentSummaryData_reactions,
    _$GCommentSummaryData_reactions
  ];
  @override
  final String wireName = 'GCommentSummaryData_reactions';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCommentSummaryData_reactions object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'emoji',
      serializers.serialize(object.emoji,
          specifiedType: const FullType(String)),
      'count',
      serializers.serialize(object.count, specifiedType: const FullType(int)),
      'byViewer',
      serializers.serialize(object.byViewer,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GCommentSummaryData_reactions deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCommentSummaryData_reactionsBuilder();

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
        case 'emoji':
          result.emoji = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'count':
          result.count = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'byViewer':
          result.byViewer = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GPostsForTagData extends GPostsForTagData {
  @override
  final String G__typename;
  @override
  final GPostsForTagData_tag? tag;

  factory _$GPostsForTagData(
          [void Function(GPostsForTagDataBuilder)? updates]) =>
      (GPostsForTagDataBuilder()..update(updates))._build();

  _$GPostsForTagData._({required this.G__typename, this.tag}) : super._();
  @override
  GPostsForTagData rebuild(void Function(GPostsForTagDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostsForTagDataBuilder toBuilder() =>
      GPostsForTagDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostsForTagData &&
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
    return (newBuiltValueToStringHelper(r'GPostsForTagData')
          ..add('G__typename', G__typename)
          ..add('tag', tag))
        .toString();
  }
}

class GPostsForTagDataBuilder
    implements Builder<GPostsForTagData, GPostsForTagDataBuilder> {
  _$GPostsForTagData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GPostsForTagData_tagBuilder? _tag;
  GPostsForTagData_tagBuilder get tag =>
      _$this._tag ??= GPostsForTagData_tagBuilder();
  set tag(GPostsForTagData_tagBuilder? tag) => _$this._tag = tag;

  GPostsForTagDataBuilder() {
    GPostsForTagData._initializeBuilder(this);
  }

  GPostsForTagDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _tag = $v.tag?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostsForTagData other) {
    _$v = other as _$GPostsForTagData;
  }

  @override
  void update(void Function(GPostsForTagDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostsForTagData build() => _build();

  _$GPostsForTagData _build() {
    _$GPostsForTagData _$result;
    try {
      _$result = _$v ??
          _$GPostsForTagData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GPostsForTagData', 'G__typename'),
            tag: _tag?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tag';
        _tag?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GPostsForTagData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GPostsForTagData_tag extends GPostsForTagData_tag {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final GPostsForTagData_tag_posts posts;

  factory _$GPostsForTagData_tag(
          [void Function(GPostsForTagData_tagBuilder)? updates]) =>
      (GPostsForTagData_tagBuilder()..update(updates))._build();

  _$GPostsForTagData_tag._(
      {required this.G__typename, required this.id, required this.posts})
      : super._();
  @override
  GPostsForTagData_tag rebuild(
          void Function(GPostsForTagData_tagBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostsForTagData_tagBuilder toBuilder() =>
      GPostsForTagData_tagBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostsForTagData_tag &&
        G__typename == other.G__typename &&
        id == other.id &&
        posts == other.posts;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, posts.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostsForTagData_tag')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('posts', posts))
        .toString();
  }
}

class GPostsForTagData_tagBuilder
    implements Builder<GPostsForTagData_tag, GPostsForTagData_tagBuilder> {
  _$GPostsForTagData_tag? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GPostsForTagData_tag_postsBuilder? _posts;
  GPostsForTagData_tag_postsBuilder get posts =>
      _$this._posts ??= GPostsForTagData_tag_postsBuilder();
  set posts(GPostsForTagData_tag_postsBuilder? posts) => _$this._posts = posts;

  GPostsForTagData_tagBuilder() {
    GPostsForTagData_tag._initializeBuilder(this);
  }

  GPostsForTagData_tagBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _posts = $v.posts.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostsForTagData_tag other) {
    _$v = other as _$GPostsForTagData_tag;
  }

  @override
  void update(void Function(GPostsForTagData_tagBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostsForTagData_tag build() => _build();

  _$GPostsForTagData_tag _build() {
    _$GPostsForTagData_tag _$result;
    try {
      _$result = _$v ??
          _$GPostsForTagData_tag._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GPostsForTagData_tag', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GPostsForTagData_tag', 'id'),
            posts: posts.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'posts';
        posts.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GPostsForTagData_tag', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GPostsForTagData_tag_posts extends GPostsForTagData_tag_posts {
  @override
  final String G__typename;
  @override
  final BuiltList<GPostsForTagData_tag_posts_edges> edges;

  factory _$GPostsForTagData_tag_posts(
          [void Function(GPostsForTagData_tag_postsBuilder)? updates]) =>
      (GPostsForTagData_tag_postsBuilder()..update(updates))._build();

  _$GPostsForTagData_tag_posts._(
      {required this.G__typename, required this.edges})
      : super._();
  @override
  GPostsForTagData_tag_posts rebuild(
          void Function(GPostsForTagData_tag_postsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostsForTagData_tag_postsBuilder toBuilder() =>
      GPostsForTagData_tag_postsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostsForTagData_tag_posts &&
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
    return (newBuiltValueToStringHelper(r'GPostsForTagData_tag_posts')
          ..add('G__typename', G__typename)
          ..add('edges', edges))
        .toString();
  }
}

class GPostsForTagData_tag_postsBuilder
    implements
        Builder<GPostsForTagData_tag_posts, GPostsForTagData_tag_postsBuilder> {
  _$GPostsForTagData_tag_posts? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GPostsForTagData_tag_posts_edges>? _edges;
  ListBuilder<GPostsForTagData_tag_posts_edges> get edges =>
      _$this._edges ??= ListBuilder<GPostsForTagData_tag_posts_edges>();
  set edges(ListBuilder<GPostsForTagData_tag_posts_edges>? edges) =>
      _$this._edges = edges;

  GPostsForTagData_tag_postsBuilder() {
    GPostsForTagData_tag_posts._initializeBuilder(this);
  }

  GPostsForTagData_tag_postsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _edges = $v.edges.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostsForTagData_tag_posts other) {
    _$v = other as _$GPostsForTagData_tag_posts;
  }

  @override
  void update(void Function(GPostsForTagData_tag_postsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostsForTagData_tag_posts build() => _build();

  _$GPostsForTagData_tag_posts _build() {
    _$GPostsForTagData_tag_posts _$result;
    try {
      _$result = _$v ??
          _$GPostsForTagData_tag_posts._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GPostsForTagData_tag_posts', 'G__typename'),
            edges: edges.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'edges';
        edges.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GPostsForTagData_tag_posts', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GPostsForTagData_tag_posts_edges
    extends GPostsForTagData_tag_posts_edges {
  @override
  final String G__typename;
  @override
  final String cursor;
  @override
  final GPostsForTagData_tag_posts_edges_node node;

  factory _$GPostsForTagData_tag_posts_edges(
          [void Function(GPostsForTagData_tag_posts_edgesBuilder)? updates]) =>
      (GPostsForTagData_tag_posts_edgesBuilder()..update(updates))._build();

  _$GPostsForTagData_tag_posts_edges._(
      {required this.G__typename, required this.cursor, required this.node})
      : super._();
  @override
  GPostsForTagData_tag_posts_edges rebuild(
          void Function(GPostsForTagData_tag_posts_edgesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostsForTagData_tag_posts_edgesBuilder toBuilder() =>
      GPostsForTagData_tag_posts_edgesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostsForTagData_tag_posts_edges &&
        G__typename == other.G__typename &&
        cursor == other.cursor &&
        node == other.node;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, cursor.hashCode);
    _$hash = $jc(_$hash, node.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostsForTagData_tag_posts_edges')
          ..add('G__typename', G__typename)
          ..add('cursor', cursor)
          ..add('node', node))
        .toString();
  }
}

class GPostsForTagData_tag_posts_edgesBuilder
    implements
        Builder<GPostsForTagData_tag_posts_edges,
            GPostsForTagData_tag_posts_edgesBuilder> {
  _$GPostsForTagData_tag_posts_edges? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _cursor;
  String? get cursor => _$this._cursor;
  set cursor(String? cursor) => _$this._cursor = cursor;

  GPostsForTagData_tag_posts_edges_nodeBuilder? _node;
  GPostsForTagData_tag_posts_edges_nodeBuilder get node =>
      _$this._node ??= GPostsForTagData_tag_posts_edges_nodeBuilder();
  set node(GPostsForTagData_tag_posts_edges_nodeBuilder? node) =>
      _$this._node = node;

  GPostsForTagData_tag_posts_edgesBuilder() {
    GPostsForTagData_tag_posts_edges._initializeBuilder(this);
  }

  GPostsForTagData_tag_posts_edgesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _cursor = $v.cursor;
      _node = $v.node.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostsForTagData_tag_posts_edges other) {
    _$v = other as _$GPostsForTagData_tag_posts_edges;
  }

  @override
  void update(void Function(GPostsForTagData_tag_posts_edgesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostsForTagData_tag_posts_edges build() => _build();

  _$GPostsForTagData_tag_posts_edges _build() {
    _$GPostsForTagData_tag_posts_edges _$result;
    try {
      _$result = _$v ??
          _$GPostsForTagData_tag_posts_edges._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GPostsForTagData_tag_posts_edges', 'G__typename'),
            cursor: BuiltValueNullFieldError.checkNotNull(
                cursor, r'GPostsForTagData_tag_posts_edges', 'cursor'),
            node: node.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'node';
        node.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GPostsForTagData_tag_posts_edges', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GPostsForTagData_tag_posts_edges_node
    extends GPostsForTagData_tag_posts_edges_node {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String title;
  @override
  final String body;
  @override
  final _i2.GTime createdAt;
  @override
  final _i2.GTime? editedAt;
  @override
  final _i2.GDecisionStatus? decisionStatus;
  @override
  final bool denyFlag;
  @override
  final GPostsForTagData_tag_posts_edges_node_author author;
  @override
  final BuiltList<GPostsForTagData_tag_posts_edges_node_reactions> reactions;

  factory _$GPostsForTagData_tag_posts_edges_node(
          [void Function(GPostsForTagData_tag_posts_edges_nodeBuilder)?
              updates]) =>
      (GPostsForTagData_tag_posts_edges_nodeBuilder()..update(updates))
          ._build();

  _$GPostsForTagData_tag_posts_edges_node._(
      {required this.G__typename,
      required this.id,
      required this.title,
      required this.body,
      required this.createdAt,
      this.editedAt,
      this.decisionStatus,
      required this.denyFlag,
      required this.author,
      required this.reactions})
      : super._();
  @override
  GPostsForTagData_tag_posts_edges_node rebuild(
          void Function(GPostsForTagData_tag_posts_edges_nodeBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostsForTagData_tag_posts_edges_nodeBuilder toBuilder() =>
      GPostsForTagData_tag_posts_edges_nodeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostsForTagData_tag_posts_edges_node &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        body == other.body &&
        createdAt == other.createdAt &&
        editedAt == other.editedAt &&
        decisionStatus == other.decisionStatus &&
        denyFlag == other.denyFlag &&
        author == other.author &&
        reactions == other.reactions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, editedAt.hashCode);
    _$hash = $jc(_$hash, decisionStatus.hashCode);
    _$hash = $jc(_$hash, denyFlag.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, reactions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GPostsForTagData_tag_posts_edges_node')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('body', body)
          ..add('createdAt', createdAt)
          ..add('editedAt', editedAt)
          ..add('decisionStatus', decisionStatus)
          ..add('denyFlag', denyFlag)
          ..add('author', author)
          ..add('reactions', reactions))
        .toString();
  }
}

class GPostsForTagData_tag_posts_edges_nodeBuilder
    implements
        Builder<GPostsForTagData_tag_posts_edges_node,
            GPostsForTagData_tag_posts_edges_nodeBuilder> {
  _$GPostsForTagData_tag_posts_edges_node? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  _i2.GTimeBuilder? _createdAt;
  _i2.GTimeBuilder get createdAt => _$this._createdAt ??= _i2.GTimeBuilder();
  set createdAt(_i2.GTimeBuilder? createdAt) => _$this._createdAt = createdAt;

  _i2.GTimeBuilder? _editedAt;
  _i2.GTimeBuilder get editedAt => _$this._editedAt ??= _i2.GTimeBuilder();
  set editedAt(_i2.GTimeBuilder? editedAt) => _$this._editedAt = editedAt;

  _i2.GDecisionStatus? _decisionStatus;
  _i2.GDecisionStatus? get decisionStatus => _$this._decisionStatus;
  set decisionStatus(_i2.GDecisionStatus? decisionStatus) =>
      _$this._decisionStatus = decisionStatus;

  bool? _denyFlag;
  bool? get denyFlag => _$this._denyFlag;
  set denyFlag(bool? denyFlag) => _$this._denyFlag = denyFlag;

  GPostsForTagData_tag_posts_edges_node_authorBuilder? _author;
  GPostsForTagData_tag_posts_edges_node_authorBuilder get author =>
      _$this._author ??= GPostsForTagData_tag_posts_edges_node_authorBuilder();
  set author(GPostsForTagData_tag_posts_edges_node_authorBuilder? author) =>
      _$this._author = author;

  ListBuilder<GPostsForTagData_tag_posts_edges_node_reactions>? _reactions;
  ListBuilder<GPostsForTagData_tag_posts_edges_node_reactions> get reactions =>
      _$this._reactions ??=
          ListBuilder<GPostsForTagData_tag_posts_edges_node_reactions>();
  set reactions(
          ListBuilder<GPostsForTagData_tag_posts_edges_node_reactions>?
              reactions) =>
      _$this._reactions = reactions;

  GPostsForTagData_tag_posts_edges_nodeBuilder() {
    GPostsForTagData_tag_posts_edges_node._initializeBuilder(this);
  }

  GPostsForTagData_tag_posts_edges_nodeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _body = $v.body;
      _createdAt = $v.createdAt.toBuilder();
      _editedAt = $v.editedAt?.toBuilder();
      _decisionStatus = $v.decisionStatus;
      _denyFlag = $v.denyFlag;
      _author = $v.author.toBuilder();
      _reactions = $v.reactions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostsForTagData_tag_posts_edges_node other) {
    _$v = other as _$GPostsForTagData_tag_posts_edges_node;
  }

  @override
  void update(
      void Function(GPostsForTagData_tag_posts_edges_nodeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostsForTagData_tag_posts_edges_node build() => _build();

  _$GPostsForTagData_tag_posts_edges_node _build() {
    _$GPostsForTagData_tag_posts_edges_node _$result;
    try {
      _$result = _$v ??
          _$GPostsForTagData_tag_posts_edges_node._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GPostsForTagData_tag_posts_edges_node', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GPostsForTagData_tag_posts_edges_node', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GPostsForTagData_tag_posts_edges_node', 'title'),
            body: BuiltValueNullFieldError.checkNotNull(
                body, r'GPostsForTagData_tag_posts_edges_node', 'body'),
            createdAt: createdAt.build(),
            editedAt: _editedAt?.build(),
            decisionStatus: decisionStatus,
            denyFlag: BuiltValueNullFieldError.checkNotNull(
                denyFlag, r'GPostsForTagData_tag_posts_edges_node', 'denyFlag'),
            author: author.build(),
            reactions: reactions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'editedAt';
        _editedAt?.build();

        _$failedField = 'author';
        author.build();
        _$failedField = 'reactions';
        reactions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GPostsForTagData_tag_posts_edges_node',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GPostsForTagData_tag_posts_edges_node_author
    extends GPostsForTagData_tag_posts_edges_node_author {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;

  factory _$GPostsForTagData_tag_posts_edges_node_author(
          [void Function(GPostsForTagData_tag_posts_edges_node_authorBuilder)?
              updates]) =>
      (GPostsForTagData_tag_posts_edges_node_authorBuilder()..update(updates))
          ._build();

  _$GPostsForTagData_tag_posts_edges_node_author._(
      {required this.G__typename, required this.id, required this.displayName})
      : super._();
  @override
  GPostsForTagData_tag_posts_edges_node_author rebuild(
          void Function(GPostsForTagData_tag_posts_edges_node_authorBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostsForTagData_tag_posts_edges_node_authorBuilder toBuilder() =>
      GPostsForTagData_tag_posts_edges_node_authorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostsForTagData_tag_posts_edges_node_author &&
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
            r'GPostsForTagData_tag_posts_edges_node_author')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName))
        .toString();
  }
}

class GPostsForTagData_tag_posts_edges_node_authorBuilder
    implements
        Builder<GPostsForTagData_tag_posts_edges_node_author,
            GPostsForTagData_tag_posts_edges_node_authorBuilder> {
  _$GPostsForTagData_tag_posts_edges_node_author? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GPostsForTagData_tag_posts_edges_node_authorBuilder() {
    GPostsForTagData_tag_posts_edges_node_author._initializeBuilder(this);
  }

  GPostsForTagData_tag_posts_edges_node_authorBuilder get _$this {
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
  void replace(GPostsForTagData_tag_posts_edges_node_author other) {
    _$v = other as _$GPostsForTagData_tag_posts_edges_node_author;
  }

  @override
  void update(
      void Function(GPostsForTagData_tag_posts_edges_node_authorBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostsForTagData_tag_posts_edges_node_author build() => _build();

  _$GPostsForTagData_tag_posts_edges_node_author _build() {
    final _$result = _$v ??
        _$GPostsForTagData_tag_posts_edges_node_author._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GPostsForTagData_tag_posts_edges_node_author', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GPostsForTagData_tag_posts_edges_node_author', 'id'),
          displayName: BuiltValueNullFieldError.checkNotNull(displayName,
              r'GPostsForTagData_tag_posts_edges_node_author', 'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GPostsForTagData_tag_posts_edges_node_reactions
    extends GPostsForTagData_tag_posts_edges_node_reactions {
  @override
  final String G__typename;
  @override
  final String emoji;
  @override
  final int count;
  @override
  final bool byViewer;

  factory _$GPostsForTagData_tag_posts_edges_node_reactions(
          [void Function(
                  GPostsForTagData_tag_posts_edges_node_reactionsBuilder)?
              updates]) =>
      (GPostsForTagData_tag_posts_edges_node_reactionsBuilder()
            ..update(updates))
          ._build();

  _$GPostsForTagData_tag_posts_edges_node_reactions._(
      {required this.G__typename,
      required this.emoji,
      required this.count,
      required this.byViewer})
      : super._();
  @override
  GPostsForTagData_tag_posts_edges_node_reactions rebuild(
          void Function(GPostsForTagData_tag_posts_edges_node_reactionsBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostsForTagData_tag_posts_edges_node_reactionsBuilder toBuilder() =>
      GPostsForTagData_tag_posts_edges_node_reactionsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostsForTagData_tag_posts_edges_node_reactions &&
        G__typename == other.G__typename &&
        emoji == other.emoji &&
        count == other.count &&
        byViewer == other.byViewer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, emoji.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, byViewer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GPostsForTagData_tag_posts_edges_node_reactions')
          ..add('G__typename', G__typename)
          ..add('emoji', emoji)
          ..add('count', count)
          ..add('byViewer', byViewer))
        .toString();
  }
}

class GPostsForTagData_tag_posts_edges_node_reactionsBuilder
    implements
        Builder<GPostsForTagData_tag_posts_edges_node_reactions,
            GPostsForTagData_tag_posts_edges_node_reactionsBuilder> {
  _$GPostsForTagData_tag_posts_edges_node_reactions? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _emoji;
  String? get emoji => _$this._emoji;
  set emoji(String? emoji) => _$this._emoji = emoji;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  bool? _byViewer;
  bool? get byViewer => _$this._byViewer;
  set byViewer(bool? byViewer) => _$this._byViewer = byViewer;

  GPostsForTagData_tag_posts_edges_node_reactionsBuilder() {
    GPostsForTagData_tag_posts_edges_node_reactions._initializeBuilder(this);
  }

  GPostsForTagData_tag_posts_edges_node_reactionsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _emoji = $v.emoji;
      _count = $v.count;
      _byViewer = $v.byViewer;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostsForTagData_tag_posts_edges_node_reactions other) {
    _$v = other as _$GPostsForTagData_tag_posts_edges_node_reactions;
  }

  @override
  void update(
      void Function(GPostsForTagData_tag_posts_edges_node_reactionsBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostsForTagData_tag_posts_edges_node_reactions build() => _build();

  _$GPostsForTagData_tag_posts_edges_node_reactions _build() {
    final _$result = _$v ??
        _$GPostsForTagData_tag_posts_edges_node_reactions._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GPostsForTagData_tag_posts_edges_node_reactions',
              'G__typename'),
          emoji: BuiltValueNullFieldError.checkNotNull(emoji,
              r'GPostsForTagData_tag_posts_edges_node_reactions', 'emoji'),
          count: BuiltValueNullFieldError.checkNotNull(count,
              r'GPostsForTagData_tag_posts_edges_node_reactions', 'count'),
          byViewer: BuiltValueNullFieldError.checkNotNull(byViewer,
              r'GPostsForTagData_tag_posts_edges_node_reactions', 'byViewer'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GPostDetailData extends GPostDetailData {
  @override
  final String G__typename;
  @override
  final GPostDetailData_post? post;

  factory _$GPostDetailData([void Function(GPostDetailDataBuilder)? updates]) =>
      (GPostDetailDataBuilder()..update(updates))._build();

  _$GPostDetailData._({required this.G__typename, this.post}) : super._();
  @override
  GPostDetailData rebuild(void Function(GPostDetailDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostDetailDataBuilder toBuilder() => GPostDetailDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostDetailData &&
        G__typename == other.G__typename &&
        post == other.post;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, post.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostDetailData')
          ..add('G__typename', G__typename)
          ..add('post', post))
        .toString();
  }
}

class GPostDetailDataBuilder
    implements Builder<GPostDetailData, GPostDetailDataBuilder> {
  _$GPostDetailData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GPostDetailData_postBuilder? _post;
  GPostDetailData_postBuilder get post =>
      _$this._post ??= GPostDetailData_postBuilder();
  set post(GPostDetailData_postBuilder? post) => _$this._post = post;

  GPostDetailDataBuilder() {
    GPostDetailData._initializeBuilder(this);
  }

  GPostDetailDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _post = $v.post?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostDetailData other) {
    _$v = other as _$GPostDetailData;
  }

  @override
  void update(void Function(GPostDetailDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostDetailData build() => _build();

  _$GPostDetailData _build() {
    _$GPostDetailData _$result;
    try {
      _$result = _$v ??
          _$GPostDetailData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GPostDetailData', 'G__typename'),
            post: _post?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'post';
        _post?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GPostDetailData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GPostDetailData_post extends GPostDetailData_post {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String title;
  @override
  final String body;
  @override
  final _i2.GTime createdAt;
  @override
  final _i2.GTime? editedAt;
  @override
  final _i2.GDecisionStatus? decisionStatus;
  @override
  final bool denyFlag;
  @override
  final GPostDetailData_post_author author;
  @override
  final BuiltList<GPostDetailData_post_reactions> reactions;
  @override
  final BuiltList<GPostDetailData_post_tags> tags;
  @override
  final GPostDetailData_post_comments comments;
  @override
  final GPostDetailData_post_myPermissions myPermissions;

  factory _$GPostDetailData_post(
          [void Function(GPostDetailData_postBuilder)? updates]) =>
      (GPostDetailData_postBuilder()..update(updates))._build();

  _$GPostDetailData_post._(
      {required this.G__typename,
      required this.id,
      required this.title,
      required this.body,
      required this.createdAt,
      this.editedAt,
      this.decisionStatus,
      required this.denyFlag,
      required this.author,
      required this.reactions,
      required this.tags,
      required this.comments,
      required this.myPermissions})
      : super._();
  @override
  GPostDetailData_post rebuild(
          void Function(GPostDetailData_postBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostDetailData_postBuilder toBuilder() =>
      GPostDetailData_postBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostDetailData_post &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        body == other.body &&
        createdAt == other.createdAt &&
        editedAt == other.editedAt &&
        decisionStatus == other.decisionStatus &&
        denyFlag == other.denyFlag &&
        author == other.author &&
        reactions == other.reactions &&
        tags == other.tags &&
        comments == other.comments &&
        myPermissions == other.myPermissions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, editedAt.hashCode);
    _$hash = $jc(_$hash, decisionStatus.hashCode);
    _$hash = $jc(_$hash, denyFlag.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, reactions.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, comments.hashCode);
    _$hash = $jc(_$hash, myPermissions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostDetailData_post')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('body', body)
          ..add('createdAt', createdAt)
          ..add('editedAt', editedAt)
          ..add('decisionStatus', decisionStatus)
          ..add('denyFlag', denyFlag)
          ..add('author', author)
          ..add('reactions', reactions)
          ..add('tags', tags)
          ..add('comments', comments)
          ..add('myPermissions', myPermissions))
        .toString();
  }
}

class GPostDetailData_postBuilder
    implements Builder<GPostDetailData_post, GPostDetailData_postBuilder> {
  _$GPostDetailData_post? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  _i2.GTimeBuilder? _createdAt;
  _i2.GTimeBuilder get createdAt => _$this._createdAt ??= _i2.GTimeBuilder();
  set createdAt(_i2.GTimeBuilder? createdAt) => _$this._createdAt = createdAt;

  _i2.GTimeBuilder? _editedAt;
  _i2.GTimeBuilder get editedAt => _$this._editedAt ??= _i2.GTimeBuilder();
  set editedAt(_i2.GTimeBuilder? editedAt) => _$this._editedAt = editedAt;

  _i2.GDecisionStatus? _decisionStatus;
  _i2.GDecisionStatus? get decisionStatus => _$this._decisionStatus;
  set decisionStatus(_i2.GDecisionStatus? decisionStatus) =>
      _$this._decisionStatus = decisionStatus;

  bool? _denyFlag;
  bool? get denyFlag => _$this._denyFlag;
  set denyFlag(bool? denyFlag) => _$this._denyFlag = denyFlag;

  GPostDetailData_post_authorBuilder? _author;
  GPostDetailData_post_authorBuilder get author =>
      _$this._author ??= GPostDetailData_post_authorBuilder();
  set author(GPostDetailData_post_authorBuilder? author) =>
      _$this._author = author;

  ListBuilder<GPostDetailData_post_reactions>? _reactions;
  ListBuilder<GPostDetailData_post_reactions> get reactions =>
      _$this._reactions ??= ListBuilder<GPostDetailData_post_reactions>();
  set reactions(ListBuilder<GPostDetailData_post_reactions>? reactions) =>
      _$this._reactions = reactions;

  ListBuilder<GPostDetailData_post_tags>? _tags;
  ListBuilder<GPostDetailData_post_tags> get tags =>
      _$this._tags ??= ListBuilder<GPostDetailData_post_tags>();
  set tags(ListBuilder<GPostDetailData_post_tags>? tags) => _$this._tags = tags;

  GPostDetailData_post_commentsBuilder? _comments;
  GPostDetailData_post_commentsBuilder get comments =>
      _$this._comments ??= GPostDetailData_post_commentsBuilder();
  set comments(GPostDetailData_post_commentsBuilder? comments) =>
      _$this._comments = comments;

  GPostDetailData_post_myPermissionsBuilder? _myPermissions;
  GPostDetailData_post_myPermissionsBuilder get myPermissions =>
      _$this._myPermissions ??= GPostDetailData_post_myPermissionsBuilder();
  set myPermissions(GPostDetailData_post_myPermissionsBuilder? myPermissions) =>
      _$this._myPermissions = myPermissions;

  GPostDetailData_postBuilder() {
    GPostDetailData_post._initializeBuilder(this);
  }

  GPostDetailData_postBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _body = $v.body;
      _createdAt = $v.createdAt.toBuilder();
      _editedAt = $v.editedAt?.toBuilder();
      _decisionStatus = $v.decisionStatus;
      _denyFlag = $v.denyFlag;
      _author = $v.author.toBuilder();
      _reactions = $v.reactions.toBuilder();
      _tags = $v.tags.toBuilder();
      _comments = $v.comments.toBuilder();
      _myPermissions = $v.myPermissions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostDetailData_post other) {
    _$v = other as _$GPostDetailData_post;
  }

  @override
  void update(void Function(GPostDetailData_postBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostDetailData_post build() => _build();

  _$GPostDetailData_post _build() {
    _$GPostDetailData_post _$result;
    try {
      _$result = _$v ??
          _$GPostDetailData_post._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GPostDetailData_post', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GPostDetailData_post', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GPostDetailData_post', 'title'),
            body: BuiltValueNullFieldError.checkNotNull(
                body, r'GPostDetailData_post', 'body'),
            createdAt: createdAt.build(),
            editedAt: _editedAt?.build(),
            decisionStatus: decisionStatus,
            denyFlag: BuiltValueNullFieldError.checkNotNull(
                denyFlag, r'GPostDetailData_post', 'denyFlag'),
            author: author.build(),
            reactions: reactions.build(),
            tags: tags.build(),
            comments: comments.build(),
            myPermissions: myPermissions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'editedAt';
        _editedAt?.build();

        _$failedField = 'author';
        author.build();
        _$failedField = 'reactions';
        reactions.build();
        _$failedField = 'tags';
        tags.build();
        _$failedField = 'comments';
        comments.build();
        _$failedField = 'myPermissions';
        myPermissions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GPostDetailData_post', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GPostDetailData_post_author extends GPostDetailData_post_author {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;

  factory _$GPostDetailData_post_author(
          [void Function(GPostDetailData_post_authorBuilder)? updates]) =>
      (GPostDetailData_post_authorBuilder()..update(updates))._build();

  _$GPostDetailData_post_author._(
      {required this.G__typename, required this.id, required this.displayName})
      : super._();
  @override
  GPostDetailData_post_author rebuild(
          void Function(GPostDetailData_post_authorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostDetailData_post_authorBuilder toBuilder() =>
      GPostDetailData_post_authorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostDetailData_post_author &&
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
    return (newBuiltValueToStringHelper(r'GPostDetailData_post_author')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName))
        .toString();
  }
}

class GPostDetailData_post_authorBuilder
    implements
        Builder<GPostDetailData_post_author,
            GPostDetailData_post_authorBuilder> {
  _$GPostDetailData_post_author? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GPostDetailData_post_authorBuilder() {
    GPostDetailData_post_author._initializeBuilder(this);
  }

  GPostDetailData_post_authorBuilder get _$this {
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
  void replace(GPostDetailData_post_author other) {
    _$v = other as _$GPostDetailData_post_author;
  }

  @override
  void update(void Function(GPostDetailData_post_authorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostDetailData_post_author build() => _build();

  _$GPostDetailData_post_author _build() {
    final _$result = _$v ??
        _$GPostDetailData_post_author._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GPostDetailData_post_author', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GPostDetailData_post_author', 'id'),
          displayName: BuiltValueNullFieldError.checkNotNull(
              displayName, r'GPostDetailData_post_author', 'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GPostDetailData_post_reactions extends GPostDetailData_post_reactions {
  @override
  final String G__typename;
  @override
  final String emoji;
  @override
  final int count;
  @override
  final bool byViewer;

  factory _$GPostDetailData_post_reactions(
          [void Function(GPostDetailData_post_reactionsBuilder)? updates]) =>
      (GPostDetailData_post_reactionsBuilder()..update(updates))._build();

  _$GPostDetailData_post_reactions._(
      {required this.G__typename,
      required this.emoji,
      required this.count,
      required this.byViewer})
      : super._();
  @override
  GPostDetailData_post_reactions rebuild(
          void Function(GPostDetailData_post_reactionsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostDetailData_post_reactionsBuilder toBuilder() =>
      GPostDetailData_post_reactionsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostDetailData_post_reactions &&
        G__typename == other.G__typename &&
        emoji == other.emoji &&
        count == other.count &&
        byViewer == other.byViewer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, emoji.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, byViewer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostDetailData_post_reactions')
          ..add('G__typename', G__typename)
          ..add('emoji', emoji)
          ..add('count', count)
          ..add('byViewer', byViewer))
        .toString();
  }
}

class GPostDetailData_post_reactionsBuilder
    implements
        Builder<GPostDetailData_post_reactions,
            GPostDetailData_post_reactionsBuilder> {
  _$GPostDetailData_post_reactions? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _emoji;
  String? get emoji => _$this._emoji;
  set emoji(String? emoji) => _$this._emoji = emoji;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  bool? _byViewer;
  bool? get byViewer => _$this._byViewer;
  set byViewer(bool? byViewer) => _$this._byViewer = byViewer;

  GPostDetailData_post_reactionsBuilder() {
    GPostDetailData_post_reactions._initializeBuilder(this);
  }

  GPostDetailData_post_reactionsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _emoji = $v.emoji;
      _count = $v.count;
      _byViewer = $v.byViewer;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostDetailData_post_reactions other) {
    _$v = other as _$GPostDetailData_post_reactions;
  }

  @override
  void update(void Function(GPostDetailData_post_reactionsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostDetailData_post_reactions build() => _build();

  _$GPostDetailData_post_reactions _build() {
    final _$result = _$v ??
        _$GPostDetailData_post_reactions._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GPostDetailData_post_reactions', 'G__typename'),
          emoji: BuiltValueNullFieldError.checkNotNull(
              emoji, r'GPostDetailData_post_reactions', 'emoji'),
          count: BuiltValueNullFieldError.checkNotNull(
              count, r'GPostDetailData_post_reactions', 'count'),
          byViewer: BuiltValueNullFieldError.checkNotNull(
              byViewer, r'GPostDetailData_post_reactions', 'byViewer'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GPostDetailData_post_tags extends GPostDetailData_post_tags {
  @override
  final String G__typename;
  @override
  final GPostDetailData_post_tags_tag tag;

  factory _$GPostDetailData_post_tags(
          [void Function(GPostDetailData_post_tagsBuilder)? updates]) =>
      (GPostDetailData_post_tagsBuilder()..update(updates))._build();

  _$GPostDetailData_post_tags._({required this.G__typename, required this.tag})
      : super._();
  @override
  GPostDetailData_post_tags rebuild(
          void Function(GPostDetailData_post_tagsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostDetailData_post_tagsBuilder toBuilder() =>
      GPostDetailData_post_tagsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostDetailData_post_tags &&
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
    return (newBuiltValueToStringHelper(r'GPostDetailData_post_tags')
          ..add('G__typename', G__typename)
          ..add('tag', tag))
        .toString();
  }
}

class GPostDetailData_post_tagsBuilder
    implements
        Builder<GPostDetailData_post_tags, GPostDetailData_post_tagsBuilder> {
  _$GPostDetailData_post_tags? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GPostDetailData_post_tags_tagBuilder? _tag;
  GPostDetailData_post_tags_tagBuilder get tag =>
      _$this._tag ??= GPostDetailData_post_tags_tagBuilder();
  set tag(GPostDetailData_post_tags_tagBuilder? tag) => _$this._tag = tag;

  GPostDetailData_post_tagsBuilder() {
    GPostDetailData_post_tags._initializeBuilder(this);
  }

  GPostDetailData_post_tagsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _tag = $v.tag.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostDetailData_post_tags other) {
    _$v = other as _$GPostDetailData_post_tags;
  }

  @override
  void update(void Function(GPostDetailData_post_tagsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostDetailData_post_tags build() => _build();

  _$GPostDetailData_post_tags _build() {
    _$GPostDetailData_post_tags _$result;
    try {
      _$result = _$v ??
          _$GPostDetailData_post_tags._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GPostDetailData_post_tags', 'G__typename'),
            tag: tag.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tag';
        tag.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GPostDetailData_post_tags', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GPostDetailData_post_tags_tag extends GPostDetailData_post_tags_tag {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String slug;
  @override
  final String displayName;

  factory _$GPostDetailData_post_tags_tag(
          [void Function(GPostDetailData_post_tags_tagBuilder)? updates]) =>
      (GPostDetailData_post_tags_tagBuilder()..update(updates))._build();

  _$GPostDetailData_post_tags_tag._(
      {required this.G__typename,
      required this.id,
      required this.slug,
      required this.displayName})
      : super._();
  @override
  GPostDetailData_post_tags_tag rebuild(
          void Function(GPostDetailData_post_tags_tagBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostDetailData_post_tags_tagBuilder toBuilder() =>
      GPostDetailData_post_tags_tagBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostDetailData_post_tags_tag &&
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
    return (newBuiltValueToStringHelper(r'GPostDetailData_post_tags_tag')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('slug', slug)
          ..add('displayName', displayName))
        .toString();
  }
}

class GPostDetailData_post_tags_tagBuilder
    implements
        Builder<GPostDetailData_post_tags_tag,
            GPostDetailData_post_tags_tagBuilder> {
  _$GPostDetailData_post_tags_tag? _$v;

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

  GPostDetailData_post_tags_tagBuilder() {
    GPostDetailData_post_tags_tag._initializeBuilder(this);
  }

  GPostDetailData_post_tags_tagBuilder get _$this {
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
  void replace(GPostDetailData_post_tags_tag other) {
    _$v = other as _$GPostDetailData_post_tags_tag;
  }

  @override
  void update(void Function(GPostDetailData_post_tags_tagBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostDetailData_post_tags_tag build() => _build();

  _$GPostDetailData_post_tags_tag _build() {
    final _$result = _$v ??
        _$GPostDetailData_post_tags_tag._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GPostDetailData_post_tags_tag', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GPostDetailData_post_tags_tag', 'id'),
          slug: BuiltValueNullFieldError.checkNotNull(
              slug, r'GPostDetailData_post_tags_tag', 'slug'),
          displayName: BuiltValueNullFieldError.checkNotNull(
              displayName, r'GPostDetailData_post_tags_tag', 'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GPostDetailData_post_comments extends GPostDetailData_post_comments {
  @override
  final String G__typename;
  @override
  final BuiltList<GPostDetailData_post_comments_edges> edges;

  factory _$GPostDetailData_post_comments(
          [void Function(GPostDetailData_post_commentsBuilder)? updates]) =>
      (GPostDetailData_post_commentsBuilder()..update(updates))._build();

  _$GPostDetailData_post_comments._(
      {required this.G__typename, required this.edges})
      : super._();
  @override
  GPostDetailData_post_comments rebuild(
          void Function(GPostDetailData_post_commentsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostDetailData_post_commentsBuilder toBuilder() =>
      GPostDetailData_post_commentsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostDetailData_post_comments &&
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
    return (newBuiltValueToStringHelper(r'GPostDetailData_post_comments')
          ..add('G__typename', G__typename)
          ..add('edges', edges))
        .toString();
  }
}

class GPostDetailData_post_commentsBuilder
    implements
        Builder<GPostDetailData_post_comments,
            GPostDetailData_post_commentsBuilder> {
  _$GPostDetailData_post_comments? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GPostDetailData_post_comments_edges>? _edges;
  ListBuilder<GPostDetailData_post_comments_edges> get edges =>
      _$this._edges ??= ListBuilder<GPostDetailData_post_comments_edges>();
  set edges(ListBuilder<GPostDetailData_post_comments_edges>? edges) =>
      _$this._edges = edges;

  GPostDetailData_post_commentsBuilder() {
    GPostDetailData_post_comments._initializeBuilder(this);
  }

  GPostDetailData_post_commentsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _edges = $v.edges.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostDetailData_post_comments other) {
    _$v = other as _$GPostDetailData_post_comments;
  }

  @override
  void update(void Function(GPostDetailData_post_commentsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostDetailData_post_comments build() => _build();

  _$GPostDetailData_post_comments _build() {
    _$GPostDetailData_post_comments _$result;
    try {
      _$result = _$v ??
          _$GPostDetailData_post_comments._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GPostDetailData_post_comments', 'G__typename'),
            edges: edges.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'edges';
        edges.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GPostDetailData_post_comments', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GPostDetailData_post_comments_edges
    extends GPostDetailData_post_comments_edges {
  @override
  final String G__typename;
  @override
  final GPostDetailData_post_comments_edges_node node;

  factory _$GPostDetailData_post_comments_edges(
          [void Function(GPostDetailData_post_comments_edgesBuilder)?
              updates]) =>
      (GPostDetailData_post_comments_edgesBuilder()..update(updates))._build();

  _$GPostDetailData_post_comments_edges._(
      {required this.G__typename, required this.node})
      : super._();
  @override
  GPostDetailData_post_comments_edges rebuild(
          void Function(GPostDetailData_post_comments_edgesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostDetailData_post_comments_edgesBuilder toBuilder() =>
      GPostDetailData_post_comments_edgesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostDetailData_post_comments_edges &&
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
    return (newBuiltValueToStringHelper(r'GPostDetailData_post_comments_edges')
          ..add('G__typename', G__typename)
          ..add('node', node))
        .toString();
  }
}

class GPostDetailData_post_comments_edgesBuilder
    implements
        Builder<GPostDetailData_post_comments_edges,
            GPostDetailData_post_comments_edgesBuilder> {
  _$GPostDetailData_post_comments_edges? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GPostDetailData_post_comments_edges_nodeBuilder? _node;
  GPostDetailData_post_comments_edges_nodeBuilder get node =>
      _$this._node ??= GPostDetailData_post_comments_edges_nodeBuilder();
  set node(GPostDetailData_post_comments_edges_nodeBuilder? node) =>
      _$this._node = node;

  GPostDetailData_post_comments_edgesBuilder() {
    GPostDetailData_post_comments_edges._initializeBuilder(this);
  }

  GPostDetailData_post_comments_edgesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _node = $v.node.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostDetailData_post_comments_edges other) {
    _$v = other as _$GPostDetailData_post_comments_edges;
  }

  @override
  void update(
      void Function(GPostDetailData_post_comments_edgesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostDetailData_post_comments_edges build() => _build();

  _$GPostDetailData_post_comments_edges _build() {
    _$GPostDetailData_post_comments_edges _$result;
    try {
      _$result = _$v ??
          _$GPostDetailData_post_comments_edges._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GPostDetailData_post_comments_edges', 'G__typename'),
            node: node.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'node';
        node.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(r'GPostDetailData_post_comments_edges',
            _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GPostDetailData_post_comments_edges_node
    extends GPostDetailData_post_comments_edges_node {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String postId;
  @override
  final String? parentId;
  @override
  final int depth;
  @override
  final String body;
  @override
  final _i2.GTime createdAt;
  @override
  final _i2.GTime? editedAt;
  @override
  final GPostDetailData_post_comments_edges_node_author author;
  @override
  final BuiltList<GPostDetailData_post_comments_edges_node_reactions> reactions;

  factory _$GPostDetailData_post_comments_edges_node(
          [void Function(GPostDetailData_post_comments_edges_nodeBuilder)?
              updates]) =>
      (GPostDetailData_post_comments_edges_nodeBuilder()..update(updates))
          ._build();

  _$GPostDetailData_post_comments_edges_node._(
      {required this.G__typename,
      required this.id,
      required this.postId,
      this.parentId,
      required this.depth,
      required this.body,
      required this.createdAt,
      this.editedAt,
      required this.author,
      required this.reactions})
      : super._();
  @override
  GPostDetailData_post_comments_edges_node rebuild(
          void Function(GPostDetailData_post_comments_edges_nodeBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostDetailData_post_comments_edges_nodeBuilder toBuilder() =>
      GPostDetailData_post_comments_edges_nodeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostDetailData_post_comments_edges_node &&
        G__typename == other.G__typename &&
        id == other.id &&
        postId == other.postId &&
        parentId == other.parentId &&
        depth == other.depth &&
        body == other.body &&
        createdAt == other.createdAt &&
        editedAt == other.editedAt &&
        author == other.author &&
        reactions == other.reactions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, postId.hashCode);
    _$hash = $jc(_$hash, parentId.hashCode);
    _$hash = $jc(_$hash, depth.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, editedAt.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, reactions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GPostDetailData_post_comments_edges_node')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('postId', postId)
          ..add('parentId', parentId)
          ..add('depth', depth)
          ..add('body', body)
          ..add('createdAt', createdAt)
          ..add('editedAt', editedAt)
          ..add('author', author)
          ..add('reactions', reactions))
        .toString();
  }
}

class GPostDetailData_post_comments_edges_nodeBuilder
    implements
        Builder<GPostDetailData_post_comments_edges_node,
            GPostDetailData_post_comments_edges_nodeBuilder> {
  _$GPostDetailData_post_comments_edges_node? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _postId;
  String? get postId => _$this._postId;
  set postId(String? postId) => _$this._postId = postId;

  String? _parentId;
  String? get parentId => _$this._parentId;
  set parentId(String? parentId) => _$this._parentId = parentId;

  int? _depth;
  int? get depth => _$this._depth;
  set depth(int? depth) => _$this._depth = depth;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  _i2.GTimeBuilder? _createdAt;
  _i2.GTimeBuilder get createdAt => _$this._createdAt ??= _i2.GTimeBuilder();
  set createdAt(_i2.GTimeBuilder? createdAt) => _$this._createdAt = createdAt;

  _i2.GTimeBuilder? _editedAt;
  _i2.GTimeBuilder get editedAt => _$this._editedAt ??= _i2.GTimeBuilder();
  set editedAt(_i2.GTimeBuilder? editedAt) => _$this._editedAt = editedAt;

  GPostDetailData_post_comments_edges_node_authorBuilder? _author;
  GPostDetailData_post_comments_edges_node_authorBuilder get author =>
      _$this._author ??=
          GPostDetailData_post_comments_edges_node_authorBuilder();
  set author(GPostDetailData_post_comments_edges_node_authorBuilder? author) =>
      _$this._author = author;

  ListBuilder<GPostDetailData_post_comments_edges_node_reactions>? _reactions;
  ListBuilder<GPostDetailData_post_comments_edges_node_reactions>
      get reactions => _$this._reactions ??=
          ListBuilder<GPostDetailData_post_comments_edges_node_reactions>();
  set reactions(
          ListBuilder<GPostDetailData_post_comments_edges_node_reactions>?
              reactions) =>
      _$this._reactions = reactions;

  GPostDetailData_post_comments_edges_nodeBuilder() {
    GPostDetailData_post_comments_edges_node._initializeBuilder(this);
  }

  GPostDetailData_post_comments_edges_nodeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _postId = $v.postId;
      _parentId = $v.parentId;
      _depth = $v.depth;
      _body = $v.body;
      _createdAt = $v.createdAt.toBuilder();
      _editedAt = $v.editedAt?.toBuilder();
      _author = $v.author.toBuilder();
      _reactions = $v.reactions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostDetailData_post_comments_edges_node other) {
    _$v = other as _$GPostDetailData_post_comments_edges_node;
  }

  @override
  void update(
      void Function(GPostDetailData_post_comments_edges_nodeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostDetailData_post_comments_edges_node build() => _build();

  _$GPostDetailData_post_comments_edges_node _build() {
    _$GPostDetailData_post_comments_edges_node _$result;
    try {
      _$result = _$v ??
          _$GPostDetailData_post_comments_edges_node._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GPostDetailData_post_comments_edges_node', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GPostDetailData_post_comments_edges_node', 'id'),
            postId: BuiltValueNullFieldError.checkNotNull(
                postId, r'GPostDetailData_post_comments_edges_node', 'postId'),
            parentId: parentId,
            depth: BuiltValueNullFieldError.checkNotNull(
                depth, r'GPostDetailData_post_comments_edges_node', 'depth'),
            body: BuiltValueNullFieldError.checkNotNull(
                body, r'GPostDetailData_post_comments_edges_node', 'body'),
            createdAt: createdAt.build(),
            editedAt: _editedAt?.build(),
            author: author.build(),
            reactions: reactions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'editedAt';
        _editedAt?.build();
        _$failedField = 'author';
        author.build();
        _$failedField = 'reactions';
        reactions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GPostDetailData_post_comments_edges_node',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GPostDetailData_post_comments_edges_node_author
    extends GPostDetailData_post_comments_edges_node_author {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;

  factory _$GPostDetailData_post_comments_edges_node_author(
          [void Function(
                  GPostDetailData_post_comments_edges_node_authorBuilder)?
              updates]) =>
      (GPostDetailData_post_comments_edges_node_authorBuilder()
            ..update(updates))
          ._build();

  _$GPostDetailData_post_comments_edges_node_author._(
      {required this.G__typename, required this.id, required this.displayName})
      : super._();
  @override
  GPostDetailData_post_comments_edges_node_author rebuild(
          void Function(GPostDetailData_post_comments_edges_node_authorBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostDetailData_post_comments_edges_node_authorBuilder toBuilder() =>
      GPostDetailData_post_comments_edges_node_authorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostDetailData_post_comments_edges_node_author &&
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
            r'GPostDetailData_post_comments_edges_node_author')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName))
        .toString();
  }
}

class GPostDetailData_post_comments_edges_node_authorBuilder
    implements
        Builder<GPostDetailData_post_comments_edges_node_author,
            GPostDetailData_post_comments_edges_node_authorBuilder> {
  _$GPostDetailData_post_comments_edges_node_author? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GPostDetailData_post_comments_edges_node_authorBuilder() {
    GPostDetailData_post_comments_edges_node_author._initializeBuilder(this);
  }

  GPostDetailData_post_comments_edges_node_authorBuilder get _$this {
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
  void replace(GPostDetailData_post_comments_edges_node_author other) {
    _$v = other as _$GPostDetailData_post_comments_edges_node_author;
  }

  @override
  void update(
      void Function(GPostDetailData_post_comments_edges_node_authorBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostDetailData_post_comments_edges_node_author build() => _build();

  _$GPostDetailData_post_comments_edges_node_author _build() {
    final _$result = _$v ??
        _$GPostDetailData_post_comments_edges_node_author._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GPostDetailData_post_comments_edges_node_author',
              'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GPostDetailData_post_comments_edges_node_author', 'id'),
          displayName: BuiltValueNullFieldError.checkNotNull(
              displayName,
              r'GPostDetailData_post_comments_edges_node_author',
              'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GPostDetailData_post_comments_edges_node_reactions
    extends GPostDetailData_post_comments_edges_node_reactions {
  @override
  final String G__typename;
  @override
  final String emoji;
  @override
  final int count;
  @override
  final bool byViewer;

  factory _$GPostDetailData_post_comments_edges_node_reactions(
          [void Function(
                  GPostDetailData_post_comments_edges_node_reactionsBuilder)?
              updates]) =>
      (GPostDetailData_post_comments_edges_node_reactionsBuilder()
            ..update(updates))
          ._build();

  _$GPostDetailData_post_comments_edges_node_reactions._(
      {required this.G__typename,
      required this.emoji,
      required this.count,
      required this.byViewer})
      : super._();
  @override
  GPostDetailData_post_comments_edges_node_reactions rebuild(
          void Function(
                  GPostDetailData_post_comments_edges_node_reactionsBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostDetailData_post_comments_edges_node_reactionsBuilder toBuilder() =>
      GPostDetailData_post_comments_edges_node_reactionsBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostDetailData_post_comments_edges_node_reactions &&
        G__typename == other.G__typename &&
        emoji == other.emoji &&
        count == other.count &&
        byViewer == other.byViewer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, emoji.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, byViewer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GPostDetailData_post_comments_edges_node_reactions')
          ..add('G__typename', G__typename)
          ..add('emoji', emoji)
          ..add('count', count)
          ..add('byViewer', byViewer))
        .toString();
  }
}

class GPostDetailData_post_comments_edges_node_reactionsBuilder
    implements
        Builder<GPostDetailData_post_comments_edges_node_reactions,
            GPostDetailData_post_comments_edges_node_reactionsBuilder> {
  _$GPostDetailData_post_comments_edges_node_reactions? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _emoji;
  String? get emoji => _$this._emoji;
  set emoji(String? emoji) => _$this._emoji = emoji;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  bool? _byViewer;
  bool? get byViewer => _$this._byViewer;
  set byViewer(bool? byViewer) => _$this._byViewer = byViewer;

  GPostDetailData_post_comments_edges_node_reactionsBuilder() {
    GPostDetailData_post_comments_edges_node_reactions._initializeBuilder(this);
  }

  GPostDetailData_post_comments_edges_node_reactionsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _emoji = $v.emoji;
      _count = $v.count;
      _byViewer = $v.byViewer;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostDetailData_post_comments_edges_node_reactions other) {
    _$v = other as _$GPostDetailData_post_comments_edges_node_reactions;
  }

  @override
  void update(
      void Function(GPostDetailData_post_comments_edges_node_reactionsBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostDetailData_post_comments_edges_node_reactions build() => _build();

  _$GPostDetailData_post_comments_edges_node_reactions _build() {
    final _$result = _$v ??
        _$GPostDetailData_post_comments_edges_node_reactions._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GPostDetailData_post_comments_edges_node_reactions',
              'G__typename'),
          emoji: BuiltValueNullFieldError.checkNotNull(emoji,
              r'GPostDetailData_post_comments_edges_node_reactions', 'emoji'),
          count: BuiltValueNullFieldError.checkNotNull(count,
              r'GPostDetailData_post_comments_edges_node_reactions', 'count'),
          byViewer: BuiltValueNullFieldError.checkNotNull(
              byViewer,
              r'GPostDetailData_post_comments_edges_node_reactions',
              'byViewer'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GPostDetailData_post_myPermissions
    extends GPostDetailData_post_myPermissions {
  @override
  final String G__typename;
  @override
  final bool canView;
  @override
  final bool canContribute;
  @override
  final bool canModerate;

  factory _$GPostDetailData_post_myPermissions(
          [void Function(GPostDetailData_post_myPermissionsBuilder)?
              updates]) =>
      (GPostDetailData_post_myPermissionsBuilder()..update(updates))._build();

  _$GPostDetailData_post_myPermissions._(
      {required this.G__typename,
      required this.canView,
      required this.canContribute,
      required this.canModerate})
      : super._();
  @override
  GPostDetailData_post_myPermissions rebuild(
          void Function(GPostDetailData_post_myPermissionsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostDetailData_post_myPermissionsBuilder toBuilder() =>
      GPostDetailData_post_myPermissionsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostDetailData_post_myPermissions &&
        G__typename == other.G__typename &&
        canView == other.canView &&
        canContribute == other.canContribute &&
        canModerate == other.canModerate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, canView.hashCode);
    _$hash = $jc(_$hash, canContribute.hashCode);
    _$hash = $jc(_$hash, canModerate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostDetailData_post_myPermissions')
          ..add('G__typename', G__typename)
          ..add('canView', canView)
          ..add('canContribute', canContribute)
          ..add('canModerate', canModerate))
        .toString();
  }
}

class GPostDetailData_post_myPermissionsBuilder
    implements
        Builder<GPostDetailData_post_myPermissions,
            GPostDetailData_post_myPermissionsBuilder> {
  _$GPostDetailData_post_myPermissions? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _canView;
  bool? get canView => _$this._canView;
  set canView(bool? canView) => _$this._canView = canView;

  bool? _canContribute;
  bool? get canContribute => _$this._canContribute;
  set canContribute(bool? canContribute) =>
      _$this._canContribute = canContribute;

  bool? _canModerate;
  bool? get canModerate => _$this._canModerate;
  set canModerate(bool? canModerate) => _$this._canModerate = canModerate;

  GPostDetailData_post_myPermissionsBuilder() {
    GPostDetailData_post_myPermissions._initializeBuilder(this);
  }

  GPostDetailData_post_myPermissionsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _canView = $v.canView;
      _canContribute = $v.canContribute;
      _canModerate = $v.canModerate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostDetailData_post_myPermissions other) {
    _$v = other as _$GPostDetailData_post_myPermissions;
  }

  @override
  void update(
      void Function(GPostDetailData_post_myPermissionsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostDetailData_post_myPermissions build() => _build();

  _$GPostDetailData_post_myPermissions _build() {
    final _$result = _$v ??
        _$GPostDetailData_post_myPermissions._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GPostDetailData_post_myPermissions', 'G__typename'),
          canView: BuiltValueNullFieldError.checkNotNull(
              canView, r'GPostDetailData_post_myPermissions', 'canView'),
          canContribute: BuiltValueNullFieldError.checkNotNull(canContribute,
              r'GPostDetailData_post_myPermissions', 'canContribute'),
          canModerate: BuiltValueNullFieldError.checkNotNull(canModerate,
              r'GPostDetailData_post_myPermissions', 'canModerate'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCreatePostData extends GCreatePostData {
  @override
  final String G__typename;
  @override
  final GCreatePostData_createPost createPost;

  factory _$GCreatePostData([void Function(GCreatePostDataBuilder)? updates]) =>
      (GCreatePostDataBuilder()..update(updates))._build();

  _$GCreatePostData._({required this.G__typename, required this.createPost})
      : super._();
  @override
  GCreatePostData rebuild(void Function(GCreatePostDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreatePostDataBuilder toBuilder() => GCreatePostDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreatePostData &&
        G__typename == other.G__typename &&
        createPost == other.createPost;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, createPost.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreatePostData')
          ..add('G__typename', G__typename)
          ..add('createPost', createPost))
        .toString();
  }
}

class GCreatePostDataBuilder
    implements Builder<GCreatePostData, GCreatePostDataBuilder> {
  _$GCreatePostData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GCreatePostData_createPostBuilder? _createPost;
  GCreatePostData_createPostBuilder get createPost =>
      _$this._createPost ??= GCreatePostData_createPostBuilder();
  set createPost(GCreatePostData_createPostBuilder? createPost) =>
      _$this._createPost = createPost;

  GCreatePostDataBuilder() {
    GCreatePostData._initializeBuilder(this);
  }

  GCreatePostDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _createPost = $v.createPost.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreatePostData other) {
    _$v = other as _$GCreatePostData;
  }

  @override
  void update(void Function(GCreatePostDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreatePostData build() => _build();

  _$GCreatePostData _build() {
    _$GCreatePostData _$result;
    try {
      _$result = _$v ??
          _$GCreatePostData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GCreatePostData', 'G__typename'),
            createPost: createPost.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createPost';
        createPost.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GCreatePostData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreatePostData_createPost extends GCreatePostData_createPost {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String title;
  @override
  final String body;
  @override
  final _i2.GTime createdAt;
  @override
  final _i2.GTime? editedAt;
  @override
  final _i2.GDecisionStatus? decisionStatus;
  @override
  final bool denyFlag;
  @override
  final GCreatePostData_createPost_author author;
  @override
  final BuiltList<GCreatePostData_createPost_reactions> reactions;

  factory _$GCreatePostData_createPost(
          [void Function(GCreatePostData_createPostBuilder)? updates]) =>
      (GCreatePostData_createPostBuilder()..update(updates))._build();

  _$GCreatePostData_createPost._(
      {required this.G__typename,
      required this.id,
      required this.title,
      required this.body,
      required this.createdAt,
      this.editedAt,
      this.decisionStatus,
      required this.denyFlag,
      required this.author,
      required this.reactions})
      : super._();
  @override
  GCreatePostData_createPost rebuild(
          void Function(GCreatePostData_createPostBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreatePostData_createPostBuilder toBuilder() =>
      GCreatePostData_createPostBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreatePostData_createPost &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        body == other.body &&
        createdAt == other.createdAt &&
        editedAt == other.editedAt &&
        decisionStatus == other.decisionStatus &&
        denyFlag == other.denyFlag &&
        author == other.author &&
        reactions == other.reactions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, editedAt.hashCode);
    _$hash = $jc(_$hash, decisionStatus.hashCode);
    _$hash = $jc(_$hash, denyFlag.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, reactions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreatePostData_createPost')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('body', body)
          ..add('createdAt', createdAt)
          ..add('editedAt', editedAt)
          ..add('decisionStatus', decisionStatus)
          ..add('denyFlag', denyFlag)
          ..add('author', author)
          ..add('reactions', reactions))
        .toString();
  }
}

class GCreatePostData_createPostBuilder
    implements
        Builder<GCreatePostData_createPost, GCreatePostData_createPostBuilder> {
  _$GCreatePostData_createPost? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  _i2.GTimeBuilder? _createdAt;
  _i2.GTimeBuilder get createdAt => _$this._createdAt ??= _i2.GTimeBuilder();
  set createdAt(_i2.GTimeBuilder? createdAt) => _$this._createdAt = createdAt;

  _i2.GTimeBuilder? _editedAt;
  _i2.GTimeBuilder get editedAt => _$this._editedAt ??= _i2.GTimeBuilder();
  set editedAt(_i2.GTimeBuilder? editedAt) => _$this._editedAt = editedAt;

  _i2.GDecisionStatus? _decisionStatus;
  _i2.GDecisionStatus? get decisionStatus => _$this._decisionStatus;
  set decisionStatus(_i2.GDecisionStatus? decisionStatus) =>
      _$this._decisionStatus = decisionStatus;

  bool? _denyFlag;
  bool? get denyFlag => _$this._denyFlag;
  set denyFlag(bool? denyFlag) => _$this._denyFlag = denyFlag;

  GCreatePostData_createPost_authorBuilder? _author;
  GCreatePostData_createPost_authorBuilder get author =>
      _$this._author ??= GCreatePostData_createPost_authorBuilder();
  set author(GCreatePostData_createPost_authorBuilder? author) =>
      _$this._author = author;

  ListBuilder<GCreatePostData_createPost_reactions>? _reactions;
  ListBuilder<GCreatePostData_createPost_reactions> get reactions =>
      _$this._reactions ??= ListBuilder<GCreatePostData_createPost_reactions>();
  set reactions(ListBuilder<GCreatePostData_createPost_reactions>? reactions) =>
      _$this._reactions = reactions;

  GCreatePostData_createPostBuilder() {
    GCreatePostData_createPost._initializeBuilder(this);
  }

  GCreatePostData_createPostBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _body = $v.body;
      _createdAt = $v.createdAt.toBuilder();
      _editedAt = $v.editedAt?.toBuilder();
      _decisionStatus = $v.decisionStatus;
      _denyFlag = $v.denyFlag;
      _author = $v.author.toBuilder();
      _reactions = $v.reactions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreatePostData_createPost other) {
    _$v = other as _$GCreatePostData_createPost;
  }

  @override
  void update(void Function(GCreatePostData_createPostBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreatePostData_createPost build() => _build();

  _$GCreatePostData_createPost _build() {
    _$GCreatePostData_createPost _$result;
    try {
      _$result = _$v ??
          _$GCreatePostData_createPost._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GCreatePostData_createPost', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GCreatePostData_createPost', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GCreatePostData_createPost', 'title'),
            body: BuiltValueNullFieldError.checkNotNull(
                body, r'GCreatePostData_createPost', 'body'),
            createdAt: createdAt.build(),
            editedAt: _editedAt?.build(),
            decisionStatus: decisionStatus,
            denyFlag: BuiltValueNullFieldError.checkNotNull(
                denyFlag, r'GCreatePostData_createPost', 'denyFlag'),
            author: author.build(),
            reactions: reactions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'editedAt';
        _editedAt?.build();

        _$failedField = 'author';
        author.build();
        _$failedField = 'reactions';
        reactions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GCreatePostData_createPost', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreatePostData_createPost_author
    extends GCreatePostData_createPost_author {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;

  factory _$GCreatePostData_createPost_author(
          [void Function(GCreatePostData_createPost_authorBuilder)? updates]) =>
      (GCreatePostData_createPost_authorBuilder()..update(updates))._build();

  _$GCreatePostData_createPost_author._(
      {required this.G__typename, required this.id, required this.displayName})
      : super._();
  @override
  GCreatePostData_createPost_author rebuild(
          void Function(GCreatePostData_createPost_authorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreatePostData_createPost_authorBuilder toBuilder() =>
      GCreatePostData_createPost_authorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreatePostData_createPost_author &&
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
    return (newBuiltValueToStringHelper(r'GCreatePostData_createPost_author')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName))
        .toString();
  }
}

class GCreatePostData_createPost_authorBuilder
    implements
        Builder<GCreatePostData_createPost_author,
            GCreatePostData_createPost_authorBuilder> {
  _$GCreatePostData_createPost_author? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GCreatePostData_createPost_authorBuilder() {
    GCreatePostData_createPost_author._initializeBuilder(this);
  }

  GCreatePostData_createPost_authorBuilder get _$this {
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
  void replace(GCreatePostData_createPost_author other) {
    _$v = other as _$GCreatePostData_createPost_author;
  }

  @override
  void update(
      void Function(GCreatePostData_createPost_authorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreatePostData_createPost_author build() => _build();

  _$GCreatePostData_createPost_author _build() {
    final _$result = _$v ??
        _$GCreatePostData_createPost_author._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GCreatePostData_createPost_author', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GCreatePostData_createPost_author', 'id'),
          displayName: BuiltValueNullFieldError.checkNotNull(
              displayName, r'GCreatePostData_createPost_author', 'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCreatePostData_createPost_reactions
    extends GCreatePostData_createPost_reactions {
  @override
  final String G__typename;
  @override
  final String emoji;
  @override
  final int count;
  @override
  final bool byViewer;

  factory _$GCreatePostData_createPost_reactions(
          [void Function(GCreatePostData_createPost_reactionsBuilder)?
              updates]) =>
      (GCreatePostData_createPost_reactionsBuilder()..update(updates))._build();

  _$GCreatePostData_createPost_reactions._(
      {required this.G__typename,
      required this.emoji,
      required this.count,
      required this.byViewer})
      : super._();
  @override
  GCreatePostData_createPost_reactions rebuild(
          void Function(GCreatePostData_createPost_reactionsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreatePostData_createPost_reactionsBuilder toBuilder() =>
      GCreatePostData_createPost_reactionsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreatePostData_createPost_reactions &&
        G__typename == other.G__typename &&
        emoji == other.emoji &&
        count == other.count &&
        byViewer == other.byViewer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, emoji.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, byViewer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreatePostData_createPost_reactions')
          ..add('G__typename', G__typename)
          ..add('emoji', emoji)
          ..add('count', count)
          ..add('byViewer', byViewer))
        .toString();
  }
}

class GCreatePostData_createPost_reactionsBuilder
    implements
        Builder<GCreatePostData_createPost_reactions,
            GCreatePostData_createPost_reactionsBuilder> {
  _$GCreatePostData_createPost_reactions? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _emoji;
  String? get emoji => _$this._emoji;
  set emoji(String? emoji) => _$this._emoji = emoji;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  bool? _byViewer;
  bool? get byViewer => _$this._byViewer;
  set byViewer(bool? byViewer) => _$this._byViewer = byViewer;

  GCreatePostData_createPost_reactionsBuilder() {
    GCreatePostData_createPost_reactions._initializeBuilder(this);
  }

  GCreatePostData_createPost_reactionsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _emoji = $v.emoji;
      _count = $v.count;
      _byViewer = $v.byViewer;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreatePostData_createPost_reactions other) {
    _$v = other as _$GCreatePostData_createPost_reactions;
  }

  @override
  void update(
      void Function(GCreatePostData_createPost_reactionsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreatePostData_createPost_reactions build() => _build();

  _$GCreatePostData_createPost_reactions _build() {
    final _$result = _$v ??
        _$GCreatePostData_createPost_reactions._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GCreatePostData_createPost_reactions', 'G__typename'),
          emoji: BuiltValueNullFieldError.checkNotNull(
              emoji, r'GCreatePostData_createPost_reactions', 'emoji'),
          count: BuiltValueNullFieldError.checkNotNull(
              count, r'GCreatePostData_createPost_reactions', 'count'),
          byViewer: BuiltValueNullFieldError.checkNotNull(
              byViewer, r'GCreatePostData_createPost_reactions', 'byViewer'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCreateCommentData extends GCreateCommentData {
  @override
  final String G__typename;
  @override
  final GCreateCommentData_createComment createComment;

  factory _$GCreateCommentData(
          [void Function(GCreateCommentDataBuilder)? updates]) =>
      (GCreateCommentDataBuilder()..update(updates))._build();

  _$GCreateCommentData._(
      {required this.G__typename, required this.createComment})
      : super._();
  @override
  GCreateCommentData rebuild(
          void Function(GCreateCommentDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateCommentDataBuilder toBuilder() =>
      GCreateCommentDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateCommentData &&
        G__typename == other.G__typename &&
        createComment == other.createComment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, createComment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateCommentData')
          ..add('G__typename', G__typename)
          ..add('createComment', createComment))
        .toString();
  }
}

class GCreateCommentDataBuilder
    implements Builder<GCreateCommentData, GCreateCommentDataBuilder> {
  _$GCreateCommentData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GCreateCommentData_createCommentBuilder? _createComment;
  GCreateCommentData_createCommentBuilder get createComment =>
      _$this._createComment ??= GCreateCommentData_createCommentBuilder();
  set createComment(GCreateCommentData_createCommentBuilder? createComment) =>
      _$this._createComment = createComment;

  GCreateCommentDataBuilder() {
    GCreateCommentData._initializeBuilder(this);
  }

  GCreateCommentDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _createComment = $v.createComment.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateCommentData other) {
    _$v = other as _$GCreateCommentData;
  }

  @override
  void update(void Function(GCreateCommentDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateCommentData build() => _build();

  _$GCreateCommentData _build() {
    _$GCreateCommentData _$result;
    try {
      _$result = _$v ??
          _$GCreateCommentData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GCreateCommentData', 'G__typename'),
            createComment: createComment.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createComment';
        createComment.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GCreateCommentData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateCommentData_createComment
    extends GCreateCommentData_createComment {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String postId;
  @override
  final String? parentId;
  @override
  final int depth;
  @override
  final String body;
  @override
  final _i2.GTime createdAt;
  @override
  final _i2.GTime? editedAt;
  @override
  final GCreateCommentData_createComment_author author;
  @override
  final BuiltList<GCreateCommentData_createComment_reactions> reactions;

  factory _$GCreateCommentData_createComment(
          [void Function(GCreateCommentData_createCommentBuilder)? updates]) =>
      (GCreateCommentData_createCommentBuilder()..update(updates))._build();

  _$GCreateCommentData_createComment._(
      {required this.G__typename,
      required this.id,
      required this.postId,
      this.parentId,
      required this.depth,
      required this.body,
      required this.createdAt,
      this.editedAt,
      required this.author,
      required this.reactions})
      : super._();
  @override
  GCreateCommentData_createComment rebuild(
          void Function(GCreateCommentData_createCommentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateCommentData_createCommentBuilder toBuilder() =>
      GCreateCommentData_createCommentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateCommentData_createComment &&
        G__typename == other.G__typename &&
        id == other.id &&
        postId == other.postId &&
        parentId == other.parentId &&
        depth == other.depth &&
        body == other.body &&
        createdAt == other.createdAt &&
        editedAt == other.editedAt &&
        author == other.author &&
        reactions == other.reactions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, postId.hashCode);
    _$hash = $jc(_$hash, parentId.hashCode);
    _$hash = $jc(_$hash, depth.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, editedAt.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, reactions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateCommentData_createComment')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('postId', postId)
          ..add('parentId', parentId)
          ..add('depth', depth)
          ..add('body', body)
          ..add('createdAt', createdAt)
          ..add('editedAt', editedAt)
          ..add('author', author)
          ..add('reactions', reactions))
        .toString();
  }
}

class GCreateCommentData_createCommentBuilder
    implements
        Builder<GCreateCommentData_createComment,
            GCreateCommentData_createCommentBuilder> {
  _$GCreateCommentData_createComment? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _postId;
  String? get postId => _$this._postId;
  set postId(String? postId) => _$this._postId = postId;

  String? _parentId;
  String? get parentId => _$this._parentId;
  set parentId(String? parentId) => _$this._parentId = parentId;

  int? _depth;
  int? get depth => _$this._depth;
  set depth(int? depth) => _$this._depth = depth;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  _i2.GTimeBuilder? _createdAt;
  _i2.GTimeBuilder get createdAt => _$this._createdAt ??= _i2.GTimeBuilder();
  set createdAt(_i2.GTimeBuilder? createdAt) => _$this._createdAt = createdAt;

  _i2.GTimeBuilder? _editedAt;
  _i2.GTimeBuilder get editedAt => _$this._editedAt ??= _i2.GTimeBuilder();
  set editedAt(_i2.GTimeBuilder? editedAt) => _$this._editedAt = editedAt;

  GCreateCommentData_createComment_authorBuilder? _author;
  GCreateCommentData_createComment_authorBuilder get author =>
      _$this._author ??= GCreateCommentData_createComment_authorBuilder();
  set author(GCreateCommentData_createComment_authorBuilder? author) =>
      _$this._author = author;

  ListBuilder<GCreateCommentData_createComment_reactions>? _reactions;
  ListBuilder<GCreateCommentData_createComment_reactions> get reactions =>
      _$this._reactions ??=
          ListBuilder<GCreateCommentData_createComment_reactions>();
  set reactions(
          ListBuilder<GCreateCommentData_createComment_reactions>? reactions) =>
      _$this._reactions = reactions;

  GCreateCommentData_createCommentBuilder() {
    GCreateCommentData_createComment._initializeBuilder(this);
  }

  GCreateCommentData_createCommentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _postId = $v.postId;
      _parentId = $v.parentId;
      _depth = $v.depth;
      _body = $v.body;
      _createdAt = $v.createdAt.toBuilder();
      _editedAt = $v.editedAt?.toBuilder();
      _author = $v.author.toBuilder();
      _reactions = $v.reactions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateCommentData_createComment other) {
    _$v = other as _$GCreateCommentData_createComment;
  }

  @override
  void update(void Function(GCreateCommentData_createCommentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateCommentData_createComment build() => _build();

  _$GCreateCommentData_createComment _build() {
    _$GCreateCommentData_createComment _$result;
    try {
      _$result = _$v ??
          _$GCreateCommentData_createComment._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GCreateCommentData_createComment', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GCreateCommentData_createComment', 'id'),
            postId: BuiltValueNullFieldError.checkNotNull(
                postId, r'GCreateCommentData_createComment', 'postId'),
            parentId: parentId,
            depth: BuiltValueNullFieldError.checkNotNull(
                depth, r'GCreateCommentData_createComment', 'depth'),
            body: BuiltValueNullFieldError.checkNotNull(
                body, r'GCreateCommentData_createComment', 'body'),
            createdAt: createdAt.build(),
            editedAt: _editedAt?.build(),
            author: author.build(),
            reactions: reactions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'editedAt';
        _editedAt?.build();
        _$failedField = 'author';
        author.build();
        _$failedField = 'reactions';
        reactions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GCreateCommentData_createComment', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateCommentData_createComment_author
    extends GCreateCommentData_createComment_author {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;

  factory _$GCreateCommentData_createComment_author(
          [void Function(GCreateCommentData_createComment_authorBuilder)?
              updates]) =>
      (GCreateCommentData_createComment_authorBuilder()..update(updates))
          ._build();

  _$GCreateCommentData_createComment_author._(
      {required this.G__typename, required this.id, required this.displayName})
      : super._();
  @override
  GCreateCommentData_createComment_author rebuild(
          void Function(GCreateCommentData_createComment_authorBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateCommentData_createComment_authorBuilder toBuilder() =>
      GCreateCommentData_createComment_authorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateCommentData_createComment_author &&
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
            r'GCreateCommentData_createComment_author')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName))
        .toString();
  }
}

class GCreateCommentData_createComment_authorBuilder
    implements
        Builder<GCreateCommentData_createComment_author,
            GCreateCommentData_createComment_authorBuilder> {
  _$GCreateCommentData_createComment_author? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GCreateCommentData_createComment_authorBuilder() {
    GCreateCommentData_createComment_author._initializeBuilder(this);
  }

  GCreateCommentData_createComment_authorBuilder get _$this {
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
  void replace(GCreateCommentData_createComment_author other) {
    _$v = other as _$GCreateCommentData_createComment_author;
  }

  @override
  void update(
      void Function(GCreateCommentData_createComment_authorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateCommentData_createComment_author build() => _build();

  _$GCreateCommentData_createComment_author _build() {
    final _$result = _$v ??
        _$GCreateCommentData_createComment_author._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GCreateCommentData_createComment_author', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GCreateCommentData_createComment_author', 'id'),
          displayName: BuiltValueNullFieldError.checkNotNull(displayName,
              r'GCreateCommentData_createComment_author', 'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCreateCommentData_createComment_reactions
    extends GCreateCommentData_createComment_reactions {
  @override
  final String G__typename;
  @override
  final String emoji;
  @override
  final int count;
  @override
  final bool byViewer;

  factory _$GCreateCommentData_createComment_reactions(
          [void Function(GCreateCommentData_createComment_reactionsBuilder)?
              updates]) =>
      (GCreateCommentData_createComment_reactionsBuilder()..update(updates))
          ._build();

  _$GCreateCommentData_createComment_reactions._(
      {required this.G__typename,
      required this.emoji,
      required this.count,
      required this.byViewer})
      : super._();
  @override
  GCreateCommentData_createComment_reactions rebuild(
          void Function(GCreateCommentData_createComment_reactionsBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateCommentData_createComment_reactionsBuilder toBuilder() =>
      GCreateCommentData_createComment_reactionsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateCommentData_createComment_reactions &&
        G__typename == other.G__typename &&
        emoji == other.emoji &&
        count == other.count &&
        byViewer == other.byViewer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, emoji.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, byViewer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GCreateCommentData_createComment_reactions')
          ..add('G__typename', G__typename)
          ..add('emoji', emoji)
          ..add('count', count)
          ..add('byViewer', byViewer))
        .toString();
  }
}

class GCreateCommentData_createComment_reactionsBuilder
    implements
        Builder<GCreateCommentData_createComment_reactions,
            GCreateCommentData_createComment_reactionsBuilder> {
  _$GCreateCommentData_createComment_reactions? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _emoji;
  String? get emoji => _$this._emoji;
  set emoji(String? emoji) => _$this._emoji = emoji;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  bool? _byViewer;
  bool? get byViewer => _$this._byViewer;
  set byViewer(bool? byViewer) => _$this._byViewer = byViewer;

  GCreateCommentData_createComment_reactionsBuilder() {
    GCreateCommentData_createComment_reactions._initializeBuilder(this);
  }

  GCreateCommentData_createComment_reactionsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _emoji = $v.emoji;
      _count = $v.count;
      _byViewer = $v.byViewer;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateCommentData_createComment_reactions other) {
    _$v = other as _$GCreateCommentData_createComment_reactions;
  }

  @override
  void update(
      void Function(GCreateCommentData_createComment_reactionsBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateCommentData_createComment_reactions build() => _build();

  _$GCreateCommentData_createComment_reactions _build() {
    final _$result = _$v ??
        _$GCreateCommentData_createComment_reactions._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GCreateCommentData_createComment_reactions', 'G__typename'),
          emoji: BuiltValueNullFieldError.checkNotNull(
              emoji, r'GCreateCommentData_createComment_reactions', 'emoji'),
          count: BuiltValueNullFieldError.checkNotNull(
              count, r'GCreateCommentData_createComment_reactions', 'count'),
          byViewer: BuiltValueNullFieldError.checkNotNull(byViewer,
              r'GCreateCommentData_createComment_reactions', 'byViewer'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GReactToPostData extends GReactToPostData {
  @override
  final String G__typename;
  @override
  final GReactToPostData_reactToPost reactToPost;

  factory _$GReactToPostData(
          [void Function(GReactToPostDataBuilder)? updates]) =>
      (GReactToPostDataBuilder()..update(updates))._build();

  _$GReactToPostData._({required this.G__typename, required this.reactToPost})
      : super._();
  @override
  GReactToPostData rebuild(void Function(GReactToPostDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GReactToPostDataBuilder toBuilder() =>
      GReactToPostDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReactToPostData &&
        G__typename == other.G__typename &&
        reactToPost == other.reactToPost;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, reactToPost.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GReactToPostData')
          ..add('G__typename', G__typename)
          ..add('reactToPost', reactToPost))
        .toString();
  }
}

class GReactToPostDataBuilder
    implements Builder<GReactToPostData, GReactToPostDataBuilder> {
  _$GReactToPostData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GReactToPostData_reactToPostBuilder? _reactToPost;
  GReactToPostData_reactToPostBuilder get reactToPost =>
      _$this._reactToPost ??= GReactToPostData_reactToPostBuilder();
  set reactToPost(GReactToPostData_reactToPostBuilder? reactToPost) =>
      _$this._reactToPost = reactToPost;

  GReactToPostDataBuilder() {
    GReactToPostData._initializeBuilder(this);
  }

  GReactToPostDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _reactToPost = $v.reactToPost.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GReactToPostData other) {
    _$v = other as _$GReactToPostData;
  }

  @override
  void update(void Function(GReactToPostDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GReactToPostData build() => _build();

  _$GReactToPostData _build() {
    _$GReactToPostData _$result;
    try {
      _$result = _$v ??
          _$GReactToPostData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GReactToPostData', 'G__typename'),
            reactToPost: reactToPost.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'reactToPost';
        reactToPost.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GReactToPostData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GReactToPostData_reactToPost extends GReactToPostData_reactToPost {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final BuiltList<GReactToPostData_reactToPost_reactions> reactions;

  factory _$GReactToPostData_reactToPost(
          [void Function(GReactToPostData_reactToPostBuilder)? updates]) =>
      (GReactToPostData_reactToPostBuilder()..update(updates))._build();

  _$GReactToPostData_reactToPost._(
      {required this.G__typename, required this.id, required this.reactions})
      : super._();
  @override
  GReactToPostData_reactToPost rebuild(
          void Function(GReactToPostData_reactToPostBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GReactToPostData_reactToPostBuilder toBuilder() =>
      GReactToPostData_reactToPostBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReactToPostData_reactToPost &&
        G__typename == other.G__typename &&
        id == other.id &&
        reactions == other.reactions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, reactions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GReactToPostData_reactToPost')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('reactions', reactions))
        .toString();
  }
}

class GReactToPostData_reactToPostBuilder
    implements
        Builder<GReactToPostData_reactToPost,
            GReactToPostData_reactToPostBuilder> {
  _$GReactToPostData_reactToPost? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  ListBuilder<GReactToPostData_reactToPost_reactions>? _reactions;
  ListBuilder<GReactToPostData_reactToPost_reactions> get reactions =>
      _$this._reactions ??=
          ListBuilder<GReactToPostData_reactToPost_reactions>();
  set reactions(
          ListBuilder<GReactToPostData_reactToPost_reactions>? reactions) =>
      _$this._reactions = reactions;

  GReactToPostData_reactToPostBuilder() {
    GReactToPostData_reactToPost._initializeBuilder(this);
  }

  GReactToPostData_reactToPostBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _reactions = $v.reactions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GReactToPostData_reactToPost other) {
    _$v = other as _$GReactToPostData_reactToPost;
  }

  @override
  void update(void Function(GReactToPostData_reactToPostBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GReactToPostData_reactToPost build() => _build();

  _$GReactToPostData_reactToPost _build() {
    _$GReactToPostData_reactToPost _$result;
    try {
      _$result = _$v ??
          _$GReactToPostData_reactToPost._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GReactToPostData_reactToPost', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GReactToPostData_reactToPost', 'id'),
            reactions: reactions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'reactions';
        reactions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GReactToPostData_reactToPost', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GReactToPostData_reactToPost_reactions
    extends GReactToPostData_reactToPost_reactions {
  @override
  final String G__typename;
  @override
  final String emoji;
  @override
  final int count;
  @override
  final bool byViewer;

  factory _$GReactToPostData_reactToPost_reactions(
          [void Function(GReactToPostData_reactToPost_reactionsBuilder)?
              updates]) =>
      (GReactToPostData_reactToPost_reactionsBuilder()..update(updates))
          ._build();

  _$GReactToPostData_reactToPost_reactions._(
      {required this.G__typename,
      required this.emoji,
      required this.count,
      required this.byViewer})
      : super._();
  @override
  GReactToPostData_reactToPost_reactions rebuild(
          void Function(GReactToPostData_reactToPost_reactionsBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GReactToPostData_reactToPost_reactionsBuilder toBuilder() =>
      GReactToPostData_reactToPost_reactionsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReactToPostData_reactToPost_reactions &&
        G__typename == other.G__typename &&
        emoji == other.emoji &&
        count == other.count &&
        byViewer == other.byViewer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, emoji.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, byViewer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GReactToPostData_reactToPost_reactions')
          ..add('G__typename', G__typename)
          ..add('emoji', emoji)
          ..add('count', count)
          ..add('byViewer', byViewer))
        .toString();
  }
}

class GReactToPostData_reactToPost_reactionsBuilder
    implements
        Builder<GReactToPostData_reactToPost_reactions,
            GReactToPostData_reactToPost_reactionsBuilder> {
  _$GReactToPostData_reactToPost_reactions? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _emoji;
  String? get emoji => _$this._emoji;
  set emoji(String? emoji) => _$this._emoji = emoji;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  bool? _byViewer;
  bool? get byViewer => _$this._byViewer;
  set byViewer(bool? byViewer) => _$this._byViewer = byViewer;

  GReactToPostData_reactToPost_reactionsBuilder() {
    GReactToPostData_reactToPost_reactions._initializeBuilder(this);
  }

  GReactToPostData_reactToPost_reactionsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _emoji = $v.emoji;
      _count = $v.count;
      _byViewer = $v.byViewer;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GReactToPostData_reactToPost_reactions other) {
    _$v = other as _$GReactToPostData_reactToPost_reactions;
  }

  @override
  void update(
      void Function(GReactToPostData_reactToPost_reactionsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GReactToPostData_reactToPost_reactions build() => _build();

  _$GReactToPostData_reactToPost_reactions _build() {
    final _$result = _$v ??
        _$GReactToPostData_reactToPost_reactions._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GReactToPostData_reactToPost_reactions', 'G__typename'),
          emoji: BuiltValueNullFieldError.checkNotNull(
              emoji, r'GReactToPostData_reactToPost_reactions', 'emoji'),
          count: BuiltValueNullFieldError.checkNotNull(
              count, r'GReactToPostData_reactToPost_reactions', 'count'),
          byViewer: BuiltValueNullFieldError.checkNotNull(
              byViewer, r'GReactToPostData_reactToPost_reactions', 'byViewer'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GUnreactToPostData extends GUnreactToPostData {
  @override
  final String G__typename;
  @override
  final GUnreactToPostData_unreactToPost unreactToPost;

  factory _$GUnreactToPostData(
          [void Function(GUnreactToPostDataBuilder)? updates]) =>
      (GUnreactToPostDataBuilder()..update(updates))._build();

  _$GUnreactToPostData._(
      {required this.G__typename, required this.unreactToPost})
      : super._();
  @override
  GUnreactToPostData rebuild(
          void Function(GUnreactToPostDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUnreactToPostDataBuilder toBuilder() =>
      GUnreactToPostDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUnreactToPostData &&
        G__typename == other.G__typename &&
        unreactToPost == other.unreactToPost;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, unreactToPost.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUnreactToPostData')
          ..add('G__typename', G__typename)
          ..add('unreactToPost', unreactToPost))
        .toString();
  }
}

class GUnreactToPostDataBuilder
    implements Builder<GUnreactToPostData, GUnreactToPostDataBuilder> {
  _$GUnreactToPostData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUnreactToPostData_unreactToPostBuilder? _unreactToPost;
  GUnreactToPostData_unreactToPostBuilder get unreactToPost =>
      _$this._unreactToPost ??= GUnreactToPostData_unreactToPostBuilder();
  set unreactToPost(GUnreactToPostData_unreactToPostBuilder? unreactToPost) =>
      _$this._unreactToPost = unreactToPost;

  GUnreactToPostDataBuilder() {
    GUnreactToPostData._initializeBuilder(this);
  }

  GUnreactToPostDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _unreactToPost = $v.unreactToPost.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUnreactToPostData other) {
    _$v = other as _$GUnreactToPostData;
  }

  @override
  void update(void Function(GUnreactToPostDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUnreactToPostData build() => _build();

  _$GUnreactToPostData _build() {
    _$GUnreactToPostData _$result;
    try {
      _$result = _$v ??
          _$GUnreactToPostData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GUnreactToPostData', 'G__typename'),
            unreactToPost: unreactToPost.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'unreactToPost';
        unreactToPost.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GUnreactToPostData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUnreactToPostData_unreactToPost
    extends GUnreactToPostData_unreactToPost {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final BuiltList<GUnreactToPostData_unreactToPost_reactions> reactions;

  factory _$GUnreactToPostData_unreactToPost(
          [void Function(GUnreactToPostData_unreactToPostBuilder)? updates]) =>
      (GUnreactToPostData_unreactToPostBuilder()..update(updates))._build();

  _$GUnreactToPostData_unreactToPost._(
      {required this.G__typename, required this.id, required this.reactions})
      : super._();
  @override
  GUnreactToPostData_unreactToPost rebuild(
          void Function(GUnreactToPostData_unreactToPostBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUnreactToPostData_unreactToPostBuilder toBuilder() =>
      GUnreactToPostData_unreactToPostBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUnreactToPostData_unreactToPost &&
        G__typename == other.G__typename &&
        id == other.id &&
        reactions == other.reactions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, reactions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUnreactToPostData_unreactToPost')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('reactions', reactions))
        .toString();
  }
}

class GUnreactToPostData_unreactToPostBuilder
    implements
        Builder<GUnreactToPostData_unreactToPost,
            GUnreactToPostData_unreactToPostBuilder> {
  _$GUnreactToPostData_unreactToPost? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  ListBuilder<GUnreactToPostData_unreactToPost_reactions>? _reactions;
  ListBuilder<GUnreactToPostData_unreactToPost_reactions> get reactions =>
      _$this._reactions ??=
          ListBuilder<GUnreactToPostData_unreactToPost_reactions>();
  set reactions(
          ListBuilder<GUnreactToPostData_unreactToPost_reactions>? reactions) =>
      _$this._reactions = reactions;

  GUnreactToPostData_unreactToPostBuilder() {
    GUnreactToPostData_unreactToPost._initializeBuilder(this);
  }

  GUnreactToPostData_unreactToPostBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _reactions = $v.reactions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUnreactToPostData_unreactToPost other) {
    _$v = other as _$GUnreactToPostData_unreactToPost;
  }

  @override
  void update(void Function(GUnreactToPostData_unreactToPostBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUnreactToPostData_unreactToPost build() => _build();

  _$GUnreactToPostData_unreactToPost _build() {
    _$GUnreactToPostData_unreactToPost _$result;
    try {
      _$result = _$v ??
          _$GUnreactToPostData_unreactToPost._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GUnreactToPostData_unreactToPost', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GUnreactToPostData_unreactToPost', 'id'),
            reactions: reactions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'reactions';
        reactions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GUnreactToPostData_unreactToPost', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUnreactToPostData_unreactToPost_reactions
    extends GUnreactToPostData_unreactToPost_reactions {
  @override
  final String G__typename;
  @override
  final String emoji;
  @override
  final int count;
  @override
  final bool byViewer;

  factory _$GUnreactToPostData_unreactToPost_reactions(
          [void Function(GUnreactToPostData_unreactToPost_reactionsBuilder)?
              updates]) =>
      (GUnreactToPostData_unreactToPost_reactionsBuilder()..update(updates))
          ._build();

  _$GUnreactToPostData_unreactToPost_reactions._(
      {required this.G__typename,
      required this.emoji,
      required this.count,
      required this.byViewer})
      : super._();
  @override
  GUnreactToPostData_unreactToPost_reactions rebuild(
          void Function(GUnreactToPostData_unreactToPost_reactionsBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUnreactToPostData_unreactToPost_reactionsBuilder toBuilder() =>
      GUnreactToPostData_unreactToPost_reactionsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUnreactToPostData_unreactToPost_reactions &&
        G__typename == other.G__typename &&
        emoji == other.emoji &&
        count == other.count &&
        byViewer == other.byViewer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, emoji.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, byViewer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GUnreactToPostData_unreactToPost_reactions')
          ..add('G__typename', G__typename)
          ..add('emoji', emoji)
          ..add('count', count)
          ..add('byViewer', byViewer))
        .toString();
  }
}

class GUnreactToPostData_unreactToPost_reactionsBuilder
    implements
        Builder<GUnreactToPostData_unreactToPost_reactions,
            GUnreactToPostData_unreactToPost_reactionsBuilder> {
  _$GUnreactToPostData_unreactToPost_reactions? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _emoji;
  String? get emoji => _$this._emoji;
  set emoji(String? emoji) => _$this._emoji = emoji;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  bool? _byViewer;
  bool? get byViewer => _$this._byViewer;
  set byViewer(bool? byViewer) => _$this._byViewer = byViewer;

  GUnreactToPostData_unreactToPost_reactionsBuilder() {
    GUnreactToPostData_unreactToPost_reactions._initializeBuilder(this);
  }

  GUnreactToPostData_unreactToPost_reactionsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _emoji = $v.emoji;
      _count = $v.count;
      _byViewer = $v.byViewer;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUnreactToPostData_unreactToPost_reactions other) {
    _$v = other as _$GUnreactToPostData_unreactToPost_reactions;
  }

  @override
  void update(
      void Function(GUnreactToPostData_unreactToPost_reactionsBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GUnreactToPostData_unreactToPost_reactions build() => _build();

  _$GUnreactToPostData_unreactToPost_reactions _build() {
    final _$result = _$v ??
        _$GUnreactToPostData_unreactToPost_reactions._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GUnreactToPostData_unreactToPost_reactions', 'G__typename'),
          emoji: BuiltValueNullFieldError.checkNotNull(
              emoji, r'GUnreactToPostData_unreactToPost_reactions', 'emoji'),
          count: BuiltValueNullFieldError.checkNotNull(
              count, r'GUnreactToPostData_unreactToPost_reactions', 'count'),
          byViewer: BuiltValueNullFieldError.checkNotNull(byViewer,
              r'GUnreactToPostData_unreactToPost_reactions', 'byViewer'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GPostChangedData extends GPostChangedData {
  @override
  final String G__typename;
  @override
  final GPostChangedData_postChanged postChanged;

  factory _$GPostChangedData(
          [void Function(GPostChangedDataBuilder)? updates]) =>
      (GPostChangedDataBuilder()..update(updates))._build();

  _$GPostChangedData._({required this.G__typename, required this.postChanged})
      : super._();
  @override
  GPostChangedData rebuild(void Function(GPostChangedDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostChangedDataBuilder toBuilder() =>
      GPostChangedDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostChangedData &&
        G__typename == other.G__typename &&
        postChanged == other.postChanged;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, postChanged.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostChangedData')
          ..add('G__typename', G__typename)
          ..add('postChanged', postChanged))
        .toString();
  }
}

class GPostChangedDataBuilder
    implements Builder<GPostChangedData, GPostChangedDataBuilder> {
  _$GPostChangedData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GPostChangedData_postChangedBuilder? _postChanged;
  GPostChangedData_postChangedBuilder get postChanged =>
      _$this._postChanged ??= GPostChangedData_postChangedBuilder();
  set postChanged(GPostChangedData_postChangedBuilder? postChanged) =>
      _$this._postChanged = postChanged;

  GPostChangedDataBuilder() {
    GPostChangedData._initializeBuilder(this);
  }

  GPostChangedDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _postChanged = $v.postChanged.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostChangedData other) {
    _$v = other as _$GPostChangedData;
  }

  @override
  void update(void Function(GPostChangedDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostChangedData build() => _build();

  _$GPostChangedData _build() {
    _$GPostChangedData _$result;
    try {
      _$result = _$v ??
          _$GPostChangedData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GPostChangedData', 'G__typename'),
            postChanged: postChanged.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'postChanged';
        postChanged.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GPostChangedData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GPostChangedData_postChanged extends GPostChangedData_postChanged {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String title;
  @override
  final String body;
  @override
  final _i2.GTime createdAt;
  @override
  final _i2.GTime? editedAt;
  @override
  final _i2.GDecisionStatus? decisionStatus;
  @override
  final bool denyFlag;
  @override
  final GPostChangedData_postChanged_author author;
  @override
  final BuiltList<GPostChangedData_postChanged_reactions> reactions;

  factory _$GPostChangedData_postChanged(
          [void Function(GPostChangedData_postChangedBuilder)? updates]) =>
      (GPostChangedData_postChangedBuilder()..update(updates))._build();

  _$GPostChangedData_postChanged._(
      {required this.G__typename,
      required this.id,
      required this.title,
      required this.body,
      required this.createdAt,
      this.editedAt,
      this.decisionStatus,
      required this.denyFlag,
      required this.author,
      required this.reactions})
      : super._();
  @override
  GPostChangedData_postChanged rebuild(
          void Function(GPostChangedData_postChangedBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostChangedData_postChangedBuilder toBuilder() =>
      GPostChangedData_postChangedBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostChangedData_postChanged &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        body == other.body &&
        createdAt == other.createdAt &&
        editedAt == other.editedAt &&
        decisionStatus == other.decisionStatus &&
        denyFlag == other.denyFlag &&
        author == other.author &&
        reactions == other.reactions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, editedAt.hashCode);
    _$hash = $jc(_$hash, decisionStatus.hashCode);
    _$hash = $jc(_$hash, denyFlag.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, reactions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostChangedData_postChanged')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('body', body)
          ..add('createdAt', createdAt)
          ..add('editedAt', editedAt)
          ..add('decisionStatus', decisionStatus)
          ..add('denyFlag', denyFlag)
          ..add('author', author)
          ..add('reactions', reactions))
        .toString();
  }
}

class GPostChangedData_postChangedBuilder
    implements
        Builder<GPostChangedData_postChanged,
            GPostChangedData_postChangedBuilder> {
  _$GPostChangedData_postChanged? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  _i2.GTimeBuilder? _createdAt;
  _i2.GTimeBuilder get createdAt => _$this._createdAt ??= _i2.GTimeBuilder();
  set createdAt(_i2.GTimeBuilder? createdAt) => _$this._createdAt = createdAt;

  _i2.GTimeBuilder? _editedAt;
  _i2.GTimeBuilder get editedAt => _$this._editedAt ??= _i2.GTimeBuilder();
  set editedAt(_i2.GTimeBuilder? editedAt) => _$this._editedAt = editedAt;

  _i2.GDecisionStatus? _decisionStatus;
  _i2.GDecisionStatus? get decisionStatus => _$this._decisionStatus;
  set decisionStatus(_i2.GDecisionStatus? decisionStatus) =>
      _$this._decisionStatus = decisionStatus;

  bool? _denyFlag;
  bool? get denyFlag => _$this._denyFlag;
  set denyFlag(bool? denyFlag) => _$this._denyFlag = denyFlag;

  GPostChangedData_postChanged_authorBuilder? _author;
  GPostChangedData_postChanged_authorBuilder get author =>
      _$this._author ??= GPostChangedData_postChanged_authorBuilder();
  set author(GPostChangedData_postChanged_authorBuilder? author) =>
      _$this._author = author;

  ListBuilder<GPostChangedData_postChanged_reactions>? _reactions;
  ListBuilder<GPostChangedData_postChanged_reactions> get reactions =>
      _$this._reactions ??=
          ListBuilder<GPostChangedData_postChanged_reactions>();
  set reactions(
          ListBuilder<GPostChangedData_postChanged_reactions>? reactions) =>
      _$this._reactions = reactions;

  GPostChangedData_postChangedBuilder() {
    GPostChangedData_postChanged._initializeBuilder(this);
  }

  GPostChangedData_postChangedBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _body = $v.body;
      _createdAt = $v.createdAt.toBuilder();
      _editedAt = $v.editedAt?.toBuilder();
      _decisionStatus = $v.decisionStatus;
      _denyFlag = $v.denyFlag;
      _author = $v.author.toBuilder();
      _reactions = $v.reactions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostChangedData_postChanged other) {
    _$v = other as _$GPostChangedData_postChanged;
  }

  @override
  void update(void Function(GPostChangedData_postChangedBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostChangedData_postChanged build() => _build();

  _$GPostChangedData_postChanged _build() {
    _$GPostChangedData_postChanged _$result;
    try {
      _$result = _$v ??
          _$GPostChangedData_postChanged._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GPostChangedData_postChanged', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GPostChangedData_postChanged', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GPostChangedData_postChanged', 'title'),
            body: BuiltValueNullFieldError.checkNotNull(
                body, r'GPostChangedData_postChanged', 'body'),
            createdAt: createdAt.build(),
            editedAt: _editedAt?.build(),
            decisionStatus: decisionStatus,
            denyFlag: BuiltValueNullFieldError.checkNotNull(
                denyFlag, r'GPostChangedData_postChanged', 'denyFlag'),
            author: author.build(),
            reactions: reactions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'editedAt';
        _editedAt?.build();

        _$failedField = 'author';
        author.build();
        _$failedField = 'reactions';
        reactions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GPostChangedData_postChanged', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GPostChangedData_postChanged_author
    extends GPostChangedData_postChanged_author {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;

  factory _$GPostChangedData_postChanged_author(
          [void Function(GPostChangedData_postChanged_authorBuilder)?
              updates]) =>
      (GPostChangedData_postChanged_authorBuilder()..update(updates))._build();

  _$GPostChangedData_postChanged_author._(
      {required this.G__typename, required this.id, required this.displayName})
      : super._();
  @override
  GPostChangedData_postChanged_author rebuild(
          void Function(GPostChangedData_postChanged_authorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostChangedData_postChanged_authorBuilder toBuilder() =>
      GPostChangedData_postChanged_authorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostChangedData_postChanged_author &&
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
    return (newBuiltValueToStringHelper(r'GPostChangedData_postChanged_author')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName))
        .toString();
  }
}

class GPostChangedData_postChanged_authorBuilder
    implements
        Builder<GPostChangedData_postChanged_author,
            GPostChangedData_postChanged_authorBuilder> {
  _$GPostChangedData_postChanged_author? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GPostChangedData_postChanged_authorBuilder() {
    GPostChangedData_postChanged_author._initializeBuilder(this);
  }

  GPostChangedData_postChanged_authorBuilder get _$this {
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
  void replace(GPostChangedData_postChanged_author other) {
    _$v = other as _$GPostChangedData_postChanged_author;
  }

  @override
  void update(
      void Function(GPostChangedData_postChanged_authorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostChangedData_postChanged_author build() => _build();

  _$GPostChangedData_postChanged_author _build() {
    final _$result = _$v ??
        _$GPostChangedData_postChanged_author._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GPostChangedData_postChanged_author', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GPostChangedData_postChanged_author', 'id'),
          displayName: BuiltValueNullFieldError.checkNotNull(displayName,
              r'GPostChangedData_postChanged_author', 'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GPostChangedData_postChanged_reactions
    extends GPostChangedData_postChanged_reactions {
  @override
  final String G__typename;
  @override
  final String emoji;
  @override
  final int count;
  @override
  final bool byViewer;

  factory _$GPostChangedData_postChanged_reactions(
          [void Function(GPostChangedData_postChanged_reactionsBuilder)?
              updates]) =>
      (GPostChangedData_postChanged_reactionsBuilder()..update(updates))
          ._build();

  _$GPostChangedData_postChanged_reactions._(
      {required this.G__typename,
      required this.emoji,
      required this.count,
      required this.byViewer})
      : super._();
  @override
  GPostChangedData_postChanged_reactions rebuild(
          void Function(GPostChangedData_postChanged_reactionsBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostChangedData_postChanged_reactionsBuilder toBuilder() =>
      GPostChangedData_postChanged_reactionsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostChangedData_postChanged_reactions &&
        G__typename == other.G__typename &&
        emoji == other.emoji &&
        count == other.count &&
        byViewer == other.byViewer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, emoji.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, byViewer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GPostChangedData_postChanged_reactions')
          ..add('G__typename', G__typename)
          ..add('emoji', emoji)
          ..add('count', count)
          ..add('byViewer', byViewer))
        .toString();
  }
}

class GPostChangedData_postChanged_reactionsBuilder
    implements
        Builder<GPostChangedData_postChanged_reactions,
            GPostChangedData_postChanged_reactionsBuilder> {
  _$GPostChangedData_postChanged_reactions? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _emoji;
  String? get emoji => _$this._emoji;
  set emoji(String? emoji) => _$this._emoji = emoji;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  bool? _byViewer;
  bool? get byViewer => _$this._byViewer;
  set byViewer(bool? byViewer) => _$this._byViewer = byViewer;

  GPostChangedData_postChanged_reactionsBuilder() {
    GPostChangedData_postChanged_reactions._initializeBuilder(this);
  }

  GPostChangedData_postChanged_reactionsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _emoji = $v.emoji;
      _count = $v.count;
      _byViewer = $v.byViewer;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostChangedData_postChanged_reactions other) {
    _$v = other as _$GPostChangedData_postChanged_reactions;
  }

  @override
  void update(
      void Function(GPostChangedData_postChanged_reactionsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostChangedData_postChanged_reactions build() => _build();

  _$GPostChangedData_postChanged_reactions _build() {
    final _$result = _$v ??
        _$GPostChangedData_postChanged_reactions._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GPostChangedData_postChanged_reactions', 'G__typename'),
          emoji: BuiltValueNullFieldError.checkNotNull(
              emoji, r'GPostChangedData_postChanged_reactions', 'emoji'),
          count: BuiltValueNullFieldError.checkNotNull(
              count, r'GPostChangedData_postChanged_reactions', 'count'),
          byViewer: BuiltValueNullFieldError.checkNotNull(
              byViewer, r'GPostChangedData_postChanged_reactions', 'byViewer'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GPostSummaryData extends GPostSummaryData {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String title;
  @override
  final String body;
  @override
  final _i2.GTime createdAt;
  @override
  final _i2.GTime? editedAt;
  @override
  final _i2.GDecisionStatus? decisionStatus;
  @override
  final bool denyFlag;
  @override
  final GPostSummaryData_author author;
  @override
  final BuiltList<GPostSummaryData_reactions> reactions;

  factory _$GPostSummaryData(
          [void Function(GPostSummaryDataBuilder)? updates]) =>
      (GPostSummaryDataBuilder()..update(updates))._build();

  _$GPostSummaryData._(
      {required this.G__typename,
      required this.id,
      required this.title,
      required this.body,
      required this.createdAt,
      this.editedAt,
      this.decisionStatus,
      required this.denyFlag,
      required this.author,
      required this.reactions})
      : super._();
  @override
  GPostSummaryData rebuild(void Function(GPostSummaryDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostSummaryDataBuilder toBuilder() =>
      GPostSummaryDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostSummaryData &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        body == other.body &&
        createdAt == other.createdAt &&
        editedAt == other.editedAt &&
        decisionStatus == other.decisionStatus &&
        denyFlag == other.denyFlag &&
        author == other.author &&
        reactions == other.reactions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, editedAt.hashCode);
    _$hash = $jc(_$hash, decisionStatus.hashCode);
    _$hash = $jc(_$hash, denyFlag.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, reactions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostSummaryData')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('body', body)
          ..add('createdAt', createdAt)
          ..add('editedAt', editedAt)
          ..add('decisionStatus', decisionStatus)
          ..add('denyFlag', denyFlag)
          ..add('author', author)
          ..add('reactions', reactions))
        .toString();
  }
}

class GPostSummaryDataBuilder
    implements Builder<GPostSummaryData, GPostSummaryDataBuilder> {
  _$GPostSummaryData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  _i2.GTimeBuilder? _createdAt;
  _i2.GTimeBuilder get createdAt => _$this._createdAt ??= _i2.GTimeBuilder();
  set createdAt(_i2.GTimeBuilder? createdAt) => _$this._createdAt = createdAt;

  _i2.GTimeBuilder? _editedAt;
  _i2.GTimeBuilder get editedAt => _$this._editedAt ??= _i2.GTimeBuilder();
  set editedAt(_i2.GTimeBuilder? editedAt) => _$this._editedAt = editedAt;

  _i2.GDecisionStatus? _decisionStatus;
  _i2.GDecisionStatus? get decisionStatus => _$this._decisionStatus;
  set decisionStatus(_i2.GDecisionStatus? decisionStatus) =>
      _$this._decisionStatus = decisionStatus;

  bool? _denyFlag;
  bool? get denyFlag => _$this._denyFlag;
  set denyFlag(bool? denyFlag) => _$this._denyFlag = denyFlag;

  GPostSummaryData_authorBuilder? _author;
  GPostSummaryData_authorBuilder get author =>
      _$this._author ??= GPostSummaryData_authorBuilder();
  set author(GPostSummaryData_authorBuilder? author) => _$this._author = author;

  ListBuilder<GPostSummaryData_reactions>? _reactions;
  ListBuilder<GPostSummaryData_reactions> get reactions =>
      _$this._reactions ??= ListBuilder<GPostSummaryData_reactions>();
  set reactions(ListBuilder<GPostSummaryData_reactions>? reactions) =>
      _$this._reactions = reactions;

  GPostSummaryDataBuilder() {
    GPostSummaryData._initializeBuilder(this);
  }

  GPostSummaryDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _body = $v.body;
      _createdAt = $v.createdAt.toBuilder();
      _editedAt = $v.editedAt?.toBuilder();
      _decisionStatus = $v.decisionStatus;
      _denyFlag = $v.denyFlag;
      _author = $v.author.toBuilder();
      _reactions = $v.reactions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostSummaryData other) {
    _$v = other as _$GPostSummaryData;
  }

  @override
  void update(void Function(GPostSummaryDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostSummaryData build() => _build();

  _$GPostSummaryData _build() {
    _$GPostSummaryData _$result;
    try {
      _$result = _$v ??
          _$GPostSummaryData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GPostSummaryData', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GPostSummaryData', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GPostSummaryData', 'title'),
            body: BuiltValueNullFieldError.checkNotNull(
                body, r'GPostSummaryData', 'body'),
            createdAt: createdAt.build(),
            editedAt: _editedAt?.build(),
            decisionStatus: decisionStatus,
            denyFlag: BuiltValueNullFieldError.checkNotNull(
                denyFlag, r'GPostSummaryData', 'denyFlag'),
            author: author.build(),
            reactions: reactions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'editedAt';
        _editedAt?.build();

        _$failedField = 'author';
        author.build();
        _$failedField = 'reactions';
        reactions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GPostSummaryData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GPostSummaryData_author extends GPostSummaryData_author {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;

  factory _$GPostSummaryData_author(
          [void Function(GPostSummaryData_authorBuilder)? updates]) =>
      (GPostSummaryData_authorBuilder()..update(updates))._build();

  _$GPostSummaryData_author._(
      {required this.G__typename, required this.id, required this.displayName})
      : super._();
  @override
  GPostSummaryData_author rebuild(
          void Function(GPostSummaryData_authorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostSummaryData_authorBuilder toBuilder() =>
      GPostSummaryData_authorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostSummaryData_author &&
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
    return (newBuiltValueToStringHelper(r'GPostSummaryData_author')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName))
        .toString();
  }
}

class GPostSummaryData_authorBuilder
    implements
        Builder<GPostSummaryData_author, GPostSummaryData_authorBuilder> {
  _$GPostSummaryData_author? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GPostSummaryData_authorBuilder() {
    GPostSummaryData_author._initializeBuilder(this);
  }

  GPostSummaryData_authorBuilder get _$this {
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
  void replace(GPostSummaryData_author other) {
    _$v = other as _$GPostSummaryData_author;
  }

  @override
  void update(void Function(GPostSummaryData_authorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostSummaryData_author build() => _build();

  _$GPostSummaryData_author _build() {
    final _$result = _$v ??
        _$GPostSummaryData_author._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GPostSummaryData_author', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GPostSummaryData_author', 'id'),
          displayName: BuiltValueNullFieldError.checkNotNull(
              displayName, r'GPostSummaryData_author', 'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GPostSummaryData_reactions extends GPostSummaryData_reactions {
  @override
  final String G__typename;
  @override
  final String emoji;
  @override
  final int count;
  @override
  final bool byViewer;

  factory _$GPostSummaryData_reactions(
          [void Function(GPostSummaryData_reactionsBuilder)? updates]) =>
      (GPostSummaryData_reactionsBuilder()..update(updates))._build();

  _$GPostSummaryData_reactions._(
      {required this.G__typename,
      required this.emoji,
      required this.count,
      required this.byViewer})
      : super._();
  @override
  GPostSummaryData_reactions rebuild(
          void Function(GPostSummaryData_reactionsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostSummaryData_reactionsBuilder toBuilder() =>
      GPostSummaryData_reactionsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostSummaryData_reactions &&
        G__typename == other.G__typename &&
        emoji == other.emoji &&
        count == other.count &&
        byViewer == other.byViewer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, emoji.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, byViewer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostSummaryData_reactions')
          ..add('G__typename', G__typename)
          ..add('emoji', emoji)
          ..add('count', count)
          ..add('byViewer', byViewer))
        .toString();
  }
}

class GPostSummaryData_reactionsBuilder
    implements
        Builder<GPostSummaryData_reactions, GPostSummaryData_reactionsBuilder> {
  _$GPostSummaryData_reactions? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _emoji;
  String? get emoji => _$this._emoji;
  set emoji(String? emoji) => _$this._emoji = emoji;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  bool? _byViewer;
  bool? get byViewer => _$this._byViewer;
  set byViewer(bool? byViewer) => _$this._byViewer = byViewer;

  GPostSummaryData_reactionsBuilder() {
    GPostSummaryData_reactions._initializeBuilder(this);
  }

  GPostSummaryData_reactionsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _emoji = $v.emoji;
      _count = $v.count;
      _byViewer = $v.byViewer;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostSummaryData_reactions other) {
    _$v = other as _$GPostSummaryData_reactions;
  }

  @override
  void update(void Function(GPostSummaryData_reactionsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostSummaryData_reactions build() => _build();

  _$GPostSummaryData_reactions _build() {
    final _$result = _$v ??
        _$GPostSummaryData_reactions._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GPostSummaryData_reactions', 'G__typename'),
          emoji: BuiltValueNullFieldError.checkNotNull(
              emoji, r'GPostSummaryData_reactions', 'emoji'),
          count: BuiltValueNullFieldError.checkNotNull(
              count, r'GPostSummaryData_reactions', 'count'),
          byViewer: BuiltValueNullFieldError.checkNotNull(
              byViewer, r'GPostSummaryData_reactions', 'byViewer'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCommentSummaryData extends GCommentSummaryData {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String postId;
  @override
  final String? parentId;
  @override
  final int depth;
  @override
  final String body;
  @override
  final _i2.GTime createdAt;
  @override
  final _i2.GTime? editedAt;
  @override
  final GCommentSummaryData_author author;
  @override
  final BuiltList<GCommentSummaryData_reactions> reactions;

  factory _$GCommentSummaryData(
          [void Function(GCommentSummaryDataBuilder)? updates]) =>
      (GCommentSummaryDataBuilder()..update(updates))._build();

  _$GCommentSummaryData._(
      {required this.G__typename,
      required this.id,
      required this.postId,
      this.parentId,
      required this.depth,
      required this.body,
      required this.createdAt,
      this.editedAt,
      required this.author,
      required this.reactions})
      : super._();
  @override
  GCommentSummaryData rebuild(
          void Function(GCommentSummaryDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCommentSummaryDataBuilder toBuilder() =>
      GCommentSummaryDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCommentSummaryData &&
        G__typename == other.G__typename &&
        id == other.id &&
        postId == other.postId &&
        parentId == other.parentId &&
        depth == other.depth &&
        body == other.body &&
        createdAt == other.createdAt &&
        editedAt == other.editedAt &&
        author == other.author &&
        reactions == other.reactions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, postId.hashCode);
    _$hash = $jc(_$hash, parentId.hashCode);
    _$hash = $jc(_$hash, depth.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, editedAt.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, reactions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCommentSummaryData')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('postId', postId)
          ..add('parentId', parentId)
          ..add('depth', depth)
          ..add('body', body)
          ..add('createdAt', createdAt)
          ..add('editedAt', editedAt)
          ..add('author', author)
          ..add('reactions', reactions))
        .toString();
  }
}

class GCommentSummaryDataBuilder
    implements Builder<GCommentSummaryData, GCommentSummaryDataBuilder> {
  _$GCommentSummaryData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _postId;
  String? get postId => _$this._postId;
  set postId(String? postId) => _$this._postId = postId;

  String? _parentId;
  String? get parentId => _$this._parentId;
  set parentId(String? parentId) => _$this._parentId = parentId;

  int? _depth;
  int? get depth => _$this._depth;
  set depth(int? depth) => _$this._depth = depth;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  _i2.GTimeBuilder? _createdAt;
  _i2.GTimeBuilder get createdAt => _$this._createdAt ??= _i2.GTimeBuilder();
  set createdAt(_i2.GTimeBuilder? createdAt) => _$this._createdAt = createdAt;

  _i2.GTimeBuilder? _editedAt;
  _i2.GTimeBuilder get editedAt => _$this._editedAt ??= _i2.GTimeBuilder();
  set editedAt(_i2.GTimeBuilder? editedAt) => _$this._editedAt = editedAt;

  GCommentSummaryData_authorBuilder? _author;
  GCommentSummaryData_authorBuilder get author =>
      _$this._author ??= GCommentSummaryData_authorBuilder();
  set author(GCommentSummaryData_authorBuilder? author) =>
      _$this._author = author;

  ListBuilder<GCommentSummaryData_reactions>? _reactions;
  ListBuilder<GCommentSummaryData_reactions> get reactions =>
      _$this._reactions ??= ListBuilder<GCommentSummaryData_reactions>();
  set reactions(ListBuilder<GCommentSummaryData_reactions>? reactions) =>
      _$this._reactions = reactions;

  GCommentSummaryDataBuilder() {
    GCommentSummaryData._initializeBuilder(this);
  }

  GCommentSummaryDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _postId = $v.postId;
      _parentId = $v.parentId;
      _depth = $v.depth;
      _body = $v.body;
      _createdAt = $v.createdAt.toBuilder();
      _editedAt = $v.editedAt?.toBuilder();
      _author = $v.author.toBuilder();
      _reactions = $v.reactions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCommentSummaryData other) {
    _$v = other as _$GCommentSummaryData;
  }

  @override
  void update(void Function(GCommentSummaryDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCommentSummaryData build() => _build();

  _$GCommentSummaryData _build() {
    _$GCommentSummaryData _$result;
    try {
      _$result = _$v ??
          _$GCommentSummaryData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GCommentSummaryData', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GCommentSummaryData', 'id'),
            postId: BuiltValueNullFieldError.checkNotNull(
                postId, r'GCommentSummaryData', 'postId'),
            parentId: parentId,
            depth: BuiltValueNullFieldError.checkNotNull(
                depth, r'GCommentSummaryData', 'depth'),
            body: BuiltValueNullFieldError.checkNotNull(
                body, r'GCommentSummaryData', 'body'),
            createdAt: createdAt.build(),
            editedAt: _editedAt?.build(),
            author: author.build(),
            reactions: reactions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'editedAt';
        _editedAt?.build();
        _$failedField = 'author';
        author.build();
        _$failedField = 'reactions';
        reactions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GCommentSummaryData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCommentSummaryData_author extends GCommentSummaryData_author {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;

  factory _$GCommentSummaryData_author(
          [void Function(GCommentSummaryData_authorBuilder)? updates]) =>
      (GCommentSummaryData_authorBuilder()..update(updates))._build();

  _$GCommentSummaryData_author._(
      {required this.G__typename, required this.id, required this.displayName})
      : super._();
  @override
  GCommentSummaryData_author rebuild(
          void Function(GCommentSummaryData_authorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCommentSummaryData_authorBuilder toBuilder() =>
      GCommentSummaryData_authorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCommentSummaryData_author &&
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
    return (newBuiltValueToStringHelper(r'GCommentSummaryData_author')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName))
        .toString();
  }
}

class GCommentSummaryData_authorBuilder
    implements
        Builder<GCommentSummaryData_author, GCommentSummaryData_authorBuilder> {
  _$GCommentSummaryData_author? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GCommentSummaryData_authorBuilder() {
    GCommentSummaryData_author._initializeBuilder(this);
  }

  GCommentSummaryData_authorBuilder get _$this {
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
  void replace(GCommentSummaryData_author other) {
    _$v = other as _$GCommentSummaryData_author;
  }

  @override
  void update(void Function(GCommentSummaryData_authorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCommentSummaryData_author build() => _build();

  _$GCommentSummaryData_author _build() {
    final _$result = _$v ??
        _$GCommentSummaryData_author._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GCommentSummaryData_author', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GCommentSummaryData_author', 'id'),
          displayName: BuiltValueNullFieldError.checkNotNull(
              displayName, r'GCommentSummaryData_author', 'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCommentSummaryData_reactions extends GCommentSummaryData_reactions {
  @override
  final String G__typename;
  @override
  final String emoji;
  @override
  final int count;
  @override
  final bool byViewer;

  factory _$GCommentSummaryData_reactions(
          [void Function(GCommentSummaryData_reactionsBuilder)? updates]) =>
      (GCommentSummaryData_reactionsBuilder()..update(updates))._build();

  _$GCommentSummaryData_reactions._(
      {required this.G__typename,
      required this.emoji,
      required this.count,
      required this.byViewer})
      : super._();
  @override
  GCommentSummaryData_reactions rebuild(
          void Function(GCommentSummaryData_reactionsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCommentSummaryData_reactionsBuilder toBuilder() =>
      GCommentSummaryData_reactionsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCommentSummaryData_reactions &&
        G__typename == other.G__typename &&
        emoji == other.emoji &&
        count == other.count &&
        byViewer == other.byViewer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, emoji.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, byViewer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCommentSummaryData_reactions')
          ..add('G__typename', G__typename)
          ..add('emoji', emoji)
          ..add('count', count)
          ..add('byViewer', byViewer))
        .toString();
  }
}

class GCommentSummaryData_reactionsBuilder
    implements
        Builder<GCommentSummaryData_reactions,
            GCommentSummaryData_reactionsBuilder> {
  _$GCommentSummaryData_reactions? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _emoji;
  String? get emoji => _$this._emoji;
  set emoji(String? emoji) => _$this._emoji = emoji;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  bool? _byViewer;
  bool? get byViewer => _$this._byViewer;
  set byViewer(bool? byViewer) => _$this._byViewer = byViewer;

  GCommentSummaryData_reactionsBuilder() {
    GCommentSummaryData_reactions._initializeBuilder(this);
  }

  GCommentSummaryData_reactionsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _emoji = $v.emoji;
      _count = $v.count;
      _byViewer = $v.byViewer;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCommentSummaryData_reactions other) {
    _$v = other as _$GCommentSummaryData_reactions;
  }

  @override
  void update(void Function(GCommentSummaryData_reactionsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCommentSummaryData_reactions build() => _build();

  _$GCommentSummaryData_reactions _build() {
    final _$result = _$v ??
        _$GCommentSummaryData_reactions._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GCommentSummaryData_reactions', 'G__typename'),
          emoji: BuiltValueNullFieldError.checkNotNull(
              emoji, r'GCommentSummaryData_reactions', 'emoji'),
          count: BuiltValueNullFieldError.checkNotNull(
              count, r'GCommentSummaryData_reactions', 'count'),
          byViewer: BuiltValueNullFieldError.checkNotNull(
              byViewer, r'GCommentSummaryData_reactions', 'byViewer'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
