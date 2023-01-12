import 'package:equatable/equatable.dart';

import "package:flutter/foundation.dart" show immutable;

@immutable
abstract class Failure extends Equatable {}

@immutable
class LocalFailure extends Failure {
  static const message = "Local Failure";
  @override
  List<Object?> get props => [];
}
