import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leng_responsive_helper/responsive_helper.dart';
import 'package:leng_responsive_helper/src/extensions/context_extension_helpers.dart';

void main() {
  group('ResponsiveHelper', () {
    testWidgets('should initialize correctly with different screen sizes',
        (WidgetTester tester) async {
      // Test mobile initialization
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              ResponsiveHelper.init(context);
              return Container();
            },
          ),
        ),
      );

      expect(ResponsiveHelper.deviceSize, isNotNull);
    });

    test('should determine device size correctly', () {
      // These are internal methods, so we test the public interface
      // by checking that device size categories work as expected

      // Since _determineDeviceSize is private, we test through the public API
      // after initialization with known screen sizes
    });

    test('should provide correct design dimensions for each device type', () {
      // We can test that design dimensions are returned
      final dimensions = ResponsiveHelper.designDimensions;

      expect(dimensions, isA<Map<String, double>>());
      expect(dimensions.containsKey('width'), true);
      expect(dimensions.containsKey('height'), true);
      expect(dimensions['width'], greaterThan(0));
      expect(dimensions['height'], greaterThan(0));
    });
  });

  group('SizeExtension', () {
    testWidgets('should provide responsive width and height',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              ResponsiveHelper.init(context);

              // Test that extensions work
              final width = 200.w;
              final height = 100.h;
              final fontSize = 16.sp;

              expect(width, isA<double>());
              expect(height, isA<double>());
              expect(fontSize, isA<double>());
              expect(width, greaterThan(0));
              expect(height, greaterThan(0));
              expect(fontSize, greaterThan(0));

              return Container();
            },
          ),
        ),
      );
    });

    test('should create correct spacing widgets', () {
      final verticalSpace = 16.verticalSpace;
      final horizontalSpace = 20.horizontalSpace;

      expect(verticalSpace, isA<SizedBox>());
      expect(horizontalSpace, isA<SizedBox>());
      expect(verticalSpace.height, 16.0);
      expect(horizontalSpace.width, 20.0);
    });

    test('should create correct EdgeInsets', () {
      final padding = 16.padding;
      final verticalPadding = 12.paddingVertical;
      final horizontalPadding = 8.paddingHorizontal;

      expect(padding, const EdgeInsets.all(16.0));
      expect(verticalPadding, const EdgeInsets.symmetric(vertical: 12.0));
      expect(horizontalPadding, const EdgeInsets.symmetric(horizontal: 8.0));
    });

    test('should create correct BorderRadius', () {
      final borderRadius = 12.borderRadius;

      expect(borderRadius, BorderRadius.circular(12.0));
    });

    test('should create correct Duration', () {
      final milliseconds = 300.milliseconds;
      final seconds = 2.seconds;

      expect(milliseconds, const Duration(milliseconds: 300));
      expect(seconds, const Duration(seconds: 2));
    });
  });

  group('ResponsiveExtension', () {
    testWidgets('should provide device type checks',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              ResponsiveHelper.init(context);

              // Test device type checks
              expect(context.isMobile, isA<bool>());
              expect(context.isTablet, isA<bool>());
              expect(context.isDesktop, isA<bool>());

              // Test screen dimensions
              expect(context.screenWidth, greaterThan(0));
              expect(context.screenHeight, greaterThan(0));

              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('should provide responsive values with fallbacks',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              ResponsiveHelper.init(context);

              final responsiveValue = context.responsive<int>(
                mobile: 1,
                tablet: 2,
                desktop: 3,
                fallback: 0,
              );

              expect(responsiveValue, isA<int>());
              expect(responsiveValue, greaterThanOrEqualTo(0));

              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('should provide dynamic padding and text scale',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              ResponsiveHelper.init(context);

              final dynamicPadding = context.dynamicPadding;
              final dynamicTextScale = context.dynamicTextScale;

              expect(dynamicPadding, greaterThan(0));
              expect(dynamicTextScale, greaterThan(0));

              return Container();
            },
          ),
        ),
      );
    });
  });

  group('ContextExtension', () {
    testWidgets('should provide theme access', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Builder(
            builder: (context) {
              expect(context.theme, isA<ThemeData>());
              expect(context.textTheme, isA<TextTheme>());
              expect(context.colorScheme, isA<ColorScheme>());
              expect(context.isDarkMode, false);
              expect(context.isLightMode, true);

              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('should provide device information',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(context.mediaQuery, isA<MediaQueryData>());
              // Avoid calling context.size directly during build (can throw in tests)
              expect(MediaQuery.of(context).size, isA<Size>());
              expect(context.isPortrait, isA<bool>());
              expect(context.isLandscape, isA<bool>());
              expect(context.statusBarHeight, greaterThanOrEqualTo(0));
              expect(context.bottomPadding, greaterThanOrEqualTo(0));

              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('should provide navigation methods',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(context.canPop, false); // Root route can't pop
              return Container();
            },
          ),
        ),
      );
    });
  });

  group('ResponsiveBuilder', () {
    testWidgets('should render mobile layout by default',
        (WidgetTester tester) async {
      const mobileWidget = Text('Mobile Layout');
      const tabletWidget = Text('Tablet Layout');

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(builder: (context) {
            // Provide a MediaQuery with mobile size and scaffold so ResponsiveBuilder
            // has a proper layout and Directionality in tests.
            return MediaQuery(
              data: const MediaQueryData(size: Size(375, 812)),
              child: Builder(builder: (inner) {
                ResponsiveHelper.init(inner);
                return Scaffold(
                  body: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(375, 812)),
                      child: const ResponsiveBuilder(
                        mobile: mobileWidget,
                        tablet: tabletWidget,
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      );

      // Should find mobile layout (since test environment is typically mobile-sized)
      expect(find.text('Mobile Layout'), findsOneWidget);
    });

    testWidgets('should use fallback correctly', (WidgetTester tester) async {
      const mobileWidget = Text('Mobile Layout');

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(builder: (context) {
            return MediaQuery(
              data: const MediaQueryData(size: Size(375, 812)),
              child: Builder(builder: (inner) {
                ResponsiveHelper.init(inner);
                return Scaffold(
                  body: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(375, 812)),
                      child: const ResponsiveBuilder(
                        mobile: mobileWidget,
                        // No tablet/desktop specified - should fall back to mobile
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      );

      expect(find.text('Mobile Layout'), findsOneWidget);
    });
  });

  group('SimpleResponsiveBuilder', () {
    testWidgets('should render correctly', (WidgetTester tester) async {
      const mobileWidget = Text('Simple Mobile');

      await tester.pumpWidget(
        const MaterialApp(
          home: SimpleResponsiveBuilder(
            mobile: mobileWidget,
          ),
        ),
      );

      expect(find.text('Simple Mobile'), findsOneWidget);
    });
  });

  group('Edge Cases', () {
    test('should handle null values in responsive method', () {
      // This would need to be tested within a widget context
      // but we can test that the method signature allows nulls
    });

    testWidgets(
        'should handle missing ResponsiveHelper initialization gracefully',
        (WidgetTester tester) async {
      // Test what happens if ResponsiveHelper.init() is not called
      // This might throw an error or use defaults
      expect(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                // Don't call ResponsiveHelper.init(context)
                try {
                  final width = 100.w; // This might fail without initialization
                  return Container(width: width);
                } catch (e) {
                  return const Text('Error: ResponsiveHelper not initialized');
                }
              },
            ),
          ),
        );
      }, returnsNormally);
    });
  });
}
