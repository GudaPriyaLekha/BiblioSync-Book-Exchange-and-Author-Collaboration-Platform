// class Book {
//   final String id;
//   final String title;
//   final String author;
//   final String? coverUrl;
//   final double? rating;
//   final bool isAvailable;
//   final List<String>? genres;
//   final String? description;

//   Book({
//     required this.id,
//     required this.title,
//     required this.author,
//     this.coverUrl,
//     this.rating,
//     this.isAvailable = true,
//     this.genres,
//     this.description,
//   });
// }
class Book {
  final String id;
  final String title;
  final String author;
  final String? description;
  final List<String>? genres;
  final String? publishYear;
  final String? owner;
  final String status; // 'Available', 'Exchanged', etc.
  final String? borrower;
  final String? exchangeDate;
  final String? borrowDate;
  final String? returnDate;

  // 👇 New fields added:
  final String? coverUrl;
  final double? rating;

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.description,
    this.genres,
    this.publishYear,
    this.owner,
    this.status = 'Available',
    this.borrower,
    this.exchangeDate,
    this.borrowDate,
    this.returnDate,
    this.coverUrl,
    this.rating,
  });

  // 👇 Computed property for convenience
  bool get isAvailable => status == 'Available';

  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? description,
    List<String>? genres,
    String? publishYear,
    String? owner,
    String? status,
    String? borrower,
    String? exchangeDate,
    String? borrowDate,
    String? returnDate,
    String? coverUrl,
    double? rating,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      genres: genres ?? this.genres,
      publishYear: publishYear ?? this.publishYear,
      owner: owner ?? this.owner,
      status: status ?? this.status,
      borrower: borrower ?? this.borrower,
      exchangeDate: exchangeDate ?? this.exchangeDate,
      borrowDate: borrowDate ?? this.borrowDate,
      returnDate: returnDate ?? this.returnDate,
      coverUrl: coverUrl ?? this.coverUrl,
      rating: rating ?? this.rating,
    );
  }
}
