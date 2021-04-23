import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/config/routes/routes.dart';
import 'package:onthegrubv2/core/auth/login/repositories/login_repository.dart';
import 'package:onthegrubv2/services/navigation_service.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState('', ''));

  update(String username, String password) {
    // TODO: do i validate now
    emit(LoginState(username, password));
  }

  login() async {
    await LoginRepository().retrieveToken(state.username, state.password);
    // TODO: If I handle "Remember username" or "Remember password" -> do it here
    emit(LoginState('', ''));
    NavigationService.instance.goToReplacementNamed(Routes.splashScreen);
  }
}
