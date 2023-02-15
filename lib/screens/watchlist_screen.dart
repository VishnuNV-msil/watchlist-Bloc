import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/user_bloc.dart';
import '../model/user_model.dart';
import '../repo/repositories.dart';
import '../widgets/list.dart';
import './search_screen.dart';

class WatchlistPage extends StatelessWidget {
  int watchlistnum;
  WatchlistPage(this.watchlistnum);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => UserBloc(
          UserRepository(),
        )..add(LoadUserEvent(watchlistnum)),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserLoadedState) {
              List<UserModel> userList = state.users;
               //List<UserModel> userList =  getlistdata();
              return Container(
                child: UserList(userList),
                height: MediaQuery.of(context).size.height - 100,
              );
            }
            if (state is UserErrorState) {
              return const Center(
                child: Text("Error"),
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        onPressed: () {
          //SearchPage(watchlistnum);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SearchPage(watchlistnum),
            ),
          );
        },
      ),
    );
  }

  // Future<List<UserModel>> getlistdata() async {
  //   List<UserModel> userlist = [];
  //   var preferences = await SharedPreferences.getInstance();

  //   if (watchlistnum == 1) {
  //     final string1 = preferences.getString('watchlist1');
  //     if (string1 != null) {
  //       final userList = jsonDecode(string1) as List;
  //       userlist = userList.map((e) => UserModel.fromJson(e)).toList();
  //     } else {
  //       print('list1 is null');
  //     }
  //   } else if (watchlistnum == 2) {
  //     final string2 = preferences.getString('watchlist2');
  //     if (string2 != null) {
  //       final userList = jsonDecode(string2) as List;
  //       userlist = userList.map((e) => UserModel.fromJson(e)).toList();
  //     } else {
  //       print('list2 is null');
  //     }
  //   } else {
  //     final string3 = preferences.getString('watchlist3');
  //     if (string3 != null) {
  //       final userList = jsonDecode(string3) as List;
  //       userlist = userList.map((e) => UserModel.fromJson(e)).toList();
  //     } else {
  //       print('list3 is null');
  //     }
  //   }
  //   return userlist;
  // }



}
