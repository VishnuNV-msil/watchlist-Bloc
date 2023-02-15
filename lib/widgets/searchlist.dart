import 'package:flutter/material.dart';
import '../model/user_model.dart';

Widget SearchList(List<UserModel> userList) {
  List<int> sel = [];
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
