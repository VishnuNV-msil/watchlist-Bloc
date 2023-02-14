import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import '../model/user_model.dart';
import '../repo/repositories.dart';
import '../screens/search_screen.dart';
import './widgets/list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(
            create: (BuildContext context) => UserBloc(UserRepository()),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
              bottom: const TabBar(tabs: [
                Text(
                  'Watchlist 1',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  'Watchlist 2',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  'Watchlist 3',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ]),
              title: const Text('The WatchlistApp')),
          body: TabBarView(children: [
            blocBody(),
            SearchPage(1),
            SearchPage(2),
          ]),
        ),
      ),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => UserBloc(
        UserRepository(),
      )..add(LoadUserEvent()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserLoadedState) {
            List<UserModel> userList = state.users;
            return UserList(userList);
          }
          if (state is UserErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget blocBody3() {
    return BlocProvider(
      create: (context) => UserBloc(
        UserRepository(),
      ),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return const Center(
            child: Text("Custom Watchlist"),
          );
        },
      ),
    );
  }
}
