class UserModel {
  String? id;
  String? profilePic;
  String? name;
  String? about;
  String? email;
  String? city;
  String? status;
  RegistrationDetails? registrationDetails;
  BankDetails? bankDetails;
  String? userId;
  String? phoneNumber;
  String? pricing;
  String? workStartDate;
  String? totalRating;
  String? avgRating;
  int? ratingCount;
  int? consultationDuration;

  UserModel({
    this.id,
    this.profilePic,
    this.name,
    this.about,
    this.email,
    this.city,
    this.status,
    this.registrationDetails,
    this.bankDetails,
    this.userId,
    this.phoneNumber,
    this.pricing,
    this.workStartDate,
    this.totalRating,
    this.avgRating,
    this.ratingCount,
    this.consultationDuration,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profilePic = json['profile_pic'];
    name = json['name'];
    about = json['about'];
    email = json['email'];
    city = json['city'];
    status = json['status'];
    registrationDetails =
        json['registration_details'] != null
            ? new RegistrationDetails.fromJson(json['registration_details'])
            : null;
    bankDetails =
        json['bank_details'] != null
            ? new BankDetails.fromJson(json['bank_details'])
            : null;
    userId = json['user_id'];
    phoneNumber = json['phone_number'];
    pricing = json['pricing'];
    workStartDate = json['work_start_date'];
    totalRating = json['total_rating'];
    avgRating = json['avg_rating'];
    ratingCount = json['rating_count'];
    consultationDuration = json['consultation_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profile_pic'] = this.profilePic;
    data['name'] = this.name;
    data['about'] = this.about;
    data['email'] = this.email;
    data['city'] = this.city;
    data['status'] = this.status;
    if (this.registrationDetails != null) {
      data['registration_details'] = this.registrationDetails!.toJson();
    }
    if (this.bankDetails != null) {
      data['bank_details'] = this.bankDetails!.toJson();
    }
    data['user_id'] = this.userId;
    data['phone_number'] = this.phoneNumber;
    data['pricing'] = this.pricing;
    data['work_start_date'] = this.workStartDate;
    data['total_rating'] = this.totalRating;
    data['avg_rating'] = this.avgRating;
    data['rating_count'] = this.ratingCount;
    data['consultation_duration'] = this.consultationDuration;
    return data;
  }
}

class RegistrationDetails {
  String? councilName;
  String? qualification;
  String? registrationNumber;

  RegistrationDetails({
    this.councilName,
    this.qualification,
    this.registrationNumber,
  });

  RegistrationDetails.fromJson(Map<String, dynamic> json) {
    councilName = json['council_name'];
    qualification = json['qualification'];
    registrationNumber = json['registration_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['council_name'] = this.councilName;
    data['qualification'] = this.qualification;
    data['registration_number'] = this.registrationNumber;
    return data;
  }
}

class BankDetails {
  String? ifsc;
  String? upiId;
  String? bankName;
  String? accountHolder;
  String? accountNumber;

  BankDetails({
    this.ifsc,
    this.upiId,
    this.bankName,
    this.accountHolder,
    this.accountNumber,
  });

  BankDetails.fromJson(Map<String, dynamic> json) {
    ifsc = json['ifsc'];
    upiId = json['upi_id'];
    bankName = json['bank_name'];
    accountHolder = json['account_holder'];
    accountNumber = json['account_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ifsc'] = this.ifsc;
    data['upi_id'] = this.upiId;
    data['bank_name'] = this.bankName;
    data['account_holder'] = this.accountHolder;
    data['account_number'] = this.accountNumber;
    return data;
  }
}
