
class Constant {
  static const String baseUrl = "http://117.205.3.45:8082";
  // static const String testBaseUrl = "https://kasiri.mocklab.io";
  // static const String testBaseUrl = "https://tech.mocklab.io";
  static const String testBaseUrl = "https://y163z.wiremockapi.cloud";
  static const String registration = "/attendance_register.php";
  static const String getAllCompanies =
      "/attendance_register_get_all_companies.php";
  static const String login = "/attendance_login.php";
  static const String getHolidayList = "/attendance_get_holidays.php";
  static const String getDashBoardData = "/attendance_dashboard.php";
  static const String punch = "/attendance_punch.php";
  static const String timebar = "/attendance_timebar.php";
  static const String attendanceSummeryCount = "/attendance_summery_count.php";
  static const String userDetail = "/attendance_get_user.php";
  static const String applyRegularization = "/attendance_apply_regularization";
  static const String applyLeave = "/attendance_apply_leave.php";
  static const String userPendingRequests =
      "/attendance_user_pending_requests.php";
  static const String userPastRequests = "/attendance_user_past_requests.php";
  static const String getRequestDetail = "/attendance_get_request_detail.php";
  static const String cancelRequest = "/attendance_cancel_request.php";
  static const String getAdminTodayStatusReport =
      "/attendance_admin_get_user_list.php";
  static const String getAdminUserwiseAttendanceSummery =
      "/attendance_admin_get_userwise_attendance_summery.php";
  static const String getLocationByAdminLocations =
      "/attendance_admin_get_locations.php";
  static const String getAdminPastApproval =
      "/attendance_admin_past_approval.php";
  static const String getAdminPendingApproval =
      "/attendance_admin_pending_approval.php";
  static const String getAdminTodayPunchCount =
      "/attendance_admin_today_punch_count.php";
  static const String getAdminCurrentMonthCount =
      "/attendance_admin_current_month_count.php";
  static const String updateAdminRequest =
      "/attendance_admin_update_request_status.php";
  static const String updateImeiRequest = "/attendance_update_imei_request.php";
  static const String createAnnouncement =
      "/attendance_admin_create_announcement.php";

  static const String testGetCompanyIds = "/getAllCompanyCodes";
  // static const String testLogin = "/rdss/login";
  // static const String testRegister = "/rdss/register";

  static const String testUpdateIMEI = "/rdss/updateIMEI";
  // static const String testDashboard = "/rdss/dashboard";
  static const String testPunch = "/rdss/punchRequest";
  static const String testAdminPastApproval = "/rdss/admin_past_approvals";
  // static const String testAttendanceSummery = "/rdss/getAttendanceSummery";

  // static const String testAttendanceSummeryCount =
  //     "/rdss/attendance_summery_count";
  static const String testRegularizeReasons = "/rdss/getRegularizationReasons";
  // static const String testApplyRegularization = "/rdss/applyRegularization";
  // static const String testUserDetail = "/rdss/getUserDetail";
  static const String testPendingRequest = "/rdss/getPendingRequests";
  // static const String testHistoryRequest = "/rdss/getHistoryRequest";
  static const String testGetRequestDetail = "/rdss/getRequestDetail";
  static const String testCancleRequest = "/rdss/cancleRequest";
  // static const String testApplyLeave = "/rdss/applyLeave";
  // static const String testGetAbsentUsers = "/rdss/getAbsentUserList";
  static const String testAdminPendingApprovals =
      "/rdss/admin/pending_approvals";
  static const String testRequestStatusUpdate = "/rdss/request_status_update";
  static const String testAdminUserWiseAttendanceSummery =
      "/rdss/adminUserWiseAttendanceSummery";
  static const String testGetLocations = "/rdss/getLocationsByLocation";
}

enum SELECTED_LEAVE_TYPE { FULL_DAY, FIRST_HALF, SECOND_HALF }

enum USER_TYPE {
  PG_SDN_ADM,
  PG_DIV_ADM,
  PG_CIR_ADM,
  PG_ZON_ADM,
  PG_COR_ADM,
  PA_SDN_ADM,
  PA_SDN_EMP,
  PA_DIV_ADM,
  PA_DIV_EMP,
  PA_CIR_ADM,
  PA_CIR_EMP,
  PA_ZON_EMP,
  PA_ZON_ADM,
  PA_COR_ADM,
  PA_COR_EMP
}

const INCLUDE_SUB_LOCATIONS = 1;
const DONT_INCLUDE_SUB_LOCATIONS = 0;

const INCLUDE_PARENT_LOCATION = 1;
const DONT_INCLUDE_PARENT_LOCATION = 0;

const String EMPTY = "";
const int ZERO = 0;

// COLUMN LABEL
String COL_COMPANY_MASTER_ID = "company_master_id";
String COL_EMPLOYEE_ID = "employee_id";
String COL_PASSWORD = "password";
String COL_IMEI = "imei";
String COL_USER_ID = "user_master_id";
String COL_EMP_NAME = "user_name";
String COL_USER_PHONE = "user_mobile_no";
String COL_LOCATION_CODE = "location_code";
String COL_LOCATION_NAME = "office_name";
String COL_USER_TYPE = "user_type";
String COL_USER_LEVEL = "user_level";
const String COL_ADMIN_1_ID = "admin1_user_master_id";
const String COL_ADMIN_2_ID = "admin2_user_master_id";
const String COL_FROM_DATE = "from_date";
const String COL_TO_DATE = "to_date";
const String COL_TOTAL_LEAVE = "total_leave";
const String COL_LEAVE_BALANCE = "leave_balance";
const String COL_HOLIDAY_ID = "holiday_master_id";
const String COL_HOLIDAY_DATE = "date";
const String COL_HOLIDAY_TYPE = "type_of_holiday";
const String COL_HOLIDAY_DESC = "description";
String COL_CHECK_IN_DATETIME = "check_in_datetime";
String COL_CHECK_OUT_DATETIME = "check_out_datetime";
const String COL_LOCATION_LONG = "longitude";
const String COL_LOCATION_LAT = "latitude";
const String COL_PUNCH_DATE = "date";
const String COL_ATTENDANCE_STATE = "attendance_state";
const String COL_LEAVE_FLAG = "leave_flag";
const String COL_REGULARIZE_FLAG = "regularize_flag";
const String COL_FIRST_HALF_LEAVE_FLAG = "first_half_leave_flag";
const String COL_SECOND_HALF_LEAVE_FLAG = "second_half_leave_flag";
const String COL_PRESENCE_COUNT = "presence_count";
String COL_DEFAULT_CHECK_IN = "default_check_in_time";
String COL_DESIGNATION = "designation";
const String COL_REGULARIZATION_REASON = "regularization_reason";
const String COL_USER_REMARK = "user_remark";
const String COL_LEAVE_TYPE = "type_of_leave";
const String COL_ADMIN1_REMARK = "admin1_remark";
const String COL_ADMIN2_REMARK = "admin2_remark";
const String COL_ADMIN1_APPROVAL_STATUS = "admin1_approval_status";
const String COL_ADMIN2_APPROVAL_STATUS = "admin2_approval_status";
const String COL_LOCATION_TYPE = "office_type";

const String JSON_REGULARIZATION_DATE = "regularization_date";

String JSON_FISRT_HALF = "FIRST-HALF";
String JSON_SECOND_HALF = "SECOND-HALF";
String JSON_FULL_DAY_LEAVE = "FULL-DAY";
String JSON_APPROVED = "Approve";
String JSON_REJECT = "Reject";
//json constrants

String JSON_COMPANY_NAME = "company_name";
String JSON_COMPANY_EMAIL = "email";
String JSON_EMP_ID = "emp_id";

String JSON_EMP_NAME = "emp_name";

String JSON_OBJECT_USER = "user";
String JSON_OBJECT_USERS = "users";
String JSON_DESIGNATION = "designation";
String JSON_LOCATION_CODE = "location_code";
String JSON_OBJECT_COMPANIES = "companies";
String JSON_LOCATION_NAME = "location_name";
// String JSON_DEFAULT_CHECK_IN = "default_check_in_time";
String JSON_USER_TYPE = "user_type";
String JSON_USER_LEVEL = "user_level";
String JSON_IMEI = "imei";
String JSON_PASSWORD = "password";
String JSON_PUNCH_DATE_TIME = "punch_datetime";
String JSON_DISTANCE = "distance";
String JSON_PUNCH_TYPE = "punch_type";
String JSON_USER_ID = "user_id";

String JSON_ADMIN_ID = "admin_id";
String JSON_PUNCH_IN = "punch_in_date_time";
String JSON_PUNCH_OUT = "punch_out_date_time";
String JSON_ABSENT = "absent";
String JSON_PRESENCE = "presence";
String JSON_PRESENT = "present";
String JSON_LEAVE = "leave";
const String JSON_WEEK_OFF = "week_off";
const String JSON_HOLIDAY = "holiday";
const String JSON_NEXT_HOLIDAY = "next_holiday";
const String JSON_TODAY_CHECKED_IN = "today_check_in";
const String JSON_TOTAL_USERS = "total_users";
const String JSON_TOTAL_MAN_DAYS = "total_man_days";

const String JSON_ANNOUNCEMENT = "announcement";
String JSON_OBJECT_DASHBOARD = "dashboard";
const String JSON_USER_LAT = "user_lat";
const String JSON_LOCATION_LAT = "location_lat";
const String JSON_LOCATION_LONG = "location_long";
const String JSON_SELECTED_DATE = "selected_date";
const String JSON_LOCATION_TYPE = "location_type";
const String JSON_USER_LONG = "user_long";
const String JSON_FROM_DATE = "from_date";
const String JSON_TO_DATE = "to_date";
const String COL_ATTENDANCE_ID = "attendance_id";
// const String JSON_ATTENDANCE_STATE = "attendance_state";
// const String JSON_FIRST_HALF_LEAVE_FLAG = "first_half_leave_flag";
// const String JSON_SECOND_HALF_LEAVE_FLAG = "second_half_leave_flag";
// const String JSON_LEAVE_FLAG = "leave_flag";
// const String JSON_REGULARIZE_FLAG = "regularization_flag";
const String JSON_INCLUDE_PARENT_LOCATION_FLAG = "include_parent_location";
const String JSON_INCLUDE_SUB_LOCATION_FLAG = "include_sub_location";
// const String JSON_PRESENCE_COUNT = "presence_count";
const String JSON_PUNCH_DATE = "punch_date";
const String JSON_ATTENDANCE_MONTHLY_OBJECT = "attendance_datewise";
const String JSON_OBJECT_ATTENDANCE_SUMMERY = "attendance_summery_count";
const String JSON_OBJECT_REQUESTS = "requests";
const String JSON_OBJECT_USERWISE_ATTENDANCE = "user_wise_attendance";
const String JSON_OBJECT_REGULARIZE_REASONS = "reasons";
const String JSON_OBJECT_LOCATIONS = "locations";
const String JSON_OBJECT_HOLIDAYS = "holidays";
// const String JSON_REASON = "reason";
// const String JSON_USER_REMARK = "user_remark";
const String JSON_LEAVE_TYPE = "leave_type";
// const String JSON_REGULARIZATION_DATE = "regularization_date";

const String JSON_IN_TIME = "in_time";
const String JSON_OUT_TIME = "out_time";
const String JSON_ADMIN_1 = "admin_1";
const String JSON_ADMIN_2 = "admin_2";
const String JSON_ADMIN_1_ID = "admin_1_id";
const String JSON_ADMIN_2_ID = "admin_2_id";
const String JSON_LEAVE_BALANCE = "leave_balance";
const String JSON_TOTAL_LEAVE = "total_leave";
const String JSON_REQUEST_APPLIED_DATE = "request_applied_date";
const String JSON_REQUEST_ID = "request_id";
const String JSON_REQUEST_MESSAGE = "request_message";
const String JSON_REQUEST_STATUS = "request_status";
const String JSON_REQUEST_TYPE = "request_type";
const String JSON_ADMIN1_NAME = "admin1_name";
const String JSON_REQUEST_DATE = "request_date";
const String JSON_NEW_IMEI = "imei_no_new";
const String JSON_OLD_IMEI = "imei_no_old";
const String JSON_ADMIN1_DESIGNATION = "admin1_designation";
const String JSON_ADMIN1_REMARK = "admin1_remark";
const String JSON_ADMIN2_NAME = "admin2_name";
const String JSON_ADMIN2_DESIGNATION = "admin2_designation";
const String JSON_ADMIN2_REMARK = "admin2_remark";
const String JSON_REQUEST_STATUS_ADMIN1 = "request_status_admin_1";
const String JSON_REQUEST_STATUS_ADMIN2 = "request_status_admin_2";
const String JSON_FROM_TIME = "from_time";
const String JSON_TO_TIME = "to_time";
const String JSON_OBJECT_REQUEST_DETAIL = "request_detail";
const String JSON_REQUEST_REASON = "request_reason";
const String JSON_REQUEST_UPDATE_STATUS = "request_status_update";
const String JSON_ADMIN_REMARK = "admin_remark";
const String JSON_REQUEST_TYPE_REGULARIZATION = "Regularization";
const String JSON_REQUEST_TYPE_LEAVE = "Leave";
const String JSON_REQUEST_TYPE_IMEI = "IMEI";
const String JSON_ATTENDANCE_REPORT_TYPE = "attendance_report_type";
const String JSON_ATTENDANCE_STATUS = "attendance_status";
