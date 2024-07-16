import 'package:crowd_verse/data/models/server/all_channels.dart';
import 'package:crowd_verse/data/repositories/flriedly_chat/friendly_chat.dart';
import 'package:crowd_verse/application/utils/core/color.dart';
import 'package:crowd_verse/application/utils/core/functions.dart';
import 'package:crowd_verse/application/utils/core/height_width.dart';
import 'package:crowd_verse/application/utils/core/images.dart';
import 'package:crowd_verse/application/presentation/home/server_bloc/channel_chat/bloc/channel_chat_bloc.dart';
import 'package:crowd_verse/application/presentation/messages/widgets/chat_textform_field.dart';
import 'package:crowd_verse/application/widgets/costum_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChannelChat extends StatelessWidget {
  ChannelChat({super.key, required this.chanel, required this.serverID});
  final Channel chanel;
  final String serverID;
  final FriendlyChatService service = FriendlyChatService();
  final TextEditingController msgConttroller = TextEditingController();
  final ScrollController scrollController = ScrollController();

 
  @override
  Widget build(BuildContext context) {
    context.read<ChannelChatBloc>().add(FechAllChannelMessages(chanelID: chanel.channelId));

    return Scaffold(
      backgroundColor: kClrProfileScafold,
      appBar: CustomAppBar(
        title: ' #${chanel.name}',
        icon: Icons.arrow_back,
        onPressed: () => Navigator.pop(context),
      ),
      body: BlocBuilder<ChannelChatBloc, ChannelChatState>(
        builder: (context, state) {
          if (state is ChannelChatLoadingState) {
            return Center(child: kCircularProgressIndicator);
          }
          if (state is ChannelChatSuccussState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              scrollController.jumpTo(scrollController.position.maxScrollExtent);
            });

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: state.chat.length,
                    itemBuilder: (context, index) {
                      final data = state.chat[index];
                      String formattedDate = formatDateHeader(data.dateTime!);
                      String timeDate =kChannelMessageFormater(data.dateTime!);

                      // Determine if a date header is needed
                      bool showHeader = index == 0 || formatDateHeader(state.chat[index - 1].dateTime!) != formattedDate;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showHeader) 
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Text(
                                  formattedDate,
                                  style:const TextStyle(color: kClrBlack),
                                ),
                              ),  
                            ),
                          ListTile(
                            leading: CircleAvatar(
                              radius: 17,
                              backgroundImage: data.userProfilePic != null
                                  ? NetworkImage(data.userProfilePic!)
                                  : AssetImage(kDefaultProfilePic) as ImageProvider,
                            ), 
                            title: Row(
                              children: [  
                                 Text(data.userName!),
                                kWidth10,
                                 Text(timeDate, style: const TextStyle(fontSize: 13, color: kClrGrey)),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: kClrWhite,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10), 
                                    child: Text(data.content!, style: const TextStyle(fontSize: 15.5)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                kHeight80,
              ],
            );
          }
          if (state is ChannelChatEmptyState) {
            return const Center(child: Text('No Messages'));
          }

          return const SizedBox();
        },
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ChatTextFormField(
          controller: msgConttroller,
          onPressed: () async {
            if (msgConttroller.text.trim().isNotEmpty) {
              await service.sendMessageInChannel(channelID: chanel.channelId, serverID: serverID, message: msgConttroller.text);
              scrollController.jumpTo(scrollController.position.maxScrollExtent);
              msgConttroller.clear();
            }
          }, 
        ),
      ),
    );
  }
}
