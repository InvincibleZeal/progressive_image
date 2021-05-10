# [v2.0.0](https://pub.dev/packages/progressive_image/versions/2.0.0)

**Flutter 2.0 support:**

- Migrated the package to support flutter's null-safety. Thanks to [Aaqib Ismail](https://github.com/aaqibism)
- Added ProgressiveImage.custom() constructor to add custom widgets instead of placeholder images. Thanks to [Gioele Pannetto](https://github.com/GioPan04)

# [v1.0.1](https://pub.dev/packages/progressive_image/versions/1.0.1)

**Merged Pull Requests:**

- Block updates to state after disposal [\#1](https://github.com/InvincibleZeal/progressive_image/pull/1) ([jackdreilly](https://github.com/jackdreilly))

# [v1.0.0](https://pub.dev/packages/progressive_image/versions/1.0.0)

- Created flutter widget which progressively loads larger images using Low Quality Image Placeholders.
- Displays Placeholder and Thumbnail image until the Original image loads.
- Smooth Fade-in animations for preventing immediate image popups on load.
- Blur effect for low resolution thumbnails to prevent the pixelated view.
- Effectively resolves Thumbnail images before the Original image starts to fetch for quick first impression.
