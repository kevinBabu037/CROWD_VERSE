part of 'edit_server_bloc.dart';

@immutable
sealed class EditServerState {}

final class EditServerInitial extends EditServerState {}

final class EditServerImageSuccessState extends EditServerState {
 final String serverId;
 final String imagePath;

  EditServerImageSuccessState({required this.serverId, required this.imagePath});
}

final class EditServerImageErrorState extends EditServerState {}


final class ImagePickingSuccessstate extends EditServerState {
  final String imagePath;

  ImagePickingSuccessstate({required this.imagePath});
}


final class EditDiscriptionSuccessState extends EditServerState {
  final String discription;

  EditDiscriptionSuccessState({required this.discription});
}