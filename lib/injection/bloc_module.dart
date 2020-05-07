import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mediaconsumptiontracker/blocs/rldb_bloc.dart';

import '../blocs/auth_bloc.dart';

List<Bloc> get appBlocs => [
  Bloc((i) => AuthBloc(i.get())),
  Bloc((i) => RldbBloc(i.get()))
];