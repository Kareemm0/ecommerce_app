abstract class HomeState {}

class HomeInitialState extends HomeState {}

class GetBannersLoadingState extends HomeState {}

class GetBannersSuccessState extends HomeState {}

class GetBannersFailureState extends HomeState {}

class GetCategoriesFailureState extends HomeState {}

class GetCategoriesSuccessState extends HomeState {}

class GetCategoriesLoadingState extends HomeState {}

class GetProductsSuccessState extends HomeState {}

class GetProductsFailureState extends HomeState {}

class GetProductsLoadingState extends HomeState {}

class SearchProductsSucessState extends HomeState {}

class GetFavotitesSucessState extends HomeState {}

class GetFavotitesFailureState extends HomeState {}

class AddOrRemoveItemFromFavoriteFailureState extends HomeState {}

class AddOrRemoveItemFromFavoriteSuccessState extends HomeState {}

class GetCartsSuccessState extends HomeState {}

class GetCartsFailureState extends HomeState {}

class AddOrRemoveItemFromCartSuccessState extends HomeState {}

class AddOrRemoveItemFromCartFailureState extends HomeState {}

class ChangePasswordtFailureState extends HomeState {
  final String message;

  ChangePasswordtFailureState({required this.message});
}

class ChangePasswordSuccessState extends HomeState {}

class ChangePasswordLoadingState extends HomeState {}

class UpdateUserDataLoadingState extends HomeState {}

class UpdateUserDataSuccessState extends HomeState {}

class UpdateUserDataFailureState extends HomeState {
  final String message;

  UpdateUserDataFailureState({required this.message});
}
