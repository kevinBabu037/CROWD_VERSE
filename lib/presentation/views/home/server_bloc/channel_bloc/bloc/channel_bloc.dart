import 'package:bloc/bloc.dart';
import 'package:crowd_verse/data/models/server/all_channels.dart';
import 'package:crowd_verse/data/repositories/server/server_service.dart';
import 'package:meta/meta.dart';

part 'channel_event.dart';
part 'channel_state.dart';

class ChannelBloc extends Bloc<ChannelEvent, ChannelState> {
  ChannelBloc() : super(ChannelInitial()) {


    on<FechAllChannelsEvent>((event, emit)async {
       emit(ChannelLoadingState());

       List<ChannelModel>? channels = await ServerService().getAllChannelsAndCategory(event.serverID);

       if (channels!=null) {
         emit(ChannelSuccessState(channels: channels));
       }else{
        emit(ChannelErroegState());
       }


    });

  }
}
