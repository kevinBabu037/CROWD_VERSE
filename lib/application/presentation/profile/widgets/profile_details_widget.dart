import 'package:crowd_verse/application/utils/core/style.dart';
import 'package:crowd_verse/application/presentation/profile/widgets/edit_status_widget.dart';
import 'package:crowd_verse/application/presentation/profile/widgets/edit_profile.dart';
import 'package:crowd_verse/application/utils/core/shimmer/coverpic_shimmer.dart';
import 'package:crowd_verse/application/presentation/profile/widgets/status_and_edit_widget.dart';
import 'package:crowd_verse/application/utils/core/functions.dart';
import 'package:crowd_verse/application/utils/core/height_width.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/core/color.dart'; 
import '../profile_bloc/profile_details_bloc.dart';

class ProfileDetailsWidget extends StatelessWidget {
  const ProfileDetailsWidget({
    super.key,
    required this.screenSize, 
  });

  final Size screenSize;

  @override  
  Widget build(BuildContext context) {
   context.read<ProfileDetailsBloc>().add(DisplayProfileEvent());   
    
    return Container(
     padding:const EdgeInsets.only(left: 10,top: 10,bottom: 10 ),     
     width: screenSize.width-35,
     decoration:  BoxDecoration(
       borderRadius: BorderRadius.circular(10), 
        color:kClrWhite, 
     ),  
     child: BlocBuilder<ProfileDetailsBloc, ProfileDetailsState>(
       builder: (context, state) {
 
        if (state is ProfileLoadingState) { 
          return const ShimmerCoverPicLoading(height:200,);  
        }
          
         if (state is ProfileSuccessState) { 
           return Column( mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [  
               Text(state.profile.name,style:kProfileNameStyle),
              Text(state.profile.userName??'',style:const TextStyle(fontSize: 18)), 
              kHeight10,
               state.profile.statusTxt!=null?  
               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                children: [ 
                 Flexible(child: Text(state.profile.statusTxt??'',style:const TextStyle(fontSize: 18))),   
                 IconButton(onPressed: (){ 
                  context.read<ProfileDetailsBloc>().add(DeleteStatusEvent());
                },   
                 icon:const Icon(Icons.close,size: 17,)) 
               ],): const SizedBox(), 
               kHeight10,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,   
                children: [
                   
                GestureDetector(
                  onTap: () {
                 editStatusDialog(context);
                  },
                  child: StatusAndEditWidget(screenSize: screenSize,icon: Icons.chat_bubble_outline,text: 'Edit Status',)
                  ),
 
                GestureDetector(
                  onTap: () { 
                    kNavigationPush(context, EditProfileWidget()) ; 
                  },
                  child: StatusAndEditWidget(screenSize: screenSize,icon: Icons.edit_outlined,text:'Edit Profile',)
                  ), 
                 
               const SizedBox(width: 5,) 
              ],)
            ], 
          );
         }else{
          return const SizedBox(); 
         }
       },
       
     ) , 
    );
  }
}

