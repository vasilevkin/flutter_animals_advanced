class Cat {
  final String id;
  final String name;
  final String description;

  Cat({required this.id, required this.name, required this.description});

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  @override
  String toString() {
    return 'Cat: id=$id, name=$name';
  }
}
