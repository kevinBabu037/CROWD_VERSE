import 'package:bloc/bloc.dart';
import 'package:crowd_verse/data/models/server/all_categorys.dart';
import 'package:crowd_verse/data/repositories/server/server_service.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
  
  ServerService service = ServerService();

    on<FechAllCategory>((event, emit)async {
        emit(CategoryLoadingState());

        List<CategoreyModel>? category = await service.getAllCategorys(event.serverID);

        if (category!=null) {
          emit(CategorySuccessState(category: category));
        }else{
          emit(CategoryErrorState());
        }
    });

    on<CreateCategoryEvent>((event, emit)async{
       bool res =  await service.createCategory(event.serverID, event.categoryName);

       if (res) {
         emit(CreateCategorySuccess());
         List<CategoreyModel>? category = await service.getAllCategorys(event.serverID);
         if (category!=null) {
           emit(CategorySuccessState(category: category));
         }
       }

    });
     

  }
}
