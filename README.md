# Leng Responsive Helper

A concise Flutter package for building responsive user interfaces that adapt across device sizes.

## Quick Start

```dart
import 'package:leng_responsive_helper/responsive_helper.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);

    return Scaffold(
      body: Center(
        child: Container(
          width: 300.w,
          height: 200.h,
          padding: 16.padding,
          child: Text('Hello World', style: TextStyle(fontSize: 18.sp)),
        ),
      ),
    );
  }
}
```

## Examples

See `lib/src/example/` for multiple example screens: getting started, responsive builder, advanced examples, navigation, and a responsive form.

## Note about color / opacity

Avoid `Color.withOpacity(double)` in favor of the safer alpha setter used by this package:

- Deprecated: `color.withOpacity(0.2)`
- Recommended: `color.withValues(alpha: 0.2)`

## Running examples and tests

From the package root (PowerShell):

```powershell
flutter pub get
flutter test
flutter run
```

## Common usage patterns

```dart
// Initialize once per screen
ResponsiveHelper.init(context);

// Responsive dimension
final w = 200.w;

// Responsive font
Text('Hi', style: TextStyle(fontSize: 16.sp));
```
