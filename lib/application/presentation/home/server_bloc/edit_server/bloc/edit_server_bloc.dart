import 'package:bloc/bloc.dart';
import 'package:crowd_verse/data/repositories/server/server_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'edit_server_event.dart';
part 'edit_server_state.dart';

class EditServerBloc extends Bloc<EditServerEvent, EditServerState> {
  EditServerBloc() : super(EditServerInitial()) {

 String imgPath = "";

   ServerService service = ServerService();

    on<UploadImageEvent>((event, emit)async {

      bool res = await service.uploadServerImage(imgPath, event.serverId);
      
       if (event.discription!.isNotEmpty) {
       await service.editDiscription(serverId:event.serverId, discription:event.discription);
     }
      
       if (res) {
         emit(EditServerImageSuccessState(serverId: event.serverId, imagePath: imgPath));
       }else{
        emit(EditServerImageErrorState());
       }
       if (res) {
         emit(EditServerInitial());
       }

    });


  on<ImagePickingEvent>((event, emit)async {
    final fileImg = await ImagePicker().pickImage(source: ImageSource.gallery); 
     if (fileImg!=null) {
       imgPath=fileImg.path;
        emit(ImagePickingSuccessstate(imagePath:fileImg.path));
     }
  });










  }
}



















 // FutureOr<void> selectServerImg(SelectServerImgEvent event, Emitter<ServerState> emit)async{
  //  final fileImg = await ImagePicker().pickImage(source: ImageSource.gallery); 
  //       imagePath=fileImg!.path;
  //    if (imagePath.isNotEmpty) {
  //      emit(CreateServerImageSelectSuccessState(imagepath: imagePath)); 
  //    }   
  // }