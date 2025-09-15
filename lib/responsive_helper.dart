/// A comprehensive Flutter package for responsive design
///
/// This package provides utilities for creating responsive UIs that adapt
/// beautifully across all device sizes - from small phones to large desktops.
///
/// ## Key Features:
/// - **Smart device detection** with 8 distinct size categories
/// - **Responsive extensions** for numbers (w, h, sp, padding, etc.)
/// - **Context extensions** for easy theme, navigation, and device access
/// - **Responsive widgets** for automatic layout switching
/// - **Type-safe responsive values** with intelligent fallbacks
///
/// ## Quick Start:
///
/// ```dart
/// import 'package:responsive_extensions/responsive_extensions.dart';
///
/// class MyApp extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     ResponsiveHelper.init(context); // Initialize in your root widget
///
///     return Container(
///       width: 200.w,           // Responsive width
///       height: 100.h,          // Responsive height
///       padding: 16.padding,    // Responsive padding
///       child: Text(
///         'Hello World',
///         style: TextStyle(fontSize: 16.sp), // Responsive font size
///       ),
///     );
///   }
/// }
/// ```
library;

// Extensions
export 'src/extensions/responsive_extension.dart';
export 'src/extensions/context_extension.dart';

// Helpers
export 'src/helpers/responsive_helper.dart';

// Widgets
export 'src/widgets/responsive_builder.dart';
