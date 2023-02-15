part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}
class ButtonPressEvent extends SearchEvent {
@override
  List<Object> get props => [];
}

class FetchDataEvent extends SearchEvent {
  final int intData;
  const FetchDataEvent(this.intData);
  @override
  List<Object> get props => [];
}
