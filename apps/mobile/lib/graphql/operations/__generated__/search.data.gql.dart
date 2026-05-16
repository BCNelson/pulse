// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    as _i2;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i1;

part 'search.data.gql.g.dart';

abstract class GSearchData implements Built<GSearchData, GSearchDataBuilder> {
  GSearchData._();

  factory GSearchData([void Function(GSearchDataBuilder b) updates]) =
      _$GSearchData;

  static void _initializeBuilder(GSearchDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GSearchData_search get search;
  static Serializer<GSearchData> get serializer => _$gSearchDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchData.serializer,
        json,
      );
}

abstract class GSearchData_search
    implements Built<GSearchData_search, GSearchData_searchBuilder> {
  GSearchData_search._();

  factory GSearchData_search(
          [void Function(GSearchData_searchBuilder b) updates]) =
      _$GSearchData_search;

  static void _initializeBuilder(GSearchData_searchBuilder b) =>
      b..G__typename = 'SearchConnection';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GSearchData_search_edges> get edges;
  static Serializer<GSearchData_search> get serializer =>
      _$gSearchDataSearchSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchData_search.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchData_search? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchData_search.serializer,
        json,
      );
}

abstract class GSearchData_search_edges
    implements
        Built<GSearchData_search_edges, GSearchData_search_edgesBuilder> {
  GSearchData_search_edges._();

  factory GSearchData_search_edges(
          [void Function(GSearchData_search_edgesBuilder b) updates]) =
      _$GSearchData_search_edges;

  static void _initializeBuilder(GSearchData_search_edgesBuilder b) =>
      b..G__typename = 'SearchEdge';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get cursor;
  double get score;
  GSearchData_search_edges_node get node;
  static Serializer<GSearchData_search_edges> get serializer =>
      _$gSearchDataSearchEdgesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchData_search_edges.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchData_search_edges? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchData_search_edges.serializer,
        json,
      );
}

abstract class GSearchData_search_edges_node {
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GSearchData_search_edges_node> get serializer =>
      _i2.InlineFragmentSerializer<GSearchData_search_edges_node>(
        'GSearchData_search_edges_node',
        GSearchData_search_edges_node__base,
        {
          'Post': GSearchData_search_edges_node__asPost,
          'Comment': GSearchData_search_edges_node__asComment,
        },
      );

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchData_search_edges_node.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchData_search_edges_node? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchData_search_edges_node.serializer,
        json,
      );
}

abstract class GSearchData_search_edges_node__base
    implements
        Built<GSearchData_search_edges_node__base,
            GSearchData_search_edges_node__baseBuilder>,
        GSearchData_search_edges_node {
  GSearchData_search_edges_node__base._();

  factory GSearchData_search_edges_node__base(
      [void Function(GSearchData_search_edges_node__baseBuilder b)
          updates]) = _$GSearchData_search_edges_node__base;

  static void _initializeBuilder(
          GSearchData_search_edges_node__baseBuilder b) =>
      b..G__typename = 'SearchResult';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  static Serializer<GSearchData_search_edges_node__base> get serializer =>
      _$gSearchDataSearchEdgesNodeBaseSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchData_search_edges_node__base.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchData_search_edges_node__base? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchData_search_edges_node__base.serializer,
        json,
      );
}

abstract class GSearchData_search_edges_node__asPost
    implements
        Built<GSearchData_search_edges_node__asPost,
            GSearchData_search_edges_node__asPostBuilder>,
        GSearchData_search_edges_node {
  GSearchData_search_edges_node__asPost._();

  factory GSearchData_search_edges_node__asPost(
      [void Function(GSearchData_search_edges_node__asPostBuilder b)
          updates]) = _$GSearchData_search_edges_node__asPost;

  static void _initializeBuilder(
          GSearchData_search_edges_node__asPostBuilder b) =>
      b..G__typename = 'Post';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get title;
  GSearchData_search_edges_node__asPost_author get author;
  static Serializer<GSearchData_search_edges_node__asPost> get serializer =>
      _$gSearchDataSearchEdgesNodeAsPostSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchData_search_edges_node__asPost.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchData_search_edges_node__asPost? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchData_search_edges_node__asPost.serializer,
        json,
      );
}

abstract class GSearchData_search_edges_node__asPost_author
    implements
        Built<GSearchData_search_edges_node__asPost_author,
            GSearchData_search_edges_node__asPost_authorBuilder> {
  GSearchData_search_edges_node__asPost_author._();

  factory GSearchData_search_edges_node__asPost_author(
      [void Function(GSearchData_search_edges_node__asPost_authorBuilder b)
          updates]) = _$GSearchData_search_edges_node__asPost_author;

  static void _initializeBuilder(
          GSearchData_search_edges_node__asPost_authorBuilder b) =>
      b..G__typename = 'Principal';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get displayName;
  static Serializer<GSearchData_search_edges_node__asPost_author>
      get serializer => _$gSearchDataSearchEdgesNodeAsPostAuthorSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchData_search_edges_node__asPost_author.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchData_search_edges_node__asPost_author? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchData_search_edges_node__asPost_author.serializer,
        json,
      );
}

abstract class GSearchData_search_edges_node__asComment
    implements
        Built<GSearchData_search_edges_node__asComment,
            GSearchData_search_edges_node__asCommentBuilder>,
        GSearchData_search_edges_node {
  GSearchData_search_edges_node__asComment._();

  factory GSearchData_search_edges_node__asComment(
      [void Function(GSearchData_search_edges_node__asCommentBuilder b)
          updates]) = _$GSearchData_search_edges_node__asComment;

  static void _initializeBuilder(
          GSearchData_search_edges_node__asCommentBuilder b) =>
      b..G__typename = 'Comment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get postId;
  String get body;
  static Serializer<GSearchData_search_edges_node__asComment> get serializer =>
      _$gSearchDataSearchEdgesNodeAsCommentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchData_search_edges_node__asComment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchData_search_edges_node__asComment? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchData_search_edges_node__asComment.serializer,
        json,
      );
}

abstract class GSearchTagsData
    implements Built<GSearchTagsData, GSearchTagsDataBuilder> {
  GSearchTagsData._();

  factory GSearchTagsData([void Function(GSearchTagsDataBuilder b) updates]) =
      _$GSearchTagsData;

  static void _initializeBuilder(GSearchTagsDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GSearchTagsData_searchTags> get searchTags;
  static Serializer<GSearchTagsData> get serializer =>
      _$gSearchTagsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchTagsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchTagsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchTagsData.serializer,
        json,
      );
}

abstract class GSearchTagsData_searchTags
    implements
        Built<GSearchTagsData_searchTags, GSearchTagsData_searchTagsBuilder> {
  GSearchTagsData_searchTags._();

  factory GSearchTagsData_searchTags(
          [void Function(GSearchTagsData_searchTagsBuilder b) updates]) =
      _$GSearchTagsData_searchTags;

  static void _initializeBuilder(GSearchTagsData_searchTagsBuilder b) =>
      b..G__typename = 'TagSearchHit';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  double get similarity;
  GSearchTagsData_searchTags_tag get tag;
  static Serializer<GSearchTagsData_searchTags> get serializer =>
      _$gSearchTagsDataSearchTagsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchTagsData_searchTags.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchTagsData_searchTags? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchTagsData_searchTags.serializer,
        json,
      );
}

abstract class GSearchTagsData_searchTags_tag
    implements
        Built<GSearchTagsData_searchTags_tag,
            GSearchTagsData_searchTags_tagBuilder> {
  GSearchTagsData_searchTags_tag._();

  factory GSearchTagsData_searchTags_tag(
          [void Function(GSearchTagsData_searchTags_tagBuilder b) updates]) =
      _$GSearchTagsData_searchTags_tag;

  static void _initializeBuilder(GSearchTagsData_searchTags_tagBuilder b) =>
      b..G__typename = 'Tag';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get slug;
  String get displayName;
  String get path;
  static Serializer<GSearchTagsData_searchTags_tag> get serializer =>
      _$gSearchTagsDataSearchTagsTagSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchTagsData_searchTags_tag.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchTagsData_searchTags_tag? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchTagsData_searchTags_tag.serializer,
        json,
      );
}

abstract class GSearchUsersData
    implements Built<GSearchUsersData, GSearchUsersDataBuilder> {
  GSearchUsersData._();

  factory GSearchUsersData([void Function(GSearchUsersDataBuilder b) updates]) =
      _$GSearchUsersData;

  static void _initializeBuilder(GSearchUsersDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GSearchUsersData_searchUsers> get searchUsers;
  static Serializer<GSearchUsersData> get serializer =>
      _$gSearchUsersDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchUsersData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchUsersData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchUsersData.serializer,
        json,
      );
}

abstract class GSearchUsersData_searchUsers
    implements
        Built<GSearchUsersData_searchUsers,
            GSearchUsersData_searchUsersBuilder> {
  GSearchUsersData_searchUsers._();

  factory GSearchUsersData_searchUsers(
          [void Function(GSearchUsersData_searchUsersBuilder b) updates]) =
      _$GSearchUsersData_searchUsers;

  static void _initializeBuilder(GSearchUsersData_searchUsersBuilder b) =>
      b..G__typename = 'User';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get displayName;
  GSearchUsersData_searchUsers_homeTag? get homeTag;
  static Serializer<GSearchUsersData_searchUsers> get serializer =>
      _$gSearchUsersDataSearchUsersSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchUsersData_searchUsers.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchUsersData_searchUsers? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchUsersData_searchUsers.serializer,
        json,
      );
}

abstract class GSearchUsersData_searchUsers_homeTag
    implements
        Built<GSearchUsersData_searchUsers_homeTag,
            GSearchUsersData_searchUsers_homeTagBuilder> {
  GSearchUsersData_searchUsers_homeTag._();

  factory GSearchUsersData_searchUsers_homeTag(
      [void Function(GSearchUsersData_searchUsers_homeTagBuilder b)
          updates]) = _$GSearchUsersData_searchUsers_homeTag;

  static void _initializeBuilder(
          GSearchUsersData_searchUsers_homeTagBuilder b) =>
      b..G__typename = 'Tag';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get slug;
  String get path;
  static Serializer<GSearchUsersData_searchUsers_homeTag> get serializer =>
      _$gSearchUsersDataSearchUsersHomeTagSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchUsersData_searchUsers_homeTag.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchUsersData_searchUsers_homeTag? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchUsersData_searchUsers_homeTag.serializer,
        json,
      );
}
