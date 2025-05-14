// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(count) =>
      "${count} images trouvées. Voulez-vous les importer ?";

  static String m1(actionName) =>
      "Vous n\'avez aucune notes ! Cliquez sur \'${actionName}\' pour commencer à en prendre.";

  static String m2(eventName, username) =>
      "${eventName} à été complété par ${username}";

  static String m3(interval) =>
      "${Intl.plural(interval, one: 'Tous les jours', other: 'Tous les ${interval} jours')}";

  static String m4(interval) =>
      "${Intl.plural(interval, one: 'Tous les mois', other: 'Tous les ${interval} mois')}";

  static String m5(interval) =>
      "${Intl.plural(interval, one: 'Toutes les semaines', other: 'Toutes les ${interval} semaines')}";

  static String m6(interval) =>
      "${Intl.plural(interval, one: 'Tous les ans', other: 'Tous les ${interval} ans')}";

  static String m7(username) => "Complété par ${username}";

  static String m8(interval) =>
      "${Intl.plural(interval, one: 'jour', other: 'jours')}";

  static String m9(interval) =>
      "${Intl.plural(interval, one: 'mois', other: 'mois')}";

  static String m10(interval) =>
      "${Intl.plural(interval, one: 'semaine', other: 'semaines')}";

  static String m11(interval) =>
      "${Intl.plural(interval, one: 'an', other: 'ans')}";

  static String m12(week) => "Semaine ${week}";

  static String m13(username) => "Bon après-midi ${username}";

  static String m14(username) => "Bonsoir ${username}";

  static String m15(username) => "Bonjour ${username}";

  static String m16(length) =>
      "${Intl.plural(length, one: 'Entrée', other: 'Entrées')}";

  static String m17(length) =>
      "${Intl.plural(length, one: 'Sortie', other: 'Sorties')}";

  static String m18(length) =>
      "${Intl.plural(length, one: 'Copier le nœud sélectionné (⌘ + c)', other: 'Copier les nœuds sélectionnés (⌘ + c)')}";

  static String m19(length) =>
      "${Intl.plural(length, one: 'Copier le nœud sélectionné (ctrl + c)', other: 'Copier les nœuds sélectionnés (ctrl + c)')}";

  static String m20(length) =>
      "${Intl.plural(length, one: 'Supprimer le nœud sélectionné (⌘ + ⌫)', other: 'Supprimer les nœuds sélectionnés (⌘ + ⌫)')}";

  static String m21(length) =>
      "${Intl.plural(length, one: 'Supprimer le nœud sélectionné (ctrl + ⌫)', other: 'Supprimer les nœuds sélectionnés (ctrl + ⌫)')}";

  static String m22(length) =>
      "${Intl.plural(length, one: 'Dupliquer le nœud sélectionné (⌘ + d)', other: 'Dupliquer les nœuds sélectionnés (⌘ + d)')}";

  static String m23(length) =>
      "${Intl.plural(length, one: 'Dupliquer le nœud sélectionné (ctrl + d)', other: 'Dupliquer les nœuds sélectionnés (ctrl + d)')}";

  static String m24(length) =>
      "${Intl.plural(length, one: 'Coller le nœud copié (⌘ + v)', other: 'Coller les nœuds copiés (⌘ + v)')}";

  static String m25(length) =>
      "${Intl.plural(length, one: 'Coller le nœud copié (ctrl + v)', other: 'Coller les nœuds copiés (ctrl + v)')}";

  static String m26(length) =>
      "${Intl.plural(length, one: 'Masquer l\'enfant', other: 'Masquer les enfants')}";

  static String m27(length) =>
      "${Intl.plural(length, one: 'Afficher l\'enfant', other: 'Afficher les enfants')}";

  static String m28(totalNotesCount) =>
      "${Intl.plural(totalNotesCount, zero: 'Aucune note', one: '1 note', other: '${totalNotesCount} notes')}";

  static String m29(optionName) =>
      "Deux options ne peuvent pas avoir le même nom (${optionName})";

  static String m30(totalTasksCount, checkedTasks) =>
      "${Intl.plural(totalTasksCount, zero: 'Aucune tâche', one: '${checkedTasks}/${totalTasksCount} tâche terminée', other: '${checkedTasks}/${totalTasksCount} tâches terminées')}";

  static String m31(websiteName) => "Ouvrir ${websiteName}";

  static String m32(actualMonth, actualDay) =>
      "Cette option mettra le mois avant le jour. Comme ceci : ${actualMonth}/${actualDay}";

  static String m33(element) => "Supprimer ${element} ?";

  static String m34(user) => "Ravis de vous revoir ${user}";

  static String m35(duration) =>
      "${Intl.plural(duration, zero: 'Pomodoro - C\'est l\'heure de la pause', one: 'Pomodoro - C\'est l\'heure de la pause pour ${duration} minute', other: 'Pomodoro - C\'est l\'heure de la pause pour ${duration} minutes')}";

  static String m36(duration) =>
      "La session pomodoro est terminée, vous avez travaillé ${Intl.plural(duration, one: '1 minute', other: '${duration} minutes')}. Il est temps de se reposer !";

  static String m37(duration) =>
      "${Intl.plural(duration, zero: 'Pomodoro - Il est temps de retourner au travail', one: 'Pomodoro - Il est temps de retourner au travail pour ${duration} minute', other: 'Pomodoro - Il est temps de retourner au travail pour ${duration} minutes')}";

  static String m38(accountSettingName) =>
      "Vous pourrez toujours saisir votre prénom dans paramètres / ${accountSettingName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "app_name": MessageLookupByLibrary.simpleMessage("minddy"),
    "app_slogan": MessageLookupByLibrary.simpleMessage("Tout se passe ici."),
    "appbar_go_home": MessageLookupByLibrary.simpleMessage(
      "Retourner à l\'accueil",
    ),
    "articles_add_code_semantic_text": MessageLookupByLibrary.simpleMessage(
      "Ajouter un bloc de code",
    ),
    "articles_add_image_semantic_text": MessageLookupByLibrary.simpleMessage(
      "Ajouter une image",
    ),
    "articles_add_list_semantic_text": MessageLookupByLibrary.simpleMessage(
      "Ajouter une liste",
    ),
    "articles_add_source_button": MessageLookupByLibrary.simpleMessage(
      "Ajouter une source",
    ),
    "articles_add_source_hint": MessageLookupByLibrary.simpleMessage(
      "Indiquer une source...",
    ),
    "articles_add_subtitle_semantic_text": MessageLookupByLibrary.simpleMessage(
      "Ajouter un sous titre",
    ),
    "articles_add_text_semantic_text": MessageLookupByLibrary.simpleMessage(
      "Ajouter un bloc de texte",
    ),
    "articles_add_to_content": MessageLookupByLibrary.simpleMessage(
      "Ajouter à l\'article",
    ),
    "articles_bookmark_semantic_text": MessageLookupByLibrary.simpleMessage(
      "Enregister l\'article",
    ),
    "articles_bottom_menu_close_semantic_text":
        MessageLookupByLibrary.simpleMessage("Fermer le menu"),
    "articles_bottom_menu_content_button": MessageLookupByLibrary.simpleMessage(
      "Contenu",
    ),
    "articles_bottom_menu_notes_button": MessageLookupByLibrary.simpleMessage(
      "Notes",
    ),
    "articles_bottom_menu_open_semantic_text":
        MessageLookupByLibrary.simpleMessage("Ouvrir le menu"),
    "articles_bottom_menu_sources_button": MessageLookupByLibrary.simpleMessage(
      "Sources",
    ),
    "articles_calculate_reading_time": MessageLookupByLibrary.simpleMessage(
      "Calculer le temps de lecture",
    ),
    "articles_card_delete_this_article": MessageLookupByLibrary.simpleMessage(
      "cet article",
    ),
    "articles_card_untitled": MessageLookupByLibrary.simpleMessage(
      "Sans titre",
    ),
    "articles_code_hint": MessageLookupByLibrary.simpleMessage(
      "Entrez du code...",
    ),
    "articles_copy_text": MessageLookupByLibrary.simpleMessage("Copier"),
    "articles_copy_to_notes_text": MessageLookupByLibrary.simpleMessage(
      "Ajouter aux notes",
    ),
    "articles_corrupted_file": MessageLookupByLibrary.simpleMessage(
      "Cet article est corrompu",
    ),
    "articles_creativity_title": MessageLookupByLibrary.simpleMessage(
      "Créativité",
    ),
    "articles_daily_life_title": MessageLookupByLibrary.simpleMessage(
      "Quotidien",
    ),
    "articles_define_language": MessageLookupByLibrary.simpleMessage(
      "Définir le language",
    ),
    "articles_education_title": MessageLookupByLibrary.simpleMessage(
      "Éducation",
    ),
    "articles_empty_menu_page_text": MessageLookupByLibrary.simpleMessage(
      "Aucun article pour cette catégorie, importez ou écrivez-en un !",
    ),
    "articles_empty_menu_saved_page_text": MessageLookupByLibrary.simpleMessage(
      "Aucun article enregistré.",
    ),
    "articles_environment_title": MessageLookupByLibrary.simpleMessage(
      "Nature",
    ),
    "articles_export_articles": MessageLookupByLibrary.simpleMessage(
      "Exporter cet article",
    ),
    "articles_export_articles_choose_category":
        MessageLookupByLibrary.simpleMessage("Choisissez une catégorie"),
    "articles_export_canceled": MessageLookupByLibrary.simpleMessage(
      "L\'article n\'a pas été exporté",
    ),
    "articles_export_confirmed": MessageLookupByLibrary.simpleMessage(
      "L\'article a été exporté",
    ),
    "articles_export_confirmed_button": MessageLookupByLibrary.simpleMessage(
      "Voir l\'emplacement",
    ),
    "articles_finance_title": MessageLookupByLibrary.simpleMessage("Finance"),
    "articles_food_title": MessageLookupByLibrary.simpleMessage("Alimentation"),
    "articles_go_back_semantic_text": MessageLookupByLibrary.simpleMessage(
      "Retour",
    ),
    "articles_images_add_button": MessageLookupByLibrary.simpleMessage(
      "Ajouter une image",
    ),
    "articles_images_change_button": MessageLookupByLibrary.simpleMessage(
      "Changer l\'image",
    ),
    "articles_import_articles": MessageLookupByLibrary.simpleMessage(
      "Importer des articles",
    ),
    "articles_imported": MessageLookupByLibrary.simpleMessage(
      "Les articles ont été importés",
    ),
    "articles_importer_dont_import_images_button":
        MessageLookupByLibrary.simpleMessage("Ne pas importer"),
    "articles_importer_image_found_single":
        MessageLookupByLibrary.simpleMessage(
          "1 image trouvée. Voulez-vous l\'importer ?",
        ),
    "articles_importer_images_found_many": m0,
    "articles_importer_import_images_button":
        MessageLookupByLibrary.simpleMessage("Importer"),
    "articles_importer_import_images_title":
        MessageLookupByLibrary.simpleMessage("Importer des images"),
    "articles_impossible_to_load_content": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger le contenu de l\'article",
    ),
    "articles_my_articles_title": MessageLookupByLibrary.simpleMessage(
      "Mes articles",
    ),
    "articles_new_article": MessageLookupByLibrary.simpleMessage(
      "Nouvel article",
    ),
    "articles_no_content": MessageLookupByLibrary.simpleMessage(
      "Cet article est vide ! Ajoutez des éléments pour pouvoir les déplacer.",
    ),
    "articles_no_notes": m1,
    "articles_no_sources": MessageLookupByLibrary.simpleMessage(
      "Aucune source n\'a été fournie pour le moment ! N\'oubliez pas d\'inclure des sources pour les futurs lecteurs.",
    ),
    "articles_not_imported": MessageLookupByLibrary.simpleMessage(
      "Les articles n\'ont pas été impotés",
    ),
    "articles_philosophy_title": MessageLookupByLibrary.simpleMessage(
      "Philosophie",
    ),
    "articles_politics_title": MessageLookupByLibrary.simpleMessage(
      "Politique",
    ),
    "articles_professional_title": MessageLookupByLibrary.simpleMessage(
      "Professionnel",
    ),
    "articles_read_button": MessageLookupByLibrary.simpleMessage("Lire"),
    "articles_saved_title": MessageLookupByLibrary.simpleMessage("Enregistrés"),
    "articles_science_title": MessageLookupByLibrary.simpleMessage("Science"),
    "articles_search": MessageLookupByLibrary.simpleMessage("Rechercher"),
    "articles_search_empty": MessageLookupByLibrary.simpleMessage(
      "Aucun résultat",
    ),
    "articles_search_explain": MessageLookupByLibrary.simpleMessage(
      "Recherchez un titre, auteur",
    ),
    "articles_sources_text": MessageLookupByLibrary.simpleMessage("Sources"),
    "articles_subtitle_hint": MessageLookupByLibrary.simpleMessage(
      "Entrez un sous titre...",
    ),
    "articles_technology_title": MessageLookupByLibrary.simpleMessage(
      "Technologie",
    ),
    "articles_text_hint": MessageLookupByLibrary.simpleMessage(
      "Entrez du texte...",
    ),
    "articles_title_hint": MessageLookupByLibrary.simpleMessage(
      "Entrez un titre...",
    ),
    "articles_travel_title": MessageLookupByLibrary.simpleMessage("Voyage"),
    "articles_wellness_title": MessageLookupByLibrary.simpleMessage(
      "Bien-être",
    ),
    "calendar_button_add_event_button_tooltip":
        MessageLookupByLibrary.simpleMessage("Ajouter un événement"),
    "calendar_button_calendar_title": MessageLookupByLibrary.simpleMessage(
      "Calendrier",
    ),
    "calendar_button_due_date_cancel_complete":
        MessageLookupByLibrary.simpleMessage("Annuler"),
    "calendar_button_due_date_has_been_complete": m2,
    "calendar_button_event_date_today": MessageLookupByLibrary.simpleMessage(
      "Aujourd\'hui",
    ),
    "calendar_button_event_date_tomorrow": MessageLookupByLibrary.simpleMessage(
      "Demain",
    ),
    "calendar_button_event_date_yesterday":
        MessageLookupByLibrary.simpleMessage("Hier"),
    "calendar_button_event_preview_private_event":
        MessageLookupByLibrary.simpleMessage("Cet événement est privé."),
    "calendar_button_event_preview_recurence_text_every_day": m3,
    "calendar_button_event_preview_recurence_text_every_month": m4,
    "calendar_button_event_preview_recurence_text_every_week": m5,
    "calendar_button_event_preview_recurence_text_every_year": m6,
    "calendar_button_event_preview_see_button":
        MessageLookupByLibrary.simpleMessage("Voir"),
    "calendar_button_event_selection_menu_all_occurence":
        MessageLookupByLibrary.simpleMessage("Toutes les occurrences"),
    "calendar_button_event_selection_menu_only_this_event":
        MessageLookupByLibrary.simpleMessage("Seulement cet événement"),
    "calendar_button_free_for_next_days": MessageLookupByLibrary.simpleMessage(
      "Vous êtes libre pour les 5 prochains jours.",
    ),
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
          "En activant cette option, le mot de passe sera requis pour voir les événements de ce calendrier",
        ),
    "calendar_button_new_calendar_private_calendar_title":
        MessageLookupByLibrary.simpleMessage("Calendrier privé"),
    "calendar_button_new_due_date_button_title":
        MessageLookupByLibrary.simpleMessage("Date d\'échéance"),
    "calendar_button_new_event_button_title":
        MessageLookupByLibrary.simpleMessage("Événement"),
    "calendar_button_next_due_dates_title":
        MessageLookupByLibrary.simpleMessage("Dates d\'échéance"),
    "calendar_button_next_events_title": MessageLookupByLibrary.simpleMessage(
      "Prochains événements",
    ),
    "calendar_button_open_week_view_button_tooltip":
        MessageLookupByLibrary.simpleMessage("Ouvrir la vue semaine"),
    "calendar_event_detailed_preview_completed_by": m7,
    "calendar_event_detailed_preview_not_completed_yet":
        MessageLookupByLibrary.simpleMessage("Pas encore complété"),
    "calendar_main_calendar_name": MessageLookupByLibrary.simpleMessage(
      "Calendrier principal",
    ),
    "calendar_modify_due_date_title": MessageLookupByLibrary.simpleMessage(
      "Modifier la date d\'échéance",
    ),
    "calendar_modify_event_title": MessageLookupByLibrary.simpleMessage(
      "Modifier l\'événement",
    ),
    "calendar_new_due_date_event_completion_state":
        MessageLookupByLibrary.simpleMessage("État"),
    "calendar_new_due_date_event_completion_state_subtitle":
        MessageLookupByLibrary.simpleMessage("État d\'achèvement"),
    "calendar_new_due_date_title": MessageLookupByLibrary.simpleMessage(
      "Nouvelle date d\'échéance",
    ),
    "calendar_new_event_recurence_end_date":
        MessageLookupByLibrary.simpleMessage("Date de fin"),
    "calendar_new_event_recurence_end_date_option_the":
        MessageLookupByLibrary.simpleMessage("Le..."),
    "calendar_new_event_recurence_every_day": m8,
    "calendar_new_event_recurence_every_month": m9,
    "calendar_new_event_recurence_every_subtitle":
        MessageLookupByLibrary.simpleMessage("Tous les"),
    "calendar_new_event_recurence_every_week": m10,
    "calendar_new_event_recurence_every_year": m11,
    "calendar_new_event_recurence_type_subtitle":
        MessageLookupByLibrary.simpleMessage("Type"),
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
    "calendar_new_event_title": MessageLookupByLibrary.simpleMessage(
      "Nouvel événement",
    ),
    "calendar_new_event_whole_day": MessageLookupByLibrary.simpleMessage(
      "Jour entier",
    ),
    "calendar_week_view_week_details": MessageLookupByLibrary.simpleMessage(
      "Détails",
    ),
    "calendar_week_view_week_title": m12,
    "center_menu_general": MessageLookupByLibrary.simpleMessage("Général"),
    "center_menu_others": MessageLookupByLibrary.simpleMessage("Autre"),
    "custom_chart_donut_share": MessageLookupByLibrary.simpleMessage("Part"),
    "custom_chart_donut_total": MessageLookupByLibrary.simpleMessage("Total"),
    "custom_chart_empty_content": MessageLookupByLibrary.simpleMessage(
      "Pour créer un graphique, veuillez y ajouter des données",
    ),
    "custom_chart_grid_extend_chart": MessageLookupByLibrary.simpleMessage(
      "Agrandir le graphique",
    ),
    "custom_color_picker_opacity_tooltip": MessageLookupByLibrary.simpleMessage(
      "Opacité",
    ),
    "custom_date_picker_end": MessageLookupByLibrary.simpleMessage("Fin"),
    "custom_date_picker_include_hour": MessageLookupByLibrary.simpleMessage(
      "Inclure l\'heure",
    ),
    "custom_date_picker_invalid_date": MessageLookupByLibrary.simpleMessage(
      "Date invalide",
    ),
    "custom_date_picker_select_multiples_date_title":
        MessageLookupByLibrary.simpleMessage("Selectionnez des dates"),
    "custom_date_picker_select_single_date_title":
        MessageLookupByLibrary.simpleMessage("Selectionnez une date"),
    "custom_date_picker_start": MessageLookupByLibrary.simpleMessage("Début"),
    "default_app_colors_change_color": MessageLookupByLibrary.simpleMessage(
      "Changer la couleur",
    ),
    "default_app_colors_grey": MessageLookupByLibrary.simpleMessage("Gris"),
    "default_app_colors_lavender": MessageLookupByLibrary.simpleMessage(
      "Lavande",
    ),
    "default_app_colors_light_blue": MessageLookupByLibrary.simpleMessage(
      "Bleu clair",
    ),
    "default_app_colors_light_green": MessageLookupByLibrary.simpleMessage(
      "Vert clair",
    ),
    "default_app_colors_light_pink": MessageLookupByLibrary.simpleMessage(
      "Rose clair",
    ),
    "default_app_colors_light_purple": MessageLookupByLibrary.simpleMessage(
      "Violet clair",
    ),
    "default_app_colors_light_yellow": MessageLookupByLibrary.simpleMessage(
      "Jaune clair",
    ),
    "default_app_colors_mint_green": MessageLookupByLibrary.simpleMessage(
      "Vert menthe",
    ),
    "default_app_colors_peach": MessageLookupByLibrary.simpleMessage("Pêche"),
    "default_app_colors_soft_red": MessageLookupByLibrary.simpleMessage(
      "Rouge doux",
    ),
    "default_articles_articles_description":
        MessageLookupByLibrary.simpleMessage(
          "Découvrir les articles dans minddy",
        ),
    "default_articles_articles_fifth_paragraph":
        MessageLookupByLibrary.simpleMessage(
          "Avec les articles, vous avez un outil puissant et convivial pour organiser, partager et retrouver vos connaissances en toute simplicité.",
        ),
    "default_articles_articles_fifth_subtitle":
        MessageLookupByLibrary.simpleMessage("Outil Puissant"),
    "default_articles_articles_first_paragraph":
        MessageLookupByLibrary.simpleMessage(
          "Les articles sont une fonctionnalité clé de Minddy. Ils offrent une interface élégante et intuitive pour rédiger et partager vos connaissances. Grâce à cette fonctionnalité, vous pouvez facilement diffuser votre savoir et en faire profiter toute la communauté.",
        ),
    "default_articles_articles_first_subtitle":
        MessageLookupByLibrary.simpleMessage("Fonctionnalité Clé"),
    "default_articles_articles_fourth_paragraph":
        MessageLookupByLibrary.simpleMessage(
          "Les boutons pour ajouter des éléments à votre article sont situés en haut de la page. Pour gérer ce contenu, utilisez le menu en bas.",
        ),
    "default_articles_articles_fourth_subtitle":
        MessageLookupByLibrary.simpleMessage("Ajouter et Gérer du Contenu"),
    "default_articles_articles_second_paragraph":
        MessageLookupByLibrary.simpleMessage(
          "Vous pouvez également prendre des notes, idéal pour sauvegarder des textes ou tout autre contenu que vous souhaitez conserver pour plus tard. Cette fonctionnalité est parfaite pour capturer des idées ou des informations importantes à revisiter ultérieurement.",
        ),
    "default_articles_articles_second_subtitle":
        MessageLookupByLibrary.simpleMessage("Prise de Notes"),
    "default_articles_articles_third_paragraph":
        MessageLookupByLibrary.simpleMessage(
          "Toutes vos sources sont accessibles via un menu situé en bas de la page, vous permettant ainsi de gérer et de retrouver facilement vos références.",
        ),
    "default_articles_articles_third_subtitle":
        MessageLookupByLibrary.simpleMessage("Gestion des Sources"),
    "default_articles_articles_title": MessageLookupByLibrary.simpleMessage(
      "Articles",
    ),
    "greeting_afternoon": m13,
    "greeting_evening": m14,
    "greeting_morning": m15,
    "home_appbar": MessageLookupByLibrary.simpleMessage("Accueil"),
    "home_articles_card_open_hint": MessageLookupByLibrary.simpleMessage(
      "Ouvrir cet article",
    ),
    "home_discover": MessageLookupByLibrary.simpleMessage("Découvrir minddy"),
    "home_pick_up": MessageLookupByLibrary.simpleMessage(
      "Reprenez là où vous étiez",
    ),
    "icons_category_accessibility": MessageLookupByLibrary.simpleMessage(
      "Accessibilité",
    ),
    "icons_category_action": MessageLookupByLibrary.simpleMessage("Action"),
    "icons_category_bathroom": MessageLookupByLibrary.simpleMessage(
      "Salle de bain",
    ),
    "icons_category_building": MessageLookupByLibrary.simpleMessage("Bâtiment"),
    "icons_category_business": MessageLookupByLibrary.simpleMessage(
      "Entreprise",
    ),
    "icons_category_communication": MessageLookupByLibrary.simpleMessage(
      "Communication",
    ),
    "icons_category_content": MessageLookupByLibrary.simpleMessage("Contenu"),
    "icons_category_data": MessageLookupByLibrary.simpleMessage("Données"),
    "icons_category_design": MessageLookupByLibrary.simpleMessage("Design"),
    "icons_category_education": MessageLookupByLibrary.simpleMessage(
      "Éducation",
    ),
    "icons_category_finance": MessageLookupByLibrary.simpleMessage("Finance"),
    "icons_category_food": MessageLookupByLibrary.simpleMessage("Nourriture"),
    "icons_category_furniture": MessageLookupByLibrary.simpleMessage(
      "Mobilier",
    ),
    "icons_category_gesture": MessageLookupByLibrary.simpleMessage("Geste"),
    "icons_category_health": MessageLookupByLibrary.simpleMessage("Santé"),
    "icons_category_home": MessageLookupByLibrary.simpleMessage("Maison"),
    "icons_category_kitchen": MessageLookupByLibrary.simpleMessage("Cuisine"),
    "icons_category_location": MessageLookupByLibrary.simpleMessage(
      "Localisation",
    ),
    "icons_category_media": MessageLookupByLibrary.simpleMessage("Médias"),
    "icons_category_moderation": MessageLookupByLibrary.simpleMessage(
      "Modération",
    ),
    "icons_category_nature": MessageLookupByLibrary.simpleMessage("Nature"),
    "icons_category_navigation": MessageLookupByLibrary.simpleMessage(
      "Navigation",
    ),
    "icons_category_notification": MessageLookupByLibrary.simpleMessage(
      "Notification",
    ),
    "icons_category_science": MessageLookupByLibrary.simpleMessage("Science"),
    "icons_category_sleep": MessageLookupByLibrary.simpleMessage("Sommeil"),
    "icons_category_social": MessageLookupByLibrary.simpleMessage("Social"),
    "icons_category_tech": MessageLookupByLibrary.simpleMessage("Technologie"),
    "icons_category_text": MessageLookupByLibrary.simpleMessage("Texte"),
    "icons_category_time": MessageLookupByLibrary.simpleMessage("Temps"),
    "icons_category_tools": MessageLookupByLibrary.simpleMessage("Outils"),
    "icons_category_transport": MessageLookupByLibrary.simpleMessage(
      "Transport",
    ),
    "icons_category_travel": MessageLookupByLibrary.simpleMessage("Voyage"),
    "icons_category_user": MessageLookupByLibrary.simpleMessage("Utilisateur"),
    "icons_category_weather": MessageLookupByLibrary.simpleMessage("Météo"),
    "icons_tags_account": MessageLookupByLibrary.simpleMessage("Compte"),
    "icons_tags_add": MessageLookupByLibrary.simpleMessage("Ajouter"),
    "icons_tags_air": MessageLookupByLibrary.simpleMessage("Air"),
    "icons_tags_airline": MessageLookupByLibrary.simpleMessage(
      "Compagnie aérienne",
    ),
    "icons_tags_alarm": MessageLookupByLibrary.simpleMessage("Alarme"),
    "icons_tags_all": MessageLookupByLibrary.simpleMessage("Tout"),
    "icons_tags_alphabet": MessageLookupByLibrary.simpleMessage("Alphabet"),
    "icons_tags_alt": MessageLookupByLibrary.simpleMessage("Alternative"),
    "icons_tags_anchor": MessageLookupByLibrary.simpleMessage("Ancre"),
    "icons_tags_arrow": MessageLookupByLibrary.simpleMessage("Flèche"),
    "icons_tags_art": MessageLookupByLibrary.simpleMessage("Art"),
    "icons_tags_article": MessageLookupByLibrary.simpleMessage("Article"),
    "icons_tags_aspect": MessageLookupByLibrary.simpleMessage("Aspect"),
    "icons_tags_assessment": MessageLookupByLibrary.simpleMessage("Évaluation"),
    "icons_tags_assignment": MessageLookupByLibrary.simpleMessage("Devoir"),
    "icons_tags_assistant": MessageLookupByLibrary.simpleMessage("Assistant"),
    "icons_tags_attribution": MessageLookupByLibrary.simpleMessage(
      "Attribution",
    ),
    "icons_tags_audio": MessageLookupByLibrary.simpleMessage("Audio"),
    "icons_tags_auto": MessageLookupByLibrary.simpleMessage("Auto"),
    "icons_tags_av": MessageLookupByLibrary.simpleMessage("AV"),
    "icons_tags_awesome": MessageLookupByLibrary.simpleMessage("Génial"),
    "icons_tags_back": MessageLookupByLibrary.simpleMessage("Retour"),
    "icons_tags_backpack": MessageLookupByLibrary.simpleMessage("Sac à dos"),
    "icons_tags_backspace": MessageLookupByLibrary.simpleMessage(
      "Retour arrière",
    ),
    "icons_tags_bakery": MessageLookupByLibrary.simpleMessage("Boulangerie"),
    "icons_tags_balance": MessageLookupByLibrary.simpleMessage("Solde"),
    "icons_tags_balcony": MessageLookupByLibrary.simpleMessage("Balcon"),
    "icons_tags_bank": MessageLookupByLibrary.simpleMessage("Banque"),
    "icons_tags_bathtub": MessageLookupByLibrary.simpleMessage("Baignoire"),
    "icons_tags_battery": MessageLookupByLibrary.simpleMessage("Batterie"),
    "icons_tags_bed": MessageLookupByLibrary.simpleMessage("Lit"),
    "icons_tags_bedtime": MessageLookupByLibrary.simpleMessage(
      "Heure du coucher",
    ),
    "icons_tags_bento": MessageLookupByLibrary.simpleMessage("Bento"),
    "icons_tags_bike": MessageLookupByLibrary.simpleMessage("Vélo"),
    "icons_tags_biotech": MessageLookupByLibrary.simpleMessage(
      "Biotechnologie",
    ),
    "icons_tags_blender": MessageLookupByLibrary.simpleMessage("Mixeur"),
    "icons_tags_block": MessageLookupByLibrary.simpleMessage("Bloquer"),
    "icons_tags_blood": MessageLookupByLibrary.simpleMessage("Sang"),
    "icons_tags_bluetooth": MessageLookupByLibrary.simpleMessage("Bluetooth"),
    "icons_tags_blur": MessageLookupByLibrary.simpleMessage("Flou"),
    "icons_tags_boat": MessageLookupByLibrary.simpleMessage("Bateau"),
    "icons_tags_book": MessageLookupByLibrary.simpleMessage("Livre"),
    "icons_tags_bookmark": MessageLookupByLibrary.simpleMessage("Signet"),
    "icons_tags_bookmarks": MessageLookupByLibrary.simpleMessage("Signets"),
    "icons_tags_broken": MessageLookupByLibrary.simpleMessage("Cassé"),
    "icons_tags_browse": MessageLookupByLibrary.simpleMessage("Parcourir"),
    "icons_tags_bubble": MessageLookupByLibrary.simpleMessage("Bulle"),
    "icons_tags_build": MessageLookupByLibrary.simpleMessage("Construire"),
    "icons_tags_bus": MessageLookupByLibrary.simpleMessage("Bus"),
    "icons_tags_cabin": MessageLookupByLibrary.simpleMessage("Cabine"),
    "icons_tags_cable": MessageLookupByLibrary.simpleMessage("Câble"),
    "icons_tags_cafe": MessageLookupByLibrary.simpleMessage("Café"),
    "icons_tags_calendar": MessageLookupByLibrary.simpleMessage("Calendrier"),
    "icons_tags_call": MessageLookupByLibrary.simpleMessage("Appel"),
    "icons_tags_camera": MessageLookupByLibrary.simpleMessage("Appareil photo"),
    "icons_tags_cancel": MessageLookupByLibrary.simpleMessage("Annuler"),
    "icons_tags_car": MessageLookupByLibrary.simpleMessage("Voiture"),
    "icons_tags_cart": MessageLookupByLibrary.simpleMessage("Panier"),
    "icons_tags_center": MessageLookupByLibrary.simpleMessage("Centre"),
    "icons_tags_charging": MessageLookupByLibrary.simpleMessage("Chargement"),
    "icons_tags_chart": MessageLookupByLibrary.simpleMessage("Graphique"),
    "icons_tags_chat": MessageLookupByLibrary.simpleMessage("Discussion"),
    "icons_tags_check": MessageLookupByLibrary.simpleMessage("Vérifier"),
    "icons_tags_circle": MessageLookupByLibrary.simpleMessage("Cercle"),
    "icons_tags_circular": MessageLookupByLibrary.simpleMessage("Circulaire"),
    "icons_tags_clock": MessageLookupByLibrary.simpleMessage("Horloge"),
    "icons_tags_close": MessageLookupByLibrary.simpleMessage("Fermer"),
    "icons_tags_cloud": MessageLookupByLibrary.simpleMessage("Nuage"),
    "icons_tags_cloudy": MessageLookupByLibrary.simpleMessage("Nuageux"),
    "icons_tags_coffee": MessageLookupByLibrary.simpleMessage("Café"),
    "icons_tags_computer": MessageLookupByLibrary.simpleMessage("Ordinateur"),
    "icons_tags_confirm": MessageLookupByLibrary.simpleMessage("Confirmer"),
    "icons_tags_connected": MessageLookupByLibrary.simpleMessage("Connecté"),
    "icons_tags_connection": MessageLookupByLibrary.simpleMessage("Connexion"),
    "icons_tags_construction": MessageLookupByLibrary.simpleMessage(
      "Construction",
    ),
    "icons_tags_control": MessageLookupByLibrary.simpleMessage("Contrôle"),
    "icons_tags_cooking": MessageLookupByLibrary.simpleMessage("Cuisine"),
    "icons_tags_credit": MessageLookupByLibrary.simpleMessage("Crédit"),
    "icons_tags_cycling": MessageLookupByLibrary.simpleMessage("Cyclisme"),
    "icons_tags_day": MessageLookupByLibrary.simpleMessage("Jour"),
    "icons_tags_delete": MessageLookupByLibrary.simpleMessage("Supprimer"),
    "icons_tags_dining": MessageLookupByLibrary.simpleMessage("Repas"),
    "icons_tags_direction": MessageLookupByLibrary.simpleMessage("Direction"),
    "icons_tags_directions": MessageLookupByLibrary.simpleMessage("Directions"),
    "icons_tags_disabled": MessageLookupByLibrary.simpleMessage("Désactivé"),
    "icons_tags_discussion": MessageLookupByLibrary.simpleMessage("Discussion"),
    "icons_tags_document": MessageLookupByLibrary.simpleMessage("Document"),
    "icons_tags_down": MessageLookupByLibrary.simpleMessage("Bas"),
    "icons_tags_edit": MessageLookupByLibrary.simpleMessage("Éditer"),
    "icons_tags_email": MessageLookupByLibrary.simpleMessage("Email"),
    "icons_tags_end": MessageLookupByLibrary.simpleMessage("Fin"),
    "icons_tags_enhance": MessageLookupByLibrary.simpleMessage("Améliorer"),
    "icons_tags_exercise": MessageLookupByLibrary.simpleMessage("Exercice"),
    "icons_tags_farm": MessageLookupByLibrary.simpleMessage("Ferme"),
    "icons_tags_fast_food": MessageLookupByLibrary.simpleMessage("Fast-food"),
    "icons_tags_favorite": MessageLookupByLibrary.simpleMessage("Favori"),
    "icons_tags_file": MessageLookupByLibrary.simpleMessage("Fichier"),
    "icons_tags_flight": MessageLookupByLibrary.simpleMessage("Vol"),
    "icons_tags_florist": MessageLookupByLibrary.simpleMessage("Fleuriste"),
    "icons_tags_flowers": MessageLookupByLibrary.simpleMessage("Fleurs"),
    "icons_tags_forum": MessageLookupByLibrary.simpleMessage("Forum"),
    "icons_tags_forward": MessageLookupByLibrary.simpleMessage("Avant"),
    "icons_tags_front": MessageLookupByLibrary.simpleMessage("Avant"),
    "icons_tags_full": MessageLookupByLibrary.simpleMessage("Plein"),
    "icons_tags_gallery": MessageLookupByLibrary.simpleMessage("Galerie"),
    "icons_tags_games": MessageLookupByLibrary.simpleMessage("Jeux"),
    "icons_tags_hand": MessageLookupByLibrary.simpleMessage("Main"),
    "icons_tags_headphones": MessageLookupByLibrary.simpleMessage("Écouteurs"),
    "icons_tags_heart": MessageLookupByLibrary.simpleMessage("Cœur"),
    "icons_tags_help": MessageLookupByLibrary.simpleMessage("Aide"),
    "icons_tags_hiking": MessageLookupByLibrary.simpleMessage("Randonnée"),
    "icons_tags_home": MessageLookupByLibrary.simpleMessage("Maison"),
    "icons_tags_hotel": MessageLookupByLibrary.simpleMessage("Hôtel"),
    "icons_tags_house": MessageLookupByLibrary.simpleMessage("Maison"),
    "icons_tags_idea": MessageLookupByLibrary.simpleMessage("Idée"),
    "icons_tags_image": MessageLookupByLibrary.simpleMessage("Image"),
    "icons_tags_in": MessageLookupByLibrary.simpleMessage("Dans"),
    "icons_tags_inbox": MessageLookupByLibrary.simpleMessage(
      "Boîte de réception",
    ),
    "icons_tags_individual": MessageLookupByLibrary.simpleMessage("Individuel"),
    "icons_tags_input": MessageLookupByLibrary.simpleMessage("Saisie"),
    "icons_tags_internet": MessageLookupByLibrary.simpleMessage("Internet"),
    "icons_tags_ios": MessageLookupByLibrary.simpleMessage("iOS"),
    "icons_tags_job": MessageLookupByLibrary.simpleMessage("Emploi"),
    "icons_tags_keyboard": MessageLookupByLibrary.simpleMessage("Clavier"),
    "icons_tags_kitchen": MessageLookupByLibrary.simpleMessage("Cuisine"),
    "icons_tags_landscape": MessageLookupByLibrary.simpleMessage("Paysage"),
    "icons_tags_laptop": MessageLookupByLibrary.simpleMessage("Portable"),
    "icons_tags_learning": MessageLookupByLibrary.simpleMessage(
      "Apprentissage",
    ),
    "icons_tags_legroom": MessageLookupByLibrary.simpleMessage("Espace jambes"),
    "icons_tags_letters": MessageLookupByLibrary.simpleMessage("Lettres"),
    "icons_tags_light": MessageLookupByLibrary.simpleMessage("Lumière"),
    "icons_tags_like": MessageLookupByLibrary.simpleMessage("J\'aime"),
    "icons_tags_linear": MessageLookupByLibrary.simpleMessage("Linéaire"),
    "icons_tags_list": MessageLookupByLibrary.simpleMessage("Liste"),
    "icons_tags_location": MessageLookupByLibrary.simpleMessage("Emplacement"),
    "icons_tags_lock": MessageLookupByLibrary.simpleMessage("Verrouillage"),
    "icons_tags_made": MessageLookupByLibrary.simpleMessage("Fait"),
    "icons_tags_magnify": MessageLookupByLibrary.simpleMessage("Agrandir"),
    "icons_tags_map": MessageLookupByLibrary.simpleMessage("Carte"),
    "icons_tags_meal": MessageLookupByLibrary.simpleMessage("Repas"),
    "icons_tags_menu": MessageLookupByLibrary.simpleMessage("Menu"),
    "icons_tags_merge": MessageLookupByLibrary.simpleMessage("Fusionner"),
    "icons_tags_message": MessageLookupByLibrary.simpleMessage("Message"),
    "icons_tags_metro": MessageLookupByLibrary.simpleMessage("Métro"),
    "icons_tags_microphone": MessageLookupByLibrary.simpleMessage("Microphone"),
    "icons_tags_missed": MessageLookupByLibrary.simpleMessage("Manqué"),
    "icons_tags_mobile": MessageLookupByLibrary.simpleMessage("Mobile"),
    "icons_tags_modify": MessageLookupByLibrary.simpleMessage("Modifier"),
    "icons_tags_more": MessageLookupByLibrary.simpleMessage("Plus"),
    "icons_tags_mosaic": MessageLookupByLibrary.simpleMessage("Mosaïque"),
    "icons_tags_motion": MessageLookupByLibrary.simpleMessage("Mouvement"),
    "icons_tags_motorcycle": MessageLookupByLibrary.simpleMessage("Moto"),
    "icons_tags_music": MessageLookupByLibrary.simpleMessage("Musique"),
    "icons_tags_nature": MessageLookupByLibrary.simpleMessage("Nature"),
    "icons_tags_navigation": MessageLookupByLibrary.simpleMessage("Navigation"),
    "icons_tags_network": MessageLookupByLibrary.simpleMessage("Réseau"),
    "icons_tags_new": MessageLookupByLibrary.simpleMessage("Nouveau"),
    "icons_tags_note": MessageLookupByLibrary.simpleMessage("Note"),
    "icons_tags_off": MessageLookupByLibrary.simpleMessage("Éteint"),
    "icons_tags_on": MessageLookupByLibrary.simpleMessage("Allumé"),
    "icons_tags_options": MessageLookupByLibrary.simpleMessage("Options"),
    "icons_tags_out": MessageLookupByLibrary.simpleMessage("Sortie"),
    "icons_tags_outdoor": MessageLookupByLibrary.simpleMessage("Extérieur"),
    "icons_tags_outdoors": MessageLookupByLibrary.simpleMessage("Plein air"),
    "icons_tags_paint": MessageLookupByLibrary.simpleMessage("Peinture"),
    "icons_tags_phone": MessageLookupByLibrary.simpleMessage("Téléphone"),
    "icons_tags_photo": MessageLookupByLibrary.simpleMessage("Photo"),
    "icons_tags_place": MessageLookupByLibrary.simpleMessage("Lieu"),
    "icons_tags_play": MessageLookupByLibrary.simpleMessage("Jouer"),
    "icons_tags_plus": MessageLookupByLibrary.simpleMessage("Plus"),
    "icons_tags_preferences": MessageLookupByLibrary.simpleMessage(
      "Préférences",
    ),
    "icons_tags_print": MessageLookupByLibrary.simpleMessage("Imprimer"),
    "icons_tags_printer": MessageLookupByLibrary.simpleMessage("Imprimante"),
    "icons_tags_profile": MessageLookupByLibrary.simpleMessage("Profil"),
    "icons_tags_public": MessageLookupByLibrary.simpleMessage("Public"),
    "icons_tags_public_transport": MessageLookupByLibrary.simpleMessage(
      "Transport public",
    ),
    "icons_tags_rail": MessageLookupByLibrary.simpleMessage("Rail"),
    "icons_tags_rain": MessageLookupByLibrary.simpleMessage("Pluie"),
    "icons_tags_ratio": MessageLookupByLibrary.simpleMessage("Ratio"),
    "icons_tags_reading": MessageLookupByLibrary.simpleMessage("Lecture"),
    "icons_tags_rear": MessageLookupByLibrary.simpleMessage("Arrière"),
    "icons_tags_received": MessageLookupByLibrary.simpleMessage("Reçu"),
    "icons_tags_recline": MessageLookupByLibrary.simpleMessage("Inclinable"),
    "icons_tags_reduce": MessageLookupByLibrary.simpleMessage("Réduire"),
    "icons_tags_relax": MessageLookupByLibrary.simpleMessage("Relaxation"),
    "icons_tags_relaxation": MessageLookupByLibrary.simpleMessage("Détente"),
    "icons_tags_remove": MessageLookupByLibrary.simpleMessage("Retirer"),
    "icons_tags_renew": MessageLookupByLibrary.simpleMessage("Renouveler"),
    "icons_tags_rental": MessageLookupByLibrary.simpleMessage("Location"),
    "icons_tags_report": MessageLookupByLibrary.simpleMessage("Rapport"),
    "icons_tags_restaurant": MessageLookupByLibrary.simpleMessage("Restaurant"),
    "icons_tags_right": MessageLookupByLibrary.simpleMessage("Droite"),
    "icons_tags_road": MessageLookupByLibrary.simpleMessage("Route"),
    "icons_tags_router": MessageLookupByLibrary.simpleMessage("Routeur"),
    "icons_tags_rowing": MessageLookupByLibrary.simpleMessage("Aviron"),
    "icons_tags_running": MessageLookupByLibrary.simpleMessage("Course"),
    "icons_tags_save": MessageLookupByLibrary.simpleMessage("Enregistrer"),
    "icons_tags_school": MessageLookupByLibrary.simpleMessage("École"),
    "icons_tags_science": MessageLookupByLibrary.simpleMessage("Science"),
    "icons_tags_screen": MessageLookupByLibrary.simpleMessage("Écran"),
    "icons_tags_searching": MessageLookupByLibrary.simpleMessage("Recherche"),
    "icons_tags_seat": MessageLookupByLibrary.simpleMessage("Siège"),
    "icons_tags_security": MessageLookupByLibrary.simpleMessage("Sécurité"),
    "icons_tags_send": MessageLookupByLibrary.simpleMessage("Envoyer"),
    "icons_tags_settings": MessageLookupByLibrary.simpleMessage("Paramètres"),
    "icons_tags_share": MessageLookupByLibrary.simpleMessage("Partager"),
    "icons_tags_shopping": MessageLookupByLibrary.simpleMessage("Shopping"),
    "icons_tags_sleep": MessageLookupByLibrary.simpleMessage("Sommeil"),
    "icons_tags_smartphone": MessageLookupByLibrary.simpleMessage("Smartphone"),
    "icons_tags_snowboarding": MessageLookupByLibrary.simpleMessage(
      "Snowboard",
    ),
    "icons_tags_social": MessageLookupByLibrary.simpleMessage("Social"),
    "icons_tags_sound": MessageLookupByLibrary.simpleMessage("Son"),
    "icons_tags_spa": MessageLookupByLibrary.simpleMessage("Spa"),
    "icons_tags_speaker": MessageLookupByLibrary.simpleMessage("Haut-parleur"),
    "icons_tags_split": MessageLookupByLibrary.simpleMessage("Diviser"),
    "icons_tags_sports": MessageLookupByLibrary.simpleMessage("Sports"),
    "icons_tags_standard": MessageLookupByLibrary.simpleMessage("Standard"),
    "icons_tags_star": MessageLookupByLibrary.simpleMessage("Étoile"),
    "icons_tags_stay": MessageLookupByLibrary.simpleMessage("Séjour"),
    "icons_tags_stop": MessageLookupByLibrary.simpleMessage("Arrêter"),
    "icons_tags_store": MessageLookupByLibrary.simpleMessage("Magasin"),
    "icons_tags_subway": MessageLookupByLibrary.simpleMessage("Métro"),
    "icons_tags_suite": MessageLookupByLibrary.simpleMessage("Suite"),
    "icons_tags_sunny": MessageLookupByLibrary.simpleMessage("Ensoleillé"),
    "icons_tags_support": MessageLookupByLibrary.simpleMessage("Support"),
    "icons_tags_task": MessageLookupByLibrary.simpleMessage("Tâche"),
    "icons_tags_television": MessageLookupByLibrary.simpleMessage("Télévision"),
    "icons_tags_temperature": MessageLookupByLibrary.simpleMessage(
      "Température",
    ),
    "icons_tags_terrain": MessageLookupByLibrary.simpleMessage("Terrain"),
    "icons_tags_thermostat": MessageLookupByLibrary.simpleMessage("Thermostat"),
    "icons_tags_thumb": MessageLookupByLibrary.simpleMessage("Pouce"),
    "icons_tags_time": MessageLookupByLibrary.simpleMessage("Temps"),
    "icons_tags_timer": MessageLookupByLibrary.simpleMessage("Minuteur"),
    "icons_tags_today": MessageLookupByLibrary.simpleMessage("Aujourd\'hui"),
    "icons_tags_tools": MessageLookupByLibrary.simpleMessage("Outils"),
    "icons_tags_traffic": MessageLookupByLibrary.simpleMessage("Trafic"),
    "icons_tags_train": MessageLookupByLibrary.simpleMessage("Train"),
    "icons_tags_transit": MessageLookupByLibrary.simpleMessage("Transit"),
    "icons_tags_transport": MessageLookupByLibrary.simpleMessage("Transport"),
    "icons_tags_travel": MessageLookupByLibrary.simpleMessage("Voyage"),
    "icons_tags_turned": MessageLookupByLibrary.simpleMessage("Tourné"),
    "icons_tags_tv": MessageLookupByLibrary.simpleMessage("Télévision"),
    "icons_tags_type": MessageLookupByLibrary.simpleMessage("Type"),
    "icons_tags_umbrella": MessageLookupByLibrary.simpleMessage("Parapluie"),
    "icons_tags_unknown": MessageLookupByLibrary.simpleMessage("Inconnu"),
    "icons_tags_up": MessageLookupByLibrary.simpleMessage("Haut"),
    "icons_tags_upward": MessageLookupByLibrary.simpleMessage("Vers le haut"),
    "icons_tags_usb": MessageLookupByLibrary.simpleMessage("USB"),
    "icons_tags_user": MessageLookupByLibrary.simpleMessage("Utilisateur"),
    "icons_tags_vehicle": MessageLookupByLibrary.simpleMessage("Véhicule"),
    "icons_tags_video": MessageLookupByLibrary.simpleMessage("Vidéo"),
    "icons_tags_view": MessageLookupByLibrary.simpleMessage("Vue"),
    "icons_tags_volume": MessageLookupByLibrary.simpleMessage("Volume"),
    "icons_tags_walking": MessageLookupByLibrary.simpleMessage("Marche"),
    "icons_tags_watch": MessageLookupByLibrary.simpleMessage("Montre"),
    "icons_tags_water": MessageLookupByLibrary.simpleMessage("Eau"),
    "icons_tags_waves": MessageLookupByLibrary.simpleMessage("Vagues"),
    "icons_tags_weather": MessageLookupByLibrary.simpleMessage("Météo"),
    "icons_tags_web": MessageLookupByLibrary.simpleMessage("Web"),
    "icons_tags_wheelchair": MessageLookupByLibrary.simpleMessage(
      "Fauteuil roulant",
    ),
    "icons_tags_wifi": MessageLookupByLibrary.simpleMessage("Wifi"),
    "icons_tags_wireless": MessageLookupByLibrary.simpleMessage("Sans fil"),
    "icons_tags_work": MessageLookupByLibrary.simpleMessage("Travail"),
    "icons_tags_yard": MessageLookupByLibrary.simpleMessage("Jardin"),
    "icons_tags_zoom": MessageLookupByLibrary.simpleMessage("Zoom"),
    "node_editor_add_sub_menu_add_button": MessageLookupByLibrary.simpleMessage(
      "Ajouter",
    ),
    "node_editor_add_sub_menu_inputs_subtitle": m16,
    "node_editor_add_sub_menu_no_nodes_found":
        MessageLookupByLibrary.simpleMessage("Aucun nœud trouvé."),
    "node_editor_add_sub_menu_none_input_output":
        MessageLookupByLibrary.simpleMessage("Aucune"),
    "node_editor_add_sub_menu_note": MessageLookupByLibrary.simpleMessage(
      "Remarque: les entrées et sorties peuvent varier en fonction des options choisies pour le nœud",
    ),
    "node_editor_add_sub_menu_outputs_subtitle": m17,
    "node_editor_add_sub_menu_types": MessageLookupByLibrary.simpleMessage(
      "Types",
    ),
    "node_editor_view_bottom_toolbar_copy_tooltip_mac": m18,
    "node_editor_view_bottom_toolbar_copy_tooltip_windows": m19,
    "node_editor_view_bottom_toolbar_delete_tooltip_mac": m20,
    "node_editor_view_bottom_toolbar_delete_tooltip_windows": m21,
    "node_editor_view_bottom_toolbar_duplicate_tooltip_mac": m22,
    "node_editor_view_bottom_toolbar_duplicate_tooltip_windows": m23,
    "node_editor_view_bottom_toolbar_paste_tooltip_mac": m24,
    "node_editor_view_bottom_toolbar_paste_tooltip_windows": m25,
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
    "node_editor_view_new_node_tooltip": MessageLookupByLibrary.simpleMessage(
      "Nouveau nœud",
    ),
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
          "Effectue des opérations sur des booléens.",
        ),
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
    "node_widgets_boolean_node_title": MessageLookupByLibrary.simpleMessage(
      "Opérations logiques",
    ),
    "node_widgets_category_logic": MessageLookupByLibrary.simpleMessage(
      "Logique",
    ),
    "node_widgets_category_math": MessageLookupByLibrary.simpleMessage("Maths"),
    "node_widgets_category_variable": MessageLookupByLibrary.simpleMessage(
      "Variables",
    ),
    "node_widgets_comparison_node_description":
        MessageLookupByLibrary.simpleMessage(
          "Effectue une comparaison entre des nombres.",
        ),
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
    "node_widgets_comparison_node_title": MessageLookupByLibrary.simpleMessage(
      "Comparaison",
    ),
    "node_widgets_conversion_node_decsription":
        MessageLookupByLibrary.simpleMessage(
          "Convertit une valeur vers autre type",
        ),
    "node_widgets_conversion_node_title": MessageLookupByLibrary.simpleMessage(
      "Conversion",
    ),
    "node_widgets_end_text": MessageLookupByLibrary.simpleMessage("Fin"),
    "node_widgets_get_variable_node_description":
        MessageLookupByLibrary.simpleMessage(
          "Obtient la valeur d\'une variable.",
        ),
    "node_widgets_get_variable_node_title":
        MessageLookupByLibrary.simpleMessage("Obtenir la variable"),
    "node_widgets_length_text": MessageLookupByLibrary.simpleMessage(
      "Longueur",
    ),
    "node_widgets_math_node_description": MessageLookupByLibrary.simpleMessage(
      "Effectue des calculs sur des nombres.",
    ),
    "node_widgets_math_node_options_abs": MessageLookupByLibrary.simpleMessage(
      "Valeur absolue",
    ),
    "node_widgets_math_node_options_acos": MessageLookupByLibrary.simpleMessage(
      "Arc cosinus",
    ),
    "node_widgets_math_node_options_acosh":
        MessageLookupByLibrary.simpleMessage("Arc cosh"),
    "node_widgets_math_node_options_addition":
        MessageLookupByLibrary.simpleMessage("Addition"),
    "node_widgets_math_node_options_asin": MessageLookupByLibrary.simpleMessage(
      "Arc sinus",
    ),
    "node_widgets_math_node_options_asinh":
        MessageLookupByLibrary.simpleMessage("Arc sinh"),
    "node_widgets_math_node_options_atan": MessageLookupByLibrary.simpleMessage(
      "Arc tangente",
    ),
    "node_widgets_math_node_options_atanh":
        MessageLookupByLibrary.simpleMessage("Arc tanh"),
    "node_widgets_math_node_options_ceil": MessageLookupByLibrary.simpleMessage(
      "Plafond",
    ),
    "node_widgets_math_node_options_cos": MessageLookupByLibrary.simpleMessage(
      "Cosinus",
    ),
    "node_widgets_math_node_options_cosh": MessageLookupByLibrary.simpleMessage(
      "Cosh",
    ),
    "node_widgets_math_node_options_division":
        MessageLookupByLibrary.simpleMessage("Division"),
    "node_widgets_math_node_options_floor":
        MessageLookupByLibrary.simpleMessage("Plancher"),
    "node_widgets_math_node_options_ln": MessageLookupByLibrary.simpleMessage(
      "Logarithme népérien",
    ),
    "node_widgets_math_node_options_log10":
        MessageLookupByLibrary.simpleMessage("Logarithme en base 10"),
    "node_widgets_math_node_options_max": MessageLookupByLibrary.simpleMessage(
      "Maximum",
    ),
    "node_widgets_math_node_options_min": MessageLookupByLibrary.simpleMessage(
      "Minimum",
    ),
    "node_widgets_math_node_options_multiplication":
        MessageLookupByLibrary.simpleMessage("Multiplication"),
    "node_widgets_math_node_options_power":
        MessageLookupByLibrary.simpleMessage("Puissance"),
    "node_widgets_math_node_options_round":
        MessageLookupByLibrary.simpleMessage("Arrondi"),
    "node_widgets_math_node_options_sign": MessageLookupByLibrary.simpleMessage(
      "Signe",
    ),
    "node_widgets_math_node_options_sin": MessageLookupByLibrary.simpleMessage(
      "Sinus",
    ),
    "node_widgets_math_node_options_sinh": MessageLookupByLibrary.simpleMessage(
      "Sinh",
    ),
    "node_widgets_math_node_options_squareRoot":
        MessageLookupByLibrary.simpleMessage("Racine carrée"),
    "node_widgets_math_node_options_substraction":
        MessageLookupByLibrary.simpleMessage("Soustraction"),
    "node_widgets_math_node_options_tan": MessageLookupByLibrary.simpleMessage(
      "Tangente",
    ),
    "node_widgets_math_node_options_tanh": MessageLookupByLibrary.simpleMessage(
      "Tanh",
    ),
    "node_widgets_math_node_options_truncate":
        MessageLookupByLibrary.simpleMessage("Tronquer"),
    "node_widgets_math_node_title": MessageLookupByLibrary.simpleMessage(
      "Calculs",
    ),
    "node_widgets_random_number_node_description":
        MessageLookupByLibrary.simpleMessage(
          "Génère un nombre aléatoire entre un minimum et un maximum (0 et 1 par défaut).",
        ),
    "node_widgets_random_number_node_title":
        MessageLookupByLibrary.simpleMessage("Nombre aléatoire"),
    "node_widgets_result_text": MessageLookupByLibrary.simpleMessage(
      "Résultat",
    ),
    "node_widgets_select_variable_node_text":
        MessageLookupByLibrary.simpleMessage("Sélectionnez une variable"),
    "node_widgets_set_variable_node_description":
        MessageLookupByLibrary.simpleMessage(
          "Définit la valeur d\'une variable.",
        ),
    "node_widgets_set_variable_node_title":
        MessageLookupByLibrary.simpleMessage("Définir la variable"),
    "node_widgets_start_text": MessageLookupByLibrary.simpleMessage("Début"),
    "node_widgets_text_operation_node_decsription":
        MessageLookupByLibrary.simpleMessage(
          "Effectue des opérations sur du texte",
        ),
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
    "node_widgets_treshold_text": MessageLookupByLibrary.simpleMessage(
      "Limite",
    ),
    "node_widgets_value_text": MessageLookupByLibrary.simpleMessage("Valeur"),
    "plugin_editor_ui_side_panel_layers_add_button":
        MessageLookupByLibrary.simpleMessage("Nouveau composant"),
    "plugin_editor_ui_side_panel_layers_add_child":
        MessageLookupByLibrary.simpleMessage("Ajouter un enfant"),
    "plugin_editor_ui_side_panel_layers_hide_child": m26,
    "plugin_editor_ui_side_panel_layers_more_options":
        MessageLookupByLibrary.simpleMessage("Plus d\'options"),
    "plugin_editor_ui_side_panel_layers_show_child": m27,
    "plugin_editor_ui_side_panel_layers_title":
        MessageLookupByLibrary.simpleMessage("Composants"),
    "plugin_editor_ui_side_panel_properties_border_subtitle":
        MessageLookupByLibrary.simpleMessage("Bordure"),
    "plugin_editor_ui_side_panel_properties_size_height":
        MessageLookupByLibrary.simpleMessage("Hauteur"),
    "plugin_editor_ui_side_panel_properties_size_subtitle":
        MessageLookupByLibrary.simpleMessage("Taille"),
    "plugin_editor_ui_side_panel_properties_size_width":
        MessageLookupByLibrary.simpleMessage("Largeur"),
    "plugin_editor_ui_side_panel_properties_style_alignment":
        MessageLookupByLibrary.simpleMessage("Alignement"),
    "plugin_editor_ui_side_panel_properties_style_alignment_all":
        MessageLookupByLibrary.simpleMessage("Tous"),
    "plugin_editor_ui_side_panel_properties_style_alignment_bottom":
        MessageLookupByLibrary.simpleMessage("En bas"),
    "plugin_editor_ui_side_panel_properties_style_alignment_bottom_left":
        MessageLookupByLibrary.simpleMessage("En bas à gauche"),
    "plugin_editor_ui_side_panel_properties_style_alignment_bottom_right":
        MessageLookupByLibrary.simpleMessage("En bas à droite"),
    "plugin_editor_ui_side_panel_properties_style_alignment_left":
        MessageLookupByLibrary.simpleMessage("À gauche"),
    "plugin_editor_ui_side_panel_properties_style_alignment_multiples":
        MessageLookupByLibrary.simpleMessage("Sélection"),
    "plugin_editor_ui_side_panel_properties_style_alignment_right":
        MessageLookupByLibrary.simpleMessage("À droite"),
    "plugin_editor_ui_side_panel_properties_style_alignment_top":
        MessageLookupByLibrary.simpleMessage("En haut"),
    "plugin_editor_ui_side_panel_properties_style_alignment_top_left":
        MessageLookupByLibrary.simpleMessage("En haut à gauche"),
    "plugin_editor_ui_side_panel_properties_style_alignment_top_right":
        MessageLookupByLibrary.simpleMessage("En haut à droite"),
    "plugin_editor_ui_side_panel_properties_style_border_radius":
        MessageLookupByLibrary.simpleMessage("Arrondi"),
    "plugin_editor_ui_side_panel_properties_style_border_thickness":
        MessageLookupByLibrary.simpleMessage("Épaisseur"),
    "plugin_editor_ui_side_panel_properties_style_subtitle":
        MessageLookupByLibrary.simpleMessage("Style"),
    "plugin_editor_ui_side_panel_properties_theme_colors_accent":
        MessageLookupByLibrary.simpleMessage("Accentuation"),
    "plugin_editor_ui_side_panel_properties_theme_colors_primary":
        MessageLookupByLibrary.simpleMessage("Primaire"),
    "plugin_editor_ui_side_panel_properties_theme_colors_primary_transparent":
        MessageLookupByLibrary.simpleMessage("Primaire transparent"),
    "plugin_editor_ui_side_panel_properties_theme_colors_surface":
        MessageLookupByLibrary.simpleMessage("Surface"),
    "project_card_delete": MessageLookupByLibrary.simpleMessage("Supprimer"),
    "project_card_duplicate": MessageLookupByLibrary.simpleMessage("Dupliquer"),
    "project_card_open_settings": MessageLookupByLibrary.simpleMessage(
      "Modifier",
    ),
    "projects_add_module_tooltip": MessageLookupByLibrary.simpleMessage(
      "Nouveau module",
    ),
    "projects_module_help_text": MessageLookupByLibrary.simpleMessage("Aide"),
    "projects_module_notes_category_note_count": m28,
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
        MessageLookupByLibrary.simpleMessage("Veuillez nommer la catégorie"),
    "projects_module_notes_new_category_sub_menu_is_private":
        MessageLookupByLibrary.simpleMessage("Categorie privée"),
    "projects_module_notes_new_category_sub_menu_is_private_tooltip":
        MessageLookupByLibrary.simpleMessage(
          "En activant cette option, votre mot de passe sera requis pour ouvrir cette catégorie.",
        ),
    "projects_module_notes_new_category_sub_menu_name_hint":
        MessageLookupByLibrary.simpleMessage("Entrez le nom de la catégorie"),
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
    "projects_module_notes_title": MessageLookupByLibrary.simpleMessage(
      "Notes",
    ),
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
    "projects_module_spreadsheet_new_row": MessageLookupByLibrary.simpleMessage(
      "Nouvelle ligne",
    ),
    "projects_module_spreadsheet_number_operation_average":
        MessageLookupByLibrary.simpleMessage("Moyenne"),
    "projects_module_spreadsheet_number_operation_average_example":
        MessageLookupByLibrary.simpleMessage("(10 + 50 + 100) / 3"),
    "projects_module_spreadsheet_number_operation_average_message":
        MessageLookupByLibrary.simpleMessage(
          "Calcule la moyenne en divisant la somme de toutes les valeurs par le nombre de valeurs. Cela aide à trouver la valeur centrale des données.",
        ),
    "projects_module_spreadsheet_number_operation_calculate":
        MessageLookupByLibrary.simpleMessage("Calculer"),
    "projects_module_spreadsheet_number_operation_interval":
        MessageLookupByLibrary.simpleMessage("Intervalle"),
    "projects_module_spreadsheet_number_operation_interval_example":
        MessageLookupByLibrary.simpleMessage("(10, 50, 100) = 90"),
    "projects_module_spreadsheet_number_operation_interval_message":
        MessageLookupByLibrary.simpleMessage(
          "Calcule la plage en soustrayant la plus petite valeur de la plus grande valeur dans la colonne. Cela montre la répartition des valeurs.",
        ),
    "projects_module_spreadsheet_number_operation_maximum":
        MessageLookupByLibrary.simpleMessage("Maximum"),
    "projects_module_spreadsheet_number_operation_maximum_example":
        MessageLookupByLibrary.simpleMessage("(10, 50, 100) = 100"),
    "projects_module_spreadsheet_number_operation_maximum_message":
        MessageLookupByLibrary.simpleMessage(
          "Trouve la valeur la plus élevée dans la colonne. Utile pour identifier le plus grand nombre.",
        ),
    "projects_module_spreadsheet_number_operation_median":
        MessageLookupByLibrary.simpleMessage("Médiane"),
    "projects_module_spreadsheet_number_operation_median_example":
        MessageLookupByLibrary.simpleMessage("(10, 50, 100) = 50"),
    "projects_module_spreadsheet_number_operation_median_message":
        MessageLookupByLibrary.simpleMessage(
          "Trouve la valeur centrale lorsque les valeurs des colonnes sont triées. Utile pour identifier la valeur centrale.",
        ),
    "projects_module_spreadsheet_number_operation_minimum":
        MessageLookupByLibrary.simpleMessage("Minimum"),
    "projects_module_spreadsheet_number_operation_minimum_example":
        MessageLookupByLibrary.simpleMessage("(10, 50, 100) = 10"),
    "projects_module_spreadsheet_number_operation_minimum_message":
        MessageLookupByLibrary.simpleMessage(
          "Trouve la valeur la plus basse dans la colonne. Cela aide à identifier le plus petit nombre.",
        ),
    "projects_module_spreadsheet_number_operation_none":
        MessageLookupByLibrary.simpleMessage("Aucun"),
    "projects_module_spreadsheet_number_operation_standardDeviation_example":
        MessageLookupByLibrary.simpleMessage(
          "√[((10-53.33)² + (50-53.33)² + (100-53.33)²) / 3]",
        ),
    "projects_module_spreadsheet_number_operation_standardDeviation_message":
        MessageLookupByLibrary.simpleMessage(
          "Calcule l\'écart type pour mesurer dans quelle mesure les valeurs varient par rapport à la moyenne. Ici, 53,33 est la moyenne des valeurs 10, 50 et 100.",
        ),
    "projects_module_spreadsheet_number_operation_standard_deviation":
        MessageLookupByLibrary.simpleMessage("Écart type"),
    "projects_module_spreadsheet_number_operation_sum":
        MessageLookupByLibrary.simpleMessage("Somme"),
    "projects_module_spreadsheet_number_operation_sum_example":
        MessageLookupByLibrary.simpleMessage("10 + 50 + 100"),
    "projects_module_spreadsheet_number_operation_sum_message":
        MessageLookupByLibrary.simpleMessage(
          "Ajoute toutes les valeurs de la colonne pour obtenir le total. Utile pour résumer les données.",
        ),
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
        MessageLookupByLibrary.simpleMessage("Veuillez ajouter des options"),
    "projects_module_spreadsheet_selection_sub_menu_error_message_redundant_color":
        MessageLookupByLibrary.simpleMessage(
          "Deux options ne peuvent pas avoir la même couleur",
        ),
    "projects_module_spreadsheet_selection_sub_menu_error_message_redundant_option_name":
        m29,
    "projects_module_spreadsheet_selection_sub_menu_error_message_unnamed_option":
        MessageLookupByLibrary.simpleMessage(
          "Veuillez nommer toutes les options",
        ),
    "projects_module_spreadsheet_title": MessageLookupByLibrary.simpleMessage(
      "Tableau",
    ),
    "projects_module_spreadsheet_value_unnamed":
        MessageLookupByLibrary.simpleMessage("Sans nom"),
    "projects_module_tasks_add_task_tooltip":
        MessageLookupByLibrary.simpleMessage("Ajouter une nouvelle tâche"),
    "projects_module_tasks_completed": m30,
    "projects_module_tasks_task_add_subtask_tooltip":
        MessageLookupByLibrary.simpleMessage("Ajouter une sous-tâche"),
    "projects_module_tasks_task_title_hint":
        MessageLookupByLibrary.simpleMessage("Titre"),
    "projects_module_tasks_title": MessageLookupByLibrary.simpleMessage(
      "Tâches",
    ),
    "projects_next_page_shortcut_tooltip": MessageLookupByLibrary.simpleMessage(
      "Page suivante (ctrl + ⭢)",
    ),
    "projects_next_page_shortcut_tooltip_mac":
        MessageLookupByLibrary.simpleMessage("Page suivante (⌘ + ⭢)"),
    "projects_previous_page_shortcut_tooltip":
        MessageLookupByLibrary.simpleMessage("Page précédente (ctrl + ⭠)"),
    "projects_previous_page_shortcut_tooltip_mac":
        MessageLookupByLibrary.simpleMessage("Page précédente (⌘ + ⭠)"),
    "projects_save_project_button_tooltip":
        MessageLookupByLibrary.simpleMessage("Sauvegarder"),
    "projetcs_module_spreadsheet_open_website": m31,
    "settings_accessibility_title": MessageLookupByLibrary.simpleMessage(
      "Accessibilité",
    ),
    "settings_account_title": MessageLookupByLibrary.simpleMessage(
      "Mon compte",
    ),
    "settings_date_format": MessageLookupByLibrary.simpleMessage(
      "Préférer le format de date MM/dd",
    ),
    "settings_date_format_subtitle": MessageLookupByLibrary.simpleMessage(
      "Format de date",
    ),
    "settings_date_format_tooltip": m32,
    "settings_language_subtitle": MessageLookupByLibrary.simpleMessage(
      "Langue",
    ),
    "settings_need_to_quit_project_to_change_language":
        MessageLookupByLibrary.simpleMessage(
          "Pour changer de langue, veuillez revenir à l\'accueil",
        ),
    "settings_need_to_quit_project_to_change_theme":
        MessageLookupByLibrary.simpleMessage(
          "Pour changer les paramètres de thème, veuillez revenir à l\'accueil",
        ),
    "settings_personalize_black_and_white_title":
        MessageLookupByLibrary.simpleMessage("Mode noir et blanc"),
    "settings_personalize_title": MessageLookupByLibrary.simpleMessage(
      "Personnaliser",
    ),
    "settings_project_delete_button": MessageLookupByLibrary.simpleMessage(
      "Supprimer ce projet",
    ),
    "settings_project_delete_subtitle": MessageLookupByLibrary.simpleMessage(
      "Supprimer",
    ),
    "settings_project_privacy_subtitle": MessageLookupByLibrary.simpleMessage(
      "Confidentialité",
    ),
    "settings_project_private_project": MessageLookupByLibrary.simpleMessage(
      "Projet privé",
    ),
    "settings_project_rename_button": MessageLookupByLibrary.simpleMessage(
      "Renommer",
    ),
    "settings_project_rename_subtitle": MessageLookupByLibrary.simpleMessage(
      "Renommer",
    ),
    "settings_reset_button": MessageLookupByLibrary.simpleMessage(
      "Réinitialiser les paramètres",
    ),
    "settings_reset_subtitle": MessageLookupByLibrary.simpleMessage(
      "Réinitialiser",
    ),
    "settings_security_title": MessageLookupByLibrary.simpleMessage("Sécurité"),
    "settings_theme_subtitle": MessageLookupByLibrary.simpleMessage("Thème"),
    "settings_title": MessageLookupByLibrary.simpleMessage("Paramètres"),
    "settings_username_subtitle": MessageLookupByLibrary.simpleMessage(
      "Prénom",
    ),
    "settings_using_dark_mode": MessageLookupByLibrary.simpleMessage(
      "Mode sombre",
    ),
    "settings_using_light_mode": MessageLookupByLibrary.simpleMessage(
      "Mode clair",
    ),
    "settings_using_system_theme": MessageLookupByLibrary.simpleMessage(
      "Thème du système",
    ),
    "snackbar_articles_saved": MessageLookupByLibrary.simpleMessage(
      "Cet article à été enregistré",
    ),
    "snackbar_articles_unsaved": MessageLookupByLibrary.simpleMessage(
      "Cet article n\'est plus enregistré",
    ),
    "snackbar_cancel_button": MessageLookupByLibrary.simpleMessage("Fermer"),
    "snackbar_close_button": MessageLookupByLibrary.simpleMessage("Fermer"),
    "snackbar_delete_button": MessageLookupByLibrary.simpleMessage("Supprimer"),
    "snackbar_delete_element_text": m33,
    "snackbar_reset_button": MessageLookupByLibrary.simpleMessage(
      "Réinitialiser",
    ),
    "snackbar_reset_text": MessageLookupByLibrary.simpleMessage(
      "Réinitialiser les paramètres ?",
    ),
    "snackbar_restart_button": MessageLookupByLibrary.simpleMessage(
      "Fermer l\'app",
    ),
    "snackbar_restart_needed_text": MessageLookupByLibrary.simpleMessage(
      "Vous devrez redémarrer l\'application pour appliquer les modifications",
    ),
    "snackbar_welcome_back_button": MessageLookupByLibrary.simpleMessage(
      "Merci",
    ),
    "snackbar_welcome_back_text": m34,
    "submenu_artilces_image_description_button":
        MessageLookupByLibrary.simpleMessage("Valider"),
    "submenu_artilces_image_description_hint":
        MessageLookupByLibrary.simpleMessage("Décrivez l\'image..."),
    "submenu_artilces_image_description_subtitle":
        MessageLookupByLibrary.simpleMessage("Description de l\'image"),
    "submenu_artilces_image_description_title":
        MessageLookupByLibrary.simpleMessage("Description"),
    "submenu_new_project_button": MessageLookupByLibrary.simpleMessage("Créer"),
    "submenu_new_project_errorMessage": MessageLookupByLibrary.simpleMessage(
      "Veuillez nommer le projet",
    ),
    "submenu_new_project_hint": MessageLookupByLibrary.simpleMessage(
      "Entrez le nom du projet...",
    ),
    "submenu_new_project_subtitle": MessageLookupByLibrary.simpleMessage(
      "Nom du projet",
    ),
    "submenu_new_project_title": MessageLookupByLibrary.simpleMessage(
      "Nouveau projet",
    ),
    "submenu_unlock_content_title": MessageLookupByLibrary.simpleMessage(
      "Déverouiller",
    ),
    "submenu_unlock_error_message_error_login":
        MessageLookupByLibrary.simpleMessage(
          "Impossible de vérifier le mot de passe.",
        ),
    "submenu_unlock_error_message_incorrect_password":
        MessageLookupByLibrary.simpleMessage("Mot de passe incorrect"),
    "submenu_unlock_error_message_please_enter_password":
        MessageLookupByLibrary.simpleMessage(
          "Veuillez saisir votre mot de passe",
        ),
    "submenu_unlock_hide_mnemonic": MessageLookupByLibrary.simpleMessage(
      "Masquer l\'indice de mot de passe",
    ),
    "submenu_unlock_show_mnemonic": MessageLookupByLibrary.simpleMessage(
      "Afficher l\'indice de mot de passe",
    ),
    "submenu_unlock_subtitle_text": MessageLookupByLibrary.simpleMessage(
      "Entrez votre mot de passe",
    ),
    "submenu_welcome_password_mnemonic_sentence_hint":
        MessageLookupByLibrary.simpleMessage(
          "Entrez votre indice de mot de passe",
        ),
    "submenu_welcome_password_mnemonic_sentence_instructs":
        MessageLookupByLibrary.simpleMessage(
          "Cette fonctionnalité vous aide à vous rappeler de votre mot de passe en cas d\'oubli. Il est déconseillé d\'entrer directement votre mot de passe, veuillez plutôt fournir un indice.",
        ),
    "submenu_welcome_password_mnemonic_sentence_subtitle":
        MessageLookupByLibrary.simpleMessage(
          "Ajouter un indice de mot de passe",
        ),
    "submenu_welcome_password_mnemonic_sentence_title":
        MessageLookupByLibrary.simpleMessage("Indice de mot de passe"),
    "system_files_copy_text": MessageLookupByLibrary.simpleMessage("Copie"),
    "tool_pomodoro_break_duration": MessageLookupByLibrary.simpleMessage(
      "Durée de la session de pause",
    ),
    "tool_pomodoro_break_session": MessageLookupByLibrary.simpleMessage(
      "Pause",
    ),
    "tool_pomodoro_break_snackbar": m35,
    "tool_pomodoro_end_session": m36,
    "tool_pomodoro_focus_timer": MessageLookupByLibrary.simpleMessage(
      "Minuteur de concentration",
    ),
    "tool_pomodoro_repetition_count": MessageLookupByLibrary.simpleMessage(
      "Nombre de répétitions",
    ),
    "tool_pomodoro_start_button": MessageLookupByLibrary.simpleMessage(
      "Démarrer",
    ),
    "tool_pomodoro_stop_button": MessageLookupByLibrary.simpleMessage(
      "Arrêter",
    ),
    "tool_pomodoro_work_duration": MessageLookupByLibrary.simpleMessage(
      "Durée de la session de travail",
    ),
    "tool_pomodoro_work_session": MessageLookupByLibrary.simpleMessage(
      "Travail",
    ),
    "tool_pomodoro_work_snackbar": m37,
    "welcome_appbar": MessageLookupByLibrary.simpleMessage("Bienvenue"),
    "welcome_because": MessageLookupByLibrary.simpleMessage(
      "Pour personnaliser votre expérience",
    ),
    "welcome_before_creating": MessageLookupByLibrary.simpleMessage(
      "Pour commencer, entrez votre prénom",
    ),
    "welcome_enter_name": MessageLookupByLibrary.simpleMessage(
      "Entrez votre prénom",
    ),
    "welcome_error_save_username": MessageLookupByLibrary.simpleMessage(
      "Une erreur s\'est produite lors de l\'enregistrement de votre prénom",
    ),
    "welcome_first_name_too_long": MessageLookupByLibrary.simpleMessage(
      "Le prénom ne peut pas être plus long que 25 lettres",
    ),
    "welcome_next_page_semantic": MessageLookupByLibrary.simpleMessage(
      "Page suivante",
    ),
    "welcome_pass_default_username": MessageLookupByLibrary.simpleMessage(
      "Utilisateur",
    ),
    "welcome_pass_tooltip": m38,
    "welcome_pass_username": MessageLookupByLibrary.simpleMessage("Passer"),
    "welcome_password_creation_confirm_hint":
        MessageLookupByLibrary.simpleMessage("Confirmez votre mot de passe"),
    "welcome_password_creation_description":
        MessageLookupByLibrary.simpleMessage("Pour sécuriser vos données"),
    "welcome_password_creation_error_must_provide":
        MessageLookupByLibrary.simpleMessage(
          "Vous devez créer un mot de passe",
        ),
    "welcome_password_creation_error_not_match":
        MessageLookupByLibrary.simpleMessage(
          "Les mots de passe ne correspondent pas",
        ),
    "welcome_password_creation_error_password_save":
        MessageLookupByLibrary.simpleMessage(
          "Une erreur est survenue lors de l\'enregistrement de votre mot de passe",
        ),
    "welcome_password_creation_hide_semantic":
        MessageLookupByLibrary.simpleMessage("Masquer le mot de passe"),
    "welcome_password_creation_hint": MessageLookupByLibrary.simpleMessage(
      "Créez votre mot de passe",
    ),
    "welcome_password_creation_password_requirements":
        MessageLookupByLibrary.simpleMessage(
          "Le mot de passe doit contenir au moins 8 caractères et inclure au moins une lettre majuscule, une lettre minuscule et un chiffre.",
        ),
    "welcome_password_creation_remember": MessageLookupByLibrary.simpleMessage(
      "Ajouter un indice de mot de passe (optionel)",
    ),
    "welcome_password_creation_show_semantic":
        MessageLookupByLibrary.simpleMessage("Afficher le mot de passe"),
    "welcome_password_creation_title": MessageLookupByLibrary.simpleMessage(
      "Maintenant, créez un mot de passe",
    ),
    "welcome_should_provide": MessageLookupByLibrary.simpleMessage(
      "Vous devez fournir votre prénom",
    ),
  };
}
