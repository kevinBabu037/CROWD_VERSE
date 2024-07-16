part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}


class FechAllCategory extends CategoryEvent {
  final String serverID;

  FechAllCategory({required this.serverID});
}


class CreateCategoryEvent extends CategoryEvent {
  final String serverID;
  final String categoryName;

  CreateCategoryEvent({
    required this.serverID,
    required this.categoryName
  });
}