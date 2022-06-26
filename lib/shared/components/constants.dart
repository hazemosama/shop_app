
import 'package:shopapp/modules/login/shop_login_screen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';

void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value) {
    if(value)
    {
      navigateAndFinish(
        context,
        ShopLoginScreen(),
      );
    }
  });
}

String token = '';