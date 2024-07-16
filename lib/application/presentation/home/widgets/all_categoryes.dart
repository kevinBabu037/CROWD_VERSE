
import 'package:crowd_verse/application/utils/core/images.dart';
import 'package:crowd_verse/application/utils/core/shimmer/shimmer_friends_list.dart';
import 'package:crowd_verse/application/presentation/home/server_bloc/category_bloc/bloc/category_bloc.dart';
import 'package:crowd_verse/application/presentation/home/widgets/create_category_widget.dart';
import 'package:crowd_verse/application/presentation/home/widgets/create_channel_widget.dart';
import 'package:crowd_verse/application/widgets/costum_appbar.dart';
import 'package:crowd_verse/application/widgets/login_signup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCategorySWidget extends StatelessWidget {
  const AllCategorySWidget({super.key, required this.serverID});
  final String serverID;

  @override
  Widget build(BuildContext context) {
    context.read<CategoryBloc>().add(FechAllCategory(serverID: serverID));
    return Scaffold(
      appBar: CustomAppBar(
        title:'Create Channel',
        icon: Icons.arrow_back,
        onPressed: () => Navigator.pop(context),
        ),
        body:BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
           if (state is CategoryLoadingState) {
             return const ShimmerFriendsListTile();
           }
           if (state is CategorySuccessState) { 
              return ListView.separated(
                itemBuilder: (context, index) {
                  final data = state.category[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(kAppLogo),
                  ),
                  title: Text(data.name),
                  trailing: IconButton(
                    onPressed: (){
                     showDialogToCreateChannel(context: context, serverID: serverID,categoryID: data.cateGoryID);
                   
                    }, 
                  icon:const Icon(Icons.add)
                  ), 
                ); 
                }, 
                separatorBuilder: (context, index) =>const Divider(thickness: 0.3,), 
                itemCount: state.category.length,
                );
           }
           return const Center(child: Text('Fail to Fech'),);
          },
        ),
        bottomSheet:Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: LoginSignUpButtonWidget( 
                text: 'Add Category', 
                onPressed: () { 
                   showDialogToCreateCategory(context: context,serverID: serverID);
                },
                ),
        ) ,
           
         
    );
  }
}