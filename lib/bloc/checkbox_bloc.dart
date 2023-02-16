import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/user_model.dart';

part 'checkbox_event.dart';
part 'checkbox_state.dart';

class CheckboxBloc extends Bloc<CheckboxEvent, CheckboxState> {
  List<UserModel> watchList = [];

  CheckboxBloc() : super(CheckboxInitial()) {
    on<CheckboxEvent>((event, emit) async {
      emit( CheckBoxLoadedState());
    });
  }
}
