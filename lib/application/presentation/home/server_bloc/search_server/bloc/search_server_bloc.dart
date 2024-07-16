import 'package:bloc/bloc.dart';
import 'package:crowd_verse/data/models/server/search_server.dart';
import 'package:crowd_verse/data/repositories/server/server_service.dart';
import 'package:meta/meta.dart';

part 'search_server_event.dart';
part 'search_server_state.dart';

class SearchServerBloc extends Bloc<SearchServerEvent, SearchServerState> {
  SearchServerBloc() : super(SearchServerInitial()) {
    on<SearchAllServerEvent>((event, emit)async {
       emit(SearchServerLoadingState());
    
    await Future.delayed(const Duration(milliseconds:700)); 
    List<SearchAllServerModel>? servers = await ServerService().searchAllServers(event.searchTxt);

    if (servers!=null) {
      emit(SearchServerSuccessState(server: servers));
    } 
    if(servers == null|| servers.isEmpty){
      emit(SearchServerEmptyState());
    }
    });


  
  }
}
