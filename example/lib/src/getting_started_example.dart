import 'package:flutter/material.dart';
import 'package:leng_responsive_helper/responsive_helper.dart';
import 'package:leng_responsive_helper/src/extensions/context_extension_helpers.dart';

/// Simple getting started example
/// This demonstrates the most common use cases in just a few lines of code
class GettingStartedExample extends StatelessWidget {
  const GettingStartedExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Step 1: Initialize ResponsiveHelper (required!)
    ResponsiveHelper.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Getting Started',
          style: TextStyle(fontSize: 20.sp), // Responsive font size
        ),
      ),
      body: Padding(
        padding:
            context.dynamicPadding.padding, // Smart padding for all devices
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step 2: Use responsive dimensions
            Container(
              width: 300.w, // Responsive width
              height: 100.h, // Responsive height
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: 12.borderRadius, // Responsive border radius
              ),
              child: Center(
                child: Text(
                  'Responsive Container',
                  style: TextStyle(fontSize: 16.sp), // Responsive text
                ),
              ),
            ),

            // Step 3: Use responsive spacing
            24.verticalSpace, // Instead of SizedBox(height: 24)

            // Step 4: Use responsive values for different devices
            Text(
              'This text changes size based on your device',
              style: TextStyle(
                fontSize: context.responsive<double>(
                  mobile: 14.sp,
                  tablet: 18.sp,
                  desktop: 22.sp,
                  fallback: 16.sp,
                ),
              ),
            ),

            16.verticalSpace,

            // Step 5: Use context extensions
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Easy snackbar with context extension
                    context.showSuccessSnackBar('Button pressed!');
                  },
                  child: const Text('Show Success'),
                ),

                16.horizontalSpace, // Horizontal spacing

                ElevatedButton(
                  onPressed: () {
                    context.showErrorSnackBar('Error occurred!');
                  },
                  child: const Text('Show Error'),
                ),
              ],
            ),

            24.verticalSpace,

            // Step 6: Device-specific layouts
            if (context.isMobile) ...[
              const Text('Mobile Layout'),
              _buildMobileSpecificWidget(),
            ] else if (context.isTablet) ...[
              const Text('Tablet Layout'),
              _buildTabletSpecificWidget(),
            ] else ...[
              const Text('Desktop Layout'),
              _buildDesktopSpecificWidget(),
            ],

            24.verticalSpace,

            // Step 7: Responsive grid
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: context.responsive<int>(
                    mobile: 2, // 2 columns on mobile
                    tablet: 3, // 3 columns on tablet
                    desktop: 4, // 4 columns on desktop
                    fallback: 2,
                  ),
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      padding: 12.padding,
                      child: Center(
                        child: Text(
                          'Item $index',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileSpecificWidget() {
    return Card(
      child: Container(
        padding: 16.padding,
        child: const Text('This widget is optimized for mobile devices'),
      ),
    );
  }

  Widget _buildTabletSpecificWidget() {
    return Card(
      child: Container(
        padding: 20.padding,
        child: Row(
          children: [
            const Icon(Icons.tablet),
            16.horizontalSpace,
            const Expanded(
              child: Text('This widget takes advantage of tablet screen space'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopSpecificWidget() {
    return Card(
      child: Container(
        padding: 24.padding,
        child: Row(
          children: [
            const Icon(Icons.computer, size: 32),
            20.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Desktop Widget',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  8.verticalSpace,
                  const Text('This widget provides a rich desktop experience'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
