
import 'package:crowd_verse/data/models/server/all_channels.dart';
import 'package:crowd_verse/application/utils/core/color.dart';
import 'package:crowd_verse/application/utils/core/functions.dart';
import 'package:crowd_verse/application/utils/core/shimmer/shimmer_friends_list.dart';
import 'package:crowd_verse/application/presentation/home/cubit/server_expanded.dart';
import 'package:crowd_verse/application/presentation/home/server_bloc/channel_bloc/bloc/channel_bloc.dart';
import 'package:crowd_verse/application/presentation/home/widgets/channel_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllChannelsListWidget extends StatelessWidget {
  const AllChannelsListWidget({ 
    super.key,
    required this.expansionStates,
   required this.serverID
  });
  final String serverID;
  final Map<String, bool> expansionStates;

  @override 
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelBloc, ChannelState>(
      builder: (context, state) {
        if (state is ChannelLoadingState) {
          return const Expanded(child: ShimmerFriendsListTile());
        }
        if (state is ChannelSuccessState) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.channels.length,
              itemBuilder: (context, index){
                ChannelModel data = state.channels[index];
                bool isExpanded = expansionStates[data.name] ?? false;
                return Column( 
                  children: [
                    ExpansionTile(
                      shape: Border.all(color: kClrWhite),
                      title: Text(data.name,style:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),), 
                      onExpansionChanged: (value) {
                       context.read<ExpansionCubit>().setExpansionState(data.name, value);
                      },
                       initiallyExpanded: isExpanded, 
                      children: [
                        ListView.builder(
                           shrinkWrap: true, 
                           physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.channels.length,
                          itemBuilder: (context, index) {
                            final chanel = data.channels[index]; 
                            return ListTile(
                              onTap: () {  
                               kNavigationPush(context, ChannelChat(chanel: chanel,serverID: serverID,));                             
                              }, 
                              title: Text("  # ${chanel.name}"),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          );
        }
        if (state is ChannelErroegState) {
          return const Center(child: Text('Error'));
        }
        return const Center(child: Text('You can select a Server',style: TextStyle(fontSize: 18),));
      },
    );
  }
}
