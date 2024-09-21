import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/router/app_router.dart';
import 'package:minddy/ui/theme/theme.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
    required this.routeName,
    this.redirect = true
  });

  final String routeName;
  final bool redirect;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        
        // After a litle delay, show the home screen (or the onboarding screen)
        if (redirect) {
          Future.delayed(const Duration(milliseconds: kDebugMode ? 500 : 1500), () {
            AppRouter.router.navigateToAndReplace(routeName);
          });
        }

        StylesGetters theme = StylesGetters(context);
        return Scaffold(
          backgroundColor: theme.primary,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/logo/app_logo/logo_minddy.svg", width: 60, height: 60),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    S.maybeOf(context)?.app_name ?? 'minddy',
                    style: theme.titleLarge
                      .copyWith(color: theme.onPrimary),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    S.maybeOf(context)?.app_slogan ?? 'Everything happens here.',
                    style: theme.bodyMedium
                      .copyWith(color: theme.onPrimary, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 150,
                    height: 5,
                    child: TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: kDebugMode ? 500 : 1500),
                      curve: Curves.slowMiddle,
                      tween: Tween<double>(
                        begin: 0,
                        end: 1
                      ),
                      builder: (context, value, child) {
                        return LinearProgressIndicator(
                          value: value,
                          color: theme.secondary,
                          backgroundColor: theme.onPrimary.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(2.5),
                        );
                      }
                    ),
                  ),
                )
              ],
            )
          ),
        );
      }
    );
  }
}
