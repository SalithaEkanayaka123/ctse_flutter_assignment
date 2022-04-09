class Library {
  String id;
  String name;
  String optional;
  String color;
  String userId;


  Library({
    required this.id,
    required this.name,
    required this.optional,
    required this.color,
    required this.userId
  });

  Library.fromMap(Map<String, dynamic> snapshot, String id)
      :
        id = id ?? '',
        name = snapshot['name'] ?? '',
        optional = snapshot['optional'] ?? '',
        color = snapshot['color'] ?? '',
        userId = snapshot['userId']?? '';


  toJson() {
    return {
      "name": name,
      "optional": optional,
      "color": color,
      "userId": userId,
    };
  }
}