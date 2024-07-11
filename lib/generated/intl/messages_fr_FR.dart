// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr_FR locale. All the
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
  String get localeName => 'fr_FR';

  static String m0(count) =>
      "${count} images trouvées. Voulez-vous les importer ?";

  static String m1(actionName) =>
      "Vous n\'avez aucune notes ! Cliquez sur \'${actionName}\' pour commencer à en prendre.";

  static String m2(username) => "Bon après-midi ${username}";

  static String m3(username) => "Bonsoir ${username}";

  static String m4(username) => "Bonjour ${username}";

  static String m5(totalNotesCount) =>
      "${Intl.plural(totalNotesCount, zero: 'Aucune note', one: '1 note', other: '${totalNotesCount} notes')}";

  static String m6(optionName) =>
      "Deux options ne peuvent pas avoir le même nom (${optionName})";

  static String m7(totalTasksCount, checkedTasks) =>
      "${Intl.plural(totalTasksCount, zero: 'Aucune tâche', one: '${checkedTasks}/${totalTasksCount} tâche terminée', other: '${checkedTasks}/${totalTasksCount} tâches terminées')}";

  static String m8(websiteName) => "Ouvrir ${websiteName}";

  static String m9(actualMonth, actualDay) =>
      "Cette option mettra le mois avant le jour. Comme ceci : ${actualMonth}/${actualDay}";

  static String m10(element) => "Supprimer ${element} ?";

  static String m11(user) => "Ravis de vous revoir ${user}";

  static String m12(accountSettingName) =>
      "Vous pourrez toujours saisir votre prénom dans paramètres / ${accountSettingName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appbar_go_home":
            MessageLookupByLibrary.simpleMessage("Retourner à l\'accueil"),
        "articles_add_code_semantic_text":
            MessageLookupByLibrary.simpleMessage("Ajouter un bloc de code"),
        "articles_add_image_semantic_text":
            MessageLookupByLibrary.simpleMessage("Ajouter une image"),
        "articles_add_list_semantic_text":
            MessageLookupByLibrary.simpleMessage("Ajouter une liste"),
        "articles_add_source_button":
            MessageLookupByLibrary.simpleMessage("Ajouter une source"),
        "articles_add_source_hint":
            MessageLookupByLibrary.simpleMessage("Indiquer une source..."),
        "articles_add_subtitle_semantic_text":
            MessageLookupByLibrary.simpleMessage("Ajouter un sous titre"),
        "articles_add_text_semantic_text":
            MessageLookupByLibrary.simpleMessage("Ajouter un bloc de texte"),
        "articles_add_to_content":
            MessageLookupByLibrary.simpleMessage("Ajouter à l\'article"),
        "articles_bookmark_semantic_text":
            MessageLookupByLibrary.simpleMessage("Enregister l\'article"),
        "articles_bottom_menu_close_semantic_text":
            MessageLookupByLibrary.simpleMessage("Fermer le menu"),
        "articles_bottom_menu_content_button":
            MessageLookupByLibrary.simpleMessage("Contenu"),
        "articles_bottom_menu_notes_button":
            MessageLookupByLibrary.simpleMessage("Notes"),
        "articles_bottom_menu_open_semantic_text":
            MessageLookupByLibrary.simpleMessage("Ouvrir le menu"),
        "articles_bottom_menu_sources_button":
            MessageLookupByLibrary.simpleMessage("Sources"),
        "articles_calculate_reading_time": MessageLookupByLibrary.simpleMessage(
            "Calculer le temps de lecture"),
        "articles_card_delete_this_article":
            MessageLookupByLibrary.simpleMessage("cet article"),
        "articles_card_untitled":
            MessageLookupByLibrary.simpleMessage("Sans titre"),
        "articles_code_hint":
            MessageLookupByLibrary.simpleMessage("Entrez du code..."),
        "articles_copy_text": MessageLookupByLibrary.simpleMessage("Copier"),
        "articles_copy_to_notes_text":
            MessageLookupByLibrary.simpleMessage("Ajouter aux notes"),
        "articles_corrupted_file":
            MessageLookupByLibrary.simpleMessage("Cet article est corrompu"),
        "articles_creativity_title":
            MessageLookupByLibrary.simpleMessage("Créativité"),
        "articles_daily_life_title":
            MessageLookupByLibrary.simpleMessage("Quotidien"),
        "articles_define_language":
            MessageLookupByLibrary.simpleMessage("Définir le language"),
        "articles_education_title":
            MessageLookupByLibrary.simpleMessage("Éducation"),
        "articles_empty_menu_page_text": MessageLookupByLibrary.simpleMessage(
            "C\'est vide pour l\'instant. Importez des articles ou écrivez les vôtres pour remplir l\'espace !"),
        "articles_environment_title":
            MessageLookupByLibrary.simpleMessage("Nature"),
        "articles_export_articles":
            MessageLookupByLibrary.simpleMessage("Exporter cet article"),
        "articles_export_articles_choose_category":
            MessageLookupByLibrary.simpleMessage("Choisissez une catégorie"),
        "articles_export_canceled": MessageLookupByLibrary.simpleMessage(
            "L\'article n\'a pas été exporté"),
        "articles_export_confirmed":
            MessageLookupByLibrary.simpleMessage("L\'article a été exporté"),
        "articles_export_confirmed_button":
            MessageLookupByLibrary.simpleMessage("Voir l\'emplacement"),
        "articles_finance_title":
            MessageLookupByLibrary.simpleMessage("Finance"),
        "articles_food_title":
            MessageLookupByLibrary.simpleMessage("Alimentation"),
        "articles_go_back_semantic_text":
            MessageLookupByLibrary.simpleMessage("Retour"),
        "articles_images_add_button":
            MessageLookupByLibrary.simpleMessage("Ajouter une image"),
        "articles_images_change_button":
            MessageLookupByLibrary.simpleMessage("Changer l\'image"),
        "articles_import_articles":
            MessageLookupByLibrary.simpleMessage("Importer des articles"),
        "articles_imported": MessageLookupByLibrary.simpleMessage(
            "Les articles ont été importés"),
        "articles_importer_dont_import_images_button":
            MessageLookupByLibrary.simpleMessage("Ne pas importer"),
        "articles_importer_image_found_single":
            MessageLookupByLibrary.simpleMessage(
                "1 image trouvée. Voulez-vous l\'importer ?"),
        "articles_importer_images_found_many": m0,
        "articles_importer_import_images_button":
            MessageLookupByLibrary.simpleMessage("Importer"),
        "articles_importer_import_images_title":
            MessageLookupByLibrary.simpleMessage("Importer des images"),
        "articles_impossible_to_load_content":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de charger le contenu de l\'article"),
        "articles_my_articles_title":
            MessageLookupByLibrary.simpleMessage("Mes articles"),
        "articles_new_article":
            MessageLookupByLibrary.simpleMessage("Nouvel article"),
        "articles_no_content": MessageLookupByLibrary.simpleMessage(
            "Cet article est vide ! Ajoutez des éléments pour pouvoir les déplacer."),
        "articles_no_notes": m1,
        "articles_no_sources": MessageLookupByLibrary.simpleMessage(
            "Aucune source n\'a été fournie pour le moment ! N\'oubliez pas d\'inclure des sources pour les futurs lecteurs."),
        "articles_not_imported": MessageLookupByLibrary.simpleMessage(
            "Les articles n\'ont pas été impotés"),
        "articles_philosophy_title":
            MessageLookupByLibrary.simpleMessage("Philosophie"),
        "articles_politics_title":
            MessageLookupByLibrary.simpleMessage("Politique"),
        "articles_professional_title":
            MessageLookupByLibrary.simpleMessage("Professionnel"),
        "articles_read_button": MessageLookupByLibrary.simpleMessage("Lire"),
        "articles_saved_title":
            MessageLookupByLibrary.simpleMessage("Enregistrés"),
        "articles_science_title":
            MessageLookupByLibrary.simpleMessage("Science"),
        "articles_search": MessageLookupByLibrary.simpleMessage("Rechercher"),
        "articles_search_empty":
            MessageLookupByLibrary.simpleMessage("Aucun résultat"),
        "articles_search_explain":
            MessageLookupByLibrary.simpleMessage("Recherchez un titre, auteur"),
        "articles_sources_text":
            MessageLookupByLibrary.simpleMessage("Sources"),
        "articles_subtitle_hint":
            MessageLookupByLibrary.simpleMessage("Entrez un sous titre..."),
        "articles_technology_title":
            MessageLookupByLibrary.simpleMessage("Technologie"),
        "articles_text_hint":
            MessageLookupByLibrary.simpleMessage("Entrez du texte..."),
        "articles_title_hint":
            MessageLookupByLibrary.simpleMessage("Entrez un titre..."),
        "articles_travel_title": MessageLookupByLibrary.simpleMessage("Voyage"),
        "articles_wellness_title":
            MessageLookupByLibrary.simpleMessage("Bien-être"),
        "center_menu_general": MessageLookupByLibrary.simpleMessage("Général"),
        "center_menu_others": MessageLookupByLibrary.simpleMessage("Autre"),
        "custom_date_picker_end": MessageLookupByLibrary.simpleMessage("Fin"),
        "custom_date_picker_invalid_date":
            MessageLookupByLibrary.simpleMessage("Date invalide"),
        "custom_date_picker_select_multiples_date_title":
            MessageLookupByLibrary.simpleMessage("Selectionnez des dates"),
        "custom_date_picker_select_single_date_title":
            MessageLookupByLibrary.simpleMessage("Selectionnez une date"),
        "custom_date_picker_start":
            MessageLookupByLibrary.simpleMessage("Début"),
        "default_app_colors_change_color":
            MessageLookupByLibrary.simpleMessage("Changer la couleur"),
        "default_app_colors_grey": MessageLookupByLibrary.simpleMessage("Gris"),
        "default_app_colors_lavender":
            MessageLookupByLibrary.simpleMessage("Lavande"),
        "default_app_colors_light_blue":
            MessageLookupByLibrary.simpleMessage("Bleu clair"),
        "default_app_colors_light_green":
            MessageLookupByLibrary.simpleMessage("Vert clair"),
        "default_app_colors_light_pink":
            MessageLookupByLibrary.simpleMessage("Rose clair"),
        "default_app_colors_light_purple":
            MessageLookupByLibrary.simpleMessage("Violet clair"),
        "default_app_colors_light_yellow":
            MessageLookupByLibrary.simpleMessage("Jaune clair"),
        "default_app_colors_mint_green":
            MessageLookupByLibrary.simpleMessage("Vert menthe"),
        "default_app_colors_peach":
            MessageLookupByLibrary.simpleMessage("Pêche"),
        "default_app_colors_soft_red":
            MessageLookupByLibrary.simpleMessage("Rouge doux"),
        "default_articles_articles_description":
            MessageLookupByLibrary.simpleMessage(
                "Découvrir les articles dans minddy"),
        "default_articles_articles_fifth_paragraph":
            MessageLookupByLibrary.simpleMessage(
                "Avec les articles, vous avez un outil puissant et convivial pour organiser, partager et retrouver vos connaissances en toute simplicité."),
        "default_articles_articles_fifth_subtitle":
            MessageLookupByLibrary.simpleMessage("Outil Puissant"),
        "default_articles_articles_first_paragraph":
            MessageLookupByLibrary.simpleMessage(
                "Les articles sont une fonctionnalité clé de Minddy. Ils offrent une interface élégante et intuitive pour rédiger et partager vos connaissances. Grâce à cette fonctionnalité, vous pouvez facilement diffuser votre savoir et en faire profiter toute la communauté."),
        "default_articles_articles_first_subtitle":
            MessageLookupByLibrary.simpleMessage("Fonctionnalité Clé"),
        "default_articles_articles_fourth_paragraph":
            MessageLookupByLibrary.simpleMessage(
                "Les boutons pour ajouter des éléments à votre article sont situés en haut de la page. Pour gérer ce contenu, utilisez le menu en bas."),
        "default_articles_articles_fourth_subtitle":
            MessageLookupByLibrary.simpleMessage("Ajouter et Gérer du Contenu"),
        "default_articles_articles_second_paragraph":
            MessageLookupByLibrary.simpleMessage(
                "Vous pouvez également prendre des notes, idéal pour sauvegarder des textes ou tout autre contenu que vous souhaitez conserver pour plus tard. Cette fonctionnalité est parfaite pour capturer des idées ou des informations importantes à revisiter ultérieurement."),
        "default_articles_articles_second_subtitle":
            MessageLookupByLibrary.simpleMessage("Prise de Notes"),
        "default_articles_articles_third_paragraph":
            MessageLookupByLibrary.simpleMessage(
                "Toutes vos sources sont accessibles via un menu situé en bas de la page, vous permettant ainsi de gérer et de retrouver facilement vos références."),
        "default_articles_articles_third_subtitle":
            MessageLookupByLibrary.simpleMessage("Gestion des Sources"),
        "default_articles_articles_title":
            MessageLookupByLibrary.simpleMessage("Articles"),
        "greeting_afternoon": m2,
        "greeting_evening": m3,
        "greeting_morning": m4,
        "home_appbar": MessageLookupByLibrary.simpleMessage("Accueil"),
        "home_articles_card_open_hint":
            MessageLookupByLibrary.simpleMessage("Ouvrir cet article"),
        "home_discover":
            MessageLookupByLibrary.simpleMessage("Découvrir minddy"),
        "home_pick_up":
            MessageLookupByLibrary.simpleMessage("Reprenez là où vous étiez"),
        "project_card_delete":
            MessageLookupByLibrary.simpleMessage("Supprimer"),
        "project_card_duplicate":
            MessageLookupByLibrary.simpleMessage("Dupiquer"),
        "project_card_open_settings":
            MessageLookupByLibrary.simpleMessage("Modifier"),
        "projects_add_module_tooltip":
            MessageLookupByLibrary.simpleMessage("Nouveau module"),
        "projects_module_help_text":
            MessageLookupByLibrary.simpleMessage("Aide"),
        "projects_module_notes_category_note_count": m5,
        "projects_module_notes_editing_note_sub_menu_move_tooltip":
            MessageLookupByLibrary.simpleMessage("Déplacer"),
        "projects_module_notes_editing_note_sub_menu_save_tooltip":
            MessageLookupByLibrary.simpleMessage("Sauvegarder la note"),
        "projects_module_notes_for_later_title":
            MessageLookupByLibrary.simpleMessage("Notes pour plus tard"),
        "projects_module_notes_important_notes_title":
            MessageLookupByLibrary.simpleMessage("Notes importantes"),
        "projects_module_notes_modify_category":
            MessageLookupByLibrary.simpleMessage("Modifier"),
        "projects_module_notes_modify_category_sub_menu_title":
            MessageLookupByLibrary.simpleMessage("Modifier la catégorie"),
        "projects_module_notes_modify_note_tooltip":
            MessageLookupByLibrary.simpleMessage("Modifier cette note"),
        "projects_module_notes_new_category_sub_menu_error_message":
            MessageLookupByLibrary.simpleMessage(
                "Veuillez nommer la catégorie"),
        "projects_module_notes_new_category_sub_menu_is_private":
            MessageLookupByLibrary.simpleMessage("Categorie privée"),
        "projects_module_notes_new_category_sub_menu_is_private_tooltip":
            MessageLookupByLibrary.simpleMessage(
                "En activant cette option, votre mot de passe sera requis pour ouvrir cette catégorie."),
        "projects_module_notes_new_category_sub_menu_name_hint":
            MessageLookupByLibrary.simpleMessage(
                "Entrez le nom de la catégorie"),
        "projects_module_notes_new_category_sub_menu_subtitle":
            MessageLookupByLibrary.simpleMessage("Nom de la catégorie"),
        "projects_module_notes_new_category_sub_menu_title":
            MessageLookupByLibrary.simpleMessage("Nouvelle catégorie"),
        "projects_module_notes_new_category_tooltip":
            MessageLookupByLibrary.simpleMessage("Nouvelle catégorie"),
        "projects_module_notes_new_note_tooltip":
            MessageLookupByLibrary.simpleMessage("Nouvelle note"),
        "projects_module_notes_private_notes_title":
            MessageLookupByLibrary.simpleMessage("Notes privées"),
        "projects_module_notes_project_notes_title":
            MessageLookupByLibrary.simpleMessage("Notes du projet"),
        "projects_module_notes_title":
            MessageLookupByLibrary.simpleMessage("Notes"),
        "projects_module_spreadsheet_data_choose_column_type_tooltip":
            MessageLookupByLibrary.simpleMessage("Choisir un type de colonne"),
        "projects_module_spreadsheet_data_column_type":
            MessageLookupByLibrary.simpleMessage("Type de colonne"),
        "projects_module_spreadsheet_data_type_date":
            MessageLookupByLibrary.simpleMessage("Date"),
        "projects_module_spreadsheet_data_type_email":
            MessageLookupByLibrary.simpleMessage("E-mail"),
        "projects_module_spreadsheet_data_type_number":
            MessageLookupByLibrary.simpleMessage("Nombre"),
        "projects_module_spreadsheet_data_type_phone_number":
            MessageLookupByLibrary.simpleMessage("Numéro de téléphone"),
        "projects_module_spreadsheet_data_type_selection":
            MessageLookupByLibrary.simpleMessage("Sélection"),
        "projects_module_spreadsheet_data_type_text":
            MessageLookupByLibrary.simpleMessage("Texte"),
        "projects_module_spreadsheet_data_type_url":
            MessageLookupByLibrary.simpleMessage("URL"),
        "projects_module_spreadsheet_date_from_text":
            MessageLookupByLibrary.simpleMessage("Du"),
        "projects_module_spreadsheet_date_single_tooltip":
            MessageLookupByLibrary.simpleMessage("Date unique"),
        "projects_module_spreadsheet_date_start_end_tooltip":
            MessageLookupByLibrary.simpleMessage("Ajouter une date de fin"),
        "projects_module_spreadsheet_date_to_text":
            MessageLookupByLibrary.simpleMessage("Au"),
        "projects_module_spreadsheet_delete_column":
            MessageLookupByLibrary.simpleMessage("Supprimer cette colonne"),
        "projects_module_spreadsheet_delete_row":
            MessageLookupByLibrary.simpleMessage("Supprimer cette ligne"),
        "projects_module_spreadsheet_extend_cell_tooltip":
            MessageLookupByLibrary.simpleMessage("Étendre cette cellule"),
        "projects_module_spreadsheet_new_column":
            MessageLookupByLibrary.simpleMessage("Nouvelle colonne"),
        "projects_module_spreadsheet_new_row":
            MessageLookupByLibrary.simpleMessage("Nouvelle ligne"),
        "projects_module_spreadsheet_number_operation_average":
            MessageLookupByLibrary.simpleMessage("Moyenne"),
        "projects_module_spreadsheet_number_operation_calculate":
            MessageLookupByLibrary.simpleMessage("Calculer"),
        "projects_module_spreadsheet_number_operation_interval":
            MessageLookupByLibrary.simpleMessage("Intervalle"),
        "projects_module_spreadsheet_number_operation_maximum":
            MessageLookupByLibrary.simpleMessage("Maximum"),
        "projects_module_spreadsheet_number_operation_median":
            MessageLookupByLibrary.simpleMessage("Médiane"),
        "projects_module_spreadsheet_number_operation_minimum":
            MessageLookupByLibrary.simpleMessage("Minimum"),
        "projects_module_spreadsheet_number_operation_none":
            MessageLookupByLibrary.simpleMessage("Aucun"),
        "projects_module_spreadsheet_number_operation_standard_deviation":
            MessageLookupByLibrary.simpleMessage("Écart type"),
        "projects_module_spreadsheet_number_operation_sum":
            MessageLookupByLibrary.simpleMessage("Somme"),
        "projects_module_spreadsheet_selection_cell_add_an_option":
            MessageLookupByLibrary.simpleMessage("Ajouter une option"),
        "projects_module_spreadsheet_selection_cell_add_options":
            MessageLookupByLibrary.simpleMessage("Ajouter des options"),
        "projects_module_spreadsheet_selection_cell_all_options":
            MessageLookupByLibrary.simpleMessage("Toutes les options"),
        "projects_module_spreadsheet_selection_cell_finished":
            MessageLookupByLibrary.simpleMessage("Terminé"),
        "projects_module_spreadsheet_selection_cell_modify_options":
            MessageLookupByLibrary.simpleMessage("Modifier les options"),
        "projects_module_spreadsheet_selection_cell_name_option_hint":
            MessageLookupByLibrary.simpleMessage("Nommez cette option..."),
        "projects_module_spreadsheet_selection_cell_not_started":
            MessageLookupByLibrary.simpleMessage("Pas encore commencé"),
        "projects_module_spreadsheet_selection_cell_started":
            MessageLookupByLibrary.simpleMessage("Commencé"),
        "projects_module_spreadsheet_selection_sub_menu_error_message_no_options":
            MessageLookupByLibrary.simpleMessage(
                "Veuillez ajouter des options"),
        "projects_module_spreadsheet_selection_sub_menu_error_message_redundant_option_name":
            m6,
        "projects_module_spreadsheet_selection_sub_menu_error_message_unnamed_option":
            MessageLookupByLibrary.simpleMessage(
                "Veuillez nommer toutes les options"),
        "projects_module_spreadsheet_title":
            MessageLookupByLibrary.simpleMessage("Tableau"),
        "projects_module_spreadsheet_value_unnamed":
            MessageLookupByLibrary.simpleMessage("Sans nom"),
        "projects_module_tasks_add_task_tooltip":
            MessageLookupByLibrary.simpleMessage("Ajouter une nouvelle tâche"),
        "projects_module_tasks_completed": m7,
        "projects_module_tasks_task_add_subtask_tooltip":
            MessageLookupByLibrary.simpleMessage("Ajouter une sous-tâche"),
        "projects_module_tasks_task_title_hint":
            MessageLookupByLibrary.simpleMessage("Titre"),
        "projects_module_tasks_title":
            MessageLookupByLibrary.simpleMessage("Tâches"),
        "projects_next_page_shortcut_tooltip":
            MessageLookupByLibrary.simpleMessage("Page suivante ctrl + ⭢"),
        "projects_next_page_shortcut_tooltip_mac":
            MessageLookupByLibrary.simpleMessage("Page suivante ⌘ + ⭢"),
        "projects_previous_page_shortcut_tooltip":
            MessageLookupByLibrary.simpleMessage("Page précédente ctrl + ⭠"),
        "projects_previous_page_shortcut_tooltip_mac":
            MessageLookupByLibrary.simpleMessage("Page précédente ⌘ + ⭠"),
        "projects_save_project_button_tooltip":
            MessageLookupByLibrary.simpleMessage("Sauvegarder"),
        "projetcs_module_spreadsheet_open_website": m8,
        "settings_accessibility_title":
            MessageLookupByLibrary.simpleMessage("Accessibilité"),
        "settings_account_title":
            MessageLookupByLibrary.simpleMessage("Mon compte"),
        "settings_date_format": MessageLookupByLibrary.simpleMessage(
            "Préférer le format de date MM/dd"),
        "settings_date_format_subtitle":
            MessageLookupByLibrary.simpleMessage("Format de date"),
        "settings_date_format_tooltip": m9,
        "settings_language_subtitle":
            MessageLookupByLibrary.simpleMessage("Langue"),
        "settings_need_to_quit_project_to_change_language":
            MessageLookupByLibrary.simpleMessage(
                "Pour changer de langue, veuillez revenir à l\'accueil"),
        "settings_need_to_quit_project_to_change_theme":
            MessageLookupByLibrary.simpleMessage(
                "Pour changer les paramètres de thème, veuillez revenir à l\'accueil"),
        "settings_personalize_black_and_white_title":
            MessageLookupByLibrary.simpleMessage("Mode noir et blanc"),
        "settings_personalize_title":
            MessageLookupByLibrary.simpleMessage("Personnaliser"),
        "settings_project_delete_button":
            MessageLookupByLibrary.simpleMessage("Supprimer ce projet"),
        "settings_project_delete_subtitle":
            MessageLookupByLibrary.simpleMessage("Supprimer"),
        "settings_project_rename_button":
            MessageLookupByLibrary.simpleMessage("Renommer"),
        "settings_project_rename_subtitle":
            MessageLookupByLibrary.simpleMessage("Renommer"),
        "settings_reset_button": MessageLookupByLibrary.simpleMessage(
            "Réinitialiser les paramètres"),
        "settings_reset_subtitle":
            MessageLookupByLibrary.simpleMessage("Réinitialiser"),
        "settings_security_title":
            MessageLookupByLibrary.simpleMessage("Sécurité"),
        "settings_theme_subtitle":
            MessageLookupByLibrary.simpleMessage("Thème"),
        "settings_title": MessageLookupByLibrary.simpleMessage("Paramètres"),
        "settings_username_subtitle":
            MessageLookupByLibrary.simpleMessage("Prénom"),
        "settings_using_dark_mode":
            MessageLookupByLibrary.simpleMessage("Mode sombre"),
        "settings_using_light_mode":
            MessageLookupByLibrary.simpleMessage("Mode clair"),
        "settings_using_system_theme":
            MessageLookupByLibrary.simpleMessage("Thème du système"),
        "snacbar_close_button": MessageLookupByLibrary.simpleMessage("Fermer"),
        "snackbar_articles_saved": MessageLookupByLibrary.simpleMessage(
            "Cet article à été enregistré"),
        "snackbar_articles_unsaved": MessageLookupByLibrary.simpleMessage(
            "Cet article n\'est plus enregistré"),
        "snackbar_cancel_button":
            MessageLookupByLibrary.simpleMessage("Fermer"),
        "snackbar_delete_button":
            MessageLookupByLibrary.simpleMessage("Supprimer"),
        "snackbar_delete_element_text": m10,
        "snackbar_reset_button":
            MessageLookupByLibrary.simpleMessage("Réinitialiser"),
        "snackbar_reset_text": MessageLookupByLibrary.simpleMessage(
            "Réinitialiser les paramètres ?"),
        "snackbar_restart_button":
            MessageLookupByLibrary.simpleMessage("Fermer l\'app"),
        "snackbar_restart_needed_text": MessageLookupByLibrary.simpleMessage(
            "Vous devrez redémarrer l\'application pour appliquer les modifications"),
        "snackbar_welcome_back_button":
            MessageLookupByLibrary.simpleMessage("Merci"),
        "snackbar_welcome_back_text": m11,
        "submenu_artilces_image_description_button":
            MessageLookupByLibrary.simpleMessage("Valider"),
        "submenu_artilces_image_description_hint":
            MessageLookupByLibrary.simpleMessage("Décrivez l\'image..."),
        "submenu_artilces_image_description_subtitle":
            MessageLookupByLibrary.simpleMessage("Description de l\'image"),
        "submenu_artilces_image_description_title":
            MessageLookupByLibrary.simpleMessage("Description"),
        "submenu_new_project_button":
            MessageLookupByLibrary.simpleMessage("Créer"),
        "submenu_new_project_errorMessage":
            MessageLookupByLibrary.simpleMessage("Veuillez nommer le projet"),
        "submenu_new_project_hint":
            MessageLookupByLibrary.simpleMessage("Entrez le nom du projet..."),
        "submenu_new_project_subtitle":
            MessageLookupByLibrary.simpleMessage("Nom du projet"),
        "submenu_new_project_title":
            MessageLookupByLibrary.simpleMessage("Nouveau projet"),
        "submenu_unlock_content_title":
            MessageLookupByLibrary.simpleMessage("Déverouiller"),
        "submenu_unlock_error_message_error_login":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de vérifier le mot de passe."),
        "submenu_unlock_error_message_incorrect_password":
            MessageLookupByLibrary.simpleMessage("Mot de passe incorrect"),
        "submenu_unlock_error_message_please_enter_password":
            MessageLookupByLibrary.simpleMessage(
                "Veuillez saisir votre mot de passe"),
        "submenu_unlock_hide_mnemonic": MessageLookupByLibrary.simpleMessage(
            "Masquer l\'indice de mot de passe"),
        "submenu_unlock_show_mnemonic": MessageLookupByLibrary.simpleMessage(
            "Afficher l\'indice de mot de passe"),
        "submenu_unlock_subtitle_text":
            MessageLookupByLibrary.simpleMessage("Entrez votre mot de passe"),
        "submenu_welcome_password_mnemonic_sentence_hint":
            MessageLookupByLibrary.simpleMessage(
                "Entrez votre indice de mot de passe"),
        "submenu_welcome_password_mnemonic_sentence_instructs":
            MessageLookupByLibrary.simpleMessage(
                "Cette fonctionnalité vous aide à vous rappeler de votre mot de passe en cas d\'oubli. Il est déconseillé d\'entrer directement votre mot de passe, veuillez plutôt fournir un indice."),
        "submenu_welcome_password_mnemonic_sentence_subtitle":
            MessageLookupByLibrary.simpleMessage(
                "Ajouter un indice de mot de passe"),
        "submenu_welcome_password_mnemonic_sentence_title":
            MessageLookupByLibrary.simpleMessage("Indice de mot de passe"),
        "system_files_copy_text": MessageLookupByLibrary.simpleMessage("Copie"),
        "tool_pomodoro_break_duration": MessageLookupByLibrary.simpleMessage(
            "Durée de la session de pause"),
        "tool_pomodoro_break_session":
            MessageLookupByLibrary.simpleMessage("Pause"),
        "tool_pomodoro_focus_timer":
            MessageLookupByLibrary.simpleMessage("Minuteur de concentration"),
        "tool_pomodoro_repetition_count":
            MessageLookupByLibrary.simpleMessage("Nombre de répétitions"),
        "tool_pomodoro_start_button":
            MessageLookupByLibrary.simpleMessage("Démarrer"),
        "tool_pomodoro_stop_button":
            MessageLookupByLibrary.simpleMessage("Arrêter"),
        "tool_pomodoro_work_duration": MessageLookupByLibrary.simpleMessage(
            "Durée de la session de travail"),
        "tool_pomodoro_work_session":
            MessageLookupByLibrary.simpleMessage("Travail"),
        "welcome_appbar": MessageLookupByLibrary.simpleMessage("Bienvenue"),
        "welcome_because": MessageLookupByLibrary.simpleMessage(
            "Pour personnaliser votre expérience"),
        "welcome_before_creating": MessageLookupByLibrary.simpleMessage(
            "Pour commencer, entrez votre prénom"),
        "welcome_enter_name":
            MessageLookupByLibrary.simpleMessage("Entrez votre prénom"),
        "welcome_error_save_username": MessageLookupByLibrary.simpleMessage(
            "Une erreur s\'est produite lors de l\'enregistrement de votre prénom"),
        "welcome_first_name_too_long": MessageLookupByLibrary.simpleMessage(
            "Le prénom ne peut pas être plus long que 25 lettres"),
        "welcome_next_page_semantic":
            MessageLookupByLibrary.simpleMessage("Page suivante"),
        "welcome_pass_default_username":
            MessageLookupByLibrary.simpleMessage("Utilisateur"),
        "welcome_pass_tooltip": m12,
        "welcome_pass_username": MessageLookupByLibrary.simpleMessage("Passer"),
        "welcome_password_creation_confirm_hint":
            MessageLookupByLibrary.simpleMessage(
                "Confirmez votre mot de passe"),
        "welcome_password_creation_description":
            MessageLookupByLibrary.simpleMessage("Pour sécuriser vos données"),
        "welcome_password_creation_error_must_provide":
            MessageLookupByLibrary.simpleMessage(
                "Vous devez créer un mot de passe"),
        "welcome_password_creation_error_not_match":
            MessageLookupByLibrary.simpleMessage(
                "Les mots de passe ne correspondent pas"),
        "welcome_password_creation_error_password_save":
            MessageLookupByLibrary.simpleMessage(
                "Une erreur est survenue lors de l\'enregistrement de votre mot de passe"),
        "welcome_password_creation_hide_semantic":
            MessageLookupByLibrary.simpleMessage("Masquer le mot de passe"),
        "welcome_password_creation_hint":
            MessageLookupByLibrary.simpleMessage("Créez votre mot de passe"),
        "welcome_password_creation_password_requirements":
            MessageLookupByLibrary.simpleMessage(
                "Le mot de passe doit contenir au moins 8 caractères et inclure au moins une lettre majuscule, une lettre minuscule et un chiffre."),
        "welcome_password_creation_remember":
            MessageLookupByLibrary.simpleMessage(
                "Ajouter un indice de mot de passe (optionel)"),
        "welcome_password_creation_show_semantic":
            MessageLookupByLibrary.simpleMessage("Afficher le mot de passe"),
        "welcome_password_creation_title": MessageLookupByLibrary.simpleMessage(
            "Maintenant, créez un mot de passe"),
        "welcome_should_provide": MessageLookupByLibrary.simpleMessage(
            "Vous devez fournir votre prénom")
      };
}
