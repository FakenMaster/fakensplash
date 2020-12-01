import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/repository/repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';
part 'user_profile_bloc.freezed.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc() : super(UserProfileState.initial());


  @override
  Stream<UserProfileState> mapEventToState(
    UserProfileEvent event,
  ) async* {
    yield UserProfileState.loading();
    if (event is UserProfileLoad) {
      yield await loadData(event.username);
    }
  }

  Future<UserProfileState> loadData(String username) async {
    try {
      var data = await GetIt.I<Repository>().userProfile(username);
      if (data is User) {
        return UserProfileState.success(data);
      }
      return UserProfileState.error('null');
    } catch (e) {
      print('用户详情异常:$e');
      return UserProfileState.error(e);
    }
  }
}
