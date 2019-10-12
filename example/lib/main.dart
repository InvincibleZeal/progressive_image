import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:transparent_image/transparent_image.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text('Progressive Image Examples')),
        body: ProgressiveImageExample(),
      ),
    );
  }
}

class ProgressiveImageExample extends StatelessWidget {
  // Image Credit - https://unsplash.com/@tjholowaychuk
  Widget example1 = ProgressiveImage(
    placeholder: AssetImage('assets/images/placeholder.jpg'),
    thumbnail: NetworkImage('https://i.imgur.com/eOQL4jg.jpg'), // 64x36
    image: NetworkImage('https://i.imgur.com/mDQ3Qbi.jpg'), // 3842x2160
    height: 300,
    width: 500,
    fit: BoxFit.cover,
  );

  // Image Credit - https://unsplash.com/@jonathangallegos
  Widget example2 = ProgressiveImage.assetNetwork(
    placeholder: 'assets/images/placeholder.gif',
    thumbnail: 'https://i.imgur.com/7XL923M.jpg', // 64x43
    image: 'https://i.imgur.com/xVS07vQ.jpg', // 3240x2160
    height: 250,
    width: 500,
    fit: BoxFit.cover,
  );

  // Image Credit - https://unsplash.com/@leonel806
  Widget example3 = ProgressiveImage.memoryNetwork(
    placeholder: kTransparentImage,
    thumbnail: 'https://i.imgur.com/vz6P3pD.jpg', // 64x43
    image: 'https://i.imgur.com/GL54OhH.jpg', // 3240x2160
    height: 250,
    width: 500,
  );

  Widget _text(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            // _text('Example 1'),
            // example1,
            // _text('Example 2'),
            // example2,
            _text('Example 3'),
            example3,
            _text('End'),
          ],
        ),
      ),
    );
  }
}
