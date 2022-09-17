import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_days/repositories/my_days_repository.dart';

part 'add_day_state.dart';

class AddDayCubit extends Cubit<AddDayState> {
  AddDayCubit(this._myDaysRepository) : super(const AddDayState());

  final MyDaysRepository _myDaysRepository;

  Future<void> add(
    String textData,
    DateTime date, {
    double rating = 0.0,
    bool ratingUpdate = false,
  }) async {
    try {
      _myDaysRepository.add(textData, date);
    } catch (error) {
      emit(
        AddDayState(errorMessage: error.toString()),
      );
    }
  }
}
