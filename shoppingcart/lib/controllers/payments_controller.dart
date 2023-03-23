import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:shoppingcart/constants/app_constants.dart';
import 'package:shoppingcart/constants/controllers.dart';
import 'package:shoppingcart/constants/firebase.dart';
import 'package:shoppingcart/models/payments.dart';
import 'package:shoppingcart/screens/payments/payments.dart';
import 'package:shoppingcart/utils/helpers/showLoading.dart';
import 'package:shoppingcart/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

class PaymentsController extends GetxController {
  static PaymentsController instance = Get.find();
  String collection = "payments";
  String url =
      'https://us-central1-sneex-cbc6a.cloudfunctions.net/createPaymentIntent';
  List<PaymentsModel> payments = [];

  @override
  void onReady() {
    super.onReady();
    StripePayment.setOptions(StripeOptions(
        publishableKey: "pk_test_51JVZd8SI7QAlNpadO5JR5EB2mNa78wy8HgAK9vsE80uAGy2HsdWrC9uQSLhHd0sGLvFW8SsYMvNcgO7iGVXkgjhT002UgQwDV2",
        androidPayMode: 'test'));
  }




  Future<void> createPaymentMethod() async {
    StripePayment.setStripeAccount(null);
    //step 1: add card
    PaymentMethod paymentMethod = PaymentMethod();
    paymentMethod = await StripePayment.paymentRequestWithCardForm(
      CardFormPaymentRequest(),
    ).then((PaymentMethod paymentMethod) {
      return paymentMethod;
    }).catchError((e) {
      print('Error Card: ${e.toString()}');
    });
    paymentMethod != null
        ? processPaymentAsDirectCharge(paymentMethod)
        : _showPaymentFailedAlert();
    dismissLoadingWidget();
  }

  Future<void> processPaymentAsDirectCharge(PaymentMethod paymentMethod) async {
    showLoading();

    int amount = (double.parse(cartController.totalCartPrice.value.toStringAsFixed(2)) * 100).toInt();
    //step 2: request to create PaymentIntent, attempt to confirm the payment & return PaymentIntent
    final response = await Dio()
        .post('$url?amount=$amount&currency=USD&pm_id=${paymentMethod.id}');
    print('Now i decode');
    if (response.data != null && response.data != 'error') {
      final paymentIntentX = response.data;
      final status = paymentIntentX['paymentIntent']['status'];
      if (status == 'succeeded') {
        StripePayment.completeNativePayRequest();
        _addToCollection(paymentStatus: status, paymentId: paymentMethod.id);
        userController.updateUserData({"cart": []});
        Get.snackbar("Success", "Payment succeeded");
      }else{
        _addToCollection(paymentStatus: status, paymentId: paymentMethod.id);
      }
    } else {
      //case A
      StripePayment.cancelNativePayRequest();
      _showPaymentFailedAlert();
    }
  }

  void _showPaymentFailedAlert() {
    Get.defaultDialog(
        content: CustomText(
          text: "Payment failed, try another card",
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: "Okay",
                ),
              ))
        ]);
  }

  _addToCollection({String paymentStatus, String paymentId}){
    String id = Uuid().v1();
    firebaseFirestore.collection(collection).doc(id).set({
      "id": id,
      "clientId": userController.userModel.value.id,
      "status": paymentStatus,
      "paymentId": paymentId,
      "cart": userController.userModel.value.cartItemsToJson(),
      "amount": cartController.totalCartPrice.value.toStringAsFixed(2),
      "createdAt": DateTime.now().microsecondsSinceEpoch,
    });
  }

  getPaymentHistory() {
    showLoading();
    payments.clear();
    firebaseFirestore
        .collection(collection)
        .where("clientId", isEqualTo: userController.userModel.value.id)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        PaymentsModel payment = PaymentsModel.fromMap(doc.data());
        payments.add(payment);
      });

      logger.i("length ${payments.length}");
      dismissLoadingWidget();
      Get.to(() => PaymentsScreen());
    });
  }
}
