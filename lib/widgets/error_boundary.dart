import 'package:flutter/material.dart';
import '../core/theme.dart';

class GameErrorBoundary extends StatelessWidget {
  final Widget child;

  const GameErrorBoundary({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Note: This implementation modifies global ErrorWidget.builder inside build()
    // which is a bit unconventional but common for simple global error boundaries.
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Scaffold(
        backgroundColor: AppTheme.pureBlack,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: AppTheme.survivalRed, size: 64),
                const SizedBox(height: 24),
                const Text(
                  'The darkness has corrupted this sector',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Restart your flashlight to continue exploration',
                  style: TextStyle(color: Colors.white60),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    // Navigate back to root
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.flashlightYellow,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: const Text('RESTART'),
                ),
              ],
            ),
          ),
        ),
      );
    };
    
    return child;
  }
}
