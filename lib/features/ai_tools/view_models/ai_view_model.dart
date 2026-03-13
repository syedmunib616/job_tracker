import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../core/services/ai_services.dart';

final aiProvider =
StateNotifierProvider<AIViewModel, String?>((ref) => AIViewModel());

class AIViewModel extends StateNotifier<String?> {
  AIViewModel() : super(null);

  final AIService _aiService = AIService();

  Future<void> generateAIResponse(String prompt) async {
    state = "Loading...";

    try {
      final result = await _aiService.generateResponse(prompt);
      state = result;
    } catch (e) {
      state = "Something went wrong";
    }
  }
}