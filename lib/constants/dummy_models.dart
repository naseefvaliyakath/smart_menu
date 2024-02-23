import 'package:smart_menu/data/model/shop/shop.dart';

List<String> dashboardImg = ['fast-food.png', 'menu.png', 'gift.png', 'web.png', 'qr-code.png', 'settings.png'];
List<String> dashboardTitle = ['Add Foods', 'Menu', 'Offer', 'Menu Book', 'QR Code', 'Settings'];
List<String> dashboardSubTitle = [
  'Add New Foods',
  'Manage Menus',
  'Mange Offer',
  'Setup Menu Book',
  'Manage QR Code',
  'Settings'
];

List<String> homePageShowCaseTitle = ['Step 1','Step 2','Step 3','Step 4','Step 5',''];
List<String> homePageShowCaseDescription = ['Add New foods','Customize Food For Menu','Setup Offers For Foods','Customize Menu Website','Create QR Code Table Stand',''];

Shop dummyShop = Shop(
    shopId: 0,
    shopName: 'No Name',
    phoneNumber: '1234567890',
    email: 'dummy@gmail.com',
    state: 'KERALA',
    district: 'THRISSUR',
    plan: 'Trial',
    expiryDate: DateTime.now().toString(),
    status: 'deactivated',
    createdAt: DateTime.now().toString(),
    updatedAt: DateTime.now().toString(),
    token: '');
