import 'package:flutter/material.dart';
import '../model/user_model.dart';
import '../bloc/checkbox_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget SearchList(List<UserModel> userList) {
  print('called listview from search');
  List<int> sel = [2, 3, 4];
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
                
                sel.add(index);

                // if (checkbox) {
                //   checkbox = false;
                // } else {
                //   checkbox = true;
                // }
              },
              selected: false,
              value: sel.contains(index),
              // trailing:
              // IconButton(
              //   icon: const Icon(Icons.add),
              //   onPressed: () async {

              //   },)
            ),
          ),
        );
      },
    ),
  );
}
