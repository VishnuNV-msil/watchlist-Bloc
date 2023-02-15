
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../model/user_model.dart';
import '../repo/repositories.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  List<UserModel> userList = [];
  List<UserModel> watchList1 = [];
  List<UserModel> watchList2 = [];
  List<UserModel> watchList3 = [];

  UserBloc(this._userRepository) : super(UserInitialState()) {
    on<UserEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        List<UserModel> userlist = [];
        var preferences = await SharedPreferences.getInstance();
        int watchlistnum = event.intData;
        final users2 = await _userRepository.getUsers();




    if (watchlistnum == 1) {
      final string1 = preferences.getString('watchlist1');
      if (string1 != null) {
        final userList = jsonDecode(string1) as List;
        userlist = userList.map((e) => UserModel.fromJson(e)).toList();
        emit(UserLoadedState(userlist));
      } else {
        print('list1 is null');
      }
    } else if (watchlistnum == 2) {
      final string2 = preferences.getString('watchlist2');
      if (string2 != null) {
        final userList = jsonDecode(string2) as List;
        userlist = userList.map((e) => UserModel.fromJson(e)).toList();
        emit(UserLoadedState(userlist));
      } else {
        print('list2 is null');
      }
    } else {
      final string3 = preferences.getString('watchlist3');
      if (string3 != null) {
        final userList = jsonDecode(string3) as List;
        userlist = userList.map((e) => UserModel.fromJson(e)).toList();
        emit(UserLoadedState(userlist));
      } else {
        print('list3 is null');
      }
    }
       


        
        // final users = await _userRepository.getUsers();
        // userList = users;
        // emit(UserLoadedState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
