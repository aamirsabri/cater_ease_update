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

class DBConstant {
  static const String CUSTOMER_ID = "CUSTOMER_ID";
  static const String CUSTOMER_NAME = "CUSTOMER_NAME";
  static const String ADDRESS = "ADDRESS";
  static const String WHATSAPP_NUMBER = "WA_NUMBER";
  static const String EMAIL = "EMAIL";
  static const String CATERER_ID = "CATERER_ID";
  static const String CATERER_NAME = "CATERER_NAME";
  static const String CATERER_ADDRESS = "ADDRESS";
  static const String CATERER_MOBILE = "MOBILE";
  static const String CATERER_EMAIL = "EMAIL";
  static const String CATERER_PLACE = "PLACE";
  static const String CATERER_LOGO = "LOGO";
  static const String CUSTOMER_MOBILE = "MOBILE";

  static const String FUNCTION_NAME = "FUNCTION_NAME";
  static const String FUNCTION_ID = "FUNCTION_ID";
  static const String FUNCTION_START_DATE = "START_DATE";
  static const String FUNCTION_END_DATE = "END_DATE";
  static const String FUNCTION_FAMILY_NAME = "FAMILY_NAME";
  static const String FUNCTION_TYPE = "FUNCTION_TYPE";

  static const String EVENT_DESCRIPTION = "EVENT_DESCRIPTION";
  static const String EVENT_ICON = "EVENT_ICON";
  static const String EVENT_MASTER_ID = "EVENT_MASTER_ID";
  static const String EVENT_NAME = "EVENT_NAME";

  static const String CUSTOMER_EVENT_ID = "EVENT_ID";
  static const String EVENT_DATE = "EVENT_DATE";
  static const String EVENT_PLACE = "EVENT_PLACE";
  static const String IS_VIP_MENU = "IS_VIP_MENU";
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

enum DRAWER_SCREEN {
  HOME,
  MY_PROFILE,
  CUSTOMER,
  EVENT,
  DISH,
  MENU_ITEM,
  PAST_FUNCTIONS,
  MANAGE_USER,
  LOG_OUT
}

const INCLUDE_SUB_LOCATIONS = 1;
const DONT_INCLUDE_SUB_LOCATIONS = 0;

const INCLUDE_PARENT_LOCATION = 1;
const DONT_INCLUDE_PARENT_LOCATION = 0;

const String EMPTY = "";
const int ZERO = 0;

const String COL_CATERER_ID = "catererId";
const String COL_CATERER_NAME = "catererName";
const String COL_EMAIL = "email";
const String COL_LOGO = "logo";
const String COL_MOBILE = "mobile";
const String COL_PLACE = "place";
const String COL_IS_ACTIVE = "isActive";

const String COL_IMEI = "imei";
const String COL_MSG = "msg";
const String COL_USER_ID = "userId";
const String COL_USER_NAME = "userName";
const String COL_PASSWORD = "password";

abstract class SharedPreferencesKeys {
  static const String PREF_KEY_EMP_ID = "PREF_KEY_EMP_ID";
  static const String EMAIL = "email";
  static const String PASSWORD = "password";
  static const String CATERER_ID = "catererId";
}
