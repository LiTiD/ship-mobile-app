import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/home_screen.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';

class Dashboard extends StatefulWidget {
  const

  Dashboard( {
    Key ? key
  }):super(key:key);

  @override
  State<Dashboard> createState() =>

      _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  String _from = '';
  String _to = '';
  final _fromEditingController =

  TextEditingController();

  final _toEditingController =

  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('Chọn lộ trình'),
        backgroundColor: const Color(0x55fa5555),
      ),
      body:
      SingleChildScrollView(
        scrollDirection:Axis.horizontal,
        child:Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:15, right:15, top:20),
              child:
              Row(
                mainAxisAlignment:MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width:300,
                    height:60,
                    child:TextField(
                      controller:_fromEditingController,
                      onChanged:(context) {
                        this._from = context;
                      },
                      decoration:
                      InputDecoration(
                        labelText:'Điểm đi',
                        border:OutlineInputBorder(borderSide:BorderSide(width:1)),
                      ),
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(left:5),
                    child:
                    SizedBox(
                      width:60,
                      height:60,
                      child:Container(
                        color:Colors.black12,
                        child:IconButton(
                          onPressed:() {
                            Navigator.push(
                                context, MaterialPageRoute(builder:(context) {
                              return HomePage();
                            }));
                          },
                          icon:
                          Icon(Icons.my_location_sharp),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15, right:15, top:20),
              child:
              Row(
                mainAxisAlignment:MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width:300,
                    height:60,
                    child:TextField(
                      controller:_toEditingController,
                      onChanged:(context) {
                        this._to = context;
                      },
                      decoration:
                      InputDecoration(
                        labelText:'Điểm đến',
                        border:OutlineInputBorder(borderSide:BorderSide(width:1)),
                      ),
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(left:5),
                    child:
                    SizedBox(
                      width:60,
                      height:60,
                      child:Container(
                        color:Colors.black12,
                        child:IconButton(
                          onPressed:() {
                            Navigator.push(
                                context, MaterialPageRoute(builder:(context) {
                              return HomePage();
                            }));
                          },
                          icon:
                          Icon(Icons.my_location_sharp),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15, right:15, top:20),
              child:
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Text(
                    '* Nhấn vào',
                    style:TextStyle(
                        fontSize:20
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:5, right:5),
                    child:
                    Container(
                      color:Colors.black12,
                      child:SizedBox(
                        height:35,
                        width:35,
                        child:Icon(Icons.my_location_sharp),
                      ),
                    ),
                  ),
                  Text(
                    'để chọn trên bản đồ.',
                    style:TextStyle(
                        fontSize:20
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:EdgeInsets.only(top:20),
              child:
              ElevatedButton(
                onPressed:() {
                  _showMyDialog();
                },
                child:
                Text(
                    'XÁC NHẬN'
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog < void>(
      context:context,
      barrierDismissible:false, // user must tap button!
      builder:(BuildContext context){
        return AlertDialog(
          title: const Text('Xác nhận lộ trình!'),
          content:SingleChildScrollView(
            child:ListBody(
              children: const <Widget >[
                Text('Bạn muốn lưu lại lộ trình đã chọn?'),
              ],
            ),
          ),
          actions: <Widget >[
            Padding(
              padding: const EdgeInsets.only(right:8),
              child:
              ElevatedButton(
                child: const Text('Có'),
                onPressed:() {
                  Navigator.push(
                      context, MaterialPageRoute(builder:(context) {
                    return LoginScreen();
                  }));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right:8),
              child:
              ElevatedButton(
                child: const Text('Không'),
                onPressed:() {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
