class APIEndpoint {
  // Prod
  // static const BASE_URL =
  //     "https://e-mill.anj-group.co.id/backend/public/index.php/";

  // Dev
  static const BASE_URL =
      "https://etrace-dev.anj-group.co.id/mill-backend/public/index.php/";

  static const LOGIN_ENDPOINT = "api/v1/signin";
  static const LOGOUT_ENDPOINT = "api/v1/signout";
  static const SEND_QUALITY = "api/v1/qualitydoc-cpo/create";
  static const SEND_SOUNDING = "api/v1/soundingdoc-cpo/create";
  static const CHANGE_PASSWORD = "api/v1/my-password/update";
  static const PROFILE = "api/v1/my-profile";
  static const LIST_VERIFIER = "api/v1/verificators";
  static const CHECK_VERIFIER = "api/v1/verificator/check";
}
