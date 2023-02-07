
import 'package:equatable/equatable.dart';

abstract class DarkModeState extends Equatable{
  const DarkModeState();

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class DarkModeInitialState extends DarkModeState{}

class DarkModeLoadingState extends DarkModeState{}
class DarkModeSuccessState extends DarkModeState{}
class DarkModeErrorState extends DarkModeState{

  final String message;
  DarkModeErrorState(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [this.message];

}

