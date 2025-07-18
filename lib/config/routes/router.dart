import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import '../../features/auth/presentation/pages/login_page.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, initial: true),
  ];
}