part of 'my_days_cubit.dart';

@immutable
class MyDaysState {
  const MyDaysState({
    this.documents = const [],
    required this.isLoading,
    required this.errorMessage,
  });

  final List<NewDayModel> documents;
  final bool isLoading;
  final String errorMessage;
}
