import 'package:flutter/material.dart';
import 'package:sgtours/model/LOL_Guides.dart';
import 'package:sgtours/pages/admin/POISearchAdmin.dart';
import 'package:sgtours/pages/admin/admin_ViewArticleRequest.dart';
import 'package:sgtours/pages/admin/admin_ViewFeedbacks.dart';
import 'package:sgtours/pages/admin/admin_ViewItineraryGuideRequest.dart';
import 'package:sgtours/pages/admin/admin_navbar.dart';
import 'package:sgtours/pages/user/article/ArticlePage2.dart';
import 'package:sgtours/pages/user/essentials/aroundsg.dart';
import 'package:sgtours/pages/user/essentials/localtips.dart';
import 'package:sgtours/pages/user/essentials/usefulinfo.dart';
import 'package:sgtours/pages/user/guides/LOL_Guide_List.dart';
import 'package:sgtours/pages/user/essentials/currencyConverter/currencyconverterpage.dart';
import 'package:sgtours/pages/user/essentials/essentials.dart';
import 'package:sgtours/pages/user/guides/LOL_Guide_Thread.dart';
import 'package:sgtours/pages/user/home.dart';
import 'package:sgtours/pages/user/navigationbar.dart';
import 'package:sgtours/pages/user/article/ViewArticle.dart';
import 'package:sgtours/pages/business_owner/BOHome.dart';
import 'package:sgtours/pages/business_owner/BOViewArticle.dart';
import 'package:sgtours/pages/user/ViewReview.dart';
import 'package:sgtours/pages/business_owner/deletedArticle.dart';
import 'package:sgtours/pages/user/essentials/AboutPage.dart';
import 'package:sgtours/pages/user/essentials/tips.dart';
import 'package:sgtours/pages/user/essentials/faqs.dart';
import 'package:sgtours/pages/user/essentials/feedback.dart';
import 'package:sgtours/pages/user/essentials/emergencycontact.dart';
import 'package:sgtours/pages/user/nearby/getusercurrentlocation.dart';
import 'package:sgtours/pages/user/planner/itineraryplanner.dart';
import 'package:sgtours/pages/welcome/welcome.dart';
import 'package:sgtours/pages/user/favourite/FavouritePage.dart';
import 'package:sgtours/pages/user/poi/POIPage.dart';
import 'package:sgtours/pages/user/article/Article_ShowMore.dart';
import 'package:sgtours/pages/business_owner/Article_Create.dart';
import 'package:sgtours/pages/user/guides/Guides_ShowMore.dart';
import 'package:sgtours/pages/user/poi/poi_showmore.dart';
import 'package:sgtours/pages/user/nearby/Nearby_ShowMorePage.dart';
import 'package:sgtours/pages/forum/Forum_Main.dart';
import 'package:sgtours/pages/admin/admin_ViewAccountRequest.dart';
import 'package:sgtours/pages/admin/admin_CreatePOI.dart';
import 'package:sgtours/pages/user/profile/profile.dart';
import 'package:sgtours/pages/user/profile/planner.dart';
import 'package:sgtours/pages/admin/admin_manageUser.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:sgtours/pages/forum/Forum_Thread.dart';
import 'package:sgtours/pages/user/article/Article_ShowMore.dart';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const Main());
}

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const Main());
// }

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SG Tours',
        debugShowCheckedModeBanner: false,
        initialRoute: '/welcome',
        routes: {
          '/welcome': (context) => WelcomePage(),
          '/home': (context) => NavBar(currentIndex: 0),
          '/search': (context) => NavBar(currentIndex: 1),
          '/homepage': (context) => HomePage(),
          '/favourites': (context) => FavouritePage(),
          '/articles/more': (context) => Article_ShowMore(),
          '/itinerary/more': (context) => Guides_ShowMore(),
          '/poi/more': (context) => POI_ShowMore(),
          '/nearby/more': (context) => Nearby_ShowMorePage(),
          '/forum': (context) => Forum(),
          '/general': (context) => Forum_Thread(),
          '/admin_addPOI': (context) => admin_CreatePOI(),
          '/POISearchAdmin': (context) => POISearchAdmin(),
          '/guide': (context) => LolGuideList(),
          '/essentials': (context) => NavBar(currentIndex: 2),
          '/essentials/about': (context) => AboutPage(),
          '/essentials/currencyConverter/currencyconverterpage': (context) =>
              CurrencyConverter(),
          '/essentials/emergencycontact': (context) => EmergencyContact(),
          '/essentials/tips': (context) => Tips(),
          '/essentials/faqs': (context) => FAQS(),
          '/admin/home': (context) => Admin_Navbar(currentIndex: 0),
          '/admin/request/account': (context) => Admin_ViewAccountRequest(),
          '/admin/request/article': (context) => Admin_ViewArticleRequest(),
          '/admin/request/guide': (context) => Admin_ViewItineraryRequest(),
          '/admin/request/feedbacks': (context) => Admin_ViewFeedbacks(),
          '/admin/manage/user': (context) => Admin_ManageUser(),
          '/poi/review': (context) => ViewReview(),
          '/essentials/feedback': (context) => feedbackPage(),
          '/poi/review': (context) => ViewReview(),
          '/BO/home': (context) => BOHome(),
          '/BO/viewarticle': (context) => BOViewArticle(),
          '/BO/createarticle': (context) => Article_Create(),
          '/BO/deletearticle': (context) => deleteArticle(),
          '/profile': (context) => ProfilePage(),
          '/planner': (context) => itineraryplanner(),
          '/usefulinfo': (context) => Usefulinfo(),
          '/localtips': (context) => LocalTips(),
          '/aroundsg': (context) => AroundSg(),
        });
  }
}
