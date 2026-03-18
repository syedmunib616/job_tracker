class ExtractData {

  Map<String, dynamic> parseAIResponse(String response) {
    // 🔹 SCORE (handles 82/100 or 82%)
    final scoreRegex = RegExp(r'(\d{1,3})\s*/\s*100|(\d{1,3})%');
    final scoreMatch = scoreRegex.firstMatch(response);
    final score = int.tryParse(
      scoreMatch?.group(1) ?? scoreMatch?.group(2) ?? "0",
    ) ??
        0;

    // 🔹 EXTRACT SECTION TEXT
    String extractSection(String title) {
      final regex = RegExp(
        '$title[\\s\\S]*?\\n([\\s\\S]*?)(?=\\n---|\\n###|\\Z)',
        caseSensitive: false,
      );

      final match = regex.firstMatch(response);
      return match?.group(1) ?? "";
    }

    // 🔹 CLEAN SKILLS
    List<String> cleanSkills(String text) {
      return text
          .replaceAll(RegExp(r'[\*\•]'), '') // remove bullets
          .replaceAll(RegExp(r'\*\*(.*?)\*\*'), '') // remove bold
          .replaceAll(RegExp(r':'), ',') // replace category labels
          .replaceAll('\n', ',')
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }

    // 🔹 GET SECTIONS
    final matchingRaw = extractSection("Matching Skills");
    final missingRaw = extractSection("Missing Skills");

    final matchingSkills = cleanSkills(matchingRaw);
    final missingSkills = cleanSkills(missingRaw);

    return {
      "score": score,
      "matching": matchingSkills,
      "missing": missingSkills,
    };
  }
  // Map<String, dynamic> parseAIResponse(String response) {
  //   final scoreRegex = RegExp(r'Match Score:\s*(\d+)');
  //   final matchScore = scoreRegex.firstMatch(response);
  //   final score = int.tryParse(matchScore?.group(1) ?? "0") ?? 0;
  //
  //   List<String> extractSkills(String title) {
  //     final regex = RegExp('$title:\\s*(.*)');
  //     final match = regex.firstMatch(response);
  //     if (match == null) return [];
  //     return match.group(1)!.split(',').map((e) => e.trim()).toList();
  //   }
  //
  //   final matchingSkills = extractSkills("Matching Skills");
  //   final missingSkills = extractSkills("Missing Skills");
  //
  //   return {
  //     "score": score,
  //     "matching": matchingSkills,
  //     "missing": missingSkills,
  //   };
  // }

}