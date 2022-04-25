import 'package:barcode_scanner_example/main.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:davinci/davinci.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class BarcodeCreatePage extends StatefulWidget {
  @override
  _BarcodeCreatePageState createState() => _BarcodeCreatePageState();
}

class _BarcodeCreatePageState extends State<BarcodeCreatePage> {
  final controller = TextEditingController();
  static String namePattern = "(?=.*[a-z])(?=.*[A-Z])(?=.*[\u0900-\u097F])";
  GlobalKey imageKey;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  child: Davinci(builder: (key) {
                  ///3. set the widget key to the globalkey
                  imageKey = key;
                  return BarcodeWidget(
                      data: controller.text ,
                      backgroundColor: Colors.black,
                      color: Colors.white,
                      barcode: 
                      controller.text.contains(RegExp(r'[A-Z a-z 0-9]', caseSensitive: false, multiLine: false)) ?

                      Barcode.code128() : Barcode.pdf417(),
                      
                      width: 200,
                      height: 200,
                      drawText: false,
                    );
                  }
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      Get.showSnackbar(const GetSnackBar(
                        titleText: Center(
                            child: Text('Congratulation 🥳🎉',
                                style: TextStyle(color: Colors.white))),
                        messageText: Center(
                          child: Text(
                            "The QR code photo is in your gallerie",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        duration: Duration(seconds: 7),
                        snackPosition: SnackPosition.TOP,
                        margin: EdgeInsets.only(top: 100.0),
                        backgroundColor: Colors.green,
                        borderRadius: 20,
                        // margin: EdgeInsets.all(15),
                        isDismissible: true,
                        dismissDirection: DismissDirection.horizontal,
                        forwardAnimationCurve: Curves.easeOutBack,
                      ));
        //               var snackBar = SnackBar(
        //                 shape: ,
        //                 content: Text('Hello World'));
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      // /4. pass the globalKey varible to DavinciCapture.click.
                       await DavinciCapture.click(imageKey,
                          fileName: "code",
                          saveToDevice: true,
                        
                          openFilePreview: true,
                          albumName: 'QR code');
                       
                      
                      
                    },
                    child: Text(
                      "Take Picture",
                    )),
                SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(child: buildTextField(context)),
                    const SizedBox(width: 12),
                    FloatingActionButton(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(Icons.done, size: 30),
                      onPressed: () => setState(() {}),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildTextField(BuildContext context) => TextField(
        controller: controller,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          hintText: 'Enter the data',
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      );
}
