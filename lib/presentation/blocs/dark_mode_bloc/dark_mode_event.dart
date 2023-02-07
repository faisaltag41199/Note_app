import 'package:equatable/equatable.dart';

abstract class DarkModeEvent extends Equatable{
 const DarkModeEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EnableDarkModeEvent extends DarkModeEvent{
  final bool darkMode;
  EnableDarkModeEvent(this.darkMode);

  @override
  // TODO: implement props
  List<Object?> get props => [this.darkMode];

}

