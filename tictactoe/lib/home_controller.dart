import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController2 extends GetxController {
  var mlist=[1,2,1,4,2,4].obs;
  var firstVal="";


  var sroce=0;
  Future<void> restartGame() async {
    mlist.clear();
    mlist.addAll([1,2,1,4,2,4]);
  }

  void checkCorrectAnswer(data) {
    if (firstVal == "") {
      firstVal=data;
    }
    else {
      if (firstVal != data) {
        Get.snackbar("Status", "Fail", );
      } else {
        firstVal="";
        Get.snackbar("Status", "Success", );
        sroce++;
      }
    }
    mlist.removeWhere((element) => element == data);

  }
}

class HomeController1 extends GetxController {
  List<int> mlist = [1,2,3,4,5,6,7,8,9,0].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> restartGame() async {
    mlist.clear();
    mlist.addAll([1,2,3,4,5,6,7,8,9,0]);

  }

  void checkCorrectAnswer(data, int acceptType) {
    if (data % 2 == 0) {
      if (acceptType == 1) {
        Get.snackbar("Status", "Success", backgroundColor: Colors.green);
      } else {
        Get.snackbar("Status", "Fail", backgroundColor: Colors.red);
      }
    } else {
      if (acceptType == 1) {
        Get.snackbar("Status", "Fail", backgroundColor: Colors.red);
      } else {
        Get.snackbar("Status", "Success", backgroundColor: Colors.green);
      }
    }
    mlist.removeWhere((element) => element == data);
  }


}

class HomeController extends GetxController {
  List<String> mlist = ["", "", "", "", "", "", "", "", ""].obs;
  var nowin = true.obs;
  var yourturn = true.obs;
  var count = 0.obs;
  var countX = 0.obs;
  var countO = 0.obs;
  var yourSign="X";
  var robortSign="O";
  var winX="Congrats to X".obs;
  var winO="Congrats to O".obs;


  Future<void> restartGame() async {
    await Future.delayed(Duration(seconds: 2),(){
      count.value = 0;
      mlist.clear();
      mlist.addAll(["", "", "", "", "", "", "", "", ""]);
    });

  }

  void checkCorrectAnswer(data, int acceptType) {
    if (data % 2 == 0) {
      if (acceptType == 1) {
        Get.snackbar("Status", "Success", backgroundColor: Colors.green);
      } else {
        Get.snackbar("Status", "Fail", backgroundColor: Colors.red);
      }
    } else {
      if (acceptType == 1) {
        Get.snackbar("Status", "Fail", backgroundColor: Colors.red);
      } else {
        Get.snackbar("Status", "Success", backgroundColor: Colors.green);
      }
    }
    mlist.removeWhere((element) => element == data);
  }

  Future<void> user(index) async {
    if (yourturn.value) {
      if (mlist[index] == "") {
        mlist[index] = yourSign;
        count++;
        checkWinner1();

      }
    }
    // else {
    //   if (mlist[index] == "") {
    //     mlist[index] = robortSign;
    //     yourturn.value = !yourturn.value;
    //     count++;
    //   }
    // }

  }

  robort(){
    var n=Random().nextInt(mlist.length-1);
    if(mlist[n]==""){
      mlist[n]=robortSign;
      yourturn.value = !yourturn.value;
      count++;
      checkWinner();

    }
    else
      robort();

  }

  checkWinner1(){
    if (mlist[0] == yourSign && mlist[1] == yourSign && mlist[2] == yourSign ||
        mlist[0] == robortSign && mlist[1] == robortSign && mlist[2] == robortSign) {
      Get.snackbar("Winner", yourturn.value?winX.toString():winO.toString());
       if(yourturn.value)
        countX++;
      else
        countO++;
      restartGame();
    }
    else if (mlist[3] == yourSign && mlist[4] == yourSign && mlist[5] == yourSign ||
        mlist[3] == robortSign && mlist[4] == robortSign && mlist[5] == robortSign) {
       Get.snackbar("Winner", yourturn.value?winX.toString():winO.toString());
       if(yourturn.value)
         countX++;
       else
         countO++;
       restartGame();
    }
    else if (mlist[6] == yourSign && mlist[7] == yourSign && mlist[8] == yourSign ||
        mlist[6] == robortSign && mlist[7] == robortSign && mlist[8] == robortSign) {
       Get.snackbar("Winner", yourturn.value?winX.toString():winO.toString());
        if(yourturn.value)
         countX++;
       else
         countO++;
       restartGame();
    }
    else if (mlist[0] == yourSign && mlist[3] == yourSign && mlist[6] == yourSign ||
        mlist[0] == robortSign && mlist[3] == robortSign && mlist[6] == robortSign) {
       Get.snackbar("Winner", yourturn.value?winX.toString():winO.toString());
        if(yourturn.value)
         countX++;
       else
         countO++;
       restartGame();
    }
    else if (mlist[1] == yourSign && mlist[4] == yourSign && mlist[7] == yourSign ||
        mlist[1] == robortSign && mlist[4] == robortSign && mlist[7] == robortSign) {
       Get.snackbar("Winner", yourturn.value?winX.toString():winO.toString());
        if(yourturn.value)
         countX++;
       else
         countO++;
       restartGame();
    }
    else if (mlist[2] == yourSign && mlist[5] == yourSign && mlist[8] == yourSign ||
        mlist[2] == robortSign && mlist[5] == robortSign && mlist[8] == robortSign) {
       Get.snackbar("Winner", yourturn.value?winX.toString():winO.toString());
        if(yourturn.value)
         countX++;
       else
         countO++;
       restartGame();
    }
    else if (mlist[0] == yourSign && mlist[4] == yourSign && mlist[8] == yourSign ||
        mlist[0] == robortSign && mlist[4] == robortSign && mlist[8] == robortSign) {
       Get.snackbar("Winner", yourturn.value?winX.toString():winO.toString());
        if(yourturn.value)
         countX++;
       else
         countO++;
       restartGame();
    }
    else if (mlist[2] == yourSign && mlist[4] == yourSign && mlist[6] == yourSign ||
        mlist[2] == robortSign && mlist[4] == robortSign && mlist[6] == robortSign) {
       Get.snackbar("Winner", yourturn.value?winX.toString():winO.toString());
        if(yourturn.value)
         countX++;
       else
         countO++;
       restartGame();
    }
    else if (count == mlist.length) {
      Get.snackbar("Oops", "Its A Draw");
    }
    else{
      yourturn.value = !yourturn.value;
      robort();
    }

  }

  checkWinner(){
    if (mlist[0] == yourSign && mlist[1] == yourSign && mlist[2] == yourSign ||
        mlist[0] == robortSign && mlist[1] == robortSign && mlist[2] == robortSign) {
      Get.snackbar("Winner", !yourturn.value?winX.toString():winO.toString());
      if(yourturn.value!=true)
        countX++;
      else
        countO++;
      restartGame();
    }
    else if (mlist[3] == yourSign && mlist[4] == yourSign && mlist[5] == yourSign ||
        mlist[3] == robortSign && mlist[4] == robortSign && mlist[5] == robortSign) {
      Get.snackbar("Winner", !yourturn.value?winX.toString():winO.toString());
      if(yourturn.value!=true)
        countX++;
      else
        countO++;
      restartGame();
    }
    else if (mlist[6] == yourSign && mlist[7] == yourSign && mlist[8] == yourSign ||
        mlist[6] == robortSign && mlist[7] == robortSign && mlist[8] == robortSign) {
      Get.snackbar("Winner", !yourturn.value?winX.toString():winO.toString());
      if(yourturn.value!=true)
        countX++;
      else
        countO++;
      restartGame();
    }
    else if (mlist[0] == yourSign && mlist[3] == yourSign && mlist[6] == yourSign ||
        mlist[0] == robortSign && mlist[3] == robortSign && mlist[6] == robortSign) {
      Get.snackbar("Winner", !yourturn.value?winX.toString():winO.toString());
      if(yourturn.value!=true)
        countX++;
      else
        countO++;
      restartGame();
    }
    else if (mlist[1] == yourSign && mlist[4] == yourSign && mlist[7] == yourSign ||
        mlist[1] == robortSign && mlist[4] == robortSign && mlist[7] == robortSign) {
      Get.snackbar("Winner", !yourturn.value?winX.toString():winO.toString());
      if(yourturn.value!=true)
        countX++;
      else
        countO++;
      restartGame();
    }
    else if (mlist[2] == yourSign && mlist[5] == yourSign && mlist[8] == yourSign ||
        mlist[2] == robortSign && mlist[5] == robortSign && mlist[8] == robortSign) {
      Get.snackbar("Winner", !yourturn.value?winX.toString():winO.toString());
      if(yourturn.value!=true)
        countX++;
      else
        countO++;
      restartGame();
    }
    else if (mlist[0] == yourSign && mlist[4] == yourSign && mlist[8] == yourSign ||
        mlist[0] == robortSign && mlist[4] == robortSign && mlist[8] == robortSign) {
      Get.snackbar("Winner", !yourturn.value?winX.toString():winO.toString());
      if(yourturn.value!=true)
        countX++;
      else
        countO++;
      restartGame();
    }
    else if (mlist[2] == yourSign && mlist[4] == yourSign && mlist[6] == yourSign ||
        mlist[2] == robortSign && mlist[4] == robortSign && mlist[6] == robortSign) {
      Get.snackbar("Winner", !yourturn.value?winX.toString():winO.toString());
      if(yourturn.value!=true)
        countX++;
      else
        countO++;
      restartGame();
    }
    else if (count == mlist.length) {
      Get.snackbar("Oops", "Its A Draw");
    }

  }

}
