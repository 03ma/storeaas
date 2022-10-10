import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:store/Constants/Server.dart';
import 'package:store/Constants/Size.dart';
import 'package:store/Screens/HomeScreen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class ProductPage extends StatefulWidget {
  var product;
  ProductPage(this.product);

  @override
  State<ProductPage> createState() => _ProductState(product);
}

class _ProductState extends State<ProductPage> {
  var color = 0;
  var product;
  _ProductState(this.product);
  var checkIfInCart = false;
  var checkIfInFavorite = false;
  var _indexFavorite = -1;

  Future CheckIFInCart() async {
    var box = await Hive.openBox('Carts');
    var temp = await box.values.toList();
    for (var i = 0; i < temp.length; i++) {
      if (temp[i][0]['ID'].toString() == product["_id"]) {
        setState(() {
          checkIfInCart = true;
        });
        break;
      }
    }
  }

  Future CheckIfInFavorite() async {
    var box = await Hive.openBox('Favorite');
    var temp = await box.values.toList();
    for (var i = 0; i < temp.length; i++) {
      if (temp[i].toString() == product["_id"]) {
        setState(() {
          checkIfInFavorite = true;
          _indexFavorite = i;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    CheckIFInCart();
    CheckIfInFavorite();
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
          body: SingleChildScrollView(
              child: Column(
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                      width: size.getWidth(),
                      height: size.getHeight() * 0.4,
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
                            ProductImageUrl + product['ProductImage'],
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
                child: Row(
                  children: [
                    Container(
                      width: size.getWidth() * 0.2,
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed: (() async {
                          var box = await Hive.openBox('Favorite');
                          if (checkIfInFavorite) {
                            box.deleteAt(_indexFavorite);
                            setState(() {
                              checkIfInFavorite = false;
                            });
                          } else {
                            await box.add(product["_id"]);
                            var temp = await box.values.toList();
                            CheckIfInFavorite();
                          }
                        }),
                        icon: (!checkIfInFavorite)
                            ? const Icon(Icons.favorite_border_sharp,
                                size: 35, color: Colors.black45)
                            : const Icon(Icons.favorite,
                                size: 35, color: Colors.red),
                      ),
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        width: size.getWidth() * 0.8,
                        padding: EdgeInsets.only(left: size.getWidth() * 0.02),
                        child: Text(product['ProductName'].toString(),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 23 * textScaleFactor,
                                fontWeight: FontWeight.w500)))
                  ],
                ),
              ),
              Container(
                  width: size.getWidth(),
                  padding: EdgeInsets.only(left: size.getWidth() * 0.02),
                  child: Text(Price(product['ProductPrice'].toString()) + ' \$',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 21 * textScaleFactor,
                          fontWeight: FontWeight.w400))),
              SizedBox(height: size.getHeight() * 0.04),
              ColorsView(size),
              SizedBox(height: size.getHeight() * 0.02),

              Properties(
                size,
                'دقة الشاشة',
                product["ScreenResolution"],
                textScaleFactor,
              ),
              SizedBox(height: size.getHeight() * 0.02),
              Properties(
                size,
                'منفذ الشحن',
                product["ChargerPort"],
                textScaleFactor,
              ),
              SizedBox(height: size.getHeight() * 0.02),
              Properties(
                size,
                'المعالج',
                product["Cpu"],
                textScaleFactor,
              ),
              SizedBox(height: size.getHeight() * 0.02),
              Properties(
                size,
                'حجم البطارية',
                product["BatterySize"],
                textScaleFactor,
              ),
              SizedBox(height: size.getHeight() * 0.02),
              Properties(
                size,
                'الذاكرة العشوائية',
                product["Memory"]['RAM'],
                textScaleFactor,
              ),
              SizedBox(height: size.getHeight() * 0.02),
              Properties(
                size,
                'ذاكرة التخزين',
                product["Memory"]['InternalMemory'],
                textScaleFactor,
              ),
              for (var d = 0; d < product["FrontCamera"].length; d++)
                Column(
                  children: [
                    SizedBox(height: size.getHeight() * 0.02),
                    Properties(
                      size,
                      'الكاميرا الامامية -${d + 1}-',
                      product["FrontCamera"][d],
                      textScaleFactor,
                    ),
                  ],
                ),
              for (var d = 0; d < product["BackCamera"].length; d++)
                Column(
                  children: [
                    SizedBox(height: size.getHeight() * 0.01),
                    Properties(
                      size,
                      'الكاميرا الخلفية -${d + 1}-',
                      product["BackCamera"][d],
                      textScaleFactor,
                    ),
                  ],
                ),

              // SizedBox(height: size.getHeight() * 0.03),
              // Properties(
              //     size, 'دقة الكاميرا الامامية', 'FrontCamera', textScaleFactor,
              //     secendValue: 'CamaraQuality'),
              // SizedBox(height: size.getHeight() * 0.03),
              // Properties(
              //     size, 'جودة الكاميرا الامامية', 'FrontCamera', textScaleFactor,
              //     secendValue: 'VideoResolution'),
              // SizedBox(height: size.getHeight() * 0.03),
              // Properties(
              //     size, 'دقة الكاميرا الخلفية', 'BackCamera', textScaleFactor,
              //     secendValue: 'CamaraQuality'),
              // SizedBox(height: size.getHeight() * 0.03),
              // Properties(
              //     size, 'جودة الكاميرا الخلفية', 'BackCamera', textScaleFactor,
              //     secendValue: 'VideoResolution'),
              SizedBox(height: size.getHeight() * 0.03),
              InkWell(
                onTap: (() async {
                  var box = await Hive.openBox('Carts');
                  if (checkIfInCart) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.ERROR,
                      headerAnimationLoop: false,
                      animType: AnimType.TOPSLIDE,
                      title: 'المنتج موجود في السلة بالفعل',
                      dismissOnTouchOutside: false,
                      btnOk: InkWell(
                        onTap: (() => Navigator.pop(context)),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.getWidth() * 0.2),
                          height: size.getHeight() * 0.06,
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          child: Text('اغلاق',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24 * textScaleFactor,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      btnOkText: 'اغلاق',
                      btnOkOnPress: () {},
                    ).show();
                  } else {
                    await box.add([
                      {
                        "ID": product["_id"],
                        'Color': product['Colors'][color]['ColorHex']
                      }
                    ]);
                    var temp = await box.values.toList();
                    CheckIFInCart();
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.SUCCES,
                      headerAnimationLoop: false,
                      animType: AnimType.TOPSLIDE,
                      title: 'تم اضافة المنتج الى السلة',
                      dismissOnTouchOutside: false,
                      btnOk: InkWell(
                        onTap: (() => Navigator.pop(context)),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.getWidth() * 0.2),
                          height: size.getHeight() * 0.06,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          child: Text('اغلاق',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24 * textScaleFactor,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      btnOkText: 'اغلاق',
                      btnOkOnPress: () {},
                    ).show();
                  }
                }),
                child: Container(
                    margin: EdgeInsets.only(top: size.getHeight() * 0.02),
                    width: size.getWidth() * 0.8,
                    height: size.getHeight() * 0.1,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: Text(
                      'اضف الى السلة',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25 * textScaleFactor,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(height: size.getHeight() * 0.05),
            ],
          )),
        ));
  }

  Widget ColorsView(size) {
    return Container(
      width: size.getWidth(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var i = 0; i < product['Colors'].length; i++)
              InkWell(
                onTap: (() => setState(() {
                      color = i;
                    })),
                child: Container(
                    height: size.getHeight() * 0.07,
                    width: size.getHeight() * 0.07,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                        horizontal: size.getWidth() * 0.02),
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            blurRadius: 10.0,
                            offset: const Offset(0, 0))
                      ],
                      borderRadius: BorderRadius.circular(100),
                      color: Color(int.parse("0xFF" +
                          product['Colors'][i]['ColorHex'].substring(1))),
                    ),
                    child: (color == i)
                        ? Icon(Icons.check,
                            color: (i < product['Colors'].length - 1)
                                ? Color(int.parse("0xFF" +
                                    product['Colors'][i + 1]['ColorHex']
                                        .substring(1)))
                                : (product['Colors'].length > 1)
                                    ? Color(int.parse("0xFF" +
                                        product['Colors'][i - 1]['ColorHex']
                                            .substring(1)))
                                    : Colors.grey)
                        : Container()),
              )
          ],
        ),
      ),
    );
  }

  Widget Properties(
    size,
    key,
    value,
    textScaleFactor,
  ) {
    return Row(
      children: [
        Container(
          width: size.getWidth() * 0.45,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: size.getWidth() * 0.02),
          child: Text(key,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 19 * double.parse(textScaleFactor.toString()),
                  fontWeight: FontWeight.w500)),
        ),
        Container(
          width: size.getWidth() * 0.55,
          child: Text(value.toString(),
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18 * double.parse(textScaleFactor.toString()),
                  fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          // Bottom rectangular box
          margin:
              EdgeInsets.only(top: 40), // to push the box half way below circle
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.only(
              top: 60, left: 20, right: 20), // spacing inside the box
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                '',
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.center,
              ),
              ButtonBar(
                buttonMinWidth: 100,
                alignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Text(''),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  InkWell(
                    child: Text(''),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        CircleAvatar(
          // Top Circle with icon
          maxRadius: 40.0,
          child: Icon(Icons.message),
        ),
      ],
    );
  }
}
