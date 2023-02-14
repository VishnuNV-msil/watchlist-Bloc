import 'dart:developer';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/user_bloc.dart';
import '../model/user_model.dart';
import '../repo/repositories.dart';

class SearchPage extends StatelessWidget {
  int watchlistnum;

  SearchPage(this.watchlistnum);
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        UserRepository(),
      ),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadedState) {
            List<UserModel> userList = state.users;
            print('search');
          }
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
                          labelText: 'Search & add to Watchlist: $watchlistnum',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.black),
                          )),
                      onSubmitted: (value) {
                        getdata(_controller.text);
                        _controller.clear();
                      },
                      controller: _controller,
                      //keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),

            //  Expanded(
            //   //child: ListView.builder(itemBuilder: itemBuilder),
            //  ),
            ],
          );

          //const Center(
          //   child: Text("Search screen"),
          // );
        },
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
    List<UserModel> watchList1 = [];

    for (int i = 0; i < userlist.length; i++) {
      if (userlist.elementAt(i).name.contains(txt)) {
        watchList1.add(userlist.elementAt(i));
        log(watchList1.toString());
        log(watchList1.length.toString());
      } else {}
    }

    if (values != null) {
      print('saved data is: ${values}');
      if (values.contains(txt)) {
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
