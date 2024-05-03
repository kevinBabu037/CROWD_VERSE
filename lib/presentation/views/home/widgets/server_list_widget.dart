
import 'package:crowd_verse/data/models/server/all_server_model.dart';
import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/height_width.dart';
import 'package:crowd_verse/presentation/utils/core/images.dart';
import 'package:crowd_verse/presentation/views/home/cubit/selected_server_border.dart';
import 'package:crowd_verse/presentation/views/home/server_bloc/server_details_bloc/bloc/server_details_bloc.dart';
import 'package:crowd_verse/presentation/views/home/server_bloc/server_list_bloc/server_bloc.dart';
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
                    const Center(child: CircularProgressIndicator(),); 
                  }
               if (state is ServerSuccessState) {
                   return Expanded(
                     child: ListView.separated( 
                       itemBuilder: (context, index) {
                         ServerModel data = state.servers![index];  
                         return InkWell( 
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
                             child: CircleAvatar(
                               backgroundImage:data.serverIcon!=null? NetworkImage(data.serverIcon!): AssetImage(kDefaultcoverPic)as ImageProvider,
                               radius: 25,
                             ),
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
