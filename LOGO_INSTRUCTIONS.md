# KT Radio Logo Integration

## How to Add Your PNG Logo

1. **Place your logo file** in the `assets/images/` directory
2. **Name it exactly**: `kt_logo.png`
3. **Recommended size**: 512x512 pixels (or any square aspect ratio)
4. **Format**: PNG with transparent background (preferred)

## File Structure
```
assets/
└── images/
    └── kt_logo.png  ← Your logo file goes here
```

## What's Already Done
- ✅ Assets directory created
- ✅ pubspec.yaml updated to include assets
- ✅ Code updated to use PNG logo in:
  - Home screen header
  - Login screen main logo
  - Registration screen header
- ✅ Fallback to text/icon if logo not found

## After Adding Your Logo
1. Run `flutter pub get` to update dependencies
2. Run `flutter run` to test the app
3. The logo will appear in all the main screens

## Logo Specifications
- **Format**: PNG
- **Background**: Transparent (recommended)
- **Aspect Ratio**: Square (1:1)
- **Size**: 512x512px or higher
- **File Name**: Must be exactly `kt_logo.png`

The app will automatically use your logo and fall back to text/icon if the file is not found.
