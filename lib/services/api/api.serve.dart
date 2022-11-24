class Api {
  static String host = "https://mokingbird.herokuapp.com";

  // api auth gateways
  static String signUp = "$host/auth/register";
  static String login = "$host/auth/login";
  static String refresh = "$host/auth/refresh";
  static String logout = "$host/auth/logout";
  static String profile = "$host/auth/profile";
  static String addInfo = "$host/auth/addInfo";

  // api user gateways
  static String userPofile(int id) => "$host/users/$id";

  // api thought gateways
  static String getAll = "$host/thoughts/all";
  static String newThought = "$host/thoughts/create";

  // api activity gateways
  static String like = "$host/activity/like";
  static String comment = '$host/activity/comment';
  static String comments(int postId) => "$host/activity/comments/$postId";
  static String getActivites = "$host/activity/getUserActivites";
}
