abstract class UserState{}


class GetUserLoading extends UserState{}

class GetUserSucess extends UserState{}

class GetUserError extends UserState{
  final String error;
  GetUserError({required this.error});
}


class logoutSuccess extends UserState{}
