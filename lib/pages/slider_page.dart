import 'package:compare_image_slider/content/comapre_image_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: SizedBox(
          height: 500,
          child: CompareImageSlider(
            beforeImage: AssetImage('assets/images/image1.png'),
            afterImage: AssetImage('assets/images/image2.png'),
            initialPosition: 0.5, // Start in the middle
            sliderColor: Colors.blue,
            sliderThickness: 2.0,
          ),
        ),
      ),
    );
  }
}