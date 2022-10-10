import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:store/Constants/Colors.dart';
import 'package:store/Screens/CartScreen.dart';
import 'package:store/Screens/FavoriteScreen.dart';
import 'package:store/Screens/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:store/Constants/Server.dart';
import 'package:store/Screens/InfoScreen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBarScreen> {
  String TokenGnreate(length) {
    const _chars =
        'AaBbCcDdEeFfGdsadaxccvdfdgsdreqeghjghjmkluiPpQFqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late var HomeResponse;
  late var Products;

  late var UserID;
  bool isLoaded = false;
  Future<dynamic> getHomeData() async {
    var response = await http.get(Uri.parse(url + '/pages/home/get'));

    if (response.statusCode == 200) {
      HomeResponse = json.decode(response.body);
    } else {}
  }

  Future<dynamic> getProducts() async {
    var response = await http.get(Uri.parse(url + '/pages/Favorite'));

    if (response.statusCode == 200) {
      Products = json.decode(response.body);
    } else {}
  }

  Future<void> initOneSignal() async {
    await OneSignal.shared.setAppId("8f0462e2-2f86-493f-ae24-30509046522b");
    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});
  }

  void getAllData() async {
    await initOneSignal();
    final token = GetStorage();
    token.writeIfNull('USER_ID', TokenGnreate(230));
    UserID = await token.read('USER_ID');
    await getHomeData();
    await getProducts();

    setState(() {
      isLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    initialization();
    getAllData();
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoaded
          ? SafeArea(
              left: false,
              right: false,
              bottom: false,
              child: [
                HomeScreen(HomeResponse, Products),
                FavoriteScreen(Products, UserID),
                CartScreen(Products),
                InfoScreen()
              ][_selectedIndex])
          : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon:
                  getIcon('assets/icons/UnselectedHome.svg', 0, _selectedIndex),
              activeIcon:
                  getIcon('assets/icons/selectedHome.svg', 0, _selectedIndex),
              label: ""),
          BottomNavigationBarItem(
            icon: getIcon('assets/icons/UnselectedLove.svg', 1, _selectedIndex),
            activeIcon:
                getIcon('assets/icons/selectedLove.svg', 1, _selectedIndex),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: getIcon('assets/icons/UnselectedBag.svg', 2, _selectedIndex),
            activeIcon:
                getIcon('assets/icons/selectedBag.svg', 2, _selectedIndex),
            label: "",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz_outlined),
              activeIcon: Icon(
                Icons.more_horiz_outlined,
                color: Colors.black,
              ),
              label: ""),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: selectedItemColor,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: white,
        unselectedItemColor: unselectedItemColor,
      ),
    );
  }

  Widget getIcon(
    assets,
    index,
    selectedIndex,
  ) {
    return SvgPicture.asset(
      assets,
      width: 25,
      height: 25,
      color: (index == selectedIndex) ? selectedItemColor : unselectedItemColor,
    );
  }
}
