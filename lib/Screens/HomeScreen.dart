import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:store/Constants/Colors.dart';
import 'package:store/Constants/Server.dart';
import 'package:store/Constants/Size.dart';
import 'package:store/Screens/AdvertisementScreen.dart';
import 'package:store/Screens/CategoryScreen.dart';
import 'package:store/Screens/Product.dart';

class HomeScreen extends StatefulWidget {
  var res;
  var Products;
  HomeScreen(this.res, this.Products);
  @override
  State<HomeScreen> createState() => _HomeScreenState(res, Products);
}

class _HomeScreenState extends State<HomeScreen> {
  var activePage = 0;

  var res;
  var Products;
  var DollarPrice;
  _HomeScreenState(this.res, this.Products);
  bool _on = true;
  @override
  void initState() {
    super.initState();
    setState(() {
      DollarPrice = res['Price'][0]["Price"];
    });
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var size = MSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(height: size.getHeight() * 0.01),
          carouselSlider(context, res['advertisement'], size),
          SizedBox(height: size.getHeight() * 0.05),
          GridView(
            scrollDirection: Axis.vertical, //default
            reverse: false,
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(5.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
            ),
            children: [
              for (var i = 0; i < res['Categories'].length; i++)
                InkWell(
                  onTap: () {
                    // CategoryScreen
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryScreen(
                                res['Categories'][i], Products)));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      CategoryImageUrl + res['Categories'][i]['CategoryImage'],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: size.getHeight() * 0.05),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: size.getWidth() * 0.05),
                    // width: size.getWidth() * 0.3,
                    child: Text(
                      'اخر المنتجات',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 22 * textScaleFactor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  InkWell(
                    child: Container(
                        margin: EdgeInsets.only(left: size.getWidth() * 0.05),
                        width: 30,
                        height: 30,
                        child: (_on)
                            ? Image.asset('assets/images/money-1.png')
                            : Image.asset('assets/images/money.png')),
                    onTap: () {
                      setState(() {
                        _on = !_on;
                      });
                    },
                  ),
                ],
              ),
              Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: size.getWidth() * 0.05),
                            for (var i = 0;
                                i <
                                    ((res['latestProduct'].length > 4)
                                        ? 5
                                        : res['latestProduct'].length);
                                i++)
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: size.getWidth() * 0.02,
                                      vertical: size.getHeight() * 0.02),
                                  width: size.getWidth() * 0.4,
                                  height: size.getHeight() * 0.252,
                                  decoration: BoxDecoration(
                                    color: ProductColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          blurRadius: 10.0,
                                          offset: const Offset(0, 0))
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: (() => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ProductPage(
                                                  res['latestProduct'][i])),
                                        )),
                                    child: Column(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10)),
                                              color: Colors.white,
                                            ),
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius
                                                      .only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(
                                                      10)), //add border radius
                                              child: Image.network(
                                                ProductImageUrl +
                                                    res['latestProduct'][i]
                                                        ["ProductImage"],
                                                height: size.getHeight() * 0.16,
                                                width: size.getWidth(),
                                                fit: BoxFit.contain,
                                              ),
                                            )),
                                        SizedBox(
                                          height: size.getHeight() * 0.01,
                                        ),
                                        // Flexible(
                                        //   child: Container(
                                        //     alignment: Alignment.topLeft,
                                        //     width: size.getWidth() * 0.4,
                                        //     padding: EdgeInsets.fromLTRB(
                                        //         size.getWidth() * 0.01,
                                        //         0,
                                        //         size.getHeight() * 0.005,
                                        //         0),
                                        //     child: Text(
                                        //       res['latestProduct'][i]
                                        //           ["ProductName"],
                                        //       textAlign: TextAlign.end,
                                        //       maxLines: 2,
                                        //       style: TextStyle(
                                        //           fontWeight: FontWeight.w500,
                                        //           fontSize:
                                        //               17 * textScaleFactor),
                                        //     ),
                                        //   ),
                                        // ),
                                        Container(
                                          height: size.getHeight() * 0.04,
                                          width: size.getWidth(),
                                          alignment: Alignment.topRight,
                                          padding: EdgeInsets.only(
                                              right: 2, left: 2),
                                          child: Text(
                                            res['latestProduct'][i]
                                                ["ProductName"],
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17 * textScaleFactor),
                                            textDirection: TextDirection.ltr,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),

                                        Container(
                                          width: size.getWidth(),
                                          padding: EdgeInsets.fromLTRB(
                                              0,
                                              0,
                                              (size.getWidth() * 0.4) * 0.05,
                                              0),
                                          child: Text(
                                            ((_on)
                                                ? Price(res['latestProduct'][i]
                                                            ['ProductPrice']
                                                        .toString()) +
                                                    ' \$'
                                                : Price((res['latestProduct'][i]
                                                                [
                                                                'ProductPrice'] *
                                                            DollarPrice)
                                                        .toString()) +
                                                    ' IQD'),
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 16 * textScaleFactor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                          ]))),
              SizedBox(height: size.getHeight() * 0.05),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  height: size.getHeight() * 0.11,
                  margin:
                      EdgeInsets.symmetric(horizontal: size.getWidth() * 0.06),
                  child: Row(
                    // mainAxisAlignment,
                    children: [
                      Container(
                        width: size.getWidth() * 0.872 / 2,
                        // color: Colors.amber,
                        padding: EdgeInsets.fromLTRB(0, size.getHeight() * 0.01,
                            size.getWidth() * 0.03, 0),
                        height: size.getHeight() * 0.11,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'دولار امريكي',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20 * textScaleFactor),
                              ),
                              Text('100 \$',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16 * textScaleFactor))
                            ]),
                      ),
                      Container(
                        // color: Colors.red,

                        padding: EdgeInsets.symmetric(
                            vertical: size.getHeight() * 0.01),
                        // width: size.getWidth() * 0.88 / 3,
                        child: Center(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white54,
                                    borderRadius: BorderRadius.circular(10)),
                                width: size.getWidth() * 0.008)),
                      ),
                      Container(
                        width: size.getWidth() * 0.872 / 2,
                        padding: EdgeInsets.symmetric(
                            vertical: size.getHeight() * 0.01),
                        height: size.getHeight() * 0.11,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'دينار عراقي',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20 * textScaleFactor),
                              ),
                              Text(Price(100 * DollarPrice) + ' IQD',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16 * textScaleFactor))
                            ]),
                      )
                    ],
                  ))
            ],
          ),
          SizedBox(height: size.getHeight() * 0.05),
        ],
      )),
    );
  }

  // Widget bulder(name, data, size) {}

  // List<Widget> childrenOFList(data, size, on) {}

  Widget carouselSlider(context, advertisement, size) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index, reason) {
          setState(
            () {
              activePage = index;
            },
          );
        },
      ),
      items: advertisement
          .map<Widget>(
            (item) => InkWell(
              onTap: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Advertisements(item)),
                );
              }),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                width: size.getWidth() * 0.9,
                height: size.getHeight() * 0.1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  child: Image.network(
                    AdvertisementImageUrl + item["Photo"],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

dynamic Price(price) {
  var reverse = price.toString().split('').reversed.join('').trim();
  var temp = '';
  if (reverse.length > 3) {
    for (var i = 0; i < reverse.length; i++) {
      if (i % 3 == 0 && i != 0) {
        temp += ',' + reverse[i];
      } else {
        temp += reverse[i];
      }
    }
  } else {
    return price;
  }
  return temp.split('').reversed.join('');
}
