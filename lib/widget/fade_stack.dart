import 'package:flutter/material.dart';
import 'package:instagrams/screens/profile_screen.dart';
import 'package:instagrams/widget/sign_in_form.dart';
import 'package:instagrams/widget/sign_up_form.dart';

class FadeStack extends StatefulWidget {
  final int selectedForm;
  const FadeStack({Key? key, required this.selectedForm}) : super(key: key);

  @override
  _FadeStackState createState() => _FadeStackState();
}

class _FadeStackState extends State<FadeStack> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(vsync: this, duration: duration);
    _animationController.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FadeStack oldWidget) {
    // TODO: implement didUpdateWidget
    if(widget.selectedForm != oldWidget.selectedForm){
      _animationController.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: IndexedStack(
        index: widget.selectedForm,
        children: [
          SignUpForm(), SignInForm()
        ],
      ),
    );
  }
}
