import 'package:be_universe/src/widgets/premium/premium_controller.dart';
import 'package:flutter/material.dart';
import 'package:reusables/reusables.dart';

class PremiumWidget extends ControlledWidget<PremiumController> {
  PremiumWidget({Key? key})
      : super(key: key, controller: PremiumController.instance);

  @override
  State<PremiumWidget> createState() => _PremiumWidgetState();
}

class _PremiumWidgetState extends State<PremiumWidget>
    with ControlledStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
