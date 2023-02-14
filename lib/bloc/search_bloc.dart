import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/user_model.dart';
import '../repo/repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<UserModel> watchList1 = [];
  List<UserModel> watchList2 = [];
  List<UserModel> watchList3 = [];

  SearchBloc() : super(SearchInitial()) {
    on<FetchDataEvent>((event, emit) async {
      print('called search bloc');
      emit(SearchLoadingState());
      try {
        var preferences = await SharedPreferences.getInstance();
        final string1 = preferences.getString('watchlist1');
        if (string1 != null) {
          final userList = jsonDecode(string1) as List;
          watchList1 = userList.map((e) => UserModel.fromJson(e)).toList();
        } else {
          print('Watchlist1 is null');
        }
        final users = watchList1;
        emit(SearchLoadedState(users));
      } catch (e) {
        emit(SearchErrorState('no matching results found'));
      }
    });
  }
}
