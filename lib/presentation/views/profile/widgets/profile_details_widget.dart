import 'package:crowd_verse/presentation/views/profile/widgets/status_and_edit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/core/color.dart';
import '../bloc/profile_details_bloc.dart';

class ProfileDetailsWidget extends StatelessWidget {
  const ProfileDetailsWidget({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
   context.read<ProfileDetailsBloc>().add(ProfileDetailsEvent());
   
    return Container(
     padding:const EdgeInsets.only(left: 10,top: 10,bottom: 10 ), 
     height: screenSize.height*0.2+30 ,
     width: screenSize.width-35,
     decoration:  BoxDecoration(
       borderRadius: BorderRadius.circular(10),
        color:kClrWhite,
     ),  
     child: BlocBuilder<ProfileDetailsBloc, ProfileDetailsState>(
       builder: (context, state) {
          
         if (state is ProfileSucessesState) {
           return Column( mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [  
               Text(state.profile.name,style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 27 ),),
              Text(state.profile.userName,style:const TextStyle(fontSize: 18)),
               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                const Text('Hy All its my status text ❤️',style: TextStyle(fontSize: 18)), 
                IconButton(onPressed: (){ 
                 
                },
                 icon:const Icon(Icons.close,size: 17,))
               ],),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [
                StatusAndEditWidget(screenSize: screenSize,icon: Icons.chat_bubble_outline,text: 'Edit Status',), 
                StatusAndEditWidget(screenSize: screenSize,icon: Icons.edit_outlined,text:'Edit Profile',), 
                 
               const SizedBox(width: 5,)
              ],)
            ], 
          );
         }else{
          return const Center(child: CircularProgressIndicator(),);
         }
       },
       
     ) , 
    );
  }
}

