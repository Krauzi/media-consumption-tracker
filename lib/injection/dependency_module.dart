import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mediaconsumptiontracker/repositories/auth_repository.dart';

List<Dependency> get appDependencies => [
  Dependency((_) => AuthRepository())
];