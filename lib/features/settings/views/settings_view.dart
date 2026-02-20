import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/core/providers/theme_provider.dart';

// import '../../../core/providers/theme_provider.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Appearance',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),

                  SegmentedButton<ThemeMode>(
                    style: SegmentedButton.styleFrom(          // ← use styleFrom helper
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black87,
                      selectedBackgroundColor: Theme.of(context).colorScheme.primary,
                      selectedForegroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      // side: const BorderSide(color: Colors.grey),           // optional border
                      // shape: const RoundedRectangleBorder(...),             // custom shape
                    ),
                    segments: const [

                      ButtonSegment(
                        value: ThemeMode.system,
                        label: const Text('System'),
                        icon: const Icon(Icons.settings),
                        // No direct 'style' here → controlled by the parent's style or theme
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        label: const Text('Light'),
                        icon: const Icon(Icons.light_mode),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        label: const Text('Dark'),
                        icon: const Icon(Icons.dark_mode),
                      ),
                    ],
                    selected: {currentMode},
                    onSelectionChanged: (newSelection) {
                      ref.read(themeModeProvider.notifier).setThemeMode(newSelection.first);
                    },
                  )

                  // SegmentedButton<ThemeMode>(
                  //   style: SegmentedButton.styleFrom(
                  //     segmentStyle: ButtonStyle(
                  //       padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
                  //     ),
                  //   ),
                  //   segments: const [
                  //     ButtonSegment(value: ThemeMode.system, label: Text('System')),
                  //     ButtonSegment(value: ThemeMode.light, label: Text('Light')),
                  //     ButtonSegment(value: ThemeMode.dark, label: Text('Dark')),
                  //   ],
                  //   selected: {currentMode},
                  //   onSelectionChanged: (newSelection) {
                  //     ref.read(themeModeProvider.notifier).setThemeMode(newSelection.first);
                  //   },
                  // ),
                ],
              ),
            ),
          ),
          // Add more settings here...
        ],
      ),
    );
  }
}