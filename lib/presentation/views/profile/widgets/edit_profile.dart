import 'package:crowd_verse/data/repositories/profile/profile_serveces.dart';
import 'package:crowd_verse/presentation/views/profile/profile_bloc/profile_details_bloc.dart';
import 'package:crowd_verse/utils/core/coverpic_shimmer.dart';
import 'package:crowd_verse/presentation/widgets/login_signup_button.dart';
import 'package:crowd_verse/utils/core/color.dart';
import 'package:crowd_verse/utils/core/functions.dart';
import 'package:crowd_verse/utils/core/height_width.dart';
import 'package:crowd_verse/utils/validations/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class EditProfileWidget extends StatelessWidget {
   EditProfileWidget({super. key});
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
       context.read<ProfileDetailsBloc>().add(DisplayProfileEvent());
       final TextEditingController aboutController=TextEditingController( );   

    final screenSize = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,  
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                BlocConsumer<ProfileDetailsBloc, ProfileDetailsState>( 
                  listener: (context, state) {
                    if (state is EditProfileErrorState) {
                      kSnakBar(context, state.error, kClrLiteRed);
                    }
                  }, 
                  builder: (context, state) {
                    if (state is EditProfileLoadingState) {
                      return const ShimmerCoverPicLoading(height: 200);
                    } else if (state is ProfileSuccessState) {
                      aboutController.text = state.profile.aboutTxt ?? '';
                      return SizedBox(
                        width: double.infinity,
                        height: screenSize * 0.2,
                        child: state.profile.coverPic != null
                            ? Image.network(
                                state.profile.coverPic!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/defalt_cover_pic1.png',
                                fit: BoxFit.cover,
                              ),
                      );
                    }
                    if (state is EditProfileErrorState) { 
                      return Container(decoration: BoxDecoration(border: Border.all(width: 0.4)), height: 200,width:double.infinity,child:  Center(child: Text(state.error)),);     
                    }
                    return const SizedBox();
                  },  
                ), 
                const SizedBox(height: 70),
                Form(   
                  key:_formKey ,
                  child: Padding(  
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField( 
                      controller: aboutController,
                      validator: (value) {
                        return Validator.aboutTxtValidator(value);
                      }, 
                      maxLines: 3,
                      decoration:  InputDecoration( 
                        suffixIcon:IconButton(
                          onPressed: (){
                            aboutController.clear();
                            ProfileServices().deleteDiscription();
                          },
                         icon:const Icon(Icons.delete)) ,
                        hintText: 'About',
                        border:const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),  
                SizedBox(height: kHeight40),
                LoginSignUpButtonWidget( 
                  text: 'Save', 
                  onPressed: () { 
                    if (_formKey.currentState!.validate()) { 
                      context.read<ProfileDetailsBloc>().add(AddAboutTextEvent(txt: aboutController.text));
                     Navigator.pop(context);
                    }
                  },
                ),
              ], 
            ),
            Positioned( 
              left: 30,
              top: screenSize * 0.1 + 28,
              child: CircleAvatar(
                backgroundColor: kClrWhite,
                radius: 50,
                child: BlocConsumer<ProfileDetailsBloc, ProfileDetailsState>( 
                  listener: (context, state) {
                     if (state is EditProfilePicErrorState) { 
                      kSnakBar(context, state.error, kClrLiteRed);
                    }
                  },
                  builder: (context, state) {
                   if (state is EditProfilePicLoadingState) { 
                     return const Center(child: CircularProgressIndicator());
                   } 
                   if (state is ProfileSuccessState) { 
                       return CircleAvatar(
                        backgroundColor: kClrBlue,
                        radius: 45,
                        backgroundImage:state.profile.profilepic!=null?
                          NetworkImage(state.profile.profilepic!):
                         const AssetImage('assets/default_profile_pic.png') as ImageProvider<Object>,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              context.read<ProfileDetailsBloc>().add(EditProfilePicEvent());
                            },
                            child: CircleAvatar( 
                              radius: 12,
                              backgroundColor: kClrBlack.withOpacity(0.5),
                              child: const Icon(
                                Icons.edit_rounded, 
                                color: kClrWhite,
                              ), 
                            ),
                          ),
                        ), 
                      );
                   } 
                   if (state is EditProfilePicErrorState) {
                     return const CircleAvatar(radius:10,child: Icon(Icons.error),); 
                   }
                   return const SizedBox();
                   
                  },
                ),
              ),
            ),
            Positioned( 
              top: 30,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  context.read<ProfileDetailsBloc>().add(EditProfileEvent());
                },
                child: CircleAvatar(
                  radius: 17,
                  backgroundColor: kClrBlack.withOpacity(0.5),
                  child: const Icon(
                    Icons.edit,
                    color: kClrWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


