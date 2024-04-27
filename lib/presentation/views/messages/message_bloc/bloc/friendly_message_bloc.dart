import 'package:bloc/bloc.dart';
import 'package:crowd_verse/data/models/friendly_message/friendly_messages.dart';
import 'package:crowd_verse/data/repositories/flriedly_chat/friendly_chat.dart';
import 'package:meta/meta.dart';
part 'friendly_message_event.dart';
part 'friendly_message_state.dart';

class FriendlyMessageBloc extends Bloc<FriendlyMessageEvent, FriendlyMessageState> {
  FriendlyMessageBloc() : super(FriendlyMessageInitial()) {

    on<GetAllMessagesEvent>((event, emit)async {

      emit(FriendlyMessageLoaddingState()); 

     List<FriendlyChatModel>? res = await FriendlyChatService().getAllMessages(event.userId);

      if (res!=null) {
        emit(FriendlyMessageSuccessState(model:res));
      }
      if (res==null) {
        emit(FriendlyMessagEmptyState());
      }
    });
  }
}
