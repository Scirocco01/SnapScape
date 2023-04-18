import 'package:ehisaab_2/ViewModel/Notifications_view_model.dart';
import 'package:ehisaab_2/ViewModel/auth_view_model.dart';
import 'package:ehisaab_2/ViewModel/home_view_model.dart';
import 'package:ehisaab_2/ViewModel/navigation_provider_view_model.dart';
import 'package:ehisaab_2/ViewModel/search_view_model.dart';
import 'package:ehisaab_2/ViewModel/user_credentials_view_model.dart';
import 'package:get_it/get_it.dart';

import '../ViewModel/add_post_view_model.dart';
import '../ViewModel/message_view_model.dart';

final GetIt injector = GetIt.instance;

Future<void> initDependencies() async {
  /// View Model Classes here

  injector.registerFactory<UserCredentialsViewModel>(
      () => UserCredentialsViewModel());

  injector.registerFactory<AuthViewModel>(() => AuthViewModel());

  injector.registerFactory<NavigationProvider>(() => NavigationProvider());

  injector.registerFactory<HomeViewModel>(() => HomeViewModel());

  injector.registerFactory<MessageViewModel>(()=> MessageViewModel());


  injector.registerFactory<NotificationsViewModel>(() => NotificationsViewModel());

  injector.registerFactory<AddPostViewModel>(() =>AddPostViewModel());

  injector.registerFactory<SearchViewModel>(() => SearchViewModel());
  // injector.registerSingleton<HomeViewModel>(HomeViewModel());
}
