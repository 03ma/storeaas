import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/Constants/Size.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'dart:io' show Platform;

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  var FirstPhoneNumber = '07722229439';
  var SecendPhoneNumber = '07822229439';
  var IsCompany = true;
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var size = MSize(context);
    return SafeArea(
      left: false,
      right: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.getHeight() * 0.03,
              ),
              Container(
                width: size.getWidth(),
                height: size.getHeight() * 0.23,
                alignment: Alignment.center,
                child: Image.asset('assets/images/logo_blue_no_bg.png'),
              ),
              Text(
                'نزار للموبايل والصيرفة',
                textScaleFactor: textScaleFactor,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.blue,
                    size: 34,
                  ),
                  Text(
                    'بغداد - مدينة الصدر - ساحة 55',
                    textScaleFactor: textScaleFactor,
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w300),
                  )
                ],
              ),
              SizedBox(
                height: size.getHeight() * 0.03,
              ),
              Container(
                width: size.getWidth() * 0.9,
                height: size.getHeight() * 0.001,
                color: Colors.grey,
              ),
              SizedBox(
                height: size.getHeight() * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: (() {
                      setState(() {
                        IsCompany = false;
                        FirstPhoneNumber = '07714096772';
                        SecendPhoneNumber = '07714096772';
                      });
                    }),
                    child: Container(
                      width: size.getWidth() * 0.35,
                      height: size.getHeight() * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: !IsCompany ? Colors.blueGrey : Colors.grey,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.getHeight() * 0.01,
                          ),
                          Container(
                            width: size.getWidth() * 0.3,
                            height: size.getHeight() * 0.09,
                            child: Image.asset('assets/images/UsedPhone.png'),
                          ),
                          Text(
                            "قسم المستعمل",
                            textScaleFactor: textScaleFactor,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (() {
                      setState(() {
                        IsCompany = true;
                        FirstPhoneNumber = '07722229439';
                        SecendPhoneNumber = '07822229439';
                      });
                    }),
                    child: Container(
                      width: size.getWidth() * 0.35,
                      height: size.getHeight() * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: IsCompany ? Colors.blueGrey : Colors.grey,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.getHeight() * 0.01,
                          ),
                          Container(
                            width: size.getWidth() * 0.3,
                            height: size.getHeight() * 0.09,
                            child: Image.asset('assets/images/logo_No_bg.png'),
                          ),
                          Text(
                            "الشركة",
                            textScaleFactor: textScaleFactor,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.getHeight() * 0.03,
              ),
              Container(
                height: IsCompany
                    ? size.getHeight() * 0.15
                    : size.getHeight() * 0.08,
                width: size.getWidth() * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey,
                  // color: Colors.blue.shade800,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: size.getHeight() * 0.15 / 2,
                      width: size.getWidth() * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            FirstPhoneNumber,
                            textScaleFactor: textScaleFactor,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          SizedBox(
                            width: size.getWidth() * 0.02,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.phone,
                              color: Colors.grey,
                              size: 37,
                            ),
                            onPressed: () {
                              UrlLauncher.launch("tel://$FirstPhoneNumber");
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.whatsapp,
                              color: Colors.green,
                              size: 37,
                            ),
                            onPressed: () async {
                              var whatsapp = "+964" +
                                  FirstPhoneNumber.replaceFirst('0', '');
                              var whatsappURl_android =
                                  "whatsapp://send?phone=" +
                                      whatsapp +
                                      "&text=مرحباً";
                              var whatappURL_ios =
                                  "https://wa.me/$whatsapp?text=${Uri.parse("مرحباً")}";
                              if (Platform.isIOS) {
                                // for iOS phone only
                                if (await UrlLauncher.canLaunch(
                                    whatappURL_ios)) {
                                  await UrlLauncher.launch(whatappURL_ios,
                                      forceSafariVC: false);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: new Text(
                                              "whatsapp no installed")));
                                }
                              } else {
                                // android , web
                                if (await UrlLauncher.canLaunch(
                                    whatsappURl_android)) {
                                  await UrlLauncher.launch(whatsappURl_android);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "تعذر فتح واتس اب !!",
                                      textColor: Colors.white,
                                      fontSize: 20 * textScaleFactor,
                                      backgroundColor: Colors.black54,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1);
                                }
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    (IsCompany)
                        ? Container(
                            height: size.getHeight() * 0.15 / 2,
                            width: size.getWidth() * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  SecendPhoneNumber,
                                  textScaleFactor: textScaleFactor,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                                SizedBox(
                                  width: size.getWidth() * 0.02,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.phone,
                                    color: Colors.grey,
                                    size: 37,
                                  ),
                                  onPressed: () {
                                    UrlLauncher.launch(
                                        "tel://$SecendPhoneNumber");
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.whatsapp,
                                    color: Colors.green,
                                    size: 37,
                                  ),
                                  onPressed: () async {
                                    var whatsapp = "+964" +
                                        SecendPhoneNumber.replaceFirst('0', '');
                                    var whatsappURl_android =
                                        "whatsapp://send?phone=" +
                                            whatsapp +
                                            "&text=مرحباً";
                                    var whatappURL_ios =
                                        "https://wa.me/$whatsapp?text=${Uri.parse("مرحباً")}";
                                    if (Platform.isIOS) {
                                      // for iOS phone only
                                      if (await UrlLauncher.canLaunch(
                                          whatappURL_ios)) {
                                        await UrlLauncher.launch(whatappURL_ios,
                                            forceSafariVC: false);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "تعذر فتح واتس اب !!",
                                            textColor: Colors.white,
                                            fontSize: 20 * textScaleFactor,
                                            backgroundColor: Colors.black54,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1);
                                        ;
                                      }
                                    } else {
                                      // android , web
                                      if (await UrlLauncher.canLaunch(
                                          whatsappURl_android)) {
                                        await UrlLauncher.launch(
                                            whatsappURl_android);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "تعذر فتح واتس اب !!",
                                            textColor: Colors.white,
                                            fontSize: 20 * textScaleFactor,
                                            backgroundColor: Colors.black54,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1);
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
              SizedBox(
                height: size.getHeight() * 0.02,
              ),
              Container(
                width: size.getWidth() * 0.4,
                height: size.getHeight() * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: (() async {
                        const nativeUrl =
                            "instagram://user?username=nizarbazoon";
                        const webUrl = "https://www.instagram.com/nizarbazoon/";
                        if (await UrlLauncher.canLaunch(nativeUrl)) {
                          UrlLauncher.launch(nativeUrl);
                        } else if (await UrlLauncher.canLaunch(webUrl)) {
                          UrlLauncher.launch(webUrl);
                        } else {
                          print("can't open Instagram");
                        }
                      }),
                      child: Container(
                        width: size.getWidth() * 0.15,
                        child: Image.asset('assets/images/instagram.png'),
                      ),
                    ),
                    InkWell(
                      onTap: (() async {
                        String fbProtocolUrl;
                        bool isIOS =
                            Theme.of(context).platform == TargetPlatform.iOS;
                        if (isIOS) {
                          fbProtocolUrl = 'fb://profile/1479100262309379';
                        } else {
                          fbProtocolUrl = 'fb://page/1479100262309379';
                        }

                        String fallbackUrl =
                            'https://www.facebook.com/nizar.mobie.55';

                        try {
                          bool launched = await UrlLauncher.launch(
                              fbProtocolUrl,
                              forceSafariVC: false);

                          if (!launched) {
                            await UrlLauncher.launch(fallbackUrl,
                                forceSafariVC: false);
                          }
                        } catch (e) {
                          await UrlLauncher.launch(fallbackUrl,
                              forceSafariVC: false);
                        }
                      }),
                      child: Container(
                        width: size.getWidth() * 0.15,
                        height: size.getHeight() * 0.1,
                        child: Image.asset('assets/images/FaceBook.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
