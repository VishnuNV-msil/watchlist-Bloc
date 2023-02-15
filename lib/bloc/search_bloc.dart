import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<UserModel> watchList1 = [];
  List<UserModel> watchList2 = [];
  List<UserModel> watchList3 = [];

  SearchBloc() : super(SearchInitial()) {
    on<FetchDataEvent>((event, emit) async {
      emit(SearchLoadingState());
      try {
        List<UserModel> userlist = [];
        var preferences = await SharedPreferences.getInstance();
        int watchlistnum = event.intData;

        if (watchlistnum == 1) {
          final string1 = preferences.getString('tempwatchlist1');
          if (string1 != null) {
            final userList = jsonDecode(string1) as List;
            userlist = userList.map((e) => UserModel.fromJson(e)).toList();
             if (userList.isEmpty) {
              emit(const SearchErrorState('no matching results found'));
            } else {
              emit(SearchLoadedState(userlist));
            }
          } else {
            emit(const SearchErrorState('no matching results found'));
          }
        } else if (watchlistnum == 2) {
          final string2 = preferences.getString('tempwatchlist2');
          if (string2 != null) {
            final userList = jsonDecode(string2) as List;
            userlist = userList.map((e) => UserModel.fromJson(e)).toList();
            if (userList.isEmpty) {
              emit(const SearchErrorState('no matching results found'));
            } else {
              emit(SearchLoadedState(userlist));
            }
          } else {
            emit(const SearchErrorState('no matching results found'));
          }
        } else {
          final string3 = preferences.getString('tempwatchlist3');
          if (string3 != null) {
            final userList = jsonDecode(string3) as List;
            userlist = userList.map((e) => UserModel.fromJson(e)).toList();
             if (userList.isEmpty) {
              emit(const SearchErrorState('no matching results found'));

            } else {
              emit(SearchLoadedState(userlist));
            }
          } else {
            emit(const SearchErrorState('no matching results found'));
          }
        }
      } catch (e) {
        emit(const SearchErrorState('no matching results found'));
      }
    });
  }
}
