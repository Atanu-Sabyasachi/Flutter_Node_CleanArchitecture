import 'package:dio/dio.dart';
import 'package:flutter_node_practice/core/config/network_config.dart';
import 'package:flutter_node_practice/core/services/dio_network_service.dart';
import 'package:flutter_node_practice/core/services/network_service.dart';
import 'package:flutter_node_practice/features/authentication/data/datasource/auth_remote_data_sources.dart';
import 'package:flutter_node_practice/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:flutter_node_practice/features/authentication/domain/repository/auth_repository.dart';
import 'package:flutter_node_practice/features/authentication/domain/usecase/current_user.dart';
import 'package:flutter_node_practice/features/authentication/domain/usecase/signup_usecase.dart';
import 'package:flutter_node_practice/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initNetworkService();
  _initAuthDependencies();
}

void _initNetworkService() {
  final httpNetworkService = HTTPNetworkServiceImpl(
    baseUrl: NetworkConfig.baseUrl,
    client: http.Client(),
  );

  final dioNetworkService = DioNetworkServiceImpl(
    baseUrl: NetworkConfig.baseUrl,
    dio: Dio(),
  );

  serviceLocator
      .registerLazySingleton<HTTPNetworkService>(() => httpNetworkService);
  serviceLocator
      .registerLazySingleton<DioNetworkService>(() => dioNetworkService);
}

void _initAuthDependencies() {
  // data source
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      serviceLocator<DioNetworkService>(),
      serviceLocator<HTTPNetworkService>(),
    ),
  );

  // repository
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: serviceLocator<AuthRemoteDataSource>(),
    ),
  );

  // usecase
  serviceLocator.registerFactory(
    () => SignUpUseCase(
      serviceLocator<AuthRepository>(),
    ),
  );
  serviceLocator.registerFactory(
    () => CurrentUser(
      serviceLocator(),
    ),
  );

  // bloc
  serviceLocator.registerFactory(
    () => AuthBloc(
      signUpUseCase: serviceLocator<SignUpUseCase>(),
      currentUser: serviceLocator(),
    ),
  );
}
