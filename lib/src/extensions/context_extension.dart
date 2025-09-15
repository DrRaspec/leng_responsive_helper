import 'package:flutter/material.dart';
import 'package:responsive_helper/responsive_helper.dart';

/// SizeExtension - Responsive sizing and spacing utilities for numbers
///
/// This extension transforms any number into responsive sizes, spacing, and layout helpers.
/// It's the foundation of the responsive design system, making it easy to convert
/// design values into screen-appropriate dimensions.
///
/// ## Core Concepts:
///
/// ### Responsive Sizing:
/// - `.w` → Responsive width based on design baseline
/// - `.h` → Responsive height based on design baseline
/// - `.sp` → Responsive font size with device-specific scaling
///
/// ### Spacing Helpers:
/// - `.verticalSpace` → SizedBox with height
/// - `.horizontalSpace` → SizedBox with width
/// - `.padding` → EdgeInsets for padding/margin
///
/// ## Usage Examples:
///
/// ```dart
/// // Before: Fixed sizes (bad for responsive)
/// Container(
///   width: 200,
///   height: 100,
///   child: Text('Hello', style: TextStyle(fontSize: 16)),
/// )
///
/// // After: Responsive sizes (good!)
/// Container(
///   width: 200.w,    // Responsive width
///   height: 100.h,   // Responsive height
///    child: Text('Hello', style: TextStyle(fontSize: 16.sp)),
/// )
///
/// // Spacing between widgets
/// Column(
///   children: [
///     Text('First item'),
///     16.verticalSpace,  // 16 logical pixels height
///     Text('Second item'),
///     24.verticalSpace,  // 24 logical pixels height
///     Text('Third item'),
///   ],
/// )
///
/// // Horizontal spacing in rows
/// Row(
///   children: [
///     Icon(Icons.star),
///     8.horizontalSpace,   // 8 logical pixels width
///     Text('Rating'),
///     12.horizontalSpace,  // 12 logical pixels width
///     Text('4.5'),
///   ],
/// )
///
/// // Padding shortcuts
/// Container(
///   padding: 16.padding,           // All sides: 16
///   margin: 20.paddingVertical,    // Top/bottom: 20
///   child: Text('Padded content'),
/// )
/// ```
extension SizeExtension on num {
  /// Convert number to responsive width
  ///
  /// Converts design width values to actual screen widths proportionally.
  /// Uses the current device's design baseline automatically.
  ///
  /// ### How it works:
  /// - Takes your design value (e.g., 200 from a 375px design)
  /// - Scales it proportionally to current screen width
  /// - Uses device-specific design baselines for accuracy
  ///
  /// ### Example:
  /// ```dart
  /// // Design containers
  /// Container(width: 300.w)  // Always proportional to screen
  /// Container(width: 150.w)  // Half the width of above
  ///
  /// // Card widths in rice mill app
  /// Card(
  ///   child: Container(
  ///     width: 280.w,  // Consistent card width across devices
  ///     child: StockSummary(),
  ///   ),
  /// )
  ///
  /// // Button widths
  /// ElevatedButton(
  ///   style: ElevatedButton.styleFrom(
  ///     minimumSize: Size(120.w, 48.h), // Responsive button
  ///   ),
  ///   child: Text('Add Stock'),
  /// )
  /// ```
  ///
  /// @return Responsive width in logical pixels
  double get w => ResponsiveHelper.setWidth(this);

  /// Convert number to responsive height
  ///
  /// Converts design height values to actual screen heights proportionally.
  /// Perfect for maintaining aspect ratios and vertical spacing.
  ///
  /// ### Example:
  /// ```dart
  /// // Container heights
  /// Container(height: 200.h)  // Proportional height
  ///
  /// // Image aspect ratios
  /// Container(
  ///   width: 300.w,
  ///   height: 200.h,  // Maintains 3:2 aspect ratio
  ///   child: Image.asset('rice_field.jpg'),
  /// )
  ///
  /// // AppBar heights
  /// PreferredSize(
  ///   preferredSize: Size.fromHeight(60.h),
  ///   child: AppBar(title: Text('Rice Mill')),
  /// )
  ///
  /// // List item heights
  /// ListView.builder(
  ///   itemBuilder: (context, index) => Container(
  ///     height: 80.h,  // Consistent item height
  ///     child: StockListItem(stocks[index]),
  ///   ),
  /// )
  /// ```
  ///
  /// @return Responsive height in logical pixels
  double get h => ResponsiveHelper.setHeight(this);

  /// Convert number to responsive font size with smart scaling
  ///
  /// Applies responsive scaling to font sizes with device-specific
  /// adjustments for optimal readability across all screen sizes.
  ///
  /// ### Smart scaling by device:
  /// - Small phones: 0.9× (smaller for limited space)
  /// - Regular phones: 1.0× (baseline)
  /// - Large phones: 1.05× (slightly larger)
  /// - Tablets: 1.1-1.2× (more readable)
  /// - Desktop: 1.25× (desktop-appropriate)
  ///
  /// ### Example:
  /// ```dart
  /// // Text styles
  /// Text(
  ///   'Rice Stock: 1,250 kg',
  ///   style: TextStyle(fontSize: 16.sp), // Smart responsive font
  /// )
  ///
  /// // Heading sizes
  /// Text(
  ///   'Dashboard',
  ///   style: TextStyle(
  ///     fontSize: 24.sp,        // Large heading
  ///     fontWeight: FontWeight.bold,
  ///   ),
  /// )
  ///
  /// // Button text
  /// ElevatedButton(
  ///   child: Text(
  ///     'Submit Order',
  ///     style: TextStyle(fontSize: 14.sp), // Button-appropriate size
  ///   ),
  /// )
  ///
  /// // Small labels
  /// Text(
  ///   'Updated 2 hours ago',
  ///   style: TextStyle(
  ///     fontSize: 12.sp,        // Small subtitle
  ///     color: Colors.grey,
  ///   ),
  /// )
  /// ```
  ///
  /// @return Responsive font size in logical pixels
  double get sp => ResponsiveHelper.setSp(this); // for text

  /// Create vertical space (SizedBox with height)
  ///
  /// Perfect for adding consistent vertical spacing between widgets
  /// in columns or anywhere you need vertical gaps.
  ///
  /// ### Example:
  /// ```dart
  /// Column(
  ///   children: [
  ///     Text('Welcome to Rice Mill Management'),
  ///     16.verticalSpace,  // 16 pixels of vertical space
  ///
  ///     StockSummaryCard(),
  ///     24.verticalSpace,  // 24 pixels of vertical space
  ///
  ///     RecentTransactions(),
  ///     12.verticalSpace,  // 12 pixels of vertical space
  ///
  ///     QuickActions(),
  ///   ],
  /// )
  ///
  /// // In forms
  /// Column(
  ///   children: [
  ///     TextField(decoration: InputDecoration(labelText: 'Rice Type')),
  ///     16.verticalSpace,
  ///     TextField(decoration: InputDecoration(labelText: 'Quantity')),
  ///     24.verticalSpace,
  ///     ElevatedButton(child: Text('Save')),
  ///   ],
  /// )
  /// ```
  ///
  /// @return SizedBox with specified height
  SizedBox get verticalSpace => SizedBox(height: toDouble());

  /// Create horizontal space (SizedBox with width)
  ///
  /// Perfect for adding consistent horizontal spacing between widgets
  /// in rows or anywhere you need horizontal gaps.
  ///
  /// ### Example:
  /// ```dart
  /// Row(
  ///   children: [
  ///     Icon(Icons.inventory, color: Colors.green),
  ///     8.horizontalSpace,   // 8 pixels of horizontal space
  ///
  ///     Text('Stock Level:'),
  ///     4.horizontalSpace,   // 4 pixels of horizontal space
  ///
  ///     Text('1,250 kg', style: TextStyle(fontWeight: FontWeight.bold)),
  ///     16.horizontalSpace,  // 16 pixels of horizontal space
  ///
  ///     Icon(Icons.trending_up, color: Colors.green),
  ///   ],
  /// )
  ///
  /// // In button rows
  /// Row(
  ///   mainAxisAlignment: MainAxisAlignment.center,
  ///   children: [
  ///     ElevatedButton(child: Text('Cancel')),
  ///     16.horizontalSpace,
  ///     ElevatedButton(child: Text('Save')),
  ///     16.horizontalSpace,
  ///     ElevatedButton(child: Text('Submit')),
  ///   ],
  /// )
  /// ```
  ///
  /// @return SizedBox with specified width
  SizedBox get horizontalSpace => SizedBox(width: toDouble());

  /// Create EdgeInsets with equal padding on all sides
  ///
  /// Shortcut for creating uniform padding/margin values.
  ///
  /// ### Example:
  /// ```dart
  /// // Container padding
  /// Container(
  ///   padding: 16.padding,  // EdgeInsets.all(16.0)
  ///   child: Text('Padded content'),
  /// )
  ///
  /// // Card padding in rice mill app
  /// Card(
  ///   child: Container(
  ///     padding: 20.padding,
  ///     child: Column(
  ///       children: [
  ///         Text('Today\'s Production'),
  ///         Text('150 kg'),
  ///       ],
  ///     ),
  ///   ),
  /// )
  ///
  /// // Button padding
  /// ElevatedButton(
  ///   style: ElevatedButton.styleFrom(
  ///     padding: 16.padding,
  ///   ),
  ///   child: Text('Process Rice'),
  /// )
  /// ```
  ///
  /// @return EdgeInsets.all(value)
  EdgeInsets get padding => EdgeInsets.all(toDouble());

  /// Create EdgeInsets with vertical padding (top and bottom)
  ///
  /// Perfect for adding breathing room above and below content.
  ///
  /// ### Example:
  /// ```dart
  /// // List item padding
  /// ListTile(
  ///   contentPadding: 12.paddingVertical,
  ///   title: Text('Rice Batch #001'),
  ///   subtitle: Text('Processed today'),
  /// )
  ///
  /// // Section spacing
  /// Container(
  ///   padding: 24.paddingVertical,
  ///   child: Column(
  ///     children: [
  ///       Text('Monthly Report'),
  ///       ReportChart(),
  ///     ],
  ///   ),
  /// )
  ///
  /// // Form field spacing
  /// TextField(
  ///   decoration: InputDecoration(
  ///     contentPadding: 16.paddingVertical,
  ///     labelText: 'Customer Name',
  ///   ),
  /// )
  /// ```
  ///
  /// @return EdgeInsets.symmetric(vertical: value)
  EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: toDouble());

  /// Create EdgeInsets with horizontal padding (left and right)
  ///
  /// Perfect for side margins and horizontal spacing.
  ///
  /// ### Example:
  /// ```dart
  /// // Page content padding
  /// Container(
  ///   padding: 20.paddingHorizontal,
  ///   child: Column(
  ///     children: pageContent,
  ///   ),
  /// )
  ///
  /// // Text field side padding
  /// TextField(
  ///   decoration: InputDecoration(
  ///     contentPadding: 16.paddingHorizontal,
  ///     labelText: 'Search rice batches...',
  ///   ),
  /// )
  ///
  /// // Card content padding
  /// Card(
  ///   child: Container(
  ///     padding: 24.paddingHorizontal,
  ///     child: Row(
  ///       children: [
  ///         Icon(Icons.grain),
  ///         Text('Rice Inventory'),
  ///       ],
  ///     ),
  ///   ),
  /// )
  /// ```
  ///
  /// @return EdgeInsets.symmetric(horizontal: value)
  EdgeInsets get paddingHorizontal =>
      EdgeInsets.symmetric(horizontal: toDouble());

  /// Create EdgeInsets for top padding only
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   padding: 20.paddingTop,
  ///   child: Text('Content with top space'),
  /// )
  /// ```
  EdgeInsets get paddingTop => EdgeInsets.only(top: toDouble());

  /// Create EdgeInsets for bottom padding only
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   padding: 20.paddingBottom,
  ///   child: Text('Content with bottom space'),
  /// )
  /// ```
  EdgeInsets get paddingBottom => EdgeInsets.only(bottom: toDouble());

  /// Create EdgeInsets for left padding only
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   padding: 16.paddingLeft,
  ///   child: Text('Indented content'),
  /// )
  /// ```
  EdgeInsets get paddingLeft => EdgeInsets.only(left: toDouble());

  /// Create EdgeInsets for right padding only
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   padding: 16.paddingRight,
  ///   child: Text('Right-padded content'),
  /// )
  /// ```
  EdgeInsets get paddingRight => EdgeInsets.only(right: toDouble());

  /// Create BorderRadius with circular radius
  ///
  /// Perfect for rounded corners on containers, cards, and buttons.
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   decoration: BoxDecoration(
  ///     color: Colors.blue,
  ///     borderRadius: 12.borderRadius, // 12px rounded corners
  ///   ),
  ///   child: Text('Rounded container'),
  /// )
  ///
  /// // Card with custom radius
  /// Card(
  ///   shape: RoundedRectangleBorder(
  ///     borderRadius: 16.borderRadius,
  ///   ),
  ///   child: StockCard(),
  /// )
  ///
  /// // Button styling
  /// ElevatedButton(
  ///   style: ElevatedButton.styleFrom(
  ///     shape: RoundedRectangleBorder(
  ///       borderRadius: 8.borderRadius,
  ///     ),
  ///   ),
  ///   child: Text('Rounded Button'),
  /// )
  /// ```
  BorderRadius get borderRadius => BorderRadius.circular(toDouble());

  /// Create Duration from this number (in milliseconds)
  ///
  /// Convenient for animations and delays.
  ///
  /// ### Example:
  /// ```dart
  /// // Animation duration
  /// AnimatedContainer(
  ///   duration: 300.milliseconds, // 300ms
  ///   width: isExpanded ? 200.w : 100.w,
  /// )
  ///
  /// // Delayed action
  /// Future.delayed(2000.milliseconds, () {
  ///   // Execute after 2 seconds
  /// });
  ///
  /// // Snackbar duration
  /// ScaffoldMessenger.of(context).showSnackBar(
  ///   SnackBar(
  ///     content: Text('Stock updated successfully'),
  ///     duration: 3000.milliseconds,
  ///   ),
  /// );
  /// ```
  Duration get milliseconds => Duration(milliseconds: toInt());

  /// Create Duration from this number (in seconds)
  ///
  /// ### Example:
  /// ```dart
  /// Future.delayed(5.seconds, () {
  ///   // Execute after 5 seconds
  /// });
  /// ```
  Duration get seconds => Duration(seconds: toInt());
}
