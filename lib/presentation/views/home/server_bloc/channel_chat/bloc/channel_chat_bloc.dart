import 'package:bloc/bloc.dart';
import 'package:crowd_verse/data/models/server/channel_message.dart';
import 'package:crowd_verse/data/repositories/server/server_service.dart';
import 'package:meta/meta.dart';


part 'channel_chat_event.dart';
part 'channel_chat_state.dart';

class ChannelChatBloc extends Bloc<ChannelChatEvent, ChannelChatState> {
  ChannelChatBloc() : super(ChannelChatInitial()) {
   
   ServerService service =ServerService();

   List<ChannelChatModel> channelChat = [];


    on<FechAllChannelMessages>((event, emit)async {


      emit(ChannelChatLoadingState());

      List<ChannelChatModel>? chat = await service.getChannelMessages(event.chanelID);

     if (chat!=null) {
         channelChat = chat.map((e) => ChannelChatModel(content: e.content, dateTime: e.dateTime, userName: e.userName)).toList();
        emit(ChannelChatSuccussState(chat: channelChat));
     }else{
        emit(ChannelChatEmptyState());
     } 
      
    });


    on<ReciveChannelMessageEvent>((event, emit) {
        channelChat.add(event.chat);
        emit(ChannelChatSuccussState(chat: channelChat));
    });



  }
}
