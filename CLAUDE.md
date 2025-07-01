# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter presentation app called "Why Flutter" that showcases Flutter as a strategic choice for cross-platform development. The app is a full-screen slideshow presentation with navigation controls, speaker notes, and source links.

## Development Commands

### Setup and Dependencies
```bash
flutter pub get                    # Install dependencies
```

### Development and Testing
```bash
flutter run                       # Run the app in development mode
flutter run -d chrome             # Run in Chrome browser
flutter run -d android            # Run on Android device/emulator
flutter run -d ios                # Run on iOS simulator/device
flutter test                      # Run all tests
flutter analyze                   # Run static analysis/linting
```

### Build Commands
```bash
flutter build apk                 # Build Android APK
flutter build ios                 # Build iOS app
flutter build web                 # Build web version
flutter build windows             # Build Windows desktop app
flutter build macos               # Build macOS app
flutter build linux               # Build Linux app
```

## Architecture Overview

### Core Structure
- **main.dart**: Entry point with app configuration and dark theme setup
- **models/slide_data.dart**: Contains all presentation data and slide definitions
- **widgets/slideshow_screen.dart**: Main presentation controller with navigation and keyboard controls
- **widgets/slide_widgets.dart**: Individual slide type implementations
- **widgets/slides/**: Specialized slide components (title, statistics, performance, etc.)

### Key Components

#### Presentation System
- **SlideshowScreen**: Main controller with PageView navigation, keyboard controls (Space/Arrow keys), and animation management
- **SlideBuilder**: Factory pattern for creating different slide types based on SlideType enum
- **StartScreen**: Welcome screen with presentation start button

#### Slide Types
The app supports 8 different slide types, each with specialized layouts:
- **TitleSlide**: Opening slide with main title and key points
- **StatisticsSlide**: Data-driven slides with statistics and charts
- **PerformanceSlide**: Performance metrics with visual indicators
- **ROISlide**: Return on investment calculations
- **FutureSlide**: Forward-looking technology trends
- **PartnershipSlide**: Company/partnership information
- **InteractiveSlide**: Engagement-focused content
- **ConclusionSlide**: Summary and call-to-action

#### Data Model
- **SlideData**: Core data structure containing title, subtitle, bullet points, statistics, case studies, source links, and speaking notes
- **SourceLink**: Reference links with title, URL, and description
- **PresentationData**: Static data provider with all slide content

### Navigation Features
- Keyboard navigation (Space, Arrow keys)
- Touch/click navigation with previous/next buttons
- Slide dots indicator with direct navigation
- Slide counter display
- Full-screen presentation mode with immersive UI

### Additional Features
- **Speaking Notes**: Comprehensive presenter notes accessible via bottom sheet
- **Source Links**: Reference materials and citations for each slide
- **Animations**: Slide transition animations using AnimationController
- **Responsive Design**: Adapts to different screen sizes and orientations

## File Organization

```
lib/
├── main.dart                     # App entry point and theme
├── models/
│   └── slide_data.dart          # Data models and presentation content
└── widgets/
    ├── slideshow_screen.dart    # Main presentation controller
    ├── slide_widgets.dart       # Slide type implementations
    ├── slide_footnote.dart      # Source links and references
    ├── slide_notes_bottom_sheet.dart # Speaker notes interface
    ├── start_screen.dart        # Presentation start screen
    └── slides/                  # Individual slide components
        ├── basic_slide.dart
        ├── title_slide.dart
        ├── statistics_slide.dart
        ├── performance_slide.dart
        ├── roi_slide.dart
        ├── future_slide.dart
        ├── partnership_slide.dart
        ├── interactive_slide.dart
        └── conclusion_slide.dart
```

## Testing

The project uses Flutter's standard testing framework. Run tests with:
```bash
flutter test
```

Current test coverage includes basic widget tests for the main app functionality.

## Platform Support

This app is configured for multi-platform deployment:
- **Mobile**: Android and iOS
- **Desktop**: Windows, macOS, Linux
- **Web**: Chrome, Safari, Firefox with responsive design

## Key Dependencies

- **flutter**: Core framework
- **cupertino_icons**: iOS-style icons
- **flutter_lints**: Dart/Flutter linting rules for code quality

## Development Notes

- The app uses Material 3 design with a custom dark theme
- Immersive full-screen mode is enabled during presentations
- All slide content is defined statically in `PresentationData.getSlides()`
- The presentation follows a structured business case format for Flutter adoption