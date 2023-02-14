import 'dart:developer';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/user_bloc.dart';
import '../bloc/search_bloc.dart';
import '../model/user_model.dart';
import '../repo/repositories.dart';
import '../widgets/list.dart';

class SearchPage extends StatelessWidget {
  int watchlistnum;

  SearchPage(this.watchlistnum);
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: BlocProvider(
        create: (context) => SearchBloc(),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width - 10,
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              labelText:
                                  'Search & add to Watchlist: $watchlistnum',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              )),
                          onSubmitted: (value) {
                            getdata(_controller.text);
                            _controller.clear();
                            BlocProvider.of<SearchBloc>(context)
                                .add(FetchDataEvent());
                          },
                          controller: _controller,
                          //keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }

            if (state is SearchLoadedState) {
              List<UserModel> userList = state.users;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
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
                                labelText:
                                    'Search & add to Watchlist: $watchlistnum',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                )),
                            onSubmitted: (value) {
                              getdata(_controller.text);
                              _controller.clear();
                              BlocProvider.of<SearchBloc>(context)
                                  .add(FetchDataEvent());
                            },
                            controller: _controller,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 125,
                      width: MediaQuery.of(context).size.width,
                      child: UserList(userList),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text("No matching result"),
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getdata(String txt) async {
    print('get data called');
    var preferences = await SharedPreferences.getInstance();
    List<UserModel> userlist = [];

    final string = preferences.getString('user_list');
    if (string != null) {
      final userList = jsonDecode(string) as List;
      userlist = userList.map((e) => UserModel.fromJson(e)).toList();
    } else {
      print('list is null');
    }

    var values = (preferences.getString('savedlist'));
    if (watchlistnum == 1) {}

    List<UserModel> templist = [];

    for (int i = 0; i < userlist.length; i++) {
      if (userlist.elementAt(i).name.contains(txt)) {
        templist.add(userlist.elementAt(i));

      } else {}
    }
    if (watchlistnum == 1) {
      List<UserModel> watchlist1 = templist;
      log('watchlist1 is : ${watchlist1.toString()}');
      final string = jsonEncode(templist);
      await preferences.setString('watchlist1', string);
    } else if (watchlistnum == 2) {
      List<UserModel> watchlist2 = templist;
      log('watchlist2 is : ${watchlist2.toString()}');
      final string = jsonEncode(templist);
      await preferences.setString('watchlist2', string);
    } else {
      List<UserModel> watchlist3 = templist;
      log('watchlist3 is : ${watchlist3.toString()}');
      final string = jsonEncode(templist);
      await preferences.setString('watchlist3', string);
    }

    if (string != null) {
      print('saved data is: ${values}');
      if (string.contains(txt)) {
        print('true result found');
        return true;
      } else {
        print('false no matching result');
        return false;
      }
    } else {
      print('false outside');
      return false;
    }
  }
}
