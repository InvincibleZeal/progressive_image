library progressive_image;

import 'dart:async';
import 'dart:core';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progressive_image/src/progress.dart';

/// A image that gracefully fades from a blurred [thumbnail] to the target [image].
/// [placeholder] is displayed initially until the [thumbnail] loads.
///
/// Sequence of occurrence: [placeholder] > [thumbnail] > [image]
///
/// Use this class to display long-loading images, such as a [NetworkImage],
/// so that a relatively smaller sized [thumbnail] appears on screen as a blurred
/// version of the target [image] which is relatively larger in size.
///
/// It forces the [thumbnail] to be resolved completely before even the target
/// [image] starts to be fetched for better use experience.
///
/// Prefer a [placeholder] that's already cached so that it is displayed immediately.
/// This prevents it from popping onto the screen.
///
/// [thumbnail] {https://en.wikipedia.org/wiki/Thumbnail} can be an extremely
/// smaller version of the target [image] which loads faster and helps in a
/// better first UI impression.
///
/// The [width] and [height] properties are required for enlarging the thumbnail
/// to a specified width and height
///
/// The [fadeDuration] property controls the fading duration of the [placeholder],
/// [thumbnail] and target [image]
///
/// The [blur] property controls the intensity of the blur applied to the
/// [thumbnail] image.
///
/// ```dart
/// ProgressiveImage(
///   placeholder: AssetImage('assets/example.jpg'),
///   thumbnail: NetworkImage('https://backend.example.com/thumbnail.png'),
///   image: NetworkImage('https://backend.example.com/image.png'),
///   height: 300,
///   width: 500,
/// );
/// ```
class ProgressiveImage extends StatefulWidget {
  /// Creates a widget that gracefully fades from a blurred `thumbnail` to the target `image`.
  /// `placeholder` is displayed initially until the `thumbnail` loads.
  ///
  /// Sequence of occurrence: `placeholder` > `thumbnail` > `image`
  ///
  /// The [placeholder], [thumbnail], [image], [width], [height], [fit], [fadeDuration],
  /// [alignment], [repeat], and [matchTextDirection] arguments must not be null.
  ///
  /// If [excludeFromSemantics] is true, then [imageSemanticLabel] will be ignored.
  ///
  /// ```dart
  /// ProgressiveImage(
  ///   placeholder: AssetImage('assets/example.jpg'),
  ///   thumbnail: NetworkImage('https://backend.example.com/thumbnail.png'),
  ///   image: NetworkImage('https://backend.example.com/image.png'),
  ///   height: 300,
  ///   width: 500,
  /// );
  /// ```
  ProgressiveImage({
    Key key,
    @required this.placeholder,
    @required this.thumbnail,
    @required this.image,
    @required this.width,
    @required this.height,
    this.fit = BoxFit.fill,
    this.blur = 20,
    this.fadeDuration = const Duration(milliseconds: 500),
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.excludeFromSemantics = false,
    this.imageSemanticLabel,
  })  : assert(placeholder != null),
        assert(thumbnail != null),
        assert(image != null),
        assert(width != null),
        assert(height != null),
        assert(fadeDuration != null),
        assert(alignment != null),
        assert(repeat != null),
        assert(matchTextDirection != null),
        super(key: key);

  /// Creates a widget that uses a placeholder image stored in memory while
  /// loading the `thumbnail` and target `image` from the network.
  ///
  /// Sequence of occurrence: `placeholder` > `thumbnail` > `image`
  ///
  /// The `placeholder` argument contains the bytes of the in-memory image.
  ///
  /// The `thumbnail` argument is the URL of the thumbnail image.
  ///
  /// The `image` argument is the URL of the final image.
  ///
  /// The `placeholderScale`, `thumbnailScale` and `imageScale` arguments are
  /// passed to their respective [ImageProvider]s (see also [ImageInfo.scale]).
  ///
  ///
  /// The [placeholder], [thumbnail], [image], [placeholderScale], [thumbnailScale],
  /// [imageScale], [width], [height], [fit], [fadeDuration], [alignment], [repeat],
  /// and [matchTextDirection] arguments must not be null.
  ///
  /// ```dart
  /// ProgressiveImage.memoryNetwork(
  ///   // see transparent_image package for kTransparentImage usage
  ///   placeholder: kTransparentImage,
  ///   thumbnail: 'https://backend.example.com/thumbnail.png',
  ///   image: 'https://backend.example.com/image.png',
  ///   height: 300,
  ///   width: 500,
  /// );
  ///
  /// ```
  ///
  /// See also:
  ///
  ///  * [Image.memory], which has more details about loading images from
  ///    memory.
  ///  * [Image.network], which has more details about loading images from
  ///    the network.
  ProgressiveImage.memoryNetwork({
    Key key,
    @required Uint8List placeholder,
    @required String thumbnail,
    @required String image,
    @required this.width,
    @required this.height,
    double placeholderScale = 1.0,
    double thumbnailScale = 1.0,
    double imageScale = 1.0,
    this.fit = BoxFit.fill,
    this.blur = 20,
    this.fadeDuration = const Duration(milliseconds: 500),
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.excludeFromSemantics = false,
    this.imageSemanticLabel,
  })  : assert(placeholder != null),
        assert(thumbnail != null),
        assert(image != null),
        assert(height != null),
        assert(width != null),
        placeholder = MemoryImage(placeholder, scale: placeholderScale),
        thumbnail = NetworkImage(thumbnail, scale: thumbnailScale),
        image = NetworkImage(image, scale: imageScale),
        super(key: key);

  /// Creates a widget that uses a placeholder image stored in an asset bundle while
  /// loading the `thumbnail` and target `image` from the network.
  ///
  /// Sequence of occurrence: `placeholder` > `thumbnail` > `image`
  ///
  /// The `placeholder` argument is the key of the image in the asset bundle.
  ///
  /// The `thumbnail` argument is the URL of the thumbnail image.
  ///
  /// The `image` argument is the URL of the final image.
  ///
  /// The `placeholderScale`, `thumbnailScale` and `imageScale` arguments are
  /// passed to their respective [ImageProvider]s (see also [ImageInfo.scale]).
  ///
  /// The [placeholder], [thumbnail], [image], [thumbnailScale], [imageScale],
  /// [width], [height], [fit], [fadeDuration], [alignment], [repeat] and
  /// [matchTextDirection] arguments must not be null.
  ///
  /// ```dart
  /// ProgressiveImage.assetNetwork(
  ///   placeholder: 'assets/example.png',
  ///   thumbnail: 'https://backend.example.com/thumbnail.png',
  ///   image: 'https://backend.example.com/image.png',
  ///   height: 300,
  ///   width: 500,
  /// );
  ///```
  ///
  /// See also:
  ///
  ///  * [Image.memory], which has more details about loading images from
  ///    memory.
  ///  * [Image.network], which has more details about loading images from
  ///    the network.
  ProgressiveImage.assetNetwork({
    Key key,
    @required String placeholder,
    @required String thumbnail,
    @required String image,
    @required this.width,
    @required this.height,
    AssetBundle bundle,
    double placeholderScale,
    double thumbnailScale = 1.0,
    double imageScale = 1.0,
    this.fit = BoxFit.fill,
    this.blur = 20,
    this.fadeDuration = const Duration(milliseconds: 500),
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.excludeFromSemantics = false,
    this.imageSemanticLabel,
  })  : assert(placeholder != null),
        assert(thumbnail != null),
        assert(image != null),
        assert(height != null),
        assert(width != null),
        placeholder = placeholderScale != null
            ? ExactAssetImage(placeholder,
                bundle: bundle, scale: placeholderScale)
            : AssetImage(placeholder, bundle: bundle),
        thumbnail = NetworkImage(thumbnail),
        image = NetworkImage(image),
        super(key: key);

  /// Image displayed initially while the `thumbnail` is loading.
  final ImageProvider placeholder;

  /// The blurred thumbnail that is displayed while the target `image` is loading.
  final ImageProvider thumbnail;

  /// The target image that
  final ImageProvider image;

  /// The `placeholder`, `thumbnail` and target `image` will acquire this width
  /// based on the `fit` property.
  final double width;

  /// The `placeholder`, `thumbnail` and target `image` will acquire this height
  /// based on the `fit` property.
  final double height;

  /// How to inscribe the image into the space allocated during layout.
  ///
  /// The default is [BoxFit.fill]
  final BoxFit fit;

  /// The intensity of the blur applied on the `thumbnail`.
  ///
  /// The Default is `20.0`,
  /// use `0` for no blur effect.
  final double blur;

  /// The duration of the fade animation for the `placeholder`, `thumbnail`
  ///  and target `image`.
  final Duration fadeDuration;

  /// How to align the image within its bounds.
  ///
  /// The alignment aligns the given position in the image to the given position
  /// in the layout bounds. For example, an [Alignment] alignment of (-1.0,
  /// -1.0) aligns the image to the top-left corner of its layout bounds, while an
  /// [Alignment] alignment of (1.0, 1.0) aligns the bottom right of the
  /// image with the bottom right corner of its layout bounds. Similarly, an
  /// alignment of (0.0, 1.0) aligns the bottom middle of the image with the
  /// middle of the bottom edge of its layout bounds.
  ///
  /// If the [alignment] is [TextDirection]-dependent (i.e. if it is a
  /// [AlignmentDirectional]), then an ambient [Directionality] widget
  /// must be in scope.
  ///
  /// Defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry alignment;

  /// How to paint any portions of the layout bounds not covered by the image.
  final ImageRepeat repeat;

  /// Whether to paint the image in the direction of the [TextDirection].
  ///
  /// If this is true, then in [TextDirection.ltr] contexts, the image will be
  /// drawn with its origin in the top left (the "normal" painting direction for
  /// images); and in [TextDirection.rtl] contexts, the image will be drawn with
  /// a scaling factor of -1 in the horizontal direction so that the origin is
  /// in the top right.
  ///
  /// This is occasionally used with images in right-to-left environments, for
  /// images that were designed for left-to-right locales. Be careful, when
  /// using this, to not flip images with integral shadows, text, or other
  /// effects that will look incorrect when flipped.
  ///
  /// If this is true, there must be an ambient [Directionality] widget in
  /// scope.
  final bool matchTextDirection;

  /// Whether to exclude this image from semantics.
  ///
  /// This is useful for images which do not contribute meaningful information
  /// to an application.
  final bool excludeFromSemantics;

  /// A semantic description of the image.
  ///
  /// Used to provide a description of the `image` to TalkBack on Android, and
  /// VoiceOver on iOS.
  ///
  /// This description will be used both while the `placeholder` is shown and
  /// once the image has loaded.
  final String imageSemanticLabel;
  @override
  _ProgressiveImageState createState() => _ProgressiveImageState();
}

class _ProgressiveImageState extends State<ProgressiveImage> {
  /// Progress status to show the progress and important events.
  ///
  /// See [Progress] for a complete list of enum values describing the events in [ProgressiveImage]
  Progress _status = Progress.Loading;

  /// Whether the [placeholder] is displayed intact when the [thumbnail] is fading in.
  bool _placeholderDelay = true;

  /// Whether the [thumbnail] is displayed intact when the target [image] is fading in.
  bool _thumbnailDelay = true;

  void _updateProgress(Progress progress) {
    setState(() {
      _status = progress;
    });
  }

  @override
  void initState() {
    super.initState();

    ImageStreamListener _targetListener =
        ImageStreamListener((ImageInfo info, bool _) {
      Timer(widget.fadeDuration, () {
        setState(() {
          _thumbnailDelay = false;
        });
      });
      _updateProgress(Progress.TargetLoaded);
    });

    ImageStreamListener _thumbnailListener =
        ImageStreamListener((ImageInfo info, bool _) {
      Timer(widget.fadeDuration, () {
        setState(() {
          _placeholderDelay = false;
        });
      });

      // Start fetching the target image only after the thumbnail is resolved
      if (_status != Progress.TargetLoaded) {
        _updateProgress(Progress.ThumbnailLoaded);
        widget.image.resolve(ImageConfiguration()).addListener(_targetListener);
      }
    });

    widget.thumbnail
        .resolve(ImageConfiguration())
        .addListener(_thumbnailListener);
  }

  Image _image(
      {@required ImageProvider image, ImageFrameBuilder frameBuilder}) {
    assert(image != null);
    return Image(
      image: image,
      frameBuilder: frameBuilder,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      repeat: widget.repeat,
      alignment: widget.alignment,
      matchTextDirection: widget.matchTextDirection,
      gaplessPlayback: true,
      excludeFromSemantics: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget result = Stack(
      fit: StackFit.loose,
      alignment: AlignmentDirectional.center,
      textDirection: TextDirection.ltr,
      children: <Widget>[
        AnimatedOpacity(
            duration: widget.fadeDuration,
            // Fade out placeholder only after the thumbnail fades in completely
            opacity: _status == Progress.Loading ||
                    (_status == Progress.ThumbnailLoaded && _placeholderDelay)
                ? 1.0
                : 0.0,
            child: _image(image: widget.placeholder)),
        AnimatedOpacity(
          // Fade out thumbnail only after the target image fades in completely
          opacity: _status == Progress.ThumbnailLoaded ||
                  (_status == Progress.TargetLoaded && _thumbnailDelay)
              ? 1.0
              : 0.0,
          duration: widget.fadeDuration,
          child: _image(image: widget.thumbnail),
        ),
        Opacity(
          // Fade out blur effect only after the target image fades in completely
          opacity: _status == Progress.ThumbnailLoaded ||
                  (_status == Progress.TargetLoaded && _thumbnailDelay)
              ? 1.0
              : 0.0,
          child: ClipRect(
            child: BackdropFilter(
              filter:
                  ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
              child: Container(
                // height: apparentHeight(),
                // width: apparentWidth(),
                child: Opacity(
                  opacity: 0.0,
                  child: _image(image: widget.thumbnail),
                ),
                color: Colors.black.withOpacity(0),
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: _status == Progress.TargetLoaded ? 1.0 : 0.0,
          duration: widget.fadeDuration,
          child: _status == Progress.Loading
              ? SizedBox(height: 0, width: 0)
              : _image(image: widget.image),
        )
      ],
    );

    if (!widget.excludeFromSemantics) {
      result = Semantics(
        container: widget.imageSemanticLabel != null,
        image: true,
        label: widget.imageSemanticLabel ?? '',
        child: result,
      );
    }

    return result;
  }
}

/// [ProgressiveImage] uses this enum to describes the different events
/// that occurs during the progressive loading of the target [image].
