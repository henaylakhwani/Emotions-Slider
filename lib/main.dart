import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      home: EmotionsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EmotionsPage extends StatefulWidget {
  @override
  _EmotionsPageState createState() => _EmotionsPageState();
}

class _EmotionsPageState extends State<EmotionsPage> {
  String feel = "0";
  double _value = 0.0;
  double lastSection = 0.0;
  String feedbackText = "Very Poor";
  bool _forward = true;
  Color bgclr = Color(0xffFFA8A8);
  final List<Color> _colors = [
    Color(0xffFEBDBD),
    Color(0xffFEBDEB),
    Color(0xffFFEDBE),
    Color(0xffBEFCE6),
  ];
  final List<String> _feedbackTexts = [
    "Very Poor",
    "Poor",
    "Average",
    "Excellent",
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AnimatedContainer(
          duration: Duration(milliseconds: 800),
          color: bgclr,
          child: Stack(
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.only(left: 12, top: 12),
              //   child: IconButton(
              //     onPressed: () {},
              //     icon: Icon(
              //       Icons.close_rounded,
              //       color: Color(0xff050300),
              //     ),
              //     iconSize: 34,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Center(
                  child: FlareActor(
                    'assets/flares/EmotionSlider_1.flr',
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    animation: feel,
                  ),
                ),
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 70,
                  ),
                  Text(
                    "How was your\nexperience?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 32,
                      color: Color(0xff050300),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeIn,
                      child: Text(
                        feedbackText,
                        style: GoogleFonts.openSans(
                          fontSize: 22,
                          color: Color(0xff050300),
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        key: ValueKey(feedbackText),
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 35,
                      left: 12,
                      right: 20,
                    ),
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 3,
                        valueIndicatorColor: Color(
                            0xff050300), // This is what you are asking for
                        overlayColor:
                            Color(0x29EB1555), // Custom Thumb overlay Color
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 10.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 20.0),
                      ),
                      child: Slider(
                        value: _value,
                        min: 0.0,
                        max: 99.0,
                        divisions: 100,
                        activeColor: Color(0xff050300),
                        inactiveColor: Color(0xff050300),
                        label: (_value.round() ~/ 10 + 1).toString(),
                        onChanged: (val) {
                          setState(() {
                            int temp = (val.toInt() ~/ 25);
                            _value = val;
                            bgclr = _colors[temp];
                            feedbackText = _feedbackTexts[temp];
                            _forward = (val > lastSection);
                            feel =
                                "${_forward ? temp * 25 : (temp + 1) * 25}${_forward ? '+' : '-'}";
                            lastSection = _forward ? val - 0.1 : val + 0.1;
                          });
                        },
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.add_comment_rounded,
                              size: MediaQuery.of(context).size.height * 0.024),
                        ),
                        TextSpan(
                          text: " Add Comment",
                          style: GoogleFonts.openSans(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.021,
                            color: Color(0xff050300),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      child: Text(
                        "Done",
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                      ),
                      width: 300,
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xff050300)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
