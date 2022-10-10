import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:store/Constants/Colors.dart';
import 'package:store/Constants/Server.dart';
import 'package:store/Constants/Size.dart';
import 'package:store/Screens/HomeScreen.dart';

class FavoriteScreen extends StatefulWidget {
  var UserID;
  var Products;

  FavoriteScreen(this.Products, this.UserID);

  @override
  State<FavoriteScreen> createState() => _FavoriteState(Products, UserID);
}

class _FavoriteState extends State<FavoriteScreen> {
  var UserID;
  var Result;
  var Products;
  _FavoriteState(this.Products, this.UserID);
  Future<void> getData() async {
    var box = await Hive.openBox('Favorite');

    var temp = await box.values.toList();
    for (var i = 0; i < temp.length; i++) {
      for (var j = 0; j < Products.length; j++) {
        if (temp[i] == Products[j]["_id"]) {
          break;
        } else if (j == Products.length - 1) {
          await box.clear();
        }
      }
    }
    temp = await box.values.toList();
    setState(() {
      Result = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var size = MSize(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: (Result != null)
            ? SingleChildScrollView(
                child: Column(children: [
                Container(
                    height: size.getHeight() * 0.1,
                    width: size.getWidth(),
                    alignment: Alignment.center,
                    child: Text('المفضلة',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24 * textScaleFactor,
                            fontWeight: FontWeight.w500))),
                // Product(Result[i], size, i)
                (Result.length != 0)
                    ? Column(
                        children: [
                          for (var i = 0; i < Result.length; i++)
                            Container(
                                height: size.getHeight() * 0.18,
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.getWidth() * 0.05,
                                    vertical: size.getHeight() * 0.01),
                                width: size.getWidth() * 0.9,
                                child: Product(
                                    Result[i], size, i, textScaleFactor))
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.getHeight() * 0.1,
                            width: size.getWidth(),
                          ),
                          Image.asset(
                            'assets/images/brokenHeart.png',
                            height: size.getHeight() * 0.3,
                            width: size.getWidth(),
                          ),
                          SizedBox(height: size.getHeight() * 0.07),
                          Text(
                            "لا توجد منتجات في المفضلة",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22 * textScaleFactor,
                                color: Color.fromRGBO(158, 158, 158, 1),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
              ]))
            : const Center(child: CircularProgressIndicator()));
  }

  void delete(index) async {
    var box = await Hive.openBox('Favorite');
    await box.deleteAt(index);
    var temp = await box.values.toList();
    setState(() {
      Result = temp;
    });
  }

  Widget Product(id, size, index, textScaleFactor) {
    var product;
    for (var i = 0; i < Products.length; i++) {
      if (Products[i]['_id'] == id) {
        product = Products[i];
        break;
      }
    }
    return Container(
        width: double.infinity,
        height: double.infinity,
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
                  height: (size.getHeight() * 0.18) / 2,
                  child: Text(
                    product['ProductName'],
                    textDirection: TextDirection.ltr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20 * double.parse(textScaleFactor.toString()),
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                    width: (size.getWidth() -
                        size.getWidth() * 0.1 -
                        size.getWidth() * 0.37),
                    height: (size.getHeight() * 0.18) / 2,
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          width: (size.getWidth() -
                                  size.getWidth() * 0.1 -
                                  size.getWidth() * 0.37) *
                              0.54,
                          child: IconButton(
                            icon: const Icon(Icons.favorite,
                                size: 30, color: Colors.red),
                            onPressed: (() => delete(index)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 3, left: size.getWidth() * 0.023),
                          width: (size.getWidth() -
                                  size.getWidth() * 0.1 -
                                  size.getWidth() * 0.37) *
                              0.46,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            Price(product['ProductPrice']).toString() + ' \$',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16 *
                                    double.parse(textScaleFactor.toString()),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            Container(
              width: size.getWidth() * 0.37,
              height: size.getHeight(),
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
                  ProductImageUrl + product['ProductImage'],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ));
  }
}
