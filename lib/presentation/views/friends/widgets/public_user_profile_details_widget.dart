
import 'package:crowd_verse/data/models/profile/public_profile_model.dart';
import 'package:crowd_verse/presentation/utils/core/color.dart';
import 'package:crowd_verse/presentation/utils/core/functions.dart';
import 'package:crowd_verse/presentation/utils/core/style.dart';
import 'package:crowd_verse/presentation/views/friends/friends_blc/friends_bloc.dart';
import 'package:crowd_verse/presentation/widgets/login_signup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PublicUserProfileDetailsWidget extends StatelessWidget {
  const PublicUserProfileDetailsWidget({
    super.key,
    required this.screenSize, required this.model,
  });
   final PublicProfileModel model;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.only(left: 10,top: 10,bottom: 10 ),   
      width:screenSize.width-35,   
      decoration: BoxDecoration(
        color: kClrWhite,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(model.name,style:kProfileNameStyle),
             SizedBox(
              height: 25,
               child: BlocConsumer<FriendsBloc, FriendsState>(
                 listener: (context, state) { 
                  if(state is CreateFriendErrorState){
                    kSnakBar(context, state.errorMsg,kClrLiteRed);
                  }
                 },
                 builder: (context, state) {              
                   return LoginSignUpButtonWidget(
                       fontSize: 12,
                      text: ' Add Friend ', 
                      onPressed: () {
                       context.read<FriendsBloc>().add(CreateFriendEvent(id:model.userId!));
                      },
                      );
                 },
               ),
             ),
             
           ],
         ),  
         Text(model.userName??'',style:const TextStyle(fontSize: 18)), 
         model.statusTxt!=null?
         Text(model.statusTxt!,style:const TextStyle(fontSize: 18)):const SizedBox() 
        ],
      ) ,
    );
  }
}