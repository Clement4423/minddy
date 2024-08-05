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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
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
    return Intl.message(
      'Welcome',
      name: 'welcome_appbar',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Settings',
      name: 'settings_title',
      desc: '',
      args: [],
    );
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

  /// `Search`
  String get articles_search {
    return Intl.message(
      'Search',
      name: 'articles_search',
      desc: '',
      args: [],
    );
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

  /// `It's empty now. Import articles or write your own to fill the space !`
  String get articles_empty_menu_page_text {
    return Intl.message(
      'It\'s empty now. Import articles or write your own to fill the space !',
      name: 'articles_empty_menu_page_text',
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
    return Intl.message(
      'Copy',
      name: 'articles_copy_text',
      desc: '',
      args: [],
    );
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
  String get snacbar_close_button {
    return Intl.message(
      'Close',
      name: 'snacbar_close_button',
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
    return Intl.message(
      'Home',
      name: 'home_appbar',
      desc: '',
      args: [],
    );
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

  /// `Next page ⌘ + ⭢`
  String get projects_next_page_shortcut_tooltip_mac {
    return Intl.message(
      'Next page ⌘ + ⭢',
      name: 'projects_next_page_shortcut_tooltip_mac',
      desc: '',
      args: [],
    );
  }

  /// `Previous page ⌘ + ⭠`
  String get projects_previous_page_shortcut_tooltip_mac {
    return Intl.message(
      'Previous page ⌘ + ⭠',
      name: 'projects_previous_page_shortcut_tooltip_mac',
      desc: '',
      args: [],
    );
  }

  /// `Next page ctrl + ⭢`
  String get projects_next_page_shortcut_tooltip {
    return Intl.message(
      'Next page ctrl + ⭢',
      name: 'projects_next_page_shortcut_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Previous page ctrl + ⭠`
  String get projects_previous_page_shortcut_tooltip {
    return Intl.message(
      'Previous page ctrl + ⭠',
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
      num totalTasksCount, Object checkedTasks) {
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
          Object optionName) {
    return Intl.message(
      'Two options can\'t have the same name ($optionName)',
      name:
          'projects_module_spreadsheet_selection_sub_menu_error_message_redundant_option_name',
      desc: '',
      args: [optionName],
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
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es', countryCode: 'ES'),
      Locale.fromSubtags(languageCode: 'fr', countryCode: 'FR'),
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
