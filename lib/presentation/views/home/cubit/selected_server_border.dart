import 'package:flutter_bloc/flutter_bloc.dart';

class ServerListCubit extends Cubit<int> {
  ServerListCubit() : super(0); 

  void selectItem(int index) {
    emit(index);
  }
}