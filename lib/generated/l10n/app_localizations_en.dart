import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'minddy';

  @override
  String get app_slogan => 'Everything happens here.';

  @override
  String get system_files_copy_text => 'Copy';

  @override
  String get appbar_go_home => 'Go back home';

  @override
  String get welcome_appbar => 'Welcome';

  @override
  String get welcome_before_creating => 'First of all, please enter your first name';

  @override
  String get welcome_because => 'To personalize your experience';

  @override
  String get welcome_pass_username => 'Skip';

  @override
  String welcome_pass_tooltip(Object accountSettingName) {
    return 'You will still be able to enter your first name in settings / $accountSettingName';
  }

  @override
  String get welcome_pass_default_username => 'User';

  @override
  String get welcome_enter_name => 'Enter your first name';

  @override
  String get welcome_first_name_too_long => 'The first name cannot be longer than 25 letters';

  @override
  String get welcome_should_provide => 'Please, provide your first name';

  @override
  String get welcome_error_save_username => 'An error occured while saving your name. Please try again';

  @override
  String get welcome_next_page_semantic => 'Next page';

  @override
  String get welcome_password_creation_title => 'Now, create a password';

  @override
  String get welcome_password_creation_description => 'To keep your data secured';

  @override
  String get welcome_password_creation_hint => 'Create your password';

  @override
  String get welcome_password_creation_confirm_hint => 'Confirm your password';

  @override
  String get welcome_password_creation_error_must_provide => 'Please, create a password';

  @override
  String get welcome_password_creation_error_not_match => 'Passwords do not match';

  @override
  String get welcome_password_creation_show_semantic => 'Show password';

  @override
  String get welcome_password_creation_hide_semantic => 'Hide password';

  @override
  String get welcome_password_creation_error_password_save => 'An error occured while saving your password';

  @override
  String get welcome_password_creation_remember => 'Add a password hint (optional)';

  @override
  String get welcome_password_creation_password_requirements => 'Password must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, and one digit.';

  @override
  String get calendar_main_calendar_name => 'Main calendar';

  @override
  String get calendar_button_new_event_button_title => 'Event';

  @override
  String get calendar_button_new_due_date_button_title => 'Due date';

  @override
  String get calendar_button_calendar_title => 'Calendar';

  @override
  String get calendar_button_next_events_title => 'Next events';

  @override
  String get calendar_button_next_due_dates_title => 'Due dates';

  @override
  String get calendar_button_add_event_button_tooltip => 'Add event';

  @override
  String get calendar_button_manage_calendar_button_tooltip => 'Manage calendar';

  @override
  String get calendar_button_event_date_yesterday => 'Yesterday';

  @override
  String get calendar_button_event_date_today => 'Today';

  @override
  String get calendar_button_event_date_tomorrow => 'Tomorrow';

  @override
  String get calendar_button_due_date_cancel_complete => 'Cancel';

  @override
  String calendar_button_due_date_has_been_complete(Object eventName, Object username) {
    return '$eventName has been completed by $username';
  }

  @override
  String get calendar_event_detailed_preview_not_completed_yet => 'Not completed yet';

  @override
  String calendar_event_detailed_preview_completed_by(Object username) {
    return 'Completed by $username';
  }

  @override
  String get calendar_new_event_title => 'New event';

  @override
  String get calendar_modify_event_title => 'Modify event';

  @override
  String get calendar_new_due_date_title => 'New due date';

  @override
  String get calendar_modify_due_date_title => 'Modify due date';

  @override
  String get calendar_new_event_whole_day => 'Whole day';

  @override
  String get calendar_new_event_recurrence_subtitle => 'Recurrence';

  @override
  String get calendar_new_event_recurrence_type_never => 'Never';

  @override
  String get calendar_new_event_recurrence_type_everyday => 'Every day';

  @override
  String get calendar_new_event_recurrence_type_everyweek => 'Every week';

  @override
  String get calendar_new_event_recurrence_type_everymonth => 'Every month';

  @override
  String get calendar_new_event_recurrence_type_everyyear => 'Every year';

  @override
  String get calendar_new_event_recurrence_select_calendar => 'Select a calendar';

  @override
  String get calendar_button_open_week_view_button_tooltip => 'Open week-view';

  @override
  String get calendar_button_event_selection_menu_only_this_event => 'Only this event';

  @override
  String get calendar_button_event_selection_menu_all_occurence => 'All occurrences';

  @override
  String get calendar_button_free_for_next_days => 'You are free for the next 5 days';

  @override
  String get calendar_button_manage_calendars_sub_menu_all_calendars_subtitle => 'All calendars';

  @override
  String get calendar_button_manage_calendars_sub_menu_add_calendar => 'New calendar';

  @override
  String get calendar_button_manage_calendars_sub_menu_modify_calendar => 'Modify calendar';

  @override
  String get calendar_button_new_calendar_calendar_subtitle_name => 'Name';

  @override
  String get calendar_button_new_calendar_personalized_color => 'Personalized';

  @override
  String get calendar_button_new_calendar_private_calendar_title => 'Private calendar';

  @override
  String get calendar_button_new_calendar_private_calendar_explanation => 'By enabling this, the password will be required to see events from this calendar';

  @override
  String get calendar_button_event_preview_private_event => 'This event is private.';

  @override
  String get calendar_button_event_preview_see_button => 'See';

  @override
  String calendar_button_event_preview_recurence_text_every_day(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'Every $interval days',
      one: 'Everyday',
    );
    return '$_temp0';
  }

  @override
  String calendar_button_event_preview_recurence_text_every_week(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'Every $interval weeks',
      one: 'Every week',
    );
    return '$_temp0';
  }

  @override
  String calendar_button_event_preview_recurence_text_every_month(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'Every $interval months',
      one: 'Every month',
    );
    return '$_temp0';
  }

  @override
  String calendar_button_event_preview_recurence_text_every_year(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'Every $interval years',
      one: 'Every year',
    );
    return '$_temp0';
  }

  @override
  String calendar_week_view_week_title(Object week) {
    return 'Week $week';
  }

  @override
  String get calendar_week_view_week_details => 'Details';

  @override
  String get calendar_new_due_date_event_completion_state_subtitle => 'Completion state';

  @override
  String get calendar_new_due_date_event_completion_state => 'State';

  @override
  String get calendar_new_event_recurence_type_subtitle => 'Type';

  @override
  String get calendar_new_event_recurence_every_subtitle => 'Every';

  @override
  String calendar_new_event_recurence_every_day(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'days',
      one: 'day',
    );
    return '$_temp0';
  }

  @override
  String calendar_new_event_recurence_every_week(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'weeks',
      one: 'week',
    );
    return '$_temp0';
  }

  @override
  String calendar_new_event_recurence_every_month(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'months',
      one: 'month',
    );
    return '$_temp0';
  }

  @override
  String calendar_new_event_recurence_every_year(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'years',
      one: 'year',
    );
    return '$_temp0';
  }

  @override
  String get calendar_new_event_recurence_end_date => 'End date';

  @override
  String get calendar_new_event_recurence_end_date_option_the => 'The...';

  @override
  String get center_menu_general => 'General';

  @override
  String get center_menu_others => 'Other';

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_personalize_title => 'Personalize';

  @override
  String get settings_accessibility_title => 'Accessibility';

  @override
  String get settings_security_title => 'Security';

  @override
  String get settings_account_title => 'My account';

  @override
  String get settings_theme_subtitle => 'Theme';

  @override
  String get settings_using_dark_mode => 'Dark mode';

  @override
  String get settings_using_light_mode => 'Light mode';

  @override
  String get settings_need_to_quit_project_to_change_theme => 'To change theme settings, please go back at home';

  @override
  String get settings_need_to_quit_project_to_change_language => 'To change language, please go back at home';

  @override
  String get settings_using_system_theme => 'Device theme';

  @override
  String get settings_personalize_black_and_white_title => 'Black and white mode';

  @override
  String get settings_date_format_subtitle => 'Date format';

  @override
  String get settings_date_format => 'Prefer MM/dd date format';

  @override
  String settings_date_format_tooltip(Object actualDay, Object actualMonth) {
    return 'This option will put the month before the day. Like this : $actualMonth/$actualDay';
  }

  @override
  String get settings_language_subtitle => 'Language';

  @override
  String get settings_username_subtitle => 'First name';

  @override
  String get settings_reset_subtitle => 'Reset';

  @override
  String get settings_reset_button => 'Reset settings';

  @override
  String get settings_project_rename_button => 'Rename';

  @override
  String get settings_project_rename_subtitle => 'Rename';

  @override
  String get settings_project_delete_subtitle => 'Delete';

  @override
  String get settings_project_delete_button => 'Delete this project';

  @override
  String get settings_project_privacy_subtitle => 'Privacy';

  @override
  String get settings_project_private_project => 'Private project';

  @override
  String get articles_search => 'Search';

  @override
  String get articles_search_explain => 'Search a title, author';

  @override
  String get articles_search_empty => 'No result';

  @override
  String get articles_impossible_to_load_content => 'Impossible to load article content';

  @override
  String get articles_corrupted_file => 'This article is corrupted';

  @override
  String articles_importer_images_found_many(Object count) {
    return '$count images found. Do you want to import them ?';
  }

  @override
  String get articles_importer_image_found_single => '1 image found. Do you want to import it ?';

  @override
  String get articles_importer_import_images_title => 'Import images';

  @override
  String get articles_importer_import_images_button => 'Import';

  @override
  String get articles_importer_dont_import_images_button => 'Don\'t import';

  @override
  String get articles_empty_menu_page_text => 'No articles for this category yet, import, or write one !';

  @override
  String get articles_empty_menu_saved_page_text => 'No saved article yet';

  @override
  String get articles_new_article => 'New article';

  @override
  String get articles_import_articles => 'Import articles';

  @override
  String get articles_export_articles => 'Export this article';

  @override
  String get articles_export_articles_choose_category => 'Choose a category';

  @override
  String get articles_export_canceled => 'Article has not been exported';

  @override
  String get articles_export_confirmed => 'Article has been exported';

  @override
  String get articles_export_confirmed_button => 'See the location';

  @override
  String get articles_creativity_title => 'Creativity';

  @override
  String get articles_daily_life_title => 'Daily life';

  @override
  String get articles_professional_title => 'Professional';

  @override
  String get articles_wellness_title => 'Wellness';

  @override
  String get articles_technology_title => 'Technology';

  @override
  String get articles_education_title => 'Education';

  @override
  String get articles_science_title => 'Science';

  @override
  String get articles_philosophy_title => 'Philosophy';

  @override
  String get articles_environment_title => 'Nature';

  @override
  String get articles_travel_title => 'Travel';

  @override
  String get articles_finance_title => 'Finance';

  @override
  String get articles_politics_title => 'Politics';

  @override
  String get articles_food_title => 'Food';

  @override
  String get articles_saved_title => 'Saved';

  @override
  String get articles_my_articles_title => 'My Articles';

  @override
  String get articles_read_button => 'Read';

  @override
  String get articles_sources_text => 'Sources';

  @override
  String get articles_bookmark_semantic_text => 'Bookmark article';

  @override
  String get articles_add_text_semantic_text => 'Add a text bloc';

  @override
  String get articles_add_subtitle_semantic_text => 'Add a subtitle';

  @override
  String get articles_add_image_semantic_text => 'Add an image';

  @override
  String get articles_go_back_semantic_text => 'Previous';

  @override
  String get articles_card_untitled => 'Untitled';

  @override
  String get articles_title_hint => 'Enter a title...';

  @override
  String get articles_subtitle_hint => 'Enter a subtitle...';

  @override
  String get articles_text_hint => 'Enter some text...';

  @override
  String get articles_code_hint => 'Enter some code...';

  @override
  String get articles_copy_text => 'Copy';

  @override
  String get articles_copy_to_notes_text => 'Add to notes';

  @override
  String get articles_add_to_content => 'Add to article';

  @override
  String get articles_images_add_button => 'Add an image';

  @override
  String get articles_images_change_button => 'Change image';

  @override
  String get articles_card_delete_this_article => 'this article';

  @override
  String get articles_bottom_menu_open_semantic_text => 'Open menu';

  @override
  String get articles_bottom_menu_close_semantic_text => 'Close menu';

  @override
  String get articles_bottom_menu_sources_button => 'Sources';

  @override
  String get articles_bottom_menu_content_button => 'Content';

  @override
  String get articles_bottom_menu_notes_button => 'Notes';

  @override
  String get articles_add_source_hint => 'Indicate a source...';

  @override
  String get articles_add_source_button => 'Add a source';

  @override
  String articles_no_notes(Object actionName) {
    return 'No notes yet ! Click \'$actionName\' on any article element to start taking some.';
  }

  @override
  String get articles_no_sources => 'No sources provided yet! Remember to include sources for future readers.';

  @override
  String get articles_no_content => 'This article is empty ! Start adding elements to move them.';

  @override
  String get articles_calculate_reading_time => 'Calculate reading time';

  @override
  String get articles_add_list_semantic_text => 'Add a list';

  @override
  String get articles_add_code_semantic_text => 'Add a code block';

  @override
  String get articles_define_language => 'Define language';

  @override
  String get articles_imported => 'Articles have been imported';

  @override
  String get articles_not_imported => 'Articles have not been imported';

  @override
  String get snackbar_cancel_button => 'Close';

  @override
  String get snackbar_restart_needed_text => 'You will need to restart the app to apply changes';

  @override
  String get snackbar_restart_button => 'Close app';

  @override
  String get snackbar_reset_text => 'Reset settings ?';

  @override
  String get snackbar_reset_button => 'Reset';

  @override
  String snackbar_delete_element_text(Object element) {
    return 'Delete $element ?';
  }

  @override
  String get snackbar_delete_button => 'Delete';

  @override
  String get snackbar_articles_saved => 'This article has been save';

  @override
  String get snackbar_articles_unsaved => 'This article has been unsaved';

  @override
  String get snackbar_close_button => 'Close';

  @override
  String snackbar_welcome_back_text(Object user) {
    return 'Welcome back $user';
  }

  @override
  String get snackbar_welcome_back_button => 'Thank\'s';

  @override
  String get home_appbar => 'Home';

  @override
  String greeting_morning(Object username) {
    return 'Good morning $username';
  }

  @override
  String greeting_afternoon(Object username) {
    return 'Good afternoon $username';
  }

  @override
  String greeting_evening(Object username) {
    return 'Good evening $username';
  }

  @override
  String get home_pick_up => 'Pick up where you left off';

  @override
  String get home_discover => 'Discover minddy';

  @override
  String get home_articles_card_open_hint => 'Open this article';

  @override
  String get submenu_new_project_title => 'New project';

  @override
  String get submenu_new_project_subtitle => 'Project\'s name';

  @override
  String get submenu_new_project_hint => 'Enter the project\'s name...';

  @override
  String get submenu_new_project_button => 'Create';

  @override
  String get submenu_new_project_errorMessage => 'Please, provide a project name';

  @override
  String get submenu_artilces_image_description_title => 'Description';

  @override
  String get submenu_artilces_image_description_subtitle => 'Image description';

  @override
  String get submenu_artilces_image_description_hint => 'Write the image description...';

  @override
  String get submenu_artilces_image_description_button => 'Validate';

  @override
  String get submenu_welcome_password_mnemonic_sentence_title => 'Password hint';

  @override
  String get submenu_welcome_password_mnemonic_sentence_subtitle => 'Add a password hint';

  @override
  String get submenu_welcome_password_mnemonic_sentence_hint => 'Enter your password hint';

  @override
  String get submenu_welcome_password_mnemonic_sentence_instructs => 'This feature assists you in recalling your password if you forget it. It is not recommended to enter your password directly; please provide a hint instead.';

  @override
  String get submenu_unlock_subtitle_text => 'Enter your password';

  @override
  String get submenu_unlock_show_mnemonic => 'Show the password hint';

  @override
  String get submenu_unlock_hide_mnemonic => 'Hide the password hint';

  @override
  String get submenu_unlock_error_message_incorrect_password => 'Incorect password';

  @override
  String get submenu_unlock_error_message_please_enter_password => 'Please, enter your password';

  @override
  String get submenu_unlock_error_message_error_login => 'Unable to verify password.';

  @override
  String get submenu_unlock_content_title => 'Unlock';

  @override
  String get custom_date_picker_start => 'Start';

  @override
  String get custom_date_picker_end => 'End';

  @override
  String get custom_date_picker_invalid_date => 'Invalid date';

  @override
  String get custom_date_picker_select_single_date_title => 'Select a date';

  @override
  String get custom_date_picker_select_multiples_date_title => 'Select dates';

  @override
  String get custom_date_picker_include_hour => 'Include hour';

  @override
  String get project_card_open_settings => 'Modify';

  @override
  String get project_card_duplicate => 'Duplicate';

  @override
  String get project_card_delete => 'Delete';

  @override
  String get tool_pomodoro_work_duration => 'Work session duration';

  @override
  String get tool_pomodoro_work_session => 'Work';

  @override
  String get tool_pomodoro_break_duration => 'Break session duration';

  @override
  String get tool_pomodoro_break_session => 'Break';

  @override
  String tool_pomodoro_break_snackbar(num duration) {
    String _temp0 = intl.Intl.pluralLogic(
      duration,
      locale: localeName,
      other: 'Pomodoro - It\'s time for a break for $duration minutes',
      one: 'Pomodoro - It\'s time for a break for $duration minute',
      zero: 'Pomodoro - It\'s time for a break',
    );
    return '$_temp0';
  }

  @override
  String tool_pomodoro_work_snackbar(num duration) {
    String _temp0 = intl.Intl.pluralLogic(
      duration,
      locale: localeName,
      other: 'Pomodoro - It\'s time to get back to work for $duration minutes',
      one: 'Pomodoro - It\'s time to get back to work for $duration minute',
      zero: 'Pomodoro - It\'s time to get back to work',
    );
    return '$_temp0';
  }

  @override
  String tool_pomodoro_end_session(num duration) {
    String _temp0 = intl.Intl.pluralLogic(
      duration,
      locale: localeName,
      other: '$duration minutes',
      one: '1 minute',
    );
    return 'Pomodoro session is over, you worked $_temp0. Time to take a rest !';
  }

  @override
  String get tool_pomodoro_repetition_count => 'Repetition count';

  @override
  String get tool_pomodoro_focus_timer => 'Focus timer';

  @override
  String get tool_pomodoro_start_button => 'Start';

  @override
  String get tool_pomodoro_stop_button => 'Stop';

  @override
  String get projects_next_page_shortcut_tooltip_mac => 'Next page (⌘ + ⭢)';

  @override
  String get projects_previous_page_shortcut_tooltip_mac => 'Previous page (⌘ + ⭠)';

  @override
  String get projects_next_page_shortcut_tooltip => 'Next page (ctrl + ⭢)';

  @override
  String get projects_previous_page_shortcut_tooltip => 'Previous page (ctrl + ⭠)';

  @override
  String get projects_add_module_tooltip => 'New module';

  @override
  String get projects_save_project_button_tooltip => 'Save';

  @override
  String get projects_module_help_text => 'Help';

  @override
  String get projects_module_tasks_title => 'Tasks';

  @override
  String projects_module_tasks_completed(Object checkedTasks, num totalTasksCount) {
    String _temp0 = intl.Intl.pluralLogic(
      totalTasksCount,
      locale: localeName,
      other: '$checkedTasks/$totalTasksCount tasks completed',
      one: '$checkedTasks/$totalTasksCount task completed',
      zero: 'No tasks',
    );
    return '$_temp0';
  }

  @override
  String get projects_module_tasks_task_title_hint => 'Title';

  @override
  String get projects_module_tasks_task_add_subtask_tooltip => 'Add a subtask';

  @override
  String get projects_module_tasks_add_task_tooltip => 'Add a new task';

  @override
  String get projects_module_notes_new_category_tooltip => 'New category';

  @override
  String get projects_module_notes_new_note_tooltip => 'New note';

  @override
  String get projects_module_notes_modify_category => 'Modify';

  @override
  String get projects_module_notes_modify_note_tooltip => 'Modify this note';

  @override
  String get projects_module_notes_new_category_sub_menu_title => 'New category';

  @override
  String get projects_module_notes_new_category_sub_menu_subtitle => 'Category name';

  @override
  String get projects_module_notes_new_category_sub_menu_name_hint => 'Enter the category name';

  @override
  String get projects_module_notes_new_category_sub_menu_is_private => 'Private category';

  @override
  String get projects_module_notes_new_category_sub_menu_error_message => 'Please, name the category';

  @override
  String get projects_module_notes_new_category_sub_menu_is_private_tooltip => 'By enabling this option, your password will be required to open this category.';

  @override
  String get projects_module_notes_modify_category_sub_menu_title => 'Modify category';

  @override
  String get projects_module_notes_editing_note_sub_menu_save_tooltip => 'Save note';

  @override
  String get projects_module_notes_editing_note_sub_menu_move_tooltip => 'Move';

  @override
  String get projects_module_notes_for_later_title => 'Notes for later';

  @override
  String get projects_module_notes_important_notes_title => 'Important notes';

  @override
  String get projects_module_notes_private_notes_title => 'Privates notes';

  @override
  String get projects_module_notes_project_notes_title => 'Project notes';

  @override
  String projects_module_notes_category_note_count(num totalNotesCount) {
    String _temp0 = intl.Intl.pluralLogic(
      totalNotesCount,
      locale: localeName,
      other: '$totalNotesCount notes',
      one: '1 note',
      zero: 'No note',
    );
    return '$_temp0';
  }

  @override
  String get projects_module_notes_title => 'Notes';

  @override
  String get projects_module_spreadsheet_title => 'Spreadsheet';

  @override
  String get projects_module_spreadsheet_value_unnamed => 'Unnamed';

  @override
  String get projects_module_spreadsheet_new_row => 'New row';

  @override
  String get projects_module_spreadsheet_new_column => 'New column';

  @override
  String get projects_module_spreadsheet_delete_row => 'Delete this row';

  @override
  String get projects_module_spreadsheet_delete_column => 'Delete this column';

  @override
  String get projects_module_spreadsheet_data_column_type => 'Column type';

  @override
  String get projects_module_spreadsheet_data_choose_column_type_tooltip => 'Choose a column type';

  @override
  String get projects_module_spreadsheet_data_type_text => 'Text';

  @override
  String get projects_module_spreadsheet_data_type_number => 'Number';

  @override
  String get projects_module_spreadsheet_data_type_phone_number => 'Phone number';

  @override
  String get projects_module_spreadsheet_data_type_email => 'E-mail';

  @override
  String get projects_module_spreadsheet_data_type_url => 'URL';

  @override
  String get projects_module_spreadsheet_data_type_date => 'Date';

  @override
  String get projects_module_spreadsheet_date_from_text => 'From';

  @override
  String get projects_module_spreadsheet_date_to_text => 'To';

  @override
  String get projects_module_spreadsheet_date_single_tooltip => 'Single date';

  @override
  String get projects_module_spreadsheet_date_start_end_tooltip => 'Add an end date';

  @override
  String get projects_module_spreadsheet_data_type_selection => 'Selection';

  @override
  String projetcs_module_spreadsheet_open_website(Object websiteName) {
    return 'Open $websiteName';
  }

  @override
  String get projects_module_spreadsheet_number_operation_none => 'None';

  @override
  String get projects_module_spreadsheet_number_operation_sum => 'Sum';

  @override
  String get projects_module_spreadsheet_number_operation_average => 'Average';

  @override
  String get projects_module_spreadsheet_number_operation_maximum => 'Maximum';

  @override
  String get projects_module_spreadsheet_number_operation_minimum => 'Minimum';

  @override
  String get projects_module_spreadsheet_number_operation_interval => 'Interval';

  @override
  String get projects_module_spreadsheet_number_operation_median => 'Median';

  @override
  String get projects_module_spreadsheet_number_operation_standard_deviation => 'Standard deviation';

  @override
  String get projects_module_spreadsheet_number_operation_calculate => 'Calculate';

  @override
  String get projects_module_spreadsheet_number_operation_sum_example => '10 + 50 + 100';

  @override
  String get projects_module_spreadsheet_number_operation_sum_message => 'Adds up all the values in the column to get the total. Useful for summing up data.';

  @override
  String get projects_module_spreadsheet_number_operation_average_example => '(10 + 50 + 100) / 3';

  @override
  String get projects_module_spreadsheet_number_operation_average_message => 'Calculates the average by dividing the sum of all values by the number of values. This helps in finding the central value of the data.';

  @override
  String get projects_module_spreadsheet_number_operation_maximum_example => '(10, 50, 100) = 100';

  @override
  String get projects_module_spreadsheet_number_operation_maximum_message => 'Finds the highest value in the column. Useful for identifying the largest number.';

  @override
  String get projects_module_spreadsheet_number_operation_minimum_example => '(10, 50, 100) = 10';

  @override
  String get projects_module_spreadsheet_number_operation_minimum_message => 'Finds the lowest value in the column. This helps in identifying the smallest number.';

  @override
  String get projects_module_spreadsheet_number_operation_interval_example => '(10, 50, 100) = 90';

  @override
  String get projects_module_spreadsheet_number_operation_interval_message => 'Calculates the range by subtracting the smallest value from the largest value in the column. It shows the spread of the values.';

  @override
  String get projects_module_spreadsheet_number_operation_median_example => '(10, 50, 100) = 50';

  @override
  String get projects_module_spreadsheet_number_operation_median_message => 'Finds the middle value when the column values are sorted. Useful for identifying the central value.';

  @override
  String get projects_module_spreadsheet_number_operation_standardDeviation_example => '√[((10-53.33)² + (50-53.33)² + (100-53.33)²) / 3]';

  @override
  String get projects_module_spreadsheet_number_operation_standardDeviation_message => 'Calculates the standard deviation to measure how much the values vary from the average. Here, 53.33 is the mean of the values 10, 50, and 100.';

  @override
  String get projects_module_spreadsheet_extend_cell_tooltip => 'Extend this cell';

  @override
  String get projects_module_spreadsheet_selection_cell_not_started => 'Not started';

  @override
  String get projects_module_spreadsheet_selection_cell_started => 'Started';

  @override
  String get projects_module_spreadsheet_selection_cell_finished => 'Finished';

  @override
  String get projects_module_spreadsheet_selection_cell_modify_options => 'Modify options';

  @override
  String get projects_module_spreadsheet_selection_cell_add_options => 'Add options';

  @override
  String get projects_module_spreadsheet_selection_cell_add_an_option => 'Add an option';

  @override
  String get projects_module_spreadsheet_selection_cell_all_options => 'All options';

  @override
  String get projects_module_spreadsheet_selection_cell_name_option_hint => 'Name this option...';

  @override
  String get projects_module_spreadsheet_manage_columns_sub_menu_title => 'Organize columns';

  @override
  String get projects_module_spreadsheet_manage_columns_sub_menu_subtitle => 'All columns';

  @override
  String get projects_module_spreadsheet_manage_rows_sub_menu_title => 'Organize rows';

  @override
  String get projects_module_spreadsheet_manage_rows_sub_menu_subtitle => 'All rows';

  @override
  String get projects_module_spreadsheet_selection_sub_menu_error_message_no_options => 'Please, add options';

  @override
  String get projects_module_spreadsheet_selection_sub_menu_error_message_unnamed_option => 'Please, name all options';

  @override
  String projects_module_spreadsheet_selection_sub_menu_error_message_redundant_option_name(Object optionName) {
    return 'Two options can\'t have the same name ($optionName)';
  }

  @override
  String get projects_module_spreadsheet_selection_sub_menu_error_message_redundant_color => 'Two options can\'t have the same color';

  @override
  String get projects_module_spreadsheet_chart_show_table => 'Show the table';

  @override
  String get projects_module_spreadsheet_chart_show_chart => 'Show the charts';

  @override
  String get projects_module_spreadsheet_chart_new_tab => 'New tab';

  @override
  String get projects_module_spreadsheet_chart_new_column => 'Add a coulumn';

  @override
  String get projects_module_spreadsheet_chart_chart_type_subtitle => 'Chart type';

  @override
  String get projects_module_spreadsheet_chart_chart_type_donut => 'Donut';

  @override
  String get projects_module_spreadsheet_chart_chart_type_bar => 'Bar';

  @override
  String get projects_module_spreadsheet_chart_chart_type_bar_simple => 'Simple bars';

  @override
  String get projects_module_spreadsheet_chart_chart_type_bar_grouped => 'Grouped bars';

  @override
  String get projects_module_spreadsheet_chart_chart_type_bar_stacked => 'Stacked bars';

  @override
  String get projects_module_spreadsheet_chart_chart_select_column => 'Select a column';

  @override
  String get projects_module_spreadsheet_chart_chart_column_single => 'Column';

  @override
  String get projects_module_spreadsheet_chart_chart_column_plural => 'Columns';

  @override
  String get custom_chart_empty_content => 'To create a chart, please add data to it';

  @override
  String get custom_chart_donut_total => 'Total';

  @override
  String get custom_chart_donut_share => 'Share';

  @override
  String get custom_chart_grid_extend_chart => 'Enlarge chart';

  @override
  String get custom_color_picker_opacity_tooltip => 'Opacity';

  @override
  String get node_editor_view_new_node_tooltip => 'New node';

  @override
  String get node_editor_view_close_node_panel_tooltip => 'Close node panel';

  @override
  String get node_editor_view_open_node_panel_tooltip => 'Open node panel';

  @override
  String get node_editor_view_close_side_panel_tooltip => 'Close side panel';

  @override
  String get node_editor_view_open_side_panel_tooltip => 'Open side panel';

  @override
  String get node_editor_view_side_panel_variables_title => 'Variables';

  @override
  String get node_editor_view_side_panel_variables_add_button_tooltip => 'New variable';

  @override
  String get node_editor_view_side_panel_variables_variable_type_any => 'Not defined';

  @override
  String get node_editor_view_side_panel_variables_variable_type_number => 'Number';

  @override
  String get node_editor_view_side_panel_variables_variable_type_text => 'Text';

  @override
  String get node_editor_view_side_panel_variables_variable_type_boolean => 'Boolean';

  @override
  String get node_editor_view_side_panel_variables_variable_type_list => 'List';

  @override
  String get node_editor_view_side_panel_variables_variable_type_color => 'Color';

  @override
  String get node_editor_view_side_panel_node_trees_title => 'Node trees';

  @override
  String get node_editor_view_side_panel_node_trees_add_button_tooltip => 'New node tree';

  @override
  String get node_editor_view_bottom_toolbar_undo_tooltip_windows => 'Undo (ctrl + z)';

  @override
  String get node_editor_view_bottom_toolbar_undo_tooltip_mac => 'Undo (⌘ + z)';

  @override
  String get node_editor_view_bottom_toolbar_redo_tooltip_windows => 'Redo (⇧ + ctrl + z)';

  @override
  String get node_editor_view_bottom_toolbar_redo_tooltip_mac => 'Redo (⇧ + ⌘ + z)';

  @override
  String node_editor_view_bottom_toolbar_copy_tooltip_windows(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Copy selected nodes (ctrl + c)',
      one: 'Copy selected node (ctrl + c)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_copy_tooltip_mac(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Copy selected nodes (⌘ + c)',
      one: 'Copy selected node (⌘ + c)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_paste_tooltip_windows(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Paste copied nodes (ctrl + v)',
      one: 'Paste copied node (ctrl + v)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_paste_tooltip_mac(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Paste copied nodes (⌘ + v)',
      one: 'Paste copied node (⌘ + v)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_duplicate_tooltip_windows(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Duplicate selected nodes (ctrl + d)',
      one: 'Duplicate selected node (ctrl + d)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_duplicate_tooltip_mac(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Duplicate selected nodes (⌘ + d)',
      one: 'Duplicate selected node (⌘ + d)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_delete_tooltip_windows(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Delete selected nodes (ctrl + ⌫)',
      one: 'Delete selected node (ctrl + ⌫)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_delete_tooltip_mac(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Delete selected nodes (⌘ + ⌫)',
      one: 'Delete selected node (⌘ + ⌫)',
    );
    return '$_temp0';
  }

  @override
  String get node_editor_add_sub_menu_types => 'Types';

  @override
  String node_editor_add_sub_menu_inputs_subtitle(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Inputs',
      one: 'Input',
    );
    return '$_temp0';
  }

  @override
  String node_editor_add_sub_menu_outputs_subtitle(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Outputs',
      one: 'Output',
    );
    return '$_temp0';
  }

  @override
  String get node_editor_add_sub_menu_note => 'Note: Inputs and outputs may vary depending on the options chosen for the node';

  @override
  String get node_editor_add_sub_menu_no_nodes_found => 'No nodes found.';

  @override
  String get node_editor_add_sub_menu_add_button => 'Add';

  @override
  String get node_editor_add_sub_menu_none_input_output => 'None';

  @override
  String get node_widgets_value_text => 'Value';

  @override
  String get node_widgets_result_text => 'Result';

  @override
  String get node_widgets_text_text => 'Text';

  @override
  String get node_widgets_start_text => 'Start';

  @override
  String get node_widgets_end_text => 'End';

  @override
  String get node_widgets_length_text => 'Length';

  @override
  String get node_widgets_treshold_text => 'Treshold';

  @override
  String get node_widgets_category_math => 'Math';

  @override
  String get node_widgets_category_logic => 'Logic';

  @override
  String get node_widgets_category_variable => 'Variables';

  @override
  String get node_widgets_math_node_title => 'Calculations';

  @override
  String get node_widgets_math_node_description => 'Performs calculations on numbers.';

  @override
  String get node_widgets_math_node_options_addition => 'Addition';

  @override
  String get node_widgets_math_node_options_substraction => 'Substraction';

  @override
  String get node_widgets_math_node_options_division => 'Division';

  @override
  String get node_widgets_math_node_options_multiplication => 'Multiplication';

  @override
  String get node_widgets_math_node_options_squareRoot => 'Square Root';

  @override
  String get node_widgets_math_node_options_power => 'Power';

  @override
  String get node_widgets_math_node_options_min => 'Min';

  @override
  String get node_widgets_math_node_options_max => 'Max';

  @override
  String get node_widgets_math_node_options_sign => 'Sign';

  @override
  String get node_widgets_math_node_options_round => 'Round';

  @override
  String get node_widgets_math_node_options_floor => 'Floor';

  @override
  String get node_widgets_math_node_options_ceil => 'Ceil';

  @override
  String get node_widgets_math_node_options_truncate => 'Truncate';

  @override
  String get node_widgets_math_node_options_sin => 'Sine';

  @override
  String get node_widgets_math_node_options_cos => 'Cosine';

  @override
  String get node_widgets_math_node_options_tan => 'Tangent';

  @override
  String get node_widgets_math_node_options_asin => 'Arcsine';

  @override
  String get node_widgets_math_node_options_acos => 'Arccosine';

  @override
  String get node_widgets_math_node_options_atan => 'Arctangent';

  @override
  String get node_widgets_math_node_options_sinh => 'Hyperbolic Sine';

  @override
  String get node_widgets_math_node_options_cosh => 'Hyperbolic Cosine';

  @override
  String get node_widgets_math_node_options_tanh => 'Hyperbolic Tangent';

  @override
  String get node_widgets_math_node_options_asinh => 'Inverse Hyperbolic Sine';

  @override
  String get node_widgets_math_node_options_acosh => 'Inverse Hyperbolic Cosine';

  @override
  String get node_widgets_math_node_options_atanh => 'Inverse Hyperbolic Tangent';

  @override
  String get node_widgets_math_node_options_ln => 'Natural Logarithm';

  @override
  String get node_widgets_math_node_options_log10 => 'Logarithm Base 10';

  @override
  String get node_widgets_math_node_options_abs => 'Absolute Value';

  @override
  String get node_widgets_comparison_node_title => 'Comparison';

  @override
  String get node_widgets_comparison_node_description => 'Performs comparison between numbers.';

  @override
  String get node_widgets_comparison_node_options_lessThan => 'Less than';

  @override
  String get node_widgets_comparison_node_options_lessThanOrEqual => 'Less than or equal to';

  @override
  String get node_widgets_comparison_node_options_greatherThan => 'Greater than';

  @override
  String get node_widgets_comparison_node_options_greatherThanOrEqual => 'Greater than or equal to';

  @override
  String get node_widgets_comparison_node_options_equal => 'Equal to';

  @override
  String get node_widgets_boolean_node_title => 'Logic Operations';

  @override
  String get node_widgets_boolean_node_description => 'Performs operations on booleans.';

  @override
  String get node_widgets_boolean_node_options_and => 'And';

  @override
  String get node_widgets_boolean_node_options_or => 'Or';

  @override
  String get node_widgets_boolean_node_options_not => 'Not';

  @override
  String get node_widgets_boolean_node_options_notAnd => 'Not And';

  @override
  String get node_widgets_boolean_node_options_notOr => 'Not Or';

  @override
  String get node_widgets_boolean_node_options_equal => 'Equal';

  @override
  String get node_widgets_boolean_node_options_notEqual => 'Not Equal';

  @override
  String get node_widgets_boolean_node_options_imply => 'Imply';

  @override
  String get node_widgets_boolean_node_options_subtract => 'Subtract';

  @override
  String get node_widgets_conversion_node_title => 'Conversion';

  @override
  String get node_widgets_conversion_node_decsription => 'Converts a value to another type';

  @override
  String get node_widgets_text_operation_node_title => 'Text operation';

  @override
  String get node_widgets_text_operation_node_decsription => 'Performs operations on a text';

  @override
  String get node_widgets_text_operation_node_options_join => 'Join';

  @override
  String get node_widgets_text_operation_node_options_cut => 'Cut';

  @override
  String get node_widgets_text_operation_node_options_trim => 'Trim';

  @override
  String get node_widgets_text_operation_node_options_trim_left => 'Trim left';

  @override
  String get node_widgets_text_operation_node_options_trim_right => 'Trim right';

  @override
  String get node_widgets_text_operation_node_options_pad_left => 'Pad left';

  @override
  String get node_widgets_text_operation_node_options_pad_right => 'Pad right';

  @override
  String get node_widgets_text_operation_node_options_contains => 'Contains';

  @override
  String get node_widgets_set_variable_node_title => 'Set variable';

  @override
  String get node_widgets_set_variable_node_description => 'Sets a variable\'s value.';

  @override
  String get node_widgets_get_variable_node_title => 'Get variable';

  @override
  String get node_widgets_get_variable_node_description => 'Gets the value of a variable.';

  @override
  String get node_widgets_select_variable_node_text => 'Select a variable';

  @override
  String get node_widgets_random_number_node_title => 'Random number';

  @override
  String get node_widgets_random_number_node_description => 'Generates a random number between a minimum and maximum (0 and 1 by default).';

  @override
  String get plugin_editor_ui_side_panel_layers_title => 'Components';

  @override
  String get plugin_editor_ui_side_panel_layers_add_button => 'New component';

  @override
  String get plugin_editor_ui_side_panel_layers_add_child => 'Add child';

  @override
  String get plugin_editor_ui_side_panel_layers_more_options => 'More options';

  @override
  String plugin_editor_ui_side_panel_layers_hide_child(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Hide children',
      one: 'Hide child',
    );
    return '$_temp0';
  }

  @override
  String plugin_editor_ui_side_panel_layers_show_child(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Show children',
      one: 'Show child',
    );
    return '$_temp0';
  }

  @override
  String get plugin_editor_ui_side_panel_properties_size_subtitle => 'Size';

  @override
  String get plugin_editor_ui_side_panel_properties_size_width => 'Width';

  @override
  String get plugin_editor_ui_side_panel_properties_size_height => 'Height';

  @override
  String get plugin_editor_ui_side_panel_properties_style_subtitle => 'Style';

  @override
  String get plugin_editor_ui_side_panel_properties_style_border_radius => 'Border radius';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment => 'Alignment';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_top_left => 'Top left';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_top_right => 'Top right';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_bottom_left => 'Bottom left';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_bottom_right => 'Bottom right';

  @override
  String get plugin_editor_ui_side_panel_properties_border_subtitle => 'Border';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_top => 'Top';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_bottom => 'Bottom';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_left => 'Left';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_right => 'Right';

  @override
  String get plugin_editor_ui_side_panel_properties_style_border_thickness => 'Thickness';

  @override
  String get plugin_editor_ui_side_panel_properties_theme_colors_primary => 'Primary';

  @override
  String get plugin_editor_ui_side_panel_properties_theme_colors_primary_transparent => 'Primary transparent';

  @override
  String get plugin_editor_ui_side_panel_properties_theme_colors_accent => 'Accent';

  @override
  String get plugin_editor_ui_side_panel_properties_theme_colors_surface => 'Surface';

  @override
  String get default_app_colors_change_color => 'Change color';

  @override
  String get default_app_colors_grey => 'Grey';

  @override
  String get default_app_colors_mint_green => 'Mint Green';

  @override
  String get default_app_colors_light_pink => 'Light Pink';

  @override
  String get default_app_colors_light_yellow => 'Light Yellow';

  @override
  String get default_app_colors_peach => 'Peach';

  @override
  String get default_app_colors_soft_red => 'Soft Red';

  @override
  String get default_app_colors_lavender => 'Lavender';

  @override
  String get default_app_colors_light_blue => 'Light Blue';

  @override
  String get default_app_colors_light_green => 'Light Green';

  @override
  String get default_app_colors_light_purple => 'Light Purple';

  @override
  String get default_articles_articles_title => 'Articles';

  @override
  String get default_articles_articles_description => 'Discover articles in minddy';

  @override
  String get default_articles_articles_first_subtitle => 'Key Feature';

  @override
  String get default_articles_articles_first_paragraph => 'Articles are a key feature of Minddy. They offer an elegant and intuitive interface for writing and sharing your knowledge. With this feature, you can easily disseminate your insights and benefit the entire community.';

  @override
  String get default_articles_articles_second_subtitle => 'Note Taking';

  @override
  String get default_articles_articles_second_paragraph => 'You can also take notes, which is ideal for saving texts or any other content you want to keep for later. This feature is perfect for capturing ideas or important information to revisit later.';

  @override
  String get default_articles_articles_third_subtitle => 'Source Management';

  @override
  String get default_articles_articles_third_paragraph => 'All your sources are accessible via a menu located at the bottom of the page, allowing you to easily manage and retrieve your references.';

  @override
  String get default_articles_articles_fourth_subtitle => 'Adding and Managing Content';

  @override
  String get default_articles_articles_fourth_paragraph => 'The buttons for adding elements to your article are located at the top of the page. To manage this content, use the menu at the bottom.';

  @override
  String get default_articles_articles_fifth_subtitle => 'Powerful Tool';

  @override
  String get default_articles_articles_fifth_paragraph => 'With articles, you have a powerful and user-friendly tool to organize, share, and find your knowledge with ease.';
}
