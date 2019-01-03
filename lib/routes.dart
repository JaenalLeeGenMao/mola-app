import './home/home.dart';
import './profile/profile.dart';
import './search/search.dart';
import './library/library.dart';
import './detail/detail.dart';

getRoutes() {
  return {
    '/': (context) => HomePage(title: 'Flutter Demo Home Page'),
    '/profile': (context) => Profile(),
    '/search': (context) => Search(),
    '/library': (context) => Library(null),
    '/detail': (context) => Detail(null),
  };
}
