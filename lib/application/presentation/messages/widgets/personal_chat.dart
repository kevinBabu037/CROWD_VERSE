import 'package:crowd_verse/data/models/friendly_message/friendly_messages.dart';
import 'package:crowd_verse/data/models/friends/friends_model.dart';
import 'package:crowd_verse/data/repositories/flriedly_chat/friendly_chat.dart';
import 'package:crowd_verse/data/secure_storage/secure_storage.dart';
import 'package:crowd_verse/application/utils/core/color.dart';
import 'package:crowd_verse/application/utils/core/functions.dart';
import 'package:crowd_verse/application/utils/core/height_width.dart';
import 'package:crowd_verse/application/utils/core/images.dart';
import 'package:crowd_verse/application/presentation/messages/message_bloc/bloc/friendly_message_bloc.dart';
import 'package:crowd_verse/application/presentation/messages/widgets/chat_other_widget.dart';
import 'package:crowd_verse/application/presentation/messages/widgets/chat_self_widget.dart';
import 'package:crowd_verse/application/presentation/messages/widgets/chat_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalChat extends StatefulWidget {
  final FriendsModel data;
  const PersonalChat({
    super.key,
    required this.data,
  });

  @override
  State<PersonalChat> createState() => _PersonalChatState();
}

FriendlyChatService service = FriendlyChatService();

class _PersonalChatState extends State<PersonalChat> {
  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<FriendlyMessageBloc>().add(GetAllMessagesEvent(userId: widget.data.userId!));
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kClrProfileScafold,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: widget.data.profilePhoto != null
                  ? NetworkImage(widget.data.profilePhoto!)
                  : AssetImage(kDefaultProfilePic) as ImageProvider,
            ),
            kWidth15,
            Text(widget.data.name),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<FriendlyMessageBloc, FriendlyMessageState>(
              builder: (context, state) {
                if (state is FriendlyMessageLoaddingState) {
                  return Center(child: kCircularProgressIndicator);
                }
                if (state is FriendlyMessageSuccessState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (scrollController.hasClients) {
                      scrollController.jumpTo(scrollController.position.maxScrollExtent);
                    }
                  });
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: state.model!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data = state.model![index];
                      final String formattedDate = formatDate(data.time);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index == 0 || formatDate(state.model![index - 1].time) != formattedDate)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Text(formattedDate, style: const TextStyle(color: kClrBlack)),
                              ),
                            ),
                          if (data.senterId == widget.data.userId)
                            ChatTextOtherstWidget(data: widget.data, chat: data, date: formattedDate)
                          else
                            ChatTxtSelf(data: data),
                        ],
                      );
                    },
                  );
                }
                if (state is FriendlyMessagEmptyState) {
                  return const Center(child: Text('No messages'));
                }
                return const SizedBox();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChatTextFormField(
              controller: messageController,
              onPressed: () async {
                if (messageController.text.trim().isNotEmpty) {
                  String senderId = await SecureStorage().readSecureData('UserID');
                  // ignore: use_build_context_synchronously
                  await service.sendMessage(widget.data.userId!, messageController.text, context);

                  final chat = FriendlyChatModel(
                    time: DateTime.now().toString(),
                    message: messageController.text,
                    senterId: senderId,
                    resrverId: widget.data.userId!,
                  );

                  // ignore: use_build_context_synchronously
                  context.read<FriendlyMessageBloc>().add(SendMessageEvent(chat: chat));
                  if (scrollController.hasClients) {
                    scrollController.jumpTo(scrollController.position.maxScrollExtent);
                  }
                  messageController.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
