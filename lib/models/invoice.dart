class Invoice {
  final int id;
  final String date;
  final String image;
  final String description;

  const Invoice({
    required this.id,
    required this.date,
    required this.image,
    required this.description,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      image: json['image'],
      description: json['description'],
      date: json['date'],
    );
  }

  @override
  String toString() {
    return (description);
  }
}
