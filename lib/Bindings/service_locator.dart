import 'package:get_it/get_it.dart';
import 'package:ourhands/controllers/auth_conntroller/restore_password_controller.dart';
import 'package:ourhands/controllers/auth_conntroller/login_screen_controller.dart';
import 'package:ourhands/controllers/auth_conntroller/register_controller.dart';
import 'package:ourhands/services/password_recovery_service.dart';
import 'package:ourhands/services/login_service.dart';
import 'package:ourhands/services/register_service.dart';
import '../controllers/home_controller/search_controller.dart';
import '../services/result of search.dart';
import '../services/user_search-3_service.dart'; 

final GetIt getIt = GetIt.instance;

void setupDependencyInjection() {
  // Registering Auth related services and controllers
  getIt.registerLazySingleton<AuthLoginService>(() => AuthLoginService());
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<PasswordRecoveryService>(() => PasswordRecoveryService());
  
  getIt.registerFactory<LoginController>(() => LoginController(getIt<AuthLoginService>()));
  getIt.registerFactory<RegisterController>(() => RegisterController(getIt<AuthService>()));
  getIt.registerFactory<PasswordRecoveryController>(() => PasswordRecoveryController(getIt<PasswordRecoveryService>()));

  // Registering Search-related services and controllers
  getIt.registerLazySingleton<SearchService>(() => SearchService());
  getIt.registerLazySingleton<UserSearchService>(() => UserSearchService());

  // Registering Search and Home Controllers
  getIt.registerFactory<SearchHomeController>(() => SearchHomeController(getIt<SearchService>()));
 // getIt.registerFactory<HomeController>(() => HomeController(getIt<UserSearchService>()));
}
