import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zodo_dr/Utils/apiHandler.dart';
import 'package:zodo_dr/Utils/CustomAlerts.dart';
import 'package:zodo_dr/Utils/UtilsController.dart';

class Settlementcontroller extends GetxController {
  // Add Bank form controllers
  TextEditingController holderNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController upiIDController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController branchController = TextEditingController();

  // Withdraw form controller
  TextEditingController withdrawAmountController = TextEditingController();

  // Wallet state
  RxBool isWalletLoading = false.obs;
  RxString balanceAmount = "0".obs;
  RxString totalAmount = "0".obs;
  RxString withdrawalAmount = "0".obs;
  RxString requestedAmount = "0".obs;

  // NOTE: No "Last Settlement" field exists in the wallet API response.
  
  RxString lastSettlement = "0".obs;

  // Bank state (read from doctor profile, not a separate API)
  RxBool hasBankDetails = false.obs;

  // Action loading flags
  RxBool isBankSubmitting = false.obs;
  RxBool isWithdrawSubmitting = false.obs;

  Utilscontroller get _utils => Get.find<Utilscontroller>();

  String? get doctorId => _utils.user?.id;

  @override
  void onInit() {
    super.onInit();
    fetchWallet();
    loadExistingBankDetails();
  }

  // ---------------------------------------------------------
  // WALLET
  // ---------------------------------------------------------
  fetchWallet() async {
    if (doctorId == null) return;
    isWalletLoading.value = true;

    await ApiService.request(
      endpoint: "wallet/doctors/$doctorId",
      method: Api.GET,
      onSuccess: (data) {
        final wallet = data.data["data"];
        if (wallet != null) {
          balanceAmount.value = wallet["balance_amount"]?.toString() ?? "0";
          totalAmount.value = wallet["total_amount"]?.toString() ?? "0";
          withdrawalAmount.value =
              wallet["withdrawal_amount"]?.toString() ?? "0";
          requestedAmount.value =
              wallet["requested_amount"]?.toString() ?? "0";
        }
      },
      onError: (e) {
        Customalerts.errorAlert(
          title: "Failed to load wallet",
          body: "Please try again.",
        );
      },
    );

    isWalletLoading.value = false;
  }

  // ---------------------------------------------------------
  // BANK DETAILS — pre-fill check (Add vs Update UI decision)
  // ---------------------------------------------------------
  loadExistingBankDetails() {
    final bankDetails = _utils.user?.bankDetails;

    if (bankDetails != null &&
        (bankDetails.accountNumber?.isNotEmpty ?? false)) {
      hasBankDetails.value = true;
      holderNameController.text = bankDetails.accountHolder ?? "";
      accountNumberController.text = bankDetails.accountNumber ?? "";
      ifscController.text = bankDetails.ifsc ?? "";
      bankNameController.text = bankDetails.bankName ?? "";
      upiIDController.text = bankDetails.upiId ?? "";
    } else {
      hasBankDetails.value = false;
    }
  }

  // ---------------------------------------------------------
  // ADD / UPDATE BANK ACCOUNT — same endpoint for both cases
  // ---------------------------------------------------------
  addBankAccount() async {
    if (doctorId == null) return;

    if (holderNameController.text.trim().isEmpty ||
        accountNumberController.text.trim().isEmpty ||
        ifscController.text.trim().isEmpty ||
        bankNameController.text.trim().isEmpty) {
      Customalerts.errorAlert(
        title: "Missing Details",
        body: "Please fill all required bank fields.",
      );
      return;
    }

    isBankSubmitting.value = true;

    await ApiService.request(
      endpoint: "doctors/$doctorId",
      method: Api.PATCH,
      body: {
        "id": doctorId,
        "bank_details": {
          "ifsc": ifscController.text.trim(),
          "upi_id": upiIDController.text.trim(),
          "bank_name": bankNameController.text.trim(),
          "account_holder": holderNameController.text.trim(),
          "account_number": accountNumberController.text.trim(),
          // NOTE: branchController is collected in UI but there is no
          // "branch" field in the confirmed bank_details schema.
          
        },
      },
      onSuccess: (data) {
        final bool bodyStatus = data.data["status"] == true;

        if (bodyStatus) {
          Customalerts.successAlert(
            title: hasBankDetails.value
                ? "Bank Account Updated"
                : "Bank Account Added",
            body: "Your bank details have been saved successfully.",
          );
          hasBankDetails.value = true;
          _utils.fetchUser(); // refresh local profile
          Get.back();
        } else {
          Customalerts.errorAlert(
            title: "Failed",
            body: data.data["message"] ?? "Could not save bank details.",
          );
        }
      },
      onError: (e) {
        Customalerts.errorAlert(
          title: "Failed",
          body: "Could not save bank details. Please try again.",
        );
      },
    );

    isBankSubmitting.value = false;
  }

  // ---------------------------------------------------------
  // WITHDRAW / CREATE SETTLEMENT
  
  // ---------------------------------------------------------
  createSettlement() async {
    if (doctorId == null) return;

    final amountText = withdrawAmountController.text.trim();
    if (amountText.isEmpty) {
      Customalerts.errorAlert(
        title: "Amount Required",
        body: "Please enter an amount to withdraw.",
      );
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      Customalerts.errorAlert(
        title: "Invalid Amount",
        body: "Please enter a valid amount.",
      );
      return;
    }

    final balance = double.tryParse(balanceAmount.value) ?? 0;
    if (amount > balance) {
      Customalerts.errorAlert(
        title: "Insufficient Balance",
        body: "Withdrawal amount cannot exceed your main balance.",
      );
      return;
    }

    isWithdrawSubmitting.value = true;

    await ApiService.request(
      endpoint: "settlements",
      method: Api.POST,
      body: {
        "doctor_id": doctorId,
        "amount": amount,
        // Hardcoded — no UPI/Bank selector UI exists on Withdraw screen.
        "payment_method": "bank_transfer",
        "note": "",
      },
      onSuccess: (data) {
        // HTTP was 200-299, but we must still check the body's own status
        final bool bodyStatus = data.data["status"] == true;

        if (bodyStatus) {
          Customalerts.successAlert(
            title: "Withdrawal Requested",
            body: "Your withdrawal request has been submitted successfully.",
          );
          withdrawAmountController.clear();
          fetchWallet();
          Get.back(); // only close screen on genuine success
        } else {
          Customalerts.errorAlert(
            title: "Failed",
            body:
                data.data["message"] ??
                "Something went wrong. Please try again.",
          );
          // stay on screen so user can retry
        }
      },
      onError: (e) {
        Customalerts.errorAlert(
          title: "Failed",
          body: "Could not submit withdrawal request. Please try again.",
        );
      },
    );

    isWithdrawSubmitting.value = false;
  }
}