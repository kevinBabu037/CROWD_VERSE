import 'package:crowd_verse/data/repositories/server/server_service.dart';
import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/functions.dart';
import 'package:crowd_verse/presentation/utils/core/shimmer/shimmer_friends_list.dart';
import 'package:crowd_verse/presentation/views/home/server_bloc/search_server.dart/bloc/search_server_bloc.dart';
import 'package:crowd_verse/presentation/widgets/costum_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart'; 

class SearchServerWidget extends StatelessWidget {
  const SearchServerWidget({super.key});
  

  @override
  Widget build(BuildContext context) {
     context.read<SearchServerBloc>().add(SearchAllServerEvent(searchTxt: ''));
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Servers',
        icon: Icons.arrow_back,
        onPressed: () {
          Navigator.pop(context); 
        }, 
        ),
        body:Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),  
              child: CupertinoSearchTextField(
                onChanged: (value) {
                 context.read<SearchServerBloc>().add(SearchAllServerEvent(searchTxt:value)); 
                },
                padding: const EdgeInsets.all(10),
                backgroundColor: kClrLiteBlue,
                suffixIcon: const Icon(
                  CupertinoIcons.xmark_circle_fill,
                  color: Colors.grey,
                ),
                prefixIcon: const Icon( 
                  CupertinoIcons.search,
                  color: Colors.grey,
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchServerBloc, SearchServerState>(
                builder: (context, state) {
                  if (state is SearchServerLoadingState) { 
                    return const ShimmerFriendsListTile(); 
                  }
                  if (state is SearchServerSuccessState){
                    return ListView.separated(
                          itemBuilder: (context, index) {
                            final data = state.server[index];
                            String name = kServerNameFormter(data.name);
                            return  ListTile(
                              subtitle:data.discription!=null? Text(data.discription!):const SizedBox() ,
                              leading:data.serverIcon!=null? CircleAvatar(radius: 30, backgroundImage: NetworkImage(data.serverIcon!),):
                              CircleAvatar(
                                    backgroundColor: kClrBlue,
                                    radius: 30, 
                                    child: Text(name,style:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: kClrWhite),), 
                                  ) ,
                              title: Text(data.name,style:const TextStyle(fontSize: 18 ),),
                              trailing:GestureDetector(
                                onTap: ()async {
                                  bool res = await ServerService().joinServer(data.serverId!);
                                  // ignore: use_build_context_synchronously
                                  res?kSnakBar(context, "Joined SuccessFuly", kClrLiteGreen):kSnakBar(context, "Fail to join", kClrLiteRed);
                                },
                                child: Container(
                                       height: 20,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10), 
                                        border: Border.all()
                                      ),
                                      child:const Center(child:  Text("Join")),
                                    ),
                              ), 
                              );
                          }, 
                          separatorBuilder: (context, index) =>const Divider(thickness:0.3 ,),  
                          itemCount: state.server.length
                          );
                  }
                  if (state is SearchServerEmptyState) {
                   return  SizedBox(height: 200,width: 200, child: Lottie.network('https://lottie.host/6826a964-4a31-4504-b25c-8209c00869d4/8D2Vx9VYvn.json'));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ) ,
    );
  }
}