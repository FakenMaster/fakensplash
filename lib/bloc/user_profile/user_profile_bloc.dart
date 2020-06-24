import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';
part 'user_profile_bloc.freezed.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  @override
  UserProfileState get initialState => UserProfileInitial();

  @override
  Stream<UserProfileState> mapEventToState(
    UserProfileEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
