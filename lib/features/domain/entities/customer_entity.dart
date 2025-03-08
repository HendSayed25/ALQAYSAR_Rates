class CustomerEntity {
  final int? id;
  final String name;
  final int? branch;

  const CustomerEntity({
    this.id,
    required this.name,
    required this.branch
  });
}