import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_days/models/new_day_model.dart';
import 'package:my_days/repositories/my_days_repository.dart';

part 'my_days_state.dart';

class MyDaysCubit extends Cubit<MyDaysState> {
  MyDaysCubit(this._myDaysRepository)
      : super(
          const MyDaysState(
            documents: [],
            isLoading: false,
            errorMessage: '',
          ),
        );

  final MyDaysRepository _myDaysRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const MyDaysState(
        documents: [],
        isLoading: true,
        errorMessage: '',
      ),
    );

    _streamSubscription = _myDaysRepository.getNewDayStream().listen((data) {
      emit(
        MyDaysState(
          documents: data,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          MyDaysState(
            documents: const [],
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

  Future<void> remove(String id) async {
    await _myDaysRepository.delete(id);
  }

  Future<void> ratingUpdate(
    String id,
    double rating,
  ) async {
    _myDaysRepository.ratingUpdate(id, rating);
  }
}
