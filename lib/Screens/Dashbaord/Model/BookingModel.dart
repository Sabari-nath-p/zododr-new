class BookingModel {
  String? id;
  String? bookingId;
  MetaData? metaData;
  String? createdBy;
  String? appointmentDate;
  String? timeSlot;
  String? doctorId;
  String? userId;
  String? childUserId;
  UserDetails? userDetails;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? type;
  String? reason;
  String? amount;
  String? profilePicture;

  BookingModel({
    this.id,
    this.bookingId,
    this.metaData,
    this.createdBy,
    this.appointmentDate,
    this.timeSlot,
    this.doctorId,
    this.userId,
    this.childUserId,
    this.userDetails,
    this.status,
    this.createdAt,
    this.profilePicture,
    this.updatedAt,
    this.type,
    this.reason,
    this.amount,
  });

  BookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    metaData =
        json['meta_data'] != null
            ? new MetaData.fromJson(json['meta_data'])
            : null;
    createdBy = json['created_by'];
    appointmentDate = json['appointmentDate'];
    timeSlot = json['timeSlot'];
    doctorId = json['doctor_id'];
    userId = json['user_id'];
    childUserId = json['child_user_id'];
    userDetails =
        json['user_details'] != null
            ? new UserDetails.fromJson(json['user_details'])
            : null;
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    type = json['type'];
    reason = json['reason'];
    amount = json['amount'];
    profilePicture = json["user"]["profile_picture"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    if (this.metaData != null) {
      data['meta_data'] = this.metaData!.toJson();
    }
    data['created_by'] = this.createdBy;
    data['appointmentDate'] = this.appointmentDate;
    data['timeSlot'] = this.timeSlot;
    data['doctor_id'] = this.doctorId;
    data['user_id'] = this.userId;
    data['child_user_id'] = this.childUserId;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['type'] = this.type;
    data['reason'] = this.reason;
    data['amount'] = this.amount;
    return data;
  }
}

class MetaData {
  int? fee;
  int? total;
  String? currency;
  int? discount;
  String? couponId;
  String? couponCode;
  int? platformFee;

  MetaData({
    this.fee,
    this.total,
    this.currency,
    this.discount,
    this.couponId,
    this.couponCode,
    this.platformFee,
  });

  MetaData.fromJson(Map<String, dynamic> json) {
    fee = json['fee'];
    total = json['total'];
    currency = json['currency'];
    discount = json['discount'];
    couponId = json['coupon_id'];
    couponCode = json['coupon_code'];
    platformFee = json['platform_fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fee'] = this.fee;
    data['total'] = this.total;
    data['currency'] = this.currency;
    data['discount'] = this.discount;
    data['coupon_id'] = this.couponId;
    data['coupon_code'] = this.couponCode;
    data['platform_fee'] = this.platformFee;
    return data;
  }
}

class UserDetails {
  int? age;
  String? name;
  String? gender;

  UserDetails({this.age, this.name, this.gender});

  UserDetails.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    name = json['name'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    data['name'] = this.name;
    data['gender'] = this.gender;
    return data;
  }
}
