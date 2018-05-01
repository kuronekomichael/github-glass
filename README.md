# github_grass

Github Contribution Viewer

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).

## Generate Icon

```bash
flutter pub pub run flutter_launcher_icons:main
git checkout ios/Runner.xcodeproj/project.pbxproj
git commit -a -m "Update icon image for iOS and Android"
```

## Build

```bash
# Build for Develop
flutter build ios --flavor Development --release
flutter build ios --flavor Development --debug

# Build for Staging
flutter build ios --flavor Staging --release
flutter build ios --flavor Staging --debug

# Build for Production
flutter build ios --flavor Production --release
flutter build ios --flavor Production --debug
```