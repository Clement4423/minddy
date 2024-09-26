// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
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
  String get localeName => 'en_US';

  static String m0(count) =>
      "${count} images found. Do you want to import them ?";

  static String m1(actionName) =>
      "No notes yet ! Click \'${actionName}\' on any article element to start taking some.";

  static String m2(username) => "Good afternoon ${username}";

  static String m3(username) => "Good evening ${username}";

  static String m4(username) => "Good morning ${username}";

  static String m5(length) =>
      "${Intl.plural(length, one: 'Input', other: 'Inputs')}";

  static String m6(length) =>
      "${Intl.plural(length, one: 'Output', other: 'Outputs')}";

  static String m7(length) =>
      "${Intl.plural(length, one: 'Copy selected node (⌘ + c)', other: 'Copy selected nodes (⌘ + c)')}";

  static String m8(length) =>
      "${Intl.plural(length, one: 'Copy selected node (ctrl + c)', other: 'Copy selected nodes (ctrl + c)')}";

  static String m9(length) =>
      "${Intl.plural(length, one: 'Delete selected node (⌘ + ⌫)', other: 'Delete selected nodes (⌘ + ⌫)')}";

  static String m10(length) =>
      "${Intl.plural(length, one: 'Delete selected node (ctrl + ⌫)', other: 'Delete selected nodes (ctrl + ⌫)')}";

  static String m11(length) =>
      "${Intl.plural(length, one: 'Duplicate selected node (⌘ + d)', other: 'Duplicate selected nodes (⌘ + d)')}";

  static String m12(length) =>
      "${Intl.plural(length, one: 'Duplicate selected node (ctrl + d)', other: 'Duplicate selected nodes (ctrl + d)')}";

  static String m13(length) =>
      "${Intl.plural(length, one: 'Paste copied node (⌘ + v)', other: 'Paste copied nodes (⌘ + v)')}";

  static String m14(length) =>
      "${Intl.plural(length, one: 'Paste copied node (ctrl + v)', other: 'Paste copied nodes (ctrl + v)')}";

  static String m15(totalNotesCount) =>
      "${Intl.plural(totalNotesCount, zero: 'No note', one: '1 note', other: '${totalNotesCount} notes')}";

  static String m16(optionName) =>
      "Two options can\'t have the same name (${optionName})";

  static String m17(totalTasksCount, checkedTasks) =>
      "${Intl.plural(totalTasksCount, zero: 'No tasks', one: '${checkedTasks}/${totalTasksCount} task completed', other: '${checkedTasks}/${totalTasksCount} tasks completed')}";

  static String m18(websiteName) => "Open ${websiteName}";

  static String m19(actualMonth, actualDay) =>
      "This option will put the month before the day. Like this : ${actualMonth}/${actualDay}";

  static String m20(element) => "Delete ${element} ?";

  static String m21(user) => "Welcome back ${user}";

  static String m22(duration) =>
      "${Intl.plural(duration, zero: 'Pomodoro - It\'s time for a break', one: 'Pomodoro - It\'s time for a break for ${duration} minute', other: 'Pomodoro - It\'s time for a break for ${duration} minutes')}";

  static String m23(duration) =>
      "Pomodoro session is over, you worked ${Intl.plural(duration, one: '1 minute', other: '${duration} minutes')}. Time to take a rest !";

  static String m24(duration) =>
      "${Intl.plural(duration, zero: 'Pomodoro - It\'s time to get back to work', one: 'Pomodoro - It\'s time to get back to work for ${duration} minute', other: 'Pomodoro - It\'s time to get back to work for ${duration} minutes')}";

  static String m25(accountSettingName) =>
      "You will still be able to enter your first name in settings / ${accountSettingName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "app_name": MessageLookupByLibrary.simpleMessage("minddy"),
        "app_slogan":
            MessageLookupByLibrary.simpleMessage("Everything happens here."),
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
            "No articles for this category yet, import, or write one !"),
        "articles_empty_menu_saved_page_text":
            MessageLookupByLibrary.simpleMessage("No saved article yet"),
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
        "custom_chart_donut_share":
            MessageLookupByLibrary.simpleMessage("Share"),
        "custom_chart_donut_total":
            MessageLookupByLibrary.simpleMessage("Total"),
        "custom_chart_empty_content": MessageLookupByLibrary.simpleMessage(
            "To create a chart, please add data to it"),
        "custom_chart_grid_extend_chart":
            MessageLookupByLibrary.simpleMessage("Enlarge chart"),
        "custom_date_picker_end": MessageLookupByLibrary.simpleMessage("End"),
        "custom_date_picker_include_hour":
            MessageLookupByLibrary.simpleMessage("Include hour"),
        "custom_date_picker_invalid_date":
            MessageLookupByLibrary.simpleMessage("Invalid date"),
        "custom_date_picker_select_multiples_date_title":
            MessageLookupByLibrary.simpleMessage("Select dates"),
        "custom_date_picker_select_single_date_title":
            MessageLookupByLibrary.simpleMessage("Select a date"),
        "custom_date_picker_start":
            MessageLookupByLibrary.simpleMessage("Start"),
        "default_app_colors_change_color":
            MessageLookupByLibrary.simpleMessage("Change color"),
        "default_app_colors_grey": MessageLookupByLibrary.simpleMessage("Grey"),
        "default_app_colors_lavender":
            MessageLookupByLibrary.simpleMessage("Lavender"),
        "default_app_colors_light_blue":
            MessageLookupByLibrary.simpleMessage("Light Blue"),
        "default_app_colors_light_green":
            MessageLookupByLibrary.simpleMessage("Light Green"),
        "default_app_colors_light_pink":
            MessageLookupByLibrary.simpleMessage("Light Pink"),
        "default_app_colors_light_purple":
            MessageLookupByLibrary.simpleMessage("Light Purple"),
        "default_app_colors_light_yellow":
            MessageLookupByLibrary.simpleMessage("Light Yellow"),
        "default_app_colors_mint_green":
            MessageLookupByLibrary.simpleMessage("Mint Green"),
        "default_app_colors_peach":
            MessageLookupByLibrary.simpleMessage("Peach"),
        "default_app_colors_soft_red":
            MessageLookupByLibrary.simpleMessage("Soft Red"),
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
        "node_editor_add_sub_menu_add_button":
            MessageLookupByLibrary.simpleMessage("Add"),
        "node_editor_add_sub_menu_inputs_subtitle": m5,
        "node_editor_add_sub_menu_no_nodes_found":
            MessageLookupByLibrary.simpleMessage("No nodes found."),
        "node_editor_add_sub_menu_note": MessageLookupByLibrary.simpleMessage(
            "Note: Inputs and outputs may vary depending on the options chosen for the node"),
        "node_editor_add_sub_menu_outputs_subtitle": m6,
        "node_editor_add_sub_menu_types":
            MessageLookupByLibrary.simpleMessage("Types"),
        "node_editor_view_bottom_toolbar_copy_tooltip_mac": m7,
        "node_editor_view_bottom_toolbar_copy_tooltip_windows": m8,
        "node_editor_view_bottom_toolbar_delete_tooltip_mac": m9,
        "node_editor_view_bottom_toolbar_delete_tooltip_windows": m10,
        "node_editor_view_bottom_toolbar_duplicate_tooltip_mac": m11,
        "node_editor_view_bottom_toolbar_duplicate_tooltip_windows": m12,
        "node_editor_view_bottom_toolbar_paste_tooltip_mac": m13,
        "node_editor_view_bottom_toolbar_paste_tooltip_windows": m14,
        "node_editor_view_bottom_toolbar_redo_tooltip_mac":
            MessageLookupByLibrary.simpleMessage("Redo (⇧ + ⌘ + z)"),
        "node_editor_view_bottom_toolbar_redo_tooltip_windows":
            MessageLookupByLibrary.simpleMessage("Redo (⇧ + ctrl + z)"),
        "node_editor_view_bottom_toolbar_undo_tooltip_mac":
            MessageLookupByLibrary.simpleMessage("Undo (⌘ + z)"),
        "node_editor_view_bottom_toolbar_undo_tooltip_windows":
            MessageLookupByLibrary.simpleMessage("Undo (ctrl + z)"),
        "node_editor_view_close_node_panel_tooltip":
            MessageLookupByLibrary.simpleMessage("Close node panel"),
        "node_editor_view_close_side_panel_tooltip":
            MessageLookupByLibrary.simpleMessage("Close side panel"),
        "node_editor_view_new_node_tooltip":
            MessageLookupByLibrary.simpleMessage("New node"),
        "node_editor_view_open_node_panel_tooltip":
            MessageLookupByLibrary.simpleMessage("Open node panel"),
        "node_editor_view_open_side_panel_tooltip":
            MessageLookupByLibrary.simpleMessage("Open side panel"),
        "node_editor_view_side_panel_node_trees_add_button_tooltip":
            MessageLookupByLibrary.simpleMessage("New node tree"),
        "node_editor_view_side_panel_node_trees_title":
            MessageLookupByLibrary.simpleMessage("Node trees"),
        "node_editor_view_side_panel_variables_add_button_tooltip":
            MessageLookupByLibrary.simpleMessage("New variable"),
        "node_editor_view_side_panel_variables_title":
            MessageLookupByLibrary.simpleMessage("Variables"),
        "node_editor_view_side_panel_variables_variable_type_boolean":
            MessageLookupByLibrary.simpleMessage("Boolean"),
        "node_editor_view_side_panel_variables_variable_type_color":
            MessageLookupByLibrary.simpleMessage("Color"),
        "node_editor_view_side_panel_variables_variable_type_list":
            MessageLookupByLibrary.simpleMessage("List"),
        "node_editor_view_side_panel_variables_variable_type_number":
            MessageLookupByLibrary.simpleMessage("Number"),
        "node_editor_view_side_panel_variables_variable_type_text":
            MessageLookupByLibrary.simpleMessage("Text"),
        "node_widgets_boolean_node_options_and":
            MessageLookupByLibrary.simpleMessage("And"),
        "node_widgets_boolean_node_options_equal":
            MessageLookupByLibrary.simpleMessage("Equal"),
        "node_widgets_boolean_node_options_imply":
            MessageLookupByLibrary.simpleMessage("Imply"),
        "node_widgets_boolean_node_options_not":
            MessageLookupByLibrary.simpleMessage("Not"),
        "node_widgets_boolean_node_options_notAnd":
            MessageLookupByLibrary.simpleMessage("Not And"),
        "node_widgets_boolean_node_options_notEqual":
            MessageLookupByLibrary.simpleMessage("Not Equal"),
        "node_widgets_boolean_node_options_notOr":
            MessageLookupByLibrary.simpleMessage("Not Or"),
        "node_widgets_boolean_node_options_or":
            MessageLookupByLibrary.simpleMessage("Or"),
        "node_widgets_boolean_node_options_subtract":
            MessageLookupByLibrary.simpleMessage("Subtract"),
        "node_widgets_boolean_node_title":
            MessageLookupByLibrary.simpleMessage("Logic Operations"),
        "node_widgets_comparison_node_options_equal":
            MessageLookupByLibrary.simpleMessage("Equal to"),
        "node_widgets_comparison_node_options_greatherThan":
            MessageLookupByLibrary.simpleMessage("Greater than"),
        "node_widgets_comparison_node_options_greatherThanOrEqual":
            MessageLookupByLibrary.simpleMessage("Greater than or equal to"),
        "node_widgets_comparison_node_options_lessThan":
            MessageLookupByLibrary.simpleMessage("Less than"),
        "node_widgets_comparison_node_options_lessThanOrEqual":
            MessageLookupByLibrary.simpleMessage("Less than or equal to"),
        "node_widgets_comparison_node_title":
            MessageLookupByLibrary.simpleMessage("Comparison"),
        "node_widgets_math_node_options_abs":
            MessageLookupByLibrary.simpleMessage("Absolute Value"),
        "node_widgets_math_node_options_acos":
            MessageLookupByLibrary.simpleMessage("Arccosine"),
        "node_widgets_math_node_options_acosh":
            MessageLookupByLibrary.simpleMessage("Inverse Hyperbolic Cosine"),
        "node_widgets_math_node_options_addition":
            MessageLookupByLibrary.simpleMessage("Addition"),
        "node_widgets_math_node_options_asin":
            MessageLookupByLibrary.simpleMessage("Arcsine"),
        "node_widgets_math_node_options_asinh":
            MessageLookupByLibrary.simpleMessage("Inverse Hyperbolic Sine"),
        "node_widgets_math_node_options_atan":
            MessageLookupByLibrary.simpleMessage("Arctangent"),
        "node_widgets_math_node_options_atanh":
            MessageLookupByLibrary.simpleMessage("Inverse Hyperbolic Tangent"),
        "node_widgets_math_node_options_ceil":
            MessageLookupByLibrary.simpleMessage("Ceil"),
        "node_widgets_math_node_options_cos":
            MessageLookupByLibrary.simpleMessage("Cosine"),
        "node_widgets_math_node_options_cosh":
            MessageLookupByLibrary.simpleMessage("Hyperbolic Cosine"),
        "node_widgets_math_node_options_division":
            MessageLookupByLibrary.simpleMessage("Division"),
        "node_widgets_math_node_options_floor":
            MessageLookupByLibrary.simpleMessage("Floor"),
        "node_widgets_math_node_options_ln":
            MessageLookupByLibrary.simpleMessage("Natural Logarithm"),
        "node_widgets_math_node_options_log10":
            MessageLookupByLibrary.simpleMessage("Logarithm Base 10"),
        "node_widgets_math_node_options_max":
            MessageLookupByLibrary.simpleMessage("Max"),
        "node_widgets_math_node_options_min":
            MessageLookupByLibrary.simpleMessage("Min"),
        "node_widgets_math_node_options_multiplication":
            MessageLookupByLibrary.simpleMessage("Multiplication"),
        "node_widgets_math_node_options_power":
            MessageLookupByLibrary.simpleMessage("Power"),
        "node_widgets_math_node_options_round":
            MessageLookupByLibrary.simpleMessage("Round"),
        "node_widgets_math_node_options_sign":
            MessageLookupByLibrary.simpleMessage("Sign"),
        "node_widgets_math_node_options_sin":
            MessageLookupByLibrary.simpleMessage("Sine"),
        "node_widgets_math_node_options_sinh":
            MessageLookupByLibrary.simpleMessage("Hyperbolic Sine"),
        "node_widgets_math_node_options_squareRoot":
            MessageLookupByLibrary.simpleMessage("Square Root"),
        "node_widgets_math_node_options_substraction":
            MessageLookupByLibrary.simpleMessage("Substraction"),
        "node_widgets_math_node_options_tan":
            MessageLookupByLibrary.simpleMessage("Tangent"),
        "node_widgets_math_node_options_tanh":
            MessageLookupByLibrary.simpleMessage("Hyperbolic Tangent"),
        "node_widgets_math_node_options_truncate":
            MessageLookupByLibrary.simpleMessage("Truncate"),
        "node_widgets_math_node_title":
            MessageLookupByLibrary.simpleMessage("Calculations"),
        "node_widgets_treshold_text":
            MessageLookupByLibrary.simpleMessage("Treshold"),
        "node_widgets_value_text":
            MessageLookupByLibrary.simpleMessage("Value"),
        "project_card_delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "project_card_duplicate":
            MessageLookupByLibrary.simpleMessage("Duplicate"),
        "project_card_open_settings":
            MessageLookupByLibrary.simpleMessage("Modify"),
        "projects_add_module_tooltip":
            MessageLookupByLibrary.simpleMessage("New module"),
        "projects_module_help_text":
            MessageLookupByLibrary.simpleMessage("Help"),
        "projects_module_notes_category_note_count": m15,
        "projects_module_notes_editing_note_sub_menu_move_tooltip":
            MessageLookupByLibrary.simpleMessage("Move"),
        "projects_module_notes_editing_note_sub_menu_save_tooltip":
            MessageLookupByLibrary.simpleMessage("Save note"),
        "projects_module_notes_for_later_title":
            MessageLookupByLibrary.simpleMessage("Notes for later"),
        "projects_module_notes_important_notes_title":
            MessageLookupByLibrary.simpleMessage("Important notes"),
        "projects_module_notes_modify_category":
            MessageLookupByLibrary.simpleMessage("Modify"),
        "projects_module_notes_modify_category_sub_menu_title":
            MessageLookupByLibrary.simpleMessage("Modify category"),
        "projects_module_notes_modify_note_tooltip":
            MessageLookupByLibrary.simpleMessage("Modify this note"),
        "projects_module_notes_new_category_sub_menu_error_message":
            MessageLookupByLibrary.simpleMessage("Please, name the category"),
        "projects_module_notes_new_category_sub_menu_is_private":
            MessageLookupByLibrary.simpleMessage("Private category"),
        "projects_module_notes_new_category_sub_menu_is_private_tooltip":
            MessageLookupByLibrary.simpleMessage(
                "By enabling this option, your password will be required to open this category."),
        "projects_module_notes_new_category_sub_menu_name_hint":
            MessageLookupByLibrary.simpleMessage("Enter the category name"),
        "projects_module_notes_new_category_sub_menu_subtitle":
            MessageLookupByLibrary.simpleMessage("Category name"),
        "projects_module_notes_new_category_sub_menu_title":
            MessageLookupByLibrary.simpleMessage("New category"),
        "projects_module_notes_new_category_tooltip":
            MessageLookupByLibrary.simpleMessage("New category"),
        "projects_module_notes_new_note_tooltip":
            MessageLookupByLibrary.simpleMessage("New note"),
        "projects_module_notes_private_notes_title":
            MessageLookupByLibrary.simpleMessage("Privates notes"),
        "projects_module_notes_project_notes_title":
            MessageLookupByLibrary.simpleMessage("Project notes"),
        "projects_module_notes_title":
            MessageLookupByLibrary.simpleMessage("Notes"),
        "projects_module_spreadsheet_chart_chart_column_plural":
            MessageLookupByLibrary.simpleMessage("Columns"),
        "projects_module_spreadsheet_chart_chart_column_single":
            MessageLookupByLibrary.simpleMessage("Column"),
        "projects_module_spreadsheet_chart_chart_select_column":
            MessageLookupByLibrary.simpleMessage("Select a column"),
        "projects_module_spreadsheet_chart_chart_type_bar":
            MessageLookupByLibrary.simpleMessage("Bar"),
        "projects_module_spreadsheet_chart_chart_type_bar_grouped":
            MessageLookupByLibrary.simpleMessage("Grouped bars"),
        "projects_module_spreadsheet_chart_chart_type_bar_simple":
            MessageLookupByLibrary.simpleMessage("Simple bars"),
        "projects_module_spreadsheet_chart_chart_type_bar_stacked":
            MessageLookupByLibrary.simpleMessage("Stacked bars"),
        "projects_module_spreadsheet_chart_chart_type_donut":
            MessageLookupByLibrary.simpleMessage("Donut"),
        "projects_module_spreadsheet_chart_chart_type_subtitle":
            MessageLookupByLibrary.simpleMessage("Chart type"),
        "projects_module_spreadsheet_chart_new_column":
            MessageLookupByLibrary.simpleMessage("Add a coulumn"),
        "projects_module_spreadsheet_chart_new_tab":
            MessageLookupByLibrary.simpleMessage("New tab"),
        "projects_module_spreadsheet_chart_show_chart":
            MessageLookupByLibrary.simpleMessage("Show the charts"),
        "projects_module_spreadsheet_chart_show_table":
            MessageLookupByLibrary.simpleMessage("Show the table"),
        "projects_module_spreadsheet_data_choose_column_type_tooltip":
            MessageLookupByLibrary.simpleMessage("Choose a column type"),
        "projects_module_spreadsheet_data_column_type":
            MessageLookupByLibrary.simpleMessage("Column type"),
        "projects_module_spreadsheet_data_type_date":
            MessageLookupByLibrary.simpleMessage("Date"),
        "projects_module_spreadsheet_data_type_email":
            MessageLookupByLibrary.simpleMessage("E-mail"),
        "projects_module_spreadsheet_data_type_number":
            MessageLookupByLibrary.simpleMessage("Number"),
        "projects_module_spreadsheet_data_type_phone_number":
            MessageLookupByLibrary.simpleMessage("Phone number"),
        "projects_module_spreadsheet_data_type_selection":
            MessageLookupByLibrary.simpleMessage("Selection"),
        "projects_module_spreadsheet_data_type_text":
            MessageLookupByLibrary.simpleMessage("Text"),
        "projects_module_spreadsheet_data_type_url":
            MessageLookupByLibrary.simpleMessage("URL"),
        "projects_module_spreadsheet_date_from_text":
            MessageLookupByLibrary.simpleMessage("From"),
        "projects_module_spreadsheet_date_single_tooltip":
            MessageLookupByLibrary.simpleMessage("Single date"),
        "projects_module_spreadsheet_date_start_end_tooltip":
            MessageLookupByLibrary.simpleMessage("Add an end date"),
        "projects_module_spreadsheet_date_to_text":
            MessageLookupByLibrary.simpleMessage("To"),
        "projects_module_spreadsheet_delete_column":
            MessageLookupByLibrary.simpleMessage("Delete this column"),
        "projects_module_spreadsheet_delete_row":
            MessageLookupByLibrary.simpleMessage("Delete this row"),
        "projects_module_spreadsheet_extend_cell_tooltip":
            MessageLookupByLibrary.simpleMessage("Extend this cell"),
        "projects_module_spreadsheet_manage_columns_sub_menu_subtitle":
            MessageLookupByLibrary.simpleMessage("All columns"),
        "projects_module_spreadsheet_manage_columns_sub_menu_title":
            MessageLookupByLibrary.simpleMessage("Organize columns"),
        "projects_module_spreadsheet_manage_rows_sub_menu_subtitle":
            MessageLookupByLibrary.simpleMessage("All rows"),
        "projects_module_spreadsheet_manage_rows_sub_menu_title":
            MessageLookupByLibrary.simpleMessage("Organize rows"),
        "projects_module_spreadsheet_new_column":
            MessageLookupByLibrary.simpleMessage("New column"),
        "projects_module_spreadsheet_new_row":
            MessageLookupByLibrary.simpleMessage("New row"),
        "projects_module_spreadsheet_number_operation_average":
            MessageLookupByLibrary.simpleMessage("Average"),
        "projects_module_spreadsheet_number_operation_average_example":
            MessageLookupByLibrary.simpleMessage("(10 + 50 + 100) / 3"),
        "projects_module_spreadsheet_number_operation_average_message":
            MessageLookupByLibrary.simpleMessage(
                "Calculates the average by dividing the sum of all values by the number of values. This helps in finding the central value of the data."),
        "projects_module_spreadsheet_number_operation_calculate":
            MessageLookupByLibrary.simpleMessage("Calculate"),
        "projects_module_spreadsheet_number_operation_interval":
            MessageLookupByLibrary.simpleMessage("Interval"),
        "projects_module_spreadsheet_number_operation_interval_example":
            MessageLookupByLibrary.simpleMessage("(10, 50, 100) = 90"),
        "projects_module_spreadsheet_number_operation_interval_message":
            MessageLookupByLibrary.simpleMessage(
                "Calculates the range by subtracting the smallest value from the largest value in the column. It shows the spread of the values."),
        "projects_module_spreadsheet_number_operation_maximum":
            MessageLookupByLibrary.simpleMessage("Maximum"),
        "projects_module_spreadsheet_number_operation_maximum_example":
            MessageLookupByLibrary.simpleMessage("(10, 50, 100) = 100"),
        "projects_module_spreadsheet_number_operation_maximum_message":
            MessageLookupByLibrary.simpleMessage(
                "Finds the highest value in the column. Useful for identifying the largest number."),
        "projects_module_spreadsheet_number_operation_median":
            MessageLookupByLibrary.simpleMessage("Median"),
        "projects_module_spreadsheet_number_operation_median_example":
            MessageLookupByLibrary.simpleMessage("(10, 50, 100) = 50"),
        "projects_module_spreadsheet_number_operation_median_message":
            MessageLookupByLibrary.simpleMessage(
                "Finds the middle value when the column values are sorted. Useful for identifying the central value."),
        "projects_module_spreadsheet_number_operation_minimum":
            MessageLookupByLibrary.simpleMessage("Minimum"),
        "projects_module_spreadsheet_number_operation_minimum_example":
            MessageLookupByLibrary.simpleMessage("(10, 50, 100) = 10"),
        "projects_module_spreadsheet_number_operation_minimum_message":
            MessageLookupByLibrary.simpleMessage(
                "Finds the lowest value in the column. This helps in identifying the smallest number."),
        "projects_module_spreadsheet_number_operation_none":
            MessageLookupByLibrary.simpleMessage("None"),
        "projects_module_spreadsheet_number_operation_standardDeviation_example":
            MessageLookupByLibrary.simpleMessage(
                "√[((10-53.33)² + (50-53.33)² + (100-53.33)²) / 3]"),
        "projects_module_spreadsheet_number_operation_standardDeviation_message":
            MessageLookupByLibrary.simpleMessage(
                "Calculates the standard deviation to measure how much the values vary from the average. Here, 53.33 is the mean of the values 10, 50, and 100."),
        "projects_module_spreadsheet_number_operation_standard_deviation":
            MessageLookupByLibrary.simpleMessage("Standard deviation"),
        "projects_module_spreadsheet_number_operation_sum":
            MessageLookupByLibrary.simpleMessage("Sum"),
        "projects_module_spreadsheet_number_operation_sum_example":
            MessageLookupByLibrary.simpleMessage("10 + 50 + 100"),
        "projects_module_spreadsheet_number_operation_sum_message":
            MessageLookupByLibrary.simpleMessage(
                "Adds up all the values in the column to get the total. Useful for summing up data."),
        "projects_module_spreadsheet_selection_cell_add_an_option":
            MessageLookupByLibrary.simpleMessage("Add an option"),
        "projects_module_spreadsheet_selection_cell_add_options":
            MessageLookupByLibrary.simpleMessage("Add options"),
        "projects_module_spreadsheet_selection_cell_all_options":
            MessageLookupByLibrary.simpleMessage("All options"),
        "projects_module_spreadsheet_selection_cell_finished":
            MessageLookupByLibrary.simpleMessage("Finished"),
        "projects_module_spreadsheet_selection_cell_modify_options":
            MessageLookupByLibrary.simpleMessage("Modify options"),
        "projects_module_spreadsheet_selection_cell_name_option_hint":
            MessageLookupByLibrary.simpleMessage("Name this option..."),
        "projects_module_spreadsheet_selection_cell_not_started":
            MessageLookupByLibrary.simpleMessage("Not started"),
        "projects_module_spreadsheet_selection_cell_started":
            MessageLookupByLibrary.simpleMessage("Started"),
        "projects_module_spreadsheet_selection_sub_menu_error_message_no_options":
            MessageLookupByLibrary.simpleMessage("Please, add options"),
        "projects_module_spreadsheet_selection_sub_menu_error_message_redundant_color":
            MessageLookupByLibrary.simpleMessage(
                "Two options can\'t have the same color"),
        "projects_module_spreadsheet_selection_sub_menu_error_message_redundant_option_name":
            m16,
        "projects_module_spreadsheet_selection_sub_menu_error_message_unnamed_option":
            MessageLookupByLibrary.simpleMessage("Please, name all options"),
        "projects_module_spreadsheet_title":
            MessageLookupByLibrary.simpleMessage("Spreadsheet"),
        "projects_module_spreadsheet_value_unnamed":
            MessageLookupByLibrary.simpleMessage("Unnamed"),
        "projects_module_tasks_add_task_tooltip":
            MessageLookupByLibrary.simpleMessage("Add a new task"),
        "projects_module_tasks_completed": m17,
        "projects_module_tasks_task_add_subtask_tooltip":
            MessageLookupByLibrary.simpleMessage("Add a subtask"),
        "projects_module_tasks_task_title_hint":
            MessageLookupByLibrary.simpleMessage("Title"),
        "projects_module_tasks_title":
            MessageLookupByLibrary.simpleMessage("Tasks"),
        "projects_next_page_shortcut_tooltip":
            MessageLookupByLibrary.simpleMessage("Next page (ctrl + ⭢)"),
        "projects_next_page_shortcut_tooltip_mac":
            MessageLookupByLibrary.simpleMessage("Next page (⌘ + ⭢)"),
        "projects_previous_page_shortcut_tooltip":
            MessageLookupByLibrary.simpleMessage("Previous page (ctrl + ⭠)"),
        "projects_previous_page_shortcut_tooltip_mac":
            MessageLookupByLibrary.simpleMessage("Previous page (⌘ + ⭠)"),
        "projects_save_project_button_tooltip":
            MessageLookupByLibrary.simpleMessage("Save"),
        "projetcs_module_spreadsheet_open_website": m18,
        "settings_accessibility_title":
            MessageLookupByLibrary.simpleMessage("Accessibility"),
        "settings_account_title":
            MessageLookupByLibrary.simpleMessage("My account"),
        "settings_date_format":
            MessageLookupByLibrary.simpleMessage("Prefer MM/dd date format"),
        "settings_date_format_subtitle":
            MessageLookupByLibrary.simpleMessage("Date format"),
        "settings_date_format_tooltip": m19,
        "settings_language_subtitle":
            MessageLookupByLibrary.simpleMessage("Language"),
        "settings_need_to_quit_project_to_change_language":
            MessageLookupByLibrary.simpleMessage(
                "To change language, please go back at home"),
        "settings_need_to_quit_project_to_change_theme":
            MessageLookupByLibrary.simpleMessage(
                "To change theme settings, please go back at home"),
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
        "snackbar_delete_element_text": m20,
        "snackbar_reset_button": MessageLookupByLibrary.simpleMessage("Reset"),
        "snackbar_reset_text":
            MessageLookupByLibrary.simpleMessage("Reset settings ?"),
        "snackbar_restart_button":
            MessageLookupByLibrary.simpleMessage("Close app"),
        "snackbar_restart_needed_text": MessageLookupByLibrary.simpleMessage(
            "You will need to restart the app to apply changes"),
        "snackbar_welcome_back_button":
            MessageLookupByLibrary.simpleMessage("Thank\'s"),
        "snackbar_welcome_back_text": m21,
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
        "tool_pomodoro_break_snackbar": m22,
        "tool_pomodoro_end_session": m23,
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
        "tool_pomodoro_work_snackbar": m24,
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
        "welcome_pass_tooltip": m25,
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
