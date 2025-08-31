class Sport {
  final String name;
  final String image;
  final bool isPreferred; // biar bisa bedakan asalnya

  Sport({
    required this.name,
    required this.image,
    required this.isPreferred,
  });
}

final List<Sport> preferredSports = [
  Sport(
      isPreferred: true,
      name: "Badminton",
      image: "assets/icons/ic_badminton.svg"),
  Sport(isPreferred: true, name: "Squash", image: "assets/icons/ic_squash.svg"),
  Sport(isPreferred: true, name: "Padel", image: "assets/icons/ic_padel.svg"),
  Sport(
      isPreferred: true,
      name: "Mini Soccer",
      image: "assets/icons/ic_futsal.svg"),
];

final List<Sport> allSports = [
  Sport(
      isPreferred: false,
      name: "Tenis Meja",
      image: "assets/icons/ic_tenis_meja.svg"),
  Sport(isPreferred: false, name: "Tenis", image: "assets/icons/ic_tennis.svg"),
  Sport(
      isPreferred: false,
      name: "Pickleball",
      image: "assets/icons/ic_pickleball.svg"),
];
