// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (Serializers().toBuilder()
      ..add(FetchPolicy.serializer)
      ..add(GAttachmentOwnerKind.serializer)
      ..add(GChatRoomDetailData.serializer)
      ..add(GChatRoomDetailData_chatRoom.serializer)
      ..add(GChatRoomDetailData_chatRoom_messages.serializer)
      ..add(GChatRoomDetailData_chatRoom_messages_edges.serializer)
      ..add(GChatRoomDetailData_chatRoom_messages_edges_node.serializer)
      ..add(GChatRoomDetailData_chatRoom_messages_edges_node_author.serializer)
      ..add(GChatRoomDetailData_chatRoom_messages_edges_node_replyTo.serializer)
      ..add(GChatRoomDetailData_chatRoom_participants.serializer)
      ..add(GChatRoomDetailData_chatRoom_participants_principal.serializer)
      ..add(GChatRoomDetailData_chatRoom_tags.serializer)
      ..add(GChatRoomDetailReq.serializer)
      ..add(GChatRoomDetailVars.serializer)
      ..add(GChatRoomSummaryData.serializer)
      ..add(GChatRoomSummaryData_participants.serializer)
      ..add(GChatRoomSummaryData_participants_principal.serializer)
      ..add(GChatRoomSummaryData_tags.serializer)
      ..add(GChatRoomSummaryReq.serializer)
      ..add(GChatRoomSummaryVars.serializer)
      ..add(GCommentSummaryData.serializer)
      ..add(GCommentSummaryData_author.serializer)
      ..add(GCommentSummaryData_reactions.serializer)
      ..add(GCommentSummaryReq.serializer)
      ..add(GCommentSummaryVars.serializer)
      ..add(GCreateChatRoomData.serializer)
      ..add(GCreateChatRoomData_createChatRoom.serializer)
      ..add(GCreateChatRoomData_createChatRoom_participants.serializer)
      ..add(
          GCreateChatRoomData_createChatRoom_participants_principal.serializer)
      ..add(GCreateChatRoomData_createChatRoom_tags.serializer)
      ..add(GCreateChatRoomInput.serializer)
      ..add(GCreateChatRoomReq.serializer)
      ..add(GCreateChatRoomVars.serializer)
      ..add(GCreateCommentData.serializer)
      ..add(GCreateCommentData_createComment.serializer)
      ..add(GCreateCommentData_createComment_author.serializer)
      ..add(GCreateCommentData_createComment_reactions.serializer)
      ..add(GCreateCommentInput.serializer)
      ..add(GCreateCommentReq.serializer)
      ..add(GCreateCommentVars.serializer)
      ..add(GCreatePostData.serializer)
      ..add(GCreatePostData_createPost.serializer)
      ..add(GCreatePostData_createPost_author.serializer)
      ..add(GCreatePostData_createPost_comments.serializer)
      ..add(GCreatePostData_createPost_comments_edges.serializer)
      ..add(GCreatePostData_createPost_comments_edges_node.serializer)
      ..add(GCreatePostData_createPost_reactions.serializer)
      ..add(GCreatePostInput.serializer)
      ..add(GCreatePostReq.serializer)
      ..add(GCreatePostVars.serializer)
      ..add(GCreateTagInput.serializer)
      ..add(GCreateTaskInput.serializer)
      ..add(GDecisionStatus.serializer)
      ..add(GDevicePlatform.serializer)
      ..add(GEditPostInput.serializer)
      ..add(GEditTaskInput.serializer)
      ..add(GEndImpersonationData.serializer)
      ..add(GEndImpersonationData_endImpersonation.serializer)
      ..add(GEndImpersonationData_endImpersonation_acting.serializer)
      ..add(GEndImpersonationData_endImpersonation_effective.serializer)
      ..add(GEndImpersonationReq.serializer)
      ..add(GEndImpersonationVars.serializer)
      ..add(GGrantTagInput.serializer)
      ..add(GHealthData.serializer)
      ..add(GHealthReq.serializer)
      ..add(GHealthVars.serializer)
      ..add(GImpersonateData.serializer)
      ..add(GImpersonateData_impersonate.serializer)
      ..add(GImpersonateData_impersonate_acting.serializer)
      ..add(GImpersonateData_impersonate_effective.serializer)
      ..add(GImpersonateReq.serializer)
      ..add(GImpersonateVars.serializer)
      ..add(GIssueAttachmentUploadInput.serializer)
      ..add(GJSON.serializer)
      ..add(GLoginData.serializer)
      ..add(GLoginData_login.serializer)
      ..add(GLoginData_login_viewer.serializer)
      ..add(GLoginReq.serializer)
      ..add(GLoginVars.serializer)
      ..add(GLogoutData.serializer)
      ..add(GLogoutReq.serializer)
      ..add(GLogoutVars.serializer)
      ..add(GMarkAllNotificationsReadData.serializer)
      ..add(GMarkAllNotificationsReadReq.serializer)
      ..add(GMarkAllNotificationsReadVars.serializer)
      ..add(GMarkNotificationReadData.serializer)
      ..add(GMarkNotificationReadReq.serializer)
      ..add(GMarkNotificationReadVars.serializer)
      ..add(GMarkPostReadData.serializer)
      ..add(GMarkPostReadData_markPostRead.serializer)
      ..add(GMarkPostReadReq.serializer)
      ..add(GMarkPostReadVars.serializer)
      ..add(GMessageAddedData.serializer)
      ..add(GMessageAddedData_messageAdded.serializer)
      ..add(GMessageAddedData_messageAdded_author.serializer)
      ..add(GMessageAddedData_messageAdded_replyTo.serializer)
      ..add(GMessageAddedReq.serializer)
      ..add(GMessageAddedVars.serializer)
      ..add(GMessageSummaryData.serializer)
      ..add(GMessageSummaryData_author.serializer)
      ..add(GMessageSummaryData_replyTo.serializer)
      ..add(GMessageSummaryReq.serializer)
      ..add(GMessageSummaryVars.serializer)
      ..add(GNotificationFilter.serializer)
      ..add(GNotificationReason.serializer)
      ..add(GNotificationReceivedData.serializer)
      ..add(GNotificationReceivedData_notificationReceived.serializer)
      ..add(GNotificationReceivedData_notificationReceived_sourceTag.serializer)
      ..add(GNotificationReceivedData_notificationReceived_source__asComment
          .serializer)
      ..add(GNotificationReceivedData_notificationReceived_source__asMessage
          .serializer)
      ..add(GNotificationReceivedData_notificationReceived_source__asPost
          .serializer)
      ..add(GNotificationReceivedData_notificationReceived_source__asTask
          .serializer)
      ..add(GNotificationReceivedData_notificationReceived_source__base
          .serializer)
      ..add(GNotificationReceivedReq.serializer)
      ..add(GNotificationReceivedVars.serializer)
      ..add(GNotificationSummaryData.serializer)
      ..add(GNotificationSummaryData_sourceTag.serializer)
      ..add(GNotificationSummaryData_source__asComment.serializer)
      ..add(GNotificationSummaryData_source__asMessage.serializer)
      ..add(GNotificationSummaryData_source__asPost.serializer)
      ..add(GNotificationSummaryData_source__asTask.serializer)
      ..add(GNotificationSummaryData_source__base.serializer)
      ..add(GNotificationSummaryReq.serializer)
      ..add(GNotificationSummaryVars.serializer)
      ..add(GNotificationUrgency.serializer)
      ..add(GNotificationsInboxData.serializer)
      ..add(GNotificationsInboxData_notifications.serializer)
      ..add(GNotificationsInboxData_notifications_edges.serializer)
      ..add(GNotificationsInboxData_notifications_edges_node.serializer)
      ..add(
          GNotificationsInboxData_notifications_edges_node_sourceTag.serializer)
      ..add(GNotificationsInboxData_notifications_edges_node_source__asComment
          .serializer)
      ..add(GNotificationsInboxData_notifications_edges_node_source__asMessage
          .serializer)
      ..add(GNotificationsInboxData_notifications_edges_node_source__asPost
          .serializer)
      ..add(GNotificationsInboxData_notifications_edges_node_source__asTask
          .serializer)
      ..add(GNotificationsInboxData_notifications_edges_node_source__base
          .serializer)
      ..add(GNotificationsInboxReq.serializer)
      ..add(GNotificationsInboxVars.serializer)
      ..add(GPermissionBundle.serializer)
      ..add(GPostChangedData.serializer)
      ..add(GPostChangedData_postChanged.serializer)
      ..add(GPostChangedData_postChanged_author.serializer)
      ..add(GPostChangedData_postChanged_comments.serializer)
      ..add(GPostChangedData_postChanged_comments_edges.serializer)
      ..add(GPostChangedData_postChanged_comments_edges_node.serializer)
      ..add(GPostChangedData_postChanged_reactions.serializer)
      ..add(GPostChangedReq.serializer)
      ..add(GPostChangedVars.serializer)
      ..add(GPostDetailData.serializer)
      ..add(GPostDetailData_post.serializer)
      ..add(GPostDetailData_post_author.serializer)
      ..add(GPostDetailData_post_comments.serializer)
      ..add(GPostDetailData_post_comments_edges.serializer)
      ..add(GPostDetailData_post_comments_edges_node.serializer)
      ..add(GPostDetailData_post_comments_edges_node_author.serializer)
      ..add(GPostDetailData_post_comments_edges_node_reactions.serializer)
      ..add(GPostDetailData_post_myPermissions.serializer)
      ..add(GPostDetailData_post_reactions.serializer)
      ..add(GPostDetailData_post_tags.serializer)
      ..add(GPostDetailData_post_tags_tag.serializer)
      ..add(GPostDetailReq.serializer)
      ..add(GPostDetailVars.serializer)
      ..add(GPostSort.serializer)
      ..add(GPostSummaryData.serializer)
      ..add(GPostSummaryData_author.serializer)
      ..add(GPostSummaryData_comments.serializer)
      ..add(GPostSummaryData_comments_edges.serializer)
      ..add(GPostSummaryData_comments_edges_node.serializer)
      ..add(GPostSummaryData_reactions.serializer)
      ..add(GPostSummaryReq.serializer)
      ..add(GPostSummaryVars.serializer)
      ..add(GPostTagInput.serializer)
      ..add(GPostsForTagData.serializer)
      ..add(GPostsForTagData_tag.serializer)
      ..add(GPostsForTagData_tag_posts.serializer)
      ..add(GPostsForTagData_tag_posts_edges.serializer)
      ..add(GPostsForTagData_tag_posts_edges_node.serializer)
      ..add(GPostsForTagData_tag_posts_edges_node_author.serializer)
      ..add(GPostsForTagData_tag_posts_edges_node_comments.serializer)
      ..add(GPostsForTagData_tag_posts_edges_node_comments_edges.serializer)
      ..add(
          GPostsForTagData_tag_posts_edges_node_comments_edges_node.serializer)
      ..add(GPostsForTagData_tag_posts_edges_node_reactions.serializer)
      ..add(GPostsForTagReq.serializer)
      ..add(GPostsForTagVars.serializer)
      ..add(GPrincipalKind.serializer)
      ..add(GPrincipalStatus.serializer)
      ..add(GReactToPostData.serializer)
      ..add(GReactToPostData_reactToPost.serializer)
      ..add(GReactToPostData_reactToPost_reactions.serializer)
      ..add(GReactToPostReq.serializer)
      ..add(GReactToPostVars.serializer)
      ..add(GRegisterDeviceTokenData.serializer)
      ..add(GRegisterDeviceTokenReq.serializer)
      ..add(GRegisterDeviceTokenVars.serializer)
      ..add(GSearchData.serializer)
      ..add(GSearchData_search.serializer)
      ..add(GSearchData_search_edges.serializer)
      ..add(GSearchData_search_edges_node__asComment.serializer)
      ..add(GSearchData_search_edges_node__asPost.serializer)
      ..add(GSearchData_search_edges_node__asPost_author.serializer)
      ..add(GSearchData_search_edges_node__base.serializer)
      ..add(GSearchKind.serializer)
      ..add(GSearchReq.serializer)
      ..add(GSearchTagsData.serializer)
      ..add(GSearchTagsData_searchTags.serializer)
      ..add(GSearchTagsData_searchTags_tag.serializer)
      ..add(GSearchTagsReq.serializer)
      ..add(GSearchTagsVars.serializer)
      ..add(GSearchVars.serializer)
      ..add(GSendMessageData.serializer)
      ..add(GSendMessageData_sendMessage.serializer)
      ..add(GSendMessageData_sendMessage_author.serializer)
      ..add(GSendMessageData_sendMessage_replyTo.serializer)
      ..add(GSendMessageInput.serializer)
      ..add(GSendMessageReq.serializer)
      ..add(GSendMessageVars.serializer)
      ..add(GSubscribeTagInput.serializer)
      ..add(GSubscriptionUrgency.serializer)
      ..add(GTagChildrenData.serializer)
      ..add(GTagChildrenData_tag.serializer)
      ..add(GTagChildrenData_tag_children.serializer)
      ..add(GTagChildrenData_tag_children_children.serializer)
      ..add(GTagChildrenReq.serializer)
      ..add(GTagChildrenVars.serializer)
      ..add(GTagRootKind.serializer)
      ..add(GTagSummaryData.serializer)
      ..add(GTagSummaryReq.serializer)
      ..add(GTagSummaryVars.serializer)
      ..add(GTagTreeData.serializer)
      ..add(GTagTreeData_myTagRoots.serializer)
      ..add(GTagTreeData_myTagRoots_children.serializer)
      ..add(GTagTreeData_myTagRoots_children_children.serializer)
      ..add(GTagTreeData_myTagRoots_children_children_children.serializer)
      ..add(GTagTreeReq.serializer)
      ..add(GTagTreeVars.serializer)
      ..add(GTaskStatus.serializer)
      ..add(GTaskTagInput.serializer)
      ..add(GTime.serializer)
      ..add(GUnreactToPostData.serializer)
      ..add(GUnreactToPostData_unreactToPost.serializer)
      ..add(GUnreactToPostData_unreactToPost_reactions.serializer)
      ..add(GUnreactToPostReq.serializer)
      ..add(GUnreactToPostVars.serializer)
      ..add(GUnregisterDeviceTokenData.serializer)
      ..add(GUnregisterDeviceTokenReq.serializer)
      ..add(GUnregisterDeviceTokenVars.serializer)
      ..add(GViewerData.serializer)
      ..add(GViewerData_viewer.serializer)
      ..add(GViewerData_viewer_homeTag.serializer)
      ..add(GViewerImpersonationStateData.serializer)
      ..add(GViewerImpersonationStateData_viewerImpersonationState.serializer)
      ..add(GViewerImpersonationStateData_viewerImpersonationState_acting
          .serializer)
      ..add(GViewerImpersonationStateData_viewerImpersonationState_effective
          .serializer)
      ..add(GViewerImpersonationStateReq.serializer)
      ..add(GViewerImpersonationStateVars.serializer)
      ..add(GViewerReq.serializer)
      ..add(GViewerVars.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GChatRoomDetailData_chatRoom_messages_edges)
          ]),
          () => ListBuilder<GChatRoomDetailData_chatRoom_messages_edges>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GChatRoomDetailData_chatRoom_tags)]),
          () => ListBuilder<GChatRoomDetailData_chatRoom_tags>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GChatRoomDetailData_chatRoom_participants)
          ]),
          () => ListBuilder<GChatRoomDetailData_chatRoom_participants>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GChatRoomSummaryData_tags)]),
          () => ListBuilder<GChatRoomSummaryData_tags>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GChatRoomSummaryData_participants)]),
          () => ListBuilder<GChatRoomSummaryData_participants>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GCommentSummaryData_reactions)]),
          () => ListBuilder<GCommentSummaryData_reactions>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GCreateChatRoomData_createChatRoom_tags)]),
          () => ListBuilder<GCreateChatRoomData_createChatRoom_tags>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GCreateChatRoomData_createChatRoom_participants)
          ]),
          () => ListBuilder<GCreateChatRoomData_createChatRoom_participants>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GCreateCommentData_createComment_reactions)
          ]),
          () => ListBuilder<GCreateCommentData_createComment_reactions>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GCreatePostData_createPost_comments_edges)
          ]),
          () => ListBuilder<GCreatePostData_createPost_comments_edges>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GCreatePostData_createPost_reactions)]),
          () => ListBuilder<GCreatePostData_createPost_reactions>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GNotificationReason)]),
          () => ListBuilder<GNotificationReason>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GNotificationsInboxData_notifications_edges)
          ]),
          () => ListBuilder<GNotificationsInboxData_notifications_edges>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GPostChangedData_postChanged_comments_edges)
          ]),
          () => ListBuilder<GPostChangedData_postChanged_comments_edges>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GPostChangedData_postChanged_reactions)]),
          () => ListBuilder<GPostChangedData_postChanged_reactions>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GPostDetailData_post_comments_edges)]),
          () => ListBuilder<GPostDetailData_post_comments_edges>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GPostDetailData_post_comments_edges_node_reactions)
          ]),
          () =>
              ListBuilder<GPostDetailData_post_comments_edges_node_reactions>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GPostDetailData_post_reactions)]),
          () => ListBuilder<GPostDetailData_post_reactions>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GPostDetailData_post_tags)]),
          () => ListBuilder<GPostDetailData_post_tags>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GPostSummaryData_comments_edges)]),
          () => ListBuilder<GPostSummaryData_comments_edges>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GPostSummaryData_reactions)]),
          () => ListBuilder<GPostSummaryData_reactions>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GPostTagInput)]),
          () => ListBuilder<GPostTagInput>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GPostsForTagData_tag_posts_edges)]),
          () => ListBuilder<GPostsForTagData_tag_posts_edges>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GPostsForTagData_tag_posts_edges_node_comments_edges)
          ]),
          () => ListBuilder<
              GPostsForTagData_tag_posts_edges_node_comments_edges>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GPostsForTagData_tag_posts_edges_node_reactions)
          ]),
          () => ListBuilder<GPostsForTagData_tag_posts_edges_node_reactions>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GReactToPostData_reactToPost_reactions)]),
          () => ListBuilder<GReactToPostData_reactToPost_reactions>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GSearchData_search_edges)]),
          () => ListBuilder<GSearchData_search_edges>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GSearchTagsData_searchTags)]),
          () => ListBuilder<GSearchTagsData_searchTags>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GTagChildrenData_tag_children)]),
          () => ListBuilder<GTagChildrenData_tag_children>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GTagChildrenData_tag_children_children)]),
          () => ListBuilder<GTagChildrenData_tag_children_children>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GTagTreeData_myTagRoots)]),
          () => ListBuilder<GTagTreeData_myTagRoots>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GTagTreeData_myTagRoots_children)]),
          () => ListBuilder<GTagTreeData_myTagRoots_children>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GTagTreeData_myTagRoots_children_children)
          ]),
          () => ListBuilder<GTagTreeData_myTagRoots_children_children>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GTagTreeData_myTagRoots_children_children_children)
          ]),
          () =>
              ListBuilder<GTagTreeData_myTagRoots_children_children_children>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(GTaskTagInput)]),
          () => ListBuilder<GTaskTagInput>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(GUnreactToPostData_unreactToPost_reactions)
          ]),
          () => ListBuilder<GUnreactToPostData_unreactToPost_reactions>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>()))
    .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
