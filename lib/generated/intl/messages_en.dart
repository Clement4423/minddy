// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) =>
      "${count} images found. Do you want to import them ?";

  static String m1(actionName) =>
      "No notes yet ! Click \'${actionName}\' on any article element to start taking some.";

  static String m2(username) => "Good afternoon ${username}";

  static String m3(username) => "Good evening ${username}";

  static String m4(username) => "Good morning ${username}";

  static String m5(totalTasksCount, checkedTasks) =>
      "${Intl.plural(totalTasksCount, zero: 'No tasks', one: '${checkedTasks}/${totalTasksCount} task completed', other: '${checkedTasks}/${totalTasksCount} tasks completed')}";

  static String m6(element) => "Delete ${element} ?";

  static String m7(user) => "Welcome back ${user}";

  static String m8(accountSettingName) =>
      "You will still be able to enter your first name in settings / ${accountSettingName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appbar_go_home": MessageLookupByLibrary.simpleMessage("Go back home"),
        "articles_add_code_semantic_text":
            MessageLookupByLibrary.simpleMessage("Add a code block"),
        "articles_add_image_semantic_text":
            MessageLookupByLibrary.simpleMessage("Add an image"),
        "articles_add_list_semantic_text":
            MessageLookupByLibrary.simpleMessage("Add a list"),
        "articles_add_source_button":
            MessageLookupByLibrary.simpleMessage("Add a source"),
        "articles_add_source_hint":
            MessageLookupByLibrary.simpleMessage("Indicate a source..."),
        "articles_add_subtitle_semantic_text":
            MessageLookupByLibrary.simpleMessage("Add a subtitle"),
        "articles_add_text_semantic_text":
            MessageLookupByLibrary.simpleMessage("Add a text bloc"),
        "articles_add_to_content":
            MessageLookupByLibrary.simpleMessage("Add to article"),
        "articles_bookmark_semantic_text":
            MessageLookupByLibrary.simpleMessage("Bookmark article"),
        "articles_bottom_menu_close_semantic_text":
            MessageLookupByLibrary.simpleMessage("Close menu"),
        "articles_bottom_menu_content_button":
            MessageLookupByLibrary.simpleMessage("Content"),
        "articles_bottom_menu_notes_button":
            MessageLookupByLibrary.simpleMessage("Notes"),
        "articles_bottom_menu_open_semantic_text":
            MessageLookupByLibrary.simpleMessage("Open menu"),
        "articles_bottom_menu_sources_button":
            MessageLookupByLibrary.simpleMessage("Sources"),
        "articles_calculate_reading_time":
            MessageLookupByLibrary.simpleMessage("Calculate reading time"),
        "articles_card_delete_this_article":
            MessageLookupByLibrary.simpleMessage("this article"),
        "articles_card_untitled":
            MessageLookupByLibrary.simpleMessage("Untitled"),
        "articles_code_hint":
            MessageLookupByLibrary.simpleMessage("Enter some code..."),
        "articles_copy_text": MessageLookupByLibrary.simpleMessage("Copy"),
        "articles_copy_to_notes_text":
            MessageLookupByLibrary.simpleMessage("Add to notes"),
        "articles_corrupted_file":
            MessageLookupByLibrary.simpleMessage("This article is corrupted"),
        "articles_creativity_title":
            MessageLookupByLibrary.simpleMessage("Creativity"),
        "articles_daily_life_title":
            MessageLookupByLibrary.simpleMessage("Daily life"),
        "articles_define_language":
            MessageLookupByLibrary.simpleMessage("Define language"),
        "articles_education_title":
            MessageLookupByLibrary.simpleMessage("Education"),
        "articles_empty_menu_page_text": MessageLookupByLibrary.simpleMessage(
            "It\'s empty now. Import articles or write your own to fill the space !"),
        "articles_environment_title":
            MessageLookupByLibrary.simpleMessage("Nature"),
        "articles_export_articles":
            MessageLookupByLibrary.simpleMessage("Export this article"),
        "articles_export_articles_choose_category":
            MessageLookupByLibrary.simpleMessage("Choose a category"),
        "articles_export_canceled": MessageLookupByLibrary.simpleMessage(
            "Article has not been exported"),
        "articles_export_confirmed":
            MessageLookupByLibrary.simpleMessage("Article has been exported"),
        "articles_export_confirmed_button":
            MessageLookupByLibrary.simpleMessage("See the location"),
        "articles_finance_title":
            MessageLookupByLibrary.simpleMessage("Finance"),
        "articles_food_title": MessageLookupByLibrary.simpleMessage("Food"),
        "articles_go_back_semantic_text":
            MessageLookupByLibrary.simpleMessage("Previous"),
        "articles_images_add_button":
            MessageLookupByLibrary.simpleMessage("Add an image"),
        "articles_images_change_button":
            MessageLookupByLibrary.simpleMessage("Change image"),
        "articles_import_articles":
            MessageLookupByLibrary.simpleMessage("Import articles"),
        "articles_imported":
            MessageLookupByLibrary.simpleMessage("Articles have been imported"),
        "articles_importer_dont_import_images_button":
            MessageLookupByLibrary.simpleMessage("Don\'t import"),
        "articles_importer_image_found_single":
            MessageLookupByLibrary.simpleMessage(
                "1 image found. Do you want to import it ?"),
        "articles_importer_images_found_many": m0,
        "articles_importer_import_images_button":
            MessageLookupByLibrary.simpleMessage("Import"),
        "articles_importer_import_images_title":
            MessageLookupByLibrary.simpleMessage("Import images"),
        "articles_impossible_to_load_content":
            MessageLookupByLibrary.simpleMessage(
                "Impossible to load article content"),
        "articles_my_articles_title":
            MessageLookupByLibrary.simpleMessage("My Articles"),
        "articles_new_article":
            MessageLookupByLibrary.simpleMessage("New article"),
        "articles_no_content": MessageLookupByLibrary.simpleMessage(
            "This article is empty ! Start adding elements to move them."),
        "articles_no_notes": m1,
        "articles_no_sources": MessageLookupByLibrary.simpleMessage(
            "No sources provided yet! Remember to include sources for future readers."),
        "articles_not_imported": MessageLookupByLibrary.simpleMessage(
            "Articles have not been imported"),
        "articles_philosophy_title":
            MessageLookupByLibrary.simpleMessage("Philosophy"),
        "articles_politics_title":
            MessageLookupByLibrary.simpleMessage("Politics"),
        "articles_professional_title":
            MessageLookupByLibrary.simpleMessage("Professional"),
        "articles_read_button": MessageLookupByLibrary.simpleMessage("Read"),
        "articles_saved_title": MessageLookupByLibrary.simpleMessage("Saved"),
        "articles_science_title":
            MessageLookupByLibrary.simpleMessage("Science"),
        "articles_search": MessageLookupByLibrary.simpleMessage("Search"),
        "articles_search_empty":
            MessageLookupByLibrary.simpleMessage("No result"),
        "articles_search_explain":
            MessageLookupByLibrary.simpleMessage("Search a title, author"),
        "articles_sources_text":
            MessageLookupByLibrary.simpleMessage("Sources"),
        "articles_subtitle_hint":
            MessageLookupByLibrary.simpleMessage("Enter a subtitle..."),
        "articles_technology_title":
            MessageLookupByLibrary.simpleMessage("Technology"),
        "articles_text_hint":
            MessageLookupByLibrary.simpleMessage("Enter some text..."),
        "articles_title_hint":
            MessageLookupByLibrary.simpleMessage("Enter a title..."),
        "articles_travel_title": MessageLookupByLibrary.simpleMessage("Travel"),
        "articles_wellness_title":
            MessageLookupByLibrary.simpleMessage("Wellness"),
        "center_menu_general": MessageLookupByLibrary.simpleMessage("General"),
        "center_menu_others": MessageLookupByLibrary.simpleMessage("Other"),
        "default_articles_articles_description":
            MessageLookupByLibrary.simpleMessage("Discover articles in minddy"),
        "default_articles_articles_fifth_paragraph":
            MessageLookupByLibrary.simpleMessage(
                "With articles, you have a powerful and user-friendly tool to organize, share, and find your knowledge with ease."),
        "default_articles_articles_fifth_subtitle":
            MessageLookupByLibrary.simpleMessage("Powerful Tool"),
        "default_articles_articles_first_paragraph":
            MessageLookupByLibrary.simpleMessage(
                "Articles are a key feature of Minddy. They offer an elegant and intuitive interface for writing and sharing your knowledge. With this feature, you can easily disseminate your insights and benefit the entire community."),
        "default_articles_articles_first_subtitle":
            MessageLookupByLibrary.simpleMessage("Key Feature"),
        "default_articles_articles_fourth_paragraph":
            MessageLookupByLibrary.simpleMessage(
                "The buttons for adding elements to your article are located at the top of the page. To manage this content, use the menu at the bottom."),
        "default_articles_articles_fourth_subtitle":
            MessageLookupByLibrary.simpleMessage("Adding and Managing Content"),
        "default_articles_articles_second_paragraph":
            MessageLookupByLibrary.simpleMessage(
                "You can also take notes, which is ideal for saving texts or any other content you want to keep for later. This feature is perfect for capturing ideas or important information to revisit later."),
        "default_articles_articles_second_subtitle":
            MessageLookupByLibrary.simpleMessage("Note Taking"),
        "default_articles_articles_third_paragraph":
            MessageLookupByLibrary.simpleMessage(
                "All your sources are accessible via a menu located at the bottom of the page, allowing you to easily manage and retrieve your references."),
        "default_articles_articles_third_subtitle":
            MessageLookupByLibrary.simpleMessage("Source Management"),
        "default_articles_articles_title":
            MessageLookupByLibrary.simpleMessage("Articles"),
        "greeting_afternoon": m2,
        "greeting_evening": m3,
        "greeting_morning": m4,
        "home_appbar": MessageLookupByLibrary.simpleMessage("Home"),
        "home_articles_card_open_hint":
            MessageLookupByLibrary.simpleMessage("Open this article"),
        "home_discover":
            MessageLookupByLibrary.simpleMessage("Discover minddy"),
        "home_pick_up":
            MessageLookupByLibrary.simpleMessage("Pick up where you left off"),
        "project_card_delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "project_card_duplicate":
            MessageLookupByLibrary.simpleMessage("Duplicate"),
        "project_card_open_settings":
            MessageLookupByLibrary.simpleMessage("Modify"),
        "projects_add_module_tooltip":
            MessageLookupByLibrary.simpleMessage("New module"),
        "projects_module_help_text":
            MessageLookupByLibrary.simpleMessage("Help"),
        "projects_module_tasks_add_task_tooltip":
            MessageLookupByLibrary.simpleMessage("Add a new task"),
        "projects_module_tasks_completed": m5,
        "projects_module_tasks_task_add_subtask_tooltip":
            MessageLookupByLibrary.simpleMessage("Add a subtask"),
        "projects_module_tasks_task_title_hint":
            MessageLookupByLibrary.simpleMessage("Title"),
        "projects_module_tasks_title":
            MessageLookupByLibrary.simpleMessage("Tasks"),
        "projects_save_project_button_tooltip":
            MessageLookupByLibrary.simpleMessage("Save"),
        "settings_accessibility_title":
            MessageLookupByLibrary.simpleMessage("Accessibility"),
        "settings_account_title":
            MessageLookupByLibrary.simpleMessage("My account"),
        "settings_language_subtitle":
            MessageLookupByLibrary.simpleMessage("Language"),
        "settings_personalize_black_and_white_title":
            MessageLookupByLibrary.simpleMessage("Black and white mode"),
        "settings_personalize_title":
            MessageLookupByLibrary.simpleMessage("Personalize"),
        "settings_project_delete_button":
            MessageLookupByLibrary.simpleMessage("Delete this project"),
        "settings_project_delete_subtitle":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "settings_project_rename_button":
            MessageLookupByLibrary.simpleMessage("Rename"),
        "settings_project_rename_subtitle":
            MessageLookupByLibrary.simpleMessage("Rename"),
        "settings_reset_button":
            MessageLookupByLibrary.simpleMessage("Reset settings"),
        "settings_reset_subtitle":
            MessageLookupByLibrary.simpleMessage("Reset"),
        "settings_security_title":
            MessageLookupByLibrary.simpleMessage("Security"),
        "settings_theme_subtitle":
            MessageLookupByLibrary.simpleMessage("Theme"),
        "settings_title": MessageLookupByLibrary.simpleMessage("Settings"),
        "settings_username_subtitle":
            MessageLookupByLibrary.simpleMessage("First name"),
        "settings_using_dark_mode":
            MessageLookupByLibrary.simpleMessage("Dark mode"),
        "settings_using_light_mode":
            MessageLookupByLibrary.simpleMessage("Light mode"),
        "settings_using_system_theme":
            MessageLookupByLibrary.simpleMessage("Device theme"),
        "snacbar_close_button": MessageLookupByLibrary.simpleMessage("Close"),
        "snackbar_articles_saved":
            MessageLookupByLibrary.simpleMessage("This article has been save"),
        "snackbar_articles_unsaved": MessageLookupByLibrary.simpleMessage(
            "This article has been unsaved"),
        "snackbar_cancel_button": MessageLookupByLibrary.simpleMessage("Close"),
        "snackbar_delete_button":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "snackbar_delete_element_text": m6,
        "snackbar_reset_button": MessageLookupByLibrary.simpleMessage("Reset"),
        "snackbar_reset_text":
            MessageLookupByLibrary.simpleMessage("Reset settings ?"),
        "snackbar_restart_button":
            MessageLookupByLibrary.simpleMessage("Close app"),
        "snackbar_restart_needed_text": MessageLookupByLibrary.simpleMessage(
            "You will need to restart the app to apply changes"),
        "snackbar_welcome_back_button":
            MessageLookupByLibrary.simpleMessage("Thank\'s"),
        "snackbar_welcome_back_text": m7,
        "submenu_artilces_image_description_button":
            MessageLookupByLibrary.simpleMessage("Validate"),
        "submenu_artilces_image_description_hint":
            MessageLookupByLibrary.simpleMessage(
                "Write the image description..."),
        "submenu_artilces_image_description_subtitle":
            MessageLookupByLibrary.simpleMessage("Image description"),
        "submenu_artilces_image_description_title":
            MessageLookupByLibrary.simpleMessage("Description"),
        "submenu_new_project_button":
            MessageLookupByLibrary.simpleMessage("Create"),
        "submenu_new_project_errorMessage":
            MessageLookupByLibrary.simpleMessage(
                "Please, provide a project name"),
        "submenu_new_project_hint": MessageLookupByLibrary.simpleMessage(
            "Enter the project\'s name..."),
        "submenu_new_project_subtitle":
            MessageLookupByLibrary.simpleMessage("Project\'s name"),
        "submenu_new_project_title":
            MessageLookupByLibrary.simpleMessage("New project"),
        "submenu_unlock_content_title":
            MessageLookupByLibrary.simpleMessage("Unlock"),
        "submenu_unlock_error_message_error_login":
            MessageLookupByLibrary.simpleMessage("Unable to verify password."),
        "submenu_unlock_error_message_incorrect_password":
            MessageLookupByLibrary.simpleMessage("Incorect password"),
        "submenu_unlock_error_message_please_enter_password":
            MessageLookupByLibrary.simpleMessage("Please, enter your password"),
        "submenu_unlock_hide_mnemonic":
            MessageLookupByLibrary.simpleMessage("Hide the password hint"),
        "submenu_unlock_show_mnemonic":
            MessageLookupByLibrary.simpleMessage("Show the password hint"),
        "submenu_unlock_subtitle_text":
            MessageLookupByLibrary.simpleMessage("Enter your password"),
        "submenu_welcome_password_mnemonic_sentence_hint":
            MessageLookupByLibrary.simpleMessage("Enter your password hint"),
        "submenu_welcome_password_mnemonic_sentence_instructs":
            MessageLookupByLibrary.simpleMessage(
                "This feature assists you in recalling your password if you forget it. It is not recommended to enter your password directly; please provide a hint instead."),
        "submenu_welcome_password_mnemonic_sentence_subtitle":
            MessageLookupByLibrary.simpleMessage("Add a password hint"),
        "submenu_welcome_password_mnemonic_sentence_title":
            MessageLookupByLibrary.simpleMessage("Password hint"),
        "system_files_copy_text": MessageLookupByLibrary.simpleMessage("Copy"),
        "tool_pomodoro_break_duration":
            MessageLookupByLibrary.simpleMessage("Break session duration"),
        "tool_pomodoro_break_session":
            MessageLookupByLibrary.simpleMessage("Break"),
        "tool_pomodoro_focus_timer":
            MessageLookupByLibrary.simpleMessage("Focus timer"),
        "tool_pomodoro_repetition_count":
            MessageLookupByLibrary.simpleMessage("Repetition count"),
        "tool_pomodoro_start_button":
            MessageLookupByLibrary.simpleMessage("Start"),
        "tool_pomodoro_stop_button":
            MessageLookupByLibrary.simpleMessage("Stop"),
        "tool_pomodoro_work_duration":
            MessageLookupByLibrary.simpleMessage("Work session duration"),
        "tool_pomodoro_work_session":
            MessageLookupByLibrary.simpleMessage("Work"),
        "welcome_appbar": MessageLookupByLibrary.simpleMessage("Welcome"),
        "welcome_because": MessageLookupByLibrary.simpleMessage(
            "To personalize your experience"),
        "welcome_before_creating": MessageLookupByLibrary.simpleMessage(
            "First of all, please enter your first name"),
        "welcome_enter_name":
            MessageLookupByLibrary.simpleMessage("Enter your first name"),
        "welcome_error_save_username": MessageLookupByLibrary.simpleMessage(
            "An error occured while saving your name. Please try again"),
        "welcome_first_name_too_long": MessageLookupByLibrary.simpleMessage(
            "The first name cannot be longer than 25 letters"),
        "welcome_next_page_semantic":
            MessageLookupByLibrary.simpleMessage("Next page"),
        "welcome_pass_default_username":
            MessageLookupByLibrary.simpleMessage("User"),
        "welcome_pass_tooltip": m8,
        "welcome_pass_username": MessageLookupByLibrary.simpleMessage("Skip"),
        "welcome_password_creation_confirm_hint":
            MessageLookupByLibrary.simpleMessage("Confirm your password"),
        "welcome_password_creation_description":
            MessageLookupByLibrary.simpleMessage("To keep your data secured"),
        "welcome_password_creation_error_must_provide":
            MessageLookupByLibrary.simpleMessage("Please, create a password"),
        "welcome_password_creation_error_not_match":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "welcome_password_creation_error_password_save":
            MessageLookupByLibrary.simpleMessage(
                "An error occured while saving your password"),
        "welcome_password_creation_hide_semantic":
            MessageLookupByLibrary.simpleMessage("Hide password"),
        "welcome_password_creation_hint":
            MessageLookupByLibrary.simpleMessage("Create your password"),
        "welcome_password_creation_password_requirements":
            MessageLookupByLibrary.simpleMessage(
                "Password must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, and one digit."),
        "welcome_password_creation_remember":
            MessageLookupByLibrary.simpleMessage(
                "Add a password hint (optional)"),
        "welcome_password_creation_show_semantic":
            MessageLookupByLibrary.simpleMessage("Show password"),
        "welcome_password_creation_title":
            MessageLookupByLibrary.simpleMessage("Now, create a password"),
        "welcome_should_provide": MessageLookupByLibrary.simpleMessage(
            "Please, provide your first name")
      };
}
