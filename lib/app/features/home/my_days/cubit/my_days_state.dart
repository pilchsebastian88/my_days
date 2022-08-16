part of 'my_days_cubit.dart';

@immutable
class MyDaysState {
  const MyDaysState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
  });

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  final bool isLoading;
  final String errorMessage;
}
