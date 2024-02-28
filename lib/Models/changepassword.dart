// ignore_for_file: camel_case_types

class pass {
  String? userId;
  String? oldPassword;
  String? newPassword;
  String? errorMessage;
  int? status;

  pass(
      {this.userId,
      this.oldPassword,
      this.newPassword,
      this.errorMessage,
      this.status});

  pass.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    oldPassword = json['OldPassword'];
    newPassword = json['NewPassword'];
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = userId;
    data['OldPassword'] = oldPassword;
    data['NewPassword'] = newPassword;
    data['ErrorMessage'] = errorMessage;
    data['Status'] = status;
    return data;
  }
}
