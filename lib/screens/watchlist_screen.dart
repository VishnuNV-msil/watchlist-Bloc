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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SearchPage(watchlistnum),
            ),
          );
        },
      ),
    );
  }

}
