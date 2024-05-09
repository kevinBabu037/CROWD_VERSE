
import 'package:crowd_verse/data/models/server/all_channels.dart';
import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/views/home/cubit/server_expanded.dart';
import 'package:crowd_verse/presentation/views/home/server_bloc/channel_bloc/bloc/channel_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllChannelsListWidget extends StatelessWidget {
  const AllChannelsListWidget({
    super.key,
    required this.expansionStates,
  });

  final Map<String, bool> expansionStates;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelBloc, ChannelState>(
      builder: (context, state) {
        if (state is ChannelLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ChannelSuccessState) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.channels.length,
              itemBuilder: (context, index) {
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
