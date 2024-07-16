
import 'package:crowd_verse/data/models/server/all_server_model.dart';
import 'package:crowd_verse/application/utils/core/color.dart';
import 'package:crowd_verse/application/utils/core/functions.dart';
import 'package:crowd_verse/application/utils/core/height_width.dart';
import 'package:crowd_verse/application/presentation/home/cubit/selected_server_border.dart';
import 'package:crowd_verse/application/presentation/home/server_bloc/server_details_bloc/bloc/server_details_bloc.dart';
import 'package:crowd_verse/application/presentation/home/server_bloc/server_list_bloc/server_bloc.dart';
import 'package:crowd_verse/application/presentation/home/widgets/search_server_widget.dart';
import 'package:crowd_verse/application/presentation/home/widgets/show_dialog_crete_server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServerListWidget extends StatefulWidget {
  const ServerListWidget({
    super.key,
    required this.screenSize,
  });

  final Size screenSize; 
 
  @override
  State<ServerListWidget> createState() => _ServerListWidgetState();
}

class _ServerListWidgetState extends State<ServerListWidget> {
 
@override
  void initState() {
    context.read<ServerBloc>().add(GetAllServerEvent());
   
    super.initState();
  }
  @override
  Widget build(BuildContext context){

    return BlocBuilder<ServerListCubit, int>(
      builder: (context, selectedIndex) { 
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          width: widget.screenSize.width * 0.2,
          height: double.infinity, 
          color: kClrLiteBlue, 
          child: Column( 
            children: [ 
              BlocBuilder<ServerBloc, ServerState>(
                builder: (context, state) {
                  if (state is ServerLoadingState) {
                     Center(child: kCircularProgressIndicator,); 
                  }
               if (state is ServerSuccessState) { 
                   return Expanded(
                     child: ListView.separated( 
                       itemBuilder: (context, index) {
                        
                         ServerModel data = state.servers![index];  
                           String serverName = kServerNameFormter(data.name!);
                         return GestureDetector( 
                           onTap: () {                                           
                           context.read<ServerDetailsBloc>().add(ServerDetailsFechEvent(serverId:data.serverId!));    
                            context.read<ServerListCubit>().selectItem(index); 
                           },
                           child: Container(  
                             decoration: BoxDecoration( 
                               border: Border(
                                 left: BorderSide(
                                   width:  selectedIndex == index ? 6.0 : 0, 
                                   color: kClrBlack.withOpacity(0.6),  
                                 ), 
                               ), 
                             ), 
                             child: data.serverIcon!=null?CircleAvatar(
                              radius: 25,
                              backgroundImage:NetworkImage(data.serverIcon!),):
                              CircleAvatar(
                                backgroundColor: kClrBlue,
                                radius: 25, 
                                child: Text(serverName,style:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: kClrWhite),), 
                              ) 
                           ),
                         ); 
                       },
                       itemCount:state.servers!.length, 
                       separatorBuilder: (context, index) => kHeight15,

                     ),
                   );
                       } 
                      return const Text('\n');
                   }, 
              ),
              IconButton(      
                onPressed: () {
                  kNavigationPush(context,const SearchServerWidget());
                }, 
                icon: const Icon(Icons.diversity_2_outlined, size: 30,),
              ),
              kHeight10,
              IconButton( 
                onPressed: () {

                showDialogToCreateServer( 
                  context: context, 
                  );
                },
                icon: const Icon(Icons.add, size: 30),
              ),
            ],
          ),
        );
      },
    );
  }
}
