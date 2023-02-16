import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/search_bloc.dart';
import '../bloc/checkbox_bloc.dart';
import '../model/user_model.dart';
import '../homepage.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  int watchlistnum;
  List<UserModel> currentWatchlist;
  List<int> selectedIndexList = [];
  List<UserModel> selecteduserlist = [];

  // ignore: use_key_in_widget_constructors
  SearchPage(this.watchlistnum, this.currentWatchlist);
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(watchlistnum - 1),
                ));
          },
        ),
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
                  searchBar(context),
                ],
              );
            }

            if (state is SearchLoadedState) {
              List<UserModel> userList = state.users;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    searchBar(context),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 160,
                      width: MediaQuery.of(context).size.width,
                      child: BlocBuilder<CheckboxBloc, CheckboxState>(
                        builder: (context, state) {
                          return searchList(userList, context);
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
                  searchBar(context),
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
    } else {}
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

  Widget searchBar(BuildContext context) {
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

  Widget searchList(List<UserModel> userList, BuildContext context) {
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
                  if ((selectedIndexList.isEmpty) || !(selectedIndexList.contains(index))) {
                    selectedIndexList.add(index);
                    selecteduserlist.add(userList[index]);
                  } else {
                    selectedIndexList.remove(index);
                    selecteduserlist.remove(userList[index]);
                  }
                  addtoDB(selecteduserlist);
                  BlocProvider.of<CheckboxBloc>(context)
                      .add(CheckboxPressEvent());
                },
                selected: false,
                value: selectedIndexList.contains(index),
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
