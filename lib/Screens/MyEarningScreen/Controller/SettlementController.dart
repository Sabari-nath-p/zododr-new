import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:zodo_dr/Utils/apiHandler.dart';

class Settlementcontroller extends GetxController {
  TextEditingController holderNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController upiIDController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController branchController = TextEditingController();

  addBankAccount() async {
    ApiService.request(
      endpoint: "",
      body: {
        "account_number": "565656565",
        "account_holder": "ss",
        "ifsc": "ghgh",
        "bank_name": "dd",
        "upid": "dd",
      },
    );
  }
}
