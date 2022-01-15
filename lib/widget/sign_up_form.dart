import 'package:flutter/material.dart';
import 'package:instagrams/constants/common_size.dart';
import 'package:instagrams/home_page.dart';
import 'package:instagrams/widget/or_divider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // 상태를 저장할 키
  GlobalKey<FormState> _formKey = GlobalKey();
  // 입력 컨트롤러
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _cpwController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _pwController.dispose();
    _cpwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 키보드에 따른 화면반응 켜기
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(common_gap),
        child: Form(
          key: _formKey,
          child: ListView(        // 스크롤이 가능한 ListView
            children: [
              SizedBox(height: common_l_gap,),        // 빈공간 공간확보
              Image.asset('assets/images/insta_text_logo.png'),       // 이미지 넣기
              TextFormField(          // 입력창
                controller: _emailController,
                cursorColor: Colors.black54,
                decoration: _textInputDecoration('Email'),
                validator: (text){          // 텍스트값 추출
                  if(text != null && text.isNotEmpty && text.contains("@")){
                    return null;          // 그냥 통과
                  }else{
                    return '정확한 이메일 주소를 입력해주세요!';
                  }
                },
              ),
              SizedBox(height: common_xs_gap),
              TextFormField(
                controller: _pwController,
                cursorColor: Colors.black54,
                obscureText: true,            // 입력값 안보이게
                decoration: _textInputDecoration('Password'),
                validator: (text){          // 텍스트값 추출
                  if(text != null && text.isNotEmpty && text.length >= 4){
                    return null;          // 그냥 통과
                  }else{
                    return '4자리 이상의 비밀번호를 입력해주세요';
                  }
                },
              ),
              SizedBox(height: common_xs_gap),
              TextFormField(
                controller: _cpwController,
                cursorColor: Colors.black54,
                obscureText: true,
                decoration: _textInputDecoration('Comfirm Password'),
                validator: (text){          // 텍스트값 추출
                  if(text != null && text.isNotEmpty && _pwController.text == text){
                    return null;          // 그냥 통과
                  }else{
                    return '비밀번호 확인이 비밀번호와 일치하지 않습니다';
                  }
                },
              ),
              SizedBox(height: common_s_gap,),
              _loginBtn(context),
              SizedBox(height: common_s_gap,),
              OrDivider(),
              FlatButton.icon(
                onPressed: (){},
                icon: ImageIcon(AssetImage('assets/images/facebook.png')),
                textColor: Colors.blue,         // 배경말고 내용만 색깔주기
                label: Text('Login with Facebook')
              ),
            ],
          ),
        ),
      ),
    );
  }

  FlatButton _loginBtn(BuildContext context) {
    return FlatButton(
      onPressed: (){
        if(_formKey.currentState!.validate()){
          print('validate 모두 성공');
          // push : 기존화면을 유지한채 새화면 출력
          // pushReplacement : 기존화면을 없애고 새화면 출력
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
        }
      },
      color: Colors.blue,
      child: Text(
        'Join',
        style: TextStyle(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6)
      ),
    );
  }

  InputDecoration _textInputDecoration(String hint) {
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
