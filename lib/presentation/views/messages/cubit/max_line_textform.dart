import 'package:flutter_bloc/flutter_bloc.dart';

class MaxLineCubit extends Cubit<int> {
  MaxLineCubit() : super(1);

  void updateMaxLine(int length) {
    if (length <= 45) {
      emit(1);
    } else if (length <= 90) {
      emit(2);
    } else {
      emit(3);
    }
  }
}