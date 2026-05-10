// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pulse/graphql/__generated__/schema.schema.gql.dart' as _i1;
import 'package:pulse/graphql/__generated__/serializers.gql.dart' as _i2;

part 'health.data.gql.g.dart';

abstract class GHealthData implements Built<GHealthData, GHealthDataBuilder> {
  GHealthData._();

  factory GHealthData([void Function(GHealthDataBuilder b) updates]) =
      _$GHealthData;

  static void _initializeBuilder(GHealthDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get health;
  _i1.GTime get serverTime;
  static Serializer<GHealthData> get serializer => _$gHealthDataSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GHealthData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GHealthData? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GHealthData.serializer,
        json,
      );
}
