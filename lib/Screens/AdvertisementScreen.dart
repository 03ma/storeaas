import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:store/Constants/Server.dart';
import 'package:store/Constants/Size.dart';

class Advertisements extends StatefulWidget {
  var Advertisement;
  Advertisements(this.Advertisement);

  @override
  State<Advertisements> createState() => _AdvertisementState(Advertisement);
}

class _AdvertisementState extends State<Advertisements> {
  var Advertisement;
  _AdvertisementState(this.Advertisement);
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var size = MSize(context);

    return SafeArea(
      left: false,
      right: false,
      bottom: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                      width: size.getWidth(),
                      height: size.getHeight() * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              blurRadius: 10.0,
                              offset: const Offset(0, 0))
                        ],
                      ),
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          child: Image.network(
                            AdvertisementImageUrl + Advertisement['Photo'],
                            fit: BoxFit.contain,
                          ))),
                  Container(
                    margin: EdgeInsets.only(
                        top: size.getHeight() * 0.02,
                        left: size.getWidth() * 0.02),
                    width: 40,
                    height: 40,
                    // color: Colors.amber,
                    child: IconButton(
                      onPressed: (() => Navigator.of(context).pop()),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.getHeight() * 0.02),
              Container(
                width: size.getWidth(),
                padding:
                    EdgeInsets.symmetric(horizontal: size.getWidth() * 0.02),
                child: Text(
                  Advertisement['title'],
                  textAlign: TextAlign.start,
                  textScaleFactor: textScaleFactor,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: EdgeInsets.all(size.getWidth() * 0.02),
                width: size.getWidth(),
                child: Text(
                  Advertisement['description'],
                  textAlign: TextAlign.start,
                  textScaleFactor: textScaleFactor,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
