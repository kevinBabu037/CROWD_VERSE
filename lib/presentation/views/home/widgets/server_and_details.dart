
import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/images.dart';
import 'package:crowd_verse/presentation/views/home/server_bloc/channel_bloc/bloc/channel_bloc.dart';
import 'package:crowd_verse/presentation/views/home/server_bloc/server_details_bloc/bloc/server_details_bloc.dart';
import 'package:crowd_verse/presentation/views/home/widgets/all_channel.dart';
import 'package:crowd_verse/presentation/views/home/widgets/bottom_sheet_server_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChannelsAndDetailsWidget extends StatelessWidget {
   ChannelsAndDetailsWidget({
    super. key,
    required this.screenSize, 
  });

  final Size screenSize;

  final Map<String, bool> expansionStates = {}; 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      width: screenSize.width * 0.8,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: kClrWhite,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ServerDetailsBloc, ServerDetailsState>(
            builder: (context, state) {
              if (state is ServerDetailsLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ServerDetailsSuccessState) {
                context.read<ChannelBloc>().add(FechAllChannelsEvent(serverID: state.server.serverId!));
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: state.server.serverIcon != null
                              ? NetworkImage(state.server.serverIcon!)
                              : AssetImage(kDefaultcoverPic) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(25)),
                      ),
                      height: screenSize.height * 0.2 - 10,
                    ),
                    Positioned(
                      left: 10,
                      top: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kClrBlack.withOpacity(0.4),
                        ),
                        child: Text(
                          state.server.name,
                          style: const TextStyle(fontSize: 18, color: kClrWhite),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          bottomSheetServerSettings(context: context, data: state.server, serverId: state.server.serverId!);
                        },
                        child: CircleAvatar(
                          radius: 17,
                          backgroundColor: kClrBlack.withOpacity(0.4),
                          child: const Icon(Icons.more_horiz, color: kClrWhite),
                        ),
                      ),
                    )
                  ],
                );
              }
              return SizedBox(
                height: screenSize.height * 0.1+40,
                child: const Center(
                  child: Text('Welcome',style: TextStyle(fontSize: 20),),
                ),
              );
            },
          ),
          AllChannelsListWidget(expansionStates: expansionStates),
        ],
      ),
    );
  }
}


