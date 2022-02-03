import 'package:flutter/material.dart';
import 'package:instagrams/constants/common_size.dart';
import 'package:instagrams/home_page.dart';
import 'package:instagrams/models/firebase_auth_state.dart';
import 'package:instagrams/widget/or_divider.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  // 상태 저장 키
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,           // 키보드가 밀기 허용
      body: Padding(
        padding: const EdgeInsets.all(common_gap),
        child: Form(
          key: _formKey,
          child: ListView(            // 스크롤되는 컬럼
            children: [
              SizedBox(height: common_l_gap),
              Image.asset('assets/images/insta_text_logo.png'),
              TextFormField(
                controller: _emailController,
                cursorColor: Colors.black54,
                decoration: _textInputDecoration('Email'),
                validator: (text){
                  if(text != null && text.isNotEmpty && text.contains("@")){
                    return null;
                  }else{
                    return "정확한 이메일 주소를 입력해주세요";
                  }
                },
              ),
              SizedBox(height: common_xs_gap,),
              TextFormField(
                controller: _pwController,
                cursorColor: Colors.black54,
                obscureText: true,          // 입력값 암호화
                decoration: _textInputDecoration('Password'),
                validator: (text){
                  if(text != null && text.isNotEmpty && text.length >= 4){
                    return null;
                  }else{
                    return "4자리 이상의 비밀번호를 입력해주세요";
                  }
                },
              ),
              //SizedBox(height: common_xs_gap,),
              TextButton(
                onPressed: (){},
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgotten Password?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              //SizedBox(height: common_xs_gap),
              _loginBtn(context),
              SizedBox(height: common_s_gap,),
              OrDivider(),
              // 페이스북 로그인
              FlatButton.icon(
                onPressed: (){
                  Provider.of(context, listen: false).changeFirebaseAuthStatus(FirebaseAuthStatus.signin);
                },
                icon: ImageIcon(AssetImage('assets/images/facebook.png')),
                textColor: Colors.blue,             // 배경을 제외하고 내용만 색깔주기
                label: Text('Login with Facebook'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FlatButton _loginBtn(BuildContext context){
    return FlatButton(
      onPressed: (){
        if(_formKey.currentState!.validate()){
          print('입력값 모두 성공');
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
        }
      },
      color: Colors.blue,
      child: Text(
        'Log in',
        style: TextStyle(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6)
      ),
    );
  }

  InputDecoration _textInputDecoration(String hint){
    return InputDecoration(
      hintText: hint,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(common_s_gap),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black87),
        borderRadius: BorderRadius.circular(common_s_gap),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(common_s_gap),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(common_s_gap),
      ),
      filled: true,
      fillColor: Colors.grey[160],
    );
  }
}
