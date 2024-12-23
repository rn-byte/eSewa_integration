import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:esewa_integration/constant/constant.dart';
import 'package:flutter/material.dart';

class Esewa {
  void pay(String productId, String productName, String productPrice) {
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
