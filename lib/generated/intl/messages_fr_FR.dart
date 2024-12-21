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

  static String m2(eventName, username) =>
      "${eventName} à été complété par ${username}";

  static String m3(username) => "Complété par ${username}";

  static String m4(username) => "Bon après-midi ${username}";

  static String m5(username) => "Bonsoir ${username}";

  static String m6(username) => "Bonjour ${username}";

  static String m7(length) =>
      "${Intl.plural(length, one: 'Entrée', other: 'Entrées')}";

  static String m8(length) =>
      "${Intl.plural(length, one: 'Sortie', other: 'Sorties')}";

  static String m9(length) =>
      "${Intl.plural(length, one: 'Copier le nœud sélectionné (⌘ + c)', other: 'Copier les nœuds sélectionnés (⌘ + c)')}";

  static String m10(length) =>
      "${Intl.plural(length, one: 'Copier le nœud sélectionné (ctrl + c)', other: 'Copier les nœuds sélectionnés (ctrl + c)')}";

  static String m11(length) =>
      "${Intl.plural(length, one: 'Supprimer le nœud sélectionné (⌘ + ⌫)', other: 'Supprimer les nœuds sélectionnés (⌘ + ⌫)')}";

  static String m12(length) =>
      "${Intl.plural(length, one: 'Supprimer le nœud sélectionné (ctrl + ⌫)', other: 'Supprimer les nœuds sélectionnés (ctrl + ⌫)')}";

  static String m13(length) =>
      "${Intl.plural(length, one: 'Dupliquer le nœud sélectionné (⌘ + d)', other: 'Dupliquer les nœuds sélectionnés (⌘ + d)')}";

  static String m14(length) =>
      "${Intl.plural(length, one: 'Dupliquer le nœud sélectionné (ctrl + d)', other: 'Dupliquer les nœuds sélectionnés (ctrl + d)')}";

  static String m15(length) =>
      "${Intl.plural(length, one: 'Coller le nœud copié (⌘ + v)', other: 'Coller les nœuds copiés (⌘ + v)')}";

  static String m16(length) =>
      "${Intl.plural(length, one: 'Coller le nœud copié (ctrl + v)', other: 'Coller les nœuds copiés (ctrl + v)')}";

  static String m17(totalNotesCount) =>
      "${Intl.plural(totalNotesCount, zero: 'Aucune note', one: '1 note', other: '${totalNotesCount} notes')}";

  static String m18(optionName) =>
      "Deux options ne peuvent pas avoir le même nom (${optionName})";

  static String m19(totalTasksCount, checkedTasks) =>
      "${Intl.plural(totalTasksCount, zero: 'Aucune tâche', one: '${checkedTasks}/${totalTasksCount} tâche terminée', other: '${checkedTasks}/${totalTasksCount} tâches terminées')}";

  static String m20(websiteName) => "Ouvrir ${websiteName}";

  static String m21(actualMonth, actualDay) =>
      "Cette option mettra le mois avant le jour. Comme ceci : ${actualMonth}/${actualDay}";

  static String m22(element) => "Supprimer ${element} ?";

  static String m23(user) => "Ravis de vous revoir ${user}";

  static String m24(duration) =>
      "${Intl.plural(duration, zero: 'Pomodoro - C\'est l\'heure de la pause', one: 'Pomodoro - C\'est l\'heure de la pause pour ${duration} minute', other: 'Pomodoro - C\'est l\'heure de la pause pour ${duration} minutes')}";

  static String m25(duration) =>
      "La session pomodoro est terminée, vous avez travaillé ${Intl.plural(duration, one: '1 minute', other: '${duration} minutes')}. Il est temps de se reposer !";

  static String m26(duration) =>
      "${Intl.plural(duration, zero: 'Pomodoro - Il est temps de retourner au travail', one: 'Pomodoro - Il est temps de retourner au travail pour ${duration} minute', other: 'Pomodoro - Il est temps de retourner au travail pour ${duration} minutes')}";

  static String m27(accountSettingName) =>
      "Vous pourrez toujours saisir votre prénom dans paramètres / ${accountSettingName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "app_name": MessageLookupByLibrary.simpleMessage("minddy"),
        "app_slogan":
            MessageLookupByLibrary.simpleMessage("Tout se passe ici."),
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
            "Aucun article pour cette catégorie, importez ou écrivez-en un !"),
        "articles_empty_menu_saved_page_text":
            MessageLookupByLibrary.simpleMessage("Aucun article enregistré."),
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
        "calendar_button_add_event_button_tooltip":
            MessageLookupByLibrary.simpleMessage("Ajouter un événement"),
        "calendar_button_calendar_title":
            MessageLookupByLibrary.simpleMessage("Calendrier"),
        "calendar_button_due_date_cancel_complete":
            MessageLookupByLibrary.simpleMessage("Annuler"),
        "calendar_button_due_date_has_been_complete": m2,
        "calendar_button_event_date_today":
            MessageLookupByLibrary.simpleMessage("Aujourd\'hui"),
        "calendar_button_event_date_tomorrow":
            MessageLookupByLibrary.simpleMessage("Demain"),
        "calendar_button_event_date_yesterday":
            MessageLookupByLibrary.simpleMessage("Hier"),
        "calendar_button_event_preview_private_event":
            MessageLookupByLibrary.simpleMessage("Cet événement est privé."),
        "calendar_button_event_preview_see_button":
            MessageLookupByLibrary.simpleMessage("Voir"),
        "calendar_button_event_selection_menu_all_occurence":
            MessageLookupByLibrary.simpleMessage("Toutes les occurrences"),
        "calendar_button_event_selection_menu_only_this_event":
            MessageLookupByLibrary.simpleMessage("Seulement cet événement"),
        "calendar_button_free_for_next_days":
            MessageLookupByLibrary.simpleMessage(
                "Vous êtes libre pour les 5 prochains jours."),
        "calendar_button_manage_calendar_button_tooltip":
            MessageLookupByLibrary.simpleMessage("Gérer les calendriers"),
        "calendar_button_manage_calendars_sub_menu_add_calendar":
            MessageLookupByLibrary.simpleMessage("Nouveau calendrier"),
        "calendar_button_manage_calendars_sub_menu_all_calendars_subtitle":
            MessageLookupByLibrary.simpleMessage("Tous les calendriers"),
        "calendar_button_manage_calendars_sub_menu_modify_calendar":
            MessageLookupByLibrary.simpleMessage("Modifier le calendrier"),
        "calendar_button_new_calendar_calendar_subtitle_name":
            MessageLookupByLibrary.simpleMessage("Nom"),
        "calendar_button_new_calendar_personalized_color":
            MessageLookupByLibrary.simpleMessage("Personalisée"),
        "calendar_button_new_calendar_private_calendar_explanation":
            MessageLookupByLibrary.simpleMessage(
                "En activant cette option, le mot de passe sera requis pour voir les événements de ce calendrier"),
        "calendar_button_new_calendar_private_calendar_title":
            MessageLookupByLibrary.simpleMessage("Calendrier privé"),
        "calendar_button_new_due_date_button_title":
            MessageLookupByLibrary.simpleMessage("Date d\'échéance"),
        "calendar_button_new_event_button_title":
            MessageLookupByLibrary.simpleMessage("Événement"),
        "calendar_button_next_due_dates_title":
            MessageLookupByLibrary.simpleMessage("Dates d\'échéance"),
        "calendar_button_next_events_title":
            MessageLookupByLibrary.simpleMessage("Prochains événements"),
        "calendar_button_open_week_view_button_tooltip":
            MessageLookupByLibrary.simpleMessage("Ouvrir la vue semaine"),
        "calendar_event_detailed_preview_completed_by": m3,
        "calendar_event_detailed_preview_not_completed_yet":
            MessageLookupByLibrary.simpleMessage("Pas encore complété"),
        "calendar_main_calendar_name":
            MessageLookupByLibrary.simpleMessage("Calendrier principal"),
        "calendar_modify_due_date_title": MessageLookupByLibrary.simpleMessage(
            "Modifier la date d\'échéance"),
        "calendar_modify_event_title":
            MessageLookupByLibrary.simpleMessage("Modifier l\'événement"),
        "calendar_new_due_date_title":
            MessageLookupByLibrary.simpleMessage("Nouvelle date d\'échéance"),
        "calendar_new_event_recurrence_select_calendar":
            MessageLookupByLibrary.simpleMessage("Séléctionnez un calendrier"),
        "calendar_new_event_recurrence_subtitle":
            MessageLookupByLibrary.simpleMessage("Récurrence"),
        "calendar_new_event_recurrence_type_everyday":
            MessageLookupByLibrary.simpleMessage("Tous les jours"),
        "calendar_new_event_recurrence_type_everymonth":
            MessageLookupByLibrary.simpleMessage("Tous les mois"),
        "calendar_new_event_recurrence_type_everyweek":
            MessageLookupByLibrary.simpleMessage("Toutes les semaines"),
        "calendar_new_event_recurrence_type_everyyear":
            MessageLookupByLibrary.simpleMessage("Tous les ans"),
        "calendar_new_event_recurrence_type_never":
            MessageLookupByLibrary.simpleMessage("Jamais"),
        "calendar_new_event_title":
            MessageLookupByLibrary.simpleMessage("Nouvel événement"),
        "calendar_new_event_whole_day":
            MessageLookupByLibrary.simpleMessage("Jour entier"),
        "center_menu_general": MessageLookupByLibrary.simpleMessage("Général"),
        "center_menu_others": MessageLookupByLibrary.simpleMessage("Autre"),
        "custom_chart_donut_share":
            MessageLookupByLibrary.simpleMessage("Part"),
        "custom_chart_donut_total":
            MessageLookupByLibrary.simpleMessage("Total"),
        "custom_chart_empty_content": MessageLookupByLibrary.simpleMessage(
            "Pour créer un graphique, veuillez y ajouter des données"),
        "custom_chart_grid_extend_chart":
            MessageLookupByLibrary.simpleMessage("Agrandir le graphique"),
        "custom_color_picker_opacity_tooltip":
            MessageLookupByLibrary.simpleMessage("Opacité"),
        "custom_date_picker_end": MessageLookupByLibrary.simpleMessage("Fin"),
        "custom_date_picker_include_hour":
            MessageLookupByLibrary.simpleMessage("Inclure l\'heure"),
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
        "greeting_afternoon": m4,
        "greeting_evening": m5,
        "greeting_morning": m6,
        "home_appbar": MessageLookupByLibrary.simpleMessage("Accueil"),
        "home_articles_card_open_hint":
            MessageLookupByLibrary.simpleMessage("Ouvrir cet article"),
        "home_discover":
            MessageLookupByLibrary.simpleMessage("Découvrir minddy"),
        "home_pick_up":
            MessageLookupByLibrary.simpleMessage("Reprenez là où vous étiez"),
        "node_editor_add_sub_menu_add_button":
            MessageLookupByLibrary.simpleMessage("Ajouter"),
        "node_editor_add_sub_menu_inputs_subtitle": m7,
        "node_editor_add_sub_menu_no_nodes_found":
            MessageLookupByLibrary.simpleMessage("Aucun nœud trouvé."),
        "node_editor_add_sub_menu_none_input_output":
            MessageLookupByLibrary.simpleMessage("Aucune"),
        "node_editor_add_sub_menu_note": MessageLookupByLibrary.simpleMessage(
            "Remarque: les entrées et sorties peuvent varier en fonction des options choisies pour le nœud"),
        "node_editor_add_sub_menu_outputs_subtitle": m8,
        "node_editor_add_sub_menu_types":
            MessageLookupByLibrary.simpleMessage("Types"),
        "node_editor_view_bottom_toolbar_copy_tooltip_mac": m9,
        "node_editor_view_bottom_toolbar_copy_tooltip_windows": m10,
        "node_editor_view_bottom_toolbar_delete_tooltip_mac": m11,
        "node_editor_view_bottom_toolbar_delete_tooltip_windows": m12,
        "node_editor_view_bottom_toolbar_duplicate_tooltip_mac": m13,
        "node_editor_view_bottom_toolbar_duplicate_tooltip_windows": m14,
        "node_editor_view_bottom_toolbar_paste_tooltip_mac": m15,
        "node_editor_view_bottom_toolbar_paste_tooltip_windows": m16,
        "node_editor_view_bottom_toolbar_redo_tooltip_mac":
            MessageLookupByLibrary.simpleMessage("Rétablir (⇧ + ⌘ + z)"),
        "node_editor_view_bottom_toolbar_redo_tooltip_windows":
            MessageLookupByLibrary.simpleMessage("Rétablir (⇧ + ctrl + z)"),
        "node_editor_view_bottom_toolbar_undo_tooltip_mac":
            MessageLookupByLibrary.simpleMessage("Annuler (⌘ + z)"),
        "node_editor_view_bottom_toolbar_undo_tooltip_windows":
            MessageLookupByLibrary.simpleMessage("Annuler (ctrl + z)"),
        "node_editor_view_close_node_panel_tooltip":
            MessageLookupByLibrary.simpleMessage("Fermer panneau des nœuds"),
        "node_editor_view_close_side_panel_tooltip":
            MessageLookupByLibrary.simpleMessage("Fermer panneau latéral"),
        "node_editor_view_new_node_tooltip":
            MessageLookupByLibrary.simpleMessage("Nouveau nœud"),
        "node_editor_view_open_node_panel_tooltip":
            MessageLookupByLibrary.simpleMessage("Ouvrir panneau des nœuds"),
        "node_editor_view_open_side_panel_tooltip":
            MessageLookupByLibrary.simpleMessage("Ouvrir panneau latéral"),
        "node_editor_view_side_panel_node_trees_add_button_tooltip":
            MessageLookupByLibrary.simpleMessage("Nouvel arbre"),
        "node_editor_view_side_panel_node_trees_title":
            MessageLookupByLibrary.simpleMessage("Arbres de nœuds"),
        "node_editor_view_side_panel_variables_add_button_tooltip":
            MessageLookupByLibrary.simpleMessage("Nouvelle variable"),
        "node_editor_view_side_panel_variables_title":
            MessageLookupByLibrary.simpleMessage("Variables"),
        "node_editor_view_side_panel_variables_variable_type_any":
            MessageLookupByLibrary.simpleMessage("Non défini"),
        "node_editor_view_side_panel_variables_variable_type_boolean":
            MessageLookupByLibrary.simpleMessage("Booléen"),
        "node_editor_view_side_panel_variables_variable_type_color":
            MessageLookupByLibrary.simpleMessage("Couleur"),
        "node_editor_view_side_panel_variables_variable_type_list":
            MessageLookupByLibrary.simpleMessage("Liste"),
        "node_editor_view_side_panel_variables_variable_type_number":
            MessageLookupByLibrary.simpleMessage("Nombre"),
        "node_editor_view_side_panel_variables_variable_type_text":
            MessageLookupByLibrary.simpleMessage("Texte"),
        "node_widgets_boolean_node_description":
            MessageLookupByLibrary.simpleMessage(
                "Effectue des opérations sur des booléens."),
        "node_widgets_boolean_node_options_and":
            MessageLookupByLibrary.simpleMessage("Et"),
        "node_widgets_boolean_node_options_equal":
            MessageLookupByLibrary.simpleMessage("Égal"),
        "node_widgets_boolean_node_options_imply":
            MessageLookupByLibrary.simpleMessage("Impliquer"),
        "node_widgets_boolean_node_options_not":
            MessageLookupByLibrary.simpleMessage("Non"),
        "node_widgets_boolean_node_options_notAnd":
            MessageLookupByLibrary.simpleMessage("Non Et"),
        "node_widgets_boolean_node_options_notEqual":
            MessageLookupByLibrary.simpleMessage("Non Égal"),
        "node_widgets_boolean_node_options_notOr":
            MessageLookupByLibrary.simpleMessage("Non Ou"),
        "node_widgets_boolean_node_options_or":
            MessageLookupByLibrary.simpleMessage("Ou"),
        "node_widgets_boolean_node_options_subtract":
            MessageLookupByLibrary.simpleMessage("Soustraire"),
        "node_widgets_boolean_node_title":
            MessageLookupByLibrary.simpleMessage("Opérations logiques"),
        "node_widgets_category_logic":
            MessageLookupByLibrary.simpleMessage("Logique"),
        "node_widgets_category_math":
            MessageLookupByLibrary.simpleMessage("Maths"),
        "node_widgets_category_variable":
            MessageLookupByLibrary.simpleMessage("Variables"),
        "node_widgets_comparison_node_description":
            MessageLookupByLibrary.simpleMessage(
                "Effectue une comparaison entre des nombres."),
        "node_widgets_comparison_node_options_equal":
            MessageLookupByLibrary.simpleMessage("Égal à"),
        "node_widgets_comparison_node_options_greatherThan":
            MessageLookupByLibrary.simpleMessage("Supérieur à"),
        "node_widgets_comparison_node_options_greatherThanOrEqual":
            MessageLookupByLibrary.simpleMessage("Supérieur ou égal à"),
        "node_widgets_comparison_node_options_lessThan":
            MessageLookupByLibrary.simpleMessage("Inférieur à"),
        "node_widgets_comparison_node_options_lessThanOrEqual":
            MessageLookupByLibrary.simpleMessage("Inférieur ou égal à"),
        "node_widgets_comparison_node_title":
            MessageLookupByLibrary.simpleMessage("Comparaison"),
        "node_widgets_conversion_node_decsription":
            MessageLookupByLibrary.simpleMessage(
                "Convertit une valeur vers autre type"),
        "node_widgets_conversion_node_title":
            MessageLookupByLibrary.simpleMessage("Conversion"),
        "node_widgets_end_text": MessageLookupByLibrary.simpleMessage("Fin"),
        "node_widgets_get_variable_node_description":
            MessageLookupByLibrary.simpleMessage(
                "Obtient la valeur d\'une variable."),
        "node_widgets_get_variable_node_title":
            MessageLookupByLibrary.simpleMessage("Obtenir la variable"),
        "node_widgets_length_text":
            MessageLookupByLibrary.simpleMessage("Longueur"),
        "node_widgets_math_node_description":
            MessageLookupByLibrary.simpleMessage(
                "Effectue des calculs sur des nombres."),
        "node_widgets_math_node_options_abs":
            MessageLookupByLibrary.simpleMessage("Valeur absolue"),
        "node_widgets_math_node_options_acos":
            MessageLookupByLibrary.simpleMessage("Arc cosinus"),
        "node_widgets_math_node_options_acosh":
            MessageLookupByLibrary.simpleMessage("Arc cosh"),
        "node_widgets_math_node_options_addition":
            MessageLookupByLibrary.simpleMessage("Addition"),
        "node_widgets_math_node_options_asin":
            MessageLookupByLibrary.simpleMessage("Arc sinus"),
        "node_widgets_math_node_options_asinh":
            MessageLookupByLibrary.simpleMessage("Arc sinh"),
        "node_widgets_math_node_options_atan":
            MessageLookupByLibrary.simpleMessage("Arc tangente"),
        "node_widgets_math_node_options_atanh":
            MessageLookupByLibrary.simpleMessage("Arc tanh"),
        "node_widgets_math_node_options_ceil":
            MessageLookupByLibrary.simpleMessage("Plafond"),
        "node_widgets_math_node_options_cos":
            MessageLookupByLibrary.simpleMessage("Cosinus"),
        "node_widgets_math_node_options_cosh":
            MessageLookupByLibrary.simpleMessage("Cosh"),
        "node_widgets_math_node_options_division":
            MessageLookupByLibrary.simpleMessage("Division"),
        "node_widgets_math_node_options_floor":
            MessageLookupByLibrary.simpleMessage("Plancher"),
        "node_widgets_math_node_options_ln":
            MessageLookupByLibrary.simpleMessage("Logarithme népérien"),
        "node_widgets_math_node_options_log10":
            MessageLookupByLibrary.simpleMessage("Logarithme en base 10"),
        "node_widgets_math_node_options_max":
            MessageLookupByLibrary.simpleMessage("Maximum"),
        "node_widgets_math_node_options_min":
            MessageLookupByLibrary.simpleMessage("Minimum"),
        "node_widgets_math_node_options_multiplication":
            MessageLookupByLibrary.simpleMessage("Multiplication"),
        "node_widgets_math_node_options_power":
            MessageLookupByLibrary.simpleMessage("Puissance"),
        "node_widgets_math_node_options_round":
            MessageLookupByLibrary.simpleMessage("Arrondi"),
        "node_widgets_math_node_options_sign":
            MessageLookupByLibrary.simpleMessage("Signe"),
        "node_widgets_math_node_options_sin":
            MessageLookupByLibrary.simpleMessage("Sinus"),
        "node_widgets_math_node_options_sinh":
            MessageLookupByLibrary.simpleMessage("Sinh"),
        "node_widgets_math_node_options_squareRoot":
            MessageLookupByLibrary.simpleMessage("Racine carrée"),
        "node_widgets_math_node_options_substraction":
            MessageLookupByLibrary.simpleMessage("Soustraction"),
        "node_widgets_math_node_options_tan":
            MessageLookupByLibrary.simpleMessage("Tangente"),
        "node_widgets_math_node_options_tanh":
            MessageLookupByLibrary.simpleMessage("Tanh"),
        "node_widgets_math_node_options_truncate":
            MessageLookupByLibrary.simpleMessage("Tronquer"),
        "node_widgets_math_node_title":
            MessageLookupByLibrary.simpleMessage("Calculs"),
        "node_widgets_random_number_node_description":
            MessageLookupByLibrary.simpleMessage(
                "Génère un nombre aléatoire entre un minimum et un maximum (0 et 1 par défaut)."),
        "node_widgets_random_number_node_title":
            MessageLookupByLibrary.simpleMessage("Nombre aléatoire"),
        "node_widgets_result_text":
            MessageLookupByLibrary.simpleMessage("Résultat"),
        "node_widgets_select_variable_node_text":
            MessageLookupByLibrary.simpleMessage("Sélectionnez une variable"),
        "node_widgets_set_variable_node_description":
            MessageLookupByLibrary.simpleMessage(
                "Définit la valeur d\'une variable."),
        "node_widgets_set_variable_node_title":
            MessageLookupByLibrary.simpleMessage("Définir la variable"),
        "node_widgets_start_text":
            MessageLookupByLibrary.simpleMessage("Début"),
        "node_widgets_text_operation_node_decsription":
            MessageLookupByLibrary.simpleMessage(
                "Effectue des opérations sur du texte"),
        "node_widgets_text_operation_node_options_contains":
            MessageLookupByLibrary.simpleMessage("Contient"),
        "node_widgets_text_operation_node_options_cut":
            MessageLookupByLibrary.simpleMessage("Couper"),
        "node_widgets_text_operation_node_options_join":
            MessageLookupByLibrary.simpleMessage("Fusionner"),
        "node_widgets_text_operation_node_options_pad_left":
            MessageLookupByLibrary.simpleMessage("Remplir à gauche"),
        "node_widgets_text_operation_node_options_pad_right":
            MessageLookupByLibrary.simpleMessage("Remplir à droite"),
        "node_widgets_text_operation_node_options_trim":
            MessageLookupByLibrary.simpleMessage("Retirer le vide"),
        "node_widgets_text_operation_node_options_trim_left":
            MessageLookupByLibrary.simpleMessage("Retirer le vide à gauche"),
        "node_widgets_text_operation_node_options_trim_right":
            MessageLookupByLibrary.simpleMessage("Retirer le vide à droite"),
        "node_widgets_text_operation_node_title":
            MessageLookupByLibrary.simpleMessage("Opérations textuelles"),
        "node_widgets_text_text": MessageLookupByLibrary.simpleMessage("Texte"),
        "node_widgets_treshold_text":
            MessageLookupByLibrary.simpleMessage("Limite"),
        "node_widgets_value_text":
            MessageLookupByLibrary.simpleMessage("Valeur"),
        "project_card_delete":
            MessageLookupByLibrary.simpleMessage("Supprimer"),
        "project_card_duplicate":
            MessageLookupByLibrary.simpleMessage("Dupliquer"),
        "project_card_open_settings":
            MessageLookupByLibrary.simpleMessage("Modifier"),
        "projects_add_module_tooltip":
            MessageLookupByLibrary.simpleMessage("Nouveau module"),
        "projects_module_help_text":
            MessageLookupByLibrary.simpleMessage("Aide"),
        "projects_module_notes_category_note_count": m17,
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
        "projects_module_spreadsheet_chart_chart_column_plural":
            MessageLookupByLibrary.simpleMessage("Colonnes"),
        "projects_module_spreadsheet_chart_chart_column_single":
            MessageLookupByLibrary.simpleMessage("Colonne"),
        "projects_module_spreadsheet_chart_chart_select_column":
            MessageLookupByLibrary.simpleMessage("Sélectionnez une colonne"),
        "projects_module_spreadsheet_chart_chart_type_bar":
            MessageLookupByLibrary.simpleMessage("Barre"),
        "projects_module_spreadsheet_chart_chart_type_bar_grouped":
            MessageLookupByLibrary.simpleMessage("Barres regroupées"),
        "projects_module_spreadsheet_chart_chart_type_bar_simple":
            MessageLookupByLibrary.simpleMessage("Barres simples"),
        "projects_module_spreadsheet_chart_chart_type_bar_stacked":
            MessageLookupByLibrary.simpleMessage("Barres empilées"),
        "projects_module_spreadsheet_chart_chart_type_donut":
            MessageLookupByLibrary.simpleMessage("Donut"),
        "projects_module_spreadsheet_chart_chart_type_subtitle":
            MessageLookupByLibrary.simpleMessage("Type de graphique"),
        "projects_module_spreadsheet_chart_new_column":
            MessageLookupByLibrary.simpleMessage("Ajouter une colonne"),
        "projects_module_spreadsheet_chart_new_tab":
            MessageLookupByLibrary.simpleMessage("Nouvel onglet"),
        "projects_module_spreadsheet_chart_show_chart":
            MessageLookupByLibrary.simpleMessage("Afficher les graphiques"),
        "projects_module_spreadsheet_chart_show_table":
            MessageLookupByLibrary.simpleMessage("Afficher le tableau"),
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
        "projects_module_spreadsheet_manage_columns_sub_menu_subtitle":
            MessageLookupByLibrary.simpleMessage("Toutes les colonnes"),
        "projects_module_spreadsheet_manage_columns_sub_menu_title":
            MessageLookupByLibrary.simpleMessage("Organiser les colonnes"),
        "projects_module_spreadsheet_manage_rows_sub_menu_subtitle":
            MessageLookupByLibrary.simpleMessage("Toutes les lignes"),
        "projects_module_spreadsheet_manage_rows_sub_menu_title":
            MessageLookupByLibrary.simpleMessage("Organiser les lignes"),
        "projects_module_spreadsheet_new_column":
            MessageLookupByLibrary.simpleMessage("Nouvelle colonne"),
        "projects_module_spreadsheet_new_row":
            MessageLookupByLibrary.simpleMessage("Nouvelle ligne"),
        "projects_module_spreadsheet_number_operation_average":
            MessageLookupByLibrary.simpleMessage("Moyenne"),
        "projects_module_spreadsheet_number_operation_average_example":
            MessageLookupByLibrary.simpleMessage("(10 + 50 + 100) / 3"),
        "projects_module_spreadsheet_number_operation_average_message":
            MessageLookupByLibrary.simpleMessage(
                "Calcule la moyenne en divisant la somme de toutes les valeurs par le nombre de valeurs. Cela aide à trouver la valeur centrale des données."),
        "projects_module_spreadsheet_number_operation_calculate":
            MessageLookupByLibrary.simpleMessage("Calculer"),
        "projects_module_spreadsheet_number_operation_interval":
            MessageLookupByLibrary.simpleMessage("Intervalle"),
        "projects_module_spreadsheet_number_operation_interval_example":
            MessageLookupByLibrary.simpleMessage("(10, 50, 100) = 90"),
        "projects_module_spreadsheet_number_operation_interval_message":
            MessageLookupByLibrary.simpleMessage(
                "Calcule la plage en soustrayant la plus petite valeur de la plus grande valeur dans la colonne. Cela montre la répartition des valeurs."),
        "projects_module_spreadsheet_number_operation_maximum":
            MessageLookupByLibrary.simpleMessage("Maximum"),
        "projects_module_spreadsheet_number_operation_maximum_example":
            MessageLookupByLibrary.simpleMessage("(10, 50, 100) = 100"),
        "projects_module_spreadsheet_number_operation_maximum_message":
            MessageLookupByLibrary.simpleMessage(
                "Trouve la valeur la plus élevée dans la colonne. Utile pour identifier le plus grand nombre."),
        "projects_module_spreadsheet_number_operation_median":
            MessageLookupByLibrary.simpleMessage("Médiane"),
        "projects_module_spreadsheet_number_operation_median_example":
            MessageLookupByLibrary.simpleMessage("(10, 50, 100) = 50"),
        "projects_module_spreadsheet_number_operation_median_message":
            MessageLookupByLibrary.simpleMessage(
                "Trouve la valeur centrale lorsque les valeurs des colonnes sont triées. Utile pour identifier la valeur centrale."),
        "projects_module_spreadsheet_number_operation_minimum":
            MessageLookupByLibrary.simpleMessage("Minimum"),
        "projects_module_spreadsheet_number_operation_minimum_example":
            MessageLookupByLibrary.simpleMessage("(10, 50, 100) = 10"),
        "projects_module_spreadsheet_number_operation_minimum_message":
            MessageLookupByLibrary.simpleMessage(
                "Trouve la valeur la plus basse dans la colonne. Cela aide à identifier le plus petit nombre."),
        "projects_module_spreadsheet_number_operation_none":
            MessageLookupByLibrary.simpleMessage("Aucun"),
        "projects_module_spreadsheet_number_operation_standardDeviation_example":
            MessageLookupByLibrary.simpleMessage(
                "√[((10-53.33)² + (50-53.33)² + (100-53.33)²) / 3]"),
        "projects_module_spreadsheet_number_operation_standardDeviation_message":
            MessageLookupByLibrary.simpleMessage(
                "Calcule l\'écart type pour mesurer dans quelle mesure les valeurs varient par rapport à la moyenne. Ici, 53,33 est la moyenne des valeurs 10, 50 et 100."),
        "projects_module_spreadsheet_number_operation_standard_deviation":
            MessageLookupByLibrary.simpleMessage("Écart type"),
        "projects_module_spreadsheet_number_operation_sum":
            MessageLookupByLibrary.simpleMessage("Somme"),
        "projects_module_spreadsheet_number_operation_sum_example":
            MessageLookupByLibrary.simpleMessage("10 + 50 + 100"),
        "projects_module_spreadsheet_number_operation_sum_message":
            MessageLookupByLibrary.simpleMessage(
                "Ajoute toutes les valeurs de la colonne pour obtenir le total. Utile pour résumer les données."),
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
        "projects_module_spreadsheet_selection_sub_menu_error_message_redundant_color":
            MessageLookupByLibrary.simpleMessage(
                "Deux options ne peuvent pas avoir la même couleur"),
        "projects_module_spreadsheet_selection_sub_menu_error_message_redundant_option_name":
            m18,
        "projects_module_spreadsheet_selection_sub_menu_error_message_unnamed_option":
            MessageLookupByLibrary.simpleMessage(
                "Veuillez nommer toutes les options"),
        "projects_module_spreadsheet_title":
            MessageLookupByLibrary.simpleMessage("Tableau"),
        "projects_module_spreadsheet_value_unnamed":
            MessageLookupByLibrary.simpleMessage("Sans nom"),
        "projects_module_tasks_add_task_tooltip":
            MessageLookupByLibrary.simpleMessage("Ajouter une nouvelle tâche"),
        "projects_module_tasks_completed": m19,
        "projects_module_tasks_task_add_subtask_tooltip":
            MessageLookupByLibrary.simpleMessage("Ajouter une sous-tâche"),
        "projects_module_tasks_task_title_hint":
            MessageLookupByLibrary.simpleMessage("Titre"),
        "projects_module_tasks_title":
            MessageLookupByLibrary.simpleMessage("Tâches"),
        "projects_next_page_shortcut_tooltip":
            MessageLookupByLibrary.simpleMessage("Page suivante (ctrl + ⭢)"),
        "projects_next_page_shortcut_tooltip_mac":
            MessageLookupByLibrary.simpleMessage("Page suivante (⌘ + ⭢)"),
        "projects_previous_page_shortcut_tooltip":
            MessageLookupByLibrary.simpleMessage("Page précédente (ctrl + ⭠)"),
        "projects_previous_page_shortcut_tooltip_mac":
            MessageLookupByLibrary.simpleMessage("Page précédente (⌘ + ⭠)"),
        "projects_save_project_button_tooltip":
            MessageLookupByLibrary.simpleMessage("Sauvegarder"),
        "projetcs_module_spreadsheet_open_website": m20,
        "settings_accessibility_title":
            MessageLookupByLibrary.simpleMessage("Accessibilité"),
        "settings_account_title":
            MessageLookupByLibrary.simpleMessage("Mon compte"),
        "settings_date_format": MessageLookupByLibrary.simpleMessage(
            "Préférer le format de date MM/dd"),
        "settings_date_format_subtitle":
            MessageLookupByLibrary.simpleMessage("Format de date"),
        "settings_date_format_tooltip": m21,
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
        "settings_project_privacy_subtitle":
            MessageLookupByLibrary.simpleMessage("Confidentialité"),
        "settings_project_private_project":
            MessageLookupByLibrary.simpleMessage("Projet privé"),
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
        "snackbar_delete_element_text": m22,
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
        "snackbar_welcome_back_text": m23,
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
        "tool_pomodoro_break_snackbar": m24,
        "tool_pomodoro_end_session": m25,
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
        "tool_pomodoro_work_snackbar": m26,
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
        "welcome_pass_tooltip": m27,
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
