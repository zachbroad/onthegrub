import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/core/auth/registration/models/user_registration.dart';
import 'package:onthegrubv2/core/auth/registration/repositories/registration_repository.dart';
part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationState(UserRegistration()));

  update(UserRegistration userRegistration) {
    emit(RegistrationState(userRegistration));
  }

  Future<bool> register() async {
    await RegistrationRepository().register(state.userRegistration);
    emit(RegistrationState(UserRegistration()));
    return true;
  }
}
