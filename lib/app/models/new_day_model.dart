class NewDayModel {
  NewDayModel({
    required this.id,
    required this.date,
    required this.textData,
    required this.rating,
    required this.ratingUpdate,
  });

  final String id;
  final DateTime date;
  final String textData;
  final double rating;
  final bool ratingUpdate;
}
