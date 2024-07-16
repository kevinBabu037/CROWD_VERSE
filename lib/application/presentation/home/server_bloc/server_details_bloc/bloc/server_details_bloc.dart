import 'package:bloc/bloc.dart';
import 'package:crowd_verse/data/models/server/server_details.dart';
import 'package:crowd_verse/data/repositories/server/server_service.dart';
import 'package:meta/meta.dart';

part 'server_details_event.dart';
part 'server_details_state.dart';

class ServerDetailsBloc extends Bloc<ServerDetailsEvent, ServerDetailsState> {
  ServerDetailsBloc() : super(ServerDetailsInitial()) {
    on<ServerDetailsFechEvent>((event, emit)async {
       
       emit(ServerDetailsLoadingState());

       ServerDetailsModel? server = await ServerService().getServerDetails(event.serverId);

      if (server!=null) {
        emit(ServerDetailsSuccessState(server: server));
      }
      

    });
  }
}
