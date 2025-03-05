import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get app_name => 'minddy';

  @override
  String get app_slogan => 'Tout se passe ici.';

  @override
  String get system_files_copy_text => 'Copie';

  @override
  String get appbar_go_home => 'Retourner à l\'accueil';

  @override
  String get welcome_appbar => 'Bienvenue';

  @override
  String get welcome_before_creating => 'Pour commencer, entrez votre prénom';

  @override
  String get welcome_because => 'Pour personnaliser votre expérience';

  @override
  String get welcome_pass_username => 'Passer';

  @override
  String welcome_pass_tooltip(Object accountSettingName) {
    return 'Vous pourrez toujours saisir votre prénom dans paramètres / $accountSettingName';
  }

  @override
  String get welcome_pass_default_username => 'Utilisateur';

  @override
  String get welcome_enter_name => 'Entrez votre prénom';

  @override
  String get welcome_first_name_too_long => 'Le prénom ne peut pas être plus long que 25 lettres';

  @override
  String get welcome_should_provide => 'Vous devez fournir votre prénom';

  @override
  String get welcome_error_save_username => 'Une erreur s\'est produite lors de l\'enregistrement de votre prénom';

  @override
  String get welcome_next_page_semantic => 'Page suivante';

  @override
  String get welcome_password_creation_title => 'Maintenant, créez un mot de passe';

  @override
  String get welcome_password_creation_description => 'Pour sécuriser vos données';

  @override
  String get welcome_password_creation_hint => 'Créez votre mot de passe';

  @override
  String get welcome_password_creation_confirm_hint => 'Confirmez votre mot de passe';

  @override
  String get welcome_password_creation_error_must_provide => 'Vous devez créer un mot de passe';

  @override
  String get welcome_password_creation_error_not_match => 'Les mots de passe ne correspondent pas';

  @override
  String get welcome_password_creation_show_semantic => 'Afficher le mot de passe';

  @override
  String get welcome_password_creation_hide_semantic => 'Masquer le mot de passe';

  @override
  String get welcome_password_creation_error_password_save => 'Une erreur est survenue lors de l\'enregistrement de votre mot de passe';

  @override
  String get welcome_password_creation_remember => 'Ajouter un indice de mot de passe (optionel)';

  @override
  String get welcome_password_creation_password_requirements => 'Le mot de passe doit contenir au moins 8 caractères et inclure au moins une lettre majuscule, une lettre minuscule et un chiffre.';

  @override
  String get calendar_main_calendar_name => 'Calendrier principal';

  @override
  String get calendar_button_new_event_button_title => 'Événement';

  @override
  String get calendar_button_new_due_date_button_title => 'Date d\'échéance';

  @override
  String get calendar_button_calendar_title => 'Calendrier';

  @override
  String get calendar_button_next_events_title => 'Prochains événements';

  @override
  String get calendar_button_next_due_dates_title => 'Dates d\'échéance';

  @override
  String get calendar_button_add_event_button_tooltip => 'Ajouter un événement';

  @override
  String get calendar_button_manage_calendar_button_tooltip => 'Gérer les calendriers';

  @override
  String get calendar_button_event_date_yesterday => 'Hier';

  @override
  String get calendar_button_event_date_today => 'Aujourd\'hui';

  @override
  String get calendar_button_event_date_tomorrow => 'Demain';

  @override
  String get calendar_button_due_date_cancel_complete => 'Annuler';

  @override
  String calendar_button_due_date_has_been_complete(Object eventName, Object username) {
    return '$eventName à été complété par $username';
  }

  @override
  String get calendar_event_detailed_preview_not_completed_yet => 'Pas encore complété';

  @override
  String calendar_event_detailed_preview_completed_by(Object username) {
    return 'Complété par $username';
  }

  @override
  String get calendar_new_event_title => 'Nouvel événement';

  @override
  String get calendar_modify_event_title => 'Modifier l\'événement';

  @override
  String get calendar_new_due_date_title => 'Nouvelle date d\'échéance';

  @override
  String get calendar_modify_due_date_title => 'Modifier la date d\'échéance';

  @override
  String get calendar_new_event_whole_day => 'Jour entier';

  @override
  String get calendar_new_event_recurrence_subtitle => 'Récurrence';

  @override
  String get calendar_new_event_recurrence_type_never => 'Jamais';

  @override
  String get calendar_new_event_recurrence_type_everyday => 'Tous les jours';

  @override
  String get calendar_new_event_recurrence_type_everyweek => 'Toutes les semaines';

  @override
  String get calendar_new_event_recurrence_type_everymonth => 'Tous les mois';

  @override
  String get calendar_new_event_recurrence_type_everyyear => 'Tous les ans';

  @override
  String get calendar_new_event_recurrence_select_calendar => 'Séléctionnez un calendrier';

  @override
  String get calendar_button_open_week_view_button_tooltip => 'Ouvrir la vue semaine';

  @override
  String get calendar_button_event_selection_menu_only_this_event => 'Seulement cet événement';

  @override
  String get calendar_button_event_selection_menu_all_occurence => 'Toutes les occurrences';

  @override
  String get calendar_button_free_for_next_days => 'Vous êtes libre pour les 5 prochains jours.';

  @override
  String get calendar_button_manage_calendars_sub_menu_all_calendars_subtitle => 'Tous les calendriers';

  @override
  String get calendar_button_manage_calendars_sub_menu_add_calendar => 'Nouveau calendrier';

  @override
  String get calendar_button_manage_calendars_sub_menu_modify_calendar => 'Modifier le calendrier';

  @override
  String get calendar_button_new_calendar_calendar_subtitle_name => 'Nom';

  @override
  String get calendar_button_new_calendar_personalized_color => 'Personalisée';

  @override
  String get calendar_button_new_calendar_private_calendar_title => 'Calendrier privé';

  @override
  String get calendar_button_new_calendar_private_calendar_explanation => 'En activant cette option, le mot de passe sera requis pour voir les événements de ce calendrier';

  @override
  String get calendar_button_event_preview_private_event => 'Cet événement est privé.';

  @override
  String get calendar_button_event_preview_see_button => 'Voir';

  @override
  String calendar_button_event_preview_recurence_text_every_day(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'Tous les $interval jours',
      one: 'Tous les jours',
    );
    return '$_temp0';
  }

  @override
  String calendar_button_event_preview_recurence_text_every_week(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'Toutes les $interval semaines',
      one: 'Toutes les semaines',
    );
    return '$_temp0';
  }

  @override
  String calendar_button_event_preview_recurence_text_every_month(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'Tous les $interval mois',
      one: 'Tous les mois',
    );
    return '$_temp0';
  }

  @override
  String calendar_button_event_preview_recurence_text_every_year(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'Tous les $interval ans',
      one: 'Tous les ans',
    );
    return '$_temp0';
  }

  @override
  String calendar_week_view_week_title(Object week) {
    return 'Semaine $week';
  }

  @override
  String get calendar_week_view_week_details => 'Détails';

  @override
  String get calendar_new_due_date_event_completion_state_subtitle => 'État d\'achèvement';

  @override
  String get calendar_new_due_date_event_completion_state => 'État';

  @override
  String get calendar_new_event_recurence_type_subtitle => 'Type';

  @override
  String get calendar_new_event_recurence_every_subtitle => 'Tous les';

  @override
  String calendar_new_event_recurence_every_day(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'jours',
      one: 'jour',
    );
    return '$_temp0';
  }

  @override
  String calendar_new_event_recurence_every_week(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'semaines',
      one: 'semaine',
    );
    return '$_temp0';
  }

  @override
  String calendar_new_event_recurence_every_month(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'mois',
      one: 'mois',
    );
    return '$_temp0';
  }

  @override
  String calendar_new_event_recurence_every_year(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'ans',
      one: 'an',
    );
    return '$_temp0';
  }

  @override
  String get calendar_new_event_recurence_end_date => 'Date de fin';

  @override
  String get calendar_new_event_recurence_end_date_option_the => 'Le...';

  @override
  String get center_menu_general => 'Général';

  @override
  String get center_menu_others => 'Autre';

  @override
  String get settings_title => 'Paramètres';

  @override
  String get settings_personalize_title => 'Personnaliser';

  @override
  String get settings_accessibility_title => 'Accessibilité';

  @override
  String get settings_security_title => 'Sécurité';

  @override
  String get settings_account_title => 'Mon compte';

  @override
  String get settings_theme_subtitle => 'Thème';

  @override
  String get settings_using_dark_mode => 'Mode sombre';

  @override
  String get settings_using_light_mode => 'Mode clair';

  @override
  String get settings_need_to_quit_project_to_change_theme => 'Pour changer les paramètres de thème, veuillez revenir à l\'accueil';

  @override
  String get settings_need_to_quit_project_to_change_language => 'Pour changer de langue, veuillez revenir à l\'accueil';

  @override
  String get settings_using_system_theme => 'Thème du système';

  @override
  String get settings_personalize_black_and_white_title => 'Mode noir et blanc';

  @override
  String get settings_date_format_subtitle => 'Format de date';

  @override
  String get settings_date_format => 'Préférer le format de date MM/dd';

  @override
  String settings_date_format_tooltip(Object actualDay, Object actualMonth) {
    return 'Cette option mettra le mois avant le jour. Comme ceci : $actualMonth/$actualDay';
  }

  @override
  String get settings_language_subtitle => 'Langue';

  @override
  String get settings_username_subtitle => 'Prénom';

  @override
  String get settings_reset_subtitle => 'Réinitialiser';

  @override
  String get settings_reset_button => 'Réinitialiser les paramètres';

  @override
  String get settings_project_rename_button => 'Renommer';

  @override
  String get settings_project_rename_subtitle => 'Renommer';

  @override
  String get settings_project_delete_subtitle => 'Supprimer';

  @override
  String get settings_project_delete_button => 'Supprimer ce projet';

  @override
  String get settings_project_privacy_subtitle => 'Confidentialité';

  @override
  String get settings_project_private_project => 'Projet privé';

  @override
  String get articles_search => 'Rechercher';

  @override
  String get articles_search_explain => 'Recherchez un titre, auteur';

  @override
  String get articles_search_empty => 'Aucun résultat';

  @override
  String get articles_impossible_to_load_content => 'Impossible de charger le contenu de l\'article';

  @override
  String get articles_corrupted_file => 'Cet article est corrompu';

  @override
  String articles_importer_images_found_many(Object count) {
    return '$count images trouvées. Voulez-vous les importer ?';
  }

  @override
  String get articles_importer_image_found_single => '1 image trouvée. Voulez-vous l\'importer ?';

  @override
  String get articles_importer_import_images_title => 'Importer des images';

  @override
  String get articles_importer_import_images_button => 'Importer';

  @override
  String get articles_importer_dont_import_images_button => 'Ne pas importer';

  @override
  String get articles_empty_menu_page_text => 'Aucun article pour cette catégorie, importez ou écrivez-en un !';

  @override
  String get articles_empty_menu_saved_page_text => 'Aucun article enregistré.';

  @override
  String get articles_new_article => 'Nouvel article';

  @override
  String get articles_import_articles => 'Importer des articles';

  @override
  String get articles_export_articles => 'Exporter cet article';

  @override
  String get articles_export_articles_choose_category => 'Choisissez une catégorie';

  @override
  String get articles_export_canceled => 'L\'article n\'a pas été exporté';

  @override
  String get articles_export_confirmed => 'L\'article a été exporté';

  @override
  String get articles_export_confirmed_button => 'Voir l\'emplacement';

  @override
  String get articles_creativity_title => 'Créativité';

  @override
  String get articles_daily_life_title => 'Quotidien';

  @override
  String get articles_professional_title => 'Professionnel';

  @override
  String get articles_wellness_title => 'Bien-être';

  @override
  String get articles_technology_title => 'Technologie';

  @override
  String get articles_education_title => 'Éducation';

  @override
  String get articles_science_title => 'Science';

  @override
  String get articles_philosophy_title => 'Philosophie';

  @override
  String get articles_environment_title => 'Nature';

  @override
  String get articles_travel_title => 'Voyage';

  @override
  String get articles_finance_title => 'Finance';

  @override
  String get articles_politics_title => 'Politique';

  @override
  String get articles_food_title => 'Alimentation';

  @override
  String get articles_saved_title => 'Enregistrés';

  @override
  String get articles_my_articles_title => 'Mes articles';

  @override
  String get articles_read_button => 'Lire';

  @override
  String get articles_sources_text => 'Sources';

  @override
  String get articles_bookmark_semantic_text => 'Enregister l\'article';

  @override
  String get articles_add_text_semantic_text => 'Ajouter un bloc de texte';

  @override
  String get articles_add_subtitle_semantic_text => 'Ajouter un sous titre';

  @override
  String get articles_add_image_semantic_text => 'Ajouter une image';

  @override
  String get articles_go_back_semantic_text => 'Retour';

  @override
  String get articles_card_untitled => 'Sans titre';

  @override
  String get articles_title_hint => 'Entrez un titre...';

  @override
  String get articles_subtitle_hint => 'Entrez un sous titre...';

  @override
  String get articles_text_hint => 'Entrez du texte...';

  @override
  String get articles_code_hint => 'Entrez du code...';

  @override
  String get articles_copy_text => 'Copier';

  @override
  String get articles_copy_to_notes_text => 'Ajouter aux notes';

  @override
  String get articles_add_to_content => 'Ajouter à l\'article';

  @override
  String get articles_images_add_button => 'Ajouter une image';

  @override
  String get articles_images_change_button => 'Changer l\'image';

  @override
  String get articles_card_delete_this_article => 'cet article';

  @override
  String get articles_bottom_menu_open_semantic_text => 'Ouvrir le menu';

  @override
  String get articles_bottom_menu_close_semantic_text => 'Fermer le menu';

  @override
  String get articles_bottom_menu_sources_button => 'Sources';

  @override
  String get articles_bottom_menu_content_button => 'Contenu';

  @override
  String get articles_bottom_menu_notes_button => 'Notes';

  @override
  String get articles_add_source_hint => 'Indiquer une source...';

  @override
  String get articles_add_source_button => 'Ajouter une source';

  @override
  String articles_no_notes(Object actionName) {
    return 'Vous n\'avez aucune notes ! Cliquez sur \'$actionName\' pour commencer à en prendre.';
  }

  @override
  String get articles_no_sources => 'Aucune source n\'a été fournie pour le moment ! N\'oubliez pas d\'inclure des sources pour les futurs lecteurs.';

  @override
  String get articles_no_content => 'Cet article est vide ! Ajoutez des éléments pour pouvoir les déplacer.';

  @override
  String get articles_calculate_reading_time => 'Calculer le temps de lecture';

  @override
  String get articles_add_list_semantic_text => 'Ajouter une liste';

  @override
  String get articles_add_code_semantic_text => 'Ajouter un bloc de code';

  @override
  String get articles_define_language => 'Définir le language';

  @override
  String get articles_imported => 'Les articles ont été importés';

  @override
  String get articles_not_imported => 'Les articles n\'ont pas été impotés';

  @override
  String get snackbar_cancel_button => 'Fermer';

  @override
  String get snackbar_restart_needed_text => 'Vous devrez redémarrer l\'application pour appliquer les modifications';

  @override
  String get snackbar_restart_button => 'Fermer l\'app';

  @override
  String get snackbar_reset_text => 'Réinitialiser les paramètres ?';

  @override
  String get snackbar_reset_button => 'Réinitialiser';

  @override
  String snackbar_delete_element_text(Object element) {
    return 'Supprimer $element ?';
  }

  @override
  String get snackbar_delete_button => 'Supprimer';

  @override
  String get snackbar_articles_saved => 'Cet article à été enregistré';

  @override
  String get snackbar_articles_unsaved => 'Cet article n\'est plus enregistré';

  @override
  String get snackbar_close_button => 'Fermer';

  @override
  String snackbar_welcome_back_text(Object user) {
    return 'Ravis de vous revoir $user';
  }

  @override
  String get snackbar_welcome_back_button => 'Merci';

  @override
  String get home_appbar => 'Accueil';

  @override
  String greeting_morning(Object username) {
    return 'Bonjour $username';
  }

  @override
  String greeting_afternoon(Object username) {
    return 'Bon après-midi $username';
  }

  @override
  String greeting_evening(Object username) {
    return 'Bonsoir $username';
  }

  @override
  String get home_pick_up => 'Reprenez là où vous étiez';

  @override
  String get home_discover => 'Découvrir minddy';

  @override
  String get home_articles_card_open_hint => 'Ouvrir cet article';

  @override
  String get submenu_new_project_title => 'Nouveau projet';

  @override
  String get submenu_new_project_subtitle => 'Nom du projet';

  @override
  String get submenu_new_project_hint => 'Entrez le nom du projet...';

  @override
  String get submenu_new_project_button => 'Créer';

  @override
  String get submenu_new_project_errorMessage => 'Veuillez nommer le projet';

  @override
  String get submenu_artilces_image_description_title => 'Description';

  @override
  String get submenu_artilces_image_description_subtitle => 'Description de l\'image';

  @override
  String get submenu_artilces_image_description_hint => 'Décrivez l\'image...';

  @override
  String get submenu_artilces_image_description_button => 'Valider';

  @override
  String get submenu_welcome_password_mnemonic_sentence_title => 'Indice de mot de passe';

  @override
  String get submenu_welcome_password_mnemonic_sentence_subtitle => 'Ajouter un indice de mot de passe';

  @override
  String get submenu_welcome_password_mnemonic_sentence_hint => 'Entrez votre indice de mot de passe';

  @override
  String get submenu_welcome_password_mnemonic_sentence_instructs => 'Cette fonctionnalité vous aide à vous rappeler de votre mot de passe en cas d\'oubli. Il est déconseillé d\'entrer directement votre mot de passe, veuillez plutôt fournir un indice.';

  @override
  String get submenu_unlock_subtitle_text => 'Entrez votre mot de passe';

  @override
  String get submenu_unlock_show_mnemonic => 'Afficher l\'indice de mot de passe';

  @override
  String get submenu_unlock_hide_mnemonic => 'Masquer l\'indice de mot de passe';

  @override
  String get submenu_unlock_error_message_incorrect_password => 'Mot de passe incorrect';

  @override
  String get submenu_unlock_error_message_please_enter_password => 'Veuillez saisir votre mot de passe';

  @override
  String get submenu_unlock_error_message_error_login => 'Impossible de vérifier le mot de passe.';

  @override
  String get submenu_unlock_content_title => 'Déverouiller';

  @override
  String get custom_date_picker_start => 'Début';

  @override
  String get custom_date_picker_end => 'Fin';

  @override
  String get custom_date_picker_invalid_date => 'Date invalide';

  @override
  String get custom_date_picker_select_single_date_title => 'Selectionnez une date';

  @override
  String get custom_date_picker_select_multiples_date_title => 'Selectionnez des dates';

  @override
  String get custom_date_picker_include_hour => 'Inclure l\'heure';

  @override
  String get project_card_open_settings => 'Modifier';

  @override
  String get project_card_duplicate => 'Dupliquer';

  @override
  String get project_card_delete => 'Supprimer';

  @override
  String get tool_pomodoro_work_duration => 'Durée de la session de travail';

  @override
  String get tool_pomodoro_work_session => 'Travail';

  @override
  String get tool_pomodoro_break_duration => 'Durée de la session de pause';

  @override
  String get tool_pomodoro_break_session => 'Pause';

  @override
  String tool_pomodoro_break_snackbar(num duration) {
    String _temp0 = intl.Intl.pluralLogic(
      duration,
      locale: localeName,
      other: 'Pomodoro - C\'est l\'heure de la pause pour $duration minutes',
      one: 'Pomodoro - C\'est l\'heure de la pause pour $duration minute',
      zero: 'Pomodoro - C\'est l\'heure de la pause',
    );
    return '$_temp0';
  }

  @override
  String tool_pomodoro_work_snackbar(num duration) {
    String _temp0 = intl.Intl.pluralLogic(
      duration,
      locale: localeName,
      other: 'Pomodoro - Il est temps de retourner au travail pour $duration minutes',
      one: 'Pomodoro - Il est temps de retourner au travail pour $duration minute',
      zero: 'Pomodoro - Il est temps de retourner au travail',
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
    return 'La session pomodoro est terminée, vous avez travaillé $_temp0. Il est temps de se reposer !';
  }

  @override
  String get tool_pomodoro_repetition_count => 'Nombre de répétitions';

  @override
  String get tool_pomodoro_focus_timer => 'Minuteur de concentration';

  @override
  String get tool_pomodoro_start_button => 'Démarrer';

  @override
  String get tool_pomodoro_stop_button => 'Arrêter';

  @override
  String get projects_next_page_shortcut_tooltip_mac => 'Page suivante (⌘ + ⭢)';

  @override
  String get projects_previous_page_shortcut_tooltip_mac => 'Page précédente (⌘ + ⭠)';

  @override
  String get projects_next_page_shortcut_tooltip => 'Page suivante (ctrl + ⭢)';

  @override
  String get projects_previous_page_shortcut_tooltip => 'Page précédente (ctrl + ⭠)';

  @override
  String get projects_add_module_tooltip => 'Nouveau module';

  @override
  String get projects_save_project_button_tooltip => 'Sauvegarder';

  @override
  String get projects_module_help_text => 'Aide';

  @override
  String get projects_module_tasks_title => 'Tâches';

  @override
  String projects_module_tasks_completed(Object checkedTasks, num totalTasksCount) {
    String _temp0 = intl.Intl.pluralLogic(
      totalTasksCount,
      locale: localeName,
      other: '$checkedTasks/$totalTasksCount tâches terminées',
      one: '$checkedTasks/$totalTasksCount tâche terminée',
      zero: 'Aucune tâche',
    );
    return '$_temp0';
  }

  @override
  String get projects_module_tasks_task_title_hint => 'Titre';

  @override
  String get projects_module_tasks_task_add_subtask_tooltip => 'Ajouter une sous-tâche';

  @override
  String get projects_module_tasks_add_task_tooltip => 'Ajouter une nouvelle tâche';

  @override
  String get projects_module_notes_new_category_tooltip => 'Nouvelle catégorie';

  @override
  String get projects_module_notes_new_note_tooltip => 'Nouvelle note';

  @override
  String get projects_module_notes_modify_category => 'Modifier';

  @override
  String get projects_module_notes_modify_note_tooltip => 'Modifier cette note';

  @override
  String get projects_module_notes_new_category_sub_menu_title => 'Nouvelle catégorie';

  @override
  String get projects_module_notes_new_category_sub_menu_subtitle => 'Nom de la catégorie';

  @override
  String get projects_module_notes_new_category_sub_menu_name_hint => 'Entrez le nom de la catégorie';

  @override
  String get projects_module_notes_new_category_sub_menu_is_private => 'Categorie privée';

  @override
  String get projects_module_notes_new_category_sub_menu_error_message => 'Veuillez nommer la catégorie';

  @override
  String get projects_module_notes_new_category_sub_menu_is_private_tooltip => 'En activant cette option, votre mot de passe sera requis pour ouvrir cette catégorie.';

  @override
  String get projects_module_notes_modify_category_sub_menu_title => 'Modifier la catégorie';

  @override
  String get projects_module_notes_editing_note_sub_menu_save_tooltip => 'Sauvegarder la note';

  @override
  String get projects_module_notes_editing_note_sub_menu_move_tooltip => 'Déplacer';

  @override
  String get projects_module_notes_for_later_title => 'Notes pour plus tard';

  @override
  String get projects_module_notes_important_notes_title => 'Notes importantes';

  @override
  String get projects_module_notes_private_notes_title => 'Notes privées';

  @override
  String get projects_module_notes_project_notes_title => 'Notes du projet';

  @override
  String projects_module_notes_category_note_count(num totalNotesCount) {
    String _temp0 = intl.Intl.pluralLogic(
      totalNotesCount,
      locale: localeName,
      other: '$totalNotesCount notes',
      one: '1 note',
      zero: 'Aucune note',
    );
    return '$_temp0';
  }

  @override
  String get projects_module_notes_title => 'Notes';

  @override
  String get projects_module_spreadsheet_title => 'Tableau';

  @override
  String get projects_module_spreadsheet_value_unnamed => 'Sans nom';

  @override
  String get projects_module_spreadsheet_new_row => 'Nouvelle ligne';

  @override
  String get projects_module_spreadsheet_new_column => 'Nouvelle colonne';

  @override
  String get projects_module_spreadsheet_delete_row => 'Supprimer cette ligne';

  @override
  String get projects_module_spreadsheet_delete_column => 'Supprimer cette colonne';

  @override
  String get projects_module_spreadsheet_data_column_type => 'Type de colonne';

  @override
  String get projects_module_spreadsheet_data_choose_column_type_tooltip => 'Choisir un type de colonne';

  @override
  String get projects_module_spreadsheet_data_type_text => 'Texte';

  @override
  String get projects_module_spreadsheet_data_type_number => 'Nombre';

  @override
  String get projects_module_spreadsheet_data_type_phone_number => 'Numéro de téléphone';

  @override
  String get projects_module_spreadsheet_data_type_email => 'E-mail';

  @override
  String get projects_module_spreadsheet_data_type_url => 'URL';

  @override
  String get projects_module_spreadsheet_data_type_date => 'Date';

  @override
  String get projects_module_spreadsheet_date_from_text => 'Du';

  @override
  String get projects_module_spreadsheet_date_to_text => 'Au';

  @override
  String get projects_module_spreadsheet_date_single_tooltip => 'Date unique';

  @override
  String get projects_module_spreadsheet_date_start_end_tooltip => 'Ajouter une date de fin';

  @override
  String get projects_module_spreadsheet_data_type_selection => 'Sélection';

  @override
  String projetcs_module_spreadsheet_open_website(Object websiteName) {
    return 'Ouvrir $websiteName';
  }

  @override
  String get projects_module_spreadsheet_number_operation_none => 'Aucun';

  @override
  String get projects_module_spreadsheet_number_operation_sum => 'Somme';

  @override
  String get projects_module_spreadsheet_number_operation_average => 'Moyenne';

  @override
  String get projects_module_spreadsheet_number_operation_maximum => 'Maximum';

  @override
  String get projects_module_spreadsheet_number_operation_minimum => 'Minimum';

  @override
  String get projects_module_spreadsheet_number_operation_interval => 'Intervalle';

  @override
  String get projects_module_spreadsheet_number_operation_median => 'Médiane';

  @override
  String get projects_module_spreadsheet_number_operation_standard_deviation => 'Écart type';

  @override
  String get projects_module_spreadsheet_number_operation_calculate => 'Calculer';

  @override
  String get projects_module_spreadsheet_number_operation_sum_example => '10 + 50 + 100';

  @override
  String get projects_module_spreadsheet_number_operation_sum_message => 'Ajoute toutes les valeurs de la colonne pour obtenir le total. Utile pour résumer les données.';

  @override
  String get projects_module_spreadsheet_number_operation_average_example => '(10 + 50 + 100) / 3';

  @override
  String get projects_module_spreadsheet_number_operation_average_message => 'Calcule la moyenne en divisant la somme de toutes les valeurs par le nombre de valeurs. Cela aide à trouver la valeur centrale des données.';

  @override
  String get projects_module_spreadsheet_number_operation_maximum_example => '(10, 50, 100) = 100';

  @override
  String get projects_module_spreadsheet_number_operation_maximum_message => 'Trouve la valeur la plus élevée dans la colonne. Utile pour identifier le plus grand nombre.';

  @override
  String get projects_module_spreadsheet_number_operation_minimum_example => '(10, 50, 100) = 10';

  @override
  String get projects_module_spreadsheet_number_operation_minimum_message => 'Trouve la valeur la plus basse dans la colonne. Cela aide à identifier le plus petit nombre.';

  @override
  String get projects_module_spreadsheet_number_operation_interval_example => '(10, 50, 100) = 90';

  @override
  String get projects_module_spreadsheet_number_operation_interval_message => 'Calcule la plage en soustrayant la plus petite valeur de la plus grande valeur dans la colonne. Cela montre la répartition des valeurs.';

  @override
  String get projects_module_spreadsheet_number_operation_median_example => '(10, 50, 100) = 50';

  @override
  String get projects_module_spreadsheet_number_operation_median_message => 'Trouve la valeur centrale lorsque les valeurs des colonnes sont triées. Utile pour identifier la valeur centrale.';

  @override
  String get projects_module_spreadsheet_number_operation_standardDeviation_example => '√[((10-53.33)² + (50-53.33)² + (100-53.33)²) / 3]';

  @override
  String get projects_module_spreadsheet_number_operation_standardDeviation_message => 'Calcule l\'écart type pour mesurer dans quelle mesure les valeurs varient par rapport à la moyenne. Ici, 53,33 est la moyenne des valeurs 10, 50 et 100.';

  @override
  String get projects_module_spreadsheet_extend_cell_tooltip => 'Étendre cette cellule';

  @override
  String get projects_module_spreadsheet_selection_cell_not_started => 'Pas encore commencé';

  @override
  String get projects_module_spreadsheet_selection_cell_started => 'Commencé';

  @override
  String get projects_module_spreadsheet_selection_cell_finished => 'Terminé';

  @override
  String get projects_module_spreadsheet_selection_cell_modify_options => 'Modifier les options';

  @override
  String get projects_module_spreadsheet_selection_cell_add_options => 'Ajouter des options';

  @override
  String get projects_module_spreadsheet_selection_cell_add_an_option => 'Ajouter une option';

  @override
  String get projects_module_spreadsheet_selection_cell_all_options => 'Toutes les options';

  @override
  String get projects_module_spreadsheet_selection_cell_name_option_hint => 'Nommez cette option...';

  @override
  String get projects_module_spreadsheet_manage_columns_sub_menu_title => 'Organiser les colonnes';

  @override
  String get projects_module_spreadsheet_manage_columns_sub_menu_subtitle => 'Toutes les colonnes';

  @override
  String get projects_module_spreadsheet_manage_rows_sub_menu_title => 'Organiser les lignes';

  @override
  String get projects_module_spreadsheet_manage_rows_sub_menu_subtitle => 'Toutes les lignes';

  @override
  String get projects_module_spreadsheet_selection_sub_menu_error_message_no_options => 'Veuillez ajouter des options';

  @override
  String get projects_module_spreadsheet_selection_sub_menu_error_message_unnamed_option => 'Veuillez nommer toutes les options';

  @override
  String projects_module_spreadsheet_selection_sub_menu_error_message_redundant_option_name(Object optionName) {
    return 'Deux options ne peuvent pas avoir le même nom ($optionName)';
  }

  @override
  String get projects_module_spreadsheet_selection_sub_menu_error_message_redundant_color => 'Deux options ne peuvent pas avoir la même couleur';

  @override
  String get projects_module_spreadsheet_chart_show_table => 'Afficher le tableau';

  @override
  String get projects_module_spreadsheet_chart_show_chart => 'Afficher les graphiques';

  @override
  String get projects_module_spreadsheet_chart_new_tab => 'Nouvel onglet';

  @override
  String get projects_module_spreadsheet_chart_new_column => 'Ajouter une colonne';

  @override
  String get projects_module_spreadsheet_chart_chart_type_subtitle => 'Type de graphique';

  @override
  String get projects_module_spreadsheet_chart_chart_type_donut => 'Donut';

  @override
  String get projects_module_spreadsheet_chart_chart_type_bar => 'Barre';

  @override
  String get projects_module_spreadsheet_chart_chart_type_bar_simple => 'Barres simples';

  @override
  String get projects_module_spreadsheet_chart_chart_type_bar_grouped => 'Barres regroupées';

  @override
  String get projects_module_spreadsheet_chart_chart_type_bar_stacked => 'Barres empilées';

  @override
  String get projects_module_spreadsheet_chart_chart_select_column => 'Sélectionnez une colonne';

  @override
  String get projects_module_spreadsheet_chart_chart_column_single => 'Colonne';

  @override
  String get projects_module_spreadsheet_chart_chart_column_plural => 'Colonnes';

  @override
  String get custom_chart_empty_content => 'Pour créer un graphique, veuillez y ajouter des données';

  @override
  String get custom_chart_donut_total => 'Total';

  @override
  String get custom_chart_donut_share => 'Part';

  @override
  String get custom_chart_grid_extend_chart => 'Agrandir le graphique';

  @override
  String get custom_color_picker_opacity_tooltip => 'Opacité';

  @override
  String get node_editor_view_new_node_tooltip => 'Nouveau nœud';

  @override
  String get node_editor_view_close_node_panel_tooltip => 'Fermer panneau des nœuds';

  @override
  String get node_editor_view_open_node_panel_tooltip => 'Ouvrir panneau des nœuds';

  @override
  String get node_editor_view_close_side_panel_tooltip => 'Fermer panneau latéral';

  @override
  String get node_editor_view_open_side_panel_tooltip => 'Ouvrir panneau latéral';

  @override
  String get node_editor_view_side_panel_variables_title => 'Variables';

  @override
  String get node_editor_view_side_panel_variables_add_button_tooltip => 'Nouvelle variable';

  @override
  String get node_editor_view_side_panel_variables_variable_type_any => 'Non défini';

  @override
  String get node_editor_view_side_panel_variables_variable_type_number => 'Nombre';

  @override
  String get node_editor_view_side_panel_variables_variable_type_text => 'Texte';

  @override
  String get node_editor_view_side_panel_variables_variable_type_boolean => 'Booléen';

  @override
  String get node_editor_view_side_panel_variables_variable_type_list => 'Liste';

  @override
  String get node_editor_view_side_panel_variables_variable_type_color => 'Couleur';

  @override
  String get node_editor_view_side_panel_node_trees_title => 'Arbres de nœuds';

  @override
  String get node_editor_view_side_panel_node_trees_add_button_tooltip => 'Nouvel arbre';

  @override
  String get node_editor_view_bottom_toolbar_undo_tooltip_windows => 'Annuler (ctrl + z)';

  @override
  String get node_editor_view_bottom_toolbar_undo_tooltip_mac => 'Annuler (⌘ + z)';

  @override
  String get node_editor_view_bottom_toolbar_redo_tooltip_windows => 'Rétablir (⇧ + ctrl + z)';

  @override
  String get node_editor_view_bottom_toolbar_redo_tooltip_mac => 'Rétablir (⇧ + ⌘ + z)';

  @override
  String node_editor_view_bottom_toolbar_copy_tooltip_windows(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Copier les nœuds sélectionnés (ctrl + c)',
      one: 'Copier le nœud sélectionné (ctrl + c)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_copy_tooltip_mac(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Copier les nœuds sélectionnés (⌘ + c)',
      one: 'Copier le nœud sélectionné (⌘ + c)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_paste_tooltip_windows(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Coller les nœuds copiés (ctrl + v)',
      one: 'Coller le nœud copié (ctrl + v)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_paste_tooltip_mac(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Coller les nœuds copiés (⌘ + v)',
      one: 'Coller le nœud copié (⌘ + v)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_duplicate_tooltip_windows(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Dupliquer les nœuds sélectionnés (ctrl + d)',
      one: 'Dupliquer le nœud sélectionné (ctrl + d)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_duplicate_tooltip_mac(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Dupliquer les nœuds sélectionnés (⌘ + d)',
      one: 'Dupliquer le nœud sélectionné (⌘ + d)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_delete_tooltip_windows(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Supprimer les nœuds sélectionnés (ctrl + ⌫)',
      one: 'Supprimer le nœud sélectionné (ctrl + ⌫)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_delete_tooltip_mac(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Supprimer les nœuds sélectionnés (⌘ + ⌫)',
      one: 'Supprimer le nœud sélectionné (⌘ + ⌫)',
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
      other: 'Entrées',
      one: 'Entrée',
    );
    return '$_temp0';
  }

  @override
  String node_editor_add_sub_menu_outputs_subtitle(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Sorties',
      one: 'Sortie',
    );
    return '$_temp0';
  }

  @override
  String get node_editor_add_sub_menu_note => 'Remarque: les entrées et sorties peuvent varier en fonction des options choisies pour le nœud';

  @override
  String get node_editor_add_sub_menu_no_nodes_found => 'Aucun nœud trouvé.';

  @override
  String get node_editor_add_sub_menu_add_button => 'Ajouter';

  @override
  String get node_editor_add_sub_menu_none_input_output => 'Aucune';

  @override
  String get node_widgets_value_text => 'Valeur';

  @override
  String get node_widgets_result_text => 'Résultat';

  @override
  String get node_widgets_text_text => 'Texte';

  @override
  String get node_widgets_start_text => 'Début';

  @override
  String get node_widgets_end_text => 'Fin';

  @override
  String get node_widgets_length_text => 'Longueur';

  @override
  String get node_widgets_treshold_text => 'Limite';

  @override
  String get node_widgets_category_math => 'Maths';

  @override
  String get node_widgets_category_logic => 'Logique';

  @override
  String get node_widgets_category_variable => 'Variables';

  @override
  String get node_widgets_math_node_title => 'Calculs';

  @override
  String get node_widgets_math_node_description => 'Effectue des calculs sur des nombres.';

  @override
  String get node_widgets_math_node_options_addition => 'Addition';

  @override
  String get node_widgets_math_node_options_substraction => 'Soustraction';

  @override
  String get node_widgets_math_node_options_division => 'Division';

  @override
  String get node_widgets_math_node_options_multiplication => 'Multiplication';

  @override
  String get node_widgets_math_node_options_squareRoot => 'Racine carrée';

  @override
  String get node_widgets_math_node_options_power => 'Puissance';

  @override
  String get node_widgets_math_node_options_min => 'Minimum';

  @override
  String get node_widgets_math_node_options_max => 'Maximum';

  @override
  String get node_widgets_math_node_options_sign => 'Signe';

  @override
  String get node_widgets_math_node_options_round => 'Arrondi';

  @override
  String get node_widgets_math_node_options_floor => 'Plancher';

  @override
  String get node_widgets_math_node_options_ceil => 'Plafond';

  @override
  String get node_widgets_math_node_options_truncate => 'Tronquer';

  @override
  String get node_widgets_math_node_options_sin => 'Sinus';

  @override
  String get node_widgets_math_node_options_cos => 'Cosinus';

  @override
  String get node_widgets_math_node_options_tan => 'Tangente';

  @override
  String get node_widgets_math_node_options_asin => 'Arc sinus';

  @override
  String get node_widgets_math_node_options_acos => 'Arc cosinus';

  @override
  String get node_widgets_math_node_options_atan => 'Arc tangente';

  @override
  String get node_widgets_math_node_options_sinh => 'Sinh';

  @override
  String get node_widgets_math_node_options_cosh => 'Cosh';

  @override
  String get node_widgets_math_node_options_tanh => 'Tanh';

  @override
  String get node_widgets_math_node_options_asinh => 'Arc sinh';

  @override
  String get node_widgets_math_node_options_acosh => 'Arc cosh';

  @override
  String get node_widgets_math_node_options_atanh => 'Arc tanh';

  @override
  String get node_widgets_math_node_options_ln => 'Logarithme népérien';

  @override
  String get node_widgets_math_node_options_log10 => 'Logarithme en base 10';

  @override
  String get node_widgets_math_node_options_abs => 'Valeur absolue';

  @override
  String get node_widgets_comparison_node_title => 'Comparaison';

  @override
  String get node_widgets_comparison_node_description => 'Effectue une comparaison entre des nombres.';

  @override
  String get node_widgets_comparison_node_options_lessThan => 'Inférieur à';

  @override
  String get node_widgets_comparison_node_options_lessThanOrEqual => 'Inférieur ou égal à';

  @override
  String get node_widgets_comparison_node_options_greatherThan => 'Supérieur à';

  @override
  String get node_widgets_comparison_node_options_greatherThanOrEqual => 'Supérieur ou égal à';

  @override
  String get node_widgets_comparison_node_options_equal => 'Égal à';

  @override
  String get node_widgets_boolean_node_title => 'Opérations logiques';

  @override
  String get node_widgets_boolean_node_description => 'Effectue des opérations sur des booléens.';

  @override
  String get node_widgets_boolean_node_options_and => 'Et';

  @override
  String get node_widgets_boolean_node_options_or => 'Ou';

  @override
  String get node_widgets_boolean_node_options_not => 'Non';

  @override
  String get node_widgets_boolean_node_options_notAnd => 'Non Et';

  @override
  String get node_widgets_boolean_node_options_notOr => 'Non Ou';

  @override
  String get node_widgets_boolean_node_options_equal => 'Égal';

  @override
  String get node_widgets_boolean_node_options_notEqual => 'Non Égal';

  @override
  String get node_widgets_boolean_node_options_imply => 'Impliquer';

  @override
  String get node_widgets_boolean_node_options_subtract => 'Soustraire';

  @override
  String get node_widgets_conversion_node_title => 'Conversion';

  @override
  String get node_widgets_conversion_node_decsription => 'Convertit une valeur vers autre type';

  @override
  String get node_widgets_text_operation_node_title => 'Opérations textuelles';

  @override
  String get node_widgets_text_operation_node_decsription => 'Effectue des opérations sur du texte';

  @override
  String get node_widgets_text_operation_node_options_join => 'Fusionner';

  @override
  String get node_widgets_text_operation_node_options_cut => 'Couper';

  @override
  String get node_widgets_text_operation_node_options_trim => 'Retirer le vide';

  @override
  String get node_widgets_text_operation_node_options_trim_left => 'Retirer le vide à gauche';

  @override
  String get node_widgets_text_operation_node_options_trim_right => 'Retirer le vide à droite';

  @override
  String get node_widgets_text_operation_node_options_pad_left => 'Remplir à gauche';

  @override
  String get node_widgets_text_operation_node_options_pad_right => 'Remplir à droite';

  @override
  String get node_widgets_text_operation_node_options_contains => 'Contient';

  @override
  String get node_widgets_set_variable_node_title => 'Définir la variable';

  @override
  String get node_widgets_set_variable_node_description => 'Définit la valeur d\'une variable.';

  @override
  String get node_widgets_get_variable_node_title => 'Obtenir la variable';

  @override
  String get node_widgets_get_variable_node_description => 'Obtient la valeur d\'une variable.';

  @override
  String get node_widgets_select_variable_node_text => 'Sélectionnez une variable';

  @override
  String get node_widgets_random_number_node_title => 'Nombre aléatoire';

  @override
  String get node_widgets_random_number_node_description => 'Génère un nombre aléatoire entre un minimum et un maximum (0 et 1 par défaut).';

  @override
  String get plugin_editor_ui_side_panel_layers_title => 'Composants';

  @override
  String get plugin_editor_ui_side_panel_layers_add_button => 'Nouveau composant';

  @override
  String get plugin_editor_ui_side_panel_layers_add_child => 'Ajouter un enfant';

  @override
  String get plugin_editor_ui_side_panel_layers_more_options => 'Plus d\'options';

  @override
  String plugin_editor_ui_side_panel_layers_hide_child(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Masquer les enfants',
      one: 'Masquer l\'enfant',
    );
    return '$_temp0';
  }

  @override
  String plugin_editor_ui_side_panel_layers_show_child(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Afficher les enfants',
      one: 'Afficher l\'enfant',
    );
    return '$_temp0';
  }

  @override
  String get plugin_editor_ui_side_panel_properties_size_subtitle => 'Taille';

  @override
  String get plugin_editor_ui_side_panel_properties_size_width => 'Largeur';

  @override
  String get plugin_editor_ui_side_panel_properties_size_height => 'Hauteur';

  @override
  String get plugin_editor_ui_side_panel_properties_style_subtitle => 'Style';

  @override
  String get plugin_editor_ui_side_panel_properties_style_border_radius => 'Arrondi';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment => 'Alignement';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_top_left => 'En haut à gauche';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_top_right => 'En haut à droite';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_bottom_left => 'En bas à gauche';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_bottom_right => 'En bas à droite';

  @override
  String get plugin_editor_ui_side_panel_properties_border_subtitle => 'Bordure';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_top => 'En haut';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_bottom => 'En bas';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_left => 'À gauche';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_right => 'À droite';

  @override
  String get plugin_editor_ui_side_panel_properties_style_border_thickness => 'Épaisseur';

  @override
  String get plugin_editor_ui_side_panel_properties_theme_colors_primary => 'Primaire';

  @override
  String get plugin_editor_ui_side_panel_properties_theme_colors_primary_transparent => 'Primaire transparent';

  @override
  String get plugin_editor_ui_side_panel_properties_theme_colors_accent => 'Accentuation';

  @override
  String get plugin_editor_ui_side_panel_properties_theme_colors_surface => 'Surface';

  @override
  String get default_app_colors_change_color => 'Changer la couleur';

  @override
  String get default_app_colors_grey => 'Gris';

  @override
  String get default_app_colors_mint_green => 'Vert menthe';

  @override
  String get default_app_colors_light_pink => 'Rose clair';

  @override
  String get default_app_colors_light_yellow => 'Jaune clair';

  @override
  String get default_app_colors_peach => 'Pêche';

  @override
  String get default_app_colors_soft_red => 'Rouge doux';

  @override
  String get default_app_colors_lavender => 'Lavande';

  @override
  String get default_app_colors_light_blue => 'Bleu clair';

  @override
  String get default_app_colors_light_green => 'Vert clair';

  @override
  String get default_app_colors_light_purple => 'Violet clair';

  @override
  String get default_articles_articles_title => 'Articles';

  @override
  String get default_articles_articles_description => 'Découvrir les articles dans minddy';

  @override
  String get default_articles_articles_first_subtitle => 'Fonctionnalité Clé';

  @override
  String get default_articles_articles_first_paragraph => 'Les articles sont une fonctionnalité clé de Minddy. Ils offrent une interface élégante et intuitive pour rédiger et partager vos connaissances. Grâce à cette fonctionnalité, vous pouvez facilement diffuser votre savoir et en faire profiter toute la communauté.';

  @override
  String get default_articles_articles_second_subtitle => 'Prise de Notes';

  @override
  String get default_articles_articles_second_paragraph => 'Vous pouvez également prendre des notes, idéal pour sauvegarder des textes ou tout autre contenu que vous souhaitez conserver pour plus tard. Cette fonctionnalité est parfaite pour capturer des idées ou des informations importantes à revisiter ultérieurement.';

  @override
  String get default_articles_articles_third_subtitle => 'Gestion des Sources';

  @override
  String get default_articles_articles_third_paragraph => 'Toutes vos sources sont accessibles via un menu situé en bas de la page, vous permettant ainsi de gérer et de retrouver facilement vos références.';

  @override
  String get default_articles_articles_fourth_subtitle => 'Ajouter et Gérer du Contenu';

  @override
  String get default_articles_articles_fourth_paragraph => 'Les boutons pour ajouter des éléments à votre article sont situés en haut de la page. Pour gérer ce contenu, utilisez le menu en bas.';

  @override
  String get default_articles_articles_fifth_subtitle => 'Outil Puissant';

  @override
  String get default_articles_articles_fifth_paragraph => 'Avec les articles, vous avez un outil puissant et convivial pour organiser, partager et retrouver vos connaissances en toute simplicité.';
}
