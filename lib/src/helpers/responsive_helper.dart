import 'package:flutter/widgets.dart';

/// Enum defining device size categories based on actual device dimensions
enum DeviceSize {
  /// Small phones (iPhone SE, older Android devices)
  /// - Dimensions: width ≤ 360px and height ≤ 640px
  /// - Examples: iPhone SE (1st gen), iPhone 5s, small Android phones
  smallMobile,

  /// Regular smartphones (most modern phones)
  /// - Dimensions: width ≤ 480px and height ≤ 854px
  /// - Examples: iPhone 12, iPhone 13, Samsung Galaxy S21
  mobile,

  /// Large phones/phablets (big smartphones)
  /// - Dimensions: width ≤ 600px and height ≤ 960px
  /// - Examples: iPhone 12 Pro Max, Samsung Galaxy Note series
  largeMobile,

  /// Custom size for 600x800 tablets/devices
  /// - Dimensions: width = 600px and height = 800px
  /// - Examples: Specific tablet models, custom devices
  custom600x800,

  /// Small tablets (compact tablets)
  /// - Dimensions: width ≤ 768px and height ≤ 1024px
  /// - Examples: iPad Mini, Samsung Galaxy Tab A 8.0
  smallTablet,

  /// Regular tablets (standard tablets)
  /// - Dimensions: width ≤ 1024px and height ≤ 1366px
  /// - Examples: iPad Air, Samsung Galaxy Tab S6
  tablet,

  /// Large tablets (professional tablets)
  /// - Dimensions: width ≤ 1440px and height ≤ 1800px
  /// - Examples: iPad Pro 12.9", Microsoft Surface Pro
  largeTablet,

  /// Desktop/laptop screens
  /// - Dimensions: width > 1440px or height > 1800px
  /// - Examples: Desktop monitors, laptop screens, large displays
  desktop,
}

class ResponsiveHelper {
  static late double _screenWidth;
  static late double _screenHeight;
  static late DeviceSize _deviceSize;

  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _deviceSize = _determineDeviceSize(_screenWidth, _screenHeight);
  }

  /// Determine device size based on both width and height
  static DeviceSize _determineDeviceSize(double width, double height) {
    // Desktop check first
    if (width > 1440 || height > 1800) {
      return DeviceSize.desktop;
    }

    // Large tablet check
    if (width <= 1440 && height <= 1800 && (width > 1024 || height > 1366)) {
      return DeviceSize.largeTablet;
    }

    // Regular tablet check
    if (width <= 1024 && height <= 1366 && (width > 768 || height > 1024)) {
      return DeviceSize.tablet;
    }

    // Small tablet check
    if (width <= 768 && height <= 1024 && (width > 600 || height > 960)) {
      return DeviceSize.smallTablet;
    }

    // Custom 600x800 check (check this BEFORE largeMobile)
    if (width == 600 && height == 800) {
      return DeviceSize.custom600x800;
    }

    // Large mobile check (phablets) - now excludes 600x800
    if (width <= 600 && height <= 960 && (width > 480 || height > 854)) {
      return DeviceSize.largeMobile;
    }

    // Small mobile check
    if (width <= 360 && height <= 640) {
      return DeviceSize.smallMobile;
    }

    // Default mobile
    return DeviceSize.mobile;
  }

  static DeviceSize get deviceSize => _deviceSize;

  /// Get design dimensions (baseline) for current device size
  static Map<String, double> get designDimensions {
    switch (_deviceSize) {
      case DeviceSize.smallMobile:
        return {'width': 320.0, 'height': 568.0}; // iPhone SE
      case DeviceSize.mobile:
        return {'width': 375.0, 'height': 812.0}; // iPhone 12
      case DeviceSize.largeMobile:
        return {'width': 414.0, 'height': 896.0}; // iPhone 12 Pro Max
      case DeviceSize.custom600x800:
        return {'width': 600.0, 'height': 800.0}; // Custom 600x800 baseline
      case DeviceSize.smallTablet:
        return {'width': 768.0, 'height': 1024.0}; // iPad Mini
      case DeviceSize.tablet:
        return {'width': 834.0, 'height': 1194.0}; // iPad Air
      case DeviceSize.largeTablet:
        return {'width': 1024.0, 'height': 1366.0}; // iPad Pro
      case DeviceSize.desktop:
        return {'width': 1440.0, 'height': 900.0}; // Standard desktop
    }
  }

  static double setWidth(num width) {
    final designWidth = designDimensions['width']!;
    return width * _screenWidth / designWidth;
  }

  static double setHeight(num height) {
    final designHeight = designDimensions['height']!;
    return height * _screenHeight / designHeight;
  }

  /// Set responsive font size with device-specific scaling
  static double setSp(num fontSize) {
    final baseSize = setWidth(fontSize);

    // Apply device-specific font scaling
    switch (_deviceSize) {
      case DeviceSize.smallMobile:
        return baseSize * 0.9;
      case DeviceSize.mobile:
        return baseSize;
      case DeviceSize.largeMobile:
        return baseSize * 1.05;
      case DeviceSize.custom600x800:
        return baseSize * 0.9;
      case DeviceSize.smallTablet:
        return baseSize * 1.1;
      case DeviceSize.tablet:
        return baseSize * 1.15;
      case DeviceSize.largeTablet:
        return baseSize * 1.2;
      case DeviceSize.desktop:
        return baseSize * 1.25;
    }
  }

  static T getResponsiveValue<T>({
    T? smallMobile,
    T? mobile,
    T? largeMobile,
    T? custom600x800,
    T? smallTablet,
    T? tablet,
    T? largeTablet,
    T? desktop,
    required T fallback,
  }) {
    switch (_deviceSize) {
      case DeviceSize.smallMobile:
        return smallMobile ?? mobile ?? fallback;
      case DeviceSize.mobile:
        return mobile ?? fallback;
      case DeviceSize.largeMobile:
        return largeMobile ?? mobile ?? fallback;
      case DeviceSize.custom600x800:
        return custom600x800 ?? smallTablet ?? mobile ?? fallback;
      case DeviceSize.smallTablet:
        return smallTablet ?? tablet ?? largeMobile ?? mobile ?? fallback;
      case DeviceSize.tablet:
        return tablet ?? smallTablet ?? fallback;
      case DeviceSize.largeTablet:
        return largeTablet ?? tablet ?? fallback;
      case DeviceSize.desktop:
        return desktop ?? largeTablet ?? tablet ?? fallback;
    }
  }

  /// Check if current device belongs to mobile category
  static bool get isMobile => [
        DeviceSize.smallMobile,
        DeviceSize.mobile,
        DeviceSize.largeMobile,
      ].contains(_deviceSize);

  /// Check if current device belongs to tablet category
  static bool get isTablet => [
        DeviceSize.smallTablet,
        DeviceSize.tablet,
        DeviceSize.largeTablet,
        DeviceSize.custom600x800, // You might want to include this as tablet
      ].contains(_deviceSize);

  /// Check if current device is the custom 600x800 size
  static bool get is600x800 => _deviceSize == DeviceSize.custom600x800;

  static bool get isDesktop => _deviceSize == DeviceSize.desktop;

  static String get debugInfo =>
      'Screen: ${_screenWidth.toInt()}x${_screenHeight.toInt()}, '
      'Device: ${_deviceSize.name}, '
      'Design: ${designDimensions['width']!.toInt()}x${designDimensions['height']!.toInt()}';
}
