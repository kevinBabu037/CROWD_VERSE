part of 'edit_server_bloc.dart';

@immutable
sealed class EditServerEvent {}

// ignore: must_be_immutable
class UploadImageEvent extends EditServerEvent {
 final String serverId;
 String? discription;
  UploadImageEvent({required this.serverId,this.discription});
} 


class ImagePickingEvent extends EditServerEvent {}

class EditDiscriptionEvent extends EditServerEvent {}