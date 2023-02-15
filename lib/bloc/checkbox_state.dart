part of 'checkbox_bloc.dart';

abstract class CheckboxState extends Equatable {
  const CheckboxState();
  
  @override
  List<Object?> get props => [];
}

class CheckboxInitial extends CheckboxState {
  @override
  List<Object?> get props => [];
}

class CheckBoxLoadedState extends CheckboxState {
  final List<UserModel> users;
  CheckBoxLoadedState(this.users);
  @override
  List<Object?> get props => [users];
}
