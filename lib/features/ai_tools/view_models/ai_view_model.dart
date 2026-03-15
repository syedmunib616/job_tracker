import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../core/services/ai_services.dart';

final aiProvider =
StateNotifierProvider<AIViewModel, String?>((ref) => AIViewModel());

final resumeAnalyzerProvider =
StateNotifierProvider<AIViewModel, String?>((ref) => AIViewModel());

final jobAnalyzerProvider =
StateNotifierProvider<AIViewModel, String?>((ref) => AIViewModel());

final coverLetterProvider =
StateNotifierProvider<AIViewModel, String?>((ref) => AIViewModel());

final interviewQuestionsProvider =
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


  Future<void> analyzeResume(String resumeText) async {
    state = "Analyzing resume...";

    final prompt = """
    You are a professional resume reviewer.
    
    Analyze the following resume and give suggestions to improve it for ATS systems.
    
    Resume:
    $resumeText
    """;

    try {
      final result = await _aiService.generateResponse(prompt);
      state = result;
    } catch (e) {
      state = "Failed to analyze resume";
    }
  }

}