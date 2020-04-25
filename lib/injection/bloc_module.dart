import 'package:bloc_pattern/bloc_pattern.dart';

import '../blocs/auth_bloc.dart';

List<Bloc> get appBlocs => [
  Bloc((i) => AuthBloc(i.get()))
];