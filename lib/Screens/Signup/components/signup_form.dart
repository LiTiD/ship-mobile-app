import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Signup/components/gender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  State<SignUpForm> createState(){
    return _SignUpForm();
  }

}

class DropdownItem extends StatefulWidget {
  const DropdownItem({Key? key, required this.callback}) : super(key: key);
  final Function callback;
  @override
  State<DropdownItem> createState() => _DropdownItemState();
}

class _DropdownItemState extends State<DropdownItem> {
  String selectedValue = "Male";
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedValue,
      style: TextStyle(color: Colors.deepOrange, fontSize: 15),
      onChanged: (String? value) {
        setState(() {
          selectedValue = value!;
          widget.callback(value!);
        });
      },
      items: dropdownItems,
    );
  }
}

class _SignUpForm extends State<SignUpForm> {

  String _username = "";
  String _password = "";
  String _email = "";
  String _displayname = "";
  //String _firstname = "";
  //String _lastname = "";
  String _gender = "";
  String _phone = "";
  String _image = "";
  String _address = "";
  final _usernameEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();
  final _emailEditingController = TextEditingController();
  final _displaynameEditingController = TextEditingController();
  //final _firstnameEditingController = TextEditingController();
  //final _lastnameEditingController = TextEditingController();
  final _genderEditingController = TextEditingController();
  final _phoneEditingController = TextEditingController();
  final _imageEditingController = TextEditingController();
  final _addressEditingController = TextEditingController();


  Future<String?> postHttp(
      String username, String pass,
      String email, String displayname,
      String phone, String image,
      String address, String gender) async {
    try {
      var response = await Dio().post(
          'https://convenient-way.azurewebsites.net/api/v1.0/shippers/register',
          data: {
            'userName' : username,
            'password' : pass,
            "email": email,
            "displayName": displayname,
            "phoneNumber": phone,
            "photoUrl": image,
            "address": address,
            "gender": gender,
          });
      return response.data['data']['success'];
    } catch (e) {
      print(e);
    }
  }

  void setGender(String value){
    _gender = value;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            'Đăng ký',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SizedBox(
            height: 50,
            child: TextFormField(
              controller: _usernameEditingController,
              onChanged: (text){
                this._username = text;
              },
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                labelText: "Tài khoản",
                prefixIcon: Icon(Icons.person),
              //  ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SizedBox(
            height: 50,
            child: TextFormField(
              controller: _passwordEditingController,
              onChanged: (text){
                this._password = text;
              },
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                labelText: "Mật khẩu",
                prefixIcon: Icon(Icons.person),
                //  ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SizedBox(
            height: 50,
            child: TextFormField(
              controller: _emailEditingController,
              onChanged: (text){
                this._email = text;
              },
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.person),
                //  ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SizedBox(
            height: 50,
            child: TextFormField(
              controller: _displaynameEditingController,
              onChanged: (text){
                this._displayname = text;
              },
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                labelText: "Tên hiển thị",
                prefixIcon: Icon(Icons.person),
                //  ),
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 5),
        //   child: SizedBox(
        //     height: 50,
        //     child: TextFormField(
        //       controller: _firstnameEditingController,
        //       onChanged: (text){
        //         this._firstname = text;
        //       },
        //       cursorColor: kPrimaryColor,
        //       decoration: InputDecoration(
        //         labelText: "Tên",
        //         prefixIcon: Icon(Icons.person),
        //         //  ),
        //       ),
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 5),
        //   child: SizedBox(
        //     height: 50,
        //     child: TextFormField(
        //       controller: _lastnameEditingController,
        //       onChanged: (text){
        //         this._lastname = text;
        //       },
        //       cursorColor: kPrimaryColor,
        //       decoration: InputDecoration(
        //         labelText: "Họ",
        //         prefixIcon: Icon(Icons.person),
        //         //  ),
        //       ),
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 5),
        //   child: SizedBox(
        //     height: 50,
        //     child: TextFormField(
        //       controller: _genderEditingController,
        //       onChanged: (text){
        //         this._gender = text;
        //       },
        //       cursorColor: kPrimaryColor,
        //       decoration: InputDecoration(
        //         labelText: "Giới tính",
        //         prefixIcon: Icon(Icons.person),
        //         //  ),
        //       ),
        //     ),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SizedBox(
            height: 50,
            child: TextFormField(
              controller: _phoneEditingController,
              onChanged: (text){
                this._phone = text;
              },
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                labelText: "Số điện thoại",
                prefixIcon: Icon(Icons.person),
                //  ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SizedBox(
            height: 50,
            child: TextFormField(
              controller: _imageEditingController,
              onChanged: (text){
                this._image = text;
              },
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                labelText: "Ảnh",
                prefixIcon: Icon(Icons.person),
                //  ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SizedBox(
            height: 50,
            child: TextFormField(
              controller: _addressEditingController,
              onChanged: (text){
                this._address = text;
              },
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                labelText: "Địa chỉ",
                prefixIcon: Icon(Icons.person),
                //  ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Giới tính',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: DropdownItem(callback: setGender,),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding / 2),
        ElevatedButton(
          onPressed: () async{
            print(_gender);
            if((await postHttp(
              _username,
              _password,
              _email,
              _displayname,
              _phone,
              _image,
              _address,
              _gender,
            )) == false) {
              Fluttertoast.showToast(
                  msg: "Đăng ký không thành công!\nVui lòng nhập đầu đủ thông tin!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            }
          },
          child: Text("Sign Up".toUpperCase()),
        ),
        const SizedBox(height: defaultPadding),
        // AlreadyHaveAnAccountCheck(
        //   login: false,
        //   press: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) {
        //           return LoginScreen();
        //         },
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }
}