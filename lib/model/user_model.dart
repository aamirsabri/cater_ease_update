import 'package:cater_ease/app/constants.dart';


class User {
  int userId;
  String password;
  String? mobileNo;
  int? companyId;
  String empName;
  String? empId;
  String? locationCode;
  String? locationName;
  String? userType;
  String? userLevel;
  String? defaultCheckInTime;
  String? designation;
  int? admin1;
  int? admin2;
  double? totalLeave;
  double? leaveBalance;

  User(
      {required this.userId,
      required this.password,
      this.mobileNo,
      required this.empId,
      required this.empName,
      this.companyId,
      this.designation,
      required this.locationCode,
      this.locationName,
      this.userType,
      this.userLevel,
      this.admin1,
      this.admin2,
      this.totalLeave,
      this.leaveBalance,
      this.defaultCheckInTime});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: int.parse(json[COL_USER_ID].toString()),
        password: json[COL_PASSWORD],
        mobileNo: json[COL_USER_PHONE],
        companyId: int.parse(json[COL_COMPANY_MASTER_ID].toString()),
        empId: json[COL_EMPLOYEE_ID],
        empName: json[COL_EMP_NAME],
        locationCode: json[COL_LOCATION_CODE],
        locationName: json[COL_LOCATION_NAME],
        userType: json[COL_USER_TYPE],
        userLevel: json[COL_USER_LEVEL],
        defaultCheckInTime: json[COL_DEFAULT_CHECK_IN],
        designation: json[COL_DESIGNATION],
        admin1: int.parse(json[COL_ADMIN_1_ID].toString()),
        admin2: int.parse(json[COL_ADMIN_2_ID].toString()),
        totalLeave: double.parse(json[COL_TOTAL_LEAVE].toString()),
        leaveBalance: double.parse(json[COL_LEAVE_BALANCE].toString()));
  }
}
