import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/search_bloc.dart';
import '../bloc/checkbox_bloc.dart';
import '../model/user_model.dart';

class SearchPage extends StatelessWidget {
  int watchlistnum;
  List<UserModel> currentWatchlist;
  List<int> sel = [];
  List<UserModel> userlist1 = [];

  SearchPage(this.watchlistnum, this.currentWatchlist);
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SearchBloc(),
          ),
          BlocProvider(
            create: (context) => CheckboxBloc(),
          ),
        ],
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SearchInitial) {
              return Column(
                children: [
                  SearchBar(context),
                ],
              );
            }

            if (state is SearchLoadedState) {
              List<UserModel> userList = state.users;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SearchBar(context),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 160,
                      width: MediaQuery.of(context).size.width,
                      child: BlocBuilder<CheckboxBloc, CheckboxState>(
                        builder: (context, state) {
                          return SearchList(userList, context);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is SearchErrorState) {
              return Column(
                children: [
                  SearchBar(context),
                  const Expanded(
                    child: Text("No matching result"),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text("No matching result"),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> getdata(String txt) async {
    var preferences = await SharedPreferences.getInstance();
    List<UserModel> userlist = [];
    final string = preferences.getString('user_list');
    if (string != null) {
      final userList = jsonDecode(string) as List;
      userlist = userList.map((e) => UserModel.fromJson(e)).toList();
    } else {
      print('list is null');
    }
    List<UserModel> templist = [];
    for (int i = 0; i < userlist.length; i++) {
      if (userlist.elementAt(i).name.contains(txt)) {
        templist.add(userlist.elementAt(i));
      } else {}
    }
    if (watchlistnum == 1) {
      final string = jsonEncode(templist);
      await preferences.setString('tempwatchlist1', string);
    } else if (watchlistnum == 2) {
      final string = jsonEncode(templist);
      await preferences.setString('tempwatchlist2', string);
    } else {
      final string = jsonEncode(templist);
      await preferences.setString('tempwatchlist3', string);
    }
  }

  Widget SearchBar(BuildContext context) {
    bool checkbox = false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 70,
          width: MediaQuery.of(context).size.width - 10,
          padding: const EdgeInsets.all(10),
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                labelText: 'Search & add to Watchlist: $watchlistnum',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                )),
            onSubmitted: (value) {
              getdata(_controller.text);
              _controller.clear();
              BlocProvider.of<SearchBloc>(context)
                  .add(FetchDataEvent(watchlistnum));
            },
            controller: _controller,
          ),
        ),
      ],
    );
  }

  Widget SearchList(List<UserModel> userList, BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Card(
              color: Colors.black12,
              child: CheckboxListTile(
                title: Text(
                  '${userList[index].name} ',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                subtitle: Text(
                  '${userList[index].contacts} ',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                autofocus: false,
                activeColor: Colors.green,
                checkColor: Colors.white,
                onChanged: (value) {
                  if ((sel.isEmpty) || !(sel.contains(index))) {
                    sel.add(index);
                    userlist1.add(userList[index]);
                  } else {
                    sel.remove(index);
                    userlist1.remove(userList[index]);
                  }
                  addtoDB(userlist1);
                  BlocProvider.of<CheckboxBloc>(context)
                      .add(CheckboxPressEvent());
                },
                selected: false,
                value: sel.contains(index),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> addtoDB(List<UserModel> userlist) async {
    var pref = await SharedPreferences.getInstance();
    if (watchlistnum == 1) {
      userlist = userlist + currentWatchlist;
      final strList1 = jsonEncode(userlist);
      pref.setString('watchlist1', strList1);
    } else if (watchlistnum == 2) {
      userlist = userlist + currentWatchlist;
      final strList2 = jsonEncode(userlist);
      pref.setString('watchlist2', strList2);
    } else {
      userlist = userlist + currentWatchlist;
      final strList3 = jsonEncode(userlist);
      pref.setString('watchlist3', strList3);
    }
    return;
  }
}
