class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.subtitle = '',
  });

  final String id;
  final String name;
  final String email;
  final String subtitle;
}
