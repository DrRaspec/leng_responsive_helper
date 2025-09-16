import 'package:flutter/material.dart';
import 'package:leng_responsive_helper/responsive_helper.dart';
import 'package:leng_responsive_helper/src/extensions/context_extension_helpers.dart';

/// Simple navigation example demonstrating push/pop and responsive patterns
class NavigationExample extends StatelessWidget {
  const NavigationExample({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Example')),
      body: Padding(
        padding: context.dynamicPadding.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Navigation Patterns', style: TextStyle(fontSize: 18.sp)),
            16.verticalSpace,
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const _DetailPage()),
              ),
              child: const Text('Push to detail page'),
            ),
            12.verticalSpace,
            ElevatedButton(
              onPressed: () => context.pushAndRemoveUntil('/'),
              child: const Text('Push and clear stack (home)'),
            ),
            12.verticalSpace,
            Text(
                'Current strategy: ${context.isMobile ? 'Stack' : context.isTablet ? 'Rail/Drawer' : 'Top Bar'}'),
          ],
        ),
      ),
    );
  }
}

class _DetailPage extends StatelessWidget {
  const _DetailPage();

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Detail Page', style: TextStyle(fontSize: 20.sp)),
            16.verticalSpace,
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Pop back'),
            ),
          ],
        ),
      ),
    );
  }
}
