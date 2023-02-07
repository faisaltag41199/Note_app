
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:noteapp/core/error/failure.dart';

abstract class NoteBaseUsecase<T,Parameters>{


  Future<Either<Failure,T>> call(Parameters parameters);


}

class VoidParameters extends Equatable{

  const VoidParameters();

  @override
  // TODO: implement props
  List<Object?> get props => [];

}