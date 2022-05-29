import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hallo_doctor_client/app/models/order_detail_model.dart';
import 'package:hallo_doctor_client/app/utils/constants/constants.dart';
import 'package:hallo_doctor_client/app/utils/constants/style_constants.dart';

import '../controllers/detail_order_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ChosePayment { addCard, creditCard }

class DetailOrderView extends GetView<DetailOrderController> {
  final String assetName = 'assets/icons/powered-by-stripe.svg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail Order'.tr),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi '.tr + controller.username.value,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: mTitleColor),
                    ),
                    Text(
                      'before making a payment, make sure the items below are correct'
                          .tr,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: mSubtitleColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 200,
                      width: double.infinity,
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          detailOrderTable(),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            height: 20,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 30),
                            child: Text(
                              'Total : '.tr +
                                  currencySign +
                                  controller.selectedTimeSlot.price.toString(),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: mTitleColor),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Get.defaultDialog(
                          title: 'Test Mode',
                          content: Text(
                              'This is a testing mode, to make a payment in test mode, please enter the number 42 consecutively in the credit card details, E.g. credit card: 424242424244242'),
                          textConfirm: 'Make Payment With Stripe',
                          onConfirm: () {
                            Get.back();
                            controller.makePayment();
                          },
                        );
                        //
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: secondaryColor,
                        ),
                        child: Text(
                          'Confirm'.tr,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ));
  }

  Widget detailOrderTable() {
    final column = ['Item'.tr, 'Duration'.tr, 'Time'.tr, 'Price'.tr];
    final listOrderItem = [controller.buildOrderDetail()];
    return DataTable(
      columns: getColumn(column),
      rows: getRows(listOrderItem),
      columnSpacing: 5,
    );
  }

  List<DataColumn> getColumn(List<String> column) => column
      .map((e) => DataColumn(
              label: Container(
            child: Text(e),
          )))
      .toList();

  List<DataRow> getRows(List<OrderDetailModel> orderDetailItem) =>
      orderDetailItem.map((e) {
        final cells = [e.itemName, e.duration, e.time, e.price];
        return DataRow(cells: getCells(cells));
      }).toList();
  List<DataCell> getCells(List<dynamic> cells) => cells
      .map((e) => DataCell(Text(
            '$e',
            style: tableCellText,
          )))
      .toList();

  Widget bottomSheetPaymenMethod() {
    return Container(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Choose Payment Method",
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: mTitleColor),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text("CREDIT CARD"),
              trailing: Icon(Icons.add_circle, color: secondaryColor),
              onTap: () {
                controller.makePayment();
              },
            ),
            ListTile(
              title: Text("TEST PAYMENT"),
              trailing: Icon(Icons.credit_card, color: secondaryColor),
              onTap: () {
                //
              },
            ),
            SizedBox(
              height: 30,
            ),
            SvgPicture.asset(
              assetName,
              color: secondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
