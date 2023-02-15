part of 'checkbox_bloc.dart';

abstract class CheckboxEvent extends Equatable {
  const CheckboxEvent();
}

class CheckboxPressEvent extends CheckboxEvent {
@override
  List<Object> get props => [];
}
