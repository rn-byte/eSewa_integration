import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:esewa_integration/constant/constant.dart';
import 'package:flutter/material.dart';

class Esewa {
  void pay(String productId, String productName, String productPrice,
      BuildContext ctx) {
    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: kClientId,
          secretId: kSecretKey,
        ),
        esewaPayment: EsewaPayment(
            productId: productId,
            productName: productName,
            productPrice: productPrice,
            callbackUrl: 'www.prstore.com'),
        onPaymentSuccess: (EsewaPaymentSuccessResult data) {
          /// Toast message
          // Fluttertoast.showToast(
          //   msg: "Payment Successful: Transaction ID - ${data.refId}",
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.BOTTOM,
          //   backgroundColor: Colors.green,
          //   textColor: Colors.white,
          //   fontSize: 16.0,
          // );

          /// Alert Dialog
          showDialog(
            context: ctx, // Replace with your context
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Payment Successful"),
                content: Text(
                    "Transaction ID: ${data.refId} \nProduct Naem: ${data.productName}\n Product Id: ${data.productId}\n Payment Status:${data.status}\n Total amount: ${data.totalAmount}"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
          debugPrint(":::SUCCESS::: => $data");

          verifyTransactionStatus(data);
        },
        onPaymentFailure: (data) {
          debugPrint(":::FAILURE::: => $data");
        },
        onPaymentCancellation: (data) {
          debugPrint(":::CANCELLATION::: => $data");
        },
      );
    } on Exception catch (e) {
      debugPrint("EXCEPTION : ${e.toString()}");
    }
  }

  void verifyTransactionStatus(EsewaPaymentSuccessResult result) async {
    // var response = await callVerificationApi(result);
    // if (response.statusCode == 200) {
    //   var map = {'data': response.data};
    //   final sucResponse = EsewaPaymentSuccessResponse.fromJson(map);
    //   debugPrint("Response Code => ${sucResponse.data}");
    //   if (sucResponse.data[0].transactionDetails.status == 'COMPLETE') {
    //     //TODO Handle Txn Verification Success
    //     return;
    //   }
    //   //TODO Handle Txn Verification Failure
    // } else {
    //   //TODO Handle Txn Verification Failure
    // }
  }
}
