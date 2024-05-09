import 'package:flutter_bloc/flutter_bloc.dart';

class ExpansionCubit extends Cubit<Map<String, bool>> {
  ExpansionCubit() : super({});

  void setExpansionState(String name, bool isExpanded) {
    emit({...state, name: isExpanded});
  }
}