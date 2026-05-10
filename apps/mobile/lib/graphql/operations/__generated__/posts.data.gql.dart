// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pulse/graphql/__generated__/schema.schema.gql.dart' as _i2;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i1;

part 'posts.data.gql.g.dart';

abstract class GPostsForTagData
    implements Built<GPostsForTagData, GPostsForTagDataBuilder> {
  GPostsForTagData._();

  factory GPostsForTagData([void Function(GPostsForTagDataBuilder b) updates]) =
      _$GPostsForTagData;

  static void _initializeBuilder(GPostsForTagDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GPostsForTagData_tag? get tag;
  static Serializer<GPostsForTagData> get serializer =>
      _$gPostsForTagDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostsForTagData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostsForTagData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostsForTagData.serializer,
        json,
      );
}

abstract class GPostsForTagData_tag
    implements Built<GPostsForTagData_tag, GPostsForTagData_tagBuilder> {
  GPostsForTagData_tag._();

  factory GPostsForTagData_tag(
          [void Function(GPostsForTagData_tagBuilder b) updates]) =
      _$GPostsForTagData_tag;

  static void _initializeBuilder(GPostsForTagData_tagBuilder b) =>
      b..G__typename = 'Tag';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  GPostsForTagData_tag_posts get posts;
  static Serializer<GPostsForTagData_tag> get serializer =>
      _$gPostsForTagDataTagSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostsForTagData_tag.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostsForTagData_tag? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostsForTagData_tag.serializer,
        json,
      );
}

abstract class GPostsForTagData_tag_posts
    implements
        Built<GPostsForTagData_tag_posts, GPostsForTagData_tag_postsBuilder> {
  GPostsForTagData_tag_posts._();

  factory GPostsForTagData_tag_posts(
          [void Function(GPostsForTagData_tag_postsBuilder b) updates]) =
      _$GPostsForTagData_tag_posts;

  static void _initializeBuilder(GPostsForTagData_tag_postsBuilder b) =>
      b..G__typename = 'PostConnection';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GPostsForTagData_tag_posts_edges> get edges;
  static Serializer<GPostsForTagData_tag_posts> get serializer =>
      _$gPostsForTagDataTagPostsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostsForTagData_tag_posts.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostsForTagData_tag_posts? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostsForTagData_tag_posts.serializer,
        json,
      );
}

abstract class GPostsForTagData_tag_posts_edges
    implements
        Built<GPostsForTagData_tag_posts_edges,
            GPostsForTagData_tag_posts_edgesBuilder> {
  GPostsForTagData_tag_posts_edges._();

  factory GPostsForTagData_tag_posts_edges(
          [void Function(GPostsForTagData_tag_posts_edgesBuilder b) updates]) =
      _$GPostsForTagData_tag_posts_edges;

  static void _initializeBuilder(GPostsForTagData_tag_posts_edgesBuilder b) =>
      b..G__typename = 'PostEdge';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get cursor;
  GPostsForTagData_tag_posts_edges_node get node;
  static Serializer<GPostsForTagData_tag_posts_edges> get serializer =>
      _$gPostsForTagDataTagPostsEdgesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostsForTagData_tag_posts_edges.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostsForTagData_tag_posts_edges? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostsForTagData_tag_posts_edges.serializer,
        json,
      );
}

abstract class GPostsForTagData_tag_posts_edges_node
    implements
        Built<GPostsForTagData_tag_posts_edges_node,
            GPostsForTagData_tag_posts_edges_nodeBuilder>,
        GPostSummary {
  GPostsForTagData_tag_posts_edges_node._();

  factory GPostsForTagData_tag_posts_edges_node(
      [void Function(GPostsForTagData_tag_posts_edges_nodeBuilder b)
          updates]) = _$GPostsForTagData_tag_posts_edges_node;

  static void _initializeBuilder(
          GPostsForTagData_tag_posts_edges_nodeBuilder b) =>
      b..G__typename = 'Post';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get title;
  @override
  String get body;
  @override
  _i2.GTime get createdAt;
  @override
  _i2.GTime? get editedAt;
  @override
  _i2.GDecisionStatus? get decisionStatus;
  @override
  bool get denyFlag;
  @override
  GPostsForTagData_tag_posts_edges_node_author get author;
  @override
  BuiltList<GPostsForTagData_tag_posts_edges_node_reactions> get reactions;
  static Serializer<GPostsForTagData_tag_posts_edges_node> get serializer =>
      _$gPostsForTagDataTagPostsEdgesNodeSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostsForTagData_tag_posts_edges_node.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostsForTagData_tag_posts_edges_node? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostsForTagData_tag_posts_edges_node.serializer,
        json,
      );
}

abstract class GPostsForTagData_tag_posts_edges_node_author
    implements
        Built<GPostsForTagData_tag_posts_edges_node_author,
            GPostsForTagData_tag_posts_edges_node_authorBuilder>,
        GPostSummary_author {
  GPostsForTagData_tag_posts_edges_node_author._();

  factory GPostsForTagData_tag_posts_edges_node_author(
      [void Function(GPostsForTagData_tag_posts_edges_node_authorBuilder b)
          updates]) = _$GPostsForTagData_tag_posts_edges_node_author;

  static void _initializeBuilder(
          GPostsForTagData_tag_posts_edges_node_authorBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  static Serializer<GPostsForTagData_tag_posts_edges_node_author>
      get serializer => _$gPostsForTagDataTagPostsEdgesNodeAuthorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostsForTagData_tag_posts_edges_node_author.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostsForTagData_tag_posts_edges_node_author? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostsForTagData_tag_posts_edges_node_author.serializer,
        json,
      );
}

abstract class GPostsForTagData_tag_posts_edges_node_reactions
    implements
        Built<GPostsForTagData_tag_posts_edges_node_reactions,
            GPostsForTagData_tag_posts_edges_node_reactionsBuilder>,
        GPostSummary_reactions {
  GPostsForTagData_tag_posts_edges_node_reactions._();

  factory GPostsForTagData_tag_posts_edges_node_reactions(
      [void Function(GPostsForTagData_tag_posts_edges_node_reactionsBuilder b)
          updates]) = _$GPostsForTagData_tag_posts_edges_node_reactions;

  static void _initializeBuilder(
          GPostsForTagData_tag_posts_edges_node_reactionsBuilder b) =>
      b..G__typename = 'ReactionSummary';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get emoji;
  @override
  int get count;
  @override
  bool get byViewer;
  static Serializer<GPostsForTagData_tag_posts_edges_node_reactions>
      get serializer => _$gPostsForTagDataTagPostsEdgesNodeReactionsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostsForTagData_tag_posts_edges_node_reactions.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostsForTagData_tag_posts_edges_node_reactions? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostsForTagData_tag_posts_edges_node_reactions.serializer,
        json,
      );
}

abstract class GPostDetailData
    implements Built<GPostDetailData, GPostDetailDataBuilder> {
  GPostDetailData._();

  factory GPostDetailData([void Function(GPostDetailDataBuilder b) updates]) =
      _$GPostDetailData;

  static void _initializeBuilder(GPostDetailDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GPostDetailData_post? get post;
  static Serializer<GPostDetailData> get serializer =>
      _$gPostDetailDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostDetailData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostDetailData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostDetailData.serializer,
        json,
      );
}

abstract class GPostDetailData_post
    implements
        Built<GPostDetailData_post, GPostDetailData_postBuilder>,
        GPostSummary {
  GPostDetailData_post._();

  factory GPostDetailData_post(
          [void Function(GPostDetailData_postBuilder b) updates]) =
      _$GPostDetailData_post;

  static void _initializeBuilder(GPostDetailData_postBuilder b) =>
      b..G__typename = 'Post';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get title;
  @override
  String get body;
  @override
  _i2.GTime get createdAt;
  @override
  _i2.GTime? get editedAt;
  @override
  _i2.GDecisionStatus? get decisionStatus;
  @override
  bool get denyFlag;
  @override
  GPostDetailData_post_author get author;
  @override
  BuiltList<GPostDetailData_post_reactions> get reactions;
  BuiltList<GPostDetailData_post_tags> get tags;
  GPostDetailData_post_comments get comments;
  GPostDetailData_post_myPermissions get myPermissions;
  static Serializer<GPostDetailData_post> get serializer =>
      _$gPostDetailDataPostSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostDetailData_post.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostDetailData_post? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostDetailData_post.serializer,
        json,
      );
}

abstract class GPostDetailData_post_author
    implements
        Built<GPostDetailData_post_author, GPostDetailData_post_authorBuilder>,
        GPostSummary_author {
  GPostDetailData_post_author._();

  factory GPostDetailData_post_author(
          [void Function(GPostDetailData_post_authorBuilder b) updates]) =
      _$GPostDetailData_post_author;

  static void _initializeBuilder(GPostDetailData_post_authorBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  static Serializer<GPostDetailData_post_author> get serializer =>
      _$gPostDetailDataPostAuthorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostDetailData_post_author.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostDetailData_post_author? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostDetailData_post_author.serializer,
        json,
      );
}

abstract class GPostDetailData_post_reactions
    implements
        Built<GPostDetailData_post_reactions,
            GPostDetailData_post_reactionsBuilder>,
        GPostSummary_reactions {
  GPostDetailData_post_reactions._();

  factory GPostDetailData_post_reactions(
          [void Function(GPostDetailData_post_reactionsBuilder b) updates]) =
      _$GPostDetailData_post_reactions;

  static void _initializeBuilder(GPostDetailData_post_reactionsBuilder b) =>
      b..G__typename = 'ReactionSummary';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get emoji;
  @override
  int get count;
  @override
  bool get byViewer;
  static Serializer<GPostDetailData_post_reactions> get serializer =>
      _$gPostDetailDataPostReactionsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostDetailData_post_reactions.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostDetailData_post_reactions? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostDetailData_post_reactions.serializer,
        json,
      );
}

abstract class GPostDetailData_post_tags
    implements
        Built<GPostDetailData_post_tags, GPostDetailData_post_tagsBuilder> {
  GPostDetailData_post_tags._();

  factory GPostDetailData_post_tags(
          [void Function(GPostDetailData_post_tagsBuilder b) updates]) =
      _$GPostDetailData_post_tags;

  static void _initializeBuilder(GPostDetailData_post_tagsBuilder b) =>
      b..G__typename = 'PostTag';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GPostDetailData_post_tags_tag get tag;
  static Serializer<GPostDetailData_post_tags> get serializer =>
      _$gPostDetailDataPostTagsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostDetailData_post_tags.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostDetailData_post_tags? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostDetailData_post_tags.serializer,
        json,
      );
}

abstract class GPostDetailData_post_tags_tag
    implements
        Built<GPostDetailData_post_tags_tag,
            GPostDetailData_post_tags_tagBuilder> {
  GPostDetailData_post_tags_tag._();

  factory GPostDetailData_post_tags_tag(
          [void Function(GPostDetailData_post_tags_tagBuilder b) updates]) =
      _$GPostDetailData_post_tags_tag;

  static void _initializeBuilder(GPostDetailData_post_tags_tagBuilder b) =>
      b..G__typename = 'Tag';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get slug;
  String get displayName;
  static Serializer<GPostDetailData_post_tags_tag> get serializer =>
      _$gPostDetailDataPostTagsTagSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostDetailData_post_tags_tag.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostDetailData_post_tags_tag? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostDetailData_post_tags_tag.serializer,
        json,
      );
}

abstract class GPostDetailData_post_comments
    implements
        Built<GPostDetailData_post_comments,
            GPostDetailData_post_commentsBuilder> {
  GPostDetailData_post_comments._();

  factory GPostDetailData_post_comments(
          [void Function(GPostDetailData_post_commentsBuilder b) updates]) =
      _$GPostDetailData_post_comments;

  static void _initializeBuilder(GPostDetailData_post_commentsBuilder b) =>
      b..G__typename = 'CommentConnection';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GPostDetailData_post_comments_edges> get edges;
  static Serializer<GPostDetailData_post_comments> get serializer =>
      _$gPostDetailDataPostCommentsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostDetailData_post_comments.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostDetailData_post_comments? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostDetailData_post_comments.serializer,
        json,
      );
}

abstract class GPostDetailData_post_comments_edges
    implements
        Built<GPostDetailData_post_comments_edges,
            GPostDetailData_post_comments_edgesBuilder> {
  GPostDetailData_post_comments_edges._();

  factory GPostDetailData_post_comments_edges(
      [void Function(GPostDetailData_post_comments_edgesBuilder b)
          updates]) = _$GPostDetailData_post_comments_edges;

  static void _initializeBuilder(
          GPostDetailData_post_comments_edgesBuilder b) =>
      b..G__typename = 'CommentEdge';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GPostDetailData_post_comments_edges_node get node;
  static Serializer<GPostDetailData_post_comments_edges> get serializer =>
      _$gPostDetailDataPostCommentsEdgesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostDetailData_post_comments_edges.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostDetailData_post_comments_edges? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostDetailData_post_comments_edges.serializer,
        json,
      );
}

abstract class GPostDetailData_post_comments_edges_node
    implements
        Built<GPostDetailData_post_comments_edges_node,
            GPostDetailData_post_comments_edges_nodeBuilder>,
        GCommentSummary {
  GPostDetailData_post_comments_edges_node._();

  factory GPostDetailData_post_comments_edges_node(
      [void Function(GPostDetailData_post_comments_edges_nodeBuilder b)
          updates]) = _$GPostDetailData_post_comments_edges_node;

  static void _initializeBuilder(
          GPostDetailData_post_comments_edges_nodeBuilder b) =>
      b..G__typename = 'Comment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get postId;
  @override
  String? get parentId;
  @override
  int get depth;
  @override
  String get body;
  @override
  _i2.GTime get createdAt;
  @override
  _i2.GTime? get editedAt;
  @override
  GPostDetailData_post_comments_edges_node_author get author;
  @override
  BuiltList<GPostDetailData_post_comments_edges_node_reactions> get reactions;
  static Serializer<GPostDetailData_post_comments_edges_node> get serializer =>
      _$gPostDetailDataPostCommentsEdgesNodeSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostDetailData_post_comments_edges_node.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostDetailData_post_comments_edges_node? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostDetailData_post_comments_edges_node.serializer,
        json,
      );
}

abstract class GPostDetailData_post_comments_edges_node_author
    implements
        Built<GPostDetailData_post_comments_edges_node_author,
            GPostDetailData_post_comments_edges_node_authorBuilder>,
        GCommentSummary_author {
  GPostDetailData_post_comments_edges_node_author._();

  factory GPostDetailData_post_comments_edges_node_author(
      [void Function(GPostDetailData_post_comments_edges_node_authorBuilder b)
          updates]) = _$GPostDetailData_post_comments_edges_node_author;

  static void _initializeBuilder(
          GPostDetailData_post_comments_edges_node_authorBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  static Serializer<GPostDetailData_post_comments_edges_node_author>
      get serializer => _$gPostDetailDataPostCommentsEdgesNodeAuthorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostDetailData_post_comments_edges_node_author.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostDetailData_post_comments_edges_node_author? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostDetailData_post_comments_edges_node_author.serializer,
        json,
      );
}

abstract class GPostDetailData_post_comments_edges_node_reactions
    implements
        Built<GPostDetailData_post_comments_edges_node_reactions,
            GPostDetailData_post_comments_edges_node_reactionsBuilder>,
        GCommentSummary_reactions {
  GPostDetailData_post_comments_edges_node_reactions._();

  factory GPostDetailData_post_comments_edges_node_reactions(
      [void Function(
              GPostDetailData_post_comments_edges_node_reactionsBuilder b)
          updates]) = _$GPostDetailData_post_comments_edges_node_reactions;

  static void _initializeBuilder(
          GPostDetailData_post_comments_edges_node_reactionsBuilder b) =>
      b..G__typename = 'ReactionSummary';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get emoji;
  @override
  int get count;
  @override
  bool get byViewer;
  static Serializer<GPostDetailData_post_comments_edges_node_reactions>
      get serializer =>
          _$gPostDetailDataPostCommentsEdgesNodeReactionsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostDetailData_post_comments_edges_node_reactions.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostDetailData_post_comments_edges_node_reactions? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostDetailData_post_comments_edges_node_reactions.serializer,
        json,
      );
}

abstract class GPostDetailData_post_myPermissions
    implements
        Built<GPostDetailData_post_myPermissions,
            GPostDetailData_post_myPermissionsBuilder> {
  GPostDetailData_post_myPermissions._();

  factory GPostDetailData_post_myPermissions(
      [void Function(GPostDetailData_post_myPermissionsBuilder b)
          updates]) = _$GPostDetailData_post_myPermissions;

  static void _initializeBuilder(GPostDetailData_post_myPermissionsBuilder b) =>
      b..G__typename = 'PostPermissions';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get canView;
  bool get canContribute;
  bool get canModerate;
  static Serializer<GPostDetailData_post_myPermissions> get serializer =>
      _$gPostDetailDataPostMyPermissionsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostDetailData_post_myPermissions.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostDetailData_post_myPermissions? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostDetailData_post_myPermissions.serializer,
        json,
      );
}

abstract class GCreatePostData
    implements Built<GCreatePostData, GCreatePostDataBuilder> {
  GCreatePostData._();

  factory GCreatePostData([void Function(GCreatePostDataBuilder b) updates]) =
      _$GCreatePostData;

  static void _initializeBuilder(GCreatePostDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GCreatePostData_createPost get createPost;
  static Serializer<GCreatePostData> get serializer =>
      _$gCreatePostDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreatePostData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreatePostData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreatePostData.serializer,
        json,
      );
}

abstract class GCreatePostData_createPost
    implements
        Built<GCreatePostData_createPost, GCreatePostData_createPostBuilder>,
        GPostSummary {
  GCreatePostData_createPost._();

  factory GCreatePostData_createPost(
          [void Function(GCreatePostData_createPostBuilder b) updates]) =
      _$GCreatePostData_createPost;

  static void _initializeBuilder(GCreatePostData_createPostBuilder b) =>
      b..G__typename = 'Post';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get title;
  @override
  String get body;
  @override
  _i2.GTime get createdAt;
  @override
  _i2.GTime? get editedAt;
  @override
  _i2.GDecisionStatus? get decisionStatus;
  @override
  bool get denyFlag;
  @override
  GCreatePostData_createPost_author get author;
  @override
  BuiltList<GCreatePostData_createPost_reactions> get reactions;
  static Serializer<GCreatePostData_createPost> get serializer =>
      _$gCreatePostDataCreatePostSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreatePostData_createPost.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreatePostData_createPost? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreatePostData_createPost.serializer,
        json,
      );
}

abstract class GCreatePostData_createPost_author
    implements
        Built<GCreatePostData_createPost_author,
            GCreatePostData_createPost_authorBuilder>,
        GPostSummary_author {
  GCreatePostData_createPost_author._();

  factory GCreatePostData_createPost_author(
          [void Function(GCreatePostData_createPost_authorBuilder b) updates]) =
      _$GCreatePostData_createPost_author;

  static void _initializeBuilder(GCreatePostData_createPost_authorBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  static Serializer<GCreatePostData_createPost_author> get serializer =>
      _$gCreatePostDataCreatePostAuthorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreatePostData_createPost_author.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreatePostData_createPost_author? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreatePostData_createPost_author.serializer,
        json,
      );
}

abstract class GCreatePostData_createPost_reactions
    implements
        Built<GCreatePostData_createPost_reactions,
            GCreatePostData_createPost_reactionsBuilder>,
        GPostSummary_reactions {
  GCreatePostData_createPost_reactions._();

  factory GCreatePostData_createPost_reactions(
      [void Function(GCreatePostData_createPost_reactionsBuilder b)
          updates]) = _$GCreatePostData_createPost_reactions;

  static void _initializeBuilder(
          GCreatePostData_createPost_reactionsBuilder b) =>
      b..G__typename = 'ReactionSummary';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get emoji;
  @override
  int get count;
  @override
  bool get byViewer;
  static Serializer<GCreatePostData_createPost_reactions> get serializer =>
      _$gCreatePostDataCreatePostReactionsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreatePostData_createPost_reactions.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreatePostData_createPost_reactions? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreatePostData_createPost_reactions.serializer,
        json,
      );
}

abstract class GCreateCommentData
    implements Built<GCreateCommentData, GCreateCommentDataBuilder> {
  GCreateCommentData._();

  factory GCreateCommentData(
          [void Function(GCreateCommentDataBuilder b) updates]) =
      _$GCreateCommentData;

  static void _initializeBuilder(GCreateCommentDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GCreateCommentData_createComment get createComment;
  static Serializer<GCreateCommentData> get serializer =>
      _$gCreateCommentDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateCommentData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateCommentData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateCommentData.serializer,
        json,
      );
}

abstract class GCreateCommentData_createComment
    implements
        Built<GCreateCommentData_createComment,
            GCreateCommentData_createCommentBuilder>,
        GCommentSummary {
  GCreateCommentData_createComment._();

  factory GCreateCommentData_createComment(
          [void Function(GCreateCommentData_createCommentBuilder b) updates]) =
      _$GCreateCommentData_createComment;

  static void _initializeBuilder(GCreateCommentData_createCommentBuilder b) =>
      b..G__typename = 'Comment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get postId;
  @override
  String? get parentId;
  @override
  int get depth;
  @override
  String get body;
  @override
  _i2.GTime get createdAt;
  @override
  _i2.GTime? get editedAt;
  @override
  GCreateCommentData_createComment_author get author;
  @override
  BuiltList<GCreateCommentData_createComment_reactions> get reactions;
  static Serializer<GCreateCommentData_createComment> get serializer =>
      _$gCreateCommentDataCreateCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateCommentData_createComment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateCommentData_createComment? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateCommentData_createComment.serializer,
        json,
      );
}

abstract class GCreateCommentData_createComment_author
    implements
        Built<GCreateCommentData_createComment_author,
            GCreateCommentData_createComment_authorBuilder>,
        GCommentSummary_author {
  GCreateCommentData_createComment_author._();

  factory GCreateCommentData_createComment_author(
      [void Function(GCreateCommentData_createComment_authorBuilder b)
          updates]) = _$GCreateCommentData_createComment_author;

  static void _initializeBuilder(
          GCreateCommentData_createComment_authorBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  static Serializer<GCreateCommentData_createComment_author> get serializer =>
      _$gCreateCommentDataCreateCommentAuthorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateCommentData_createComment_author.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateCommentData_createComment_author? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateCommentData_createComment_author.serializer,
        json,
      );
}

abstract class GCreateCommentData_createComment_reactions
    implements
        Built<GCreateCommentData_createComment_reactions,
            GCreateCommentData_createComment_reactionsBuilder>,
        GCommentSummary_reactions {
  GCreateCommentData_createComment_reactions._();

  factory GCreateCommentData_createComment_reactions(
      [void Function(GCreateCommentData_createComment_reactionsBuilder b)
          updates]) = _$GCreateCommentData_createComment_reactions;

  static void _initializeBuilder(
          GCreateCommentData_createComment_reactionsBuilder b) =>
      b..G__typename = 'ReactionSummary';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get emoji;
  @override
  int get count;
  @override
  bool get byViewer;
  static Serializer<GCreateCommentData_createComment_reactions>
      get serializer => _$gCreateCommentDataCreateCommentReactionsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateCommentData_createComment_reactions.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateCommentData_createComment_reactions? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateCommentData_createComment_reactions.serializer,
        json,
      );
}

abstract class GReactToPostData
    implements Built<GReactToPostData, GReactToPostDataBuilder> {
  GReactToPostData._();

  factory GReactToPostData([void Function(GReactToPostDataBuilder b) updates]) =
      _$GReactToPostData;

  static void _initializeBuilder(GReactToPostDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GReactToPostData_reactToPost get reactToPost;
  static Serializer<GReactToPostData> get serializer =>
      _$gReactToPostDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReactToPostData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReactToPostData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReactToPostData.serializer,
        json,
      );
}

abstract class GReactToPostData_reactToPost
    implements
        Built<GReactToPostData_reactToPost,
            GReactToPostData_reactToPostBuilder> {
  GReactToPostData_reactToPost._();

  factory GReactToPostData_reactToPost(
          [void Function(GReactToPostData_reactToPostBuilder b) updates]) =
      _$GReactToPostData_reactToPost;

  static void _initializeBuilder(GReactToPostData_reactToPostBuilder b) =>
      b..G__typename = 'Post';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  BuiltList<GReactToPostData_reactToPost_reactions> get reactions;
  static Serializer<GReactToPostData_reactToPost> get serializer =>
      _$gReactToPostDataReactToPostSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReactToPostData_reactToPost.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReactToPostData_reactToPost? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReactToPostData_reactToPost.serializer,
        json,
      );
}

abstract class GReactToPostData_reactToPost_reactions
    implements
        Built<GReactToPostData_reactToPost_reactions,
            GReactToPostData_reactToPost_reactionsBuilder> {
  GReactToPostData_reactToPost_reactions._();

  factory GReactToPostData_reactToPost_reactions(
      [void Function(GReactToPostData_reactToPost_reactionsBuilder b)
          updates]) = _$GReactToPostData_reactToPost_reactions;

  static void _initializeBuilder(
          GReactToPostData_reactToPost_reactionsBuilder b) =>
      b..G__typename = 'ReactionSummary';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get emoji;
  int get count;
  bool get byViewer;
  static Serializer<GReactToPostData_reactToPost_reactions> get serializer =>
      _$gReactToPostDataReactToPostReactionsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReactToPostData_reactToPost_reactions.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReactToPostData_reactToPost_reactions? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReactToPostData_reactToPost_reactions.serializer,
        json,
      );
}

abstract class GUnreactToPostData
    implements Built<GUnreactToPostData, GUnreactToPostDataBuilder> {
  GUnreactToPostData._();

  factory GUnreactToPostData(
          [void Function(GUnreactToPostDataBuilder b) updates]) =
      _$GUnreactToPostData;

  static void _initializeBuilder(GUnreactToPostDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUnreactToPostData_unreactToPost get unreactToPost;
  static Serializer<GUnreactToPostData> get serializer =>
      _$gUnreactToPostDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUnreactToPostData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUnreactToPostData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUnreactToPostData.serializer,
        json,
      );
}

abstract class GUnreactToPostData_unreactToPost
    implements
        Built<GUnreactToPostData_unreactToPost,
            GUnreactToPostData_unreactToPostBuilder> {
  GUnreactToPostData_unreactToPost._();

  factory GUnreactToPostData_unreactToPost(
          [void Function(GUnreactToPostData_unreactToPostBuilder b) updates]) =
      _$GUnreactToPostData_unreactToPost;

  static void _initializeBuilder(GUnreactToPostData_unreactToPostBuilder b) =>
      b..G__typename = 'Post';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  BuiltList<GUnreactToPostData_unreactToPost_reactions> get reactions;
  static Serializer<GUnreactToPostData_unreactToPost> get serializer =>
      _$gUnreactToPostDataUnreactToPostSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUnreactToPostData_unreactToPost.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUnreactToPostData_unreactToPost? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUnreactToPostData_unreactToPost.serializer,
        json,
      );
}

abstract class GUnreactToPostData_unreactToPost_reactions
    implements
        Built<GUnreactToPostData_unreactToPost_reactions,
            GUnreactToPostData_unreactToPost_reactionsBuilder> {
  GUnreactToPostData_unreactToPost_reactions._();

  factory GUnreactToPostData_unreactToPost_reactions(
      [void Function(GUnreactToPostData_unreactToPost_reactionsBuilder b)
          updates]) = _$GUnreactToPostData_unreactToPost_reactions;

  static void _initializeBuilder(
          GUnreactToPostData_unreactToPost_reactionsBuilder b) =>
      b..G__typename = 'ReactionSummary';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get emoji;
  int get count;
  bool get byViewer;
  static Serializer<GUnreactToPostData_unreactToPost_reactions>
      get serializer => _$gUnreactToPostDataUnreactToPostReactionsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUnreactToPostData_unreactToPost_reactions.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUnreactToPostData_unreactToPost_reactions? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUnreactToPostData_unreactToPost_reactions.serializer,
        json,
      );
}

abstract class GPostChangedData
    implements Built<GPostChangedData, GPostChangedDataBuilder> {
  GPostChangedData._();

  factory GPostChangedData([void Function(GPostChangedDataBuilder b) updates]) =
      _$GPostChangedData;

  static void _initializeBuilder(GPostChangedDataBuilder b) =>
      b..G__typename = 'Subscription';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GPostChangedData_postChanged get postChanged;
  static Serializer<GPostChangedData> get serializer =>
      _$gPostChangedDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostChangedData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostChangedData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostChangedData.serializer,
        json,
      );
}

abstract class GPostChangedData_postChanged
    implements
        Built<GPostChangedData_postChanged,
            GPostChangedData_postChangedBuilder>,
        GPostSummary {
  GPostChangedData_postChanged._();

  factory GPostChangedData_postChanged(
          [void Function(GPostChangedData_postChangedBuilder b) updates]) =
      _$GPostChangedData_postChanged;

  static void _initializeBuilder(GPostChangedData_postChangedBuilder b) =>
      b..G__typename = 'Post';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get title;
  @override
  String get body;
  @override
  _i2.GTime get createdAt;
  @override
  _i2.GTime? get editedAt;
  @override
  _i2.GDecisionStatus? get decisionStatus;
  @override
  bool get denyFlag;
  @override
  GPostChangedData_postChanged_author get author;
  @override
  BuiltList<GPostChangedData_postChanged_reactions> get reactions;
  static Serializer<GPostChangedData_postChanged> get serializer =>
      _$gPostChangedDataPostChangedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostChangedData_postChanged.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostChangedData_postChanged? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostChangedData_postChanged.serializer,
        json,
      );
}

abstract class GPostChangedData_postChanged_author
    implements
        Built<GPostChangedData_postChanged_author,
            GPostChangedData_postChanged_authorBuilder>,
        GPostSummary_author {
  GPostChangedData_postChanged_author._();

  factory GPostChangedData_postChanged_author(
      [void Function(GPostChangedData_postChanged_authorBuilder b)
          updates]) = _$GPostChangedData_postChanged_author;

  static void _initializeBuilder(
          GPostChangedData_postChanged_authorBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  static Serializer<GPostChangedData_postChanged_author> get serializer =>
      _$gPostChangedDataPostChangedAuthorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostChangedData_postChanged_author.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostChangedData_postChanged_author? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostChangedData_postChanged_author.serializer,
        json,
      );
}

abstract class GPostChangedData_postChanged_reactions
    implements
        Built<GPostChangedData_postChanged_reactions,
            GPostChangedData_postChanged_reactionsBuilder>,
        GPostSummary_reactions {
  GPostChangedData_postChanged_reactions._();

  factory GPostChangedData_postChanged_reactions(
      [void Function(GPostChangedData_postChanged_reactionsBuilder b)
          updates]) = _$GPostChangedData_postChanged_reactions;

  static void _initializeBuilder(
          GPostChangedData_postChanged_reactionsBuilder b) =>
      b..G__typename = 'ReactionSummary';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get emoji;
  @override
  int get count;
  @override
  bool get byViewer;
  static Serializer<GPostChangedData_postChanged_reactions> get serializer =>
      _$gPostChangedDataPostChangedReactionsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostChangedData_postChanged_reactions.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostChangedData_postChanged_reactions? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostChangedData_postChanged_reactions.serializer,
        json,
      );
}

abstract class GPostSummary {
  String get G__typename;
  String get id;
  String get title;
  String get body;
  _i2.GTime get createdAt;
  _i2.GTime? get editedAt;
  _i2.GDecisionStatus? get decisionStatus;
  bool get denyFlag;
  GPostSummary_author get author;
  BuiltList<GPostSummary_reactions> get reactions;
  Map<String, dynamic> toJson();
}

abstract class GPostSummary_author {
  String get G__typename;
  String get id;
  String get displayName;
  Map<String, dynamic> toJson();
}

abstract class GPostSummary_reactions {
  String get G__typename;
  String get emoji;
  int get count;
  bool get byViewer;
  Map<String, dynamic> toJson();
}

abstract class GPostSummaryData
    implements Built<GPostSummaryData, GPostSummaryDataBuilder>, GPostSummary {
  GPostSummaryData._();

  factory GPostSummaryData([void Function(GPostSummaryDataBuilder b) updates]) =
      _$GPostSummaryData;

  static void _initializeBuilder(GPostSummaryDataBuilder b) =>
      b..G__typename = 'Post';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get title;
  @override
  String get body;
  @override
  _i2.GTime get createdAt;
  @override
  _i2.GTime? get editedAt;
  @override
  _i2.GDecisionStatus? get decisionStatus;
  @override
  bool get denyFlag;
  @override
  GPostSummaryData_author get author;
  @override
  BuiltList<GPostSummaryData_reactions> get reactions;
  static Serializer<GPostSummaryData> get serializer =>
      _$gPostSummaryDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostSummaryData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostSummaryData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostSummaryData.serializer,
        json,
      );
}

abstract class GPostSummaryData_author
    implements
        Built<GPostSummaryData_author, GPostSummaryData_authorBuilder>,
        GPostSummary_author {
  GPostSummaryData_author._();

  factory GPostSummaryData_author(
          [void Function(GPostSummaryData_authorBuilder b) updates]) =
      _$GPostSummaryData_author;

  static void _initializeBuilder(GPostSummaryData_authorBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  static Serializer<GPostSummaryData_author> get serializer =>
      _$gPostSummaryDataAuthorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostSummaryData_author.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostSummaryData_author? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostSummaryData_author.serializer,
        json,
      );
}

abstract class GPostSummaryData_reactions
    implements
        Built<GPostSummaryData_reactions, GPostSummaryData_reactionsBuilder>,
        GPostSummary_reactions {
  GPostSummaryData_reactions._();

  factory GPostSummaryData_reactions(
          [void Function(GPostSummaryData_reactionsBuilder b) updates]) =
      _$GPostSummaryData_reactions;

  static void _initializeBuilder(GPostSummaryData_reactionsBuilder b) =>
      b..G__typename = 'ReactionSummary';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get emoji;
  @override
  int get count;
  @override
  bool get byViewer;
  static Serializer<GPostSummaryData_reactions> get serializer =>
      _$gPostSummaryDataReactionsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostSummaryData_reactions.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostSummaryData_reactions? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostSummaryData_reactions.serializer,
        json,
      );
}

abstract class GCommentSummary {
  String get G__typename;
  String get id;
  String get postId;
  String? get parentId;
  int get depth;
  String get body;
  _i2.GTime get createdAt;
  _i2.GTime? get editedAt;
  GCommentSummary_author get author;
  BuiltList<GCommentSummary_reactions> get reactions;
  Map<String, dynamic> toJson();
}

abstract class GCommentSummary_author {
  String get G__typename;
  String get id;
  String get displayName;
  Map<String, dynamic> toJson();
}

abstract class GCommentSummary_reactions {
  String get G__typename;
  String get emoji;
  int get count;
  bool get byViewer;
  Map<String, dynamic> toJson();
}

abstract class GCommentSummaryData
    implements
        Built<GCommentSummaryData, GCommentSummaryDataBuilder>,
        GCommentSummary {
  GCommentSummaryData._();

  factory GCommentSummaryData(
          [void Function(GCommentSummaryDataBuilder b) updates]) =
      _$GCommentSummaryData;

  static void _initializeBuilder(GCommentSummaryDataBuilder b) =>
      b..G__typename = 'Comment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get postId;
  @override
  String? get parentId;
  @override
  int get depth;
  @override
  String get body;
  @override
  _i2.GTime get createdAt;
  @override
  _i2.GTime? get editedAt;
  @override
  GCommentSummaryData_author get author;
  @override
  BuiltList<GCommentSummaryData_reactions> get reactions;
  static Serializer<GCommentSummaryData> get serializer =>
      _$gCommentSummaryDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCommentSummaryData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCommentSummaryData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCommentSummaryData.serializer,
        json,
      );
}

abstract class GCommentSummaryData_author
    implements
        Built<GCommentSummaryData_author, GCommentSummaryData_authorBuilder>,
        GCommentSummary_author {
  GCommentSummaryData_author._();

  factory GCommentSummaryData_author(
          [void Function(GCommentSummaryData_authorBuilder b) updates]) =
      _$GCommentSummaryData_author;

  static void _initializeBuilder(GCommentSummaryData_authorBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  static Serializer<GCommentSummaryData_author> get serializer =>
      _$gCommentSummaryDataAuthorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCommentSummaryData_author.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCommentSummaryData_author? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCommentSummaryData_author.serializer,
        json,
      );
}

abstract class GCommentSummaryData_reactions
    implements
        Built<GCommentSummaryData_reactions,
            GCommentSummaryData_reactionsBuilder>,
        GCommentSummary_reactions {
  GCommentSummaryData_reactions._();

  factory GCommentSummaryData_reactions(
          [void Function(GCommentSummaryData_reactionsBuilder b) updates]) =
      _$GCommentSummaryData_reactions;

  static void _initializeBuilder(GCommentSummaryData_reactionsBuilder b) =>
      b..G__typename = 'ReactionSummary';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get emoji;
  @override
  int get count;
  @override
  bool get byViewer;
  static Serializer<GCommentSummaryData_reactions> get serializer =>
      _$gCommentSummaryDataReactionsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCommentSummaryData_reactions.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCommentSummaryData_reactions? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCommentSummaryData_reactions.serializer,
        json,
      );
}
