import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'my_days_state.dart';

class MyDaysCubit extends Cubit<MyDaysState> {
  MyDaysCubit()
      : super(
          const MyDaysState(
            documents: [],
            isLoading: false,
            errorMessage: '',
          ),
        );

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const MyDaysState(
        documents: [],
        isLoading: true,
        errorMessage: '',
      ),
    );

    _streamSubscription = FirebaseFirestore.instance
        .collection('mydays')
        .orderBy('date')
        .snapshots()
        .listen((data) {
      emit(
        MyDaysState(
          documents: data.docs,
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
    FirebaseFirestore.instance.collection('mydays').doc(id).delete();
  }
}
