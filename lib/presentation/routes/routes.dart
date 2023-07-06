import 'package:auto_route/auto_route.dart';
import 'package:demo_of_ddd/presentation/routes/routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SignInPage.page, initial: true),
  ];
}
