// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i1;

part 'mention_hover.data.gql.g.dart';

abstract class GMentionHoverUserData
    implements Built<GMentionHoverUserData, GMentionHoverUserDataBuilder> {
  GMentionHoverUserData._();

  factory GMentionHoverUserData(
          [void Function(GMentionHoverUserDataBuilder b) updates]) =
      _$GMentionHoverUserData;

  static void _initializeBuilder(GMentionHoverUserDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GMentionHoverUserData_userByHandle? get userByHandle;
  static Serializer<GMentionHoverUserData> get serializer =>
      _$gMentionHoverUserDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionHoverUserData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionHoverUserData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionHoverUserData.serializer,
        json,
      );
}

abstract class GMentionHoverUserData_userByHandle
    implements
        Built<GMentionHoverUserData_userByHandle,
            GMentionHoverUserData_userByHandleBuilder> {
  GMentionHoverUserData_userByHandle._();

  factory GMentionHoverUserData_userByHandle(
      [void Function(GMentionHoverUserData_userByHandleBuilder b)
          updates]) = _$GMentionHoverUserData_userByHandle;

  static void _initializeBuilder(GMentionHoverUserData_userByHandleBuilder b) =>
      b..G__typename = 'User';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get displayName;
  GMentionHoverUserData_userByHandle_homeTag? get homeTag;
  static Serializer<GMentionHoverUserData_userByHandle> get serializer =>
      _$gMentionHoverUserDataUserByHandleSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionHoverUserData_userByHandle.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionHoverUserData_userByHandle? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionHoverUserData_userByHandle.serializer,
        json,
      );
}

abstract class GMentionHoverUserData_userByHandle_homeTag
    implements
        Built<GMentionHoverUserData_userByHandle_homeTag,
            GMentionHoverUserData_userByHandle_homeTagBuilder> {
  GMentionHoverUserData_userByHandle_homeTag._();

  factory GMentionHoverUserData_userByHandle_homeTag(
      [void Function(GMentionHoverUserData_userByHandle_homeTagBuilder b)
          updates]) = _$GMentionHoverUserData_userByHandle_homeTag;

  static void _initializeBuilder(
          GMentionHoverUserData_userByHandle_homeTagBuilder b) =>
      b..G__typename = 'Tag';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get slug;
  String get path;
  static Serializer<GMentionHoverUserData_userByHandle_homeTag>
      get serializer => _$gMentionHoverUserDataUserByHandleHomeTagSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionHoverUserData_userByHandle_homeTag.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionHoverUserData_userByHandle_homeTag? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionHoverUserData_userByHandle_homeTag.serializer,
        json,
      );
}

abstract class GMentionHoverTagData
    implements Built<GMentionHoverTagData, GMentionHoverTagDataBuilder> {
  GMentionHoverTagData._();

  factory GMentionHoverTagData(
          [void Function(GMentionHoverTagDataBuilder b) updates]) =
      _$GMentionHoverTagData;

  static void _initializeBuilder(GMentionHoverTagDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GMentionHoverTagData_tagBySlugPath? get tagBySlugPath;
  static Serializer<GMentionHoverTagData> get serializer =>
      _$gMentionHoverTagDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionHoverTagData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionHoverTagData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionHoverTagData.serializer,
        json,
      );
}

abstract class GMentionHoverTagData_tagBySlugPath
    implements
        Built<GMentionHoverTagData_tagBySlugPath,
            GMentionHoverTagData_tagBySlugPathBuilder> {
  GMentionHoverTagData_tagBySlugPath._();

  factory GMentionHoverTagData_tagBySlugPath(
      [void Function(GMentionHoverTagData_tagBySlugPathBuilder b)
          updates]) = _$GMentionHoverTagData_tagBySlugPath;

  static void _initializeBuilder(GMentionHoverTagData_tagBySlugPathBuilder b) =>
      b..G__typename = 'Tag';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get slug;
  String get displayName;
  String get path;
  GMentionHoverTagData_tagBySlugPath_parent? get parent;
  static Serializer<GMentionHoverTagData_tagBySlugPath> get serializer =>
      _$gMentionHoverTagDataTagBySlugPathSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionHoverTagData_tagBySlugPath.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionHoverTagData_tagBySlugPath? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionHoverTagData_tagBySlugPath.serializer,
        json,
      );
}

abstract class GMentionHoverTagData_tagBySlugPath_parent
    implements
        Built<GMentionHoverTagData_tagBySlugPath_parent,
            GMentionHoverTagData_tagBySlugPath_parentBuilder> {
  GMentionHoverTagData_tagBySlugPath_parent._();

  factory GMentionHoverTagData_tagBySlugPath_parent(
      [void Function(GMentionHoverTagData_tagBySlugPath_parentBuilder b)
          updates]) = _$GMentionHoverTagData_tagBySlugPath_parent;

  static void _initializeBuilder(
          GMentionHoverTagData_tagBySlugPath_parentBuilder b) =>
      b..G__typename = 'Tag';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get displayName;
  static Serializer<GMentionHoverTagData_tagBySlugPath_parent> get serializer =>
      _$gMentionHoverTagDataTagBySlugPathParentSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMentionHoverTagData_tagBySlugPath_parent.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMentionHoverTagData_tagBySlugPath_parent? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMentionHoverTagData_tagBySlugPath_parent.serializer,
        json,
      );
}
