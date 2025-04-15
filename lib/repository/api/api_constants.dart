class ApiConstants {
  static const String BASE_URL = "https://orbitwork-backend.onrender.com/api";
  static const String TEMP_URL = "https://8643-2405-f600-8-162a-dcd7-6c76-cd28-f28b.ngrok-free.app/api";

  // AUTH ROUTES
  static const String SIGNUP = "$BASE_URL/auth/signup";   //done
  static const String SIGNIN = "$BASE_URL/auth/signin";   //done
  static const String FORGOT_PASSWORD = "$BASE_URL/auth/forgot-password";
  static const String RESET_PASSWORD = "$BASE_URL/auth/reset-password";

  // USER ROUTES
  static const String GET_USERS_LIST = "$BASE_URL/user/getall";  //done
  static const String DELETE_USER = "$BASE_URL/user/delete";

  // PROFILE ROUTES
  static const String FREELANCER_PROFILE = "$BASE_URL/profile/create-freelancer";
  static const String CLIENT_PROFILE = "$BASE_URL/profile/create-client";
  static const String AGENCY_PROFILE = "$BASE_URL/profile/create-agency";
  static const String FILTER_PROFILES = "$BASE_URL/profile/filter";

  // JOB ROUTES
  static const String CREATE_JOB = "$BASE_URL/job/create";
  static const String GET_JOB = "$BASE_URL/job/get";  //done
  static const String UPDATE_JOB = "$BASE_URL/job/update/:_id";
  static const String DELETE_JOB = "$BASE_URL/job/delete/:_id";
  static const String GET_JOB_DETAIL = "$BASE_URL/job/get/:_id";

  // JOB_PROPOSAL ROUTES
  static const String CREATE_JOB_PROPOSAL = "$BASE_URL/job-proposal/create";  //done
  static const String GET_JOB_PROPOSAL = "$BASE_URL/job-proposal/get";  //done
  static const String UPDATE_JOB_PROPOSAL = "$BASE_URL/job-proposal/update/:_id";  //done
  static const String DELETE_JOB_PROPOSAL = "$BASE_URL/job-proposal/delete/:_id";
  static const String GET_JOB_PROPOSAL_DETAIL = "$BASE_URL/job-proposal/get/"; //done

  // MESSAGE ROUTES
  static const String GET_MESSAGE_LIST = "$BASE_URL/message/list"; //done
  static const String GET_CHAT_LIST = "$TEMP_URL/chat/list"; //done
  static const String GET_GROUP_MESSAGE_LIST = "$TEMP_URL/gruop-message/list"; //done

  // UPLOAD_FILE ROUTES
  static const String UPLOAD_FILE = "$BASE_URL/file/upload"; //done

  // CREATE_ROOM ROUTES
  static const String CREATE_ROOM = "$TEMP_URL/room/create"; //done
  static const String UPDATE_ROOM = "$TEMP_URL/room/update"; //working
  static const String CREATE_ADMIN = "$TEMP_URL/room/admin/create";//done
  static const String REMOVE_ADMIN = "$TEMP_URL/room/admin/remove";//done
  static const String GET_ROOM_MEMBERS = "$TEMP_URL/room/members";//done
}