// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:ferry_exec/ferry_exec.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    show OperationSerializer;
import 'package:pulse/graphql/__generated__/schema.schema.gql.dart'
    show
        GCreateChatRoomInput,
        GCreateCommentInput,
        GCreatePostInput,
        GCreateTagInput,
        GCreateTaskInput,
        GDecisionStatus,
        GEditPostInput,
        GEditTaskInput,
        GGrantTagInput,
        GJSON,
        GNotificationFilter,
        GNotificationReason,
        GNotificationUrgency,
        GPermissionBundle,
        GPostSort,
        GPostTagInput,
        GPrincipalKind,
        GPrincipalStatus,
        GSearchKind,
        GSendMessageInput,
        GSubscribeTagInput,
        GSubscriptionUrgency,
        GTagRootKind,
        GTaskStatus,
        GTaskTagInput,
        GTime;
import 'package:pulse/graphql/operations/__generated__/health.data.gql.dart'
    show GHealthData;
import 'package:pulse/graphql/operations/__generated__/health.req.gql.dart'
    show GHealthReq;
import 'package:pulse/graphql/operations/__generated__/health.var.gql.dart'
    show GHealthVars;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GCreateChatRoomInput,
  GCreateCommentInput,
  GCreatePostInput,
  GCreateTagInput,
  GCreateTaskInput,
  GDecisionStatus,
  GEditPostInput,
  GEditTaskInput,
  GGrantTagInput,
  GHealthData,
  GHealthReq,
  GHealthVars,
  GJSON,
  GNotificationFilter,
  GNotificationReason,
  GNotificationUrgency,
  GPermissionBundle,
  GPostSort,
  GPostTagInput,
  GPrincipalKind,
  GPrincipalStatus,
  GSearchKind,
  GSendMessageInput,
  GSubscribeTagInput,
  GSubscriptionUrgency,
  GTagRootKind,
  GTaskStatus,
  GTaskTagInput,
  GTime,
])
final Serializers serializers = _serializersBuilder.build();
