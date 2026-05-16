// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pulse/graphql/__generated__/schema.schema.gql.dart' as _i2;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i1;

part 'tag_tree.data.gql.g.dart';

abstract class GTagTreeData
    implements Built<GTagTreeData, GTagTreeDataBuilder> {
  GTagTreeData._();

  factory GTagTreeData([void Function(GTagTreeDataBuilder b) updates]) =
      _$GTagTreeData;

  static void _initializeBuilder(GTagTreeDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GTagTreeData_myTagRoots> get myTagRoots;
  static Serializer<GTagTreeData> get serializer => _$gTagTreeDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTagTreeData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTagTreeData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTagTreeData.serializer,
        json,
      );
}

abstract class GTagTreeData_myTagRoots
    implements
        Built<GTagTreeData_myTagRoots, GTagTreeData_myTagRootsBuilder>,
        GTagSummary {
  GTagTreeData_myTagRoots._();

  factory GTagTreeData_myTagRoots(
          [void Function(GTagTreeData_myTagRootsBuilder b) updates]) =
      _$GTagTreeData_myTagRoots;

  static void _initializeBuilder(GTagTreeData_myTagRootsBuilder b) =>
      b..G__typename = 'Tag';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get slug;
  @override
  String get displayName;
  @override
  String get path;
  @override
  _i2.GTagRootKind get rootKind;
  @override
  bool get hasChildren;
  @override
  _i2.GTime? get archivedAt;
  BuiltList<GTagTreeData_myTagRoots_children> get children;
  static Serializer<GTagTreeData_myTagRoots> get serializer =>
      _$gTagTreeDataMyTagRootsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTagTreeData_myTagRoots.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTagTreeData_myTagRoots? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTagTreeData_myTagRoots.serializer,
        json,
      );
}

abstract class GTagTreeData_myTagRoots_children
    implements
        Built<GTagTreeData_myTagRoots_children,
            GTagTreeData_myTagRoots_childrenBuilder>,
        GTagSummary {
  GTagTreeData_myTagRoots_children._();

  factory GTagTreeData_myTagRoots_children(
          [void Function(GTagTreeData_myTagRoots_childrenBuilder b) updates]) =
      _$GTagTreeData_myTagRoots_children;

  static void _initializeBuilder(GTagTreeData_myTagRoots_childrenBuilder b) =>
      b..G__typename = 'Tag';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get slug;
  @override
  String get displayName;
  @override
  String get path;
  @override
  _i2.GTagRootKind get rootKind;
  @override
  bool get hasChildren;
  @override
  _i2.GTime? get archivedAt;
  BuiltList<GTagTreeData_myTagRoots_children_children> get children;
  static Serializer<GTagTreeData_myTagRoots_children> get serializer =>
      _$gTagTreeDataMyTagRootsChildrenSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTagTreeData_myTagRoots_children.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTagTreeData_myTagRoots_children? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTagTreeData_myTagRoots_children.serializer,
        json,
      );
}

abstract class GTagTreeData_myTagRoots_children_children
    implements
        Built<GTagTreeData_myTagRoots_children_children,
            GTagTreeData_myTagRoots_children_childrenBuilder>,
        GTagSummary {
  GTagTreeData_myTagRoots_children_children._();

  factory GTagTreeData_myTagRoots_children_children(
      [void Function(GTagTreeData_myTagRoots_children_childrenBuilder b)
          updates]) = _$GTagTreeData_myTagRoots_children_children;

  static void _initializeBuilder(
          GTagTreeData_myTagRoots_children_childrenBuilder b) =>
      b..G__typename = 'Tag';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get slug;
  @override
  String get displayName;
  @override
  String get path;
  @override
  _i2.GTagRootKind get rootKind;
  @override
  bool get hasChildren;
  @override
  _i2.GTime? get archivedAt;
  BuiltList<GTagTreeData_myTagRoots_children_children_children> get children;
  static Serializer<GTagTreeData_myTagRoots_children_children> get serializer =>
      _$gTagTreeDataMyTagRootsChildrenChildrenSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTagTreeData_myTagRoots_children_children.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTagTreeData_myTagRoots_children_children? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTagTreeData_myTagRoots_children_children.serializer,
        json,
      );
}

abstract class GTagTreeData_myTagRoots_children_children_children
    implements
        Built<GTagTreeData_myTagRoots_children_children_children,
            GTagTreeData_myTagRoots_children_children_childrenBuilder>,
        GTagSummary {
  GTagTreeData_myTagRoots_children_children_children._();

  factory GTagTreeData_myTagRoots_children_children_children(
      [void Function(
              GTagTreeData_myTagRoots_children_children_childrenBuilder b)
          updates]) = _$GTagTreeData_myTagRoots_children_children_children;

  static void _initializeBuilder(
          GTagTreeData_myTagRoots_children_children_childrenBuilder b) =>
      b..G__typename = 'Tag';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get slug;
  @override
  String get displayName;
  @override
  String get path;
  @override
  _i2.GTagRootKind get rootKind;
  @override
  bool get hasChildren;
  @override
  _i2.GTime? get archivedAt;
  static Serializer<GTagTreeData_myTagRoots_children_children_children>
      get serializer =>
          _$gTagTreeDataMyTagRootsChildrenChildrenChildrenSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTagTreeData_myTagRoots_children_children_children.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTagTreeData_myTagRoots_children_children_children? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTagTreeData_myTagRoots_children_children_children.serializer,
        json,
      );
}

abstract class GTagChildrenData
    implements Built<GTagChildrenData, GTagChildrenDataBuilder> {
  GTagChildrenData._();

  factory GTagChildrenData([void Function(GTagChildrenDataBuilder b) updates]) =
      _$GTagChildrenData;

  static void _initializeBuilder(GTagChildrenDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GTagChildrenData_tag? get tag;
  static Serializer<GTagChildrenData> get serializer =>
      _$gTagChildrenDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTagChildrenData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTagChildrenData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTagChildrenData.serializer,
        json,
      );
}

abstract class GTagChildrenData_tag
    implements Built<GTagChildrenData_tag, GTagChildrenData_tagBuilder> {
  GTagChildrenData_tag._();

  factory GTagChildrenData_tag(
          [void Function(GTagChildrenData_tagBuilder b) updates]) =
      _$GTagChildrenData_tag;

  static void _initializeBuilder(GTagChildrenData_tagBuilder b) =>
      b..G__typename = 'Tag';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  BuiltList<GTagChildrenData_tag_children> get children;
  static Serializer<GTagChildrenData_tag> get serializer =>
      _$gTagChildrenDataTagSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTagChildrenData_tag.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTagChildrenData_tag? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTagChildrenData_tag.serializer,
        json,
      );
}

abstract class GTagChildrenData_tag_children
    implements
        Built<GTagChildrenData_tag_children,
            GTagChildrenData_tag_childrenBuilder>,
        GTagSummary {
  GTagChildrenData_tag_children._();

  factory GTagChildrenData_tag_children(
          [void Function(GTagChildrenData_tag_childrenBuilder b) updates]) =
      _$GTagChildrenData_tag_children;

  static void _initializeBuilder(GTagChildrenData_tag_childrenBuilder b) =>
      b..G__typename = 'Tag';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get slug;
  @override
  String get displayName;
  @override
  String get path;
  @override
  _i2.GTagRootKind get rootKind;
  @override
  bool get hasChildren;
  @override
  _i2.GTime? get archivedAt;
  BuiltList<GTagChildrenData_tag_children_children> get children;
  static Serializer<GTagChildrenData_tag_children> get serializer =>
      _$gTagChildrenDataTagChildrenSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTagChildrenData_tag_children.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTagChildrenData_tag_children? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTagChildrenData_tag_children.serializer,
        json,
      );
}

abstract class GTagChildrenData_tag_children_children
    implements
        Built<GTagChildrenData_tag_children_children,
            GTagChildrenData_tag_children_childrenBuilder>,
        GTagSummary {
  GTagChildrenData_tag_children_children._();

  factory GTagChildrenData_tag_children_children(
      [void Function(GTagChildrenData_tag_children_childrenBuilder b)
          updates]) = _$GTagChildrenData_tag_children_children;

  static void _initializeBuilder(
          GTagChildrenData_tag_children_childrenBuilder b) =>
      b..G__typename = 'Tag';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get slug;
  @override
  String get displayName;
  @override
  String get path;
  @override
  _i2.GTagRootKind get rootKind;
  @override
  bool get hasChildren;
  @override
  _i2.GTime? get archivedAt;
  BuiltList<GTagChildrenData_tag_children_children_children> get children;
  static Serializer<GTagChildrenData_tag_children_children> get serializer =>
      _$gTagChildrenDataTagChildrenChildrenSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTagChildrenData_tag_children_children.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTagChildrenData_tag_children_children? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTagChildrenData_tag_children_children.serializer,
        json,
      );
}

abstract class GTagChildrenData_tag_children_children_children
    implements
        Built<GTagChildrenData_tag_children_children_children,
            GTagChildrenData_tag_children_children_childrenBuilder>,
        GTagSummary {
  GTagChildrenData_tag_children_children_children._();

  factory GTagChildrenData_tag_children_children_children(
      [void Function(GTagChildrenData_tag_children_children_childrenBuilder b)
          updates]) = _$GTagChildrenData_tag_children_children_children;

  static void _initializeBuilder(
          GTagChildrenData_tag_children_children_childrenBuilder b) =>
      b..G__typename = 'Tag';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get slug;
  @override
  String get displayName;
  @override
  String get path;
  @override
  _i2.GTagRootKind get rootKind;
  @override
  bool get hasChildren;
  @override
  _i2.GTime? get archivedAt;
  static Serializer<GTagChildrenData_tag_children_children_children>
      get serializer => _$gTagChildrenDataTagChildrenChildrenChildrenSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTagChildrenData_tag_children_children_children.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTagChildrenData_tag_children_children_children? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTagChildrenData_tag_children_children_children.serializer,
        json,
      );
}

abstract class GTagBySlugPathData
    implements Built<GTagBySlugPathData, GTagBySlugPathDataBuilder> {
  GTagBySlugPathData._();

  factory GTagBySlugPathData(
          [void Function(GTagBySlugPathDataBuilder b) updates]) =
      _$GTagBySlugPathData;

  static void _initializeBuilder(GTagBySlugPathDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GTagBySlugPathData_tagBySlugPath? get tagBySlugPath;
  static Serializer<GTagBySlugPathData> get serializer =>
      _$gTagBySlugPathDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTagBySlugPathData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTagBySlugPathData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTagBySlugPathData.serializer,
        json,
      );
}

abstract class GTagBySlugPathData_tagBySlugPath
    implements
        Built<GTagBySlugPathData_tagBySlugPath,
            GTagBySlugPathData_tagBySlugPathBuilder>,
        GTagSummary {
  GTagBySlugPathData_tagBySlugPath._();

  factory GTagBySlugPathData_tagBySlugPath(
          [void Function(GTagBySlugPathData_tagBySlugPathBuilder b) updates]) =
      _$GTagBySlugPathData_tagBySlugPath;

  static void _initializeBuilder(GTagBySlugPathData_tagBySlugPathBuilder b) =>
      b..G__typename = 'Tag';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get slug;
  @override
  String get displayName;
  @override
  String get path;
  @override
  _i2.GTagRootKind get rootKind;
  @override
  bool get hasChildren;
  @override
  _i2.GTime? get archivedAt;
  static Serializer<GTagBySlugPathData_tagBySlugPath> get serializer =>
      _$gTagBySlugPathDataTagBySlugPathSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTagBySlugPathData_tagBySlugPath.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTagBySlugPathData_tagBySlugPath? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTagBySlugPathData_tagBySlugPath.serializer,
        json,
      );
}

abstract class GTagSummary {
  String get G__typename;
  String get id;
  String get slug;
  String get displayName;
  String get path;
  _i2.GTagRootKind get rootKind;
  bool get hasChildren;
  _i2.GTime? get archivedAt;
  Map<String, dynamic> toJson();
}

abstract class GTagSummaryData
    implements Built<GTagSummaryData, GTagSummaryDataBuilder>, GTagSummary {
  GTagSummaryData._();

  factory GTagSummaryData([void Function(GTagSummaryDataBuilder b) updates]) =
      _$GTagSummaryData;

  static void _initializeBuilder(GTagSummaryDataBuilder b) =>
      b..G__typename = 'Tag';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get slug;
  @override
  String get displayName;
  @override
  String get path;
  @override
  _i2.GTagRootKind get rootKind;
  @override
  bool get hasChildren;
  @override
  _i2.GTime? get archivedAt;
  static Serializer<GTagSummaryData> get serializer =>
      _$gTagSummaryDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTagSummaryData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTagSummaryData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTagSummaryData.serializer,
        json,
      );
}
