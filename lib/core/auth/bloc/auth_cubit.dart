import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/core/auth/models/user.dart';
import 'package:onthegrubv2/core/auth/repositories/auth_repository.dart';
import 'package:onthegrubv2/utils/services/secure_storage_service.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState(User(), false));

  // 1. Verify token
  // if true:
  // 2. Store user information
  // 3. Navigate
  //
  // if false:
  // 2. Navigate
  Future<bool> authenticate() async {
    bool _loggedIn = await AuthRepository().validateToken();
    if (_loggedIn) {
      User _user = await AuthRepository().retrieveUserProfile();
      emit(AuthState(_user, _loggedIn));
      return true;
    } else {
      await SecureStorageService().logoutCurrentUser();
      emit(AuthState(User(), _loggedIn));
      return false;
    }
  }

  // 1. Delete all user-related data
  // 2. emit
  // 3. Navigate
  Future<bool> logout() async {
    await SecureStorageService().logoutCurrentUser();
    emit(AuthState(User(), false));
    return true;
  }
}
