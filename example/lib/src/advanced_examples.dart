import 'package:flutter/material.dart';
import 'package:leng_responsive_helper/responsive_helper.dart';
import 'package:leng_responsive_helper/src/extensions/context_extension_helpers.dart';

/// Advanced examples demonstrating complex responsive scenarios
class AdvancedExamples extends StatelessWidget {
  const AdvancedExamples({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Advanced Examples')),
      body: ListView(
        padding: context.dynamicPadding.padding,
        children: [
          _buildAdaptiveFormExample(context),
          24.verticalSpace,
          _buildResponsiveNavigationExample(context),
          24.verticalSpace,
          _buildComplexLayoutExample(context),
          24.verticalSpace,
          _buildConditionalWidgetExample(context),
        ],
      ),
    );
  }

  /// Example 1: Adaptive Form Layout
  /// Forms that adapt based on available screen space
  Widget _buildAdaptiveFormExample(BuildContext context) {
    return Card(
      child: Padding(
        padding: 20.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Adaptive Form Layout',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            16.verticalSpace,

            // Form fields adapt from vertical (mobile) to horizontal (tablet+)
            if (context.isMobile)
              Column(
                children: [
                  _buildTextField('First Name'),
                  12.verticalSpace,
                  _buildTextField('Last Name'),
                  12.verticalSpace,
                  _buildTextField('Email'),
                ],
              )
            else
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildTextField('First Name')),
                      16.horizontalSpace,
                      Expanded(child: _buildTextField('Last Name')),
                    ],
                  ),
                  16.verticalSpace,
                  _buildTextField('Email'),
                ],
              ),

            20.verticalSpace,

            // Button layout adapts too
            if (context.isMobile)
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () =>
                          context.showSuccessSnackBar('Form submitted!'),
                      child: const Text('Submit'),
                    ),
                  ),
                  8.verticalSpace,
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Cancel'),
                  ),
                  16.horizontalSpace,
                  ElevatedButton(
                    onPressed: () =>
                        context.showSuccessSnackBar('Form submitted!'),
                    child: const Text('Submit'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  /// Example 2: Responsive Navigation Patterns
  /// Different navigation styles for different screen sizes
  Widget _buildResponsiveNavigationExample(BuildContext context) {
    return Card(
      child: Padding(
        padding: 20.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Responsive Navigation Patterns',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            16.verticalSpace,

            // Show different navigation patterns based on device
            Container(
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: 8.borderRadius,
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: context.responsive<Widget>(
                mobile: _buildMobileNavDemo(),
                tablet: _buildTabletNavDemo(),
                desktop: _buildDesktopNavDemo(),
                fallback: _buildMobileNavDemo(),
              ),
            ),

            12.verticalSpace,

            Text(
              'Current navigation: ${_getNavigationType(context)}',
              style: TextStyle(
                fontSize: 14.sp,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Example 3: Complex Multi-Column Layout
  /// Dynamic column layouts based on screen size
  Widget _buildComplexLayoutExample(BuildContext context) {
    final items = List.generate(12, (index) => 'Item ${index + 1}');

    return Card(
      child: Padding(
        padding: 20.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dynamic Multi-Column Layout',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            16.verticalSpace,

            // Dynamic column count with custom spacing
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = context.responsive<int>(
                  smallMobile: 1,
                  mobile: 2,
                  largeMobile: 2,
                  smallTablet: 3,
                  tablet: 3,
                  largeTablet: 4,
                  desktop: 5,
                  fallback: 2,
                );

                final spacing = context.responsive<double>(
                  mobile: 8.w,
                  tablet: 12.w,
                  desktop: 16.w,
                  fallback: 8.w,
                );

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                    childAspectRatio: context.responsive<double>(
                      mobile: 1.5,
                      tablet: 1.3,
                      desktop: 1.2,
                      fallback: 1.5,
                    ),
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: 8.borderRadius,
                        border: Border.all(
                            color: Colors.blue.withValues(alpha: 0.3)),
                      ),
                      child: Center(
                        child: Text(
                          items[index],
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            12.verticalSpace,

            Text(
              'Columns: ${context.responsive<int>(
                smallMobile: 1,
                mobile: 2,
                largeMobile: 2,
                smallTablet: 3,
                tablet: 3,
                largeTablet: 4,
                desktop: 5,
                fallback: 2,
              )}',
              style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  /// Example 4: Conditional Widget Rendering
  /// Different widgets for different device capabilities
  Widget _buildConditionalWidgetExample(BuildContext context) {
    return Card(
      child: Padding(
        padding: 20.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Conditional Widget Rendering',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            16.verticalSpace,

            // Different interactions for different devices
            Row(
              children: [
                // Hover effects only on desktop
                if (context.isDesktop)
                  Expanded(
                    child: MouseRegion(
                      onEnter: (_) {},
                      onExit: (_) {},
                      child: Container(
                        padding: 16.padding,
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: 8.borderRadius,
                        ),
                        child: Text(
                          'Desktop: Hover Effects Available',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                    ),
                  ),

                // Touch-optimized for mobile
                if (context.isMobile)
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          context.showInfoSnackBar('Mobile tap detected'),
                      child: Container(
                        padding: 16.padding,
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.1),
                          borderRadius: 8.borderRadius,
                        ),
                        child: Text(
                          'Mobile: Touch Optimized',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                    ),
                  ),

                // Tablet-specific interaction
                if (context.isTablet)
                  Expanded(
                    child: Container(
                      padding: 16.padding,
                      decoration: BoxDecoration(
                        color: Colors.purple.withValues(alpha: 0.1),
                        borderRadius: 8.borderRadius,
                      ),
                      child: Text(
                        'Tablet: Hybrid Interactions',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ),
              ],
            ),

            16.verticalSpace,

            // Context information
            Container(
              padding: 12.padding,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: 8.borderRadius,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Device Context:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Type: ${context.deviceSize.name}'),
                  Text(
                      'Orientation: ${context.isPortrait ? "Portrait" : "Landscape"}'),
                  Text('Dark Mode: ${context.isDarkMode}'),
                  Text('Keyboard Visible: ${context.isKeyboardVisible}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widgets
  Widget _buildTextField(String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 16.h,
        ),
      ),
    );
  }

  Widget _buildMobileNavDemo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 4.h,
          width: double.infinity,
          color: Colors.blue,
        ),
        const Expanded(
          child: Center(child: Text('Main Content')),
        ),
        Container(
          height: 60.h,
          color: Colors.blue.withValues(alpha: 0.2),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.home, size: 24),
              Icon(Icons.search, size: 24),
              Icon(Icons.person, size: 24),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabletNavDemo() {
    return Row(
      children: [
        Container(
          width: 60.w,
          color: Colors.blue.withValues(alpha: 0.2),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.home, size: 24),
              Icon(Icons.search, size: 24),
              Icon(Icons.settings, size: 24),
              Icon(Icons.person, size: 24),
            ],
          ),
        ),
        const Expanded(
          child: Center(child: Text('Main Content')),
        ),
      ],
    );
  }

  Widget _buildDesktopNavDemo() {
    return Column(
      children: [
        Container(
          height: 50.h,
          color: Colors.blue.withValues(alpha: 0.2),
          child: Row(
            children: [
              16.horizontalSpace,
              const Text('Logo'),
              const Spacer(),
              const Text('Home'),
              24.horizontalSpace,
              const Text('Products'),
              24.horizontalSpace,
              const Text('About'),
              16.horizontalSpace,
            ],
          ),
        ),
        const Expanded(
          child: Center(child: Text('Main Content')),
        ),
      ],
    );
  }

  String _getNavigationType(BuildContext context) {
    if (context.isMobile) return 'Bottom Navigation';
    if (context.isTablet) return 'Navigation Rail';
    return 'Top Navigation Bar';
  }
}

/// Custom responsive widget example
class ResponsiveCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const ResponsiveCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: 12.borderRadius,
        child: Container(
          padding: context.responsive<EdgeInsets>(
            mobile: 16.padding,
            tablet: 20.padding,
            desktop: 24.padding,
            fallback: 16.padding,
          ),
          child: context.isMobile
              ? _buildVerticalLayout()
              : _buildHorizontalLayout(),
        ),
      ),
    );
  }

  Widget _buildVerticalLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 32),
        8.verticalSpace,
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        4.verticalSpace,
        Text(
          subtitle,
          style: TextStyle(fontSize: 12.sp),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildHorizontalLayout() {
    return Row(
      children: [
        Icon(icon, size: 40),
        16.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              4.verticalSpace,
              Text(
                subtitle,
                style: TextStyle(fontSize: 14.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
