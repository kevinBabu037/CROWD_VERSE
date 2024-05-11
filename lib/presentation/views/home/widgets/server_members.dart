import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/functions.dart';
import 'package:crowd_verse/presentation/views/home/server_bloc/server_members/bloc/server_members_bloc.dart';
import 'package:crowd_verse/presentation/widgets/costum_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServerMembers extends StatelessWidget {
 final String serverId;
  const ServerMembers({super.key, required this.serverId});

  @override  
  Widget build(BuildContext context) {
    context.read<ServerMembersBloc>().add(GetAllServerMembers(serverId:serverId));
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Members',
        onPressed: () => Navigator.pop(context),
        icon: Icons.arrow_back,
        ) ,
      body:SizedBox(
        child: BlocBuilder<ServerMembersBloc, ServerMembersState>(
          builder: (context, state) {
            if (state is ServerMembersLoadingState) {
             return  Center(child: kCircularProgressIndicator,);
            } 
            if (state is ServerMembersSuccessState) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    final members = state.members[index];
                   return  ListTile(
                    leading:const CircleAvatar(
                      child: Center(child: Icon(Icons.person),),
                    ),
                    title: Text(members.name), 
                    trailing:members.role=="SuperAdmin"? Container(
                      decoration: BoxDecoration(
                        color: kClrLiteGreen,
                       borderRadius: BorderRadius.circular(10)
                      ),
                      child:const Text(' Admin ')
                      ):const SizedBox(),
                   );
                  }, 
                  separatorBuilder: (context, index) =>const Divider(thickness: 0.2,),  
                  itemCount: state.members.length
                  );
            }
            return const Center(child: Text('Fail to fech'),);
          },
        ),
      ),
    ); 
  }
}