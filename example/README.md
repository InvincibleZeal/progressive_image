# Progressive Image Demo

## Examples

### `ProgressiveImage` constructor

This requires `ImageProvider` as an argument for each of the `placeholder`, `thumbnail` and `image` parameters.

**\*Note -** `image` will start to load only after the `thumbnail` is resolved completely.\*

```dart
Widget example1 = ProgressiveImage(
    placeholder: AssetImage('assets/images/placeholder.jpg'),   // required
    thumbnail: NetworkImage('https://i.imgur.com/eOQL4jg.jpg'), // required
    image: NetworkImage('https://i.imgur.com/mDQ3Qbi.jpg'),     // required
    height: 300,                                                // required
    width: 500,                                                 // required
    fit: BoxFit.cover,                                          // default BoxFit.fill
);
```

### `ProgressiveImage.assetNetwork` constructor

Creates a widget that uses a `placeholder` image stored in an asset bundle while loading the `thumbnail` and target `image` from the network.

```dart
Widget example2 = ProgressiveImage.assetNetwork(
    placeholder: 'assets/images/placeholder.gif', // gifs can be used
    thumbnail: 'https://i.imgur.com/7XL923M.jpg',
    image: 'https://i.imgur.com/xVS07vQ.jpg',
    height: 250,
    width: 500,
    fit: BoxFit.cover,
);
```

### `ProgressiveImage.memoryNetwork` constructor

Creates a widget that uses a `placeholder` image stored in memory while loading the `thumbnail` and target `image` from the network.

```dart
Widget example3 = ProgressiveImage.memoryNetwork(
    // see transparent_image package for kTransparentImage usage
    placeholder: kTransparentImage,
    thumbnail: 'https://i.imgur.com/vz6P3pD.jpg',
    image: 'https://i.imgur.com/GL54OhH.jpg',
    height: 250,
    width: 500,
);
```

### `ProgressiveImage.custom` constructor

Creates a widget that uses a `placeholder` image stored in memory while loading the `thumbnail` and target `image` from the network.

```dart
 Widget get example4 = ProgressiveImage.custom(
    placeholderBuilder: (context) {
        return Center(
            child: Container(
                width: 20,
                height: 20,
                color: Colors.red,
            ),
        );
    },
    thumbnail: NetworkImage(
        'https://unsplash.com/photos/g2-lALqauao/download?w=640'), // 640x479
    image: NetworkImage(
        'https://unsplash.com/photos/g2-lALqauao/download'), // 3057x1797
    height: 250,
    width: 500,
    fit: BoxFit.cover,
);
```
