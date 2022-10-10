import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store/Constants/Server.dart';
import 'package:store/Constants/Size.dart';
import 'package:http/http.dart' as http;
import 'package:store/Screens/HomeScreen.dart';

class Orders extends StatefulWidget {
  var Products;
  Orders(this.Products);

  @override
  State<Orders> createState() => _OrdersState(Products);
}

class _OrdersState extends State<Orders> {
  var Products;
  _OrdersState(this.Products);
  var orders;
  var isLoaded = false;
  Future<void> GetData() async {
    final token = GetStorage();
    var UserID = await token.read('USER_ID');
    var response = await http
        .get(Uri.parse(url + '/order/getbyid?buyerId=' + UserID.toString()));

    if (response.statusCode == 200) {
      setState(() {
        orders = json.decode(response.body);
        isLoaded = true;
      });
    } else {}
  }

  @override
  void initState() {
    super.initState();

    GetData();
  }

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
          children: [
            Container(
                height: size.getHeight() * 0.1,
                width: size.getWidth(),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: size.getWidth() * 0.05),
                        child: const Text(
                          'الطلبات السابقة',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        width: size.getWidth() * 0.3,
                        height: size.getHeight() * 0.05,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: size.getHeight() * 0.05,
                                width: size.getWidth() * 0.1,
                                child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              )
                            ]),
                      )
                    ])),
            (!isLoaded)
                ? Container(
                    height: size.getHeight() * 0.9,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator())
                : orders['order'].length > 0
                    ? Container(
                        child: Column(
                        children: [
                          for (var i = 0; i < orders['order'].length; i++)
                            for (var j = 0;
                                j < orders['order'][i]['Products'].length;
                                j++)
                              Product(
                                  orders['order'][i]['Products'][j]
                                      ['ProductName'],
                                  orders['order'][i]['Products'][j]
                                      ['ProductPrice'],
                                  orders['order'][i]['Products'][j]
                                      ['ProductImage'],
                                  orders['order'][i]['Products'][j]['quantity'],
                                  orders['order'][i]['Products'][j]["Colors"],
                                  orders['order'][i]['status'],
                                  size,
                                  textScaleFactor)
                        ],
                      ))
                    : Container(
                        height: size.getHeight() * 0.9,
                        width: size.getWidth(),
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(top: size.getHeight() * 0.1),
                              height: size.getHeight() * 0.4,
                              child: Image.asset('assets/images/NoOrder.png'),
                            ),
                            Text(
                              'لم تقم بشراء اي منتج من قبل',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22 * textScaleFactor,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
          ],
        )),
      ),
    );
  }

  Widget Product(name, price, imageName, Quantity, colorOfProduct, status, size,
      textScaleFactor) {
    return Container(
        // width: sizeinfinity,
        // height: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: size.getWidth() * 0.05,
          vertical: size.getHeight() * 0.01,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: 3, left: size.getWidth() * 0.023),
                  alignment: Alignment.topLeft,
                  width: (size.getWidth() -
                      size.getWidth() * 0.1 -
                      size.getWidth() * 0.37),
                  height: (size.getHeight() * 0.18) / 3,
                  child: Text(
                    name,
                    textDirection: TextDirection.ltr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20 * double.parse(textScaleFactor.toString()),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                    width: (size.getWidth() -
                        size.getWidth() * 0.1 -
                        size.getWidth() * 0.37),
                    child: Row(
                      children: [
                        Container(
                            alignment: Alignment.centerRight,
                            width: (size.getWidth() -
                                    size.getWidth() * 0.1 -
                                    size.getWidth() * 0.37) *
                                0.6,
                            child: Column(
                              children: [
                                (colorOfProduct.length == 1)
                                    ? ColorOne(
                                        colorOfProduct, size, textScaleFactor)
                                    : (colorOfProduct.length == 2)
                                        ? ColorsTwo(colorOfProduct, size,
                                            textScaleFactor)
                                        : (colorOfProduct.length == 3)
                                            ? ColorsThree(colorOfProduct, size,
                                                textScaleFactor)
                                            : ColorsMoreThanThree(
                                                colorOfProduct,
                                                size,
                                                textScaleFactor),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: (status == 0)
                                          ? Colors.blue
                                          : (status == 1)
                                              ? Colors.green.withOpacity(0.8)
                                              : Color(0xff8b0000)
                                                  .withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(10)),
                                  height: (size.getHeight() * 0.18) / 3.4,
                                  width: (size.getWidth() -
                                          size.getWidth() * 0.1 -
                                          size.getWidth() * 0.37) *
                                      0.6,
                                  child: Text(
                                    status == 1
                                        ? "مكتمل"
                                        : status == 0
                                            ? 'جاري المعالجة'
                                            : 'ملغي',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18 *
                                          double.parse(
                                            textScaleFactor.toString(),
                                          ),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          padding: EdgeInsets.only(
                            top: size.getHeight() * 0.057,
                            left: size.getWidth() * 0.023,
                          ),
                          width: (size.getWidth() -
                                  size.getWidth() * 0.1 -
                                  size.getWidth() * 0.37) *
                              0.4,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                Price(price).toString() + ' \$',
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 16 *
                                        double.parse(
                                            textScaleFactor.toString()),
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: size.getHeight() * 0.003,
                              ),
                              Text(
                                'العدد : ' + Quantity.toString(),
                                style: TextStyle(
                                  color: Colors.black45.withOpacity(0.6),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18 *
                                      double.parse(textScaleFactor.toString()),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            Container(
              width: size.getWidth() * 0.37,
              // height: size.getHeight(),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  ProductImageUrl + imageName.toString(),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ));
  }

  Widget ColorOne(colorOfProduct, size, textScaleFactor) {
    return Container(
      width:
          (size.getWidth() - size.getWidth() * 0.1 - size.getWidth() * 0.37) *
              0.6,
      height: (size.getHeight() * 0.18) * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: (size.getWidth() -
                    size.getWidth() * 0.1 -
                    size.getWidth() * 0.37) *
                0.46,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(
              horizontal: size.getWidth() * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Container(
                      width: size.getWidth() * 0.067,
                      height: size.getWidth() * 0.067,
                      margin: EdgeInsets.only(right: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 0.8,
                          color: Color(
                            int.parse(
                              "0xff" +
                                  colorOfProduct[0]['color']
                                      .toString()
                                      .replaceFirst('#', ''),
                            ),
                          ),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        width: size.getWidth() * 0.048,
                        height: size.getWidth() * 0.048,
                        decoration: BoxDecoration(
                          color: Color(
                            int.parse(
                              "0xff" +
                                  colorOfProduct[0]['color']
                                      .toString()
                                      .replaceFirst('#', ''),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: (size.getWidth() -
                    size.getWidth() * 0.1 -
                    size.getWidth() * 0.37) *
                0.14,
            child: Icon(
              Icons.color_lens_sharp,
              color: Colors.grey,
              size: 26 * double.parse(textScaleFactor.toString()),
            ),
          ),
        ],
      ),
    );
  }

  Widget ColorsTwo(colorOfProduct, size, textScaleFactor) {
    return Container(
      width:
          (size.getWidth() - size.getWidth() * 0.1 - size.getWidth() * 0.37) *
              0.6,
      height: (size.getHeight() * 0.18) * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: (size.getWidth() -
                    size.getWidth() * 0.1 -
                    size.getWidth() * 0.37) *
                0.46,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(
              horizontal: size.getWidth() * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Container(
                      width: size.getWidth() * 0.067,
                      height: size.getWidth() * 0.067,
                      margin: EdgeInsets.only(right: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 0.8,
                          color: Color(
                            int.parse(
                              "0xff" +
                                  colorOfProduct[0]['color']
                                      .toString()
                                      .replaceFirst('#', ''),
                            ),
                          ),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        width: size.getWidth() * 0.048,
                        height: size.getWidth() * 0.048,
                        decoration: BoxDecoration(
                          color: Color(
                            int.parse(
                              "0xff" +
                                  colorOfProduct[0]['color']
                                      .toString()
                                      .replaceFirst('#', ''),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    Container(
                      width: size.getWidth() * 0.067,
                      height: size.getWidth() * 0.067,
                      margin: EdgeInsets.only(right: size.getWidth() * 0.035),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 0.8,
                            color: Color(
                              int.parse(
                                "0xff" +
                                    colorOfProduct[1]['color']
                                        .toString()
                                        .replaceFirst('#', ''),
                              ),
                            ),
                          )),
                      alignment: Alignment.center,
                      child: Container(
                        width: size.getWidth() * 0.048,
                        height: size.getWidth() * 0.048,
                        decoration: BoxDecoration(
                          color: Color(
                            int.parse(
                              "0xff" +
                                  colorOfProduct[1]['color']
                                      .toString()
                                      .replaceFirst('#', ''),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: (size.getWidth() -
                    size.getWidth() * 0.1 -
                    size.getWidth() * 0.37) *
                0.14,
            child: Icon(
              Icons.color_lens_sharp,
              color: Colors.grey,
              size: 26 * double.parse(textScaleFactor.toString()),
            ),
          ),
        ],
      ),
    );
  }

  Widget ColorsThree(colorOfProduct, size, textScaleFactor) {
    return Container(
      width:
          (size.getWidth() - size.getWidth() * 0.1 - size.getWidth() * 0.37) *
              0.6,
      height: (size.getHeight() * 0.18) * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: (size.getWidth() -
                    size.getWidth() * 0.1 -
                    size.getWidth() * 0.37) *
                0.46,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(
              horizontal: size.getWidth() * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Container(
                      width: size.getWidth() * 0.067,
                      height: size.getWidth() * 0.067,
                      margin: EdgeInsets.only(right: 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 0.8,
                            color: Color(
                              int.parse(
                                "0xff" +
                                    colorOfProduct[0]['color']
                                        .toString()
                                        .replaceFirst('#', ''),
                              ),
                            ),
                          )),
                      alignment: Alignment.center,
                      child: Container(
                        width: size.getWidth() * 0.048,
                        height: size.getWidth() * 0.048,
                        decoration: BoxDecoration(
                          color: Color(
                            int.parse(
                              "0xff" +
                                  colorOfProduct[0]['color']
                                      .toString()
                                      .replaceFirst('#', ''),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    Container(
                      width: size.getWidth() * 0.067,
                      height: size.getWidth() * 0.067,
                      margin: EdgeInsets.only(right: size.getWidth() * 0.035),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 0.8,
                            color: Color(
                              int.parse(
                                "0xff" +
                                    colorOfProduct[1]['color']
                                        .toString()
                                        .replaceFirst('#', ''),
                              ),
                            ),
                          )),
                      alignment: Alignment.center,
                      child: Container(
                        width: size.getWidth() * 0.048,
                        height: size.getWidth() * 0.048,
                        decoration: BoxDecoration(
                          color: Color(
                            int.parse(
                              "0xff" +
                                  colorOfProduct[1]['color']
                                      .toString()
                                      .replaceFirst('#', ''),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    Container(
                      width: size.getWidth() * 0.067,
                      height: size.getWidth() * 0.067,
                      margin: EdgeInsets.only(right: size.getWidth() * 0.07),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 0.8,
                            color: Color(
                              int.parse(
                                "0xff" +
                                    colorOfProduct[2]['color']
                                        .toString()
                                        .replaceFirst('#', ''),
                              ),
                            ),
                          )),
                      alignment: Alignment.center,
                      child: Container(
                        width: size.getWidth() * 0.048,
                        height: size.getWidth() * 0.048,
                        decoration: BoxDecoration(
                          color: Color(
                            int.parse(
                              "0xff" +
                                  colorOfProduct[2]['color']
                                      .toString()
                                      .replaceFirst('#', ''),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: (size.getWidth() -
                    size.getWidth() * 0.1 -
                    size.getWidth() * 0.37) *
                0.14,
            child: Icon(
              Icons.color_lens_sharp,
              color: Colors.grey,
              size: 26 * double.parse(textScaleFactor.toString()),
            ),
          ),
        ],
      ),
    );
  }

  Widget ColorsMoreThanThree(colorOfProduct, size, textScaleFactor) {
    return Container(
      width:
          (size.getWidth() - size.getWidth() * 0.1 - size.getWidth() * 0.37) *
              0.6,
      height: (size.getHeight() * 0.18) * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: (size.getWidth() -
                    size.getWidth() * 0.1 -
                    size.getWidth() * 0.37) *
                0.48,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(
              horizontal: size.getWidth() * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  (colorOfProduct.length - 3).toString() + '+ ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 18 * double.parse(textScaleFactor.toString()),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      width: size.getWidth() * 0.067,
                      height: size.getWidth() * 0.067,
                      margin: EdgeInsets.only(right: 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 0.8,
                            color: Color(
                              int.parse(
                                "0xff" +
                                    colorOfProduct[0]['color']
                                        .toString()
                                        .replaceFirst('#', ''),
                              ),
                            ),
                          )),
                      alignment: Alignment.center,
                      child: Container(
                        width: size.getWidth() * 0.048,
                        height: size.getWidth() * 0.048,
                        decoration: BoxDecoration(
                          color: Color(
                            int.parse(
                              "0xff" +
                                  colorOfProduct[0]['color']
                                      .toString()
                                      .replaceFirst('#', ''),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    Container(
                      width: size.getWidth() * 0.067,
                      height: size.getWidth() * 0.067,
                      margin: EdgeInsets.only(right: size.getWidth() * 0.035),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 0.8,
                            color: Color(
                              int.parse(
                                "0xff" +
                                    colorOfProduct[1]['color']
                                        .toString()
                                        .replaceFirst('#', ''),
                              ),
                            ),
                          )),
                      alignment: Alignment.center,
                      child: Container(
                        width: size.getWidth() * 0.048,
                        height: size.getWidth() * 0.048,
                        decoration: BoxDecoration(
                          color: Color(
                            int.parse(
                              "0xff" +
                                  colorOfProduct[1]['color']
                                      .toString()
                                      .replaceFirst('#', ''),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    Container(
                      width: size.getWidth() * 0.067,
                      height: size.getWidth() * 0.067,
                      margin: EdgeInsets.only(right: size.getWidth() * 0.07),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 0.8,
                            color: Color(
                              int.parse(
                                "0xff" +
                                    colorOfProduct[2]['color']
                                        .toString()
                                        .replaceFirst('#', ''),
                              ),
                            ),
                          )),
                      alignment: Alignment.center,
                      child: Container(
                        width: size.getWidth() * 0.048,
                        height: size.getWidth() * 0.048,
                        decoration: BoxDecoration(
                          color: Color(
                            int.parse(
                              "0xff" +
                                  colorOfProduct[2]['color']
                                      .toString()
                                      .replaceFirst('#', ''),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: (size.getWidth() -
                    size.getWidth() * 0.1 -
                    size.getWidth() * 0.37) *
                0.12,
            child: Icon(
              Icons.color_lens_sharp,
              color: Colors.grey,
              size: 26 * double.parse(textScaleFactor.toString()),
            ),
          ),
        ],
      ),
    );
  }
}
