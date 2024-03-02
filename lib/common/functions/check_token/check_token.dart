import 'package:beaja_toko/datasource/profile/get_user_details/get_user_detail_datasource.dart';
import 'package:beaja_toko/repository/auth/auth_local_repository.dart';

class TokenChecker {
  static Future<void> checkToken(
      {required Function(bool isLogged, String userToken, String userEmail,
              bool isExpiredToken, int userId)
          setStateCallback}) async {
    final token = await AuthLocalRepository().getToken();

    bool isLogged = false;
    bool isExpiredToken = false;
    String userToken = '';
    String userEmail = '';
    int userId = 0;

    if (token.isEmpty) {
      isLogged = false;
    } else {
      // CHECK EXPIRED
      final emailUser = await AuthLocalRepository().getUserEmail();
      final idUser = await AuthLocalRepository().getUserId();

      final result = await GetUserDetailsDatasource().getUserDetails();
      result.fold(
        (error) {
          isLogged = true;
          isExpiredToken = true;
        },
        (data) {
          isLogged = true;
          userToken = token;
          userEmail = emailUser;
          userId = idUser;
          isExpiredToken = false;
        },
      );
    }
    setStateCallback(isLogged, userToken, userEmail, isExpiredToken, userId);
  }
}
