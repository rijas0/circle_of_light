class Surah {
  const Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.arabicName,
    required this.verseCount,
    required this.revelationType,
  });

  final int number;
  final String name;
  final String englishName;
  final String arabicName;
  final int verseCount;
  final RevelationType revelationType;
}

enum RevelationType { makki, madani }
