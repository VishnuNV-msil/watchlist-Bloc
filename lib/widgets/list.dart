import 'dart:developer';

import 'package:flutter/material.dart';
import '../model/user_model.dart';

Widget UserList(List<UserModel> userList) {
  log('called listview from search');
  return Expanded(
    child: ListView.builder(
      itemCount: userList.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Card(
            color: Colors.black12,
            child: ListTile(
              title: Text(
                '${userList[index].name} ',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              subtitle: Text(
                '${userList[index].contacts} ',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              trailing: CircleAvatar(
                backgroundImage: NetworkImage(userList[index].url),
              ),
            ),
          ),
        );
      },
    ),
  );
}
