

import 'package:order_now/core/network/error_message_model.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  final ErrorMessageModel errorMessageModel;

  const Failure({required this.errorMessageModel});

  @override
  List<Object> get props => [errorMessageModel];
}

class ServerFailure extends Failure{
  const ServerFailure({required super.errorMessageModel});
}


class DatabaseFailure extends Failure{
  const DatabaseFailure({required super.errorMessageModel});
} 