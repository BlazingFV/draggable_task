enum AssetType {
  question('q'),
  answer('a');

  const AssetType(this.abbreviation);
  final String abbreviation;
}

class AssetManager {
  static String path({required int id, required AssetType assetType}) {
    return 'assets/${assetType.abbreviation}$id.png';
  }

  static const howto = 'assets/howto.png';

  static List<String> get questionPaths => List.generate(
      5, (index) => path(id: index + 1, assetType: AssetType.question));

  static List<String> get answerPaths => List.generate(
      5, (index) => path(id: index + 1, assetType: AssetType.answer));
}
