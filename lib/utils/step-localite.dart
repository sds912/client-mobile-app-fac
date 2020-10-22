import 'package:flutter/widgets.dart';
import 'package:v1/utils/step/step.dart';

buildStepLocalite(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: size.height * .48,
    width: size.width * .8,
    child: Center(
      child: step(context),
    ),
  );
}
