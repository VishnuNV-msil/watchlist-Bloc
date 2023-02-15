part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUserEvent extends UserEvent {
  final int intData;
  const LoadUserEvent(this.intData);
  @override
  List<Object?> get props => [];
}
