import 'package:equatable/equatable.dart';

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'checkbox_event.dart';
part 'checkbox_state.dart';

class CheckboxBloc extends Bloc<CheckboxEvent, CheckboxState> {
  List<UserModel> watchList = [];

  CheckboxBloc() : super(CheckboxInitial()) {
    on<CheckboxEvent>((event, emit) async {

      var preferences = await SharedPreferences.getInstance();
      final string1 = preferences.getString('watchlist1');
      if (string1 != null) {
        final userList = jsonDecode(string1) as List;
        watchList = userList.map((e) => UserModel.fromJson(e)).toList();
        final users = watchList;
        emit(CheckBoxLoadedState(users));
      } else {
        // emit(SearchErrorState('no matching results found'));
      }
    });
  }
}
