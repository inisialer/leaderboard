class CategorySport {
  final String name;
  final bool isIndividu;
  final bool isTunggal;

  CategorySport({
    required this.name,
    required this.isIndividu,
    required this.isTunggal,
  });
}

final List<CategorySport> allCategorySports = [
  CategorySport(
    isIndividu: true,
    isTunggal: true,
    name: "Tunggal",
  ),
  CategorySport(
    isIndividu: true,
    isTunggal: false,
    name: "Ganda",
  ),
  CategorySport(
    isIndividu: false,
    isTunggal: false,
    name: "Komunitas",
  ),
];
