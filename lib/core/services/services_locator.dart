

import 'package:order_now/src/authentication/data/authentication_datasource/authentication_remote_datasource.dart';
import 'package:order_now/src/authentication/data/authentication_repository_imp/authentication_repository.dart';
import 'package:order_now/src/authentication/domain/repositories/base_authentication_repository.dart';
import 'package:order_now/src/authentication/domain/usecases/login_usecase.dart';
import 'package:order_now/src/authentication/domain/usecases/register_usecase.dart';
import 'package:order_now/src/authentication/presentation/controllers/login/login_bloc.dart';
import 'package:order_now/src/authentication/presentation/controllers/otp/otp_bloc.dart';
import 'package:order_now/src/authentication/presentation/controllers/register/register_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServicesLocator{
  void init(){
    //bloc
    sl.registerLazySingleton(() => LoginBloc(loginUseCase: sl()));
    sl.registerLazySingleton(() => RegisterBloc(registerUseCase: sl()));
    sl.registerLazySingleton(() => OtpBloc());

    //use cases
    sl.registerLazySingleton(() => LoginUseCase(authenticationRepository: sl()));
    sl.registerLazySingleton(() => RegisterUseCase(authenticationRepository: sl()));

    // repo
    sl.registerLazySingleton<BaseAuthenticationRepository>(() => AuthenticationRepositoryImp(authenticationRemoteDataSource: sl()));

    // data source
    sl.registerLazySingleton<BaseAuthenticationRemoteDataSource>(()=> AuthenticationRemoteDataSourceImp());



  }
}
