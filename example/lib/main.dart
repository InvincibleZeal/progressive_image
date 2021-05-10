import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w700).fontFamily,
        brightness: Brightness.light,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 10,
          title: Text(
            'Progressive Image Examples',
            style: TextStyle(
              color: Color(0xFF0556F3),
              fontSize: 20.0,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: ProgressiveImageExample(),
      ),
    );
  }
}

class ProgressiveImageExample extends StatelessWidget {
  // Image Credit - https://unsplash.com/@tjholowaychuk
  Widget get example1 => ProgressiveImage(
        placeholder: AssetImage('assets/images/placeholder.jpg'),
        thumbnail: NetworkImage('https://i.imgur.com/eOQL4jg.jpg'), // 64x36
        image: NetworkImage('https://i.imgur.com/mDQ3Qbi.jpg'), // 3842x2160
        height: 250,
        width: 500,
        fit: BoxFit.cover,
      );

  // Image Credit - https://unsplash.com/@jonathangallegos
  Widget get example2 => ProgressiveImage.assetNetwork(
        placeholder: 'assets/images/placeholder.gif',
        thumbnail: 'https://i.imgur.com/7XL923M.jpg', // 64x43
        image: 'https://i.imgur.com/xVS07vQ.jpg', // 3240x2160
        height: 250,
        width: 500,
        fit: BoxFit.cover,
      );

  // Image Credit - https://unsplash.com/@little_klein
  Widget get example3 => ProgressiveImage.memoryNetwork(
        placeholder: kTransparentImage,
        thumbnail: 'https://i.imgur.com/zzlvBm5.jpg', // 64x43
        image: 'https://i.imgur.com/7LxOVQf.jpg', // 3240x2160
        height: 250,
        width: 500,
      );

  // Image Credit - https://unsplash.com/@marcelalaskoski
  Widget get example4 => ProgressiveImage.custom(
        placeholderBuilder: (BuildContext context) => _customWidget,
        thumbnail: NetworkImage('https://i.imgur.com/4WRfwXm.jpg'), // 64x43
        image: NetworkImage('https://i.imgur.com/0NnZINx.jpg'), // 3240x2160
        height: 250,
        width: 500,
        fit: BoxFit.cover,
      );

  Widget _text(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF0556F3),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.only(bottom: 20),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget get _customWidget => Container(
        width: 500,
        height: 250,
        color: Color(0xFF6501E5),
        child: Center(
          child: Text(
            "Custom Placeholder",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      );

  Widget _extra(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.only(bottom: 20),
      height: 50,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
      children: <Widget>[
        example1,
        _text('Example 1  -  with Placeholder Image'),
        example2,
        _text('Example 2  -  with Placeholder GIF'),
        example3,
        _text('Example 3  -  with kTransparentImage'),
        example4,
        _text('Example 4  -  with Placeholder Widget'),
        _extra('Some other content'),
        _extra('Some other content'),
      ],
    );
  }
}
