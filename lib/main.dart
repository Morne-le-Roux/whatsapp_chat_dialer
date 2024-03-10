import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  if (Platform.isWindows) {
    WindowManager.instance.setMinimumSize(const Size(400, 600));
    WindowManager.instance.setMaximumSize(const Size(400, 600));
  }
  runApp(const WhatsappChatDialer());
}

class WhatsappChatDialer extends StatefulWidget {
  const WhatsappChatDialer({super.key});

  @override
  State<WhatsappChatDialer> createState() => _WhatsappChatDialerState();
}

class _WhatsappChatDialerState extends State<WhatsappChatDialer> {
  //VARIABLES

  final TextStyle _textStyle =
      const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold);

  String _phoneNumber = "";
  String _completedLink = "";
  final TextEditingController _countryCode = TextEditingController();

//FUNCTION TO LAUNCH WHATSAPP URL
  Future<void> launchWhatsapp({required url}) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    _countryCode.text = "27";
    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            title: const Center(
                child: Text(
              "PIC Whatsapp Dialer",
              style: TextStyle(fontWeight: FontWeight.w900),
            )),
          ),

//BODY

          body: Container(
//BACKGROUND COLOR
            color: const Color.fromARGB(255, 33, 0, 37),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Country Code",
                  style: _textStyle,
                ),

//COUNTRY CODE TEXTFIELD

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 150,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
//BORDER COLOR
                            color: Colors.amber),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: TextField(
                      style: _textStyle,
                      controller: _countryCode,
                      decoration: InputDecoration(
                          icon: const Icon(
                            Icons.map_outlined,
                            color: Colors.amber,
                          ),
                          prefix: Text(
                            "+",
                            style: _textStyle,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Phone Number",
                  style: _textStyle,
                ),

//PHONE NUMBER TEXTFIELD

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            //BORDER COLOR
                            color: Colors.amber),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: TextField(
                      style: _textStyle,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.phone_outlined,
                            color: Colors.amber,
                          ),
                          border: InputBorder.none),
                      onChanged: (value) => _phoneNumber = value,
                    ),
                  ),
                ),

//BUTTON TO LAUNCH URL

                const SizedBox(height: 20),

                GestureDetector(
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Open Chat",
                        style: _textStyle.copyWith(color: Colors.black),
                      ),
                    ),
                  ),

//ON TAP

                  onTap: () {
                    _completedLink =
                        "whatsapp://send/?phone=${_countryCode.text}$_phoneNumber&text&type=phone_number";

//CONDITIONALS TO CHECK

//IF NO PHONE NUMBER IS INSERTED
                    if (_phoneNumber == "") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "You cannot leave the phone number empty.")));

//IF NO COUNTRY CODE IS INSERTED
                    } else {
                      if (_countryCode.text == "") {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "You cannot leave the country code empty.")));

//IF THERE IS A ZERO IN FRONT OF THE NUMBER
                      } else {
                        if (_phoneNumber.substring(0, 1) == "0") {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  "Please remove the '0' in front of your phone number!")));

//IF EVERYTHING ELSE RUNS FINE
                        } else {
                          var uri = Uri.parse(_completedLink);
                          launchWhatsapp(url: uri);
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
