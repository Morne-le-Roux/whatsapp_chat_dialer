import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const WhatsappChatDialer());
}

class WhatsappChatDialer extends StatefulWidget {
  const WhatsappChatDialer({super.key});

  @override
  State<WhatsappChatDialer> createState() => _WhatsappChatDialerState();
}

class _WhatsappChatDialerState extends State<WhatsappChatDialer> {
  //VARIABLES
  String countryCode = "";
  String phoneNumber = "";
  String api = "https://wa.me/";
  String completedLink = "";

  Future<void> launchWhatsapp({required url}) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      print("launched");
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.greenAccent.shade700,
            title: const Center(child: Text("Whatsapp Chat Dialer")),
          ),

          //BODY

          body: Container(
            color: Colors.white, //BACKGROUND COLOR
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text("Country Code"),

                //COUNTRY CODE TEXTFIELD

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 150,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.lightGreenAccent), //BORDER COLOR
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: TextField(
                      decoration: const InputDecoration(
                          icon: Icon(Icons.map_outlined),
                          prefix: Text("+"),
                          border: InputBorder.none),
                      onChanged: (value) => countryCode = value,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Phone Number"),

                //PHONE NUMBER TEXTFIELD

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.lightGreenAccent), //BORDER COLOR
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: TextField(
                      decoration: const InputDecoration(
                          icon: Icon(Icons.phone_outlined),
                          border: InputBorder.none),
                      onChanged: (value) => phoneNumber = value,
                    ),
                  ),
                ),

                //BUTTON TO RUN APP

                GestureDetector(
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.lightGreenAccent.shade700,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Open Chat",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  //ON TAP

                  onTap: () {
                    completedLink = "$api$countryCode$phoneNumber";

                    if (phoneNumber == "") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "You cannot leave the phone number empty.")));
                    } else {
                      if (countryCode == "") {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "You cannot leave the country code empty.")));
                      } else {
                        if (phoneNumber.substring(0, 1) == "0") {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  "Please remove the '0' in front of your phone number!")));
                        } else {
                          var uri = Uri.parse(completedLink);
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
