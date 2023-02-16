import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import '../repo/repositories.dart';
import '../screens/watchlist_screen.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  //const HomePage({super.key});
  int watchlistnum;
  // ignore: use_key_in_widget_constructors
  HomePage(this.watchlistnum);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: watchlistnum,
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
            WatchlistPage(1),
            WatchlistPage(2),
            WatchlistPage(3),
          ]),
        ),
      ),
    );
  }
}
