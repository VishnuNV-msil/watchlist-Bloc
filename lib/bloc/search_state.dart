part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {
   @override
  List<Object?> get props => [];
}

class SearchLoadingState extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoadedState extends SearchState {
  final List<UserModel> users;
  SearchLoadedState(this.users);
  @override
  List<Object?> get props => [users];
}

class SearchErrorState extends SearchState {
  final String error;
  SearchErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
