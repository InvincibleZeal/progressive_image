# Progressive Image

A flutter widget which progressively loads larger images using Low Quality Image Placeholders.

<img src="https://i.imgur.com/gJUtww7.gif" height="400" style="border-radius: 10px;">
<img src="https://i.imgur.com/Ei4ENjT.gif" height="400" style="border-radius: 10px;">
<img src="https://i.imgur.com/BpgeKfv.gif" height="400" style="border-radius: 10px;">

## Features

* Displays Placeholder and Thumbnail image until the Original image loads.
* Smooth Fade-in animations for preventing immediate image popups on load.
* Blur effect for low resolution thumbnails to prevent the pixelated view.
* Effectively resolves Thumbnail images before the Original image starts to fetch for quick first impression.

## Installing

Following steps will help you add this library as a dependency in your flutter project.

* In the `pubspec.yaml` file in the root of your project

```yaml
dependencies:
    progressive_image: ^1.0.0 
```

* Getting the package via package manager
```bash
$ flutter packages get
```

* Import the package:

```dart
import 'package:progressive_image/progressive_image.dart';
```

## Usage

For a more detailed look at how to use this library, there is a sweet project in the `example` directory and various examples can be found [here](/example/README.md)

A simple example usage of the `ProgressiveImage` widget is shown below:

```dart
import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Progressive Image Example')),
        body: ProgressiveImageExample(),
      ),
    );
  }
}

class ProgressiveImageExample extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Container(
            child: ProgressiveImage(
                placeholder: AssetImage('assets/placeholder.jpg'),
                // size: 1.87KB 
                thumbnail: NetworkImage('https://i.imgur.com/7XL923M.jpg'), 
                // size: 1.29MB 
                image: NetworkImage('https://i.imgur.com/xVS07vQ.jpg'),     
                height: 300,
                width: 500,
            ),
        );
    }
}

```