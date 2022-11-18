import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider(
      {Key? key,
      required this.value,
      required this.callback,
      required this.text})
      : super(key: key);
  final double value;
  final void Function(double) callback;
  final String text;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double value;
  LinearGradient gradient = const LinearGradient(colors: <Color>[
    Color(0xFFD2876F),
    Color(0xFF523072),
  ]);

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.text,
          style: GoogleFonts.poppins(
              fontSize: 15, color: const Color(0xFFD3896F), letterSpacing: 1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '0',
              style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.7),
                  letterSpacing: 1),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 270,
              height: 40,
              decoration: BoxDecoration(
                  color: const Color(0xFF2E2340),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10)),
              child: SliderTheme(
                data: SliderThemeData(
                  overlayColor: const Color(0xFF7390D6).withOpacity(0.7),
                  thumbColor: Colors.black,
                  inactiveTrackColor: Colors.white,
                  trackShape: GradientRectSliderTrackShape(
                    gradient: gradient,
                  ),
                ),
                child: Slider(
                    inactiveColor: Colors.grey,
                    min: 0.0,
                    max: 10.0,
                    value: value,
                    onChanged: (d) {
                      value = d;
                      widget.callback(d);
                      setState(() {});
                    }),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '10',
              style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.7),
                  letterSpacing: 1),
            ),
          ],
        ),
      ],
    );
  }
}

class GradientRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  const GradientRectSliderTrackShape({
    this.gradient = const LinearGradient(
      colors: [
        Colors.red,
        Colors.yellow,
      ],
    ),
  });

  final LinearGradient gradient;

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    assert(sliderTheme.trackHeight != null && sliderTheme.trackHeight! > 0);

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final activeGradientRect = Rect.fromLTRB(
      trackRect.left,
      (textDirection == TextDirection.ltr)
          ? trackRect.top - (additionalActiveTrackHeight / 2)
          : trackRect.top,
      thumbCenter.dx,
      (textDirection == TextDirection.ltr)
          ? trackRect.bottom + (additionalActiveTrackHeight / 2)
          : trackRect.bottom,
    );

    // Assign the track segment paints, which are leading: active and
    // trailing: inactive.
    // final ColorTween activeTrackColorTween = ColorTween(
    //     begin: sliderTheme.disabledActiveTrackColor,
    //     end: sliderTheme.activeTrackColor);

    final Paint activePaint = Paint()
      ..shader = gradient.createShader(activeGradientRect);

    final Paint inactivePaint = Paint();

    final Paint leftTrackPaint;
    final Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    final Radius trackRadius = Radius.circular(trackRect.height / 2);
    final Radius activeTrackRadius = Radius.circular(trackRect.height / 2 + 1);

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        (textDirection == TextDirection.ltr)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        thumbCenter.dx,
        (textDirection == TextDirection.ltr)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        bottomLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
      ),
      leftTrackPaint,
    );
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        (textDirection == TextDirection.rtl)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        trackRect.right,
        (textDirection == TextDirection.rtl)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
        bottomRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
      ),
      rightTrackPaint,
    );
  }
}
