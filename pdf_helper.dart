// // TODO: needs to be refactored
// import 'dart:developer';
// import 'dart:io';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:open_filex/open_filex.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';

// import '../model/order_model.dart';
// import '../model/receipt_item_model.dart';
// import '../model/transaction_model.dart';
// import '../view/app_constants/app_images.dart';

// Future<void> buildOrderInvoice(
//   BuildContext context,
//   List<ReceiptItem> dataList,
//   OrderModel order,
// ) async {
//   try {
//     await _checkStoragePermissions();

//     String appDocPath = await _getAppDocPath();

//     log(appDocPath);
//     // throw 'Test';

//     // Create a new PDF document.
//     final PdfDocument document = PdfDocument();
//     // Add a new page to the document.
//     final PdfPage page = document.pages.add();

//     Uint8List fontFile = await _loadPdfFonts();

//     final PdfFont generalFont =
//         PdfTrueTypeFont(fontFile, 12, style: PdfFontStyle.bold);

//     // Add logo on top of the page
//     await _buildPdfHeaderLogo(page);

//     // Create a PDF grid class to add tables.
//     final PdfGrid grid = PdfGrid();
//     // Specify the grid column count.
//     grid.columns.add(count: 6);
//     // Add a grid header row.
//     final PdfGridRow headerRow = grid.headers.add(1)[0];
//     headerRow.cells[0].value = 'Sr. No.';
//     headerRow.cells[1].value = 'Product';
//     headerRow.cells[2].value = 'Quantity';
//     headerRow.cells[3].value = 'Price €'; // Add euro sign to price field
//     headerRow.cells[4].value = 'Discount %';
//     headerRow.cells[5].value = 'Total €'; // Add euro sign to total field
//     // Set header font.
//     headerRow.style.font = generalFont;
//     // Add rows to the grid.

//     int count = 0;
//     for (ReceiptItem item in dataList) {
//       final PdfGridRow row = grid.rows.add();
//       count++;
//       row.cells[0].value = count.toString();
//       row.cells[1].value = item.name;
//       row.cells[2].value = item.quantity.toString();
//       row.cells[3].value =
//           item.price.toStringAsFixed(2); // Add euro sign to price field
//       row.cells[4].value = item.discountPercentage.toString();
//       row.cells[5].value =
//           item.total.toStringAsFixed(2); // Add euro sign to total field
//     }

//     // Set grid format.
//     grid.style.cellPadding = PdfPaddings(left: 5, top: 5);

//     // Add receipt heading
//     final (Size textSize, double y) =
//         await _paintHeading('Order Receipt', page: page, fontFile: fontFile);

//     final (Size dateSize, double dateY) =
//         await _paintDate(page, y, textSize, generalFont, grid);

//     final double total = order.totalAmount;
//     final double tax = order.tax;
//     final double subTotal = order.subtotal;
//     final double tip = order.tip;

//     // Add tax
//     final PdfStringFormat totalFormat = PdfStringFormat(
//         alignment: PdfTextAlignment.right,
//         lineAlignment: PdfVerticalAlignment.middle);
//     final String taxText =
//         'VAT: € ${tax.toStringAsFixed(2)}'; // Add euro sign to tax field
//     final Size taxSize =
//         generalFont.measureString(taxText, format: totalFormat);
//     final PdfTextElement taxElement = PdfTextElement(
//         text: taxText,
//         font: generalFont,
//         brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//         format: totalFormat);
//     final double taxX = page.getClientSize().width - taxSize.width;
//     final double taxY =
//         dateY + dateSize.height + 10 + (grid.rows.count * 20) + 40;
//     final Rect taxRect =
//         Rect.fromLTWH(taxX, taxY, taxSize.width, taxSize.height);
//     taxElement.draw(page: page, bounds: taxRect);

//     // Add tip
//     final String tipText =
//         'Tip: € ${tip.toStringAsFixed(2)}'; // Add euro sign to tip field
//     final Size tipSize =
//         generalFont.measureString(tipText, format: totalFormat);
//     final PdfTextElement tipElement = PdfTextElement(
//         text: tipText,
//         font: generalFont,
//         brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//         format: totalFormat);
//     final double tipX = page.getClientSize().width - tipSize.width;
//     final double tipY = taxY + taxSize.height + 10;
//     final Rect tipRect =
//         Rect.fromLTWH(tipX, tipY, tipSize.width, tipSize.height);
//     tipElement.draw(page: page, bounds: tipRect);

//     // Add subtotal and total
//     final String subtotalText =
//         'Subtotal: € ${subTotal.toStringAsFixed(2)}'; // Add euro sign to subtotal field
//     final Size subtotalSize =
//         generalFont.measureString(subtotalText, format: totalFormat);

//     final PdfTextElement subtotalElement = PdfTextElement(
//         text: subtotalText,
//         font: generalFont,
//         brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//         format: totalFormat);
//     final double subtotalX = page.getClientSize().width - subtotalSize.width;
//     final double subtotalY = tipY + tipSize.height + 10;
//     final Rect subtotalRect = Rect.fromLTWH(
//         subtotalX, subtotalY, subtotalSize.width, subtotalSize.height);
//     subtotalElement.draw(page: page, bounds: subtotalRect);

//     final String totalText =
//         'Total: € ${total.toStringAsFixed(2)}'; // Add euro sign to total field
//     final Size totalSize =
//         generalFont.measureString(totalText, format: totalFormat);
//     final PdfTextElement totalElement = PdfTextElement(
//         text: totalText,
//         font: generalFont,
//         brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//         format: totalFormat);
//     final double totalX = page.getClientSize().width - totalSize.width;
//     final double totalY = subtotalY + subtotalSize.height + 10;
//     final Rect totalRect =
//         Rect.fromLTWH(totalX, totalY, totalSize.width, totalSize.height);
//     totalElement.draw(page: page, bounds: totalRect);

//     // Save the document.
//     String path = await _saveDocument(document, appDocPath);

//     //Open the PDF document in mobile
//     await _openPdfFile(path, document, context);
//   } catch (e) {
//     log(e.toString());
//     rethrow;
//   }
// }

// Future<void> buildPaymentInvoice(
//     BuildContext context, TransactionModel transaction,
//     {bool isPayLink = false}) async {
//   try {
//     await _checkStoragePermissions();

//     String appDocPath = await _getAppDocPath();

//     log(appDocPath);
//     // throw 'Test';

//     // Create a new PDF document.
//     final PdfDocument document = PdfDocument();
//     // Add a new page to the document.
//     final PdfPage page = document.pages.add();

//     Uint8List fontFile = await _loadPdfFonts();

//     final PdfFont generalFont =
//         PdfTrueTypeFont(fontFile, 12, style: PdfFontStyle.bold);

//     await _buildPdfHeaderLogo(page);

//     // Add receipt heading
//     final (Size textSize, double y) = await _paintHeading(
//         isPayLink ? 'PayLink Receipt' : 'Till Number Payment',
//         page: page,
//         fontFile: fontFile);

//     final (Size dateSize, double dateY) =
//         await _paintDate(page, y, textSize, generalFont, PdfGrid());

//     final double total = transaction.amount;
//     final double tax = transaction.tax;

//     //paint transaction details

//     final String shopName = '${'shopName'.tr()}: ${transaction.shopName}';
//     final Size shopNameSize =
//         generalFont.measureString(shopName, format: PdfStringFormat());
//     final PdfTextElement shopNameElement = PdfTextElement(
//         text: shopName,
//         font: generalFont,
//         brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//         format: PdfStringFormat());
//     final double shopNameX =
//         (page.getClientSize().width - shopNameSize.width) / 2;
//     final double shopNameY = dateY + dateSize.height + 10 + 40;
//     final Rect shopNameRect = Rect.fromLTWH(
//         shopNameX, shopNameY, shopNameSize.width, shopNameSize.height);
//     shopNameElement.draw(page: page, bounds: shopNameRect);

//     // Add tax
//     final PdfStringFormat totalFormat = PdfStringFormat(
//         alignment: PdfTextAlignment.center,
//         lineAlignment: PdfVerticalAlignment.middle);
//     final String taxText =
//         'VAT: € ${tax.toStringAsFixed(2)}'; // Add euro sign to tax field
//     final Size taxSize =
//         generalFont.measureString(taxText, format: totalFormat);
//     final PdfTextElement taxElement = PdfTextElement(
//         text: taxText,
//         font: generalFont,
//         brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//         format: totalFormat);
//     final double taxX = (page.getClientSize().width - taxSize.width) / 2;
//     final double taxY = shopNameY + shopNameSize.height + 10;
//     final Rect taxRect =
//         Rect.fromLTWH(taxX, taxY, taxSize.width, taxSize.height);
//     taxElement.draw(page: page, bounds: taxRect);

//     // Add total
//     final String totalText =
//         'Total: € ${total.toStringAsFixed(2)}'; // Add euro sign to total field
//     final Size totalSize =
//         generalFont.measureString(totalText, format: totalFormat);
//     final PdfTextElement totalElement = PdfTextElement(
//         text: totalText,
//         font: generalFont,
//         brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//         format: totalFormat);
//     final double totalX = (page.getClientSize().width - totalSize.width) / 2;
//     final double totalY = taxY + taxSize.height + 10;
//     final Rect totalRect =
//         Rect.fromLTWH(totalX, totalY, totalSize.width, totalSize.height);
//     totalElement.draw(page: page, bounds: totalRect);

//     // Save the document.
//     String path = await _saveDocument(document, appDocPath);

//     //Open the PDF document in mobile
//     await _openPdfFile(path, document, context);

//     // Add date below receipt heading
//   } catch (e) {
//     log(e.toString());
//     rethrow;
//   }
// }

// Future<String> _saveDocument(PdfDocument document, String appDocPath) async {
//   final List<int> documentData = await document.save();
//   final String path =
//       '$appDocPath/${DateTime.now().millisecondsSinceEpoch}.pdf';
//   await File(path).writeAsBytes(documentData);
//   return path;
// }

// Future<(Size dateSize, double dateY)> _paintDate(
//   PdfPage page,
//   double y,
//   Size textSize,
//   PdfFont generalFont,
//   PdfGrid grid,
// ) async {
//   // Add date below receipt heading
//   final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm a');
//   final String formattedDate = formatter.format(DateTime.now());
//   final PdfStringFormat dateFormat = PdfStringFormat(
//       alignment: PdfTextAlignment.center,
//       lineAlignment: PdfVerticalAlignment.middle);
//   final String dateText = 'Date: $formattedDate';
//   final Size dateSize = generalFont.measureString(dateText, format: dateFormat);
//   final PdfTextElement dateElement = PdfTextElement(
//       text: dateText,
//       font: generalFont,
//       brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//       format: dateFormat);
//   final double dateX = (page.getClientSize().width - dateSize.width) / 2;
//   final double dateY = y + textSize.height + 10;
//   final Rect dateRect =
//       Rect.fromLTWH(dateX, dateY, dateSize.width, dateSize.height);
//   dateElement.draw(page: page, bounds: dateRect);

//   // Draw table in the PDF page.
//   grid.draw(
//       page: page,
//       bounds: Rect.fromLTWH(0, dateY + dateSize.height + 10,
//           page.getClientSize().width, page.getClientSize().height));

//   return (dateSize, dateY);
// }

// Future<void> _buildPdfHeaderLogo(PdfPage page) async {
//   final PdfGraphics graphics = page.graphics;
//   final Uint8List logoData =
//       (await rootBundle.load(AppImages.logo)).buffer.asUint8List();
//   final PdfBitmap logo = PdfBitmap(logoData);
//   graphics.drawImage(
//     logo,
//     Rect.fromLTWH(0, 0, page.getClientSize().width * 0.5, 100),
//   );
// }

// Future<(Size textSize, double y)> _paintHeading(
//   String title, {
//   required PdfPage page,
//   required Uint8List fontFile,
// }) async {
//   final PdfFont font = PdfTrueTypeFont(fontFile, 20, style: PdfFontStyle.bold);
//   final PdfStringFormat format = PdfStringFormat(
//       alignment: PdfTextAlignment.center,
//       lineAlignment: PdfVerticalAlignment.middle);
//   final String receiptHeading = title;
//   final Size textSize = font.measureString(receiptHeading, format: format);
//   final PdfTextElement textElement = PdfTextElement(
//     text: receiptHeading,
//     font: font,
//     brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//     format: format,
//     // stringFormat: format,
//   );
//   final double x = (page.getClientSize().width - textSize.width) / 2;
//   final double y = 110; // Adjust as needed
//   final Rect rect = Rect.fromLTWH(x, y, textSize.width, textSize.height);
//   textElement.draw(page: page, bounds: rect);

//   return (textSize, y);
// }

// Future<Uint8List> _loadPdfFonts() async {
//   final Uint8List fontFile =
//       (await rootBundle.load('assets/fonts/Poppins-Regular.ttf'))
//           .buffer
//           .asUint8List();
//   return fontFile;
// }

// Future<void> _checkStoragePermissions() async {
//   final PermissionStatus permissionStatus = await Permission.storage.request();

//   if (!kDebugMode) {
//     if (permissionStatus != PermissionStatus.granted) {
//       throw 'storagePermissionDenied'.tr();
//     }
//   }
// }

// Future<String> _getAppDocPath() async {
//   Directory appDocDir = Platform.isAndroid
//       ? await getExternalStorageDirectory() ??
//           await getApplicationDocumentsDirectory()
//       : await getApplicationDocumentsDirectory();
//   String appDocPath = appDocDir.path;
//   return appDocPath;
// }

// Future<void> _openPdfFile(
//     String path, PdfDocument document, BuildContext context) async {
//   try {
//     await OpenFilex.open(path);
//   } catch (e) {}
//   document.dispose();
// }
