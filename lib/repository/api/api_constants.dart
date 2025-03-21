class ApiConstants {
  static const String BASE_URL = "https://orbitwork-backend.onrender.com/api";

  // AUTH ROUTES
  static const String SIGNUP = "$BASE_URL/auth/signup";
  static const String SIGNIN = "$BASE_URL/auth/signin";
  static const String FORGOT_PASSWORD = "$BASE_URL/auth/forgot-password";
  static const String RESET_PASSWORD = "$BASE_URL/auth/reset-password";

  // USER ROUTES
  static const String GET_USERS_LIST = "$BASE_URL/user/getall";
  static const String DELETE_USER = "$BASE_URL/user/delete";

  // PROFILE ROUTES
  static const String FREELANCER_PROFILE = "$BASE_URL/profile/create-freelancer";
  static const String CLIENT_PROFILE = "$BASE_URL/profile/create-client";
  static const String AGENCY_PROFILE = "$BASE_URL/profile/create-agency";
  static const String FILTER_PROFILES = "$BASE_URL/profile/filter";

  // JOB ROUTES
  static const String CREATE_JOB = "$BASE_URL/job/create";
  static const String GET_JOB = "$BASE_URL/job/get";
  static const String UPDATE_JOB = "$BASE_URL/job/update/:_id";
  static const String DELETE_JOB = "$BASE_URL/job/delete/:_id";
  static const String GET_JOB_DETAIL = "$BASE_URL/job/get/:_id";

  // JOB_PROPOSAL ROUTES
  static const String CREATE_JOB_PROPOSAL = "$BASE_URL/job-proposal/create";
  static const String GET_JOB_PROPOSAL = "$BASE_URL/job-proposal/get";
  static const String UPDATE_JOB_PROPOSAL = "$BASE_URL/job-proposal/update/:_id";
  static const String DELETE_JOB_PROPOSAL = "$BASE_URL/job-proposal/delete/:_id";
  static const String GET_JOB_PROPOSAL_DETAIL = "$BASE_URL/job-proposal/get/:_id";

  // MESSAGE ROUTES
  static const String MESSAGE_LIST = "$BASE_URL/message/list";

  // UPLOAD_FILE ROUTES
  static const String UPLOAD_FILE = "$BASE_URL/file/upload";

  // CREATE_ROOM ROUTES
  static const String CREATE_ROOM = "$BASE_URL/room/create";
  static const String UPDATE_ROOM = "$BASE_URL/room/update/:id";
}
