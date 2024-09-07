abstract class CubitState {}


class RegisterLoading extends CubitState{}
class RegisterSuccess extends CubitState{}
class RegisterError extends CubitState{
 final String? error;
  RegisterError({this.error});
}



class LoginLoading extends CubitState{}
class LoginSuccess extends CubitState{}
class LoginError extends CubitState{
 final String? error;
 LoginError({this.error});
}







