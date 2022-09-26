import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_days/repositories/users_repository.dart';

part 'root_state.dart';

class RootCubit extends Cubit<RootState> {
  RootCubit(this.usersRepository)
      : super(
          const RootState(
            user: null,
            isLoading: false,
            errorMessage: '',
          ),
        );

  final UsersRepository usersRepository;

  StreamSubscription? _streamSubscription;

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await usersRepository.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      emit(
        RootState(
          user: null,
          isLoading: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await usersRepository.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      emit(RootState(
          user: null, isLoading: false, errorMessage: error.toString()));
    }
  }

  Future<void> signOut() async {
    usersRepository.signOut();
  }

  Future<void> start() async {
    emit(
      const RootState(
        user: null,
        isLoading: true,
        errorMessage: '',
      ),
    );

    _streamSubscription = usersRepository.getUserStream().listen((user) {
      emit(
        RootState(
          user: user,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          RootState(
            user: null,
            isLoading: false,
            errorMessage: error.toString(),
          ),
        );
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
