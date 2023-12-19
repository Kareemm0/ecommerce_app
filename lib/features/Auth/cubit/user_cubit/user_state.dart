abstract class UserStates {}

class UserInitialState extends UserStates {}

class UserLoadingState extends UserStates {}

class UserGetDataSuccessState extends UserStates {}

class UserFailureToGetDataState extends UserStates {
  final String error;

  UserFailureToGetDataState({required this.error});
}
