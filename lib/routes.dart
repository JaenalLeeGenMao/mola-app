import './home/home.dart';
import './profile/profile.dart';
import './search/search.dart';
import './library/library.dart';
import './detail/detail.dart';

getRoutes() {
  return {
    '/': (context) => new HomePage(title: 'Flutter Demo Home Page'),
    '/profile': (context) => Profile(),
    '/search': (context) => Search(),
    '/library': (context) => Library("0"),
    '/detail': (context) => Detail("0"),
  };
}
