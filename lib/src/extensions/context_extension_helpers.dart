import 'package:flutter/material.dart';

/// ContextExtension - Convenient BuildContext utilities
///
/// This extension adds helpful shortcut methods to BuildContext for common
/// operations like navigation, theming, media queries, and more.
///
/// ## Categories:
///
/// ### 🎨 Theme & Styling:
/// - `context.theme` → Current ThemeData
/// - `context.textTheme` → Current TextTheme
/// - `context.colorScheme` → Current ColorScheme
///
/// ### 📱 Device Information:
/// - `context.mediaQuery` → MediaQueryData
/// - `context.size` → Screen size
/// - `context.orientation` → Portrait/Landscape
///
/// ### 🚀 Navigation:
/// - `context.push()` → Navigate to route
/// - `context.pop()` → Go back
/// - `context.pushAndRemoveUntil()` → Replace navigation stack
///
/// ### 💬 Dialogs & Snackbars:
/// - `context.showSnackBar()` → Show snackbar
/// - `context.showDialog()` → Show dialog
/// - `context.hideKeyboard()` → Dismiss keyboard
///
/// ## Examples:
///
/// ```dart
/// // Theme access
/// Text(
///   'Hello',
///   style: context.textTheme.headlineMedium?.copyWith(
///     color: context.colorScheme.primary,
///   ),
/// )
///
/// // Navigation
/// ElevatedButton(
///   onPressed: () => context.push('/stock-detail'),
///   child: Text('View Details'),
/// )
///
/// // Snackbar
/// context.showSnackBar('Stock updated successfully!');
///
/// // Device info
/// if (context.isPortrait) {
///   // Portrait layout
/// }
/// ```
extension ContextExtension on BuildContext {
  /// Get current theme data
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   color: context.theme.primaryColor,
  ///   child: Text('Themed container'),
  /// )
  /// ```
  ThemeData get theme => Theme.of(this);

  /// Get current text theme
  ///
  /// ### Example:
  /// ```dart
  /// Text(
  ///   'Dashboard Title',
  ///   style: context.textTheme.headlineLarge,
  /// )
  ///
  /// Text(
  ///   'Subtitle',
  ///   style: context.textTheme.bodyMedium?.copyWith(
  ///     color: Colors.grey,
  ///   ),
  /// )
  /// ```
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Get current color scheme
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   decoration: BoxDecoration(
  ///     color: context.colorScheme.primary,
  ///     borderRadius: BorderRadius.circular(8),
  ///   ),
  ///   child: Text(
  ///     'Primary colored container',
  ///     style: TextStyle(color: context.colorScheme.onPrimary),
  ///   ),
  /// )
  ///
  /// // Error styling
  /// Text(
  ///   'Error message',
  ///   style: TextStyle(color: context.colorScheme.error),
  /// )
  /// ```
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Get MediaQuery data
  ///
  /// ### Example:
  /// ```dart
  /// if (context.mediaQuery.orientation == Orientation.landscape) {
  ///   // Landscape layout
  /// }
  ///
  /// double statusBarHeight = context.mediaQuery.padding.top;
  /// ```
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get screen size
  ///
  /// ### Example:
  /// ```dart
  /// Size screenSize = context.size;
  /// double width = context.size.width;
  /// double height = context.size.height;
  ///
  /// if (context.size.width > 600) {
  ///   // Wide screen layout
  /// }
  /// ```
  Size get size => MediaQuery.of(this).size;

  /// Check if device is in portrait mode
  ///
  /// ### Example:
  /// ```dart
  /// Widget buildLayout() {
  ///   if (context.isPortrait) {
  ///     return Column(children: widgets); // Vertical layout
  ///   } else {
  ///     return Row(children: widgets);    // Horizontal layout
  ///   }
  /// }
  /// ```
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  /// Check if device is in landscape mode
  ///
  /// ### Example:
  /// ```dart
  /// if (context.isLandscape) {
  ///   // Show side-by-side panels
  ///   return Row(children: [LeftPanel(), RightPanel()]);
  /// }
  /// ```
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  /// Get status bar height
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   margin: EdgeInsets.only(top: context.statusBarHeight),
  ///   child: Text('Below status bar'),
  /// )
  /// ```
  double get statusBarHeight => MediaQuery.of(this).padding.top;

  /// Get bottom padding (for devices with home indicator)
  ///
  /// ### Example:
  /// ```dart
  /// Container(
  ///   margin: EdgeInsets.only(bottom: context.bottomPadding),
  ///   child: Text('Above home indicator'),
  /// )
  /// ```
  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  /// Navigate to named route
  ///
  /// ### Example:
  /// ```dart
  /// // Simple navigation
  /// context.push('/stock-detail');
  ///
  /// // With arguments
  /// context.push('/stock-detail', arguments: {'stockId': '123'});
  ///
  /// // In button
  /// ElevatedButton(
  ///   onPressed: () => context.push('/add-stock'),
  ///   child: Text('Add New Stock'),
  /// )
  /// ```
  Future<T?> push<T extends Object?>(String routeName, {Object? arguments}) {
    return Navigator.pushNamed<T>(this, routeName, arguments: arguments);
  }

  /// Navigate and replace current route
  ///
  /// ### Example:
  /// ```dart
  /// // Replace login with dashboard
  /// context.pushReplacement('/dashboard');
  /// ```
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return Navigator.pushReplacementNamed<T, TO>(
      this,
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  /// Navigate and clear navigation stack
  ///
  /// ### Example:
  /// ```dart
  /// // Go to dashboard and clear all previous routes
  /// context.pushAndRemoveUntil('/dashboard');
  ///
  /// // Logout flow
  /// context.pushAndRemoveUntil('/login');
  /// ```
  Future<T?> pushAndRemoveUntil<T extends Object?>(
    String newRouteName, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      this,
      newRouteName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Go back to previous route
  ///
  /// ### Example:
  /// ```dart
  /// // Simple back navigation
  /// context.pop();
  ///
  /// // Back with result
  /// context.pop('result_data');
  ///
  /// // In app bar
  /// AppBar(
  ///   leading: IconButton(
  ///     icon: Icon(Icons.arrow_back),
  ///     onPressed: () => context.pop(),
  ///   ),
  /// )
  /// ```
  void pop<T extends Object?>([T? result]) {
    Navigator.pop<T>(this, result);
  }

  /// Check if can go back
  ///
  /// ### Example:
  /// ```dart
  /// if (context.canPop) {
  ///   // Show back button
  ///   IconButton(
  ///     icon: Icon(Icons.arrow_back),
  ///     onPressed: () => context.pop(),
  ///   )
  /// }
  /// ```
  bool get canPop => Navigator.canPop(this);

  /// Show snackbar with message
  ///
  /// ### Example:
  /// ```dart
  /// // Simple message
  /// context.showSnackBar('Stock updated successfully!');
  ///
  /// // Custom styling
  /// context.showSnackBar(
  ///   'Error: Could not save stock',
  ///   backgroundColor: Colors.red,
  ///   textColor: Colors.white,
  ///   duration: Duration(seconds: 5),
  /// );
  ///
  /// // With action
  /// context.showSnackBar(
  ///   'Stock deleted',
  ///   action: SnackBarAction(
  ///     label: 'UNDO',
  ///     onPressed: () => _undoDelete(),
  ///   ),
  /// );
  /// ```
  void showSnackBar(
    String message, {
    Color? backgroundColor,
    Color? textColor,
    Duration? duration,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: textColor)),
        backgroundColor: backgroundColor,
        duration: duration ?? const Duration(seconds: 4),
        action: action,
      ),
    );
  }

  /// Show success snackbar (green)
  ///
  /// ### Example:
  /// ```dart
  /// context.showSuccessSnackBar('Rice batch processed successfully!');
  /// ```
  void showSuccessSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  /// Show error snackbar (red)
  ///
  /// ### Example:
  /// ```dart
  /// context.showErrorSnackBar('Failed to connect to server');
  /// ```
  void showErrorSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      duration: const Duration(seconds: 6),
    );
  }

  /// Show warning snackbar (orange)
  ///
  /// ### Example:
  /// ```dart
  /// context.showWarningSnackBar('Stock level is running low');
  /// ```
  void showWarningSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      duration: const Duration(seconds: 5),
    );
  }

  /// Show info snackbar (blue)
  ///
  /// ### Example:
  /// ```dart
  /// context.showInfoSnackBar('New rice batch has arrived');
  /// ```
  void showInfoSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );
  }

  /// Show dialog
  ///
  /// ### Example:
  /// ```dart
  /// context.showDialog(
  ///   AlertDialog(
  ///     title: Text('Confirm Delete'),
  ///     content: Text('Are you sure you want to delete this stock?'),
  ///     actions: [
  ///       TextButton(
  ///         onPressed: () => context.pop(),
  ///         child: Text('Cancel'),
  ///       ),
  ///       TextButton(
  ///         onPressed: () {
  ///           _deleteStock();
  ///           context.pop();
  ///         },
  ///         child: Text('Delete'),
  ///       ),
  ///     ],
  ///   ),
  /// );
  /// ```
  Future<T?> showDialogWidget<T>(Widget dialog) {
    return showDialog<T>(context: this, builder: (context) => dialog);
  }

  /// Show confirmation dialog
  ///
  /// ### Example:
  /// ```dart
  /// bool? confirmed = await context.showConfirmationDialog(
  ///   title: 'Delete Stock',
  ///   message: 'Are you sure you want to delete this rice batch?',
  ///   confirmText: 'Delete',
  ///   cancelText: 'Cancel',
  /// );
  ///
  /// if (confirmed == true) {
  ///   // User confirmed, proceed with deletion
  ///   _deleteStock();
  /// }
  /// ```
  Future<bool?> showConfirmationDialog({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    Color? confirmColor,
  }) {
    return showDialog<bool>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: confirmColor != null
                ? TextButton.styleFrom(foregroundColor: confirmColor)
                : null,
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  /// Hide keyboard
  ///
  /// ### Example:
  /// ```dart
  /// // When submitting form
  /// void submitForm() {
  ///   context.hideKeyboard(); // Hide keyboard first
  ///   // Process form...
  /// }
  ///
  /// // On tap outside
  /// GestureDetector(
  ///   onTap: () => context.hideKeyboard(),
  ///   child: Container(/* ... */),
  /// )
  /// ```
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  /// Check if keyboard is visible
  ///
  /// ### Example:
  /// ```dart
  /// if (context.isKeyboardVisible) {
  ///   // Adjust layout for keyboard
  ///   return SingleChildScrollView(child: form);
  /// } else {
  ///   return form;
  /// }
  /// ```
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  /// Get keyboard height
  ///
  /// ### Example:
  /// ```dart
  /// double keyboardHeight = context.keyboardHeight;
  ///
  /// // Adjust bottom padding
  /// Container(
  ///   padding: EdgeInsets.only(bottom: keyboardHeight),
  ///   child: form,
  /// )
  /// ```
  double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;

  /// Check if device is in dark mode
  ///
  /// ### Example:
  /// ```dart
  /// Color backgroundColor = context.isDarkMode
  ///     ? Colors.grey[900]!
  ///     : Colors.grey[100]!;
  ///
  /// Icon(
  ///   context.isDarkMode ? Icons.light_mode : Icons.dark_mode,
  /// )
  /// ```
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Check if device is in light mode
  ///
  /// ### Example:
  /// ```dart
  /// if (context.isLightMode) {
  ///   // Light mode specific styling
  /// }
  /// ```
  bool get isLightMode => Theme.of(this).brightness == Brightness.light;

  /// Get current locale
  ///
  /// ### Example:
  /// ```dart
  /// Locale currentLocale = context.locale;
  /// String languageCode = context.locale.languageCode; // 'en', 'es', etc.
  ///
  /// if (context.locale.languageCode == 'en') {
  ///   // English-specific logic
  /// }
  /// ```
  Locale get locale => Localizations.localeOf(this);

  /// Check if text direction is RTL (Right-to-Left)
  ///
  /// ### Example:
  /// ```dart
  /// if (context.isRTL) {
  ///   // Arabic, Hebrew, etc. - adjust layout accordingly
  ///   return Row(
  ///     textDirection: TextDirection.rtl,
  ///     children: widgets,
  ///   );
  /// }
  /// ```
  bool get isRTL => Directionality.of(this) == TextDirection.rtl;

  /// Get text direction
  ///
  /// ### Example:
  /// ```dart
  /// Row(
  ///   textDirection: context.textDirection,
  ///   children: widgets,
  /// )
  /// ```
  TextDirection get textDirection => Directionality.of(this);
}
