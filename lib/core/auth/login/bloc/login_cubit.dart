import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/core/auth/login/repositories/login_repository.dart';
import 'package:onthegrubv2/core/auth/screens/splash_screen.dart';
import 'package:onthegrubv2/modules/index/index.dart';
import 'package:onthegrubv2/services/navigation_service.dart';
import 'package:onthegrubv2/utils/services/secure_storage_service.dart';
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
    NavigationService.instance.goToReplacementNamed(SplashScreen.routeName);
  }
}
