// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i1;

part 'viewer.data.gql.g.dart';

abstract class GViewerData implements Built<GViewerData, GViewerDataBuilder> {
  GViewerData._();

  factory GViewerData([void Function(GViewerDataBuilder b) updates]) =
      _$GViewerData;

  static void _initializeBuilder(GViewerDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GViewerData_viewer? get viewer;
  static Serializer<GViewerData> get serializer => _$gViewerDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GViewerData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GViewerData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GViewerData.serializer,
        json,
      );
}

abstract class GViewerData_viewer
    implements Built<GViewerData_viewer, GViewerData_viewerBuilder> {
  GViewerData_viewer._();

  factory GViewerData_viewer(
          [void Function(GViewerData_viewerBuilder b) updates]) =
      _$GViewerData_viewer;

  static void _initializeBuilder(GViewerData_viewerBuilder b) =>
      b..G__typename = 'User';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get globalUri;
  String get displayName;
  String? get email;
  GViewerData_viewer_homeTag? get homeTag;
  static Serializer<GViewerData_viewer> get serializer =>
      _$gViewerDataViewerSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GViewerData_viewer.serializer,
        this,
      ) as Map<String, dynamic>);

  static GViewerData_viewer? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GViewerData_viewer.serializer,
        json,
      );
}

abstract class GViewerData_viewer_homeTag
    implements
        Built<GViewerData_viewer_homeTag, GViewerData_viewer_homeTagBuilder> {
  GViewerData_viewer_homeTag._();

  factory GViewerData_viewer_homeTag(
          [void Function(GViewerData_viewer_homeTagBuilder b) updates]) =
      _$GViewerData_viewer_homeTag;

  static void _initializeBuilder(GViewerData_viewer_homeTagBuilder b) =>
      b..G__typename = 'Tag';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get slug;
  String get displayName;
  static Serializer<GViewerData_viewer_homeTag> get serializer =>
      _$gViewerDataViewerHomeTagSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GViewerData_viewer_homeTag.serializer,
        this,
      ) as Map<String, dynamic>);

  static GViewerData_viewer_homeTag? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GViewerData_viewer_homeTag.serializer,
        json,
      );
}
