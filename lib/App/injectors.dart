

import 'package:ehisaab_2/ViewModel/user_credentials_view_model.dart';
import 'package:get_it/get_it.dart';

final GetIt injector = GetIt.instance;

Future<void> initDependencies()async{

  /// View Model Classes here


  injector.registerFactory<UserCredentialsViewModel>(() => UserCredentialsViewModel());


}