import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import '../model/user_model.dart';
import '../repo/repositories.dart';
import '../widgets/list.dart';
import './search_screen.dart';
import '../homepage.dart';

// ignore: must_be_immutable
class WatchlistPage extends StatelessWidget {
  int watchlistnum;
  List<UserModel> loadedUserlist = [];
  // ignore: use_key_in_widget_constructors
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
              loadedUserlist = state.users;
              return SizedBox(
                height: MediaQuery.of(context).size.height - 100,
                child: userList(loadedUserlist),
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
          _navigateAndDisplaySelection(context);
        },
      ),
    );
  }

Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    final shouldReload = await Navigator.push(
      context,
      MaterialPageRoute(
              builder: (context) => SearchPage(watchlistnum, loadedUserlist),
            ),
    );
    if (shouldReload) {
       // ignore: use_build_context_synchronously
       Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(watchlistnum - 1),
      ),
    );
    }
  }

}
