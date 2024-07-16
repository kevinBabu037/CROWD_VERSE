import 'package:bloc/bloc.dart';
import 'package:crowd_verse/data/models/server/server_members.dart';
import 'package:crowd_verse/data/repositories/server/server_service.dart';
import 'package:meta/meta.dart';

part 'server_members_event.dart';
part 'server_members_state.dart';

class ServerMembersBloc extends Bloc<ServerMembersEvent, ServerMembersState> {
  ServerMembersBloc() : super(ServerMembersInitial()) {
  
   ServerService serverce =ServerService();


   on<LeaveServerEvent>((event, emit)async{
    bool isLeave = await serverce.leaveFromServer(event.serverId);
    if (isLeave) {
       emit(LeaveServerSuccessState());
    }else{
      emit(LeaveServerErrorssState());
    }
   });


 on<DeleteServerEvent>((event, emit)async {
    bool isLeave = await serverce.deleteServer(event.serverId); 
    if (isLeave) {
       emit(DeleteServerSuccessState());
    }else{
      emit(DeleteServerErrorssState());
    }
 });



    on<GetAllServerMembers>((event, emit)async {

         emit(ServerMembersLoadingState());

      List <ServerMembersModel>? members =  await serverce.getAllServerMembers(event.serverId);

      if (members!=null) {
        emit(ServerMembersSuccessState(members: members));
      }
      if (members==null) {
        ServerMembersEmptyState();
      }

    });
  }
}
