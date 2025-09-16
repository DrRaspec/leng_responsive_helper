import 'package:flutter/material.dart';
import 'package:leng_responsive_helper/responsive_helper.dart';

/// Example demonstrating ResponsiveBuilder widget
/// This shows how to create different layouts for different device sizes
class ResponsiveBuilderExample extends StatelessWidget {
  const ResponsiveBuilderExample({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ResponsiveBuilder Example'),
      ),
      body: ResponsiveBuilder(
        // Required: Mobile layout (fallback for all devices)
        mobile: _buildMobileLayout(),

        // Optional: Specialized layouts for different device sizes
        smallMobile: _buildSmallMobileLayout(),
        largeMobile: _buildLargeMobileLayout(),
        smallTablet: _buildSmallTabletLayout(),
        tablet: _buildTabletLayout(),
        largeTablet: _buildLargeTabletLayout(),
        desktop: _buildDesktopLayout(),
      ),
    );
  }

  // Mobile Layout - Single column, bottom navigation
  Widget _buildMobileLayout() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: 16.padding,
            children: [
              _buildWelcomeCard('Mobile Layout'),
              16.verticalSpace,
              _buildFeatureCard('Single Column', Icons.view_agenda),
              16.verticalSpace,
              _buildFeatureCard('Touch Optimized', Icons.touch_app),
            ],
          ),
        ),
        _buildBottomNavigation(),
      ],
    );
  }

  // Small Mobile Layout - Even more compact
  Widget _buildSmallMobileLayout() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: 12.padding,
            children: [
              _buildWelcomeCard('Small Mobile Layout'),
              12.verticalSpace,
              _buildCompactFeatureCard('Compact Design', Icons.compress),
              12.verticalSpace,
              _buildCompactFeatureCard('Space Efficient', Icons.space_bar),
            ],
          ),
        ),
        _buildBottomNavigation(),
      ],
    );
  }

  // Large Mobile Layout - Two columns where appropriate
  Widget _buildLargeMobileLayout() {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: 16.padding,
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildWelcomeCard('Large Mobile Layout'),
                    16.verticalSpace,
                  ]),
                ),
              ),
              SliverPadding(
                padding: 16.paddingHorizontal,
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.5,
                  ),
                  delegate: SliverChildListDelegate([
                    _buildFeatureCard('Two Columns', Icons.view_column),
                    _buildFeatureCard('More Space', Icons.open_in_full),
                  ]),
                ),
              ),
            ],
          ),
        ),
        _buildBottomNavigation(),
      ],
    );
  }

  // Small Tablet Layout - Navigation rail + content
  Widget _buildSmallTabletLayout() {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: _buildNavigationRail(),
        ),
        Expanded(
          child: Padding(
            padding: 20.padding,
            child: Column(
              children: [
                _buildWelcomeCard('Small Tablet Layout'),
                20.verticalSpace,
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.5,
                    children: [
                      _buildFeatureCard('Navigation Rail', Icons.menu),
                      _buildFeatureCard('Two Columns', Icons.view_column),
                      _buildFeatureCard(
                          'More Comfortable', Icons.accessibility),
                      _buildFeatureCard('Professional', Icons.business),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Tablet Layout - Full navigation drawer + multi-column content
  Widget _buildTabletLayout() {
    return Row(
      children: [
        SizedBox(
          width: 280,
          child: _buildNavigationDrawer(),
        ),
        Expanded(
          child: Padding(
            padding: 24.padding,
            child: Column(
              children: [
                _buildWelcomeCard('Tablet Layout'),
                24.verticalSpace,
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1.3,
                    children: [
                      _buildFeatureCard('Full Navigation', Icons.menu_open),
                      _buildFeatureCard('Three Columns', Icons.view_column),
                      _buildFeatureCard('Rich Content', Icons.dashboard),
                      _buildFeatureCard('Multi-tasking', Icons.layers),
                      _buildFeatureCard('Professional', Icons.business_center),
                      _buildFeatureCard('Efficient', Icons.speed),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Large Tablet Layout - Multi-pane with right sidebar
  Widget _buildLargeTabletLayout() {
    return Row(
      children: [
        // Left navigation
        SizedBox(
          width: 300,
          child: _buildNavigationDrawer(),
        ),
        // Main content
        Expanded(
          flex: 2,
          child: Padding(
            padding: 24.padding,
            child: Column(
              children: [
                _buildWelcomeCard('Large Tablet Layout'),
                24.verticalSpace,
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1.2,
                    children: List.generate(
                        8,
                        (index) => _buildFeatureCard(
                            'Feature ${index + 1}', Icons.star)),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Right sidebar
        SizedBox(
          width: 280,
          child: _buildRightSidebar(),
        ),
      ],
    );
  }

  // Desktop Layout - Full desktop experience
  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Left navigation panel
        SizedBox(
          width: 320,
          child: _buildDesktopNavigation(),
        ),
        // Main content area
        Expanded(
          flex: 3,
          child: Padding(
            padding: 32.padding,
            child: Column(
              children: [
                _buildWelcomeCard('Desktop Layout'),
                32.verticalSpace,
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 5,
                    crossAxisSpacing: 32,
                    mainAxisSpacing: 32,
                    childAspectRatio: 1.1,
                    children: List.generate(
                        10,
                        (index) => _buildFeatureCard(
                            'Desktop Feature ${index + 1}', Icons.computer)),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Right information panel
        SizedBox(
          width: 350,
          child: _buildDesktopRightPanel(),
        ),
      ],
    );
  }

  // Helper widgets for different layouts
  Widget _buildWelcomeCard(String title) {
    return Card(
      child: Padding(
        padding: 20.padding,
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            8.verticalSpace,
            Text(
              'This layout is optimized for your current device size',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(String title, IconData icon) {
    return Card(
      child: Padding(
        padding: 16.padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32),
            8.verticalSpace,
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactFeatureCard(String title, IconData icon) {
    return Card(
      child: Padding(
        padding: 12.padding,
        child: Row(
          children: [
            Icon(icon, size: 24),
            12.horizontalSpace,
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      destinations: const [
        NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
        NavigationRailDestination(
            icon: Icon(Icons.search), label: Text('Search')),
        NavigationRailDestination(
            icon: Icon(Icons.settings), label: Text('Settings')),
      ],
      selectedIndex: 0,
    );
  }

  Widget _buildNavigationDrawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('Navigation', style: TextStyle(fontSize: 18.sp)),
          ),
          const ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
          ),
          const ListTile(leading: Icon(Icons.search), title: Text('Search')),
          const ListTile(
              leading: Icon(Icons.settings), title: Text('Settings')),
          const ListTile(leading: Icon(Icons.help), title: Text('Help')),
        ],
      ),
    );
  }

  Widget _buildRightSidebar() {
    return Card(
      margin: 16.padding,
      child: Padding(
        padding: 16.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quick Info',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            16.verticalSpace,
            const Text('Recent Activity'),
            const Text('Notifications'),
            const Text('Settings'),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopNavigation() {
    return Card(
      margin: 16.padding,
      child: Column(
        children: [
          Container(
            padding: 20.padding,
            child: Text('Desktop Navigation',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView(
              children: const [
                ListTile(
                  leading: Icon(Icons.dashboard),
                  title: Text('Dashboard'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  leading: Icon(Icons.analytics),
                  title: Text('Analytics'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  leading: Icon(Icons.inventory),
                  title: Text('Inventory'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopRightPanel() {
    return Card(
      margin: 16.padding,
      child: Padding(
        padding: 20.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Information Panel',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            20.verticalSpace,
            const Text('System Status: Online'),
            const Text('Last Updated: Now'),
            const Text('Active Users: 1,247'),
            20.verticalSpace,
            const Text('Recent Notifications'),
            // Add more desktop-specific content here
          ],
        ),
      ),
    );
  }
}
