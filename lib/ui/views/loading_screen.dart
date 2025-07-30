/*
 * minddy - Free project management
 * Copyright (C) 2025 mangué
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

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
                          backgroundColor: theme.onPrimary.withValues(alpha: 0.05),
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
