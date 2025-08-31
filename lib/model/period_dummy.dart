class Period {
  final String name;
  final String range;
  final bool isCurrent;

  Period({
    required this.name,
    required this.range,
    this.isCurrent = false,
  });
}

final List<Period> dummyPeriods = [
  Period(name: "All Time", range: "All Time"),
  Period(
    range: "Januari - Maret 2025",
    name: 'Winter Season',
    isCurrent: false,
  ),
  Period(
      range: "Oktober - Desember 2025",
      isCurrent: true,
      name: 'Current Season'),
  Period(range: "Juli - Agustus 2025", name: 'Summer Season', isCurrent: false),
];
