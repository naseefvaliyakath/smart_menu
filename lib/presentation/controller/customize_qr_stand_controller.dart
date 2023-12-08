import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_menu/data/model/item_purchase_model/item_purchase_model.dart';
import 'package:smart_menu/domain/repository/network/contract/shop_repository.dart';
import 'package:smart_menu/presentation/controller/login_controller.dart';
import '../../constants/app_constant_names.dart';
import '../../data/model/api_response/api_response.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CustomizeQRStandController extends GetxController {
  ShopRepository shopRepository = Get.find<ShopRepository>();

  TextEditingController shopNameCtrl = TextEditingController();
  TextEditingController scanTextCtrl = TextEditingController();

  bool isBorderVisible = false;
  bool isPreviewMode = false;

  final List<ItemPurchaseModel> _purchaseItems = [];

  List<ItemPurchaseModel> get purchaseItems => _purchaseItems;

  String restaurantName = 'Hello';
  String scanMeText = 'Scan Me for menu !!';
  XFile? logoImage;
  Uint8List? initialLogo;
  final ImagePicker imagePicker = ImagePicker();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  Future<void> onInit() async {
    super.onInit();
    loadSavedImage();
    readTextFromStorage();
    getAllPurchaseItem();
    initialLogo = await loadAssetImageBytes('assets/image/food_logo.png');
  }

  Future<void> pickLogoImage() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await saveImageLocally(pickedFile);
      logoImage = pickedFile;
      update(); // This will trigger UI update
    }
  }

  void changeRestaurantName() {
    restaurantName = shopNameCtrl.text;
    storage.write(key: KEY_QR_SETUP_HOTEL_NAME, value: restaurantName);
    update();
  }

  void changeScanMeText() {
    scanMeText = scanTextCtrl.text;
    storage.write(key: KEY_QR_SETUP_SCAN_ME_TXT, value: scanMeText);
    update();
  }

  void toggleBorder() {
    isBorderVisible = !isBorderVisible;
    update();
  }

  void togglePreviewMode() {
    isPreviewMode = !isPreviewMode;
    update();
  }

  // Save the image to the app's local directory and store the path in Flutter Secure Storage
  Future<void> saveImageLocally(XFile imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('${path}/savedImage.png');

    await File(imageFile.path).copy(file.path);

    await storage.write(key: 'savedImagePath', value: file.path);
  }

  // Load the saved image when the app starts
  Future<void> loadSavedImage() async {
    final savedImagePath = await storage.read(key: 'savedImagePath');
    if (savedImagePath != null) {
      logoImage = XFile(savedImagePath);
      update();
    }
  }

  readTextFromStorage() async {
    String hotelName = await storage.read(key: KEY_QR_SETUP_HOTEL_NAME) ?? Get.find<LoginController>().myShop.shopName ?? 'Hello';
    String scanMeTxtRead = await storage.read(key: KEY_QR_SETUP_SCAN_ME_TXT) ?? 'SCAN FOR MENU';
    restaurantName = hotelName;
    scanMeText = scanMeTxtRead;
    update();
  }

  getAllPurchaseItem() async {
    try {
      ApiResponse<List<ItemPurchaseModel>>? apiResponse = await shopRepository.getAllPurchaseItem();
      if (apiResponse != null) {
        if (apiResponse.error) {
          return false;
        } else {
          _purchaseItems.clear();
          _purchaseItems.addAll(apiResponse.data ?? []);
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      return e;
    } finally {
      update();
    }
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    // Add page with two A6 designs rotated and placed vertically
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              _buildQrDesign(),
            ],
          );
        },
      ),
    );

    // Save and share the PDF file
    final output = await getApplicationDocumentsDirectory();
    final file = File("${output.path}/qr_stands.pdf");
    await file.writeAsBytes(await pdf.save());
    final xFileImage = XFile(file.path);
    await Share.shareXFiles([xFileImage]);
  }

  pw.Widget _buildQrDesign() {
    // Define A6 size
    final a6Width = PdfPageFormat.a4.width / 2;
    final a6Height = PdfPageFormat.a4.height / 2;

    return pw.Transform(
      transform: Matrix4.rotationZ(-pi / 2)..translate(-a6Height, 0),
      child: pw.Container(
        width: a6Width,
        height: a6Height,
        decoration: pw.BoxDecoration(
          border: isBorderVisible
              ? pw.Border.all(color: PdfColors.black, width: 2)
              : pw.Border.all(color: PdfColors.grey, width: 1),
          borderRadius: pw.BorderRadius.circular(15),
        ),
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            // Logo
            pw.ClipOval(
              child: logoImage != null
                  ? pw.Image(
                pw.MemoryImage(
                  File(logoImage!.path).readAsBytesSync(),
                ),
                width: 120,
                height: 120,
              )
                  : pw.Image(pw.MemoryImage(initialLogo!), width: 120, height: 120), // Default logo
            ),
            pw.SizedBox(height: 10),
            // Restaurant Name
            pw.Text(restaurantName, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 30),
            pw.BarcodeWidget(
              barcode: pw.Barcode.qrCode(),
              data: 'hello',
              width: 120,
              height: 120,
            ),
            pw.SizedBox(height: 10),
            // Scan Me Text
            pw.Text(scanMeText, style: pw.TextStyle(fontSize: 18, color: PdfColors.red)),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> loadAssetImageBytes(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }
}
