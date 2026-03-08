# अर्थ खबर (Arthakhabar) Mobile App

Nepal's Leading Economic News Portal - Flutter mobile application.

## Features

- **News Feed**: Browse latest news from Arthakhabar with category tabs
- **Categories**: Dynamic tabs loaded from API (`/ak_api/app/v1/categories`)
- **Article View**: Tap any article to read full content in-app (WebView)
- **Menu**: Hamburger drawer with:
  - हाम्रो बारेमा (About Us)
  - सम्पर्क गर्नुहोस् (Contact Us)
  - प्राइभेसी पोलिसी (Privacy Policy)
  - एप सेयर गर्नुहोस् (Share App)
- **Social Media**: Links to Facebook, YouTube, TikTok, Instagram
- **Branding**: Red/blue theme matching Arthakhabar logo

## API Integration

Uses [Arthakhabar API](https://arthakhabar.com/wp-content/themes/arthakhabar/api-documentation.html):

- `GET /ak_api/app/v1/posts` - Recent posts (first tab)
- `GET /ak_api/app/v1/categories` - All categories (tabs)
- `GET /ak_api/app/v1/get-category/{catid}/{numpost}` - Posts by category

## Setup

```bash
cd arthakhabar_app
flutter pub get
flutter run
```

## Configuration

### Social Media URLs

Update `lib/constants/app_constants.dart` with actual social media URLs:

```dart
static const String facebookUrl = 'https://www.facebook.com/arthakhabar';
static const String youtubeUrl = 'https://www.youtube.com/@arthakhabar';
static const String tiktokUrl = 'https://www.tiktok.com/@arthakhabar';
static const String instagramUrl = 'https://www.instagram.com/arthakhabar';
```

### App Icon

Replace `android/app/src/main/res/mipmap-*/ic_launcher.png` and iOS equivalents with the Arthakhabar app icon (`assets/images/app_icon.png`).

## Assets

- `assets/images/logo_main.png` - Main logo (splash, app bar, drawer)
- `assets/images/app_icon.png` - App icon (copy to platform folders)

## Build

```bash
# Android
flutter build apk

# iOS
flutter build ios
```

© 2026 Arthakhabar - Media Hundred Pvt. Ltd.
