import 'package:flutter_bloc/flutter_bloc.dart';

class NavIndex extends Cubit<int>{

  NavIndex():super(0);

 void updateIndex(int selectedIndex) {
    emit(selectedIndex);
  }

  
}