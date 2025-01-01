import 'package:flutter/material.dart';

class CompareImageSlider extends StatefulWidget {
  final ImageProvider beforeImage;
  final ImageProvider afterImage;
  final double initialPosition; // Initial slider position (0.0 to 1.0)
  final Color sliderColor;
  final double sliderThickness;

  const CompareImageSlider({
    Key? key,
    required this.beforeImage,
    required this.afterImage,
    this.initialPosition = 0.5,
    this.sliderColor = Colors.white,
    this.sliderThickness = 2.0,
  }) : super(key: key);

  @override
  _CompareImageSliderState createState() => _CompareImageSliderState();
}

class _CompareImageSliderState extends State<CompareImageSlider> {
  late double _sliderPosition;

  @override
  void initState() {
    super.initState();
    _sliderPosition = widget.initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        return GestureDetector(
          onHorizontalDragUpdate: (details) {
            setState(() {
              // Update the slider position smoothly within bounds
              _sliderPosition = (_sliderPosition +
                  details.delta.dx / width)
                  .clamp(0.0, 1.0);
            });
          },
          child: Stack(
            children: [
              // Before Image
              Positioned.fill(
                child: Image(
                  image: widget.beforeImage,
                  fit: BoxFit.cover,
                ),
              ),

              // After Image with smooth clipping
              Positioned.fill(
                child: ClipRect(
                  clipper: _ImageClipper(_sliderPosition * width),
                  child: Image(
                    image: widget.afterImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Draggable Slider
              Positioned(
                left: (_sliderPosition * width) -
                    (widget.sliderThickness / 2),
                top: 0,
                bottom: 0,
                child: Container(
                  width: widget.sliderThickness,
                  color: widget.sliderColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ImageClipper extends CustomClipper<Rect> {
  final double clipX;

  _ImageClipper(this.clipX);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, clipX, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
