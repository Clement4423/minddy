// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `minddy`
  String get app_name {
    return Intl.message('minddy', name: 'app_name', desc: '', args: []);
  }

  /// `Everything happens here.`
  String get app_slogan {
    return Intl.message(
      'Everything happens here.',
      name: 'app_slogan',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get system_files_copy_text {
    return Intl.message(
      'Copy',
      name: 'system_files_copy_text',
      desc: '',
      args: [],
    );
  }

  /// `Go back home`
  String get appbar_go_home {
    return Intl.message(
      'Go back home',
      name: 'appbar_go_home',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome_appbar {
    return Intl.message('Welcome', name: 'welcome_appbar', desc: '', args: []);
  }

  /// `First of all, please enter your first name`
  String get welcome_before_creating {
    return Intl.message(
      'First of all, please enter your first name',
      name: 'welcome_before_creating',
      desc: '',
      args: [],
    );
  }

  /// `To personalize your experience`
  String get welcome_because {
    return Intl.message(
      'To personalize your experience',
      name: 'welcome_because',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get welcome_pass_username {
    return Intl.message(
      'Skip',
      name: 'welcome_pass_username',
      desc: '',
      args: [],
    );
  }

  /// `You will still be able to enter your first name in settings / {accountSettingName}`
  String welcome_pass_tooltip(Object accountSettingName) {
    return Intl.message(
      'You will still be able to enter your first name in settings / $accountSettingName',
      name: 'welcome_pass_tooltip',
      desc: '',
      args: [accountSettingName],
    );
  }

  /// `User`
  String get welcome_pass_default_username {
    return Intl.message(
      'User',
      name: 'welcome_pass_default_username',
      desc: '',
      args: [],
    );
  }

  /// `Enter your first name`
  String get welcome_enter_name {
    return Intl.message(
      'Enter your first name',
      name: 'welcome_enter_name',
      desc: '',
      args: [],
    );
  }

  /// `The first name cannot be longer than 25 letters`
  String get welcome_first_name_too_long {
    return Intl.message(
      'The first name cannot be longer than 25 letters',
      name: 'welcome_first_name_too_long',
      desc: '',
      args: [],
    );
  }

  /// `Please, provide your first name`
  String get welcome_should_provide {
    return Intl.message(
      'Please, provide your first name',
      name: 'welcome_should_provide',
      desc: '',
      args: [],
    );
  }

  /// `An error occured while saving your name. Please try again`
  String get welcome_error_save_username {
    return Intl.message(
      'An error occured while saving your name. Please try again',
      name: 'welcome_error_save_username',
      desc: '',
      args: [],
    );
  }

  /// `Next page`
  String get welcome_next_page_semantic {
    return Intl.message(
      'Next page',
      name: 'welcome_next_page_semantic',
      desc: '',
      args: [],
    );
  }

  /// `Now, create a password`
  String get welcome_password_creation_title {
    return Intl.message(
      'Now, create a password',
      name: 'welcome_password_creation_title',
      desc: '',
      args: [],
    );
  }

  /// `To keep your data secured`
  String get welcome_password_creation_description {
    return Intl.message(
      'To keep your data secured',
      name: 'welcome_password_creation_description',
      desc: '',
      args: [],
    );
  }

  /// `Create your password`
  String get welcome_password_creation_hint {
    return Intl.message(
      'Create your password',
      name: 'welcome_password_creation_hint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your password`
  String get welcome_password_creation_confirm_hint {
    return Intl.message(
      'Confirm your password',
      name: 'welcome_password_creation_confirm_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please, create a password`
  String get welcome_password_creation_error_must_provide {
    return Intl.message(
      'Please, create a password',
      name: 'welcome_password_creation_error_must_provide',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get welcome_password_creation_error_not_match {
    return Intl.message(
      'Passwords do not match',
      name: 'welcome_password_creation_error_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Show password`
  String get welcome_password_creation_show_semantic {
    return Intl.message(
      'Show password',
      name: 'welcome_password_creation_show_semantic',
      desc: '',
      args: [],
    );
  }

  /// `Hide password`
  String get welcome_password_creation_hide_semantic {
    return Intl.message(
      'Hide password',
      name: 'welcome_password_creation_hide_semantic',
      desc: '',
      args: [],
    );
  }

  /// `An error occured while saving your password`
  String get welcome_password_creation_error_password_save {
    return Intl.message(
      'An error occured while saving your password',
      name: 'welcome_password_creation_error_password_save',
      desc: '',
      args: [],
    );
  }

  /// `Add a password hint (optional)`
  String get welcome_password_creation_remember {
    return Intl.message(
      'Add a password hint (optional)',
      name: 'welcome_password_creation_remember',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, and one digit.`
  String get welcome_password_creation_password_requirements {
    return Intl.message(
      'Password must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, and one digit.',
      name: 'welcome_password_creation_password_requirements',
      desc: '',
      args: [],
    );
  }

  /// `Main calendar`
  String get calendar_main_calendar_name {
    return Intl.message(
      'Main calendar',
      name: 'calendar_main_calendar_name',
      desc: '',
      args: [],
    );
  }

  /// `Event`
  String get calendar_button_new_event_button_title {
    return Intl.message(
      'Event',
      name: 'calendar_button_new_event_button_title',
      desc: '',
      args: [],
    );
  }

  /// `Due date`
  String get calendar_button_new_due_date_button_title {
    return Intl.message(
      'Due date',
      name: 'calendar_button_new_due_date_button_title',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get calendar_button_calendar_title {
    return Intl.message(
      'Calendar',
      name: 'calendar_button_calendar_title',
      desc: '',
      args: [],
    );
  }

  /// `Next events`
  String get calendar_button_next_events_title {
    return Intl.message(
      'Next events',
      name: 'calendar_button_next_events_title',
      desc: '',
      args: [],
    );
  }

  /// `Due dates`
  String get calendar_button_next_due_dates_title {
    return Intl.message(
      'Due dates',
      name: 'calendar_button_next_due_dates_title',
      desc: '',
      args: [],
    );
  }

  /// `Add event`
  String get calendar_button_add_event_button_tooltip {
    return Intl.message(
      'Add event',
      name: 'calendar_button_add_event_button_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Manage calendar`
  String get calendar_button_manage_calendar_button_tooltip {
    return Intl.message(
      'Manage calendar',
      name: 'calendar_button_manage_calendar_button_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get calendar_button_event_date_yesterday {
    return Intl.message(
      'Yesterday',
      name: 'calendar_button_event_date_yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get calendar_button_event_date_today {
    return Intl.message(
      'Today',
      name: 'calendar_button_event_date_today',
      desc: '',
      args: [],
    );
  }

  /// `Tomorrow`
  String get calendar_button_event_date_tomorrow {
    return Intl.message(
      'Tomorrow',
      name: 'calendar_button_event_date_tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get calendar_button_due_date_cancel_complete {
    return Intl.message(
      'Cancel',
      name: 'calendar_button_due_date_cancel_complete',
      desc: '',
      args: [],
    );
  }

  /// `{eventName} has been completed by {username}`
  String calendar_button_due_date_has_been_complete(
    Object eventName,
    Object username,
  ) {
    return Intl.message(
      '$eventName has been completed by $username',
      name: 'calendar_button_due_date_has_been_complete',
      desc: '',
      args: [eventName, username],
    );
  }

  /// `Not completed yet`
  String get calendar_event_detailed_preview_not_completed_yet {
    return Intl.message(
      'Not completed yet',
      name: 'calendar_event_detailed_preview_not_completed_yet',
      desc: '',
      args: [],
    );
  }

  /// `Completed by {username}`
  String calendar_event_detailed_preview_completed_by(Object username) {
    return Intl.message(
      'Completed by $username',
      name: 'calendar_event_detailed_preview_completed_by',
      desc: '',
      args: [username],
    );
  }

  /// `New event`
  String get calendar_new_event_title {
    return Intl.message(
      'New event',
      name: 'calendar_new_event_title',
      desc: '',
      args: [],
    );
  }

  /// `Modify event`
  String get calendar_modify_event_title {
    return Intl.message(
      'Modify event',
      name: 'calendar_modify_event_title',
      desc: '',
      args: [],
    );
  }

  /// `New due date`
  String get calendar_new_due_date_title {
    return Intl.message(
      'New due date',
      name: 'calendar_new_due_date_title',
      desc: '',
      args: [],
    );
  }

  /// `Modify due date`
  String get calendar_modify_due_date_title {
    return Intl.message(
      'Modify due date',
      name: 'calendar_modify_due_date_title',
      desc: '',
      args: [],
    );
  }

  /// `Whole day`
  String get calendar_new_event_whole_day {
    return Intl.message(
      'Whole day',
      name: 'calendar_new_event_whole_day',
      desc: '',
      args: [],
    );
  }

  /// `Recurrence`
  String get calendar_new_event_recurrence_subtitle {
    return Intl.message(
      'Recurrence',
      name: 'calendar_new_event_recurrence_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Never`
  String get calendar_new_event_recurrence_type_never {
    return Intl.message(
      'Never',
      name: 'calendar_new_event_recurrence_type_never',
      desc: '',
      args: [],
    );
  }

  /// `Every day`
  String get calendar_new_event_recurrence_type_everyday {
    return Intl.message(
      'Every day',
      name: 'calendar_new_event_recurrence_type_everyday',
      desc: '',
      args: [],
    );
  }

  /// `Every week`
  String get calendar_new_event_recurrence_type_everyweek {
    return Intl.message(
      'Every week',
      name: 'calendar_new_event_recurrence_type_everyweek',
      desc: '',
      args: [],
    );
  }

  /// `Every month`
  String get calendar_new_event_recurrence_type_everymonth {
    return Intl.message(
      'Every month',
      name: 'calendar_new_event_recurrence_type_everymonth',
      desc: '',
      args: [],
    );
  }

  /// `Every year`
  String get calendar_new_event_recurrence_type_everyyear {
    return Intl.message(
      'Every year',
      name: 'calendar_new_event_recurrence_type_everyyear',
      desc: '',
      args: [],
    );
  }

  /// `Select a calendar`
  String get calendar_new_event_recurrence_select_calendar {
    return Intl.message(
      'Select a calendar',
      name: 'calendar_new_event_recurrence_select_calendar',
      desc: '',
      args: [],
    );
  }

  /// `Open week-view`
  String get calendar_button_open_week_view_button_tooltip {
    return Intl.message(
      'Open week-view',
      name: 'calendar_button_open_week_view_button_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Only this event`
  String get calendar_button_event_selection_menu_only_this_event {
    return Intl.message(
      'Only this event',
      name: 'calendar_button_event_selection_menu_only_this_event',
      desc: '',
      args: [],
    );
  }

  /// `All occurrences`
  String get calendar_button_event_selection_menu_all_occurence {
    return Intl.message(
      'All occurrences',
      name: 'calendar_button_event_selection_menu_all_occurence',
      desc: '',
      args: [],
    );
  }

  /// `You are free for the next 5 days`
  String get calendar_button_free_for_next_days {
    return Intl.message(
      'You are free for the next 5 days',
      name: 'calendar_button_free_for_next_days',
      desc: '',
      args: [],
    );
  }

  /// `All calendars`
  String get calendar_button_manage_calendars_sub_menu_all_calendars_subtitle {
    return Intl.message(
      'All calendars',
      name: 'calendar_button_manage_calendars_sub_menu_all_calendars_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `New calendar`
  String get calendar_button_manage_calendars_sub_menu_add_calendar {
    return Intl.message(
      'New calendar',
      name: 'calendar_button_manage_calendars_sub_menu_add_calendar',
      desc: '',
      args: [],
    );
  }

  /// `Modify calendar`
  String get calendar_button_manage_calendars_sub_menu_modify_calendar {
    return Intl.message(
      'Modify calendar',
      name: 'calendar_button_manage_calendars_sub_menu_modify_calendar',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get calendar_button_new_calendar_calendar_subtitle_name {
    return Intl.message(
      'Name',
      name: 'calendar_button_new_calendar_calendar_subtitle_name',
      desc: '',
      args: [],
    );
  }

  /// `Personalized`
  String get calendar_button_new_calendar_personalized_color {
    return Intl.message(
      'Personalized',
      name: 'calendar_button_new_calendar_personalized_color',
      desc: '',
      args: [],
    );
  }

  /// `Private calendar`
  String get calendar_button_new_calendar_private_calendar_title {
    return Intl.message(
      'Private calendar',
      name: 'calendar_button_new_calendar_private_calendar_title',
      desc: '',
      args: [],
    );
  }

  /// `By enabling this, the password will be required to see events from this calendar`
  String get calendar_button_new_calendar_private_calendar_explanation {
    return Intl.message(
      'By enabling this, the password will be required to see events from this calendar',
      name: 'calendar_button_new_calendar_private_calendar_explanation',
      desc: '',
      args: [],
    );
  }

  /// `This event is private.`
  String get calendar_button_event_preview_private_event {
    return Intl.message(
      'This event is private.',
      name: 'calendar_button_event_preview_private_event',
      desc: '',
      args: [],
    );
  }

  /// `See`
  String get calendar_button_event_preview_see_button {
    return Intl.message(
      'See',
      name: 'calendar_button_event_preview_see_button',
      desc: '',
      args: [],
    );
  }

  /// `{interval, plural, one {Everyday} other {Every {interval} days}}`
  String calendar_button_event_preview_recurence_text_every_day(num interval) {
    return Intl.plural(
      interval,
      one: 'Everyday',
      other: 'Every $interval days',
      name: 'calendar_button_event_preview_recurence_text_every_day',
      desc: '',
      args: [interval],
    );
  }

  /// `{interval, plural, one {Every week} other {Every {interval} weeks}}`
  String calendar_button_event_preview_recurence_text_every_week(num interval) {
    return Intl.plural(
      interval,
      one: 'Every week',
      other: 'Every $interval weeks',
      name: 'calendar_button_event_preview_recurence_text_every_week',
      desc: '',
      args: [interval],
    );
  }

  /// `{interval, plural, one {Every month} other {Every {interval} months}}`
  String calendar_button_event_preview_recurence_text_every_month(
    num interval,
  ) {
    return Intl.plural(
      interval,
      one: 'Every month',
      other: 'Every $interval months',
      name: 'calendar_button_event_preview_recurence_text_every_month',
      desc: '',
      args: [interval],
    );
  }

  /// `{interval, plural, one {Every year} other {Every {interval} years}}`
  String calendar_button_event_preview_recurence_text_every_year(num interval) {
    return Intl.plural(
      interval,
      one: 'Every year',
      other: 'Every $interval years',
      name: 'calendar_button_event_preview_recurence_text_every_year',
      desc: '',
      args: [interval],
    );
  }

  /// `Week {week}`
  String calendar_week_view_week_title(Object week) {
    return Intl.message(
      'Week $week',
      name: 'calendar_week_view_week_title',
      desc: '',
      args: [week],
    );
  }

  /// `Details`
  String get calendar_week_view_week_details {
    return Intl.message(
      'Details',
      name: 'calendar_week_view_week_details',
      desc: '',
      args: [],
    );
  }

  /// `Completion state`
  String get calendar_new_due_date_event_completion_state_subtitle {
    return Intl.message(
      'Completion state',
      name: 'calendar_new_due_date_event_completion_state_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get calendar_new_due_date_event_completion_state {
    return Intl.message(
      'State',
      name: 'calendar_new_due_date_event_completion_state',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get calendar_new_event_recurence_type_subtitle {
    return Intl.message(
      'Type',
      name: 'calendar_new_event_recurence_type_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Every`
  String get calendar_new_event_recurence_every_subtitle {
    return Intl.message(
      'Every',
      name: 'calendar_new_event_recurence_every_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `{interval, plural, one {day} other {days}}`
  String calendar_new_event_recurence_every_day(num interval) {
    return Intl.plural(
      interval,
      one: 'day',
      other: 'days',
      name: 'calendar_new_event_recurence_every_day',
      desc: '',
      args: [interval],
    );
  }

  /// `{interval, plural, one {week} other {weeks}}`
  String calendar_new_event_recurence_every_week(num interval) {
    return Intl.plural(
      interval,
      one: 'week',
      other: 'weeks',
      name: 'calendar_new_event_recurence_every_week',
      desc: '',
      args: [interval],
    );
  }

  /// `{interval, plural, one {month} other {months}}`
  String calendar_new_event_recurence_every_month(num interval) {
    return Intl.plural(
      interval,
      one: 'month',
      other: 'months',
      name: 'calendar_new_event_recurence_every_month',
      desc: '',
      args: [interval],
    );
  }

  /// `{interval, plural, one {year} other {years}}`
  String calendar_new_event_recurence_every_year(num interval) {
    return Intl.plural(
      interval,
      one: 'year',
      other: 'years',
      name: 'calendar_new_event_recurence_every_year',
      desc: '',
      args: [interval],
    );
  }

  /// `End date`
  String get calendar_new_event_recurence_end_date {
    return Intl.message(
      'End date',
      name: 'calendar_new_event_recurence_end_date',
      desc: '',
      args: [],
    );
  }

  /// `The...`
  String get calendar_new_event_recurence_end_date_option_the {
    return Intl.message(
      'The...',
      name: 'calendar_new_event_recurence_end_date_option_the',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get center_menu_general {
    return Intl.message(
      'General',
      name: 'center_menu_general',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get center_menu_others {
    return Intl.message(
      'Other',
      name: 'center_menu_others',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings_title {
    return Intl.message('Settings', name: 'settings_title', desc: '', args: []);
  }

  /// `Personalize`
  String get settings_personalize_title {
    return Intl.message(
      'Personalize',
      name: 'settings_personalize_title',
      desc: '',
      args: [],
    );
  }

  /// `Accessibility`
  String get settings_accessibility_title {
    return Intl.message(
      'Accessibility',
      name: 'settings_accessibility_title',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get settings_security_title {
    return Intl.message(
      'Security',
      name: 'settings_security_title',
      desc: '',
      args: [],
    );
  }

  /// `My account`
  String get settings_account_title {
    return Intl.message(
      'My account',
      name: 'settings_account_title',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get settings_theme_subtitle {
    return Intl.message(
      'Theme',
      name: 'settings_theme_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get settings_using_dark_mode {
    return Intl.message(
      'Dark mode',
      name: 'settings_using_dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Light mode`
  String get settings_using_light_mode {
    return Intl.message(
      'Light mode',
      name: 'settings_using_light_mode',
      desc: '',
      args: [],
    );
  }

  /// `To change theme settings, please go back at home`
  String get settings_need_to_quit_project_to_change_theme {
    return Intl.message(
      'To change theme settings, please go back at home',
      name: 'settings_need_to_quit_project_to_change_theme',
      desc: '',
      args: [],
    );
  }

  /// `To change language, please go back at home`
  String get settings_need_to_quit_project_to_change_language {
    return Intl.message(
      'To change language, please go back at home',
      name: 'settings_need_to_quit_project_to_change_language',
      desc: '',
      args: [],
    );
  }

  /// `Device theme`
  String get settings_using_system_theme {
    return Intl.message(
      'Device theme',
      name: 'settings_using_system_theme',
      desc: '',
      args: [],
    );
  }

  /// `Black and white mode`
  String get settings_personalize_black_and_white_title {
    return Intl.message(
      'Black and white mode',
      name: 'settings_personalize_black_and_white_title',
      desc: '',
      args: [],
    );
  }

  /// `Date format`
  String get settings_date_format_subtitle {
    return Intl.message(
      'Date format',
      name: 'settings_date_format_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Prefer MM/dd date format`
  String get settings_date_format {
    return Intl.message(
      'Prefer MM/dd date format',
      name: 'settings_date_format',
      desc: '',
      args: [],
    );
  }

  /// `This option will put the month before the day. Like this : {actualMonth}/{actualDay}`
  String settings_date_format_tooltip(Object actualMonth, Object actualDay) {
    return Intl.message(
      'This option will put the month before the day. Like this : $actualMonth/$actualDay',
      name: 'settings_date_format_tooltip',
      desc: '',
      args: [actualMonth, actualDay],
    );
  }

  /// `Language`
  String get settings_language_subtitle {
    return Intl.message(
      'Language',
      name: 'settings_language_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get settings_username_subtitle {
    return Intl.message(
      'First name',
      name: 'settings_username_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get settings_reset_subtitle {
    return Intl.message(
      'Reset',
      name: 'settings_reset_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Reset settings`
  String get settings_reset_button {
    return Intl.message(
      'Reset settings',
      name: 'settings_reset_button',
      desc: '',
      args: [],
    );
  }

  /// `Rename`
  String get settings_project_rename_button {
    return Intl.message(
      'Rename',
      name: 'settings_project_rename_button',
      desc: '',
      args: [],
    );
  }

  /// `Rename`
  String get settings_project_rename_subtitle {
    return Intl.message(
      'Rename',
      name: 'settings_project_rename_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get settings_project_delete_subtitle {
    return Intl.message(
      'Delete',
      name: 'settings_project_delete_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Delete this project`
  String get settings_project_delete_button {
    return Intl.message(
      'Delete this project',
      name: 'settings_project_delete_button',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get settings_project_privacy_subtitle {
    return Intl.message(
      'Privacy',
      name: 'settings_project_privacy_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Private project`
  String get settings_project_private_project {
    return Intl.message(
      'Private project',
      name: 'settings_project_private_project',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get articles_search {
    return Intl.message('Search', name: 'articles_search', desc: '', args: []);
  }

  /// `Search a title, author`
  String get articles_search_explain {
    return Intl.message(
      'Search a title, author',
      name: 'articles_search_explain',
      desc: '',
      args: [],
    );
  }

  /// `No result`
  String get articles_search_empty {
    return Intl.message(
      'No result',
      name: 'articles_search_empty',
      desc: '',
      args: [],
    );
  }

  /// `Impossible to load article content`
  String get articles_impossible_to_load_content {
    return Intl.message(
      'Impossible to load article content',
      name: 'articles_impossible_to_load_content',
      desc: '',
      args: [],
    );
  }

  /// `This article is corrupted`
  String get articles_corrupted_file {
    return Intl.message(
      'This article is corrupted',
      name: 'articles_corrupted_file',
      desc: '',
      args: [],
    );
  }

  /// `{count} images found. Do you want to import them ?`
  String articles_importer_images_found_many(Object count) {
    return Intl.message(
      '$count images found. Do you want to import them ?',
      name: 'articles_importer_images_found_many',
      desc: '',
      args: [count],
    );
  }

  /// `1 image found. Do you want to import it ?`
  String get articles_importer_image_found_single {
    return Intl.message(
      '1 image found. Do you want to import it ?',
      name: 'articles_importer_image_found_single',
      desc: '',
      args: [],
    );
  }

  /// `Import images`
  String get articles_importer_import_images_title {
    return Intl.message(
      'Import images',
      name: 'articles_importer_import_images_title',
      desc: '',
      args: [],
    );
  }

  /// `Import`
  String get articles_importer_import_images_button {
    return Intl.message(
      'Import',
      name: 'articles_importer_import_images_button',
      desc: '',
      args: [],
    );
  }

  /// `Don't import`
  String get articles_importer_dont_import_images_button {
    return Intl.message(
      'Don\'t import',
      name: 'articles_importer_dont_import_images_button',
      desc: '',
      args: [],
    );
  }

  /// `No articles for this category yet, import, or write one !`
  String get articles_empty_menu_page_text {
    return Intl.message(
      'No articles for this category yet, import, or write one !',
      name: 'articles_empty_menu_page_text',
      desc: '',
      args: [],
    );
  }

  /// `No saved article yet`
  String get articles_empty_menu_saved_page_text {
    return Intl.message(
      'No saved article yet',
      name: 'articles_empty_menu_saved_page_text',
      desc: '',
      args: [],
    );
  }

  /// `New article`
  String get articles_new_article {
    return Intl.message(
      'New article',
      name: 'articles_new_article',
      desc: '',
      args: [],
    );
  }

  /// `Import articles`
  String get articles_import_articles {
    return Intl.message(
      'Import articles',
      name: 'articles_import_articles',
      desc: '',
      args: [],
    );
  }

  /// `Export this article`
  String get articles_export_articles {
    return Intl.message(
      'Export this article',
      name: 'articles_export_articles',
      desc: '',
      args: [],
    );
  }

  /// `Choose a category`
  String get articles_export_articles_choose_category {
    return Intl.message(
      'Choose a category',
      name: 'articles_export_articles_choose_category',
      desc: '',
      args: [],
    );
  }

  /// `Article has not been exported`
  String get articles_export_canceled {
    return Intl.message(
      'Article has not been exported',
      name: 'articles_export_canceled',
      desc: '',
      args: [],
    );
  }

  /// `Article has been exported`
  String get articles_export_confirmed {
    return Intl.message(
      'Article has been exported',
      name: 'articles_export_confirmed',
      desc: '',
      args: [],
    );
  }

  /// `See the location`
  String get articles_export_confirmed_button {
    return Intl.message(
      'See the location',
      name: 'articles_export_confirmed_button',
      desc: '',
      args: [],
    );
  }

  /// `Creativity`
  String get articles_creativity_title {
    return Intl.message(
      'Creativity',
      name: 'articles_creativity_title',
      desc: '',
      args: [],
    );
  }

  /// `Daily life`
  String get articles_daily_life_title {
    return Intl.message(
      'Daily life',
      name: 'articles_daily_life_title',
      desc: '',
      args: [],
    );
  }

  /// `Professional`
  String get articles_professional_title {
    return Intl.message(
      'Professional',
      name: 'articles_professional_title',
      desc: '',
      args: [],
    );
  }

  /// `Wellness`
  String get articles_wellness_title {
    return Intl.message(
      'Wellness',
      name: 'articles_wellness_title',
      desc: '',
      args: [],
    );
  }

  /// `Technology`
  String get articles_technology_title {
    return Intl.message(
      'Technology',
      name: 'articles_technology_title',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get articles_education_title {
    return Intl.message(
      'Education',
      name: 'articles_education_title',
      desc: '',
      args: [],
    );
  }

  /// `Science`
  String get articles_science_title {
    return Intl.message(
      'Science',
      name: 'articles_science_title',
      desc: '',
      args: [],
    );
  }

  /// `Philosophy`
  String get articles_philosophy_title {
    return Intl.message(
      'Philosophy',
      name: 'articles_philosophy_title',
      desc: '',
      args: [],
    );
  }

  /// `Nature`
  String get articles_environment_title {
    return Intl.message(
      'Nature',
      name: 'articles_environment_title',
      desc: '',
      args: [],
    );
  }

  /// `Travel`
  String get articles_travel_title {
    return Intl.message(
      'Travel',
      name: 'articles_travel_title',
      desc: '',
      args: [],
    );
  }

  /// `Finance`
  String get articles_finance_title {
    return Intl.message(
      'Finance',
      name: 'articles_finance_title',
      desc: '',
      args: [],
    );
  }

  /// `Politics`
  String get articles_politics_title {
    return Intl.message(
      'Politics',
      name: 'articles_politics_title',
      desc: '',
      args: [],
    );
  }

  /// `Food`
  String get articles_food_title {
    return Intl.message(
      'Food',
      name: 'articles_food_title',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get articles_saved_title {
    return Intl.message(
      'Saved',
      name: 'articles_saved_title',
      desc: '',
      args: [],
    );
  }

  /// `My Articles`
  String get articles_my_articles_title {
    return Intl.message(
      'My Articles',
      name: 'articles_my_articles_title',
      desc: '',
      args: [],
    );
  }

  /// `Read`
  String get articles_read_button {
    return Intl.message(
      'Read',
      name: 'articles_read_button',
      desc: '',
      args: [],
    );
  }

  /// `Sources`
  String get articles_sources_text {
    return Intl.message(
      'Sources',
      name: 'articles_sources_text',
      desc: '',
      args: [],
    );
  }

  /// `Bookmark article`
  String get articles_bookmark_semantic_text {
    return Intl.message(
      'Bookmark article',
      name: 'articles_bookmark_semantic_text',
      desc: '',
      args: [],
    );
  }

  /// `Add a text bloc`
  String get articles_add_text_semantic_text {
    return Intl.message(
      'Add a text bloc',
      name: 'articles_add_text_semantic_text',
      desc: '',
      args: [],
    );
  }

  /// `Add a subtitle`
  String get articles_add_subtitle_semantic_text {
    return Intl.message(
      'Add a subtitle',
      name: 'articles_add_subtitle_semantic_text',
      desc: '',
      args: [],
    );
  }

  /// `Add an image`
  String get articles_add_image_semantic_text {
    return Intl.message(
      'Add an image',
      name: 'articles_add_image_semantic_text',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get articles_go_back_semantic_text {
    return Intl.message(
      'Previous',
      name: 'articles_go_back_semantic_text',
      desc: '',
      args: [],
    );
  }

  /// `Untitled`
  String get articles_card_untitled {
    return Intl.message(
      'Untitled',
      name: 'articles_card_untitled',
      desc: '',
      args: [],
    );
  }

  /// `Enter a title...`
  String get articles_title_hint {
    return Intl.message(
      'Enter a title...',
      name: 'articles_title_hint',
      desc: '',
      args: [],
    );
  }

  /// `Enter a subtitle...`
  String get articles_subtitle_hint {
    return Intl.message(
      'Enter a subtitle...',
      name: 'articles_subtitle_hint',
      desc: '',
      args: [],
    );
  }

  /// `Enter some text...`
  String get articles_text_hint {
    return Intl.message(
      'Enter some text...',
      name: 'articles_text_hint',
      desc: '',
      args: [],
    );
  }

  /// `Enter some code...`
  String get articles_code_hint {
    return Intl.message(
      'Enter some code...',
      name: 'articles_code_hint',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get articles_copy_text {
    return Intl.message('Copy', name: 'articles_copy_text', desc: '', args: []);
  }

  /// `Add to notes`
  String get articles_copy_to_notes_text {
    return Intl.message(
      'Add to notes',
      name: 'articles_copy_to_notes_text',
      desc: '',
      args: [],
    );
  }

  /// `Add to article`
  String get articles_add_to_content {
    return Intl.message(
      'Add to article',
      name: 'articles_add_to_content',
      desc: '',
      args: [],
    );
  }

  /// `Add an image`
  String get articles_images_add_button {
    return Intl.message(
      'Add an image',
      name: 'articles_images_add_button',
      desc: '',
      args: [],
    );
  }

  /// `Change image`
  String get articles_images_change_button {
    return Intl.message(
      'Change image',
      name: 'articles_images_change_button',
      desc: '',
      args: [],
    );
  }

  /// `this article`
  String get articles_card_delete_this_article {
    return Intl.message(
      'this article',
      name: 'articles_card_delete_this_article',
      desc: '',
      args: [],
    );
  }

  /// `Open menu`
  String get articles_bottom_menu_open_semantic_text {
    return Intl.message(
      'Open menu',
      name: 'articles_bottom_menu_open_semantic_text',
      desc: '',
      args: [],
    );
  }

  /// `Close menu`
  String get articles_bottom_menu_close_semantic_text {
    return Intl.message(
      'Close menu',
      name: 'articles_bottom_menu_close_semantic_text',
      desc: '',
      args: [],
    );
  }

  /// `Sources`
  String get articles_bottom_menu_sources_button {
    return Intl.message(
      'Sources',
      name: 'articles_bottom_menu_sources_button',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get articles_bottom_menu_content_button {
    return Intl.message(
      'Content',
      name: 'articles_bottom_menu_content_button',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get articles_bottom_menu_notes_button {
    return Intl.message(
      'Notes',
      name: 'articles_bottom_menu_notes_button',
      desc: '',
      args: [],
    );
  }

  /// `Indicate a source...`
  String get articles_add_source_hint {
    return Intl.message(
      'Indicate a source...',
      name: 'articles_add_source_hint',
      desc: '',
      args: [],
    );
  }

  /// `Add a source`
  String get articles_add_source_button {
    return Intl.message(
      'Add a source',
      name: 'articles_add_source_button',
      desc: '',
      args: [],
    );
  }

  /// `No notes yet ! Click '{actionName}' on any article element to start taking some.`
  String articles_no_notes(Object actionName) {
    return Intl.message(
      'No notes yet ! Click \'$actionName\' on any article element to start taking some.',
      name: 'articles_no_notes',
      desc: '',
      args: [actionName],
    );
  }

  /// `No sources provided yet! Remember to include sources for future readers.`
  String get articles_no_sources {
    return Intl.message(
      'No sources provided yet! Remember to include sources for future readers.',
      name: 'articles_no_sources',
      desc: '',
      args: [],
    );
  }

  /// `This article is empty ! Start adding elements to move them.`
  String get articles_no_content {
    return Intl.message(
      'This article is empty ! Start adding elements to move them.',
      name: 'articles_no_content',
      desc: '',
      args: [],
    );
  }

  /// `Calculate reading time`
  String get articles_calculate_reading_time {
    return Intl.message(
      'Calculate reading time',
      name: 'articles_calculate_reading_time',
      desc: '',
      args: [],
    );
  }

  /// `Add a list`
  String get articles_add_list_semantic_text {
    return Intl.message(
      'Add a list',
      name: 'articles_add_list_semantic_text',
      desc: '',
      args: [],
    );
  }

  /// `Add a code block`
  String get articles_add_code_semantic_text {
    return Intl.message(
      'Add a code block',
      name: 'articles_add_code_semantic_text',
      desc: '',
      args: [],
    );
  }

  /// `Define language`
  String get articles_define_language {
    return Intl.message(
      'Define language',
      name: 'articles_define_language',
      desc: '',
      args: [],
    );
  }

  /// `Articles have been imported`
  String get articles_imported {
    return Intl.message(
      'Articles have been imported',
      name: 'articles_imported',
      desc: '',
      args: [],
    );
  }

  /// `Articles have not been imported`
  String get articles_not_imported {
    return Intl.message(
      'Articles have not been imported',
      name: 'articles_not_imported',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get snackbar_cancel_button {
    return Intl.message(
      'Close',
      name: 'snackbar_cancel_button',
      desc: '',
      args: [],
    );
  }

  /// `You will need to restart the app to apply changes`
  String get snackbar_restart_needed_text {
    return Intl.message(
      'You will need to restart the app to apply changes',
      name: 'snackbar_restart_needed_text',
      desc: '',
      args: [],
    );
  }

  /// `Close app`
  String get snackbar_restart_button {
    return Intl.message(
      'Close app',
      name: 'snackbar_restart_button',
      desc: '',
      args: [],
    );
  }

  /// `Reset settings ?`
  String get snackbar_reset_text {
    return Intl.message(
      'Reset settings ?',
      name: 'snackbar_reset_text',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get snackbar_reset_button {
    return Intl.message(
      'Reset',
      name: 'snackbar_reset_button',
      desc: '',
      args: [],
    );
  }

  /// `Delete {element} ?`
  String snackbar_delete_element_text(Object element) {
    return Intl.message(
      'Delete $element ?',
      name: 'snackbar_delete_element_text',
      desc: '',
      args: [element],
    );
  }

  /// `Delete`
  String get snackbar_delete_button {
    return Intl.message(
      'Delete',
      name: 'snackbar_delete_button',
      desc: '',
      args: [],
    );
  }

  /// `This article has been save`
  String get snackbar_articles_saved {
    return Intl.message(
      'This article has been save',
      name: 'snackbar_articles_saved',
      desc: '',
      args: [],
    );
  }

  /// `This article has been unsaved`
  String get snackbar_articles_unsaved {
    return Intl.message(
      'This article has been unsaved',
      name: 'snackbar_articles_unsaved',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get snackbar_close_button {
    return Intl.message(
      'Close',
      name: 'snackbar_close_button',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back {user}`
  String snackbar_welcome_back_text(Object user) {
    return Intl.message(
      'Welcome back $user',
      name: 'snackbar_welcome_back_text',
      desc: '',
      args: [user],
    );
  }

  /// `Thank's`
  String get snackbar_welcome_back_button {
    return Intl.message(
      'Thank\'s',
      name: 'snackbar_welcome_back_button',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home_appbar {
    return Intl.message('Home', name: 'home_appbar', desc: '', args: []);
  }

  /// `Good morning {username}`
  String greeting_morning(Object username) {
    return Intl.message(
      'Good morning $username',
      name: 'greeting_morning',
      desc: '',
      args: [username],
    );
  }

  /// `Good afternoon {username}`
  String greeting_afternoon(Object username) {
    return Intl.message(
      'Good afternoon $username',
      name: 'greeting_afternoon',
      desc: '',
      args: [username],
    );
  }

  /// `Good evening {username}`
  String greeting_evening(Object username) {
    return Intl.message(
      'Good evening $username',
      name: 'greeting_evening',
      desc: '',
      args: [username],
    );
  }

  /// `Pick up where you left off`
  String get home_pick_up {
    return Intl.message(
      'Pick up where you left off',
      name: 'home_pick_up',
      desc: '',
      args: [],
    );
  }

  /// `Discover minddy`
  String get home_discover {
    return Intl.message(
      'Discover minddy',
      name: 'home_discover',
      desc: '',
      args: [],
    );
  }

  /// `Open this article`
  String get home_articles_card_open_hint {
    return Intl.message(
      'Open this article',
      name: 'home_articles_card_open_hint',
      desc: '',
      args: [],
    );
  }

  /// `New project`
  String get submenu_new_project_title {
    return Intl.message(
      'New project',
      name: 'submenu_new_project_title',
      desc: '',
      args: [],
    );
  }

  /// `Project's name`
  String get submenu_new_project_subtitle {
    return Intl.message(
      'Project\'s name',
      name: 'submenu_new_project_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter the project's name...`
  String get submenu_new_project_hint {
    return Intl.message(
      'Enter the project\'s name...',
      name: 'submenu_new_project_hint',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get submenu_new_project_button {
    return Intl.message(
      'Create',
      name: 'submenu_new_project_button',
      desc: '',
      args: [],
    );
  }

  /// `Please, provide a project name`
  String get submenu_new_project_errorMessage {
    return Intl.message(
      'Please, provide a project name',
      name: 'submenu_new_project_errorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get submenu_artilces_image_description_title {
    return Intl.message(
      'Description',
      name: 'submenu_artilces_image_description_title',
      desc: '',
      args: [],
    );
  }

  /// `Image description`
  String get submenu_artilces_image_description_subtitle {
    return Intl.message(
      'Image description',
      name: 'submenu_artilces_image_description_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Write the image description...`
  String get submenu_artilces_image_description_hint {
    return Intl.message(
      'Write the image description...',
      name: 'submenu_artilces_image_description_hint',
      desc: '',
      args: [],
    );
  }

  /// `Validate`
  String get submenu_artilces_image_description_button {
    return Intl.message(
      'Validate',
      name: 'submenu_artilces_image_description_button',
      desc: '',
      args: [],
    );
  }

  /// `Password hint`
  String get submenu_welcome_password_mnemonic_sentence_title {
    return Intl.message(
      'Password hint',
      name: 'submenu_welcome_password_mnemonic_sentence_title',
      desc: '',
      args: [],
    );
  }

  /// `Add a password hint`
  String get submenu_welcome_password_mnemonic_sentence_subtitle {
    return Intl.message(
      'Add a password hint',
      name: 'submenu_welcome_password_mnemonic_sentence_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password hint`
  String get submenu_welcome_password_mnemonic_sentence_hint {
    return Intl.message(
      'Enter your password hint',
      name: 'submenu_welcome_password_mnemonic_sentence_hint',
      desc: '',
      args: [],
    );
  }

  /// `This feature assists you in recalling your password if you forget it. It is not recommended to enter your password directly; please provide a hint instead.`
  String get submenu_welcome_password_mnemonic_sentence_instructs {
    return Intl.message(
      'This feature assists you in recalling your password if you forget it. It is not recommended to enter your password directly; please provide a hint instead.',
      name: 'submenu_welcome_password_mnemonic_sentence_instructs',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get submenu_unlock_subtitle_text {
    return Intl.message(
      'Enter your password',
      name: 'submenu_unlock_subtitle_text',
      desc: '',
      args: [],
    );
  }

  /// `Show the password hint`
  String get submenu_unlock_show_mnemonic {
    return Intl.message(
      'Show the password hint',
      name: 'submenu_unlock_show_mnemonic',
      desc: '',
      args: [],
    );
  }

  /// `Hide the password hint`
  String get submenu_unlock_hide_mnemonic {
    return Intl.message(
      'Hide the password hint',
      name: 'submenu_unlock_hide_mnemonic',
      desc: '',
      args: [],
    );
  }

  /// `Incorect password`
  String get submenu_unlock_error_message_incorrect_password {
    return Intl.message(
      'Incorect password',
      name: 'submenu_unlock_error_message_incorrect_password',
      desc: '',
      args: [],
    );
  }

  /// `Please, enter your password`
  String get submenu_unlock_error_message_please_enter_password {
    return Intl.message(
      'Please, enter your password',
      name: 'submenu_unlock_error_message_please_enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Unable to verify password.`
  String get submenu_unlock_error_message_error_login {
    return Intl.message(
      'Unable to verify password.',
      name: 'submenu_unlock_error_message_error_login',
      desc: '',
      args: [],
    );
  }

  /// `Unlock`
  String get submenu_unlock_content_title {
    return Intl.message(
      'Unlock',
      name: 'submenu_unlock_content_title',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get custom_date_picker_start {
    return Intl.message(
      'Start',
      name: 'custom_date_picker_start',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get custom_date_picker_end {
    return Intl.message(
      'End',
      name: 'custom_date_picker_end',
      desc: '',
      args: [],
    );
  }

  /// `Invalid date`
  String get custom_date_picker_invalid_date {
    return Intl.message(
      'Invalid date',
      name: 'custom_date_picker_invalid_date',
      desc: '',
      args: [],
    );
  }

  /// `Select a date`
  String get custom_date_picker_select_single_date_title {
    return Intl.message(
      'Select a date',
      name: 'custom_date_picker_select_single_date_title',
      desc: '',
      args: [],
    );
  }

  /// `Select dates`
  String get custom_date_picker_select_multiples_date_title {
    return Intl.message(
      'Select dates',
      name: 'custom_date_picker_select_multiples_date_title',
      desc: '',
      args: [],
    );
  }

  /// `Include hour`
  String get custom_date_picker_include_hour {
    return Intl.message(
      'Include hour',
      name: 'custom_date_picker_include_hour',
      desc: '',
      args: [],
    );
  }

  /// `Modify`
  String get project_card_open_settings {
    return Intl.message(
      'Modify',
      name: 'project_card_open_settings',
      desc: '',
      args: [],
    );
  }

  /// `Duplicate`
  String get project_card_duplicate {
    return Intl.message(
      'Duplicate',
      name: 'project_card_duplicate',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get project_card_delete {
    return Intl.message(
      'Delete',
      name: 'project_card_delete',
      desc: '',
      args: [],
    );
  }

  /// `Work session duration`
  String get tool_pomodoro_work_duration {
    return Intl.message(
      'Work session duration',
      name: 'tool_pomodoro_work_duration',
      desc: '',
      args: [],
    );
  }

  /// `Work`
  String get tool_pomodoro_work_session {
    return Intl.message(
      'Work',
      name: 'tool_pomodoro_work_session',
      desc: '',
      args: [],
    );
  }

  /// `Break session duration`
  String get tool_pomodoro_break_duration {
    return Intl.message(
      'Break session duration',
      name: 'tool_pomodoro_break_duration',
      desc: '',
      args: [],
    );
  }

  /// `Break`
  String get tool_pomodoro_break_session {
    return Intl.message(
      'Break',
      name: 'tool_pomodoro_break_session',
      desc: '',
      args: [],
    );
  }

  /// `{duration, plural, =0 {Pomodoro - It's time for a break} one {Pomodoro - It's time for a break for {duration} minute} other {Pomodoro - It's time for a break for {duration} minutes}}`
  String tool_pomodoro_break_snackbar(num duration) {
    return Intl.plural(
      duration,
      zero: 'Pomodoro - It\'s time for a break',
      one: 'Pomodoro - It\'s time for a break for $duration minute',
      other: 'Pomodoro - It\'s time for a break for $duration minutes',
      name: 'tool_pomodoro_break_snackbar',
      desc: '',
      args: [duration],
    );
  }

  /// `{duration, plural, =0 {Pomodoro - It's time to get back to work} one {Pomodoro - It's time to get back to work for {duration} minute} other {Pomodoro - It's time to get back to work for {duration} minutes}}`
  String tool_pomodoro_work_snackbar(num duration) {
    return Intl.plural(
      duration,
      zero: 'Pomodoro - It\'s time to get back to work',
      one: 'Pomodoro - It\'s time to get back to work for $duration minute',
      other: 'Pomodoro - It\'s time to get back to work for $duration minutes',
      name: 'tool_pomodoro_work_snackbar',
      desc: '',
      args: [duration],
    );
  }

  /// `Pomodoro session is over, you worked {duration, plural, one {1 minute} other {{duration} minutes}}. Time to take a rest !`
  String tool_pomodoro_end_session(num duration) {
    return Intl.message(
      'Pomodoro session is over, you worked ${Intl.plural(duration, one: '1 minute', other: '$duration minutes')}. Time to take a rest !',
      name: 'tool_pomodoro_end_session',
      desc: '',
      args: [duration],
    );
  }

  /// `Repetition count`
  String get tool_pomodoro_repetition_count {
    return Intl.message(
      'Repetition count',
      name: 'tool_pomodoro_repetition_count',
      desc: '',
      args: [],
    );
  }

  /// `Focus timer`
  String get tool_pomodoro_focus_timer {
    return Intl.message(
      'Focus timer',
      name: 'tool_pomodoro_focus_timer',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get tool_pomodoro_start_button {
    return Intl.message(
      'Start',
      name: 'tool_pomodoro_start_button',
      desc: '',
      args: [],
    );
  }

  /// `Stop`
  String get tool_pomodoro_stop_button {
    return Intl.message(
      'Stop',
      name: 'tool_pomodoro_stop_button',
      desc: '',
      args: [],
    );
  }

  /// `Next page (⌘ + ⭢)`
  String get projects_next_page_shortcut_tooltip_mac {
    return Intl.message(
      'Next page (⌘ + ⭢)',
      name: 'projects_next_page_shortcut_tooltip_mac',
      desc: '',
      args: [],
    );
  }

  /// `Previous page (⌘ + ⭠)`
  String get projects_previous_page_shortcut_tooltip_mac {
    return Intl.message(
      'Previous page (⌘ + ⭠)',
      name: 'projects_previous_page_shortcut_tooltip_mac',
      desc: '',
      args: [],
    );
  }

  /// `Next page (ctrl + ⭢)`
  String get projects_next_page_shortcut_tooltip {
    return Intl.message(
      'Next page (ctrl + ⭢)',
      name: 'projects_next_page_shortcut_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Previous page (ctrl + ⭠)`
  String get projects_previous_page_shortcut_tooltip {
    return Intl.message(
      'Previous page (ctrl + ⭠)',
      name: 'projects_previous_page_shortcut_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `New module`
  String get projects_add_module_tooltip {
    return Intl.message(
      'New module',
      name: 'projects_add_module_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get projects_save_project_button_tooltip {
    return Intl.message(
      'Save',
      name: 'projects_save_project_button_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get projects_module_help_text {
    return Intl.message(
      'Help',
      name: 'projects_module_help_text',
      desc: '',
      args: [],
    );
  }

  /// `Tasks`
  String get projects_module_tasks_title {
    return Intl.message(
      'Tasks',
      name: 'projects_module_tasks_title',
      desc: '',
      args: [],
    );
  }

  /// `{totalTasksCount, plural, =0 {No tasks} one {{checkedTasks}/{totalTasksCount} task completed} other {{checkedTasks}/{totalTasksCount} tasks completed}}`
  String projects_module_tasks_completed(
    num totalTasksCount,
    Object checkedTasks,
  ) {
    return Intl.plural(
      totalTasksCount,
      zero: 'No tasks',
      one: '$checkedTasks/$totalTasksCount task completed',
      other: '$checkedTasks/$totalTasksCount tasks completed',
      name: 'projects_module_tasks_completed',
      desc: '',
      args: [totalTasksCount, checkedTasks],
    );
  }

  /// `Title`
  String get projects_module_tasks_task_title_hint {
    return Intl.message(
      'Title',
      name: 'projects_module_tasks_task_title_hint',
      desc: '',
      args: [],
    );
  }

  /// `Add a subtask`
  String get projects_module_tasks_task_add_subtask_tooltip {
    return Intl.message(
      'Add a subtask',
      name: 'projects_module_tasks_task_add_subtask_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Add a new task`
  String get projects_module_tasks_add_task_tooltip {
    return Intl.message(
      'Add a new task',
      name: 'projects_module_tasks_add_task_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `New category`
  String get projects_module_notes_new_category_tooltip {
    return Intl.message(
      'New category',
      name: 'projects_module_notes_new_category_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `New note`
  String get projects_module_notes_new_note_tooltip {
    return Intl.message(
      'New note',
      name: 'projects_module_notes_new_note_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Modify`
  String get projects_module_notes_modify_category {
    return Intl.message(
      'Modify',
      name: 'projects_module_notes_modify_category',
      desc: '',
      args: [],
    );
  }

  /// `Modify this note`
  String get projects_module_notes_modify_note_tooltip {
    return Intl.message(
      'Modify this note',
      name: 'projects_module_notes_modify_note_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `New category`
  String get projects_module_notes_new_category_sub_menu_title {
    return Intl.message(
      'New category',
      name: 'projects_module_notes_new_category_sub_menu_title',
      desc: '',
      args: [],
    );
  }

  /// `Category name`
  String get projects_module_notes_new_category_sub_menu_subtitle {
    return Intl.message(
      'Category name',
      name: 'projects_module_notes_new_category_sub_menu_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter the category name`
  String get projects_module_notes_new_category_sub_menu_name_hint {
    return Intl.message(
      'Enter the category name',
      name: 'projects_module_notes_new_category_sub_menu_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Private category`
  String get projects_module_notes_new_category_sub_menu_is_private {
    return Intl.message(
      'Private category',
      name: 'projects_module_notes_new_category_sub_menu_is_private',
      desc: '',
      args: [],
    );
  }

  /// `Please, name the category`
  String get projects_module_notes_new_category_sub_menu_error_message {
    return Intl.message(
      'Please, name the category',
      name: 'projects_module_notes_new_category_sub_menu_error_message',
      desc: '',
      args: [],
    );
  }

  /// `By enabling this option, your password will be required to open this category.`
  String get projects_module_notes_new_category_sub_menu_is_private_tooltip {
    return Intl.message(
      'By enabling this option, your password will be required to open this category.',
      name: 'projects_module_notes_new_category_sub_menu_is_private_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Modify category`
  String get projects_module_notes_modify_category_sub_menu_title {
    return Intl.message(
      'Modify category',
      name: 'projects_module_notes_modify_category_sub_menu_title',
      desc: '',
      args: [],
    );
  }

  /// `Save note`
  String get projects_module_notes_editing_note_sub_menu_save_tooltip {
    return Intl.message(
      'Save note',
      name: 'projects_module_notes_editing_note_sub_menu_save_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Move`
  String get projects_module_notes_editing_note_sub_menu_move_tooltip {
    return Intl.message(
      'Move',
      name: 'projects_module_notes_editing_note_sub_menu_move_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Notes for later`
  String get projects_module_notes_for_later_title {
    return Intl.message(
      'Notes for later',
      name: 'projects_module_notes_for_later_title',
      desc: '',
      args: [],
    );
  }

  /// `Important notes`
  String get projects_module_notes_important_notes_title {
    return Intl.message(
      'Important notes',
      name: 'projects_module_notes_important_notes_title',
      desc: '',
      args: [],
    );
  }

  /// `Privates notes`
  String get projects_module_notes_private_notes_title {
    return Intl.message(
      'Privates notes',
      name: 'projects_module_notes_private_notes_title',
      desc: '',
      args: [],
    );
  }

  /// `Project notes`
  String get projects_module_notes_project_notes_title {
    return Intl.message(
      'Project notes',
      name: 'projects_module_notes_project_notes_title',
      desc: '',
      args: [],
    );
  }

  /// `{totalNotesCount, plural, =0 {No note} one {1 note} other {{totalNotesCount} notes}}`
  String projects_module_notes_category_note_count(num totalNotesCount) {
    return Intl.plural(
      totalNotesCount,
      zero: 'No note',
      one: '1 note',
      other: '$totalNotesCount notes',
      name: 'projects_module_notes_category_note_count',
      desc: '',
      args: [totalNotesCount],
    );
  }

  /// `Notes`
  String get projects_module_notes_title {
    return Intl.message(
      'Notes',
      name: 'projects_module_notes_title',
      desc: '',
      args: [],
    );
  }

  /// `Spreadsheet`
  String get projects_module_spreadsheet_title {
    return Intl.message(
      'Spreadsheet',
      name: 'projects_module_spreadsheet_title',
      desc: '',
      args: [],
    );
  }

  /// `Unnamed`
  String get projects_module_spreadsheet_value_unnamed {
    return Intl.message(
      'Unnamed',
      name: 'projects_module_spreadsheet_value_unnamed',
      desc: '',
      args: [],
    );
  }

  /// `New row`
  String get projects_module_spreadsheet_new_row {
    return Intl.message(
      'New row',
      name: 'projects_module_spreadsheet_new_row',
      desc: '',
      args: [],
    );
  }

  /// `New column`
  String get projects_module_spreadsheet_new_column {
    return Intl.message(
      'New column',
      name: 'projects_module_spreadsheet_new_column',
      desc: '',
      args: [],
    );
  }

  /// `Delete this row`
  String get projects_module_spreadsheet_delete_row {
    return Intl.message(
      'Delete this row',
      name: 'projects_module_spreadsheet_delete_row',
      desc: '',
      args: [],
    );
  }

  /// `Delete this column`
  String get projects_module_spreadsheet_delete_column {
    return Intl.message(
      'Delete this column',
      name: 'projects_module_spreadsheet_delete_column',
      desc: '',
      args: [],
    );
  }

  /// `Column type`
  String get projects_module_spreadsheet_data_column_type {
    return Intl.message(
      'Column type',
      name: 'projects_module_spreadsheet_data_column_type',
      desc: '',
      args: [],
    );
  }

  /// `Choose a column type`
  String get projects_module_spreadsheet_data_choose_column_type_tooltip {
    return Intl.message(
      'Choose a column type',
      name: 'projects_module_spreadsheet_data_choose_column_type_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Text`
  String get projects_module_spreadsheet_data_type_text {
    return Intl.message(
      'Text',
      name: 'projects_module_spreadsheet_data_type_text',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get projects_module_spreadsheet_data_type_number {
    return Intl.message(
      'Number',
      name: 'projects_module_spreadsheet_data_type_number',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get projects_module_spreadsheet_data_type_phone_number {
    return Intl.message(
      'Phone number',
      name: 'projects_module_spreadsheet_data_type_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get projects_module_spreadsheet_data_type_email {
    return Intl.message(
      'E-mail',
      name: 'projects_module_spreadsheet_data_type_email',
      desc: '',
      args: [],
    );
  }

  /// `URL`
  String get projects_module_spreadsheet_data_type_url {
    return Intl.message(
      'URL',
      name: 'projects_module_spreadsheet_data_type_url',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get projects_module_spreadsheet_data_type_date {
    return Intl.message(
      'Date',
      name: 'projects_module_spreadsheet_data_type_date',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get projects_module_spreadsheet_date_from_text {
    return Intl.message(
      'From',
      name: 'projects_module_spreadsheet_date_from_text',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get projects_module_spreadsheet_date_to_text {
    return Intl.message(
      'To',
      name: 'projects_module_spreadsheet_date_to_text',
      desc: '',
      args: [],
    );
  }

  /// `Single date`
  String get projects_module_spreadsheet_date_single_tooltip {
    return Intl.message(
      'Single date',
      name: 'projects_module_spreadsheet_date_single_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Add an end date`
  String get projects_module_spreadsheet_date_start_end_tooltip {
    return Intl.message(
      'Add an end date',
      name: 'projects_module_spreadsheet_date_start_end_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Selection`
  String get projects_module_spreadsheet_data_type_selection {
    return Intl.message(
      'Selection',
      name: 'projects_module_spreadsheet_data_type_selection',
      desc: '',
      args: [],
    );
  }

  /// `Open {websiteName}`
  String projetcs_module_spreadsheet_open_website(Object websiteName) {
    return Intl.message(
      'Open $websiteName',
      name: 'projetcs_module_spreadsheet_open_website',
      desc: '',
      args: [websiteName],
    );
  }

  /// `None`
  String get projects_module_spreadsheet_number_operation_none {
    return Intl.message(
      'None',
      name: 'projects_module_spreadsheet_number_operation_none',
      desc: '',
      args: [],
    );
  }

  /// `Sum`
  String get projects_module_spreadsheet_number_operation_sum {
    return Intl.message(
      'Sum',
      name: 'projects_module_spreadsheet_number_operation_sum',
      desc: '',
      args: [],
    );
  }

  /// `Average`
  String get projects_module_spreadsheet_number_operation_average {
    return Intl.message(
      'Average',
      name: 'projects_module_spreadsheet_number_operation_average',
      desc: '',
      args: [],
    );
  }

  /// `Maximum`
  String get projects_module_spreadsheet_number_operation_maximum {
    return Intl.message(
      'Maximum',
      name: 'projects_module_spreadsheet_number_operation_maximum',
      desc: '',
      args: [],
    );
  }

  /// `Minimum`
  String get projects_module_spreadsheet_number_operation_minimum {
    return Intl.message(
      'Minimum',
      name: 'projects_module_spreadsheet_number_operation_minimum',
      desc: '',
      args: [],
    );
  }

  /// `Interval`
  String get projects_module_spreadsheet_number_operation_interval {
    return Intl.message(
      'Interval',
      name: 'projects_module_spreadsheet_number_operation_interval',
      desc: '',
      args: [],
    );
  }

  /// `Median`
  String get projects_module_spreadsheet_number_operation_median {
    return Intl.message(
      'Median',
      name: 'projects_module_spreadsheet_number_operation_median',
      desc: '',
      args: [],
    );
  }

  /// `Standard deviation`
  String get projects_module_spreadsheet_number_operation_standard_deviation {
    return Intl.message(
      'Standard deviation',
      name: 'projects_module_spreadsheet_number_operation_standard_deviation',
      desc: '',
      args: [],
    );
  }

  /// `Calculate`
  String get projects_module_spreadsheet_number_operation_calculate {
    return Intl.message(
      'Calculate',
      name: 'projects_module_spreadsheet_number_operation_calculate',
      desc: '',
      args: [],
    );
  }

  /// `10 + 50 + 100`
  String get projects_module_spreadsheet_number_operation_sum_example {
    return Intl.message(
      '10 + 50 + 100',
      name: 'projects_module_spreadsheet_number_operation_sum_example',
      desc: '',
      args: [],
    );
  }

  /// `Adds up all the values in the column to get the total. Useful for summing up data.`
  String get projects_module_spreadsheet_number_operation_sum_message {
    return Intl.message(
      'Adds up all the values in the column to get the total. Useful for summing up data.',
      name: 'projects_module_spreadsheet_number_operation_sum_message',
      desc: '',
      args: [],
    );
  }

  /// `(10 + 50 + 100) / 3`
  String get projects_module_spreadsheet_number_operation_average_example {
    return Intl.message(
      '(10 + 50 + 100) / 3',
      name: 'projects_module_spreadsheet_number_operation_average_example',
      desc: '',
      args: [],
    );
  }

  /// `Calculates the average by dividing the sum of all values by the number of values. This helps in finding the central value of the data.`
  String get projects_module_spreadsheet_number_operation_average_message {
    return Intl.message(
      'Calculates the average by dividing the sum of all values by the number of values. This helps in finding the central value of the data.',
      name: 'projects_module_spreadsheet_number_operation_average_message',
      desc: '',
      args: [],
    );
  }

  /// `(10, 50, 100) = 100`
  String get projects_module_spreadsheet_number_operation_maximum_example {
    return Intl.message(
      '(10, 50, 100) = 100',
      name: 'projects_module_spreadsheet_number_operation_maximum_example',
      desc: '',
      args: [],
    );
  }

  /// `Finds the highest value in the column. Useful for identifying the largest number.`
  String get projects_module_spreadsheet_number_operation_maximum_message {
    return Intl.message(
      'Finds the highest value in the column. Useful for identifying the largest number.',
      name: 'projects_module_spreadsheet_number_operation_maximum_message',
      desc: '',
      args: [],
    );
  }

  /// `(10, 50, 100) = 10`
  String get projects_module_spreadsheet_number_operation_minimum_example {
    return Intl.message(
      '(10, 50, 100) = 10',
      name: 'projects_module_spreadsheet_number_operation_minimum_example',
      desc: '',
      args: [],
    );
  }

  /// `Finds the lowest value in the column. This helps in identifying the smallest number.`
  String get projects_module_spreadsheet_number_operation_minimum_message {
    return Intl.message(
      'Finds the lowest value in the column. This helps in identifying the smallest number.',
      name: 'projects_module_spreadsheet_number_operation_minimum_message',
      desc: '',
      args: [],
    );
  }

  /// `(10, 50, 100) = 90`
  String get projects_module_spreadsheet_number_operation_interval_example {
    return Intl.message(
      '(10, 50, 100) = 90',
      name: 'projects_module_spreadsheet_number_operation_interval_example',
      desc: '',
      args: [],
    );
  }

  /// `Calculates the range by subtracting the smallest value from the largest value in the column. It shows the spread of the values.`
  String get projects_module_spreadsheet_number_operation_interval_message {
    return Intl.message(
      'Calculates the range by subtracting the smallest value from the largest value in the column. It shows the spread of the values.',
      name: 'projects_module_spreadsheet_number_operation_interval_message',
      desc: '',
      args: [],
    );
  }

  /// `(10, 50, 100) = 50`
  String get projects_module_spreadsheet_number_operation_median_example {
    return Intl.message(
      '(10, 50, 100) = 50',
      name: 'projects_module_spreadsheet_number_operation_median_example',
      desc: '',
      args: [],
    );
  }

  /// `Finds the middle value when the column values are sorted. Useful for identifying the central value.`
  String get projects_module_spreadsheet_number_operation_median_message {
    return Intl.message(
      'Finds the middle value when the column values are sorted. Useful for identifying the central value.',
      name: 'projects_module_spreadsheet_number_operation_median_message',
      desc: '',
      args: [],
    );
  }

  /// `√[((10-53.33)² + (50-53.33)² + (100-53.33)²) / 3]`
  String
  get projects_module_spreadsheet_number_operation_standardDeviation_example {
    return Intl.message(
      '√[((10-53.33)² + (50-53.33)² + (100-53.33)²) / 3]',
      name:
          'projects_module_spreadsheet_number_operation_standardDeviation_example',
      desc: '',
      args: [],
    );
  }

  /// `Calculates the standard deviation to measure how much the values vary from the average. Here, 53.33 is the mean of the values 10, 50, and 100.`
  String
  get projects_module_spreadsheet_number_operation_standardDeviation_message {
    return Intl.message(
      'Calculates the standard deviation to measure how much the values vary from the average. Here, 53.33 is the mean of the values 10, 50, and 100.',
      name:
          'projects_module_spreadsheet_number_operation_standardDeviation_message',
      desc: '',
      args: [],
    );
  }

  /// `Extend this cell`
  String get projects_module_spreadsheet_extend_cell_tooltip {
    return Intl.message(
      'Extend this cell',
      name: 'projects_module_spreadsheet_extend_cell_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Not started`
  String get projects_module_spreadsheet_selection_cell_not_started {
    return Intl.message(
      'Not started',
      name: 'projects_module_spreadsheet_selection_cell_not_started',
      desc: '',
      args: [],
    );
  }

  /// `Started`
  String get projects_module_spreadsheet_selection_cell_started {
    return Intl.message(
      'Started',
      name: 'projects_module_spreadsheet_selection_cell_started',
      desc: '',
      args: [],
    );
  }

  /// `Finished`
  String get projects_module_spreadsheet_selection_cell_finished {
    return Intl.message(
      'Finished',
      name: 'projects_module_spreadsheet_selection_cell_finished',
      desc: '',
      args: [],
    );
  }

  /// `Modify options`
  String get projects_module_spreadsheet_selection_cell_modify_options {
    return Intl.message(
      'Modify options',
      name: 'projects_module_spreadsheet_selection_cell_modify_options',
      desc: '',
      args: [],
    );
  }

  /// `Add options`
  String get projects_module_spreadsheet_selection_cell_add_options {
    return Intl.message(
      'Add options',
      name: 'projects_module_spreadsheet_selection_cell_add_options',
      desc: '',
      args: [],
    );
  }

  /// `Add an option`
  String get projects_module_spreadsheet_selection_cell_add_an_option {
    return Intl.message(
      'Add an option',
      name: 'projects_module_spreadsheet_selection_cell_add_an_option',
      desc: '',
      args: [],
    );
  }

  /// `All options`
  String get projects_module_spreadsheet_selection_cell_all_options {
    return Intl.message(
      'All options',
      name: 'projects_module_spreadsheet_selection_cell_all_options',
      desc: '',
      args: [],
    );
  }

  /// `Name this option...`
  String get projects_module_spreadsheet_selection_cell_name_option_hint {
    return Intl.message(
      'Name this option...',
      name: 'projects_module_spreadsheet_selection_cell_name_option_hint',
      desc: '',
      args: [],
    );
  }

  /// `Organize columns`
  String get projects_module_spreadsheet_manage_columns_sub_menu_title {
    return Intl.message(
      'Organize columns',
      name: 'projects_module_spreadsheet_manage_columns_sub_menu_title',
      desc: '',
      args: [],
    );
  }

  /// `All columns`
  String get projects_module_spreadsheet_manage_columns_sub_menu_subtitle {
    return Intl.message(
      'All columns',
      name: 'projects_module_spreadsheet_manage_columns_sub_menu_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Organize rows`
  String get projects_module_spreadsheet_manage_rows_sub_menu_title {
    return Intl.message(
      'Organize rows',
      name: 'projects_module_spreadsheet_manage_rows_sub_menu_title',
      desc: '',
      args: [],
    );
  }

  /// `All rows`
  String get projects_module_spreadsheet_manage_rows_sub_menu_subtitle {
    return Intl.message(
      'All rows',
      name: 'projects_module_spreadsheet_manage_rows_sub_menu_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Please, add options`
  String
  get projects_module_spreadsheet_selection_sub_menu_error_message_no_options {
    return Intl.message(
      'Please, add options',
      name:
          'projects_module_spreadsheet_selection_sub_menu_error_message_no_options',
      desc: '',
      args: [],
    );
  }

  /// `Please, name all options`
  String
  get projects_module_spreadsheet_selection_sub_menu_error_message_unnamed_option {
    return Intl.message(
      'Please, name all options',
      name:
          'projects_module_spreadsheet_selection_sub_menu_error_message_unnamed_option',
      desc: '',
      args: [],
    );
  }

  /// `Two options can't have the same name ({optionName})`
  String
  projects_module_spreadsheet_selection_sub_menu_error_message_redundant_option_name(
    Object optionName,
  ) {
    return Intl.message(
      'Two options can\'t have the same name ($optionName)',
      name:
          'projects_module_spreadsheet_selection_sub_menu_error_message_redundant_option_name',
      desc: '',
      args: [optionName],
    );
  }

  /// `Two options can't have the same color`
  String
  get projects_module_spreadsheet_selection_sub_menu_error_message_redundant_color {
    return Intl.message(
      'Two options can\'t have the same color',
      name:
          'projects_module_spreadsheet_selection_sub_menu_error_message_redundant_color',
      desc: '',
      args: [],
    );
  }

  /// `Show the table`
  String get projects_module_spreadsheet_chart_show_table {
    return Intl.message(
      'Show the table',
      name: 'projects_module_spreadsheet_chart_show_table',
      desc: '',
      args: [],
    );
  }

  /// `Show the charts`
  String get projects_module_spreadsheet_chart_show_chart {
    return Intl.message(
      'Show the charts',
      name: 'projects_module_spreadsheet_chart_show_chart',
      desc: '',
      args: [],
    );
  }

  /// `New tab`
  String get projects_module_spreadsheet_chart_new_tab {
    return Intl.message(
      'New tab',
      name: 'projects_module_spreadsheet_chart_new_tab',
      desc: '',
      args: [],
    );
  }

  /// `Add a coulumn`
  String get projects_module_spreadsheet_chart_new_column {
    return Intl.message(
      'Add a coulumn',
      name: 'projects_module_spreadsheet_chart_new_column',
      desc: '',
      args: [],
    );
  }

  /// `Chart type`
  String get projects_module_spreadsheet_chart_chart_type_subtitle {
    return Intl.message(
      'Chart type',
      name: 'projects_module_spreadsheet_chart_chart_type_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Donut`
  String get projects_module_spreadsheet_chart_chart_type_donut {
    return Intl.message(
      'Donut',
      name: 'projects_module_spreadsheet_chart_chart_type_donut',
      desc: '',
      args: [],
    );
  }

  /// `Bar`
  String get projects_module_spreadsheet_chart_chart_type_bar {
    return Intl.message(
      'Bar',
      name: 'projects_module_spreadsheet_chart_chart_type_bar',
      desc: '',
      args: [],
    );
  }

  /// `Simple bars`
  String get projects_module_spreadsheet_chart_chart_type_bar_simple {
    return Intl.message(
      'Simple bars',
      name: 'projects_module_spreadsheet_chart_chart_type_bar_simple',
      desc: '',
      args: [],
    );
  }

  /// `Grouped bars`
  String get projects_module_spreadsheet_chart_chart_type_bar_grouped {
    return Intl.message(
      'Grouped bars',
      name: 'projects_module_spreadsheet_chart_chart_type_bar_grouped',
      desc: '',
      args: [],
    );
  }

  /// `Stacked bars`
  String get projects_module_spreadsheet_chart_chart_type_bar_stacked {
    return Intl.message(
      'Stacked bars',
      name: 'projects_module_spreadsheet_chart_chart_type_bar_stacked',
      desc: '',
      args: [],
    );
  }

  /// `Select a column`
  String get projects_module_spreadsheet_chart_chart_select_column {
    return Intl.message(
      'Select a column',
      name: 'projects_module_spreadsheet_chart_chart_select_column',
      desc: '',
      args: [],
    );
  }

  /// `Column`
  String get projects_module_spreadsheet_chart_chart_column_single {
    return Intl.message(
      'Column',
      name: 'projects_module_spreadsheet_chart_chart_column_single',
      desc: '',
      args: [],
    );
  }

  /// `Columns`
  String get projects_module_spreadsheet_chart_chart_column_plural {
    return Intl.message(
      'Columns',
      name: 'projects_module_spreadsheet_chart_chart_column_plural',
      desc: '',
      args: [],
    );
  }

  /// `To create a chart, please add data to it`
  String get custom_chart_empty_content {
    return Intl.message(
      'To create a chart, please add data to it',
      name: 'custom_chart_empty_content',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get custom_chart_donut_total {
    return Intl.message(
      'Total',
      name: 'custom_chart_donut_total',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get custom_chart_donut_share {
    return Intl.message(
      'Share',
      name: 'custom_chart_donut_share',
      desc: '',
      args: [],
    );
  }

  /// `Enlarge chart`
  String get custom_chart_grid_extend_chart {
    return Intl.message(
      'Enlarge chart',
      name: 'custom_chart_grid_extend_chart',
      desc: '',
      args: [],
    );
  }

  /// `Opacity`
  String get custom_color_picker_opacity_tooltip {
    return Intl.message(
      'Opacity',
      name: 'custom_color_picker_opacity_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `New node`
  String get node_editor_view_new_node_tooltip {
    return Intl.message(
      'New node',
      name: 'node_editor_view_new_node_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Close node panel`
  String get node_editor_view_close_node_panel_tooltip {
    return Intl.message(
      'Close node panel',
      name: 'node_editor_view_close_node_panel_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Open node panel`
  String get node_editor_view_open_node_panel_tooltip {
    return Intl.message(
      'Open node panel',
      name: 'node_editor_view_open_node_panel_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Close side panel`
  String get node_editor_view_close_side_panel_tooltip {
    return Intl.message(
      'Close side panel',
      name: 'node_editor_view_close_side_panel_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Open side panel`
  String get node_editor_view_open_side_panel_tooltip {
    return Intl.message(
      'Open side panel',
      name: 'node_editor_view_open_side_panel_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Variables`
  String get node_editor_view_side_panel_variables_title {
    return Intl.message(
      'Variables',
      name: 'node_editor_view_side_panel_variables_title',
      desc: '',
      args: [],
    );
  }

  /// `New variable`
  String get node_editor_view_side_panel_variables_add_button_tooltip {
    return Intl.message(
      'New variable',
      name: 'node_editor_view_side_panel_variables_add_button_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Not defined`
  String get node_editor_view_side_panel_variables_variable_type_any {
    return Intl.message(
      'Not defined',
      name: 'node_editor_view_side_panel_variables_variable_type_any',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get node_editor_view_side_panel_variables_variable_type_number {
    return Intl.message(
      'Number',
      name: 'node_editor_view_side_panel_variables_variable_type_number',
      desc: '',
      args: [],
    );
  }

  /// `Text`
  String get node_editor_view_side_panel_variables_variable_type_text {
    return Intl.message(
      'Text',
      name: 'node_editor_view_side_panel_variables_variable_type_text',
      desc: '',
      args: [],
    );
  }

  /// `Boolean`
  String get node_editor_view_side_panel_variables_variable_type_boolean {
    return Intl.message(
      'Boolean',
      name: 'node_editor_view_side_panel_variables_variable_type_boolean',
      desc: '',
      args: [],
    );
  }

  /// `List`
  String get node_editor_view_side_panel_variables_variable_type_list {
    return Intl.message(
      'List',
      name: 'node_editor_view_side_panel_variables_variable_type_list',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get node_editor_view_side_panel_variables_variable_type_color {
    return Intl.message(
      'Color',
      name: 'node_editor_view_side_panel_variables_variable_type_color',
      desc: '',
      args: [],
    );
  }

  /// `Node trees`
  String get node_editor_view_side_panel_node_trees_title {
    return Intl.message(
      'Node trees',
      name: 'node_editor_view_side_panel_node_trees_title',
      desc: '',
      args: [],
    );
  }

  /// `New node tree`
  String get node_editor_view_side_panel_node_trees_add_button_tooltip {
    return Intl.message(
      'New node tree',
      name: 'node_editor_view_side_panel_node_trees_add_button_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Undo (ctrl + z)`
  String get node_editor_view_bottom_toolbar_undo_tooltip_windows {
    return Intl.message(
      'Undo (ctrl + z)',
      name: 'node_editor_view_bottom_toolbar_undo_tooltip_windows',
      desc: '',
      args: [],
    );
  }

  /// `Undo (⌘ + z)`
  String get node_editor_view_bottom_toolbar_undo_tooltip_mac {
    return Intl.message(
      'Undo (⌘ + z)',
      name: 'node_editor_view_bottom_toolbar_undo_tooltip_mac',
      desc: '',
      args: [],
    );
  }

  /// `Redo (⇧ + ctrl + z)`
  String get node_editor_view_bottom_toolbar_redo_tooltip_windows {
    return Intl.message(
      'Redo (⇧ + ctrl + z)',
      name: 'node_editor_view_bottom_toolbar_redo_tooltip_windows',
      desc: '',
      args: [],
    );
  }

  /// `Redo (⇧ + ⌘ + z)`
  String get node_editor_view_bottom_toolbar_redo_tooltip_mac {
    return Intl.message(
      'Redo (⇧ + ⌘ + z)',
      name: 'node_editor_view_bottom_toolbar_redo_tooltip_mac',
      desc: '',
      args: [],
    );
  }

  /// `{length, plural, =1{Copy selected node (ctrl + c)} other{Copy selected nodes (ctrl + c)}}`
  String node_editor_view_bottom_toolbar_copy_tooltip_windows(num length) {
    return Intl.plural(
      length,
      one: 'Copy selected node (ctrl + c)',
      other: 'Copy selected nodes (ctrl + c)',
      name: 'node_editor_view_bottom_toolbar_copy_tooltip_windows',
      desc: '',
      args: [length],
    );
  }

  /// `{length, plural, =1{Copy selected node (⌘ + c)} other{Copy selected nodes (⌘ + c)}}`
  String node_editor_view_bottom_toolbar_copy_tooltip_mac(num length) {
    return Intl.plural(
      length,
      one: 'Copy selected node (⌘ + c)',
      other: 'Copy selected nodes (⌘ + c)',
      name: 'node_editor_view_bottom_toolbar_copy_tooltip_mac',
      desc: '',
      args: [length],
    );
  }

  /// `{length, plural, =1{Paste copied node (ctrl + v)} other{Paste copied nodes (ctrl + v)}}`
  String node_editor_view_bottom_toolbar_paste_tooltip_windows(num length) {
    return Intl.plural(
      length,
      one: 'Paste copied node (ctrl + v)',
      other: 'Paste copied nodes (ctrl + v)',
      name: 'node_editor_view_bottom_toolbar_paste_tooltip_windows',
      desc: '',
      args: [length],
    );
  }

  /// `{length, plural, =1{Paste copied node (⌘ + v)} other{Paste copied nodes (⌘ + v)}}`
  String node_editor_view_bottom_toolbar_paste_tooltip_mac(num length) {
    return Intl.plural(
      length,
      one: 'Paste copied node (⌘ + v)',
      other: 'Paste copied nodes (⌘ + v)',
      name: 'node_editor_view_bottom_toolbar_paste_tooltip_mac',
      desc: '',
      args: [length],
    );
  }

  /// `{length, plural, one {Duplicate selected node (ctrl + d)} other {Duplicate selected nodes (ctrl + d)}}`
  String node_editor_view_bottom_toolbar_duplicate_tooltip_windows(num length) {
    return Intl.plural(
      length,
      one: 'Duplicate selected node (ctrl + d)',
      other: 'Duplicate selected nodes (ctrl + d)',
      name: 'node_editor_view_bottom_toolbar_duplicate_tooltip_windows',
      desc: '',
      args: [length],
    );
  }

  /// `{length, plural, one {Duplicate selected node (⌘ + d)} other {Duplicate selected nodes (⌘ + d)}}`
  String node_editor_view_bottom_toolbar_duplicate_tooltip_mac(num length) {
    return Intl.plural(
      length,
      one: 'Duplicate selected node (⌘ + d)',
      other: 'Duplicate selected nodes (⌘ + d)',
      name: 'node_editor_view_bottom_toolbar_duplicate_tooltip_mac',
      desc: '',
      args: [length],
    );
  }

  /// `{length, plural, one {Delete selected node (ctrl + ⌫)} other {Delete selected nodes (ctrl + ⌫)}}`
  String node_editor_view_bottom_toolbar_delete_tooltip_windows(num length) {
    return Intl.plural(
      length,
      one: 'Delete selected node (ctrl + ⌫)',
      other: 'Delete selected nodes (ctrl + ⌫)',
      name: 'node_editor_view_bottom_toolbar_delete_tooltip_windows',
      desc: '',
      args: [length],
    );
  }

  /// `{length, plural, one {Delete selected node (⌘ + ⌫)} other {Delete selected nodes (⌘ + ⌫)}}`
  String node_editor_view_bottom_toolbar_delete_tooltip_mac(num length) {
    return Intl.plural(
      length,
      one: 'Delete selected node (⌘ + ⌫)',
      other: 'Delete selected nodes (⌘ + ⌫)',
      name: 'node_editor_view_bottom_toolbar_delete_tooltip_mac',
      desc: '',
      args: [length],
    );
  }

  /// `Types`
  String get node_editor_add_sub_menu_types {
    return Intl.message(
      'Types',
      name: 'node_editor_add_sub_menu_types',
      desc: '',
      args: [],
    );
  }

  /// `{length, plural, one {Input} other {Inputs}}`
  String node_editor_add_sub_menu_inputs_subtitle(num length) {
    return Intl.plural(
      length,
      one: 'Input',
      other: 'Inputs',
      name: 'node_editor_add_sub_menu_inputs_subtitle',
      desc: '',
      args: [length],
    );
  }

  /// `{length, plural, one {Output} other {Outputs}}`
  String node_editor_add_sub_menu_outputs_subtitle(num length) {
    return Intl.plural(
      length,
      one: 'Output',
      other: 'Outputs',
      name: 'node_editor_add_sub_menu_outputs_subtitle',
      desc: '',
      args: [length],
    );
  }

  /// `Note: Inputs and outputs may vary depending on the options chosen for the node`
  String get node_editor_add_sub_menu_note {
    return Intl.message(
      'Note: Inputs and outputs may vary depending on the options chosen for the node',
      name: 'node_editor_add_sub_menu_note',
      desc: '',
      args: [],
    );
  }

  /// `No nodes found.`
  String get node_editor_add_sub_menu_no_nodes_found {
    return Intl.message(
      'No nodes found.',
      name: 'node_editor_add_sub_menu_no_nodes_found',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get node_editor_add_sub_menu_add_button {
    return Intl.message(
      'Add',
      name: 'node_editor_add_sub_menu_add_button',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get node_editor_add_sub_menu_none_input_output {
    return Intl.message(
      'None',
      name: 'node_editor_add_sub_menu_none_input_output',
      desc: '',
      args: [],
    );
  }

  /// `Value`
  String get node_widgets_value_text {
    return Intl.message(
      'Value',
      name: 'node_widgets_value_text',
      desc: '',
      args: [],
    );
  }

  /// `Result`
  String get node_widgets_result_text {
    return Intl.message(
      'Result',
      name: 'node_widgets_result_text',
      desc: '',
      args: [],
    );
  }

  /// `Text`
  String get node_widgets_text_text {
    return Intl.message(
      'Text',
      name: 'node_widgets_text_text',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get node_widgets_start_text {
    return Intl.message(
      'Start',
      name: 'node_widgets_start_text',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get node_widgets_end_text {
    return Intl.message(
      'End',
      name: 'node_widgets_end_text',
      desc: '',
      args: [],
    );
  }

  /// `Length`
  String get node_widgets_length_text {
    return Intl.message(
      'Length',
      name: 'node_widgets_length_text',
      desc: '',
      args: [],
    );
  }

  /// `Treshold`
  String get node_widgets_treshold_text {
    return Intl.message(
      'Treshold',
      name: 'node_widgets_treshold_text',
      desc: '',
      args: [],
    );
  }

  /// `Math`
  String get node_widgets_category_math {
    return Intl.message(
      'Math',
      name: 'node_widgets_category_math',
      desc: '',
      args: [],
    );
  }

  /// `Logic`
  String get node_widgets_category_logic {
    return Intl.message(
      'Logic',
      name: 'node_widgets_category_logic',
      desc: '',
      args: [],
    );
  }

  /// `Variables`
  String get node_widgets_category_variable {
    return Intl.message(
      'Variables',
      name: 'node_widgets_category_variable',
      desc: '',
      args: [],
    );
  }

  /// `Calculations`
  String get node_widgets_math_node_title {
    return Intl.message(
      'Calculations',
      name: 'node_widgets_math_node_title',
      desc: '',
      args: [],
    );
  }

  /// `Performs calculations on numbers.`
  String get node_widgets_math_node_description {
    return Intl.message(
      'Performs calculations on numbers.',
      name: 'node_widgets_math_node_description',
      desc: '',
      args: [],
    );
  }

  /// `Addition`
  String get node_widgets_math_node_options_addition {
    return Intl.message(
      'Addition',
      name: 'node_widgets_math_node_options_addition',
      desc: '',
      args: [],
    );
  }

  /// `Substraction`
  String get node_widgets_math_node_options_substraction {
    return Intl.message(
      'Substraction',
      name: 'node_widgets_math_node_options_substraction',
      desc: '',
      args: [],
    );
  }

  /// `Division`
  String get node_widgets_math_node_options_division {
    return Intl.message(
      'Division',
      name: 'node_widgets_math_node_options_division',
      desc: '',
      args: [],
    );
  }

  /// `Multiplication`
  String get node_widgets_math_node_options_multiplication {
    return Intl.message(
      'Multiplication',
      name: 'node_widgets_math_node_options_multiplication',
      desc: '',
      args: [],
    );
  }

  /// `Square Root`
  String get node_widgets_math_node_options_squareRoot {
    return Intl.message(
      'Square Root',
      name: 'node_widgets_math_node_options_squareRoot',
      desc: '',
      args: [],
    );
  }

  /// `Power`
  String get node_widgets_math_node_options_power {
    return Intl.message(
      'Power',
      name: 'node_widgets_math_node_options_power',
      desc: '',
      args: [],
    );
  }

  /// `Min`
  String get node_widgets_math_node_options_min {
    return Intl.message(
      'Min',
      name: 'node_widgets_math_node_options_min',
      desc: '',
      args: [],
    );
  }

  /// `Max`
  String get node_widgets_math_node_options_max {
    return Intl.message(
      'Max',
      name: 'node_widgets_math_node_options_max',
      desc: '',
      args: [],
    );
  }

  /// `Sign`
  String get node_widgets_math_node_options_sign {
    return Intl.message(
      'Sign',
      name: 'node_widgets_math_node_options_sign',
      desc: '',
      args: [],
    );
  }

  /// `Round`
  String get node_widgets_math_node_options_round {
    return Intl.message(
      'Round',
      name: 'node_widgets_math_node_options_round',
      desc: '',
      args: [],
    );
  }

  /// `Floor`
  String get node_widgets_math_node_options_floor {
    return Intl.message(
      'Floor',
      name: 'node_widgets_math_node_options_floor',
      desc: '',
      args: [],
    );
  }

  /// `Ceil`
  String get node_widgets_math_node_options_ceil {
    return Intl.message(
      'Ceil',
      name: 'node_widgets_math_node_options_ceil',
      desc: '',
      args: [],
    );
  }

  /// `Truncate`
  String get node_widgets_math_node_options_truncate {
    return Intl.message(
      'Truncate',
      name: 'node_widgets_math_node_options_truncate',
      desc: '',
      args: [],
    );
  }

  /// `Sine`
  String get node_widgets_math_node_options_sin {
    return Intl.message(
      'Sine',
      name: 'node_widgets_math_node_options_sin',
      desc: '',
      args: [],
    );
  }

  /// `Cosine`
  String get node_widgets_math_node_options_cos {
    return Intl.message(
      'Cosine',
      name: 'node_widgets_math_node_options_cos',
      desc: '',
      args: [],
    );
  }

  /// `Tangent`
  String get node_widgets_math_node_options_tan {
    return Intl.message(
      'Tangent',
      name: 'node_widgets_math_node_options_tan',
      desc: '',
      args: [],
    );
  }

  /// `Arcsine`
  String get node_widgets_math_node_options_asin {
    return Intl.message(
      'Arcsine',
      name: 'node_widgets_math_node_options_asin',
      desc: '',
      args: [],
    );
  }

  /// `Arccosine`
  String get node_widgets_math_node_options_acos {
    return Intl.message(
      'Arccosine',
      name: 'node_widgets_math_node_options_acos',
      desc: '',
      args: [],
    );
  }

  /// `Arctangent`
  String get node_widgets_math_node_options_atan {
    return Intl.message(
      'Arctangent',
      name: 'node_widgets_math_node_options_atan',
      desc: '',
      args: [],
    );
  }

  /// `Hyperbolic Sine`
  String get node_widgets_math_node_options_sinh {
    return Intl.message(
      'Hyperbolic Sine',
      name: 'node_widgets_math_node_options_sinh',
      desc: '',
      args: [],
    );
  }

  /// `Hyperbolic Cosine`
  String get node_widgets_math_node_options_cosh {
    return Intl.message(
      'Hyperbolic Cosine',
      name: 'node_widgets_math_node_options_cosh',
      desc: '',
      args: [],
    );
  }

  /// `Hyperbolic Tangent`
  String get node_widgets_math_node_options_tanh {
    return Intl.message(
      'Hyperbolic Tangent',
      name: 'node_widgets_math_node_options_tanh',
      desc: '',
      args: [],
    );
  }

  /// `Inverse Hyperbolic Sine`
  String get node_widgets_math_node_options_asinh {
    return Intl.message(
      'Inverse Hyperbolic Sine',
      name: 'node_widgets_math_node_options_asinh',
      desc: '',
      args: [],
    );
  }

  /// `Inverse Hyperbolic Cosine`
  String get node_widgets_math_node_options_acosh {
    return Intl.message(
      'Inverse Hyperbolic Cosine',
      name: 'node_widgets_math_node_options_acosh',
      desc: '',
      args: [],
    );
  }

  /// `Inverse Hyperbolic Tangent`
  String get node_widgets_math_node_options_atanh {
    return Intl.message(
      'Inverse Hyperbolic Tangent',
      name: 'node_widgets_math_node_options_atanh',
      desc: '',
      args: [],
    );
  }

  /// `Natural Logarithm`
  String get node_widgets_math_node_options_ln {
    return Intl.message(
      'Natural Logarithm',
      name: 'node_widgets_math_node_options_ln',
      desc: '',
      args: [],
    );
  }

  /// `Logarithm Base 10`
  String get node_widgets_math_node_options_log10 {
    return Intl.message(
      'Logarithm Base 10',
      name: 'node_widgets_math_node_options_log10',
      desc: '',
      args: [],
    );
  }

  /// `Absolute Value`
  String get node_widgets_math_node_options_abs {
    return Intl.message(
      'Absolute Value',
      name: 'node_widgets_math_node_options_abs',
      desc: '',
      args: [],
    );
  }

  /// `Comparison`
  String get node_widgets_comparison_node_title {
    return Intl.message(
      'Comparison',
      name: 'node_widgets_comparison_node_title',
      desc: '',
      args: [],
    );
  }

  /// `Performs comparison between numbers.`
  String get node_widgets_comparison_node_description {
    return Intl.message(
      'Performs comparison between numbers.',
      name: 'node_widgets_comparison_node_description',
      desc: '',
      args: [],
    );
  }

  /// `Less than`
  String get node_widgets_comparison_node_options_lessThan {
    return Intl.message(
      'Less than',
      name: 'node_widgets_comparison_node_options_lessThan',
      desc: '',
      args: [],
    );
  }

  /// `Less than or equal to`
  String get node_widgets_comparison_node_options_lessThanOrEqual {
    return Intl.message(
      'Less than or equal to',
      name: 'node_widgets_comparison_node_options_lessThanOrEqual',
      desc: '',
      args: [],
    );
  }

  /// `Greater than`
  String get node_widgets_comparison_node_options_greatherThan {
    return Intl.message(
      'Greater than',
      name: 'node_widgets_comparison_node_options_greatherThan',
      desc: '',
      args: [],
    );
  }

  /// `Greater than or equal to`
  String get node_widgets_comparison_node_options_greatherThanOrEqual {
    return Intl.message(
      'Greater than or equal to',
      name: 'node_widgets_comparison_node_options_greatherThanOrEqual',
      desc: '',
      args: [],
    );
  }

  /// `Equal to`
  String get node_widgets_comparison_node_options_equal {
    return Intl.message(
      'Equal to',
      name: 'node_widgets_comparison_node_options_equal',
      desc: '',
      args: [],
    );
  }

  /// `Logic Operations`
  String get node_widgets_boolean_node_title {
    return Intl.message(
      'Logic Operations',
      name: 'node_widgets_boolean_node_title',
      desc: '',
      args: [],
    );
  }

  /// `Performs operations on booleans.`
  String get node_widgets_boolean_node_description {
    return Intl.message(
      'Performs operations on booleans.',
      name: 'node_widgets_boolean_node_description',
      desc: '',
      args: [],
    );
  }

  /// `And`
  String get node_widgets_boolean_node_options_and {
    return Intl.message(
      'And',
      name: 'node_widgets_boolean_node_options_and',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get node_widgets_boolean_node_options_or {
    return Intl.message(
      'Or',
      name: 'node_widgets_boolean_node_options_or',
      desc: '',
      args: [],
    );
  }

  /// `Not`
  String get node_widgets_boolean_node_options_not {
    return Intl.message(
      'Not',
      name: 'node_widgets_boolean_node_options_not',
      desc: '',
      args: [],
    );
  }

  /// `Not And`
  String get node_widgets_boolean_node_options_notAnd {
    return Intl.message(
      'Not And',
      name: 'node_widgets_boolean_node_options_notAnd',
      desc: '',
      args: [],
    );
  }

  /// `Not Or`
  String get node_widgets_boolean_node_options_notOr {
    return Intl.message(
      'Not Or',
      name: 'node_widgets_boolean_node_options_notOr',
      desc: '',
      args: [],
    );
  }

  /// `Equal`
  String get node_widgets_boolean_node_options_equal {
    return Intl.message(
      'Equal',
      name: 'node_widgets_boolean_node_options_equal',
      desc: '',
      args: [],
    );
  }

  /// `Not Equal`
  String get node_widgets_boolean_node_options_notEqual {
    return Intl.message(
      'Not Equal',
      name: 'node_widgets_boolean_node_options_notEqual',
      desc: '',
      args: [],
    );
  }

  /// `Imply`
  String get node_widgets_boolean_node_options_imply {
    return Intl.message(
      'Imply',
      name: 'node_widgets_boolean_node_options_imply',
      desc: '',
      args: [],
    );
  }

  /// `Subtract`
  String get node_widgets_boolean_node_options_subtract {
    return Intl.message(
      'Subtract',
      name: 'node_widgets_boolean_node_options_subtract',
      desc: '',
      args: [],
    );
  }

  /// `Conversion`
  String get node_widgets_conversion_node_title {
    return Intl.message(
      'Conversion',
      name: 'node_widgets_conversion_node_title',
      desc: '',
      args: [],
    );
  }

  /// `Converts a value to another type`
  String get node_widgets_conversion_node_decsription {
    return Intl.message(
      'Converts a value to another type',
      name: 'node_widgets_conversion_node_decsription',
      desc: '',
      args: [],
    );
  }

  /// `Text operation`
  String get node_widgets_text_operation_node_title {
    return Intl.message(
      'Text operation',
      name: 'node_widgets_text_operation_node_title',
      desc: '',
      args: [],
    );
  }

  /// `Performs operations on a text`
  String get node_widgets_text_operation_node_decsription {
    return Intl.message(
      'Performs operations on a text',
      name: 'node_widgets_text_operation_node_decsription',
      desc: '',
      args: [],
    );
  }

  /// `Join`
  String get node_widgets_text_operation_node_options_join {
    return Intl.message(
      'Join',
      name: 'node_widgets_text_operation_node_options_join',
      desc: '',
      args: [],
    );
  }

  /// `Cut`
  String get node_widgets_text_operation_node_options_cut {
    return Intl.message(
      'Cut',
      name: 'node_widgets_text_operation_node_options_cut',
      desc: '',
      args: [],
    );
  }

  /// `Trim`
  String get node_widgets_text_operation_node_options_trim {
    return Intl.message(
      'Trim',
      name: 'node_widgets_text_operation_node_options_trim',
      desc: '',
      args: [],
    );
  }

  /// `Trim left`
  String get node_widgets_text_operation_node_options_trim_left {
    return Intl.message(
      'Trim left',
      name: 'node_widgets_text_operation_node_options_trim_left',
      desc: '',
      args: [],
    );
  }

  /// `Trim right`
  String get node_widgets_text_operation_node_options_trim_right {
    return Intl.message(
      'Trim right',
      name: 'node_widgets_text_operation_node_options_trim_right',
      desc: '',
      args: [],
    );
  }

  /// `Pad left`
  String get node_widgets_text_operation_node_options_pad_left {
    return Intl.message(
      'Pad left',
      name: 'node_widgets_text_operation_node_options_pad_left',
      desc: '',
      args: [],
    );
  }

  /// `Pad right`
  String get node_widgets_text_operation_node_options_pad_right {
    return Intl.message(
      'Pad right',
      name: 'node_widgets_text_operation_node_options_pad_right',
      desc: '',
      args: [],
    );
  }

  /// `Contains`
  String get node_widgets_text_operation_node_options_contains {
    return Intl.message(
      'Contains',
      name: 'node_widgets_text_operation_node_options_contains',
      desc: '',
      args: [],
    );
  }

  /// `Set variable`
  String get node_widgets_set_variable_node_title {
    return Intl.message(
      'Set variable',
      name: 'node_widgets_set_variable_node_title',
      desc: '',
      args: [],
    );
  }

  /// `Sets a variable's value.`
  String get node_widgets_set_variable_node_description {
    return Intl.message(
      'Sets a variable\'s value.',
      name: 'node_widgets_set_variable_node_description',
      desc: '',
      args: [],
    );
  }

  /// `Get variable`
  String get node_widgets_get_variable_node_title {
    return Intl.message(
      'Get variable',
      name: 'node_widgets_get_variable_node_title',
      desc: '',
      args: [],
    );
  }

  /// `Gets the value of a variable.`
  String get node_widgets_get_variable_node_description {
    return Intl.message(
      'Gets the value of a variable.',
      name: 'node_widgets_get_variable_node_description',
      desc: '',
      args: [],
    );
  }

  /// `Select a variable`
  String get node_widgets_select_variable_node_text {
    return Intl.message(
      'Select a variable',
      name: 'node_widgets_select_variable_node_text',
      desc: '',
      args: [],
    );
  }

  /// `Random number`
  String get node_widgets_random_number_node_title {
    return Intl.message(
      'Random number',
      name: 'node_widgets_random_number_node_title',
      desc: '',
      args: [],
    );
  }

  /// `Generates a random number between a minimum and maximum (0 and 1 by default).`
  String get node_widgets_random_number_node_description {
    return Intl.message(
      'Generates a random number between a minimum and maximum (0 and 1 by default).',
      name: 'node_widgets_random_number_node_description',
      desc: '',
      args: [],
    );
  }

  /// `Components`
  String get plugin_editor_ui_side_panel_layers_title {
    return Intl.message(
      'Components',
      name: 'plugin_editor_ui_side_panel_layers_title',
      desc: '',
      args: [],
    );
  }

  /// `New component`
  String get plugin_editor_ui_side_panel_layers_add_button {
    return Intl.message(
      'New component',
      name: 'plugin_editor_ui_side_panel_layers_add_button',
      desc: '',
      args: [],
    );
  }

  /// `Add child`
  String get plugin_editor_ui_side_panel_layers_add_child {
    return Intl.message(
      'Add child',
      name: 'plugin_editor_ui_side_panel_layers_add_child',
      desc: '',
      args: [],
    );
  }

  /// `More options`
  String get plugin_editor_ui_side_panel_layers_more_options {
    return Intl.message(
      'More options',
      name: 'plugin_editor_ui_side_panel_layers_more_options',
      desc: '',
      args: [],
    );
  }

  /// `{length, plural, one {Hide child} other {Hide children}}`
  String plugin_editor_ui_side_panel_layers_hide_child(num length) {
    return Intl.plural(
      length,
      one: 'Hide child',
      other: 'Hide children',
      name: 'plugin_editor_ui_side_panel_layers_hide_child',
      desc: '',
      args: [length],
    );
  }

  /// `{length, plural, one {Show child} other {Show children}}`
  String plugin_editor_ui_side_panel_layers_show_child(num length) {
    return Intl.plural(
      length,
      one: 'Show child',
      other: 'Show children',
      name: 'plugin_editor_ui_side_panel_layers_show_child',
      desc: '',
      args: [length],
    );
  }

  /// `Size`
  String get plugin_editor_ui_side_panel_properties_size_subtitle {
    return Intl.message(
      'Size',
      name: 'plugin_editor_ui_side_panel_properties_size_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Width`
  String get plugin_editor_ui_side_panel_properties_size_width {
    return Intl.message(
      'Width',
      name: 'plugin_editor_ui_side_panel_properties_size_width',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get plugin_editor_ui_side_panel_properties_size_height {
    return Intl.message(
      'Height',
      name: 'plugin_editor_ui_side_panel_properties_size_height',
      desc: '',
      args: [],
    );
  }

  /// `Style`
  String get plugin_editor_ui_side_panel_properties_style_subtitle {
    return Intl.message(
      'Style',
      name: 'plugin_editor_ui_side_panel_properties_style_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Border radius`
  String get plugin_editor_ui_side_panel_properties_style_border_radius {
    return Intl.message(
      'Border radius',
      name: 'plugin_editor_ui_side_panel_properties_style_border_radius',
      desc: '',
      args: [],
    );
  }

  /// `Alignment`
  String get plugin_editor_ui_side_panel_properties_style_alignment {
    return Intl.message(
      'Alignment',
      name: 'plugin_editor_ui_side_panel_properties_style_alignment',
      desc: '',
      args: [],
    );
  }

  /// `Top left`
  String get plugin_editor_ui_side_panel_properties_style_alignment_top_left {
    return Intl.message(
      'Top left',
      name: 'plugin_editor_ui_side_panel_properties_style_alignment_top_left',
      desc: '',
      args: [],
    );
  }

  /// `Top right`
  String get plugin_editor_ui_side_panel_properties_style_alignment_top_right {
    return Intl.message(
      'Top right',
      name: 'plugin_editor_ui_side_panel_properties_style_alignment_top_right',
      desc: '',
      args: [],
    );
  }

  /// `Bottom left`
  String
  get plugin_editor_ui_side_panel_properties_style_alignment_bottom_left {
    return Intl.message(
      'Bottom left',
      name:
          'plugin_editor_ui_side_panel_properties_style_alignment_bottom_left',
      desc: '',
      args: [],
    );
  }

  /// `Bottom right`
  String
  get plugin_editor_ui_side_panel_properties_style_alignment_bottom_right {
    return Intl.message(
      'Bottom right',
      name:
          'plugin_editor_ui_side_panel_properties_style_alignment_bottom_right',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get plugin_editor_ui_side_panel_properties_style_alignment_all {
    return Intl.message(
      'All',
      name: 'plugin_editor_ui_side_panel_properties_style_alignment_all',
      desc: '',
      args: [],
    );
  }

  /// `Selection`
  String get plugin_editor_ui_side_panel_properties_style_alignment_multiples {
    return Intl.message(
      'Selection',
      name: 'plugin_editor_ui_side_panel_properties_style_alignment_multiples',
      desc: '',
      args: [],
    );
  }

  /// `Border`
  String get plugin_editor_ui_side_panel_properties_border_subtitle {
    return Intl.message(
      'Border',
      name: 'plugin_editor_ui_side_panel_properties_border_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Top`
  String get plugin_editor_ui_side_panel_properties_style_alignment_top {
    return Intl.message(
      'Top',
      name: 'plugin_editor_ui_side_panel_properties_style_alignment_top',
      desc: '',
      args: [],
    );
  }

  /// `Bottom`
  String get plugin_editor_ui_side_panel_properties_style_alignment_bottom {
    return Intl.message(
      'Bottom',
      name: 'plugin_editor_ui_side_panel_properties_style_alignment_bottom',
      desc: '',
      args: [],
    );
  }

  /// `Left`
  String get plugin_editor_ui_side_panel_properties_style_alignment_left {
    return Intl.message(
      'Left',
      name: 'plugin_editor_ui_side_panel_properties_style_alignment_left',
      desc: '',
      args: [],
    );
  }

  /// `Right`
  String get plugin_editor_ui_side_panel_properties_style_alignment_right {
    return Intl.message(
      'Right',
      name: 'plugin_editor_ui_side_panel_properties_style_alignment_right',
      desc: '',
      args: [],
    );
  }

  /// `Thickness`
  String get plugin_editor_ui_side_panel_properties_style_border_thickness {
    return Intl.message(
      'Thickness',
      name: 'plugin_editor_ui_side_panel_properties_style_border_thickness',
      desc: '',
      args: [],
    );
  }

  /// `Primary`
  String get plugin_editor_ui_side_panel_properties_theme_colors_primary {
    return Intl.message(
      'Primary',
      name: 'plugin_editor_ui_side_panel_properties_theme_colors_primary',
      desc: '',
      args: [],
    );
  }

  /// `Primary transparent`
  String
  get plugin_editor_ui_side_panel_properties_theme_colors_primary_transparent {
    return Intl.message(
      'Primary transparent',
      name:
          'plugin_editor_ui_side_panel_properties_theme_colors_primary_transparent',
      desc: '',
      args: [],
    );
  }

  /// `Accent`
  String get plugin_editor_ui_side_panel_properties_theme_colors_accent {
    return Intl.message(
      'Accent',
      name: 'plugin_editor_ui_side_panel_properties_theme_colors_accent',
      desc: '',
      args: [],
    );
  }

  /// `Surface`
  String get plugin_editor_ui_side_panel_properties_theme_colors_surface {
    return Intl.message(
      'Surface',
      name: 'plugin_editor_ui_side_panel_properties_theme_colors_surface',
      desc: '',
      args: [],
    );
  }

  /// `Change color`
  String get default_app_colors_change_color {
    return Intl.message(
      'Change color',
      name: 'default_app_colors_change_color',
      desc: '',
      args: [],
    );
  }

  /// `Grey`
  String get default_app_colors_grey {
    return Intl.message(
      'Grey',
      name: 'default_app_colors_grey',
      desc: '',
      args: [],
    );
  }

  /// `Mint Green`
  String get default_app_colors_mint_green {
    return Intl.message(
      'Mint Green',
      name: 'default_app_colors_mint_green',
      desc: '',
      args: [],
    );
  }

  /// `Light Pink`
  String get default_app_colors_light_pink {
    return Intl.message(
      'Light Pink',
      name: 'default_app_colors_light_pink',
      desc: '',
      args: [],
    );
  }

  /// `Light Yellow`
  String get default_app_colors_light_yellow {
    return Intl.message(
      'Light Yellow',
      name: 'default_app_colors_light_yellow',
      desc: '',
      args: [],
    );
  }

  /// `Peach`
  String get default_app_colors_peach {
    return Intl.message(
      'Peach',
      name: 'default_app_colors_peach',
      desc: '',
      args: [],
    );
  }

  /// `Soft Red`
  String get default_app_colors_soft_red {
    return Intl.message(
      'Soft Red',
      name: 'default_app_colors_soft_red',
      desc: '',
      args: [],
    );
  }

  /// `Lavender`
  String get default_app_colors_lavender {
    return Intl.message(
      'Lavender',
      name: 'default_app_colors_lavender',
      desc: '',
      args: [],
    );
  }

  /// `Light Blue`
  String get default_app_colors_light_blue {
    return Intl.message(
      'Light Blue',
      name: 'default_app_colors_light_blue',
      desc: '',
      args: [],
    );
  }

  /// `Light Green`
  String get default_app_colors_light_green {
    return Intl.message(
      'Light Green',
      name: 'default_app_colors_light_green',
      desc: '',
      args: [],
    );
  }

  /// `Light Purple`
  String get default_app_colors_light_purple {
    return Intl.message(
      'Light Purple',
      name: 'default_app_colors_light_purple',
      desc: '',
      args: [],
    );
  }

  /// `Articles`
  String get default_articles_articles_title {
    return Intl.message(
      'Articles',
      name: 'default_articles_articles_title',
      desc: '',
      args: [],
    );
  }

  /// `Discover articles in minddy`
  String get default_articles_articles_description {
    return Intl.message(
      'Discover articles in minddy',
      name: 'default_articles_articles_description',
      desc: '',
      args: [],
    );
  }

  /// `Key Feature`
  String get default_articles_articles_first_subtitle {
    return Intl.message(
      'Key Feature',
      name: 'default_articles_articles_first_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Articles are a key feature of Minddy. They offer an elegant and intuitive interface for writing and sharing your knowledge. With this feature, you can easily disseminate your insights and benefit the entire community.`
  String get default_articles_articles_first_paragraph {
    return Intl.message(
      'Articles are a key feature of Minddy. They offer an elegant and intuitive interface for writing and sharing your knowledge. With this feature, you can easily disseminate your insights and benefit the entire community.',
      name: 'default_articles_articles_first_paragraph',
      desc: '',
      args: [],
    );
  }

  /// `Note Taking`
  String get default_articles_articles_second_subtitle {
    return Intl.message(
      'Note Taking',
      name: 'default_articles_articles_second_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `You can also take notes, which is ideal for saving texts or any other content you want to keep for later. This feature is perfect for capturing ideas or important information to revisit later.`
  String get default_articles_articles_second_paragraph {
    return Intl.message(
      'You can also take notes, which is ideal for saving texts or any other content you want to keep for later. This feature is perfect for capturing ideas or important information to revisit later.',
      name: 'default_articles_articles_second_paragraph',
      desc: '',
      args: [],
    );
  }

  /// `Source Management`
  String get default_articles_articles_third_subtitle {
    return Intl.message(
      'Source Management',
      name: 'default_articles_articles_third_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `All your sources are accessible via a menu located at the bottom of the page, allowing you to easily manage and retrieve your references.`
  String get default_articles_articles_third_paragraph {
    return Intl.message(
      'All your sources are accessible via a menu located at the bottom of the page, allowing you to easily manage and retrieve your references.',
      name: 'default_articles_articles_third_paragraph',
      desc: '',
      args: [],
    );
  }

  /// `Adding and Managing Content`
  String get default_articles_articles_fourth_subtitle {
    return Intl.message(
      'Adding and Managing Content',
      name: 'default_articles_articles_fourth_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `The buttons for adding elements to your article are located at the top of the page. To manage this content, use the menu at the bottom.`
  String get default_articles_articles_fourth_paragraph {
    return Intl.message(
      'The buttons for adding elements to your article are located at the top of the page. To manage this content, use the menu at the bottom.',
      name: 'default_articles_articles_fourth_paragraph',
      desc: '',
      args: [],
    );
  }

  /// `Powerful Tool`
  String get default_articles_articles_fifth_subtitle {
    return Intl.message(
      'Powerful Tool',
      name: 'default_articles_articles_fifth_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `With articles, you have a powerful and user-friendly tool to organize, share, and find your knowledge with ease.`
  String get default_articles_articles_fifth_paragraph {
    return Intl.message(
      'With articles, you have a powerful and user-friendly tool to organize, share, and find your knowledge with ease.',
      name: 'default_articles_articles_fifth_paragraph',
      desc: '',
      args: [],
    );
  }

  /// `Text`
  String get icons_category_text {
    return Intl.message(
      'Text',
      name: 'icons_category_text',
      desc: '',
      args: [],
    );
  }

  /// `Technology`
  String get icons_category_tech {
    return Intl.message(
      'Technology',
      name: 'icons_category_tech',
      desc: '',
      args: [],
    );
  }

  /// `Transport`
  String get icons_category_transport {
    return Intl.message(
      'Transport',
      name: 'icons_category_transport',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get icons_category_education {
    return Intl.message(
      'Education',
      name: 'icons_category_education',
      desc: '',
      args: [],
    );
  }

  /// `Media`
  String get icons_category_media {
    return Intl.message(
      'Media',
      name: 'icons_category_media',
      desc: '',
      args: [],
    );
  }

  /// `Communication`
  String get icons_category_communication {
    return Intl.message(
      'Communication',
      name: 'icons_category_communication',
      desc: '',
      args: [],
    );
  }

  /// `Nature`
  String get icons_category_nature {
    return Intl.message(
      'Nature',
      name: 'icons_category_nature',
      desc: '',
      args: [],
    );
  }

  /// `Food`
  String get icons_category_food {
    return Intl.message(
      'Food',
      name: 'icons_category_food',
      desc: '',
      args: [],
    );
  }

  /// `Social`
  String get icons_category_social {
    return Intl.message(
      'Social',
      name: 'icons_category_social',
      desc: '',
      args: [],
    );
  }

  /// `Navigation`
  String get icons_category_navigation {
    return Intl.message(
      'Navigation',
      name: 'icons_category_navigation',
      desc: '',
      args: [],
    );
  }

  /// `Accessibility`
  String get icons_category_accessibility {
    return Intl.message(
      'Accessibility',
      name: 'icons_category_accessibility',
      desc: '',
      args: [],
    );
  }

  /// `Finance`
  String get icons_category_finance {
    return Intl.message(
      'Finance',
      name: 'icons_category_finance',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get icons_category_user {
    return Intl.message(
      'User',
      name: 'icons_category_user',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get icons_category_content {
    return Intl.message(
      'Content',
      name: 'icons_category_content',
      desc: '',
      args: [],
    );
  }

  /// `Business`
  String get icons_category_business {
    return Intl.message(
      'Business',
      name: 'icons_category_business',
      desc: '',
      args: [],
    );
  }

  /// `Data`
  String get icons_category_data {
    return Intl.message(
      'Data',
      name: 'icons_category_data',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get icons_category_location {
    return Intl.message(
      'Location',
      name: 'icons_category_location',
      desc: '',
      args: [],
    );
  }

  /// `Moderation`
  String get icons_category_moderation {
    return Intl.message(
      'Moderation',
      name: 'icons_category_moderation',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get icons_category_home {
    return Intl.message(
      'Home',
      name: 'icons_category_home',
      desc: '',
      args: [],
    );
  }

  /// `Weather`
  String get icons_category_weather {
    return Intl.message(
      'Weather',
      name: 'icons_category_weather',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get icons_category_time {
    return Intl.message(
      'Time',
      name: 'icons_category_time',
      desc: '',
      args: [],
    );
  }

  /// `Design`
  String get icons_category_design {
    return Intl.message(
      'Design',
      name: 'icons_category_design',
      desc: '',
      args: [],
    );
  }

  /// `Action`
  String get icons_category_action {
    return Intl.message(
      'Action',
      name: 'icons_category_action',
      desc: '',
      args: [],
    );
  }

  /// `Gesture`
  String get icons_category_gesture {
    return Intl.message(
      'Gesture',
      name: 'icons_category_gesture',
      desc: '',
      args: [],
    );
  }

  /// `Travel`
  String get icons_category_travel {
    return Intl.message(
      'Travel',
      name: 'icons_category_travel',
      desc: '',
      args: [],
    );
  }

  /// `Building`
  String get icons_category_building {
    return Intl.message(
      'Building',
      name: 'icons_category_building',
      desc: '',
      args: [],
    );
  }

  /// `Bathroom`
  String get icons_category_bathroom {
    return Intl.message(
      'Bathroom',
      name: 'icons_category_bathroom',
      desc: '',
      args: [],
    );
  }

  /// `Furniture`
  String get icons_category_furniture {
    return Intl.message(
      'Furniture',
      name: 'icons_category_furniture',
      desc: '',
      args: [],
    );
  }

  /// `Sleep`
  String get icons_category_sleep {
    return Intl.message(
      'Sleep',
      name: 'icons_category_sleep',
      desc: '',
      args: [],
    );
  }

  /// `Science`
  String get icons_category_science {
    return Intl.message(
      'Science',
      name: 'icons_category_science',
      desc: '',
      args: [],
    );
  }

  /// `Kitchen`
  String get icons_category_kitchen {
    return Intl.message(
      'Kitchen',
      name: 'icons_category_kitchen',
      desc: '',
      args: [],
    );
  }

  /// `Health`
  String get icons_category_health {
    return Intl.message(
      'Health',
      name: 'icons_category_health',
      desc: '',
      args: [],
    );
  }

  /// `Tools`
  String get icons_category_tools {
    return Intl.message(
      'Tools',
      name: 'icons_category_tools',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get icons_category_notification {
    return Intl.message(
      'Notification',
      name: 'icons_category_notification',
      desc: '',
      args: [],
    );
  }

  /// `Alphabet`
  String get icons_tags_alphabet {
    return Intl.message(
      'Alphabet',
      name: 'icons_tags_alphabet',
      desc: '',
      args: [],
    );
  }

  /// `Letters`
  String get icons_tags_letters {
    return Intl.message(
      'Letters',
      name: 'icons_tags_letters',
      desc: '',
      args: [],
    );
  }

  /// `Alarm`
  String get icons_tags_alarm {
    return Intl.message('Alarm', name: 'icons_tags_alarm', desc: '', args: []);
  }

  /// `Clock`
  String get icons_tags_clock {
    return Intl.message('Clock', name: 'icons_tags_clock', desc: '', args: []);
  }

  /// `Time`
  String get icons_tags_time {
    return Intl.message('Time', name: 'icons_tags_time', desc: '', args: []);
  }

  /// `Anchor`
  String get icons_tags_anchor {
    return Intl.message(
      'Anchor',
      name: 'icons_tags_anchor',
      desc: '',
      args: [],
    );
  }

  /// `Boat`
  String get icons_tags_boat {
    return Intl.message('Boat', name: 'icons_tags_boat', desc: '', args: []);
  }

  /// `Battery`
  String get icons_tags_battery {
    return Intl.message(
      'Battery',
      name: 'icons_tags_battery',
      desc: '',
      args: [],
    );
  }

  /// `Charging`
  String get icons_tags_charging {
    return Intl.message(
      'Charging',
      name: 'icons_tags_charging',
      desc: '',
      args: [],
    );
  }

  /// `Bluetooth`
  String get icons_tags_bluetooth {
    return Intl.message(
      'Bluetooth',
      name: 'icons_tags_bluetooth',
      desc: '',
      args: [],
    );
  }

  /// `Wireless`
  String get icons_tags_wireless {
    return Intl.message(
      'Wireless',
      name: 'icons_tags_wireless',
      desc: '',
      args: [],
    );
  }

  /// `Book`
  String get icons_tags_book {
    return Intl.message('Book', name: 'icons_tags_book', desc: '', args: []);
  }

  /// `Reading`
  String get icons_tags_reading {
    return Intl.message(
      'Reading',
      name: 'icons_tags_reading',
      desc: '',
      args: [],
    );
  }

  /// `Art`
  String get icons_tags_art {
    return Intl.message('Art', name: 'icons_tags_art', desc: '', args: []);
  }

  /// `Paint`
  String get icons_tags_paint {
    return Intl.message('Paint', name: 'icons_tags_paint', desc: '', args: []);
  }

  /// `Camera`
  String get icons_tags_camera {
    return Intl.message(
      'Camera',
      name: 'icons_tags_camera',
      desc: '',
      args: [],
    );
  }

  /// `Photo`
  String get icons_tags_photo {
    return Intl.message('Photo', name: 'icons_tags_photo', desc: '', args: []);
  }

  /// `Car`
  String get icons_tags_car {
    return Intl.message('Car', name: 'icons_tags_car', desc: '', args: []);
  }

  /// `Rental`
  String get icons_tags_rental {
    return Intl.message(
      'Rental',
      name: 'icons_tags_rental',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get icons_tags_chat {
    return Intl.message('Chat', name: 'icons_tags_chat', desc: '', args: []);
  }

  /// `Message`
  String get icons_tags_message {
    return Intl.message(
      'Message',
      name: 'icons_tags_message',
      desc: '',
      args: [],
    );
  }

  /// `Cloud`
  String get icons_tags_cloud {
    return Intl.message('Cloud', name: 'icons_tags_cloud', desc: '', args: []);
  }

  /// `Weather`
  String get icons_tags_weather {
    return Intl.message(
      'Weather',
      name: 'icons_tags_weather',
      desc: '',
      args: [],
    );
  }

  /// `Computer`
  String get icons_tags_computer {
    return Intl.message(
      'Computer',
      name: 'icons_tags_computer',
      desc: '',
      args: [],
    );
  }

  /// `Laptop`
  String get icons_tags_laptop {
    return Intl.message(
      'Laptop',
      name: 'icons_tags_laptop',
      desc: '',
      args: [],
    );
  }

  /// `Construction`
  String get icons_tags_construction {
    return Intl.message(
      'Construction',
      name: 'icons_tags_construction',
      desc: '',
      args: [],
    );
  }

  /// `Tools`
  String get icons_tags_tools {
    return Intl.message('Tools', name: 'icons_tags_tools', desc: '', args: []);
  }

  /// `Bike`
  String get icons_tags_bike {
    return Intl.message('Bike', name: 'icons_tags_bike', desc: '', args: []);
  }

  /// `Cycling`
  String get icons_tags_cycling {
    return Intl.message(
      'Cycling',
      name: 'icons_tags_cycling',
      desc: '',
      args: [],
    );
  }

  /// `Water`
  String get icons_tags_water {
    return Intl.message('Water', name: 'icons_tags_water', desc: '', args: []);
  }

  /// `Bus`
  String get icons_tags_bus {
    return Intl.message('Bus', name: 'icons_tags_bus', desc: '', args: []);
  }

  /// `Public transport`
  String get icons_tags_public_transport {
    return Intl.message(
      'Public transport',
      name: 'icons_tags_public_transport',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle`
  String get icons_tags_vehicle {
    return Intl.message(
      'Vehicle',
      name: 'icons_tags_vehicle',
      desc: '',
      args: [],
    );
  }

  /// `Train`
  String get icons_tags_train {
    return Intl.message('Train', name: 'icons_tags_train', desc: '', args: []);
  }

  /// `Rail`
  String get icons_tags_rail {
    return Intl.message('Rail', name: 'icons_tags_rail', desc: '', args: []);
  }

  /// `Running`
  String get icons_tags_running {
    return Intl.message(
      'Running',
      name: 'icons_tags_running',
      desc: '',
      args: [],
    );
  }

  /// `Exercise`
  String get icons_tags_exercise {
    return Intl.message(
      'Exercise',
      name: 'icons_tags_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Subway`
  String get icons_tags_subway {
    return Intl.message(
      'Subway',
      name: 'icons_tags_subway',
      desc: '',
      args: [],
    );
  }

  /// `Metro`
  String get icons_tags_metro {
    return Intl.message('Metro', name: 'icons_tags_metro', desc: '', args: []);
  }

  /// `Walking`
  String get icons_tags_walking {
    return Intl.message(
      'Walking',
      name: 'icons_tags_walking',
      desc: '',
      args: [],
    );
  }

  /// `Hiking`
  String get icons_tags_hiking {
    return Intl.message(
      'Hiking',
      name: 'icons_tags_hiking',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get icons_tags_email {
    return Intl.message('Email', name: 'icons_tags_email', desc: '', args: []);
  }

  /// `Fast food`
  String get icons_tags_fast_food {
    return Intl.message(
      'Fast food',
      name: 'icons_tags_fast_food',
      desc: '',
      args: [],
    );
  }

  /// `Meal`
  String get icons_tags_meal {
    return Intl.message('Meal', name: 'icons_tags_meal', desc: '', args: []);
  }

  /// `Like`
  String get icons_tags_like {
    return Intl.message('Like', name: 'icons_tags_like', desc: '', args: []);
  }

  /// `Heart`
  String get icons_tags_heart {
    return Intl.message('Heart', name: 'icons_tags_heart', desc: '', args: []);
  }

  /// `Flight`
  String get icons_tags_flight {
    return Intl.message(
      'Flight',
      name: 'icons_tags_flight',
      desc: '',
      args: [],
    );
  }

  /// `Travel`
  String get icons_tags_travel {
    return Intl.message(
      'Travel',
      name: 'icons_tags_travel',
      desc: '',
      args: [],
    );
  }

  /// `Forum`
  String get icons_tags_forum {
    return Intl.message('Forum', name: 'icons_tags_forum', desc: '', args: []);
  }

  /// `Discussion`
  String get icons_tags_discussion {
    return Intl.message(
      'Discussion',
      name: 'icons_tags_discussion',
      desc: '',
      args: [],
    );
  }

  /// `Games`
  String get icons_tags_games {
    return Intl.message('Games', name: 'icons_tags_games', desc: '', args: []);
  }

  /// `Play`
  String get icons_tags_play {
    return Intl.message('Play', name: 'icons_tags_play', desc: '', args: []);
  }

  /// `Headphones`
  String get icons_tags_headphones {
    return Intl.message(
      'Headphones',
      name: 'icons_tags_headphones',
      desc: '',
      args: [],
    );
  }

  /// `Audio`
  String get icons_tags_audio {
    return Intl.message('Audio', name: 'icons_tags_audio', desc: '', args: []);
  }

  /// `Home`
  String get icons_tags_home {
    return Intl.message('Home', name: 'icons_tags_home', desc: '', args: []);
  }

  /// `House`
  String get icons_tags_house {
    return Intl.message('House', name: 'icons_tags_house', desc: '', args: []);
  }

  /// `Hotel`
  String get icons_tags_hotel {
    return Intl.message('Hotel', name: 'icons_tags_hotel', desc: '', args: []);
  }

  /// `Stay`
  String get icons_tags_stay {
    return Intl.message('Stay', name: 'icons_tags_stay', desc: '', args: []);
  }

  /// `Image`
  String get icons_tags_image {
    return Intl.message('Image', name: 'icons_tags_image', desc: '', args: []);
  }

  /// `Keyboard`
  String get icons_tags_keyboard {
    return Intl.message(
      'Keyboard',
      name: 'icons_tags_keyboard',
      desc: '',
      args: [],
    );
  }

  /// `Input`
  String get icons_tags_input {
    return Intl.message('Input', name: 'icons_tags_input', desc: '', args: []);
  }

  /// `Kitchen`
  String get icons_tags_kitchen {
    return Intl.message(
      'Kitchen',
      name: 'icons_tags_kitchen',
      desc: '',
      args: [],
    );
  }

  /// `Cooking`
  String get icons_tags_cooking {
    return Intl.message(
      'Cooking',
      name: 'icons_tags_cooking',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get icons_tags_light {
    return Intl.message('Light', name: 'icons_tags_light', desc: '', args: []);
  }

  /// `Idea`
  String get icons_tags_idea {
    return Intl.message('Idea', name: 'icons_tags_idea', desc: '', args: []);
  }

  /// `Cafe`
  String get icons_tags_cafe {
    return Intl.message('Cafe', name: 'icons_tags_cafe', desc: '', args: []);
  }

  /// `Coffee`
  String get icons_tags_coffee {
    return Intl.message(
      'Coffee',
      name: 'icons_tags_coffee',
      desc: '',
      args: [],
    );
  }

  /// `Dining`
  String get icons_tags_dining {
    return Intl.message(
      'Dining',
      name: 'icons_tags_dining',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant`
  String get icons_tags_restaurant {
    return Intl.message(
      'Restaurant',
      name: 'icons_tags_restaurant',
      desc: '',
      args: [],
    );
  }

  /// `Florist`
  String get icons_tags_florist {
    return Intl.message(
      'Florist',
      name: 'icons_tags_florist',
      desc: '',
      args: [],
    );
  }

  /// `Flowers`
  String get icons_tags_flowers {
    return Intl.message(
      'Flowers',
      name: 'icons_tags_flowers',
      desc: '',
      args: [],
    );
  }

  /// `Lock`
  String get icons_tags_lock {
    return Intl.message('Lock', name: 'icons_tags_lock', desc: '', args: []);
  }

  /// `Security`
  String get icons_tags_security {
    return Intl.message(
      'Security',
      name: 'icons_tags_security',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get icons_tags_map {
    return Intl.message('Map', name: 'icons_tags_map', desc: '', args: []);
  }

  /// `Location`
  String get icons_tags_location {
    return Intl.message(
      'Location',
      name: 'icons_tags_location',
      desc: '',
      args: [],
    );
  }

  /// `Microphone`
  String get icons_tags_microphone {
    return Intl.message(
      'Microphone',
      name: 'icons_tags_microphone',
      desc: '',
      args: [],
    );
  }

  /// `Motorcycle`
  String get icons_tags_motorcycle {
    return Intl.message(
      'Motorcycle',
      name: 'icons_tags_motorcycle',
      desc: '',
      args: [],
    );
  }

  /// `Music`
  String get icons_tags_music {
    return Intl.message('Music', name: 'icons_tags_music', desc: '', args: []);
  }

  /// `Note`
  String get icons_tags_note {
    return Intl.message('Note', name: 'icons_tags_note', desc: '', args: []);
  }

  /// `Nature`
  String get icons_tags_nature {
    return Intl.message(
      'Nature',
      name: 'icons_tags_nature',
      desc: '',
      args: [],
    );
  }

  /// `Outdoors`
  String get icons_tags_outdoors {
    return Intl.message(
      'Outdoors',
      name: 'icons_tags_outdoors',
      desc: '',
      args: [],
    );
  }

  /// `Navigation`
  String get icons_tags_navigation {
    return Intl.message(
      'Navigation',
      name: 'icons_tags_navigation',
      desc: '',
      args: [],
    );
  }

  /// `Directions`
  String get icons_tags_directions {
    return Intl.message(
      'Directions',
      name: 'icons_tags_directions',
      desc: '',
      args: [],
    );
  }

  /// `Wifi`
  String get icons_tags_wifi {
    return Intl.message('Wifi', name: 'icons_tags_wifi', desc: '', args: []);
  }

  /// `Internet`
  String get icons_tags_internet {
    return Intl.message(
      'Internet',
      name: 'icons_tags_internet',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get icons_tags_phone {
    return Intl.message('Phone', name: 'icons_tags_phone', desc: '', args: []);
  }

  /// `Call`
  String get icons_tags_call {
    return Intl.message('Call', name: 'icons_tags_call', desc: '', args: []);
  }

  /// `Place`
  String get icons_tags_place {
    return Intl.message('Place', name: 'icons_tags_place', desc: '', args: []);
  }

  /// `Printer`
  String get icons_tags_printer {
    return Intl.message(
      'Printer',
      name: 'icons_tags_printer',
      desc: '',
      args: [],
    );
  }

  /// `Print`
  String get icons_tags_print {
    return Intl.message('Print', name: 'icons_tags_print', desc: '', args: []);
  }

  /// `Public`
  String get icons_tags_public {
    return Intl.message(
      'Public',
      name: 'icons_tags_public',
      desc: '',
      args: [],
    );
  }

  /// `Router`
  String get icons_tags_router {
    return Intl.message(
      'Router',
      name: 'icons_tags_router',
      desc: '',
      args: [],
    );
  }

  /// `Network`
  String get icons_tags_network {
    return Intl.message(
      'Network',
      name: 'icons_tags_network',
      desc: '',
      args: [],
    );
  }

  /// `Rowing`
  String get icons_tags_rowing {
    return Intl.message(
      'Rowing',
      name: 'icons_tags_rowing',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get icons_tags_save {
    return Intl.message('Save', name: 'icons_tags_save', desc: '', args: []);
  }

  /// `File`
  String get icons_tags_file {
    return Intl.message('File', name: 'icons_tags_file', desc: '', args: []);
  }

  /// `School`
  String get icons_tags_school {
    return Intl.message(
      'School',
      name: 'icons_tags_school',
      desc: '',
      args: [],
    );
  }

  /// `Learning`
  String get icons_tags_learning {
    return Intl.message(
      'Learning',
      name: 'icons_tags_learning',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get icons_tags_send {
    return Intl.message('Send', name: 'icons_tags_send', desc: '', args: []);
  }

  /// `Settings`
  String get icons_tags_settings {
    return Intl.message(
      'Settings',
      name: 'icons_tags_settings',
      desc: '',
      args: [],
    );
  }

  /// `Preferences`
  String get icons_tags_preferences {
    return Intl.message(
      'Preferences',
      name: 'icons_tags_preferences',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get icons_tags_share {
    return Intl.message('Share', name: 'icons_tags_share', desc: '', args: []);
  }

  /// `Social`
  String get icons_tags_social {
    return Intl.message(
      'Social',
      name: 'icons_tags_social',
      desc: '',
      args: [],
    );
  }

  /// `Shopping`
  String get icons_tags_shopping {
    return Intl.message(
      'Shopping',
      name: 'icons_tags_shopping',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get icons_tags_cart {
    return Intl.message('Cart', name: 'icons_tags_cart', desc: '', args: []);
  }

  /// `Smartphone`
  String get icons_tags_smartphone {
    return Intl.message(
      'Smartphone',
      name: 'icons_tags_smartphone',
      desc: '',
      args: [],
    );
  }

  /// `Mobile`
  String get icons_tags_mobile {
    return Intl.message(
      'Mobile',
      name: 'icons_tags_mobile',
      desc: '',
      args: [],
    );
  }

  /// `Snowboarding`
  String get icons_tags_snowboarding {
    return Intl.message(
      'Snowboarding',
      name: 'icons_tags_snowboarding',
      desc: '',
      args: [],
    );
  }

  /// `Sports`
  String get icons_tags_sports {
    return Intl.message(
      'Sports',
      name: 'icons_tags_sports',
      desc: '',
      args: [],
    );
  }

  /// `Spa`
  String get icons_tags_spa {
    return Intl.message('Spa', name: 'icons_tags_spa', desc: '', args: []);
  }

  /// `Relaxation`
  String get icons_tags_relaxation {
    return Intl.message(
      'Relaxation',
      name: 'icons_tags_relaxation',
      desc: '',
      args: [],
    );
  }

  /// `Speaker`
  String get icons_tags_speaker {
    return Intl.message(
      'Speaker',
      name: 'icons_tags_speaker',
      desc: '',
      args: [],
    );
  }

  /// `Star`
  String get icons_tags_star {
    return Intl.message('Star', name: 'icons_tags_star', desc: '', args: []);
  }

  /// `Favorite`
  String get icons_tags_favorite {
    return Intl.message(
      'Favorite',
      name: 'icons_tags_favorite',
      desc: '',
      args: [],
    );
  }

  /// `Store`
  String get icons_tags_store {
    return Intl.message('Store', name: 'icons_tags_store', desc: '', args: []);
  }

  /// `Sunny`
  String get icons_tags_sunny {
    return Intl.message('Sunny', name: 'icons_tags_sunny', desc: '', args: []);
  }

  /// `Support`
  String get icons_tags_support {
    return Intl.message(
      'Support',
      name: 'icons_tags_support',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get icons_tags_help {
    return Intl.message('Help', name: 'icons_tags_help', desc: '', args: []);
  }

  /// `Terrain`
  String get icons_tags_terrain {
    return Intl.message(
      'Terrain',
      name: 'icons_tags_terrain',
      desc: '',
      args: [],
    );
  }

  /// `Landscape`
  String get icons_tags_landscape {
    return Intl.message(
      'Landscape',
      name: 'icons_tags_landscape',
      desc: '',
      args: [],
    );
  }

  /// `Thermostat`
  String get icons_tags_thermostat {
    return Intl.message(
      'Thermostat',
      name: 'icons_tags_thermostat',
      desc: '',
      args: [],
    );
  }

  /// `Temperature`
  String get icons_tags_temperature {
    return Intl.message(
      'Temperature',
      name: 'icons_tags_temperature',
      desc: '',
      args: [],
    );
  }

  /// `Thumb`
  String get icons_tags_thumb {
    return Intl.message('Thumb', name: 'icons_tags_thumb', desc: '', args: []);
  }

  /// `Transport`
  String get icons_tags_transport {
    return Intl.message(
      'Transport',
      name: 'icons_tags_transport',
      desc: '',
      args: [],
    );
  }

  /// `Traffic`
  String get icons_tags_traffic {
    return Intl.message(
      'Traffic',
      name: 'icons_tags_traffic',
      desc: '',
      args: [],
    );
  }

  /// `Road`
  String get icons_tags_road {
    return Intl.message('Road', name: 'icons_tags_road', desc: '', args: []);
  }

  /// `Transit`
  String get icons_tags_transit {
    return Intl.message(
      'Transit',
      name: 'icons_tags_transit',
      desc: '',
      args: [],
    );
  }

  /// `TV`
  String get icons_tags_tv {
    return Intl.message('TV', name: 'icons_tags_tv', desc: '', args: []);
  }

  /// `Television`
  String get icons_tags_television {
    return Intl.message(
      'Television',
      name: 'icons_tags_television',
      desc: '',
      args: [],
    );
  }

  /// `Umbrella`
  String get icons_tags_umbrella {
    return Intl.message(
      'Umbrella',
      name: 'icons_tags_umbrella',
      desc: '',
      args: [],
    );
  }

  /// `Rain`
  String get icons_tags_rain {
    return Intl.message('Rain', name: 'icons_tags_rain', desc: '', args: []);
  }

  /// `USB`
  String get icons_tags_usb {
    return Intl.message('USB', name: 'icons_tags_usb', desc: '', args: []);
  }

  /// `Connection`
  String get icons_tags_connection {
    return Intl.message(
      'Connection',
      name: 'icons_tags_connection',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get icons_tags_video {
    return Intl.message('Video', name: 'icons_tags_video', desc: '', args: []);
  }

  /// `Volume`
  String get icons_tags_volume {
    return Intl.message(
      'Volume',
      name: 'icons_tags_volume',
      desc: '',
      args: [],
    );
  }

  /// `Sound`
  String get icons_tags_sound {
    return Intl.message('Sound', name: 'icons_tags_sound', desc: '', args: []);
  }

  /// `Watch`
  String get icons_tags_watch {
    return Intl.message('Watch', name: 'icons_tags_watch', desc: '', args: []);
  }

  /// `Waves`
  String get icons_tags_waves {
    return Intl.message('Waves', name: 'icons_tags_waves', desc: '', args: []);
  }

  /// `Cloudy`
  String get icons_tags_cloudy {
    return Intl.message(
      'Cloudy',
      name: 'icons_tags_cloudy',
      desc: '',
      args: [],
    );
  }

  /// `Web`
  String get icons_tags_web {
    return Intl.message('Web', name: 'icons_tags_web', desc: '', args: []);
  }

  /// `Work`
  String get icons_tags_work {
    return Intl.message('Work', name: 'icons_tags_work', desc: '', args: []);
  }

  /// `Job`
  String get icons_tags_job {
    return Intl.message('Job', name: 'icons_tags_job', desc: '', args: []);
  }

  /// `Yard`
  String get icons_tags_yard {
    return Intl.message('Yard', name: 'icons_tags_yard', desc: '', args: []);
  }

  /// `Outdoor`
  String get icons_tags_outdoor {
    return Intl.message(
      'Outdoor',
      name: 'icons_tags_outdoor',
      desc: '',
      args: [],
    );
  }

  /// `Zoom`
  String get icons_tags_zoom {
    return Intl.message('Zoom', name: 'icons_tags_zoom', desc: '', args: []);
  }

  /// `Magnify`
  String get icons_tags_magnify {
    return Intl.message(
      'Magnify',
      name: 'icons_tags_magnify',
      desc: '',
      args: [],
    );
  }

  /// `Reduce`
  String get icons_tags_reduce {
    return Intl.message(
      'Reduce',
      name: 'icons_tags_reduce',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get icons_tags_add {
    return Intl.message('Add', name: 'icons_tags_add', desc: '', args: []);
  }

  /// `Plus`
  String get icons_tags_plus {
    return Intl.message('Plus', name: 'icons_tags_plus', desc: '', args: []);
  }

  /// `Delete`
  String get icons_tags_delete {
    return Intl.message(
      'Delete',
      name: 'icons_tags_delete',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get icons_tags_remove {
    return Intl.message(
      'Remove',
      name: 'icons_tags_remove',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get icons_tags_edit {
    return Intl.message('Edit', name: 'icons_tags_edit', desc: '', args: []);
  }

  /// `Modify`
  String get icons_tags_modify {
    return Intl.message(
      'Modify',
      name: 'icons_tags_modify',
      desc: '',
      args: [],
    );
  }

  /// `Check`
  String get icons_tags_check {
    return Intl.message('Check', name: 'icons_tags_check', desc: '', args: []);
  }

  /// `Confirm`
  String get icons_tags_confirm {
    return Intl.message(
      'Confirm',
      name: 'icons_tags_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get icons_tags_close {
    return Intl.message('Close', name: 'icons_tags_close', desc: '', args: []);
  }

  /// `Cancel`
  String get icons_tags_cancel {
    return Intl.message(
      'Cancel',
      name: 'icons_tags_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get icons_tags_menu {
    return Intl.message('Menu', name: 'icons_tags_menu', desc: '', args: []);
  }

  /// `More`
  String get icons_tags_more {
    return Intl.message('More', name: 'icons_tags_more', desc: '', args: []);
  }

  /// `Options`
  String get icons_tags_options {
    return Intl.message(
      'Options',
      name: 'icons_tags_options',
      desc: '',
      args: [],
    );
  }

  /// `Wheelchair`
  String get icons_tags_wheelchair {
    return Intl.message(
      'Wheelchair',
      name: 'icons_tags_wheelchair',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get icons_tags_account {
    return Intl.message(
      'Account',
      name: 'icons_tags_account',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get icons_tags_balance {
    return Intl.message(
      'Balance',
      name: 'icons_tags_balance',
      desc: '',
      args: [],
    );
  }

  /// `Bank`
  String get icons_tags_bank {
    return Intl.message('Bank', name: 'icons_tags_bank', desc: '', args: []);
  }

  /// `Profile`
  String get icons_tags_profile {
    return Intl.message(
      'Profile',
      name: 'icons_tags_profile',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get icons_tags_user {
    return Intl.message('User', name: 'icons_tags_user', desc: '', args: []);
  }

  /// `New`
  String get icons_tags_new {
    return Intl.message('New', name: 'icons_tags_new', desc: '', args: []);
  }

  /// `Control`
  String get icons_tags_control {
    return Intl.message(
      'Control',
      name: 'icons_tags_control',
      desc: '',
      args: [],
    );
  }

  /// `Screen`
  String get icons_tags_screen {
    return Intl.message(
      'Screen',
      name: 'icons_tags_screen',
      desc: '',
      args: [],
    );
  }

  /// `Farm`
  String get icons_tags_farm {
    return Intl.message('Farm', name: 'icons_tags_farm', desc: '', args: []);
  }

  /// `Air`
  String get icons_tags_air {
    return Intl.message('Air', name: 'icons_tags_air', desc: '', args: []);
  }

  /// `Airline`
  String get icons_tags_airline {
    return Intl.message(
      'Airline',
      name: 'icons_tags_airline',
      desc: '',
      args: [],
    );
  }

  /// `Seat`
  String get icons_tags_seat {
    return Intl.message('Seat', name: 'icons_tags_seat', desc: '', args: []);
  }

  /// `Individual`
  String get icons_tags_individual {
    return Intl.message(
      'Individual',
      name: 'icons_tags_individual',
      desc: '',
      args: [],
    );
  }

  /// `Suite`
  String get icons_tags_suite {
    return Intl.message('Suite', name: 'icons_tags_suite', desc: '', args: []);
  }

  /// `Legroom`
  String get icons_tags_legroom {
    return Intl.message(
      'Legroom',
      name: 'icons_tags_legroom',
      desc: '',
      args: [],
    );
  }

  /// `Recline`
  String get icons_tags_recline {
    return Intl.message(
      'Recline',
      name: 'icons_tags_recline',
      desc: '',
      args: [],
    );
  }

  /// `Off`
  String get icons_tags_off {
    return Intl.message('Off', name: 'icons_tags_off', desc: '', args: []);
  }

  /// `On`
  String get icons_tags_on {
    return Intl.message('On', name: 'icons_tags_on', desc: '', args: []);
  }

  /// `All`
  String get icons_tags_all {
    return Intl.message('All', name: 'icons_tags_all', desc: '', args: []);
  }

  /// `Inbox`
  String get icons_tags_inbox {
    return Intl.message('Inbox', name: 'icons_tags_inbox', desc: '', args: []);
  }

  /// `Out`
  String get icons_tags_out {
    return Intl.message('Out', name: 'icons_tags_out', desc: '', args: []);
  }

  /// `Arrow`
  String get icons_tags_arrow {
    return Intl.message('Arrow', name: 'icons_tags_arrow', desc: '', args: []);
  }

  /// `iOS`
  String get icons_tags_ios {
    return Intl.message('iOS', name: 'icons_tags_ios', desc: '', args: []);
  }

  /// `Circle`
  String get icons_tags_circle {
    return Intl.message(
      'Circle',
      name: 'icons_tags_circle',
      desc: '',
      args: [],
    );
  }

  /// `Down`
  String get icons_tags_down {
    return Intl.message('Down', name: 'icons_tags_down', desc: '', args: []);
  }

  /// `Up`
  String get icons_tags_up {
    return Intl.message('Up', name: 'icons_tags_up', desc: '', args: []);
  }

  /// `Forward`
  String get icons_tags_forward {
    return Intl.message(
      'Forward',
      name: 'icons_tags_forward',
      desc: '',
      args: [],
    );
  }

  /// `Right`
  String get icons_tags_right {
    return Intl.message('Right', name: 'icons_tags_right', desc: '', args: []);
  }

  /// `Alt`
  String get icons_tags_alt {
    return Intl.message('Alt', name: 'icons_tags_alt', desc: '', args: []);
  }

  /// `Upward`
  String get icons_tags_upward {
    return Intl.message(
      'Upward',
      name: 'icons_tags_upward',
      desc: '',
      args: [],
    );
  }

  /// `Article`
  String get icons_tags_article {
    return Intl.message(
      'Article',
      name: 'icons_tags_article',
      desc: '',
      args: [],
    );
  }

  /// `Document`
  String get icons_tags_document {
    return Intl.message(
      'Document',
      name: 'icons_tags_document',
      desc: '',
      args: [],
    );
  }

  /// `Aspect`
  String get icons_tags_aspect {
    return Intl.message(
      'Aspect',
      name: 'icons_tags_aspect',
      desc: '',
      args: [],
    );
  }

  /// `Ratio`
  String get icons_tags_ratio {
    return Intl.message('Ratio', name: 'icons_tags_ratio', desc: '', args: []);
  }

  /// `Assessment`
  String get icons_tags_assessment {
    return Intl.message(
      'Assessment',
      name: 'icons_tags_assessment',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get icons_tags_report {
    return Intl.message(
      'Report',
      name: 'icons_tags_report',
      desc: '',
      args: [],
    );
  }

  /// `Assignment`
  String get icons_tags_assignment {
    return Intl.message(
      'Assignment',
      name: 'icons_tags_assignment',
      desc: '',
      args: [],
    );
  }

  /// `Task`
  String get icons_tags_task {
    return Intl.message('Task', name: 'icons_tags_task', desc: '', args: []);
  }

  /// `Turned`
  String get icons_tags_turned {
    return Intl.message(
      'Turned',
      name: 'icons_tags_turned',
      desc: '',
      args: [],
    );
  }

  /// `In`
  String get icons_tags_in {
    return Intl.message('In', name: 'icons_tags_in', desc: '', args: []);
  }

  /// `Assistant`
  String get icons_tags_assistant {
    return Intl.message(
      'Assistant',
      name: 'icons_tags_assistant',
      desc: '',
      args: [],
    );
  }

  /// `Direction`
  String get icons_tags_direction {
    return Intl.message(
      'Direction',
      name: 'icons_tags_direction',
      desc: '',
      args: [],
    );
  }

  /// `Attribution`
  String get icons_tags_attribution {
    return Intl.message(
      'Attribution',
      name: 'icons_tags_attribution',
      desc: '',
      args: [],
    );
  }

  /// `Credit`
  String get icons_tags_credit {
    return Intl.message(
      'Credit',
      name: 'icons_tags_credit',
      desc: '',
      args: [],
    );
  }

  /// `Auto`
  String get icons_tags_auto {
    return Intl.message('Auto', name: 'icons_tags_auto', desc: '', args: []);
  }

  /// `Awesome`
  String get icons_tags_awesome {
    return Intl.message(
      'Awesome',
      name: 'icons_tags_awesome',
      desc: '',
      args: [],
    );
  }

  /// `Mosaic`
  String get icons_tags_mosaic {
    return Intl.message(
      'Mosaic',
      name: 'icons_tags_mosaic',
      desc: '',
      args: [],
    );
  }

  /// `Motion`
  String get icons_tags_motion {
    return Intl.message(
      'Motion',
      name: 'icons_tags_motion',
      desc: '',
      args: [],
    );
  }

  /// `Renew`
  String get icons_tags_renew {
    return Intl.message('Renew', name: 'icons_tags_renew', desc: '', args: []);
  }

  /// `AV`
  String get icons_tags_av {
    return Intl.message('AV', name: 'icons_tags_av', desc: '', args: []);
  }

  /// `Timer`
  String get icons_tags_timer {
    return Intl.message('Timer', name: 'icons_tags_timer', desc: '', args: []);
  }

  /// `Back`
  String get icons_tags_back {
    return Intl.message('Back', name: 'icons_tags_back', desc: '', args: []);
  }

  /// `Hand`
  String get icons_tags_hand {
    return Intl.message('Hand', name: 'icons_tags_hand', desc: '', args: []);
  }

  /// `Backpack`
  String get icons_tags_backpack {
    return Intl.message(
      'Backpack',
      name: 'icons_tags_backpack',
      desc: '',
      args: [],
    );
  }

  /// `Backspace`
  String get icons_tags_backspace {
    return Intl.message(
      'Backspace',
      name: 'icons_tags_backspace',
      desc: '',
      args: [],
    );
  }

  /// `Bakery`
  String get icons_tags_bakery {
    return Intl.message(
      'Bakery',
      name: 'icons_tags_bakery',
      desc: '',
      args: [],
    );
  }

  /// `Balcony`
  String get icons_tags_balcony {
    return Intl.message(
      'Balcony',
      name: 'icons_tags_balcony',
      desc: '',
      args: [],
    );
  }

  /// `Bathtub`
  String get icons_tags_bathtub {
    return Intl.message(
      'Bathtub',
      name: 'icons_tags_bathtub',
      desc: '',
      args: [],
    );
  }

  /// `Relax`
  String get icons_tags_relax {
    return Intl.message('Relax', name: 'icons_tags_relax', desc: '', args: []);
  }

  /// `Full`
  String get icons_tags_full {
    return Intl.message('Full', name: 'icons_tags_full', desc: '', args: []);
  }

  /// `Standard`
  String get icons_tags_standard {
    return Intl.message(
      'Standard',
      name: 'icons_tags_standard',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get icons_tags_unknown {
    return Intl.message(
      'Unknown',
      name: 'icons_tags_unknown',
      desc: '',
      args: [],
    );
  }

  /// `Bed`
  String get icons_tags_bed {
    return Intl.message('Bed', name: 'icons_tags_bed', desc: '', args: []);
  }

  /// `Sleep`
  String get icons_tags_sleep {
    return Intl.message('Sleep', name: 'icons_tags_sleep', desc: '', args: []);
  }

  /// `Bedtime`
  String get icons_tags_bedtime {
    return Intl.message(
      'Bedtime',
      name: 'icons_tags_bedtime',
      desc: '',
      args: [],
    );
  }

  /// `Bento`
  String get icons_tags_bento {
    return Intl.message('Bento', name: 'icons_tags_bento', desc: '', args: []);
  }

  /// `Biotech`
  String get icons_tags_biotech {
    return Intl.message(
      'Biotech',
      name: 'icons_tags_biotech',
      desc: '',
      args: [],
    );
  }

  /// `Science`
  String get icons_tags_science {
    return Intl.message(
      'Science',
      name: 'icons_tags_science',
      desc: '',
      args: [],
    );
  }

  /// `Blender`
  String get icons_tags_blender {
    return Intl.message(
      'Blender',
      name: 'icons_tags_blender',
      desc: '',
      args: [],
    );
  }

  /// `Block`
  String get icons_tags_block {
    return Intl.message('Block', name: 'icons_tags_block', desc: '', args: []);
  }

  /// `Stop`
  String get icons_tags_stop {
    return Intl.message('Stop', name: 'icons_tags_stop', desc: '', args: []);
  }

  /// `Blood`
  String get icons_tags_blood {
    return Intl.message('Blood', name: 'icons_tags_blood', desc: '', args: []);
  }

  /// `Type`
  String get icons_tags_type {
    return Intl.message('Type', name: 'icons_tags_type', desc: '', args: []);
  }

  /// `Connected`
  String get icons_tags_connected {
    return Intl.message(
      'Connected',
      name: 'icons_tags_connected',
      desc: '',
      args: [],
    );
  }

  /// `Disabled`
  String get icons_tags_disabled {
    return Intl.message(
      'Disabled',
      name: 'icons_tags_disabled',
      desc: '',
      args: [],
    );
  }

  /// `Searching`
  String get icons_tags_searching {
    return Intl.message(
      'Searching',
      name: 'icons_tags_searching',
      desc: '',
      args: [],
    );
  }

  /// `Blur`
  String get icons_tags_blur {
    return Intl.message('Blur', name: 'icons_tags_blur', desc: '', args: []);
  }

  /// `Circular`
  String get icons_tags_circular {
    return Intl.message(
      'Circular',
      name: 'icons_tags_circular',
      desc: '',
      args: [],
    );
  }

  /// `Linear`
  String get icons_tags_linear {
    return Intl.message(
      'Linear',
      name: 'icons_tags_linear',
      desc: '',
      args: [],
    );
  }

  /// `Bookmark`
  String get icons_tags_bookmark {
    return Intl.message(
      'Bookmark',
      name: 'icons_tags_bookmark',
      desc: '',
      args: [],
    );
  }

  /// `Bookmarks`
  String get icons_tags_bookmarks {
    return Intl.message(
      'Bookmarks',
      name: 'icons_tags_bookmarks',
      desc: '',
      args: [],
    );
  }

  /// `List`
  String get icons_tags_list {
    return Intl.message('List', name: 'icons_tags_list', desc: '', args: []);
  }

  /// `Broken`
  String get icons_tags_broken {
    return Intl.message(
      'Broken',
      name: 'icons_tags_broken',
      desc: '',
      args: [],
    );
  }

  /// `Browse`
  String get icons_tags_browse {
    return Intl.message(
      'Browse',
      name: 'icons_tags_browse',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get icons_tags_gallery {
    return Intl.message(
      'Gallery',
      name: 'icons_tags_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Bubble`
  String get icons_tags_bubble {
    return Intl.message(
      'Bubble',
      name: 'icons_tags_bubble',
      desc: '',
      args: [],
    );
  }

  /// `Chart`
  String get icons_tags_chart {
    return Intl.message('Chart', name: 'icons_tags_chart', desc: '', args: []);
  }

  /// `Build`
  String get icons_tags_build {
    return Intl.message('Build', name: 'icons_tags_build', desc: '', args: []);
  }

  /// `Center`
  String get icons_tags_center {
    return Intl.message(
      'Center',
      name: 'icons_tags_center',
      desc: '',
      args: [],
    );
  }

  /// `Cabin`
  String get icons_tags_cabin {
    return Intl.message('Cabin', name: 'icons_tags_cabin', desc: '', args: []);
  }

  /// `Cable`
  String get icons_tags_cable {
    return Intl.message('Cable', name: 'icons_tags_cable', desc: '', args: []);
  }

  /// `Calendar`
  String get icons_tags_calendar {
    return Intl.message(
      'Calendar',
      name: 'icons_tags_calendar',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get icons_tags_today {
    return Intl.message('Today', name: 'icons_tags_today', desc: '', args: []);
  }

  /// `View`
  String get icons_tags_view {
    return Intl.message('View', name: 'icons_tags_view', desc: '', args: []);
  }

  /// `Day`
  String get icons_tags_day {
    return Intl.message('Day', name: 'icons_tags_day', desc: '', args: []);
  }

  /// `End`
  String get icons_tags_end {
    return Intl.message('End', name: 'icons_tags_end', desc: '', args: []);
  }

  /// `Made`
  String get icons_tags_made {
    return Intl.message('Made', name: 'icons_tags_made', desc: '', args: []);
  }

  /// `Merge`
  String get icons_tags_merge {
    return Intl.message('Merge', name: 'icons_tags_merge', desc: '', args: []);
  }

  /// `Missed`
  String get icons_tags_missed {
    return Intl.message(
      'Missed',
      name: 'icons_tags_missed',
      desc: '',
      args: [],
    );
  }

  /// `Received`
  String get icons_tags_received {
    return Intl.message(
      'Received',
      name: 'icons_tags_received',
      desc: '',
      args: [],
    );
  }

  /// `Split`
  String get icons_tags_split {
    return Intl.message('Split', name: 'icons_tags_split', desc: '', args: []);
  }

  /// `Enhance`
  String get icons_tags_enhance {
    return Intl.message(
      'Enhance',
      name: 'icons_tags_enhance',
      desc: '',
      args: [],
    );
  }

  /// `Front`
  String get icons_tags_front {
    return Intl.message('Front', name: 'icons_tags_front', desc: '', args: []);
  }

  /// `Rear`
  String get icons_tags_rear {
    return Intl.message('Rear', name: 'icons_tags_rear', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
