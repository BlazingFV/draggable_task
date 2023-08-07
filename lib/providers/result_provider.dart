import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultRepository {
  String selectedImage = '';
  bool isCorrectAnswer = false;

  resetGame() {
    selectedImage = '';
    isCorrectAnswer = false;
  }
}

final resultRepositoryProvider = Provider<ResultRepository>((ref) {
  return ResultRepository();
});
final selectedImageProvider = StateProvider<String>((ref) {
  final resultRepository = ref.watch(resultRepositoryProvider);
  return resultRepository.selectedImage;
});
final isCorrectAnswerProvider = StateProvider<bool>((ref) {
  final resultRepository = ref.watch(resultRepositoryProvider);
  return resultRepository.isCorrectAnswer;
});
