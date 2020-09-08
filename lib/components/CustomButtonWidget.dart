import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget(
      {Key key, @required this.onPressHandler, @required this.title})
      : super(key: key);
  final Function onPressHandler;
  final String title;
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
        quarterTurns: 3,
        child: RawMaterialButton(
          onPressed: onPressHandler,
          splashColor: Colors.orange,
          fillColor: Colors.deepOrange,
          shape: StadiumBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                RotatedBox(
                  quarterTurns: 3,
                  child: const Icon(
                    Icons.explore,
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(title, style: GoogleFonts.pacifico(fontSize: 24)),
              ],
            ),
          ),
        ));
  }
}
