import 'package:flutter/material.dart';
import 'package:responsive_helper/responsive_helper.dart';

/// ResponsiveExtension - Convenient extension methods for responsive design
///
/// This extension adds responsive capabilities directly to BuildContext,
/// making it easy to create responsive UIs with clean, readable code.
///
/// ## Setup:
/// 1. Initialize ResponsiveHelper in your widget first
/// 2. Use extension methods throughout your UI
///
/// ```dart
/// @override
/// Widget build(BuildContext context) {
///   ResponsiveHelper.init(context); // Initialize first!
///
///   return Scaffold(
///     body: Container(
///       padding: EdgeInsets.all(context.dynamicPadding), // Smart padding
///       child: Text(
///         'Hello World',
///         style: TextStyle(
///           fontSize: context.responsive<double>(  // Granular control
///             mobile: 16.0,
///             tablet: 20.0,
///             desktop: 24.0,
///             fallback: 16.0,
///           ),
///         ),
///       ),
///     ),
///   );
/// }
/// ```
extension ResponsiveExtension on BuildContext {
  /// Get current screen width in logical pixels
  ///
  /// ### Example:
  /// ```dart
  /// double width = context.screenWidth;
  /// if (width > 600) {
  ///   // Wide screen layout
  /// }
  /// ```
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get current screen height in logical pixels
  ///
  /// ### Example:
  /// ```dart
  /// double height = context.screenHeight;
  /// if (height > 800) {
  ///   // Tall screen layout
  /// }
  /// ```
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Check if current device is in mobile category (all mobile sizes)
  ///
  /// Returns true for: smallMobile, mobile, largeMobile
  ///
  /// ### Example:
  /// ```dart
  /// if (context.isMobile) {
  ///   // Mobile UI: Stack navigation, bottom sheets
  ///   return MobileLayout();
  /// }
  /// ```
  bool get isMobile => ResponsiveHelper.isMobile;

  /// Check if current device is in tablet category (all tablet sizes)
  ///
  /// Returns true for: smallTablet, tablet, largeTablet
  ///
  /// ### Example:
  /// ```dart
  /// if (context.isTablet) {
  ///   // Tablet UI: Side navigation, modal dialogs
  ///   return TabletLayout();
  /// }
  /// ```
  bool get isTablet => ResponsiveHelper.isTablet;

  /// Check if current device is desktop/laptop
  ///
  /// ### Example:
  /// ```dart
  /// if (context.isDesktop) {
  ///   // Desktop UI: Multi-panel layout, hover effects
  ///   return DesktopLayout();
  /// }
  /// ```
  bool get isDesktop => ResponsiveHelper.isDesktop;

  /// Get the specific device size category
  ///
  /// Returns the exact DeviceSize enum for granular control.
  ///
  /// ### Example:
  /// ```dart
  /// switch (context.deviceSize) {
  ///   case DeviceSize.smallMobile:
  ///     return CompactMobileLayout();
  ///   case DeviceSize.largeMobile:
  ///     return PhabletLayout();
  ///   case DeviceSize.tablet:
  ///     return TabletLayout();
  ///   case DeviceSize.desktop:
  ///     return DesktopLayout();
  ///   default:
  ///     return DefaultLayout();
  /// }
  /// ```
  DeviceSize get deviceSize => ResponsiveHelper.deviceSize;

  /// Enhanced responsive method with granular device size support
  ///
  /// Specify different values for each device size category. The system
  /// automatically selects the most appropriate value with smart fallbacks.
  ///
  /// ### Example - Responsive padding:
  /// ```dart
  /// EdgeInsets padding = EdgeInsets.all(
  ///   context.responsive<double>(
  ///     smallMobile: 8.0,    // Tight spacing for small screens
  ///     mobile: 16.0,        // Standard mobile padding
  ///     largeMobile: 18.0,   // Bit more for phablets
  ///     smallTablet: 20.0,   // Comfortable tablet spacing
  ///     tablet: 24.0,        // More spacious
  ///     largeTablet: 28.0,   // Professional tablet look
  ///     desktop: 32.0,       // Desktop-appropriate spacing
  ///     fallback: 16.0,      // Safety fallback
  ///   ),
  /// );
  /// ```
  ///
  /// ### Example - Responsive column count:
  /// ```dart
  /// int columns = context.responsive<int>(
  ///   mobile: 1,           // Single column on mobile
  ///   largeMobile: 2,      // Two columns on large phones
  ///   tablet: 3,           // Three columns on tablets
  ///   desktop: 4,          // Four columns on desktop
  ///   fallback: 2,         // Default fallback
  /// );
  ///
  /// GridView.count(crossAxisCount: columns, children: [...]);
  /// ```
  ///
  /// ### Example - Responsive widgets:
  /// ```dart
  /// Widget navigation = context.responsive<Widget>(
  ///   mobile: BottomNavigationBar(...),     // Bottom nav for mobile
  ///   tablet: NavigationRail(...),          // Side nav for tablet
  ///   desktop: Drawer(...),                 // Drawer for desktop
  ///   fallback: BottomNavigationBar(...),   // Default
  /// );
  /// ```
  T responsive<T>({
    T? smallMobile,
    T? mobile,
    T? largeMobile,
    T? smallTablet,
    T? custom600x800,
    T? tablet,
    T? largeTablet,
    T? desktop,
    required T fallback,
  }) {
    return ResponsiveHelper.getResponsiveValue<T>(
      smallMobile: smallMobile,
      mobile: mobile,
      largeMobile: largeMobile,
      smallTablet: smallTablet,
      custom600x800: custom600x800,
      tablet: tablet,
      largeTablet: largeTablet,
      desktop: desktop,
      fallback: fallback,
    );
  }

  /// Simple responsive method for basic use cases (backward compatibility)
  ///
  /// A simplified version that only supports mobile/tablet/desktop categories.
  /// Use this when you don't need granular device size control.
  ///
  /// ### Example:
  /// ```dart
  /// double fontSize = context.responsiveSimple<double>(
  ///   mobile: 16.0,    // All mobile devices
  ///   tablet: 20.0,    // All tablet devices
  ///   desktop: 24.0,   // Desktop devices
  /// );
  ///
  /// Text('Hello', style: TextStyle(fontSize: fontSize));
  /// ```
  ///
  /// ### Example - Layout switching:
  /// ```dart
  /// Widget layout = context.responsiveSimple<Widget>(
  ///   mobile: SingleChildScrollView(child: MobileLayout()),
  ///   tablet: Row(children: [Sidebar(), Content()]),
  ///   desktop: Row(children: [Sidebar(), Content(), RightPanel()]),
  /// );
  /// ```
  T responsiveSimple<T>({required T mobile, T? tablet, T? desktop}) {
    if (isDesktop) {
      return desktop ?? tablet ?? mobile;
    } else if (isTablet) {
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }

  /// Smart dynamic padding based on device size
  ///
  /// Automatically provides appropriate padding for each device category.
  /// Use this for consistent spacing throughout your app.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   padding: EdgeInsets.all(context.dynamicPadding),
  ///   child: Text('Consistently padded content'),
  /// )
  ///
  /// // Or use in margins
  /// Container(
  ///   margin: EdgeInsets.all(context.dynamicPadding),
  ///   child: Card(...),
  /// )
  /// ```
  ///
  /// ### Padding values by device:
  /// - Small Mobile: 12px (tight spacing)
  /// - Mobile: 16px (standard)
  /// - Large Mobile: 18px (slightly more)
  /// - Small Tablet: 20px (comfortable)
  /// - Tablet: 24px (spacious)
  /// - Large Tablet: 28px (professional)
  /// - Desktop: 32px (desktop-appropriate)
  double get dynamicPadding => responsive<double>(
    smallMobile: 12.0,
    mobile: 16.0,
    largeMobile: 18.0,
    smallTablet: 20.0,
    tablet: 24.0,
    largeTablet: 28.0,
    desktop: 32.0,
    fallback: 16.0,
  );

  /// Smart dynamic text scaling based on device size
  ///
  /// Provides intelligent text scaling factors for optimal readability
  /// across different device categories. Apply this to your base font sizes.
  ///
  /// ### Example:
  /// ```dart
  /// Text(
  ///   'Dynamic Text',
  ///   style: TextStyle(
  ///     fontSize: 16 * context.dynamicTextScale, // Auto-scaled font
  ///   ),
  /// )
  ///
  /// // Or combine with theme
  /// Text(
  ///   'Scaled Title',
  ///   style: Theme.of(context).textTheme.headlineSmall?.copyWith(
  ///     fontSize: (Theme.of(context).textTheme.headlineSmall?.fontSize ?? 20)
  ///               * context.dynamicTextScale,
  ///   ),
  /// )
  /// ```
  ///
  /// ### Scaling factors by device:
  /// - Small Mobile: 0.9× (reduce for small screens)
  /// - Mobile: 1.0× (baseline)
  /// - Large Mobile: 1.05× (slightly larger for phablets)
  /// - Small Tablet: 1.1× (more readable)
  /// - Tablet: 1.15× (comfortable reading)
  /// - Large Tablet: 1.2× (professional)
  /// - Desktop: 1.25× (desktop-appropriate)
  double get dynamicTextScale => responsive<double>(
    smallMobile: 0.9,
    mobile: 1.0,
    largeMobile: 1.05,
    smallTablet: 1.1,
    tablet: 1.15,
    largeTablet: 1.2,
    desktop: 1.25,
    fallback: 1.0,
  );
}
