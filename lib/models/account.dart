class Account {
  const Account({
    required this.name,
    required this.phone,
    required this.password,
    this.isStaff = false,
  });

  final String name;
  final String phone;
  final String password;
  final bool isStaff;
}
