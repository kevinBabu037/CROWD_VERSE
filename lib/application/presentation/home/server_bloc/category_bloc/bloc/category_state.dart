part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoadingState extends CategoryState {}

final class CategorySuccessState extends CategoryState {
  final List<CategoreyModel> category;

  CategorySuccessState({required this.category});
  
}

final class CategoryErrorState extends CategoryState {}
////////////////


final class CreateCategorySuccess extends CategoryState {}






