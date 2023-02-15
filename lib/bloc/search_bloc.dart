import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/user_model.dart';
import '../repo/repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/search_screen.dart';

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
         List<UserModel> userlist = [];
        var preferences = await SharedPreferences.getInstance();
        int watchlistnum = event.intData;






       if (watchlistnum == 1) {
      final string1 = preferences.getString('watchlist1');
      if (string1 != null) {
        final userList = jsonDecode(string1) as List;
        userlist = userList.map((e) => UserModel.fromJson(e)).toList();
        emit(SearchLoadedState(userlist));
      } else {
        print('list1 is null');
        emit(SearchErrorState('no matching results found'));
      }
    } else if (watchlistnum == 2) {
      final string2 = preferences.getString('watchlist2');
      if (string2 != null) {
        final userList = jsonDecode(string2) as List;
        userlist = userList.map((e) => UserModel.fromJson(e)).toList();
        emit(SearchLoadedState(userlist));
      } else {
        print('list2 is null');
        emit(SearchErrorState('no matching results found'));
      }
    } else {
      final string3 = preferences.getString('watchlist3');
      if (string3 != null) {
        final userList = jsonDecode(string3) as List;
        userlist = userList.map((e) => UserModel.fromJson(e)).toList();
        emit(SearchLoadedState(userlist));
      } else {
        print('list3 is null');
        emit(SearchErrorState('no matching results found'));
      }
    }









        // final string1 = preferences.getString('watchlist1');
        // if (string1 != null) {
        //   final userList = jsonDecode(string1) as List;
        //   watchList1 = userList.map((e) => UserModel.fromJson(e)).toList();
        //   final users = watchList1;
        //   if (users.length == 0) {
        //     print('Watchlist1 is null');
        //     emit(SearchErrorState('no matching results found'));
        //   } else {
        //     emit(SearchLoadedState(users));
        //   }
        // } else {
        //   print('Watchlist1 is null');
        //   emit(SearchErrorState('no matching results found'));
        // }
      } catch (e) {
        emit(SearchErrorState('no matching results found'));
      }
    });
  }
}
