import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';
import '../repo/repositories.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  List<UserModel> userList = [];
  List<UserModel> watchList1 = [];
  List<UserModel> watchList2 = [];

  UserBloc(this._userRepository) : super(UserInitialState()) {
    on<UserEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await _userRepository.getUsers();
        userList = users;
         print(users.last.name);
        //savedata();
        //preferences.setString('savedlist', userList.toString());
        emit(UserLoadedState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
  // void savedata() async {
  //   print('save data is called');
  //   var pref = await SharedPreferences.getInstance();
  //   var values = pref .setString('savedlist', userList.toString());
  //   log('saved data is: ${userList.toString()}');
  // }
}
