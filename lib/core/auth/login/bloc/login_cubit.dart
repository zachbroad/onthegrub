import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/core/auth/login/repositories/login_repository.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState('', ''));

  update(String username, String password) {
    emit(LoginState(username, password));
  }

  Future<bool> login() async {
    await LoginRepository().retrieveToken(state.username, state.password);
    emit(LoginState('', ''));
    return true;
  }
}
