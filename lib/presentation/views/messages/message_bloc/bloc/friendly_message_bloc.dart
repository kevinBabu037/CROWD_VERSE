import 'package:bloc/bloc.dart';
import 'package:crowd_verse/data/models/friendly_message/friendly_messages.dart';
import 'package:crowd_verse/data/repositories/flriedly_chat/friendly_chat.dart';
import 'package:meta/meta.dart';
part 'friendly_message_event.dart';
part 'friendly_message_state.dart';

class FriendlyMessageBloc extends Bloc<FriendlyMessageEvent, FriendlyMessageState> {
  FriendlyMessageBloc() : super(FriendlyMessageInitial(model:const [])) {
    List<FriendlyChatModel> allChats =[];
    on<GetAllMessagesEvent>((event, emit)async {

      emit(FriendlyMessageLoaddingState()); 

     List<FriendlyChatModel>? res = await FriendlyChatService().getAllMessages(event.userId);
     
      if (res!=null) {  
        allChats = res.map((e) => FriendlyChatModel(time: e.time, message: e.message, senterId: e.senterId, resrverId: e.resrverId)).toList();
        emit(FriendlyMessageSuccessState(model:allChats)); 
      } 
      if (res==null) {
        emit(FriendlyMessagEmptyState(model:const []));    
      } 
 
    });

  on<ResiveMsgEvent>((event, emit) {
      allChats.add(event.chat); 
      emit(FriendlyMessageSuccessState(model:allChats)); 
  });
   
 
 on<SendMessageEvent>((event, emit) {
   allChats.add(event.chat);
   emit(FriendlyMessageSuccessState(model:allChats)); 

 });





  }
}
