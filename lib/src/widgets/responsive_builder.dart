import 'package:flutter/material.dart';

/// ResponsiveBuilder - Advanced responsive layout builder for Flutter
///
/// This widget provides sophisticated responsive layout capabilities by automatically
/// selecting the most appropriate widget based on screen dimensions. It uses the same
/// device detection logic as ResponsiveHelper for consistent behavior across your app.
///
/// ## Key Features:
/// - **7 device categories** for precise layout control
/// - **Smart fallback system** - automatically uses the best available layout
/// - **Consistent detection** - matches ResponsiveHelper's device categorization
/// - **Optional everything** - only mobile layout is required
///
/// ## How to Use:
///
/// ### 1. Basic Usage (Mobile/Desktop):
/// ```dart
/// ResponsiveBuilder(
///   mobile: MobileHomePage(),
///   desktop: DesktopHomePage(),
/// )
/// ```
///
/// ### 2. Complete Device Coverage:
/// ```dart
/// ResponsiveBuilder(
///   mobile: MobileLayout(),
///   smallMobile: CompactMobileLayout(),     // iPhone SE optimized
///   largeMobile: PhabletLayout(),           // iPhone Pro Max optimized
///   smallTablet: CompactTabletLayout(),     // iPad Mini optimized
///   tablet: StandardTabletLayout(),         // iPad Air optimized
///   largeTablet: ProTabletLayout(),         // iPad Pro optimized
///   desktop: DesktopLayout(),               // Desktop/laptop optimized
/// )
/// ```
///
/// ### 3. Selective Usage:
/// ```dart
/// ResponsiveBuilder(
///   mobile: MobileView(),
///   largeMobile: PhabletView(),  // Special handling for big phones
///   tablet: TabletView(),        // Covers all tablet sizes
///   desktop: DesktopView(),
/// )
/// // Note: Missing layouts automatically fall back to the best available option
/// ```
class ResponsiveBuilder extends StatelessWidget {
  /// **Required**: Mobile layout widget
  ///
  /// This serves as the primary layout and ultimate fallback for all device types.
  /// Used when no more specific layout is provided for the current device.
  ///
  /// ### Design for:
  /// - Regular smartphones (iPhone 12, Samsung Galaxy S21)
  /// - Screen dimensions: width ≤ 480px and height ≤ 854px
  ///
  /// ### Example:
  /// ```dart
  /// mobile: Scaffold(
  ///   appBar: AppBar(title: Text('Rice Mill')),
  ///   body: SingleChildScrollView(
  ///     child: Column(children: [
  ///       DashboardCard(),
  ///       RecentTransactions(),
  ///     ]),
  ///   ),
  ///   bottomNavigationBar: BottomNavBar(),
  /// )
  /// ```
  final Widget mobile;

  /// **Optional**: Small mobile layout widget
  ///
  /// Specialized layout for very small phones with limited screen real estate.
  /// Falls back to `mobile` if not provided.
  ///
  /// ### Design for:
  /// - Small phones (iPhone SE 1st gen, iPhone 5s, older Android phones)
  /// - Screen dimensions: width ≤ 360px and height ≤ 640px
  ///
  /// ### Design considerations:
  /// - Use smaller font sizes and compact spacing
  /// - Minimize vertical scrolling with efficient layouts
  /// - Consider single-column layouts even where mobile uses two columns
  ///
  /// ### Example:
  /// ```dart
  /// smallMobile: Scaffold(
  ///   appBar: AppBar(
  ///     title: Text('Rice Mill', style: TextStyle(fontSize: 16)),
  ///     toolbarHeight: 48, // Reduced height for small screens
  ///   ),
  ///   body: ListView(
  ///     padding: EdgeInsets.all(8), // Tighter padding
  ///     children: [
  ///       CompactDashboardCard(),
  ///       CompactTransactionList(),
  ///     ],
  ///   ),
  /// )
  /// ```
  final Widget? smallMobile;

  /// **Optional**: Large mobile layout widget
  ///
  /// Specialized layout for phablets and large smartphones with extra screen space.
  /// Falls back to `mobile` if not provided.
  ///
  /// ### Design for:
  /// - Large phones/phablets (iPhone 12 Pro Max, Samsung Galaxy Note series)
  /// - Screen dimensions: width ≤ 600px and height ≤ 960px
  ///
  /// ### Design considerations:
  /// - Take advantage of extra width for two-column layouts
  /// - Use larger touch targets and more generous spacing
  /// - Consider showing more content per screen
  ///
  /// ### Example:
  /// ```dart
  /// largeMobile: Scaffold(
  ///   appBar: AppBar(title: Text('Rice Mill Management')), // Longer title
  ///   body: CustomScrollView(
  ///     slivers: [
  ///       SliverGrid(
  ///         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  ///           crossAxisCount: 2, // Two columns for phablets
  ///           childAspectRatio: 1.5,
  ///         ),
  ///         delegate: SliverChildListDelegate([
  ///           DashboardCard(expanded: true),
  ///           RevenueCard(expanded: true),
  ///         ]),
  ///       ),
  ///     ],
  ///   ),
  /// )
  /// ```
  final Widget? largeMobile;

  /// **Optional**: Small tablet layout widget
  ///
  /// Specialized layout for compact tablets that bridge mobile and tablet experiences.
  /// Falls back to `tablet`, then `largeMobile`, then `mobile` if not provided.
  ///
  /// ### Design for:
  /// - Small tablets (iPad Mini, Samsung Galaxy Tab A 8.0)
  /// - Screen dimensions: width ≤ 768px and height ≤ 1024px
  ///
  /// ### Design considerations:
  /// - Transition between mobile and tablet paradigms
  /// - Multi-column layouts start to become viable
  /// - Navigation can be more prominent than mobile
  ///
  /// ### Example:
  /// ```dart
  /// smallTablet: Scaffold(
  ///   appBar: AppBar(
  ///     title: Text('Rice Mill Management System'),
  ///     actions: [
  ///       IconButton(icon: Icon(Icons.search)),
  ///       IconButton(icon: Icon(Icons.notifications)),
  ///       IconButton(icon: Icon(Icons.account_circle)),
  ///     ],
  ///   ),
  ///   body: Row(
  ///     children: [
  ///       SizedBox(
  ///         width: 200,
  ///         child: NavigationRail(/* compact side nav */),
  ///       ),
  ///       Expanded(
  ///         child: GridView.count(
  ///           crossAxisCount: 2, // Two-column content
  ///           children: dashboardCards,
  ///         ),
  ///       ),
  ///     ],
  ///   ),
  /// )
  /// ```
  final Widget? smallTablet;

  /// **Optional**: Standard tablet layout widget
  ///
  /// Layout optimized for regular-sized tablets with comfortable viewing and interaction.
  /// Falls back to `smallTablet`, then `mobile` if not provided.
  ///
  /// ### Design for:
  /// - Regular tablets (iPad Air, Samsung Galaxy Tab S6)
  /// - Screen dimensions: width ≤ 1024px and height ≤ 1366px
  ///
  /// ### Design considerations:
  /// - Full tablet experience with multi-column layouts
  /// - Side navigation or tab bars become standard
  /// - More content can be displayed simultaneously
  /// - Touch targets optimized for tablet interaction
  ///
  /// ### Example:
  /// ```dart
  /// tablet: Scaffold(
  ///   body: Row(
  ///     children: [
  ///       SizedBox(
  ///         width: 250,
  ///         child: NavigationDrawer(
  ///           children: [
  ///             DrawerHeader(child: Text('Rice Mill Pro')),
  ///             NavigationDrawerDestination(
  ///               icon: Icon(Icons.dashboard),
  ///               label: Text('Dashboard'),
  ///             ),
  ///             // ... more navigation items
  ///           ],
  ///         ),
  ///       ),
  ///       Expanded(
  ///         child: Column(
  ///           children: [
  ///             TabletAppBar(),
  ///             Expanded(
  ///               child: GridView.count(
  ///                 crossAxisCount: 3, // Three-column layout
  ///                 children: dashboardWidgets,
  ///               ),
  ///             ),
  ///           ],
  ///         ),
  ///       ),
  ///     ],
  ///   ),
  /// )
  /// ```
  final Widget? tablet;

  /// **Optional**: Large tablet layout widget
  ///
  /// Layout for professional tablets with extensive screen real estate.
  /// Falls back to `tablet`, then `smallTablet`, then `mobile` if not provided.
  ///
  /// ### Design for:
  /// - Large tablets (iPad Pro 12.9", Microsoft Surface Pro)
  /// - Screen dimensions: width ≤ 1440px and height ≤ 1800px
  ///
  /// ### Design considerations:
  /// - Desktop-class experience in tablet form factor
  /// - Multi-pane layouts with master-detail views
  /// - Professional workflows and complex interactions
  /// - Rich data visualization and charts
  ///
  /// ### Example:
  /// ```dart
  /// largeTablet: Scaffold(
  ///   body: Row(
  ///     children: [
  ///       // Side navigation panel
  ///       SizedBox(
  ///         width: 300,
  ///         child: Card(
  ///           child: Column(
  ///             children: [
  ///               UserProfileHeader(),
  ///               Expanded(child: NavigationMenu()),
  ///             ],
  ///           ),
  ///         ),
  ///       ),
  ///       // Main content area
  ///       Expanded(
  ///         flex: 2,
  ///         child: Column(
  ///           children: [
  ///             ProfessionalAppBar(),
  ///             Expanded(
  ///               child: GridView.count(
  ///                 crossAxisCount: 4, // Four-column layout
  ///                 children: detailedDashboardCards,
  ///               ),
  ///             ),
  ///           ],
  ///         ),
  ///       ),
  ///       // Right panel for additional info
  ///       SizedBox(
  ///         width: 250,
  ///         child: Card(child: RecentActivityPanel()),
  ///       ),
  ///     ],
  ///   ),
  /// )
  /// ```
  final Widget? largeTablet;

  /// **Optional**: Desktop layout widget
  ///
  /// Full desktop experience optimized for mouse and keyboard interaction.
  /// Falls back to `largeTablet`, then `tablet`, then `mobile` if not provided.
  ///
  /// ### Design for:
  /// - Desktop monitors and laptop screens
  /// - Screen dimensions: width > 1440px or height > 1800px
  ///
  /// ### Design considerations:
  /// - Full desktop paradigms (hover states, right-click menus)
  /// - Complex multi-window layouts
  /// - Keyboard shortcuts and accessibility
  /// - Dense information display
  /// - Professional business application feel
  ///
  /// ### Example:
  /// ```dart
  /// desktop: Scaffold(
  ///   appBar: PreferredSize(
  ///     preferredSize: Size.fromHeight(60),
  ///     child: AppBar(
  ///       title: Row(
  ///         children: [
  ///           Image.asset('assets/logo.png', height: 40),
  ///           SizedBox(width: 16),
  ///           Text('Rice Mill Management System'),
  ///         ],
  ///       ),
  ///       actions: [
  ///         TextButton.icon(
  ///           icon: Icon(Icons.dashboard),
  ///           label: Text('Dashboard'),
  ///           onPressed: () {},
  ///         ),
  ///         TextButton.icon(
  ///           icon: Icon(Icons.inventory),
  ///           label: Text('Inventory'),
  ///           onPressed: () {},
  ///         ),
  ///         TextButton.icon(
  ///           icon: Icon(Icons.analytics),
  ///           label: Text('Reports'),
  ///           onPressed: () {},
  ///         ),
  ///         // ... more menu items
  ///       ],
  ///     ),
  ///   ),
  ///   body: Row(
  ///     children: [
  ///       // Left sidebar
  ///       SizedBox(
  ///         width: 280,
  ///         child: Card(
  ///           child: Column(
  ///             children: [
  ///               QuickStatsPanel(),
  ///               Expanded(child: DetailedNavigationTree()),
  ///             ],
  ///           ),
  ///         ),
  ///       ),
  ///       // Main content area
  ///       Expanded(
  ///         flex: 3,
  ///         child: Padding(
  ///           padding: EdgeInsets.all(16),
  ///           child: GridView.count(
  ///             crossAxisCount: 5, // Five-column desktop layout
  ///             crossAxisSpacing: 16,
  ///             mainAxisSpacing: 16,
  ///             children: comprehensiveDashboardCards,
  ///           ),
  ///         ),
  ///       ),
  ///       // Right panel
  ///       SizedBox(
  ///         width: 320,
  ///         child: Card(
  ///           child: Column(
  ///             children: [
  ///               NotificationsPanel(),
  ///               Expanded(child: DetailedActivityFeed()),
  ///             ],
  ///           ),
  ///         ),
  ///       ),
  ///     ],
  ///   ),
  /// )
  /// ```
  final Widget? desktop;

  /// Creates a responsive builder widget
  ///
  /// ### Required Parameters:
  /// - **mobile**: The base layout widget (used as fallback for all devices)
  ///
  /// ### Optional Parameters:
  /// - **smallMobile**: Layout for small phones (iPhone SE, etc.)
  /// - **largeMobile**: Layout for phablets (iPhone Pro Max, etc.)
  /// - **smallTablet**: Layout for compact tablets (iPad Mini, etc.)
  /// - **tablet**: Layout for standard tablets (iPad Air, etc.)
  /// - **largeTablet**: Layout for large tablets (iPad Pro, etc.)
  /// - **desktop**: Layout for desktop/laptop screens
  ///
  /// ### Example:
  /// ```dart
  /// const ResponsiveBuilder(
  ///   mobile: MobileHomePage(),
  ///   tablet: TabletHomePage(),
  ///   desktop: DesktopHomePage(),
  /// )
  /// ```
  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.smallMobile,
    this.largeMobile,
    this.smallTablet,
    this.tablet,
    this.largeTablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        // Desktop check first (width > 1440 or height > 1800)
        // Examples: Desktop monitors, laptop screens, large displays
        if (width > 1440 || height > 1800) {
          return desktop ?? largeTablet ?? tablet ?? mobile;
        }

        // Large tablet check
        // Examples: iPad Pro 12.9", Microsoft Surface Pro
        // Dimensions: width ≤ 1440px and height ≤ 1800px
        if (width <= 1440 &&
            height <= 1800 &&
            (width > 1024 || height > 1366)) {
          return largeTablet ?? tablet ?? smallTablet ?? mobile;
        }

        // Regular tablet check
        // Examples: iPad Air, Samsung Galaxy Tab S6
        // Dimensions: width ≤ 1024px and height ≤ 1366px
        if (width <= 1024 && height <= 1366 && (width > 768 || height > 1024)) {
          return tablet ?? smallTablet ?? largeTablet ?? mobile;
        }

        // Small tablet check
        // Examples: iPad Mini, Samsung Galaxy Tab A 8.0
        // Dimensions: width ≤ 768px and height ≤ 1024px
        if (width <= 768 && height <= 1024 && (width > 600 || height > 960)) {
          return smallTablet ?? tablet ?? largeMobile ?? mobile;
        }

        // Large mobile check (phablets)
        // Examples: iPhone 12 Pro Max, Samsung Galaxy Note series
        // Dimensions: width ≤ 600px and height ≤ 960px
        if (width <= 600 && height <= 960 && (width > 480 || height > 854)) {
          return largeMobile ?? mobile;
        }

        // Small mobile check
        // Examples: iPhone SE (1st gen), iPhone 5s, small Android phones
        // Dimensions: width ≤ 360px and height ≤ 640px
        if (width <= 360 && height <= 640) {
          return smallMobile ?? mobile;
        }

        // Default mobile
        // Examples: iPhone 12, iPhone 13, Samsung Galaxy S21
        // Dimensions: width ≤ 480px and height ≤ 854px
        return mobile;
      },
    );
  }
}

/// SimpleResponsiveBuilder - Streamlined responsive layout builder
///
/// A simplified version of ResponsiveBuilder with fewer breakpoints for
/// applications that don't need fine-grained device control.
///
/// ## Use Cases:
/// - Simple apps with basic responsive needs
/// - Rapid prototyping and MVP development
/// - Apps where detailed device optimization isn't critical
///
/// ## Device Categories:
/// - **Mobile**: All phone sizes (including small and large phones)
/// - **Large Mobile**: Phablets that benefit from different layouts
/// - **Tablet**: All tablet sizes (small, regular, and large tablets)
/// - **Desktop**: Desktop and laptop screens
///
/// ### Example:
/// ```dart
/// SimpleResponsiveBuilder(
///   mobile: MobileLayout(),
///   largeMobile: PhabletLayout(),  // Optional: special phablet handling
///   tablet: TabletLayout(),        // Covers all tablet sizes
///   desktop: DesktopLayout(),
/// )
/// ```
class SimpleResponsiveBuilder extends StatelessWidget {
  /// **Required**: Mobile layout widget
  ///
  /// Used for all phone sizes unless more specific layouts are provided.
  /// Serves as the ultimate fallback for all device types.
  final Widget mobile;

  /// **Optional**: Large mobile layout widget
  ///
  /// Specialized layout for phablets and large smartphones.
  /// Falls back to `mobile` if not provided.
  final Widget? largeMobile;

  /// **Optional**: Tablet layout widget
  ///
  /// Used for all tablet sizes (small, regular, and large tablets).
  /// Falls back to `largeMobile`, then `mobile` if not provided.
  final Widget? tablet;

  /// **Optional**: Desktop layout widget
  ///
  /// Used for desktop monitors and laptop screens.
  /// Falls back to `tablet`, then `mobile` if not provided.
  final Widget? desktop;

  /// Creates a simple responsive builder widget
  ///
  /// ### Required Parameters:
  /// - **mobile**: The base layout widget
  ///
  /// ### Optional Parameters:
  /// - **largeMobile**: Layout for phablets
  /// - **tablet**: Layout for all tablet sizes
  /// - **desktop**: Layout for desktop screens
  ///
  /// ### Example:
  /// ```dart
  /// const SimpleResponsiveBuilder(
  ///   mobile: MobileView(),
  ///   tablet: TabletView(),
  ///   desktop: DesktopView(),
  /// )
  /// ```
  const SimpleResponsiveBuilder({
    super.key,
    required this.mobile,
    this.largeMobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Desktop - Large screens (> 1024px)
        if (width > 1024) {
          return desktop ?? tablet ?? mobile;
        }

        // Tablet - Medium screens (600px - 1024px)
        if (width > 600) {
          return tablet ?? largeMobile ?? mobile;
        }

        // Large mobile - Phablets (480px - 600px)
        if (width > 480) {
          return largeMobile ?? mobile;
        }

        // Mobile - Small screens (≤ 480px)
        return mobile;
      },
    );
  }
}
