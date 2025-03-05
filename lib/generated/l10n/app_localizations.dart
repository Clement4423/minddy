import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr')
  ];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'minddy'**
  String get app_name;

  /// No description provided for @app_slogan.
  ///
  /// In en, this message translates to:
  /// **'Everything happens here.'**
  String get app_slogan;

  /// No description provided for @system_files_copy_text.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get system_files_copy_text;

  /// No description provided for @appbar_go_home.
  ///
  /// In en, this message translates to:
  /// **'Go back home'**
  String get appbar_go_home;

  /// No description provided for @welcome_appbar.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome_appbar;

  /// No description provided for @welcome_before_creating.
  ///
  /// In en, this message translates to:
  /// **'First of all, please enter your first name'**
  String get welcome_before_creating;

  /// No description provided for @welcome_because.
  ///
  /// In en, this message translates to:
  /// **'To personalize your experience'**
  String get welcome_because;

  /// No description provided for @welcome_pass_username.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get welcome_pass_username;

  /// No description provided for @welcome_pass_tooltip.
  ///
  /// In en, this message translates to:
  /// **'You will still be able to enter your first name in settings / {accountSettingName}'**
  String welcome_pass_tooltip(Object accountSettingName);

  /// No description provided for @welcome_pass_default_username.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get welcome_pass_default_username;

  /// No description provided for @welcome_enter_name.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get welcome_enter_name;

  /// No description provided for @welcome_first_name_too_long.
  ///
  /// In en, this message translates to:
  /// **'The first name cannot be longer than 25 letters'**
  String get welcome_first_name_too_long;

  /// No description provided for @welcome_should_provide.
  ///
  /// In en, this message translates to:
  /// **'Please, provide your first name'**
  String get welcome_should_provide;

  /// No description provided for @welcome_error_save_username.
  ///
  /// In en, this message translates to:
  /// **'An error occured while saving your name. Please try again'**
  String get welcome_error_save_username;

  /// No description provided for @welcome_next_page_semantic.
  ///
  /// In en, this message translates to:
  /// **'Next page'**
  String get welcome_next_page_semantic;

  /// No description provided for @welcome_password_creation_title.
  ///
  /// In en, this message translates to:
  /// **'Now, create a password'**
  String get welcome_password_creation_title;

  /// No description provided for @welcome_password_creation_description.
  ///
  /// In en, this message translates to:
  /// **'To keep your data secured'**
  String get welcome_password_creation_description;

  /// No description provided for @welcome_password_creation_hint.
  ///
  /// In en, this message translates to:
  /// **'Create your password'**
  String get welcome_password_creation_hint;

  /// No description provided for @welcome_password_creation_confirm_hint.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get welcome_password_creation_confirm_hint;

  /// No description provided for @welcome_password_creation_error_must_provide.
  ///
  /// In en, this message translates to:
  /// **'Please, create a password'**
  String get welcome_password_creation_error_must_provide;

  /// No description provided for @welcome_password_creation_error_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get welcome_password_creation_error_not_match;

  /// No description provided for @welcome_password_creation_show_semantic.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get welcome_password_creation_show_semantic;

  /// No description provided for @welcome_password_creation_hide_semantic.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get welcome_password_creation_hide_semantic;

  /// No description provided for @welcome_password_creation_error_password_save.
  ///
  /// In en, this message translates to:
  /// **'An error occured while saving your password'**
  String get welcome_password_creation_error_password_save;

  /// No description provided for @welcome_password_creation_remember.
  ///
  /// In en, this message translates to:
  /// **'Add a password hint (optional)'**
  String get welcome_password_creation_remember;

  /// No description provided for @welcome_password_creation_password_requirements.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, and one digit.'**
  String get welcome_password_creation_password_requirements;

  /// No description provided for @calendar_main_calendar_name.
  ///
  /// In en, this message translates to:
  /// **'Main calendar'**
  String get calendar_main_calendar_name;

  /// No description provided for @calendar_button_new_event_button_title.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get calendar_button_new_event_button_title;

  /// No description provided for @calendar_button_new_due_date_button_title.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get calendar_button_new_due_date_button_title;

  /// No description provided for @calendar_button_calendar_title.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar_button_calendar_title;

  /// No description provided for @calendar_button_next_events_title.
  ///
  /// In en, this message translates to:
  /// **'Next events'**
  String get calendar_button_next_events_title;

  /// No description provided for @calendar_button_next_due_dates_title.
  ///
  /// In en, this message translates to:
  /// **'Due dates'**
  String get calendar_button_next_due_dates_title;

  /// No description provided for @calendar_button_add_event_button_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Add event'**
  String get calendar_button_add_event_button_tooltip;

  /// No description provided for @calendar_button_manage_calendar_button_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Manage calendar'**
  String get calendar_button_manage_calendar_button_tooltip;

  /// No description provided for @calendar_button_event_date_yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get calendar_button_event_date_yesterday;

  /// No description provided for @calendar_button_event_date_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get calendar_button_event_date_today;

  /// No description provided for @calendar_button_event_date_tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get calendar_button_event_date_tomorrow;

  /// No description provided for @calendar_button_due_date_cancel_complete.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get calendar_button_due_date_cancel_complete;

  /// No description provided for @calendar_button_due_date_has_been_complete.
  ///
  /// In en, this message translates to:
  /// **'{eventName} has been completed by {username}'**
  String calendar_button_due_date_has_been_complete(Object eventName, Object username);

  /// No description provided for @calendar_event_detailed_preview_not_completed_yet.
  ///
  /// In en, this message translates to:
  /// **'Not completed yet'**
  String get calendar_event_detailed_preview_not_completed_yet;

  /// No description provided for @calendar_event_detailed_preview_completed_by.
  ///
  /// In en, this message translates to:
  /// **'Completed by {username}'**
  String calendar_event_detailed_preview_completed_by(Object username);

  /// No description provided for @calendar_new_event_title.
  ///
  /// In en, this message translates to:
  /// **'New event'**
  String get calendar_new_event_title;

  /// No description provided for @calendar_modify_event_title.
  ///
  /// In en, this message translates to:
  /// **'Modify event'**
  String get calendar_modify_event_title;

  /// No description provided for @calendar_new_due_date_title.
  ///
  /// In en, this message translates to:
  /// **'New due date'**
  String get calendar_new_due_date_title;

  /// No description provided for @calendar_modify_due_date_title.
  ///
  /// In en, this message translates to:
  /// **'Modify due date'**
  String get calendar_modify_due_date_title;

  /// No description provided for @calendar_new_event_whole_day.
  ///
  /// In en, this message translates to:
  /// **'Whole day'**
  String get calendar_new_event_whole_day;

  /// No description provided for @calendar_new_event_recurrence_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Recurrence'**
  String get calendar_new_event_recurrence_subtitle;

  /// No description provided for @calendar_new_event_recurrence_type_never.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get calendar_new_event_recurrence_type_never;

  /// No description provided for @calendar_new_event_recurrence_type_everyday.
  ///
  /// In en, this message translates to:
  /// **'Every day'**
  String get calendar_new_event_recurrence_type_everyday;

  /// No description provided for @calendar_new_event_recurrence_type_everyweek.
  ///
  /// In en, this message translates to:
  /// **'Every week'**
  String get calendar_new_event_recurrence_type_everyweek;

  /// No description provided for @calendar_new_event_recurrence_type_everymonth.
  ///
  /// In en, this message translates to:
  /// **'Every month'**
  String get calendar_new_event_recurrence_type_everymonth;

  /// No description provided for @calendar_new_event_recurrence_type_everyyear.
  ///
  /// In en, this message translates to:
  /// **'Every year'**
  String get calendar_new_event_recurrence_type_everyyear;

  /// No description provided for @calendar_new_event_recurrence_select_calendar.
  ///
  /// In en, this message translates to:
  /// **'Select a calendar'**
  String get calendar_new_event_recurrence_select_calendar;

  /// No description provided for @calendar_button_open_week_view_button_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Open week-view'**
  String get calendar_button_open_week_view_button_tooltip;

  /// No description provided for @calendar_button_event_selection_menu_only_this_event.
  ///
  /// In en, this message translates to:
  /// **'Only this event'**
  String get calendar_button_event_selection_menu_only_this_event;

  /// No description provided for @calendar_button_event_selection_menu_all_occurence.
  ///
  /// In en, this message translates to:
  /// **'All occurrences'**
  String get calendar_button_event_selection_menu_all_occurence;

  /// No description provided for @calendar_button_free_for_next_days.
  ///
  /// In en, this message translates to:
  /// **'You are free for the next 5 days'**
  String get calendar_button_free_for_next_days;

  /// No description provided for @calendar_button_manage_calendars_sub_menu_all_calendars_subtitle.
  ///
  /// In en, this message translates to:
  /// **'All calendars'**
  String get calendar_button_manage_calendars_sub_menu_all_calendars_subtitle;

  /// No description provided for @calendar_button_manage_calendars_sub_menu_add_calendar.
  ///
  /// In en, this message translates to:
  /// **'New calendar'**
  String get calendar_button_manage_calendars_sub_menu_add_calendar;

  /// No description provided for @calendar_button_manage_calendars_sub_menu_modify_calendar.
  ///
  /// In en, this message translates to:
  /// **'Modify calendar'**
  String get calendar_button_manage_calendars_sub_menu_modify_calendar;

  /// No description provided for @calendar_button_new_calendar_calendar_subtitle_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get calendar_button_new_calendar_calendar_subtitle_name;

  /// No description provided for @calendar_button_new_calendar_personalized_color.
  ///
  /// In en, this message translates to:
  /// **'Personalized'**
  String get calendar_button_new_calendar_personalized_color;

  /// No description provided for @calendar_button_new_calendar_private_calendar_title.
  ///
  /// In en, this message translates to:
  /// **'Private calendar'**
  String get calendar_button_new_calendar_private_calendar_title;

  /// No description provided for @calendar_button_new_calendar_private_calendar_explanation.
  ///
  /// In en, this message translates to:
  /// **'By enabling this, the password will be required to see events from this calendar'**
  String get calendar_button_new_calendar_private_calendar_explanation;

  /// No description provided for @calendar_button_event_preview_private_event.
  ///
  /// In en, this message translates to:
  /// **'This event is private.'**
  String get calendar_button_event_preview_private_event;

  /// No description provided for @calendar_button_event_preview_see_button.
  ///
  /// In en, this message translates to:
  /// **'See'**
  String get calendar_button_event_preview_see_button;

  /// No description provided for @calendar_button_event_preview_recurence_text_every_day.
  ///
  /// In en, this message translates to:
  /// **'{interval, plural, one {Everyday} other {Every {interval} days}}'**
  String calendar_button_event_preview_recurence_text_every_day(num interval);

  /// No description provided for @calendar_button_event_preview_recurence_text_every_week.
  ///
  /// In en, this message translates to:
  /// **'{interval, plural, one {Every week} other {Every {interval} weeks}}'**
  String calendar_button_event_preview_recurence_text_every_week(num interval);

  /// No description provided for @calendar_button_event_preview_recurence_text_every_month.
  ///
  /// In en, this message translates to:
  /// **'{interval, plural, one {Every month} other {Every {interval} months}}'**
  String calendar_button_event_preview_recurence_text_every_month(num interval);

  /// No description provided for @calendar_button_event_preview_recurence_text_every_year.
  ///
  /// In en, this message translates to:
  /// **'{interval, plural, one {Every year} other {Every {interval} years}}'**
  String calendar_button_event_preview_recurence_text_every_year(num interval);

  /// No description provided for @calendar_week_view_week_title.
  ///
  /// In en, this message translates to:
  /// **'Week {week}'**
  String calendar_week_view_week_title(Object week);

  /// No description provided for @calendar_week_view_week_details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get calendar_week_view_week_details;

  /// No description provided for @calendar_new_due_date_event_completion_state_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Completion state'**
  String get calendar_new_due_date_event_completion_state_subtitle;

  /// No description provided for @calendar_new_due_date_event_completion_state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get calendar_new_due_date_event_completion_state;

  /// No description provided for @calendar_new_event_recurence_type_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get calendar_new_event_recurence_type_subtitle;

  /// No description provided for @calendar_new_event_recurence_every_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Every'**
  String get calendar_new_event_recurence_every_subtitle;

  /// No description provided for @calendar_new_event_recurence_every_day.
  ///
  /// In en, this message translates to:
  /// **'{interval, plural, one {day} other {days}}'**
  String calendar_new_event_recurence_every_day(num interval);

  /// No description provided for @calendar_new_event_recurence_every_week.
  ///
  /// In en, this message translates to:
  /// **'{interval, plural, one {week} other {weeks}}'**
  String calendar_new_event_recurence_every_week(num interval);

  /// No description provided for @calendar_new_event_recurence_every_month.
  ///
  /// In en, this message translates to:
  /// **'{interval, plural, one {month} other {months}}'**
  String calendar_new_event_recurence_every_month(num interval);

  /// No description provided for @calendar_new_event_recurence_every_year.
  ///
  /// In en, this message translates to:
  /// **'{interval, plural, one {year} other {years}}'**
  String calendar_new_event_recurence_every_year(num interval);

  /// No description provided for @calendar_new_event_recurence_end_date.
  ///
  /// In en, this message translates to:
  /// **'End date'**
  String get calendar_new_event_recurence_end_date;

  /// No description provided for @calendar_new_event_recurence_end_date_option_the.
  ///
  /// In en, this message translates to:
  /// **'The...'**
  String get calendar_new_event_recurence_end_date_option_the;

  /// No description provided for @center_menu_general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get center_menu_general;

  /// No description provided for @center_menu_others.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get center_menu_others;

  /// No description provided for @settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// No description provided for @settings_personalize_title.
  ///
  /// In en, this message translates to:
  /// **'Personalize'**
  String get settings_personalize_title;

  /// No description provided for @settings_accessibility_title.
  ///
  /// In en, this message translates to:
  /// **'Accessibility'**
  String get settings_accessibility_title;

  /// No description provided for @settings_security_title.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get settings_security_title;

  /// No description provided for @settings_account_title.
  ///
  /// In en, this message translates to:
  /// **'My account'**
  String get settings_account_title;

  /// No description provided for @settings_theme_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settings_theme_subtitle;

  /// No description provided for @settings_using_dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get settings_using_dark_mode;

  /// No description provided for @settings_using_light_mode.
  ///
  /// In en, this message translates to:
  /// **'Light mode'**
  String get settings_using_light_mode;

  /// No description provided for @settings_need_to_quit_project_to_change_theme.
  ///
  /// In en, this message translates to:
  /// **'To change theme settings, please go back at home'**
  String get settings_need_to_quit_project_to_change_theme;

  /// No description provided for @settings_need_to_quit_project_to_change_language.
  ///
  /// In en, this message translates to:
  /// **'To change language, please go back at home'**
  String get settings_need_to_quit_project_to_change_language;

  /// No description provided for @settings_using_system_theme.
  ///
  /// In en, this message translates to:
  /// **'Device theme'**
  String get settings_using_system_theme;

  /// No description provided for @settings_personalize_black_and_white_title.
  ///
  /// In en, this message translates to:
  /// **'Black and white mode'**
  String get settings_personalize_black_and_white_title;

  /// No description provided for @settings_date_format_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Date format'**
  String get settings_date_format_subtitle;

  /// No description provided for @settings_date_format.
  ///
  /// In en, this message translates to:
  /// **'Prefer MM/dd date format'**
  String get settings_date_format;

  /// No description provided for @settings_date_format_tooltip.
  ///
  /// In en, this message translates to:
  /// **'This option will put the month before the day. Like this : {actualMonth}/{actualDay}'**
  String settings_date_format_tooltip(Object actualDay, Object actualMonth);

  /// No description provided for @settings_language_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language_subtitle;

  /// No description provided for @settings_username_subtitle.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get settings_username_subtitle;

  /// No description provided for @settings_reset_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get settings_reset_subtitle;

  /// No description provided for @settings_reset_button.
  ///
  /// In en, this message translates to:
  /// **'Reset settings'**
  String get settings_reset_button;

  /// No description provided for @settings_project_rename_button.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get settings_project_rename_button;

  /// No description provided for @settings_project_rename_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get settings_project_rename_subtitle;

  /// No description provided for @settings_project_delete_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get settings_project_delete_subtitle;

  /// No description provided for @settings_project_delete_button.
  ///
  /// In en, this message translates to:
  /// **'Delete this project'**
  String get settings_project_delete_button;

  /// No description provided for @settings_project_privacy_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settings_project_privacy_subtitle;

  /// No description provided for @settings_project_private_project.
  ///
  /// In en, this message translates to:
  /// **'Private project'**
  String get settings_project_private_project;

  /// No description provided for @articles_search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get articles_search;

  /// No description provided for @articles_search_explain.
  ///
  /// In en, this message translates to:
  /// **'Search a title, author'**
  String get articles_search_explain;

  /// No description provided for @articles_search_empty.
  ///
  /// In en, this message translates to:
  /// **'No result'**
  String get articles_search_empty;

  /// No description provided for @articles_impossible_to_load_content.
  ///
  /// In en, this message translates to:
  /// **'Impossible to load article content'**
  String get articles_impossible_to_load_content;

  /// No description provided for @articles_corrupted_file.
  ///
  /// In en, this message translates to:
  /// **'This article is corrupted'**
  String get articles_corrupted_file;

  /// No description provided for @articles_importer_images_found_many.
  ///
  /// In en, this message translates to:
  /// **'{count} images found. Do you want to import them ?'**
  String articles_importer_images_found_many(Object count);

  /// No description provided for @articles_importer_image_found_single.
  ///
  /// In en, this message translates to:
  /// **'1 image found. Do you want to import it ?'**
  String get articles_importer_image_found_single;

  /// No description provided for @articles_importer_import_images_title.
  ///
  /// In en, this message translates to:
  /// **'Import images'**
  String get articles_importer_import_images_title;

  /// No description provided for @articles_importer_import_images_button.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get articles_importer_import_images_button;

  /// No description provided for @articles_importer_dont_import_images_button.
  ///
  /// In en, this message translates to:
  /// **'Don\'t import'**
  String get articles_importer_dont_import_images_button;

  /// No description provided for @articles_empty_menu_page_text.
  ///
  /// In en, this message translates to:
  /// **'No articles for this category yet, import, or write one !'**
  String get articles_empty_menu_page_text;

  /// No description provided for @articles_empty_menu_saved_page_text.
  ///
  /// In en, this message translates to:
  /// **'No saved article yet'**
  String get articles_empty_menu_saved_page_text;

  /// No description provided for @articles_new_article.
  ///
  /// In en, this message translates to:
  /// **'New article'**
  String get articles_new_article;

  /// No description provided for @articles_import_articles.
  ///
  /// In en, this message translates to:
  /// **'Import articles'**
  String get articles_import_articles;

  /// No description provided for @articles_export_articles.
  ///
  /// In en, this message translates to:
  /// **'Export this article'**
  String get articles_export_articles;

  /// No description provided for @articles_export_articles_choose_category.
  ///
  /// In en, this message translates to:
  /// **'Choose a category'**
  String get articles_export_articles_choose_category;

  /// No description provided for @articles_export_canceled.
  ///
  /// In en, this message translates to:
  /// **'Article has not been exported'**
  String get articles_export_canceled;

  /// No description provided for @articles_export_confirmed.
  ///
  /// In en, this message translates to:
  /// **'Article has been exported'**
  String get articles_export_confirmed;

  /// No description provided for @articles_export_confirmed_button.
  ///
  /// In en, this message translates to:
  /// **'See the location'**
  String get articles_export_confirmed_button;

  /// No description provided for @articles_creativity_title.
  ///
  /// In en, this message translates to:
  /// **'Creativity'**
  String get articles_creativity_title;

  /// No description provided for @articles_daily_life_title.
  ///
  /// In en, this message translates to:
  /// **'Daily life'**
  String get articles_daily_life_title;

  /// No description provided for @articles_professional_title.
  ///
  /// In en, this message translates to:
  /// **'Professional'**
  String get articles_professional_title;

  /// No description provided for @articles_wellness_title.
  ///
  /// In en, this message translates to:
  /// **'Wellness'**
  String get articles_wellness_title;

  /// No description provided for @articles_technology_title.
  ///
  /// In en, this message translates to:
  /// **'Technology'**
  String get articles_technology_title;

  /// No description provided for @articles_education_title.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get articles_education_title;

  /// No description provided for @articles_science_title.
  ///
  /// In en, this message translates to:
  /// **'Science'**
  String get articles_science_title;

  /// No description provided for @articles_philosophy_title.
  ///
  /// In en, this message translates to:
  /// **'Philosophy'**
  String get articles_philosophy_title;

  /// No description provided for @articles_environment_title.
  ///
  /// In en, this message translates to:
  /// **'Nature'**
  String get articles_environment_title;

  /// No description provided for @articles_travel_title.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get articles_travel_title;

  /// No description provided for @articles_finance_title.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get articles_finance_title;

  /// No description provided for @articles_politics_title.
  ///
  /// In en, this message translates to:
  /// **'Politics'**
  String get articles_politics_title;

  /// No description provided for @articles_food_title.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get articles_food_title;

  /// No description provided for @articles_saved_title.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get articles_saved_title;

  /// No description provided for @articles_my_articles_title.
  ///
  /// In en, this message translates to:
  /// **'My Articles'**
  String get articles_my_articles_title;

  /// No description provided for @articles_read_button.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get articles_read_button;

  /// No description provided for @articles_sources_text.
  ///
  /// In en, this message translates to:
  /// **'Sources'**
  String get articles_sources_text;

  /// No description provided for @articles_bookmark_semantic_text.
  ///
  /// In en, this message translates to:
  /// **'Bookmark article'**
  String get articles_bookmark_semantic_text;

  /// No description provided for @articles_add_text_semantic_text.
  ///
  /// In en, this message translates to:
  /// **'Add a text bloc'**
  String get articles_add_text_semantic_text;

  /// No description provided for @articles_add_subtitle_semantic_text.
  ///
  /// In en, this message translates to:
  /// **'Add a subtitle'**
  String get articles_add_subtitle_semantic_text;

  /// No description provided for @articles_add_image_semantic_text.
  ///
  /// In en, this message translates to:
  /// **'Add an image'**
  String get articles_add_image_semantic_text;

  /// No description provided for @articles_go_back_semantic_text.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get articles_go_back_semantic_text;

  /// No description provided for @articles_card_untitled.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get articles_card_untitled;

  /// No description provided for @articles_title_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter a title...'**
  String get articles_title_hint;

  /// No description provided for @articles_subtitle_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter a subtitle...'**
  String get articles_subtitle_hint;

  /// No description provided for @articles_text_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter some text...'**
  String get articles_text_hint;

  /// No description provided for @articles_code_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter some code...'**
  String get articles_code_hint;

  /// No description provided for @articles_copy_text.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get articles_copy_text;

  /// No description provided for @articles_copy_to_notes_text.
  ///
  /// In en, this message translates to:
  /// **'Add to notes'**
  String get articles_copy_to_notes_text;

  /// No description provided for @articles_add_to_content.
  ///
  /// In en, this message translates to:
  /// **'Add to article'**
  String get articles_add_to_content;

  /// No description provided for @articles_images_add_button.
  ///
  /// In en, this message translates to:
  /// **'Add an image'**
  String get articles_images_add_button;

  /// No description provided for @articles_images_change_button.
  ///
  /// In en, this message translates to:
  /// **'Change image'**
  String get articles_images_change_button;

  /// No description provided for @articles_card_delete_this_article.
  ///
  /// In en, this message translates to:
  /// **'this article'**
  String get articles_card_delete_this_article;

  /// No description provided for @articles_bottom_menu_open_semantic_text.
  ///
  /// In en, this message translates to:
  /// **'Open menu'**
  String get articles_bottom_menu_open_semantic_text;

  /// No description provided for @articles_bottom_menu_close_semantic_text.
  ///
  /// In en, this message translates to:
  /// **'Close menu'**
  String get articles_bottom_menu_close_semantic_text;

  /// No description provided for @articles_bottom_menu_sources_button.
  ///
  /// In en, this message translates to:
  /// **'Sources'**
  String get articles_bottom_menu_sources_button;

  /// No description provided for @articles_bottom_menu_content_button.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get articles_bottom_menu_content_button;

  /// No description provided for @articles_bottom_menu_notes_button.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get articles_bottom_menu_notes_button;

  /// No description provided for @articles_add_source_hint.
  ///
  /// In en, this message translates to:
  /// **'Indicate a source...'**
  String get articles_add_source_hint;

  /// No description provided for @articles_add_source_button.
  ///
  /// In en, this message translates to:
  /// **'Add a source'**
  String get articles_add_source_button;

  /// No description provided for @articles_no_notes.
  ///
  /// In en, this message translates to:
  /// **'No notes yet ! Click \'{actionName}\' on any article element to start taking some.'**
  String articles_no_notes(Object actionName);

  /// No description provided for @articles_no_sources.
  ///
  /// In en, this message translates to:
  /// **'No sources provided yet! Remember to include sources for future readers.'**
  String get articles_no_sources;

  /// No description provided for @articles_no_content.
  ///
  /// In en, this message translates to:
  /// **'This article is empty ! Start adding elements to move them.'**
  String get articles_no_content;

  /// No description provided for @articles_calculate_reading_time.
  ///
  /// In en, this message translates to:
  /// **'Calculate reading time'**
  String get articles_calculate_reading_time;

  /// No description provided for @articles_add_list_semantic_text.
  ///
  /// In en, this message translates to:
  /// **'Add a list'**
  String get articles_add_list_semantic_text;

  /// No description provided for @articles_add_code_semantic_text.
  ///
  /// In en, this message translates to:
  /// **'Add a code block'**
  String get articles_add_code_semantic_text;

  /// No description provided for @articles_define_language.
  ///
  /// In en, this message translates to:
  /// **'Define language'**
  String get articles_define_language;

  /// No description provided for @articles_imported.
  ///
  /// In en, this message translates to:
  /// **'Articles have been imported'**
  String get articles_imported;

  /// No description provided for @articles_not_imported.
  ///
  /// In en, this message translates to:
  /// **'Articles have not been imported'**
  String get articles_not_imported;

  /// No description provided for @snackbar_cancel_button.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get snackbar_cancel_button;

  /// No description provided for @snackbar_restart_needed_text.
  ///
  /// In en, this message translates to:
  /// **'You will need to restart the app to apply changes'**
  String get snackbar_restart_needed_text;

  /// No description provided for @snackbar_restart_button.
  ///
  /// In en, this message translates to:
  /// **'Close app'**
  String get snackbar_restart_button;

  /// No description provided for @snackbar_reset_text.
  ///
  /// In en, this message translates to:
  /// **'Reset settings ?'**
  String get snackbar_reset_text;

  /// No description provided for @snackbar_reset_button.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get snackbar_reset_button;

  /// No description provided for @snackbar_delete_element_text.
  ///
  /// In en, this message translates to:
  /// **'Delete {element} ?'**
  String snackbar_delete_element_text(Object element);

  /// No description provided for @snackbar_delete_button.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get snackbar_delete_button;

  /// No description provided for @snackbar_articles_saved.
  ///
  /// In en, this message translates to:
  /// **'This article has been save'**
  String get snackbar_articles_saved;

  /// No description provided for @snackbar_articles_unsaved.
  ///
  /// In en, this message translates to:
  /// **'This article has been unsaved'**
  String get snackbar_articles_unsaved;

  /// No description provided for @snackbar_close_button.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get snackbar_close_button;

  /// No description provided for @snackbar_welcome_back_text.
  ///
  /// In en, this message translates to:
  /// **'Welcome back {user}'**
  String snackbar_welcome_back_text(Object user);

  /// No description provided for @snackbar_welcome_back_button.
  ///
  /// In en, this message translates to:
  /// **'Thank\'s'**
  String get snackbar_welcome_back_button;

  /// No description provided for @home_appbar.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home_appbar;

  /// No description provided for @greeting_morning.
  ///
  /// In en, this message translates to:
  /// **'Good morning {username}'**
  String greeting_morning(Object username);

  /// No description provided for @greeting_afternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon {username}'**
  String greeting_afternoon(Object username);

  /// No description provided for @greeting_evening.
  ///
  /// In en, this message translates to:
  /// **'Good evening {username}'**
  String greeting_evening(Object username);

  /// No description provided for @home_pick_up.
  ///
  /// In en, this message translates to:
  /// **'Pick up where you left off'**
  String get home_pick_up;

  /// No description provided for @home_discover.
  ///
  /// In en, this message translates to:
  /// **'Discover minddy'**
  String get home_discover;

  /// No description provided for @home_articles_card_open_hint.
  ///
  /// In en, this message translates to:
  /// **'Open this article'**
  String get home_articles_card_open_hint;

  /// No description provided for @submenu_new_project_title.
  ///
  /// In en, this message translates to:
  /// **'New project'**
  String get submenu_new_project_title;

  /// No description provided for @submenu_new_project_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Project\'s name'**
  String get submenu_new_project_subtitle;

  /// No description provided for @submenu_new_project_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter the project\'s name...'**
  String get submenu_new_project_hint;

  /// No description provided for @submenu_new_project_button.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get submenu_new_project_button;

  /// No description provided for @submenu_new_project_errorMessage.
  ///
  /// In en, this message translates to:
  /// **'Please, provide a project name'**
  String get submenu_new_project_errorMessage;

  /// No description provided for @submenu_artilces_image_description_title.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get submenu_artilces_image_description_title;

  /// No description provided for @submenu_artilces_image_description_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Image description'**
  String get submenu_artilces_image_description_subtitle;

  /// No description provided for @submenu_artilces_image_description_hint.
  ///
  /// In en, this message translates to:
  /// **'Write the image description...'**
  String get submenu_artilces_image_description_hint;

  /// No description provided for @submenu_artilces_image_description_button.
  ///
  /// In en, this message translates to:
  /// **'Validate'**
  String get submenu_artilces_image_description_button;

  /// No description provided for @submenu_welcome_password_mnemonic_sentence_title.
  ///
  /// In en, this message translates to:
  /// **'Password hint'**
  String get submenu_welcome_password_mnemonic_sentence_title;

  /// No description provided for @submenu_welcome_password_mnemonic_sentence_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Add a password hint'**
  String get submenu_welcome_password_mnemonic_sentence_subtitle;

  /// No description provided for @submenu_welcome_password_mnemonic_sentence_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password hint'**
  String get submenu_welcome_password_mnemonic_sentence_hint;

  /// No description provided for @submenu_welcome_password_mnemonic_sentence_instructs.
  ///
  /// In en, this message translates to:
  /// **'This feature assists you in recalling your password if you forget it. It is not recommended to enter your password directly; please provide a hint instead.'**
  String get submenu_welcome_password_mnemonic_sentence_instructs;

  /// No description provided for @submenu_unlock_subtitle_text.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get submenu_unlock_subtitle_text;

  /// No description provided for @submenu_unlock_show_mnemonic.
  ///
  /// In en, this message translates to:
  /// **'Show the password hint'**
  String get submenu_unlock_show_mnemonic;

  /// No description provided for @submenu_unlock_hide_mnemonic.
  ///
  /// In en, this message translates to:
  /// **'Hide the password hint'**
  String get submenu_unlock_hide_mnemonic;

  /// No description provided for @submenu_unlock_error_message_incorrect_password.
  ///
  /// In en, this message translates to:
  /// **'Incorect password'**
  String get submenu_unlock_error_message_incorrect_password;

  /// No description provided for @submenu_unlock_error_message_please_enter_password.
  ///
  /// In en, this message translates to:
  /// **'Please, enter your password'**
  String get submenu_unlock_error_message_please_enter_password;

  /// No description provided for @submenu_unlock_error_message_error_login.
  ///
  /// In en, this message translates to:
  /// **'Unable to verify password.'**
  String get submenu_unlock_error_message_error_login;

  /// No description provided for @submenu_unlock_content_title.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get submenu_unlock_content_title;

  /// No description provided for @custom_date_picker_start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get custom_date_picker_start;

  /// No description provided for @custom_date_picker_end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get custom_date_picker_end;

  /// No description provided for @custom_date_picker_invalid_date.
  ///
  /// In en, this message translates to:
  /// **'Invalid date'**
  String get custom_date_picker_invalid_date;

  /// No description provided for @custom_date_picker_select_single_date_title.
  ///
  /// In en, this message translates to:
  /// **'Select a date'**
  String get custom_date_picker_select_single_date_title;

  /// No description provided for @custom_date_picker_select_multiples_date_title.
  ///
  /// In en, this message translates to:
  /// **'Select dates'**
  String get custom_date_picker_select_multiples_date_title;

  /// No description provided for @custom_date_picker_include_hour.
  ///
  /// In en, this message translates to:
  /// **'Include hour'**
  String get custom_date_picker_include_hour;

  /// No description provided for @project_card_open_settings.
  ///
  /// In en, this message translates to:
  /// **'Modify'**
  String get project_card_open_settings;

  /// No description provided for @project_card_duplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get project_card_duplicate;

  /// No description provided for @project_card_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get project_card_delete;

  /// No description provided for @tool_pomodoro_work_duration.
  ///
  /// In en, this message translates to:
  /// **'Work session duration'**
  String get tool_pomodoro_work_duration;

  /// No description provided for @tool_pomodoro_work_session.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get tool_pomodoro_work_session;

  /// No description provided for @tool_pomodoro_break_duration.
  ///
  /// In en, this message translates to:
  /// **'Break session duration'**
  String get tool_pomodoro_break_duration;

  /// No description provided for @tool_pomodoro_break_session.
  ///
  /// In en, this message translates to:
  /// **'Break'**
  String get tool_pomodoro_break_session;

  /// No description provided for @tool_pomodoro_break_snackbar.
  ///
  /// In en, this message translates to:
  /// **'{duration, plural, =0 {Pomodoro - It\'s time for a break} one {Pomodoro - It\'s time for a break for {duration} minute} other {Pomodoro - It\'s time for a break for {duration} minutes}}'**
  String tool_pomodoro_break_snackbar(num duration);

  /// No description provided for @tool_pomodoro_work_snackbar.
  ///
  /// In en, this message translates to:
  /// **'{duration, plural, =0 {Pomodoro - It\'s time to get back to work} one {Pomodoro - It\'s time to get back to work for {duration} minute} other {Pomodoro - It\'s time to get back to work for {duration} minutes}}'**
  String tool_pomodoro_work_snackbar(num duration);

  /// No description provided for @tool_pomodoro_end_session.
  ///
  /// In en, this message translates to:
  /// **'Pomodoro session is over, you worked {duration, plural, one {1 minute} other {{duration} minutes}}. Time to take a rest !'**
  String tool_pomodoro_end_session(num duration);

  /// No description provided for @tool_pomodoro_repetition_count.
  ///
  /// In en, this message translates to:
  /// **'Repetition count'**
  String get tool_pomodoro_repetition_count;

  /// No description provided for @tool_pomodoro_focus_timer.
  ///
  /// In en, this message translates to:
  /// **'Focus timer'**
  String get tool_pomodoro_focus_timer;

  /// No description provided for @tool_pomodoro_start_button.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get tool_pomodoro_start_button;

  /// No description provided for @tool_pomodoro_stop_button.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get tool_pomodoro_stop_button;

  /// No description provided for @projects_next_page_shortcut_tooltip_mac.
  ///
  /// In en, this message translates to:
  /// **'Next page (⌘ + ⭢)'**
  String get projects_next_page_shortcut_tooltip_mac;

  /// No description provided for @projects_previous_page_shortcut_tooltip_mac.
  ///
  /// In en, this message translates to:
  /// **'Previous page (⌘ + ⭠)'**
  String get projects_previous_page_shortcut_tooltip_mac;

  /// No description provided for @projects_next_page_shortcut_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Next page (ctrl + ⭢)'**
  String get projects_next_page_shortcut_tooltip;

  /// No description provided for @projects_previous_page_shortcut_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Previous page (ctrl + ⭠)'**
  String get projects_previous_page_shortcut_tooltip;

  /// No description provided for @projects_add_module_tooltip.
  ///
  /// In en, this message translates to:
  /// **'New module'**
  String get projects_add_module_tooltip;

  /// No description provided for @projects_save_project_button_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get projects_save_project_button_tooltip;

  /// No description provided for @projects_module_help_text.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get projects_module_help_text;

  /// No description provided for @projects_module_tasks_title.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get projects_module_tasks_title;

  /// No description provided for @projects_module_tasks_completed.
  ///
  /// In en, this message translates to:
  /// **'{totalTasksCount, plural, =0 {No tasks} one {{checkedTasks}/{totalTasksCount} task completed} other {{checkedTasks}/{totalTasksCount} tasks completed}}'**
  String projects_module_tasks_completed(Object checkedTasks, num totalTasksCount);

  /// No description provided for @projects_module_tasks_task_title_hint.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get projects_module_tasks_task_title_hint;

  /// No description provided for @projects_module_tasks_task_add_subtask_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Add a subtask'**
  String get projects_module_tasks_task_add_subtask_tooltip;

  /// No description provided for @projects_module_tasks_add_task_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Add a new task'**
  String get projects_module_tasks_add_task_tooltip;

  /// No description provided for @projects_module_notes_new_category_tooltip.
  ///
  /// In en, this message translates to:
  /// **'New category'**
  String get projects_module_notes_new_category_tooltip;

  /// No description provided for @projects_module_notes_new_note_tooltip.
  ///
  /// In en, this message translates to:
  /// **'New note'**
  String get projects_module_notes_new_note_tooltip;

  /// No description provided for @projects_module_notes_modify_category.
  ///
  /// In en, this message translates to:
  /// **'Modify'**
  String get projects_module_notes_modify_category;

  /// No description provided for @projects_module_notes_modify_note_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Modify this note'**
  String get projects_module_notes_modify_note_tooltip;

  /// No description provided for @projects_module_notes_new_category_sub_menu_title.
  ///
  /// In en, this message translates to:
  /// **'New category'**
  String get projects_module_notes_new_category_sub_menu_title;

  /// No description provided for @projects_module_notes_new_category_sub_menu_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Category name'**
  String get projects_module_notes_new_category_sub_menu_subtitle;

  /// No description provided for @projects_module_notes_new_category_sub_menu_name_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter the category name'**
  String get projects_module_notes_new_category_sub_menu_name_hint;

  /// No description provided for @projects_module_notes_new_category_sub_menu_is_private.
  ///
  /// In en, this message translates to:
  /// **'Private category'**
  String get projects_module_notes_new_category_sub_menu_is_private;

  /// No description provided for @projects_module_notes_new_category_sub_menu_error_message.
  ///
  /// In en, this message translates to:
  /// **'Please, name the category'**
  String get projects_module_notes_new_category_sub_menu_error_message;

  /// No description provided for @projects_module_notes_new_category_sub_menu_is_private_tooltip.
  ///
  /// In en, this message translates to:
  /// **'By enabling this option, your password will be required to open this category.'**
  String get projects_module_notes_new_category_sub_menu_is_private_tooltip;

  /// No description provided for @projects_module_notes_modify_category_sub_menu_title.
  ///
  /// In en, this message translates to:
  /// **'Modify category'**
  String get projects_module_notes_modify_category_sub_menu_title;

  /// No description provided for @projects_module_notes_editing_note_sub_menu_save_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Save note'**
  String get projects_module_notes_editing_note_sub_menu_save_tooltip;

  /// No description provided for @projects_module_notes_editing_note_sub_menu_move_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Move'**
  String get projects_module_notes_editing_note_sub_menu_move_tooltip;

  /// No description provided for @projects_module_notes_for_later_title.
  ///
  /// In en, this message translates to:
  /// **'Notes for later'**
  String get projects_module_notes_for_later_title;

  /// No description provided for @projects_module_notes_important_notes_title.
  ///
  /// In en, this message translates to:
  /// **'Important notes'**
  String get projects_module_notes_important_notes_title;

  /// No description provided for @projects_module_notes_private_notes_title.
  ///
  /// In en, this message translates to:
  /// **'Privates notes'**
  String get projects_module_notes_private_notes_title;

  /// No description provided for @projects_module_notes_project_notes_title.
  ///
  /// In en, this message translates to:
  /// **'Project notes'**
  String get projects_module_notes_project_notes_title;

  /// No description provided for @projects_module_notes_category_note_count.
  ///
  /// In en, this message translates to:
  /// **'{totalNotesCount, plural, =0 {No note} one {1 note} other {{totalNotesCount} notes}}'**
  String projects_module_notes_category_note_count(num totalNotesCount);

  /// No description provided for @projects_module_notes_title.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get projects_module_notes_title;

  /// No description provided for @projects_module_spreadsheet_title.
  ///
  /// In en, this message translates to:
  /// **'Spreadsheet'**
  String get projects_module_spreadsheet_title;

  /// No description provided for @projects_module_spreadsheet_value_unnamed.
  ///
  /// In en, this message translates to:
  /// **'Unnamed'**
  String get projects_module_spreadsheet_value_unnamed;

  /// No description provided for @projects_module_spreadsheet_new_row.
  ///
  /// In en, this message translates to:
  /// **'New row'**
  String get projects_module_spreadsheet_new_row;

  /// No description provided for @projects_module_spreadsheet_new_column.
  ///
  /// In en, this message translates to:
  /// **'New column'**
  String get projects_module_spreadsheet_new_column;

  /// No description provided for @projects_module_spreadsheet_delete_row.
  ///
  /// In en, this message translates to:
  /// **'Delete this row'**
  String get projects_module_spreadsheet_delete_row;

  /// No description provided for @projects_module_spreadsheet_delete_column.
  ///
  /// In en, this message translates to:
  /// **'Delete this column'**
  String get projects_module_spreadsheet_delete_column;

  /// No description provided for @projects_module_spreadsheet_data_column_type.
  ///
  /// In en, this message translates to:
  /// **'Column type'**
  String get projects_module_spreadsheet_data_column_type;

  /// No description provided for @projects_module_spreadsheet_data_choose_column_type_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Choose a column type'**
  String get projects_module_spreadsheet_data_choose_column_type_tooltip;

  /// No description provided for @projects_module_spreadsheet_data_type_text.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get projects_module_spreadsheet_data_type_text;

  /// No description provided for @projects_module_spreadsheet_data_type_number.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get projects_module_spreadsheet_data_type_number;

  /// No description provided for @projects_module_spreadsheet_data_type_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get projects_module_spreadsheet_data_type_phone_number;

  /// No description provided for @projects_module_spreadsheet_data_type_email.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get projects_module_spreadsheet_data_type_email;

  /// No description provided for @projects_module_spreadsheet_data_type_url.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get projects_module_spreadsheet_data_type_url;

  /// No description provided for @projects_module_spreadsheet_data_type_date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get projects_module_spreadsheet_data_type_date;

  /// No description provided for @projects_module_spreadsheet_date_from_text.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get projects_module_spreadsheet_date_from_text;

  /// No description provided for @projects_module_spreadsheet_date_to_text.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get projects_module_spreadsheet_date_to_text;

  /// No description provided for @projects_module_spreadsheet_date_single_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Single date'**
  String get projects_module_spreadsheet_date_single_tooltip;

  /// No description provided for @projects_module_spreadsheet_date_start_end_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Add an end date'**
  String get projects_module_spreadsheet_date_start_end_tooltip;

  /// No description provided for @projects_module_spreadsheet_data_type_selection.
  ///
  /// In en, this message translates to:
  /// **'Selection'**
  String get projects_module_spreadsheet_data_type_selection;

  /// No description provided for @projetcs_module_spreadsheet_open_website.
  ///
  /// In en, this message translates to:
  /// **'Open {websiteName}'**
  String projetcs_module_spreadsheet_open_website(Object websiteName);

  /// No description provided for @projects_module_spreadsheet_number_operation_none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get projects_module_spreadsheet_number_operation_none;

  /// No description provided for @projects_module_spreadsheet_number_operation_sum.
  ///
  /// In en, this message translates to:
  /// **'Sum'**
  String get projects_module_spreadsheet_number_operation_sum;

  /// No description provided for @projects_module_spreadsheet_number_operation_average.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get projects_module_spreadsheet_number_operation_average;

  /// No description provided for @projects_module_spreadsheet_number_operation_maximum.
  ///
  /// In en, this message translates to:
  /// **'Maximum'**
  String get projects_module_spreadsheet_number_operation_maximum;

  /// No description provided for @projects_module_spreadsheet_number_operation_minimum.
  ///
  /// In en, this message translates to:
  /// **'Minimum'**
  String get projects_module_spreadsheet_number_operation_minimum;

  /// No description provided for @projects_module_spreadsheet_number_operation_interval.
  ///
  /// In en, this message translates to:
  /// **'Interval'**
  String get projects_module_spreadsheet_number_operation_interval;

  /// No description provided for @projects_module_spreadsheet_number_operation_median.
  ///
  /// In en, this message translates to:
  /// **'Median'**
  String get projects_module_spreadsheet_number_operation_median;

  /// No description provided for @projects_module_spreadsheet_number_operation_standard_deviation.
  ///
  /// In en, this message translates to:
  /// **'Standard deviation'**
  String get projects_module_spreadsheet_number_operation_standard_deviation;

  /// No description provided for @projects_module_spreadsheet_number_operation_calculate.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get projects_module_spreadsheet_number_operation_calculate;

  /// No description provided for @projects_module_spreadsheet_number_operation_sum_example.
  ///
  /// In en, this message translates to:
  /// **'10 + 50 + 100'**
  String get projects_module_spreadsheet_number_operation_sum_example;

  /// No description provided for @projects_module_spreadsheet_number_operation_sum_message.
  ///
  /// In en, this message translates to:
  /// **'Adds up all the values in the column to get the total. Useful for summing up data.'**
  String get projects_module_spreadsheet_number_operation_sum_message;

  /// No description provided for @projects_module_spreadsheet_number_operation_average_example.
  ///
  /// In en, this message translates to:
  /// **'(10 + 50 + 100) / 3'**
  String get projects_module_spreadsheet_number_operation_average_example;

  /// No description provided for @projects_module_spreadsheet_number_operation_average_message.
  ///
  /// In en, this message translates to:
  /// **'Calculates the average by dividing the sum of all values by the number of values. This helps in finding the central value of the data.'**
  String get projects_module_spreadsheet_number_operation_average_message;

  /// No description provided for @projects_module_spreadsheet_number_operation_maximum_example.
  ///
  /// In en, this message translates to:
  /// **'(10, 50, 100) = 100'**
  String get projects_module_spreadsheet_number_operation_maximum_example;

  /// No description provided for @projects_module_spreadsheet_number_operation_maximum_message.
  ///
  /// In en, this message translates to:
  /// **'Finds the highest value in the column. Useful for identifying the largest number.'**
  String get projects_module_spreadsheet_number_operation_maximum_message;

  /// No description provided for @projects_module_spreadsheet_number_operation_minimum_example.
  ///
  /// In en, this message translates to:
  /// **'(10, 50, 100) = 10'**
  String get projects_module_spreadsheet_number_operation_minimum_example;

  /// No description provided for @projects_module_spreadsheet_number_operation_minimum_message.
  ///
  /// In en, this message translates to:
  /// **'Finds the lowest value in the column. This helps in identifying the smallest number.'**
  String get projects_module_spreadsheet_number_operation_minimum_message;

  /// No description provided for @projects_module_spreadsheet_number_operation_interval_example.
  ///
  /// In en, this message translates to:
  /// **'(10, 50, 100) = 90'**
  String get projects_module_spreadsheet_number_operation_interval_example;

  /// No description provided for @projects_module_spreadsheet_number_operation_interval_message.
  ///
  /// In en, this message translates to:
  /// **'Calculates the range by subtracting the smallest value from the largest value in the column. It shows the spread of the values.'**
  String get projects_module_spreadsheet_number_operation_interval_message;

  /// No description provided for @projects_module_spreadsheet_number_operation_median_example.
  ///
  /// In en, this message translates to:
  /// **'(10, 50, 100) = 50'**
  String get projects_module_spreadsheet_number_operation_median_example;

  /// No description provided for @projects_module_spreadsheet_number_operation_median_message.
  ///
  /// In en, this message translates to:
  /// **'Finds the middle value when the column values are sorted. Useful for identifying the central value.'**
  String get projects_module_spreadsheet_number_operation_median_message;

  /// No description provided for @projects_module_spreadsheet_number_operation_standardDeviation_example.
  ///
  /// In en, this message translates to:
  /// **'√[((10-53.33)² + (50-53.33)² + (100-53.33)²) / 3]'**
  String get projects_module_spreadsheet_number_operation_standardDeviation_example;

  /// No description provided for @projects_module_spreadsheet_number_operation_standardDeviation_message.
  ///
  /// In en, this message translates to:
  /// **'Calculates the standard deviation to measure how much the values vary from the average. Here, 53.33 is the mean of the values 10, 50, and 100.'**
  String get projects_module_spreadsheet_number_operation_standardDeviation_message;

  /// No description provided for @projects_module_spreadsheet_extend_cell_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Extend this cell'**
  String get projects_module_spreadsheet_extend_cell_tooltip;

  /// No description provided for @projects_module_spreadsheet_selection_cell_not_started.
  ///
  /// In en, this message translates to:
  /// **'Not started'**
  String get projects_module_spreadsheet_selection_cell_not_started;

  /// No description provided for @projects_module_spreadsheet_selection_cell_started.
  ///
  /// In en, this message translates to:
  /// **'Started'**
  String get projects_module_spreadsheet_selection_cell_started;

  /// No description provided for @projects_module_spreadsheet_selection_cell_finished.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get projects_module_spreadsheet_selection_cell_finished;

  /// No description provided for @projects_module_spreadsheet_selection_cell_modify_options.
  ///
  /// In en, this message translates to:
  /// **'Modify options'**
  String get projects_module_spreadsheet_selection_cell_modify_options;

  /// No description provided for @projects_module_spreadsheet_selection_cell_add_options.
  ///
  /// In en, this message translates to:
  /// **'Add options'**
  String get projects_module_spreadsheet_selection_cell_add_options;

  /// No description provided for @projects_module_spreadsheet_selection_cell_add_an_option.
  ///
  /// In en, this message translates to:
  /// **'Add an option'**
  String get projects_module_spreadsheet_selection_cell_add_an_option;

  /// No description provided for @projects_module_spreadsheet_selection_cell_all_options.
  ///
  /// In en, this message translates to:
  /// **'All options'**
  String get projects_module_spreadsheet_selection_cell_all_options;

  /// No description provided for @projects_module_spreadsheet_selection_cell_name_option_hint.
  ///
  /// In en, this message translates to:
  /// **'Name this option...'**
  String get projects_module_spreadsheet_selection_cell_name_option_hint;

  /// No description provided for @projects_module_spreadsheet_manage_columns_sub_menu_title.
  ///
  /// In en, this message translates to:
  /// **'Organize columns'**
  String get projects_module_spreadsheet_manage_columns_sub_menu_title;

  /// No description provided for @projects_module_spreadsheet_manage_columns_sub_menu_subtitle.
  ///
  /// In en, this message translates to:
  /// **'All columns'**
  String get projects_module_spreadsheet_manage_columns_sub_menu_subtitle;

  /// No description provided for @projects_module_spreadsheet_manage_rows_sub_menu_title.
  ///
  /// In en, this message translates to:
  /// **'Organize rows'**
  String get projects_module_spreadsheet_manage_rows_sub_menu_title;

  /// No description provided for @projects_module_spreadsheet_manage_rows_sub_menu_subtitle.
  ///
  /// In en, this message translates to:
  /// **'All rows'**
  String get projects_module_spreadsheet_manage_rows_sub_menu_subtitle;

  /// No description provided for @projects_module_spreadsheet_selection_sub_menu_error_message_no_options.
  ///
  /// In en, this message translates to:
  /// **'Please, add options'**
  String get projects_module_spreadsheet_selection_sub_menu_error_message_no_options;

  /// No description provided for @projects_module_spreadsheet_selection_sub_menu_error_message_unnamed_option.
  ///
  /// In en, this message translates to:
  /// **'Please, name all options'**
  String get projects_module_spreadsheet_selection_sub_menu_error_message_unnamed_option;

  /// No description provided for @projects_module_spreadsheet_selection_sub_menu_error_message_redundant_option_name.
  ///
  /// In en, this message translates to:
  /// **'Two options can\'t have the same name ({optionName})'**
  String projects_module_spreadsheet_selection_sub_menu_error_message_redundant_option_name(Object optionName);

  /// No description provided for @projects_module_spreadsheet_selection_sub_menu_error_message_redundant_color.
  ///
  /// In en, this message translates to:
  /// **'Two options can\'t have the same color'**
  String get projects_module_spreadsheet_selection_sub_menu_error_message_redundant_color;

  /// No description provided for @projects_module_spreadsheet_chart_show_table.
  ///
  /// In en, this message translates to:
  /// **'Show the table'**
  String get projects_module_spreadsheet_chart_show_table;

  /// No description provided for @projects_module_spreadsheet_chart_show_chart.
  ///
  /// In en, this message translates to:
  /// **'Show the charts'**
  String get projects_module_spreadsheet_chart_show_chart;

  /// No description provided for @projects_module_spreadsheet_chart_new_tab.
  ///
  /// In en, this message translates to:
  /// **'New tab'**
  String get projects_module_spreadsheet_chart_new_tab;

  /// No description provided for @projects_module_spreadsheet_chart_new_column.
  ///
  /// In en, this message translates to:
  /// **'Add a coulumn'**
  String get projects_module_spreadsheet_chart_new_column;

  /// No description provided for @projects_module_spreadsheet_chart_chart_type_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Chart type'**
  String get projects_module_spreadsheet_chart_chart_type_subtitle;

  /// No description provided for @projects_module_spreadsheet_chart_chart_type_donut.
  ///
  /// In en, this message translates to:
  /// **'Donut'**
  String get projects_module_spreadsheet_chart_chart_type_donut;

  /// No description provided for @projects_module_spreadsheet_chart_chart_type_bar.
  ///
  /// In en, this message translates to:
  /// **'Bar'**
  String get projects_module_spreadsheet_chart_chart_type_bar;

  /// No description provided for @projects_module_spreadsheet_chart_chart_type_bar_simple.
  ///
  /// In en, this message translates to:
  /// **'Simple bars'**
  String get projects_module_spreadsheet_chart_chart_type_bar_simple;

  /// No description provided for @projects_module_spreadsheet_chart_chart_type_bar_grouped.
  ///
  /// In en, this message translates to:
  /// **'Grouped bars'**
  String get projects_module_spreadsheet_chart_chart_type_bar_grouped;

  /// No description provided for @projects_module_spreadsheet_chart_chart_type_bar_stacked.
  ///
  /// In en, this message translates to:
  /// **'Stacked bars'**
  String get projects_module_spreadsheet_chart_chart_type_bar_stacked;

  /// No description provided for @projects_module_spreadsheet_chart_chart_select_column.
  ///
  /// In en, this message translates to:
  /// **'Select a column'**
  String get projects_module_spreadsheet_chart_chart_select_column;

  /// No description provided for @projects_module_spreadsheet_chart_chart_column_single.
  ///
  /// In en, this message translates to:
  /// **'Column'**
  String get projects_module_spreadsheet_chart_chart_column_single;

  /// No description provided for @projects_module_spreadsheet_chart_chart_column_plural.
  ///
  /// In en, this message translates to:
  /// **'Columns'**
  String get projects_module_spreadsheet_chart_chart_column_plural;

  /// No description provided for @custom_chart_empty_content.
  ///
  /// In en, this message translates to:
  /// **'To create a chart, please add data to it'**
  String get custom_chart_empty_content;

  /// No description provided for @custom_chart_donut_total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get custom_chart_donut_total;

  /// No description provided for @custom_chart_donut_share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get custom_chart_donut_share;

  /// No description provided for @custom_chart_grid_extend_chart.
  ///
  /// In en, this message translates to:
  /// **'Enlarge chart'**
  String get custom_chart_grid_extend_chart;

  /// No description provided for @custom_color_picker_opacity_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Opacity'**
  String get custom_color_picker_opacity_tooltip;

  /// No description provided for @node_editor_view_new_node_tooltip.
  ///
  /// In en, this message translates to:
  /// **'New node'**
  String get node_editor_view_new_node_tooltip;

  /// No description provided for @node_editor_view_close_node_panel_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Close node panel'**
  String get node_editor_view_close_node_panel_tooltip;

  /// No description provided for @node_editor_view_open_node_panel_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Open node panel'**
  String get node_editor_view_open_node_panel_tooltip;

  /// No description provided for @node_editor_view_close_side_panel_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Close side panel'**
  String get node_editor_view_close_side_panel_tooltip;

  /// No description provided for @node_editor_view_open_side_panel_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Open side panel'**
  String get node_editor_view_open_side_panel_tooltip;

  /// No description provided for @node_editor_view_side_panel_variables_title.
  ///
  /// In en, this message translates to:
  /// **'Variables'**
  String get node_editor_view_side_panel_variables_title;

  /// No description provided for @node_editor_view_side_panel_variables_add_button_tooltip.
  ///
  /// In en, this message translates to:
  /// **'New variable'**
  String get node_editor_view_side_panel_variables_add_button_tooltip;

  /// No description provided for @node_editor_view_side_panel_variables_variable_type_any.
  ///
  /// In en, this message translates to:
  /// **'Not defined'**
  String get node_editor_view_side_panel_variables_variable_type_any;

  /// No description provided for @node_editor_view_side_panel_variables_variable_type_number.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get node_editor_view_side_panel_variables_variable_type_number;

  /// No description provided for @node_editor_view_side_panel_variables_variable_type_text.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get node_editor_view_side_panel_variables_variable_type_text;

  /// No description provided for @node_editor_view_side_panel_variables_variable_type_boolean.
  ///
  /// In en, this message translates to:
  /// **'Boolean'**
  String get node_editor_view_side_panel_variables_variable_type_boolean;

  /// No description provided for @node_editor_view_side_panel_variables_variable_type_list.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get node_editor_view_side_panel_variables_variable_type_list;

  /// No description provided for @node_editor_view_side_panel_variables_variable_type_color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get node_editor_view_side_panel_variables_variable_type_color;

  /// No description provided for @node_editor_view_side_panel_node_trees_title.
  ///
  /// In en, this message translates to:
  /// **'Node trees'**
  String get node_editor_view_side_panel_node_trees_title;

  /// No description provided for @node_editor_view_side_panel_node_trees_add_button_tooltip.
  ///
  /// In en, this message translates to:
  /// **'New node tree'**
  String get node_editor_view_side_panel_node_trees_add_button_tooltip;

  /// No description provided for @node_editor_view_bottom_toolbar_undo_tooltip_windows.
  ///
  /// In en, this message translates to:
  /// **'Undo (ctrl + z)'**
  String get node_editor_view_bottom_toolbar_undo_tooltip_windows;

  /// No description provided for @node_editor_view_bottom_toolbar_undo_tooltip_mac.
  ///
  /// In en, this message translates to:
  /// **'Undo (⌘ + z)'**
  String get node_editor_view_bottom_toolbar_undo_tooltip_mac;

  /// No description provided for @node_editor_view_bottom_toolbar_redo_tooltip_windows.
  ///
  /// In en, this message translates to:
  /// **'Redo (⇧ + ctrl + z)'**
  String get node_editor_view_bottom_toolbar_redo_tooltip_windows;

  /// No description provided for @node_editor_view_bottom_toolbar_redo_tooltip_mac.
  ///
  /// In en, this message translates to:
  /// **'Redo (⇧ + ⌘ + z)'**
  String get node_editor_view_bottom_toolbar_redo_tooltip_mac;

  /// No description provided for @node_editor_view_bottom_toolbar_copy_tooltip_windows.
  ///
  /// In en, this message translates to:
  /// **'{length, plural, =1{Copy selected node (ctrl + c)} other{Copy selected nodes (ctrl + c)}}'**
  String node_editor_view_bottom_toolbar_copy_tooltip_windows(num length);

  /// No description provided for @node_editor_view_bottom_toolbar_copy_tooltip_mac.
  ///
  /// In en, this message translates to:
  /// **'{length, plural, =1{Copy selected node (⌘ + c)} other{Copy selected nodes (⌘ + c)}}'**
  String node_editor_view_bottom_toolbar_copy_tooltip_mac(num length);

  /// No description provided for @node_editor_view_bottom_toolbar_paste_tooltip_windows.
  ///
  /// In en, this message translates to:
  /// **'{length, plural, =1{Paste copied node (ctrl + v)} other{Paste copied nodes (ctrl + v)}}'**
  String node_editor_view_bottom_toolbar_paste_tooltip_windows(num length);

  /// No description provided for @node_editor_view_bottom_toolbar_paste_tooltip_mac.
  ///
  /// In en, this message translates to:
  /// **'{length, plural, =1{Paste copied node (⌘ + v)} other{Paste copied nodes (⌘ + v)}}'**
  String node_editor_view_bottom_toolbar_paste_tooltip_mac(num length);

  /// No description provided for @node_editor_view_bottom_toolbar_duplicate_tooltip_windows.
  ///
  /// In en, this message translates to:
  /// **'{length, plural, one {Duplicate selected node (ctrl + d)} other {Duplicate selected nodes (ctrl + d)}}'**
  String node_editor_view_bottom_toolbar_duplicate_tooltip_windows(num length);

  /// No description provided for @node_editor_view_bottom_toolbar_duplicate_tooltip_mac.
  ///
  /// In en, this message translates to:
  /// **'{length, plural, one {Duplicate selected node (⌘ + d)} other {Duplicate selected nodes (⌘ + d)}}'**
  String node_editor_view_bottom_toolbar_duplicate_tooltip_mac(num length);

  /// No description provided for @node_editor_view_bottom_toolbar_delete_tooltip_windows.
  ///
  /// In en, this message translates to:
  /// **'{length, plural, one {Delete selected node (ctrl + ⌫)} other {Delete selected nodes (ctrl + ⌫)}}'**
  String node_editor_view_bottom_toolbar_delete_tooltip_windows(num length);

  /// No description provided for @node_editor_view_bottom_toolbar_delete_tooltip_mac.
  ///
  /// In en, this message translates to:
  /// **'{length, plural, one {Delete selected node (⌘ + ⌫)} other {Delete selected nodes (⌘ + ⌫)}}'**
  String node_editor_view_bottom_toolbar_delete_tooltip_mac(num length);

  /// No description provided for @node_editor_add_sub_menu_types.
  ///
  /// In en, this message translates to:
  /// **'Types'**
  String get node_editor_add_sub_menu_types;

  /// No description provided for @node_editor_add_sub_menu_inputs_subtitle.
  ///
  /// In en, this message translates to:
  /// **'{length, plural, one {Input} other {Inputs}}'**
  String node_editor_add_sub_menu_inputs_subtitle(num length);

  /// No description provided for @node_editor_add_sub_menu_outputs_subtitle.
  ///
  /// In en, this message translates to:
  /// **'{length, plural, one {Output} other {Outputs}}'**
  String node_editor_add_sub_menu_outputs_subtitle(num length);

  /// No description provided for @node_editor_add_sub_menu_note.
  ///
  /// In en, this message translates to:
  /// **'Note: Inputs and outputs may vary depending on the options chosen for the node'**
  String get node_editor_add_sub_menu_note;

  /// No description provided for @node_editor_add_sub_menu_no_nodes_found.
  ///
  /// In en, this message translates to:
  /// **'No nodes found.'**
  String get node_editor_add_sub_menu_no_nodes_found;

  /// No description provided for @node_editor_add_sub_menu_add_button.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get node_editor_add_sub_menu_add_button;

  /// No description provided for @node_editor_add_sub_menu_none_input_output.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get node_editor_add_sub_menu_none_input_output;

  /// No description provided for @node_widgets_value_text.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get node_widgets_value_text;

  /// No description provided for @node_widgets_result_text.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get node_widgets_result_text;

  /// No description provided for @node_widgets_text_text.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get node_widgets_text_text;

  /// No description provided for @node_widgets_start_text.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get node_widgets_start_text;

  /// No description provided for @node_widgets_end_text.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get node_widgets_end_text;

  /// No description provided for @node_widgets_length_text.
  ///
  /// In en, this message translates to:
  /// **'Length'**
  String get node_widgets_length_text;

  /// No description provided for @node_widgets_treshold_text.
  ///
  /// In en, this message translates to:
  /// **'Treshold'**
  String get node_widgets_treshold_text;

  /// No description provided for @node_widgets_category_math.
  ///
  /// In en, this message translates to:
  /// **'Math'**
  String get node_widgets_category_math;

  /// No description provided for @node_widgets_category_logic.
  ///
  /// In en, this message translates to:
  /// **'Logic'**
  String get node_widgets_category_logic;

  /// No description provided for @node_widgets_category_variable.
  ///
  /// In en, this message translates to:
  /// **'Variables'**
  String get node_widgets_category_variable;

  /// No description provided for @node_widgets_math_node_title.
  ///
  /// In en, this message translates to:
  /// **'Calculations'**
  String get node_widgets_math_node_title;

  /// No description provided for @node_widgets_math_node_description.
  ///
  /// In en, this message translates to:
  /// **'Performs calculations on numbers.'**
  String get node_widgets_math_node_description;

  /// No description provided for @node_widgets_math_node_options_addition.
  ///
  /// In en, this message translates to:
  /// **'Addition'**
  String get node_widgets_math_node_options_addition;

  /// No description provided for @node_widgets_math_node_options_substraction.
  ///
  /// In en, this message translates to:
  /// **'Substraction'**
  String get node_widgets_math_node_options_substraction;

  /// No description provided for @node_widgets_math_node_options_division.
  ///
  /// In en, this message translates to:
  /// **'Division'**
  String get node_widgets_math_node_options_division;

  /// No description provided for @node_widgets_math_node_options_multiplication.
  ///
  /// In en, this message translates to:
  /// **'Multiplication'**
  String get node_widgets_math_node_options_multiplication;

  /// No description provided for @node_widgets_math_node_options_squareRoot.
  ///
  /// In en, this message translates to:
  /// **'Square Root'**
  String get node_widgets_math_node_options_squareRoot;

  /// No description provided for @node_widgets_math_node_options_power.
  ///
  /// In en, this message translates to:
  /// **'Power'**
  String get node_widgets_math_node_options_power;

  /// No description provided for @node_widgets_math_node_options_min.
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get node_widgets_math_node_options_min;

  /// No description provided for @node_widgets_math_node_options_max.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get node_widgets_math_node_options_max;

  /// No description provided for @node_widgets_math_node_options_sign.
  ///
  /// In en, this message translates to:
  /// **'Sign'**
  String get node_widgets_math_node_options_sign;

  /// No description provided for @node_widgets_math_node_options_round.
  ///
  /// In en, this message translates to:
  /// **'Round'**
  String get node_widgets_math_node_options_round;

  /// No description provided for @node_widgets_math_node_options_floor.
  ///
  /// In en, this message translates to:
  /// **'Floor'**
  String get node_widgets_math_node_options_floor;

  /// No description provided for @node_widgets_math_node_options_ceil.
  ///
  /// In en, this message translates to:
  /// **'Ceil'**
  String get node_widgets_math_node_options_ceil;

  /// No description provided for @node_widgets_math_node_options_truncate.
  ///
  /// In en, this message translates to:
  /// **'Truncate'**
  String get node_widgets_math_node_options_truncate;

  /// No description provided for @node_widgets_math_node_options_sin.
  ///
  /// In en, this message translates to:
  /// **'Sine'**
  String get node_widgets_math_node_options_sin;

  /// No description provided for @node_widgets_math_node_options_cos.
  ///
  /// In en, this message translates to:
  /// **'Cosine'**
  String get node_widgets_math_node_options_cos;

  /// No description provided for @node_widgets_math_node_options_tan.
  ///
  /// In en, this message translates to:
  /// **'Tangent'**
  String get node_widgets_math_node_options_tan;

  /// No description provided for @node_widgets_math_node_options_asin.
  ///
  /// In en, this message translates to:
  /// **'Arcsine'**
  String get node_widgets_math_node_options_asin;

  /// No description provided for @node_widgets_math_node_options_acos.
  ///
  /// In en, this message translates to:
  /// **'Arccosine'**
  String get node_widgets_math_node_options_acos;

  /// No description provided for @node_widgets_math_node_options_atan.
  ///
  /// In en, this message translates to:
  /// **'Arctangent'**
  String get node_widgets_math_node_options_atan;

  /// No description provided for @node_widgets_math_node_options_sinh.
  ///
  /// In en, this message translates to:
  /// **'Hyperbolic Sine'**
  String get node_widgets_math_node_options_sinh;

  /// No description provided for @node_widgets_math_node_options_cosh.
  ///
  /// In en, this message translates to:
  /// **'Hyperbolic Cosine'**
  String get node_widgets_math_node_options_cosh;

  /// No description provided for @node_widgets_math_node_options_tanh.
  ///
  /// In en, this message translates to:
  /// **'Hyperbolic Tangent'**
  String get node_widgets_math_node_options_tanh;

  /// No description provided for @node_widgets_math_node_options_asinh.
  ///
  /// In en, this message translates to:
  /// **'Inverse Hyperbolic Sine'**
  String get node_widgets_math_node_options_asinh;

  /// No description provided for @node_widgets_math_node_options_acosh.
  ///
  /// In en, this message translates to:
  /// **'Inverse Hyperbolic Cosine'**
  String get node_widgets_math_node_options_acosh;

  /// No description provided for @node_widgets_math_node_options_atanh.
  ///
  /// In en, this message translates to:
  /// **'Inverse Hyperbolic Tangent'**
  String get node_widgets_math_node_options_atanh;

  /// No description provided for @node_widgets_math_node_options_ln.
  ///
  /// In en, this message translates to:
  /// **'Natural Logarithm'**
  String get node_widgets_math_node_options_ln;

  /// No description provided for @node_widgets_math_node_options_log10.
  ///
  /// In en, this message translates to:
  /// **'Logarithm Base 10'**
  String get node_widgets_math_node_options_log10;

  /// No description provided for @node_widgets_math_node_options_abs.
  ///
  /// In en, this message translates to:
  /// **'Absolute Value'**
  String get node_widgets_math_node_options_abs;

  /// No description provided for @node_widgets_comparison_node_title.
  ///
  /// In en, this message translates to:
  /// **'Comparison'**
  String get node_widgets_comparison_node_title;

  /// No description provided for @node_widgets_comparison_node_description.
  ///
  /// In en, this message translates to:
  /// **'Performs comparison between numbers.'**
  String get node_widgets_comparison_node_description;

  /// No description provided for @node_widgets_comparison_node_options_lessThan.
  ///
  /// In en, this message translates to:
  /// **'Less than'**
  String get node_widgets_comparison_node_options_lessThan;

  /// No description provided for @node_widgets_comparison_node_options_lessThanOrEqual.
  ///
  /// In en, this message translates to:
  /// **'Less than or equal to'**
  String get node_widgets_comparison_node_options_lessThanOrEqual;

  /// No description provided for @node_widgets_comparison_node_options_greatherThan.
  ///
  /// In en, this message translates to:
  /// **'Greater than'**
  String get node_widgets_comparison_node_options_greatherThan;

  /// No description provided for @node_widgets_comparison_node_options_greatherThanOrEqual.
  ///
  /// In en, this message translates to:
  /// **'Greater than or equal to'**
  String get node_widgets_comparison_node_options_greatherThanOrEqual;

  /// No description provided for @node_widgets_comparison_node_options_equal.
  ///
  /// In en, this message translates to:
  /// **'Equal to'**
  String get node_widgets_comparison_node_options_equal;

  /// No description provided for @node_widgets_boolean_node_title.
  ///
  /// In en, this message translates to:
  /// **'Logic Operations'**
  String get node_widgets_boolean_node_title;

  /// No description provided for @node_widgets_boolean_node_description.
  ///
  /// In en, this message translates to:
  /// **'Performs operations on booleans.'**
  String get node_widgets_boolean_node_description;

  /// No description provided for @node_widgets_boolean_node_options_and.
  ///
  /// In en, this message translates to:
  /// **'And'**
  String get node_widgets_boolean_node_options_and;

  /// No description provided for @node_widgets_boolean_node_options_or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get node_widgets_boolean_node_options_or;

  /// No description provided for @node_widgets_boolean_node_options_not.
  ///
  /// In en, this message translates to:
  /// **'Not'**
  String get node_widgets_boolean_node_options_not;

  /// No description provided for @node_widgets_boolean_node_options_notAnd.
  ///
  /// In en, this message translates to:
  /// **'Not And'**
  String get node_widgets_boolean_node_options_notAnd;

  /// No description provided for @node_widgets_boolean_node_options_notOr.
  ///
  /// In en, this message translates to:
  /// **'Not Or'**
  String get node_widgets_boolean_node_options_notOr;

  /// No description provided for @node_widgets_boolean_node_options_equal.
  ///
  /// In en, this message translates to:
  /// **'Equal'**
  String get node_widgets_boolean_node_options_equal;

  /// No description provided for @node_widgets_boolean_node_options_notEqual.
  ///
  /// In en, this message translates to:
  /// **'Not Equal'**
  String get node_widgets_boolean_node_options_notEqual;

  /// No description provided for @node_widgets_boolean_node_options_imply.
  ///
  /// In en, this message translates to:
  /// **'Imply'**
  String get node_widgets_boolean_node_options_imply;

  /// No description provided for @node_widgets_boolean_node_options_subtract.
  ///
  /// In en, this message translates to:
  /// **'Subtract'**
  String get node_widgets_boolean_node_options_subtract;

  /// No description provided for @node_widgets_conversion_node_title.
  ///
  /// In en, this message translates to:
  /// **'Conversion'**
  String get node_widgets_conversion_node_title;

  /// No description provided for @node_widgets_conversion_node_decsription.
  ///
  /// In en, this message translates to:
  /// **'Converts a value to another type'**
  String get node_widgets_conversion_node_decsription;

  /// No description provided for @node_widgets_text_operation_node_title.
  ///
  /// In en, this message translates to:
  /// **'Text operation'**
  String get node_widgets_text_operation_node_title;

  /// No description provided for @node_widgets_text_operation_node_decsription.
  ///
  /// In en, this message translates to:
  /// **'Performs operations on a text'**
  String get node_widgets_text_operation_node_decsription;

  /// No description provided for @node_widgets_text_operation_node_options_join.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get node_widgets_text_operation_node_options_join;

  /// No description provided for @node_widgets_text_operation_node_options_cut.
  ///
  /// In en, this message translates to:
  /// **'Cut'**
  String get node_widgets_text_operation_node_options_cut;

  /// No description provided for @node_widgets_text_operation_node_options_trim.
  ///
  /// In en, this message translates to:
  /// **'Trim'**
  String get node_widgets_text_operation_node_options_trim;

  /// No description provided for @node_widgets_text_operation_node_options_trim_left.
  ///
  /// In en, this message translates to:
  /// **'Trim left'**
  String get node_widgets_text_operation_node_options_trim_left;

  /// No description provided for @node_widgets_text_operation_node_options_trim_right.
  ///
  /// In en, this message translates to:
  /// **'Trim right'**
  String get node_widgets_text_operation_node_options_trim_right;

  /// No description provided for @node_widgets_text_operation_node_options_pad_left.
  ///
  /// In en, this message translates to:
  /// **'Pad left'**
  String get node_widgets_text_operation_node_options_pad_left;

  /// No description provided for @node_widgets_text_operation_node_options_pad_right.
  ///
  /// In en, this message translates to:
  /// **'Pad right'**
  String get node_widgets_text_operation_node_options_pad_right;

  /// No description provided for @node_widgets_text_operation_node_options_contains.
  ///
  /// In en, this message translates to:
  /// **'Contains'**
  String get node_widgets_text_operation_node_options_contains;

  /// No description provided for @node_widgets_set_variable_node_title.
  ///
  /// In en, this message translates to:
  /// **'Set variable'**
  String get node_widgets_set_variable_node_title;

  /// No description provided for @node_widgets_set_variable_node_description.
  ///
  /// In en, this message translates to:
  /// **'Sets a variable\'s value.'**
  String get node_widgets_set_variable_node_description;

  /// No description provided for @node_widgets_get_variable_node_title.
  ///
  /// In en, this message translates to:
  /// **'Get variable'**
  String get node_widgets_get_variable_node_title;

  /// No description provided for @node_widgets_get_variable_node_description.
  ///
  /// In en, this message translates to:
  /// **'Gets the value of a variable.'**
  String get node_widgets_get_variable_node_description;

  /// No description provided for @node_widgets_select_variable_node_text.
  ///
  /// In en, this message translates to:
  /// **'Select a variable'**
  String get node_widgets_select_variable_node_text;

  /// No description provided for @node_widgets_random_number_node_title.
  ///
  /// In en, this message translates to:
  /// **'Random number'**
  String get node_widgets_random_number_node_title;

  /// No description provided for @node_widgets_random_number_node_description.
  ///
  /// In en, this message translates to:
  /// **'Generates a random number between a minimum and maximum (0 and 1 by default).'**
  String get node_widgets_random_number_node_description;

  /// No description provided for @plugin_editor_ui_side_panel_layers_title.
  ///
  /// In en, this message translates to:
  /// **'Components'**
  String get plugin_editor_ui_side_panel_layers_title;

  /// No description provided for @plugin_editor_ui_side_panel_layers_add_button.
  ///
  /// In en, this message translates to:
  /// **'New component'**
  String get plugin_editor_ui_side_panel_layers_add_button;

  /// No description provided for @plugin_editor_ui_side_panel_layers_add_child.
  ///
  /// In en, this message translates to:
  /// **'Add child'**
  String get plugin_editor_ui_side_panel_layers_add_child;

  /// No description provided for @plugin_editor_ui_side_panel_layers_more_options.
  ///
  /// In en, this message translates to:
  /// **'More options'**
  String get plugin_editor_ui_side_panel_layers_more_options;

  /// No description provided for @plugin_editor_ui_side_panel_layers_hide_child.
  ///
  /// In en, this message translates to:
  /// **'{length, plural, one {Hide child} other {Hide children}}'**
  String plugin_editor_ui_side_panel_layers_hide_child(num length);

  /// No description provided for @plugin_editor_ui_side_panel_layers_show_child.
  ///
  /// In en, this message translates to:
  /// **'{length, plural, one {Show child} other {Show children}}'**
  String plugin_editor_ui_side_panel_layers_show_child(num length);

  /// No description provided for @plugin_editor_ui_side_panel_properties_size_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get plugin_editor_ui_side_panel_properties_size_subtitle;

  /// No description provided for @plugin_editor_ui_side_panel_properties_size_width.
  ///
  /// In en, this message translates to:
  /// **'Width'**
  String get plugin_editor_ui_side_panel_properties_size_width;

  /// No description provided for @plugin_editor_ui_side_panel_properties_size_height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get plugin_editor_ui_side_panel_properties_size_height;

  /// No description provided for @plugin_editor_ui_side_panel_properties_style_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Style'**
  String get plugin_editor_ui_side_panel_properties_style_subtitle;

  /// No description provided for @plugin_editor_ui_side_panel_properties_style_border_radius.
  ///
  /// In en, this message translates to:
  /// **'Border radius'**
  String get plugin_editor_ui_side_panel_properties_style_border_radius;

  /// No description provided for @plugin_editor_ui_side_panel_properties_style_alignment.
  ///
  /// In en, this message translates to:
  /// **'Alignment'**
  String get plugin_editor_ui_side_panel_properties_style_alignment;

  /// No description provided for @plugin_editor_ui_side_panel_properties_style_alignment_top_left.
  ///
  /// In en, this message translates to:
  /// **'Top left'**
  String get plugin_editor_ui_side_panel_properties_style_alignment_top_left;

  /// No description provided for @plugin_editor_ui_side_panel_properties_style_alignment_top_right.
  ///
  /// In en, this message translates to:
  /// **'Top right'**
  String get plugin_editor_ui_side_panel_properties_style_alignment_top_right;

  /// No description provided for @plugin_editor_ui_side_panel_properties_style_alignment_bottom_left.
  ///
  /// In en, this message translates to:
  /// **'Bottom left'**
  String get plugin_editor_ui_side_panel_properties_style_alignment_bottom_left;

  /// No description provided for @plugin_editor_ui_side_panel_properties_style_alignment_bottom_right.
  ///
  /// In en, this message translates to:
  /// **'Bottom right'**
  String get plugin_editor_ui_side_panel_properties_style_alignment_bottom_right;

  /// No description provided for @plugin_editor_ui_side_panel_properties_border_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Border'**
  String get plugin_editor_ui_side_panel_properties_border_subtitle;

  /// No description provided for @plugin_editor_ui_side_panel_properties_style_alignment_top.
  ///
  /// In en, this message translates to:
  /// **'Top'**
  String get plugin_editor_ui_side_panel_properties_style_alignment_top;

  /// No description provided for @plugin_editor_ui_side_panel_properties_style_alignment_bottom.
  ///
  /// In en, this message translates to:
  /// **'Bottom'**
  String get plugin_editor_ui_side_panel_properties_style_alignment_bottom;

  /// No description provided for @plugin_editor_ui_side_panel_properties_style_alignment_left.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get plugin_editor_ui_side_panel_properties_style_alignment_left;

  /// No description provided for @plugin_editor_ui_side_panel_properties_style_alignment_right.
  ///
  /// In en, this message translates to:
  /// **'Right'**
  String get plugin_editor_ui_side_panel_properties_style_alignment_right;

  /// No description provided for @plugin_editor_ui_side_panel_properties_style_border_thickness.
  ///
  /// In en, this message translates to:
  /// **'Thickness'**
  String get plugin_editor_ui_side_panel_properties_style_border_thickness;

  /// No description provided for @plugin_editor_ui_side_panel_properties_theme_colors_primary.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get plugin_editor_ui_side_panel_properties_theme_colors_primary;

  /// No description provided for @plugin_editor_ui_side_panel_properties_theme_colors_primary_transparent.
  ///
  /// In en, this message translates to:
  /// **'Primary transparent'**
  String get plugin_editor_ui_side_panel_properties_theme_colors_primary_transparent;

  /// No description provided for @plugin_editor_ui_side_panel_properties_theme_colors_accent.
  ///
  /// In en, this message translates to:
  /// **'Accent'**
  String get plugin_editor_ui_side_panel_properties_theme_colors_accent;

  /// No description provided for @plugin_editor_ui_side_panel_properties_theme_colors_surface.
  ///
  /// In en, this message translates to:
  /// **'Surface'**
  String get plugin_editor_ui_side_panel_properties_theme_colors_surface;

  /// No description provided for @default_app_colors_change_color.
  ///
  /// In en, this message translates to:
  /// **'Change color'**
  String get default_app_colors_change_color;

  /// No description provided for @default_app_colors_grey.
  ///
  /// In en, this message translates to:
  /// **'Grey'**
  String get default_app_colors_grey;

  /// No description provided for @default_app_colors_mint_green.
  ///
  /// In en, this message translates to:
  /// **'Mint Green'**
  String get default_app_colors_mint_green;

  /// No description provided for @default_app_colors_light_pink.
  ///
  /// In en, this message translates to:
  /// **'Light Pink'**
  String get default_app_colors_light_pink;

  /// No description provided for @default_app_colors_light_yellow.
  ///
  /// In en, this message translates to:
  /// **'Light Yellow'**
  String get default_app_colors_light_yellow;

  /// No description provided for @default_app_colors_peach.
  ///
  /// In en, this message translates to:
  /// **'Peach'**
  String get default_app_colors_peach;

  /// No description provided for @default_app_colors_soft_red.
  ///
  /// In en, this message translates to:
  /// **'Soft Red'**
  String get default_app_colors_soft_red;

  /// No description provided for @default_app_colors_lavender.
  ///
  /// In en, this message translates to:
  /// **'Lavender'**
  String get default_app_colors_lavender;

  /// No description provided for @default_app_colors_light_blue.
  ///
  /// In en, this message translates to:
  /// **'Light Blue'**
  String get default_app_colors_light_blue;

  /// No description provided for @default_app_colors_light_green.
  ///
  /// In en, this message translates to:
  /// **'Light Green'**
  String get default_app_colors_light_green;

  /// No description provided for @default_app_colors_light_purple.
  ///
  /// In en, this message translates to:
  /// **'Light Purple'**
  String get default_app_colors_light_purple;

  /// No description provided for @default_articles_articles_title.
  ///
  /// In en, this message translates to:
  /// **'Articles'**
  String get default_articles_articles_title;

  /// No description provided for @default_articles_articles_description.
  ///
  /// In en, this message translates to:
  /// **'Discover articles in minddy'**
  String get default_articles_articles_description;

  /// No description provided for @default_articles_articles_first_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Key Feature'**
  String get default_articles_articles_first_subtitle;

  /// No description provided for @default_articles_articles_first_paragraph.
  ///
  /// In en, this message translates to:
  /// **'Articles are a key feature of Minddy. They offer an elegant and intuitive interface for writing and sharing your knowledge. With this feature, you can easily disseminate your insights and benefit the entire community.'**
  String get default_articles_articles_first_paragraph;

  /// No description provided for @default_articles_articles_second_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Note Taking'**
  String get default_articles_articles_second_subtitle;

  /// No description provided for @default_articles_articles_second_paragraph.
  ///
  /// In en, this message translates to:
  /// **'You can also take notes, which is ideal for saving texts or any other content you want to keep for later. This feature is perfect for capturing ideas or important information to revisit later.'**
  String get default_articles_articles_second_paragraph;

  /// No description provided for @default_articles_articles_third_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Source Management'**
  String get default_articles_articles_third_subtitle;

  /// No description provided for @default_articles_articles_third_paragraph.
  ///
  /// In en, this message translates to:
  /// **'All your sources are accessible via a menu located at the bottom of the page, allowing you to easily manage and retrieve your references.'**
  String get default_articles_articles_third_paragraph;

  /// No description provided for @default_articles_articles_fourth_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Adding and Managing Content'**
  String get default_articles_articles_fourth_subtitle;

  /// No description provided for @default_articles_articles_fourth_paragraph.
  ///
  /// In en, this message translates to:
  /// **'The buttons for adding elements to your article are located at the top of the page. To manage this content, use the menu at the bottom.'**
  String get default_articles_articles_fourth_paragraph;

  /// No description provided for @default_articles_articles_fifth_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Powerful Tool'**
  String get default_articles_articles_fifth_subtitle;

  /// No description provided for @default_articles_articles_fifth_paragraph.
  ///
  /// In en, this message translates to:
  /// **'With articles, you have a powerful and user-friendly tool to organize, share, and find your knowledge with ease.'**
  String get default_articles_articles_fifth_paragraph;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
