import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:testing/screen/camera_screen.dart';
import 'package:testing/utils/general.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final GlobalKey qrKey = GlobalKey(debugLabel: "QR");

class _HomeScreenState extends State<HomeScreen> {
  String result = "No Result";
  TextEditingController ctrlTxtBarcode = TextEditingController();
  late QRViewController ctrlQr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    ctrlTxtBarcode.dispose();
    ctrlQr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Utils"),
        centerTitle: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: ctrlTxtBarcode,
              decoration: InputDecoration(
                  hintText: "Barcode",
                  prefixIcon: const Icon(Icons.qr_code_scanner),
                  suffixIcon: InkWell(
                      onTap: scanForBarcode,
                      child: const Icon(Icons.qr_code_scanner))),
            ),
            ElevatedButton(
                onPressed: getLatLong, child: const Text("Get Lat Long")),
            ElevatedButton(
                onPressed: goToCameraScreen, child: const Text("Take Picture")),
            SizedBox(
                height: 200,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: qrViewCreated,
                )),
            Text(result)
          ]),
    );
  }

  void scanForBarcode() async {
    String result = await FlutterBarcodeScanner.scanBarcode(
        "#55cc55", "Cancel", true, ScanMode.BARCODE);
    if (result == "-1") return;

    ctrlTxtBarcode.text = result;
    setState(() {});
  }

  void qrViewCreated(QRViewController ctrl) {
    ctrlQr = ctrl;
    ctrl.scannedDataStream.listen((event) {
      result += event.code ?? "null";
      setState(() {});
    });
  }

  void getLatLong() async {
    try {
      var pos = await General.determinePosition();
      result = "${pos.latitude.toString()}, ${pos.longitude.toString()}";
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void goToCameraScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const CameraScreen()));
  }
}
