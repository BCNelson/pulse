// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pulse/graphql/__generated__/schema.schema.gql.dart' as _i2;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i1;

part 'mention_preview.data.gql.g.dart';

abstract class GMentionPreviewUserData
    implements Built<GMentionPreviewUserData, GMentionPreviewUserDataBuilder> {
  GMentionPreviewUserData._();

  factory GMentionPreviewUserData(
          [void Function(GMentionPreviewUserDataBuilder b) updates]) =
      _$GMentionPreviewUserData;

  static void _initializeBuilder(GMentionPreviewUserDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GMentionPreviewUserData_userByHandle? get userByHandle;
  static Serializer<GMentionPreviewUserData> get serializer =>
      _$gMentionPreviewUserDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionPreviewUserData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionPreviewUserData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionPreviewUserData.serializer,
        json,
      );
}

abstract class GMentionPreviewUserData_userByHandle
    implements
        Built<GMentionPreviewUserData_userByHandle,
            GMentionPreviewUserData_userByHandleBuilder> {
  GMentionPreviewUserData_userByHandle._();

  factory GMentionPreviewUserData_userByHandle(
      [void Function(GMentionPreviewUserData_userByHandleBuilder b)
          updates]) = _$GMentionPreviewUserData_userByHandle;

  static void _initializeBuilder(
          GMentionPreviewUserData_userByHandleBuilder b) =>
      b..G__typename = 'User';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get displayName;
  GMentionPreviewUserData_userByHandle_homeTag? get homeTag;
  BuiltList<GMentionPreviewUserData_userByHandle_recentPosts> get recentPosts;
  static Serializer<GMentionPreviewUserData_userByHandle> get serializer =>
      _$gMentionPreviewUserDataUserByHandleSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionPreviewUserData_userByHandle.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionPreviewUserData_userByHandle? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionPreviewUserData_userByHandle.serializer,
        json,
      );
}

abstract class GMentionPreviewUserData_userByHandle_homeTag
    implements
        Built<GMentionPreviewUserData_userByHandle_homeTag,
            GMentionPreviewUserData_userByHandle_homeTagBuilder> {
  GMentionPreviewUserData_userByHandle_homeTag._();

  factory GMentionPreviewUserData_userByHandle_homeTag(
      [void Function(GMentionPreviewUserData_userByHandle_homeTagBuilder b)
          updates]) = _$GMentionPreviewUserData_userByHandle_homeTag;

  static void _initializeBuilder(
          GMentionPreviewUserData_userByHandle_homeTagBuilder b) =>
      b..G__typename = 'Tag';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get slug;
  String get path;
  static Serializer<GMentionPreviewUserData_userByHandle_homeTag>
      get serializer => _$gMentionPreviewUserDataUserByHandleHomeTagSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionPreviewUserData_userByHandle_homeTag.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionPreviewUserData_userByHandle_homeTag? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionPreviewUserData_userByHandle_homeTag.serializer,
        json,
      );
}

abstract class GMentionPreviewUserData_userByHandle_recentPosts
    implements
        Built<GMentionPreviewUserData_userByHandle_recentPosts,
            GMentionPreviewUserData_userByHandle_recentPostsBuilder>,
        GMentionPreviewPost {
  GMentionPreviewUserData_userByHandle_recentPosts._();

  factory GMentionPreviewUserData_userByHandle_recentPosts(
      [void Function(GMentionPreviewUserData_userByHandle_recentPostsBuilder b)
          updates]) = _$GMentionPreviewUserData_userByHandle_recentPosts;

  static void _initializeBuilder(
          GMentionPreviewUserData_userByHandle_recentPostsBuilder b) =>
      b..G__typename = 'Post';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get title;
  @override
  _i2.GTime get createdAt;
  @override
  GMentionPreviewUserData_userByHandle_recentPosts_author get author;
  static Serializer<GMentionPreviewUserData_userByHandle_recentPosts>
      get serializer =>
          _$gMentionPreviewUserDataUserByHandleRecentPostsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionPreviewUserData_userByHandle_recentPosts.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionPreviewUserData_userByHandle_recentPosts? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionPreviewUserData_userByHandle_recentPosts.serializer,
        json,
      );
}

abstract class GMentionPreviewUserData_userByHandle_recentPosts_author
    implements
        Built<GMentionPreviewUserData_userByHandle_recentPosts_author,
            GMentionPreviewUserData_userByHandle_recentPosts_authorBuilder>,
        GMentionPreviewPost_author {
  GMentionPreviewUserData_userByHandle_recentPosts_author._();

  factory GMentionPreviewUserData_userByHandle_recentPosts_author(
      [void Function(
              GMentionPreviewUserData_userByHandle_recentPosts_authorBuilder b)
          updates]) = _$GMentionPreviewUserData_userByHandle_recentPosts_author;

  static void _initializeBuilder(
          GMentionPreviewUserData_userByHandle_recentPosts_authorBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  static Serializer<GMentionPreviewUserData_userByHandle_recentPosts_author>
      get serializer =>
          _$gMentionPreviewUserDataUserByHandleRecentPostsAuthorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionPreviewUserData_userByHandle_recentPosts_author.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionPreviewUserData_userByHandle_recentPosts_author? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionPreviewUserData_userByHandle_recentPosts_author.serializer,
        json,
      );
}

abstract class GMentionPreviewTagData
    implements Built<GMentionPreviewTagData, GMentionPreviewTagDataBuilder> {
  GMentionPreviewTagData._();

  factory GMentionPreviewTagData(
          [void Function(GMentionPreviewTagDataBuilder b) updates]) =
      _$GMentionPreviewTagData;

  static void _initializeBuilder(GMentionPreviewTagDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GMentionPreviewTagData_tagBySlugPath? get tagBySlugPath;
  static Serializer<GMentionPreviewTagData> get serializer =>
      _$gMentionPreviewTagDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionPreviewTagData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionPreviewTagData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionPreviewTagData.serializer,
        json,
      );
}

abstract class GMentionPreviewTagData_tagBySlugPath
    implements
        Built<GMentionPreviewTagData_tagBySlugPath,
            GMentionPreviewTagData_tagBySlugPathBuilder> {
  GMentionPreviewTagData_tagBySlugPath._();

  factory GMentionPreviewTagData_tagBySlugPath(
      [void Function(GMentionPreviewTagData_tagBySlugPathBuilder b)
          updates]) = _$GMentionPreviewTagData_tagBySlugPath;

  static void _initializeBuilder(
          GMentionPreviewTagData_tagBySlugPathBuilder b) =>
      b..G__typename = 'Tag';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get slug;
  String get displayName;
  String get path;
  _i2.GTagRootKind get rootKind;
  GMentionPreviewTagData_tagBySlugPath_parent? get parent;
  GMentionPreviewTagData_tagBySlugPath_posts get posts;
  static Serializer<GMentionPreviewTagData_tagBySlugPath> get serializer =>
      _$gMentionPreviewTagDataTagBySlugPathSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionPreviewTagData_tagBySlugPath.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionPreviewTagData_tagBySlugPath? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionPreviewTagData_tagBySlugPath.serializer,
        json,
      );
}

abstract class GMentionPreviewTagData_tagBySlugPath_parent
    implements
        Built<GMentionPreviewTagData_tagBySlugPath_parent,
            GMentionPreviewTagData_tagBySlugPath_parentBuilder> {
  GMentionPreviewTagData_tagBySlugPath_parent._();

  factory GMentionPreviewTagData_tagBySlugPath_parent(
      [void Function(GMentionPreviewTagData_tagBySlugPath_parentBuilder b)
          updates]) = _$GMentionPreviewTagData_tagBySlugPath_parent;

  static void _initializeBuilder(
          GMentionPreviewTagData_tagBySlugPath_parentBuilder b) =>
      b..G__typename = 'Tag';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get slug;
  String get displayName;
  String get path;
  static Serializer<GMentionPreviewTagData_tagBySlugPath_parent>
      get serializer => _$gMentionPreviewTagDataTagBySlugPathParentSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionPreviewTagData_tagBySlugPath_parent.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionPreviewTagData_tagBySlugPath_parent? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionPreviewTagData_tagBySlugPath_parent.serializer,
        json,
      );
}

abstract class GMentionPreviewTagData_tagBySlugPath_posts
    implements
        Built<GMentionPreviewTagData_tagBySlugPath_posts,
            GMentionPreviewTagData_tagBySlugPath_postsBuilder> {
  GMentionPreviewTagData_tagBySlugPath_posts._();

  factory GMentionPreviewTagData_tagBySlugPath_posts(
      [void Function(GMentionPreviewTagData_tagBySlugPath_postsBuilder b)
          updates]) = _$GMentionPreviewTagData_tagBySlugPath_posts;

  static void _initializeBuilder(
          GMentionPreviewTagData_tagBySlugPath_postsBuilder b) =>
      b..G__typename = 'PostConnection';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GMentionPreviewTagData_tagBySlugPath_posts_edges> get edges;
  static Serializer<GMentionPreviewTagData_tagBySlugPath_posts>
      get serializer => _$gMentionPreviewTagDataTagBySlugPathPostsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionPreviewTagData_tagBySlugPath_posts.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionPreviewTagData_tagBySlugPath_posts? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionPreviewTagData_tagBySlugPath_posts.serializer,
        json,
      );
}

abstract class GMentionPreviewTagData_tagBySlugPath_posts_edges
    implements
        Built<GMentionPreviewTagData_tagBySlugPath_posts_edges,
            GMentionPreviewTagData_tagBySlugPath_posts_edgesBuilder> {
  GMentionPreviewTagData_tagBySlugPath_posts_edges._();

  factory GMentionPreviewTagData_tagBySlugPath_posts_edges(
      [void Function(GMentionPreviewTagData_tagBySlugPath_posts_edgesBuilder b)
          updates]) = _$GMentionPreviewTagData_tagBySlugPath_posts_edges;

  static void _initializeBuilder(
          GMentionPreviewTagData_tagBySlugPath_posts_edgesBuilder b) =>
      b..G__typename = 'PostEdge';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GMentionPreviewTagData_tagBySlugPath_posts_edges_node get node;
  static Serializer<GMentionPreviewTagData_tagBySlugPath_posts_edges>
      get serializer =>
          _$gMentionPreviewTagDataTagBySlugPathPostsEdgesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionPreviewTagData_tagBySlugPath_posts_edges.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionPreviewTagData_tagBySlugPath_posts_edges? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionPreviewTagData_tagBySlugPath_posts_edges.serializer,
        json,
      );
}

abstract class GMentionPreviewTagData_tagBySlugPath_posts_edges_node
    implements
        Built<GMentionPreviewTagData_tagBySlugPath_posts_edges_node,
            GMentionPreviewTagData_tagBySlugPath_posts_edges_nodeBuilder>,
        GMentionPreviewPost {
  GMentionPreviewTagData_tagBySlugPath_posts_edges_node._();

  factory GMentionPreviewTagData_tagBySlugPath_posts_edges_node(
      [void Function(
              GMentionPreviewTagData_tagBySlugPath_posts_edges_nodeBuilder b)
          updates]) = _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node;

  static void _initializeBuilder(
          GMentionPreviewTagData_tagBySlugPath_posts_edges_nodeBuilder b) =>
      b..G__typename = 'Post';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get title;
  @override
  _i2.GTime get createdAt;
  @override
  GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author get author;
  static Serializer<GMentionPreviewTagData_tagBySlugPath_posts_edges_node>
      get serializer =>
          _$gMentionPreviewTagDataTagBySlugPathPostsEdgesNodeSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionPreviewTagData_tagBySlugPath_posts_edges_node.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionPreviewTagData_tagBySlugPath_posts_edges_node? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionPreviewTagData_tagBySlugPath_posts_edges_node.serializer,
        json,
      );
}

abstract class GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author
    implements
        Built<GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author,
            GMentionPreviewTagData_tagBySlugPath_posts_edges_node_authorBuilder>,
        GMentionPreviewPost_author {
  GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author._();

  factory GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author(
          [void Function(
                  GMentionPreviewTagData_tagBySlugPath_posts_edges_node_authorBuilder
                      b)
              updates]) =
      _$GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author;

  static void _initializeBuilder(
          GMentionPreviewTagData_tagBySlugPath_posts_edges_node_authorBuilder
              b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  static Serializer<
          GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author>
      get serializer =>
          _$gMentionPreviewTagDataTagBySlugPathPostsEdgesNodeAuthorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionPreviewTagData_tagBySlugPath_posts_edges_node_author.serializer,
        json,
      );
}

abstract class GMentionPreviewPost {
  String get G__typename;
  String get id;
  String get title;
  _i2.GTime get createdAt;
  GMentionPreviewPost_author get author;
  Map<String, dynamic> toJson();
}

abstract class GMentionPreviewPost_author {
  String get G__typename;
  String get id;
  String get displayName;
  Map<String, dynamic> toJson();
}

abstract class GMentionPreviewPostData
    implements
        Built<GMentionPreviewPostData, GMentionPreviewPostDataBuilder>,
        GMentionPreviewPost {
  GMentionPreviewPostData._();

  factory GMentionPreviewPostData(
          [void Function(GMentionPreviewPostDataBuilder b) updates]) =
      _$GMentionPreviewPostData;

  static void _initializeBuilder(GMentionPreviewPostDataBuilder b) =>
      b..G__typename = 'Post';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get title;
  @override
  _i2.GTime get createdAt;
  @override
  GMentionPreviewPostData_author get author;
  static Serializer<GMentionPreviewPostData> get serializer =>
      _$gMentionPreviewPostDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionPreviewPostData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionPreviewPostData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionPreviewPostData.serializer,
        json,
      );
}

abstract class GMentionPreviewPostData_author
    implements
        Built<GMentionPreviewPostData_author,
            GMentionPreviewPostData_authorBuilder>,
        GMentionPreviewPost_author {
  GMentionPreviewPostData_author._();

  factory GMentionPreviewPostData_author(
          [void Function(GMentionPreviewPostData_authorBuilder b) updates]) =
      _$GMentionPreviewPostData_author;

  static void _initializeBuilder(GMentionPreviewPostData_authorBuilder b) =>
      b..G__typename = 'Principal';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get displayName;
  static Serializer<GMentionPreviewPostData_author> get serializer =>
      _$gMentionPreviewPostDataAuthorSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionPreviewPostData_author.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionPreviewPostData_author? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionPreviewPostData_author.serializer,
        json,
      );
}
