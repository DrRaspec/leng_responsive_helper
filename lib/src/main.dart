import 'package:flutter/material.dart';
import 'package:leng_responsive_helper/responsive_helper.dart';
import 'package:leng_responsive_helper/src/extensions/context_extension_helpers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Helper Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ResponsiveDemo(),
    );
  }
}

class ResponsiveDemo extends StatefulWidget {
  const ResponsiveDemo({super.key});

  @override
  State<ResponsiveDemo> createState() => _ResponsiveDemoState();
}

class _ResponsiveDemoState extends State<ResponsiveDemo> {
  @override
  Widget build(BuildContext context) {
    // IMPORTANT: Initialize ResponsiveHelper first!
    ResponsiveHelper.init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.inversePrimary,
        title: Text(
          'Responsive Demo',
          style: TextStyle(fontSize: 20.sp), // Responsive font size
        ),
      ),
      body: SingleChildScrollView(
        padding: context.dynamicPadding.padding, // Smart padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Device Info Card
            _buildDeviceInfoCard(context),

            24.verticalSpace, // Responsive spacing

            // Responsive Layout Examples
            _buildResponsiveLayoutExamples(context),

            24.verticalSpace,

            // Responsive Values Example
            _buildResponsiveValuesExample(context),

            24.verticalSpace,

            // Navigation & Context Examples
            _buildContextExamples(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceInfoCard(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: 20.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Device Info',
              style: context.textTheme.headlineSmall?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            12.verticalSpace,
            Text(
                'Screen Size: ${context.screenWidth.toInt()} x ${context.screenHeight.toInt()}'),
            Text('Device Type: ${context.deviceSize.name}'),
            Text('Is Mobile: ${context.isMobile}'),
            Text('Is Tablet: ${context.isTablet}'),
            Text('Is Desktop: ${context.isDesktop}'),
            Text('Dynamic Padding: ${context.dynamicPadding}'),
            Text('Text Scale: ${context.dynamicTextScale}'),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveLayoutExamples(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Responsive Layout Examples',
          style: context.textTheme.headlineSmall?.copyWith(fontSize: 18.sp),
        ),
        16.verticalSpace,

        // Grid with responsive columns
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: context.responsive<int>(
              smallMobile: 1,
              mobile: 2,
              largeMobile: 2,
              tablet: 3,
              desktop: 4,
              fallback: 2,
            ),
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1.5,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Card(
              child: Container(
                padding: 12.padding,
                decoration: BoxDecoration(
                  borderRadius: 8.borderRadius,
                  color: context.colorScheme.primaryContainer,
                ),
                child: Center(
                  child: Text(
                    'Card ${index + 1}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildResponsiveValuesExample(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: 20.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Responsive Values in Action',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            16.verticalSpace,

            // Container with responsive dimensions
            Container(
              width: context.responsive<double>(
                smallMobile: 200.w,
                mobile: 250.w,
                tablet: 300.w,
                desktop: 400.w,
                fallback: 250.w,
              ),
              height: 100.h,
              decoration: BoxDecoration(
                color: context.colorScheme.secondary.withValues(alpha: 0.2),
                borderRadius: 12.borderRadius,
                border: Border.all(color: context.colorScheme.secondary),
              ),
              child: Center(
                child: Text(
                  'Responsive Container',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ),

            16.verticalSpace,

            // Responsive button
            SizedBox(
              width: context.responsive<double>(
                mobile: 200.w,
                tablet: 250.w,
                desktop: 300.w,
                fallback: 200.w,
              ),
              height: 48.h,
              child: ElevatedButton(
                onPressed: () {
                  context.showSuccessSnackBar('Button pressed!');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: 8.borderRadius,
                  ),
                ),
                child: Text(
                  'Responsive Button',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContextExamples(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: 20.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Context Extensions Demo',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            16.verticalSpace,
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      context.showSuccessSnackBar('Success message!'),
                  child: Text('Success SnackBar',
                      style: TextStyle(fontSize: 14.sp)),
                ),
                ElevatedButton(
                  onPressed: () => context.showErrorSnackBar('Error occurred!'),
                  child:
                      Text('Error SnackBar', style: TextStyle(fontSize: 14.sp)),
                ),
                ElevatedButton(
                  onPressed: () =>
                      context.showWarningSnackBar('Warning message!'),
                  child: Text('Warning SnackBar',
                      style: TextStyle(fontSize: 14.sp)),
                ),
                ElevatedButton(
                  onPressed: () => context.showInfoSnackBar('Info message!'),
                  child:
                      Text('Info SnackBar', style: TextStyle(fontSize: 14.sp)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    final result = await context.showConfirmationDialog(
                      title: 'Confirm Action',
                      message: 'Are you sure you want to continue?',
                      confirmText: 'Yes',
                      cancelText: 'No',
                    );
                    if (!mounted) return;
                    if (result == true) {
                      messenger.showSnackBar(
                          const SnackBar(content: Text('Confirmed!')));
                    }
                  },
                  child: Text('Show Dialog', style: TextStyle(fontSize: 14.sp)),
                ),
              ],
            ),
            16.verticalSpace,
            Text(
              'Theme Information:',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            8.verticalSpace,
            Text('Is Dark Mode: ${context.isDarkMode}'),
            Text('Is Portrait: ${context.isPortrait}'),
            Text('Status Bar Height: ${context.statusBarHeight}'),
          ],
        ),
      ),
    );
  }
}
