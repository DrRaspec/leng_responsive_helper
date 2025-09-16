import 'package:flutter/material.dart';
import 'package:leng_responsive_helper/responsive_helper.dart';
// Import helpers to ensure context extension helpers are in scope for the example
import 'package:leng_responsive_helper/src/extensions/context_extension_helpers.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'leng_responsive_helper Example',
      theme: ThemeData(useMaterial3: true),
      home: const ExampleHome(),
    );
  }
}

class ExampleHome extends StatelessWidget {
  const ExampleHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the helper (can be called on each screen)
    ResponsiveHelper.init(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Example')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Screen width: ${context.screenWidth.toStringAsFixed(0)}',
                style: TextStyle(fontSize: 16.sp)),
            16.verticalSpace,
            Container(
              width: 200.w,
              height: 100.h,
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: 12.borderRadius,
              ),
              child: const Center(child: Text('Responsive box')),
            ),
            16.verticalSpace,
            ElevatedButton(
              onPressed: () => context.showSuccessSnackBar('Works!'),
              child: const Text('Show snackbar'),
            ),
          ],
        ),
      ),
    );
  }
}
