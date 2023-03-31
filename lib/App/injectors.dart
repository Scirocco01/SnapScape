import 'package:ehisaab_2/ViewModel/auth_view_model.dart';
import 'package:ehisaab_2/ViewModel/home_view_model.dart';
import 'package:ehisaab_2/ViewModel/navigation_provider_view_model.dart';
import 'package:ehisaab_2/ViewModel/user_credentials_view_model.dart';
import 'package:get_it/get_it.dart';

final GetIt injector = GetIt.instance;

Future<void> initDependencies() async {
  /// View Model Classes here

  injector.registerFactory<UserCredentialsViewModel>(
      () => UserCredentialsViewModel());

  injector.registerFactory<AuthViewModel>(() => AuthViewModel());

  injector.registerFactory<NavigationProvider>(() => NavigationProvider());

  injector.registerFactory<HomeViewModel>(() => HomeViewModel());
}
