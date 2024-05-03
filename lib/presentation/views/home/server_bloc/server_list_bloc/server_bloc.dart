import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crowd_verse/data/models/server/all_server_model.dart';
import 'package:crowd_verse/data/repositories/server/server_service.dart';
import 'package:meta/meta.dart';

part 'server_event.dart';
part 'server_state.dart';

class ServerBloc extends Bloc<ServerEvent, ServerState> {
  ServerBloc() : super(ServerInitial()) {
    on<GetAllServerEvent>(getAllServerEvent);
  }

    ServerService service = ServerService();


   FutureOr<void> getAllServerEvent(GetAllServerEvent event, Emitter<ServerState> emit)async{

      emit(ServerLoadingState());

      List<ServerModel>? servers = await service.getAllService();
     
    if (servers!=null) {
      emit(ServerSuccessState(servers: servers));
    }
    if (servers==null) {
      emit(ServerEmptyState());
    }

  }
}
