import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get app_name => 'minddy';

  @override
  String get app_slogan => 'Todo sucede aquí.';

  @override
  String get system_files_copy_text => 'Copiar';

  @override
  String get appbar_go_home => 'Retorno al inicio';

  @override
  String get welcome_appbar => 'Bienvenido';

  @override
  String get welcome_before_creating => 'Para empezar, por favor introduce tu nombre';

  @override
  String get welcome_because => 'Para personalizar tu experiencia';

  @override
  String get welcome_pass_username => 'Pasar';

  @override
  String welcome_pass_tooltip(Object accountSettingName) {
    return 'Aún podrás ingresar tu nombre en la configuración - $accountSettingName';
  }

  @override
  String get welcome_pass_default_username => 'Usuario';

  @override
  String get welcome_enter_name => 'Introduce tu nombre';

  @override
  String get welcome_first_name_too_long => 'El nombre no puede tener más de 25 letras.';

  @override
  String get welcome_should_provide => 'Debes proporcionar tu nombre';

  @override
  String get welcome_error_save_username => 'Se produjo un error al guardar tu nombre';

  @override
  String get welcome_next_page_semantic => 'Siguiente página';

  @override
  String get welcome_password_creation_title => 'Ahora, crea una contraseña';

  @override
  String get welcome_password_creation_description => 'Para mantener tus datos seguros';

  @override
  String get welcome_password_creation_hint => 'Crea tu contraseña';

  @override
  String get welcome_password_creation_confirm_hint => 'Confirma tu contraseña';

  @override
  String get welcome_password_creation_error_must_provide => 'Por favor, cree una contraseña';

  @override
  String get welcome_password_creation_error_not_match => 'Las contraseñas no coinciden';

  @override
  String get welcome_password_creation_show_semantic => 'Mostrar contraseña';

  @override
  String get welcome_password_creation_hide_semantic => 'Ocultar contraseña';

  @override
  String get welcome_password_creation_error_password_save => 'Se produjo un error al guardar su contraseña';

  @override
  String get welcome_password_creation_remember => 'Agregar una pista de contraseña (opcional)';

  @override
  String get welcome_password_creation_password_requirements => 'La contraseña debe tener al menos 8 caracteres e incluir al menos una letra mayúscula, una letra minúscula y un dígito.';

  @override
  String get calendar_main_calendar_name => 'Calendario principal';

  @override
  String get calendar_button_new_event_button_title => 'Evento';

  @override
  String get calendar_button_new_due_date_button_title => 'Fecha de vencimiento';

  @override
  String get calendar_button_calendar_title => 'Calendario';

  @override
  String get calendar_button_next_events_title => 'Próximos eventos';

  @override
  String get calendar_button_next_due_dates_title => 'Fechas de vencimiento';

  @override
  String get calendar_button_add_event_button_tooltip => 'Agregar un evento';

  @override
  String get calendar_button_manage_calendar_button_tooltip => 'Administrar calendarios';

  @override
  String get calendar_button_event_date_yesterday => 'Ayer';

  @override
  String get calendar_button_event_date_today => 'Hoy';

  @override
  String get calendar_button_event_date_tomorrow => 'Mañana';

  @override
  String get calendar_button_due_date_cancel_complete => 'Cancelar';

  @override
  String calendar_button_due_date_has_been_complete(Object eventName, Object username) {
    return '$eventName ha sido completado por $username';
  }

  @override
  String get calendar_event_detailed_preview_not_completed_yet => 'Aún no completado';

  @override
  String calendar_event_detailed_preview_completed_by(Object username) {
    return 'Completado por $username';
  }

  @override
  String get calendar_new_event_title => 'Nuevo evento';

  @override
  String get calendar_modify_event_title => 'Modificar evento';

  @override
  String get calendar_new_due_date_title => 'Nueva fecha de vencimiento';

  @override
  String get calendar_modify_due_date_title => 'Modificar fecha de vencimiento';

  @override
  String get calendar_new_event_whole_day => 'Día completo';

  @override
  String get calendar_new_event_recurrence_subtitle => 'Recurrencia';

  @override
  String get calendar_new_event_recurrence_type_never => 'Nunca';

  @override
  String get calendar_new_event_recurrence_type_everyday => 'Todos los días';

  @override
  String get calendar_new_event_recurrence_type_everyweek => 'Cada semana';

  @override
  String get calendar_new_event_recurrence_type_everymonth => 'Cada mes';

  @override
  String get calendar_new_event_recurrence_type_everyyear => 'Cada año';

  @override
  String get calendar_new_event_recurrence_select_calendar => 'Selecciona un calendario';

  @override
  String get calendar_button_open_week_view_button_tooltip => 'Abrir vista semanal';

  @override
  String get calendar_button_event_selection_menu_only_this_event => 'Solo este evento';

  @override
  String get calendar_button_event_selection_menu_all_occurence => 'Todas las ocurrencias';

  @override
  String get calendar_button_free_for_next_days => 'Estás libre durante los próximos 5 días.';

  @override
  String get calendar_button_manage_calendars_sub_menu_all_calendars_subtitle => 'Todos los calendarios';

  @override
  String get calendar_button_manage_calendars_sub_menu_add_calendar => 'Nuevo calendario';

  @override
  String get calendar_button_manage_calendars_sub_menu_modify_calendar => 'Editar calendario';

  @override
  String get calendar_button_new_calendar_calendar_subtitle_name => 'Nombre';

  @override
  String get calendar_button_new_calendar_personalized_color => 'Personalizado';

  @override
  String get calendar_button_new_calendar_private_calendar_title => 'Calendario privado';

  @override
  String get calendar_button_new_calendar_private_calendar_explanation => 'Al habilitar esta opción, se requerirá la contraseña para ver los eventos en este calendario';

  @override
  String get calendar_button_event_preview_private_event => 'Este evento es privado.';

  @override
  String get calendar_button_event_preview_see_button => 'Ver';

  @override
  String calendar_button_event_preview_recurence_text_every_day(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'Cada $interval días',
      one: 'Todos los días',
    );
    return '$_temp0';
  }

  @override
  String calendar_button_event_preview_recurence_text_every_week(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'Cada $interval semanas',
      one: 'Cada semana',
    );
    return '$_temp0';
  }

  @override
  String calendar_button_event_preview_recurence_text_every_month(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'Cada $interval meses',
      one: 'Cada mes',
    );
    return '$_temp0';
  }

  @override
  String calendar_button_event_preview_recurence_text_every_year(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'Cada $interval años',
      one: 'Cada año',
    );
    return '$_temp0';
  }

  @override
  String calendar_week_view_week_title(Object week) {
    return 'Semana $week';
  }

  @override
  String get calendar_week_view_week_details => 'Detalles';

  @override
  String get calendar_new_due_date_event_completion_state_subtitle => 'Estado de finalización';

  @override
  String get calendar_new_due_date_event_completion_state => 'Estado';

  @override
  String get calendar_new_event_recurence_type_subtitle => 'Tipo';

  @override
  String get calendar_new_event_recurence_every_subtitle => 'Cada';

  @override
  String calendar_new_event_recurence_every_day(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'días',
      one: 'día',
    );
    return '$_temp0';
  }

  @override
  String calendar_new_event_recurence_every_week(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'semanas',
      one: 'semana',
    );
    return '$_temp0';
  }

  @override
  String calendar_new_event_recurence_every_month(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'meses',
      one: 'mes',
    );
    return '$_temp0';
  }

  @override
  String calendar_new_event_recurence_every_year(num interval) {
    String _temp0 = intl.Intl.pluralLogic(
      interval,
      locale: localeName,
      other: 'años',
      one: 'año',
    );
    return '$_temp0';
  }

  @override
  String get calendar_new_event_recurence_end_date => 'Fecha de finalización';

  @override
  String get calendar_new_event_recurence_end_date_option_the => 'El...';

  @override
  String get center_menu_general => 'General';

  @override
  String get center_menu_others => 'Otros';

  @override
  String get settings_title => 'Ajustes';

  @override
  String get settings_personalize_title => 'Personalizar';

  @override
  String get settings_accessibility_title => 'Accesibilidad';

  @override
  String get settings_security_title => 'Seguridad';

  @override
  String get settings_account_title => 'Mi cuenta';

  @override
  String get settings_theme_subtitle => 'Tema';

  @override
  String get settings_using_dark_mode => 'Modo oscuro';

  @override
  String get settings_using_light_mode => 'Modo claro';

  @override
  String get settings_need_to_quit_project_to_change_theme => 'Para cambiar la configuración del tema, regrese a inicio';

  @override
  String get settings_need_to_quit_project_to_change_language => 'Para cambiar el idioma, regrese a inicio';

  @override
  String get settings_using_system_theme => 'Tema del sistema';

  @override
  String get settings_personalize_black_and_white_title => 'Modo blanco y negro';

  @override
  String get settings_date_format_subtitle => 'Formato de fecha';

  @override
  String get settings_date_format => 'Prefiero el formato de fecha MM/dd';

  @override
  String settings_date_format_tooltip(Object actualDay, Object actualMonth) {
    return 'Esta opción pondrá el mes antes del día. Así: $actualMonth/$actualDay';
  }

  @override
  String get settings_language_subtitle => 'Idioma';

  @override
  String get settings_username_subtitle => 'Nombre';

  @override
  String get settings_reset_subtitle => 'Restablecer';

  @override
  String get settings_reset_button => 'Restablecer ajustes';

  @override
  String get settings_project_rename_button => 'Renombrar';

  @override
  String get settings_project_rename_subtitle => 'Renombrar';

  @override
  String get settings_project_delete_subtitle => 'Eliminar';

  @override
  String get settings_project_delete_button => 'Eliminar este proyecto';

  @override
  String get settings_project_privacy_subtitle => 'Privacidad';

  @override
  String get settings_project_private_project => 'Proyecto privado';

  @override
  String get articles_search => 'Buscar';

  @override
  String get articles_search_explain => 'Buscar un título, autor';

  @override
  String get articles_search_empty => 'Sin resultados';

  @override
  String get articles_impossible_to_load_content => 'No se puede cargar el contenido del artículo';

  @override
  String get articles_corrupted_file => 'Este artículo está corrupto';

  @override
  String articles_importer_images_found_many(Object count) {
    return '$count imágenes encontradas. ¿Quieres importarlas?';
  }

  @override
  String get articles_importer_image_found_single => '1 imagen encontrada. ¿Quieres importarla?';

  @override
  String get articles_importer_import_images_title => 'Importar imágenes';

  @override
  String get articles_importer_import_images_button => 'Importar';

  @override
  String get articles_importer_dont_import_images_button => 'No importar';

  @override
  String get articles_empty_menu_page_text => '¡No hay artículos para esta categoría, importa o escribe uno!';

  @override
  String get articles_empty_menu_saved_page_text => 'No se guardaron artículos.';

  @override
  String get articles_new_article => 'Nuevo artículo';

  @override
  String get articles_import_articles => 'Importar artículos';

  @override
  String get articles_export_articles => 'Exportar este artículo';

  @override
  String get articles_export_articles_choose_category => 'Elige una categoría';

  @override
  String get articles_export_canceled => 'El artículo no ha sido exportado';

  @override
  String get articles_export_confirmed => 'El artículo ha sido exportado';

  @override
  String get articles_export_confirmed_button => 'Ver ubicación';

  @override
  String get articles_creativity_title => 'Creatividad';

  @override
  String get articles_daily_life_title => 'Vida cotidiana';

  @override
  String get articles_professional_title => 'Profesional';

  @override
  String get articles_wellness_title => 'Bienestar';

  @override
  String get articles_technology_title => 'Tecnología';

  @override
  String get articles_education_title => 'Educación';

  @override
  String get articles_science_title => 'Ciencia';

  @override
  String get articles_philosophy_title => 'Filosofía';

  @override
  String get articles_environment_title => 'Medio ambiente';

  @override
  String get articles_travel_title => 'Viaje';

  @override
  String get articles_finance_title => 'Finanzas';

  @override
  String get articles_politics_title => 'Política';

  @override
  String get articles_food_title => 'Alimentación';

  @override
  String get articles_saved_title => 'Guardados';

  @override
  String get articles_my_articles_title => 'Mis artículos';

  @override
  String get articles_read_button => 'Leer';

  @override
  String get articles_sources_text => 'Fuentes';

  @override
  String get articles_bookmark_semantic_text => 'Guardar el artículo';

  @override
  String get articles_add_text_semantic_text => 'Añadir un bloque de texto';

  @override
  String get articles_add_subtitle_semantic_text => 'Añadir un subtítulo';

  @override
  String get articles_add_image_semantic_text => 'Añadir una imagen';

  @override
  String get articles_go_back_semantic_text => 'Volver';

  @override
  String get articles_card_untitled => 'Sin título';

  @override
  String get articles_title_hint => 'Introduce un título...';

  @override
  String get articles_subtitle_hint => 'Introduce un subtítulo...';

  @override
  String get articles_text_hint => 'Introduce texto...';

  @override
  String get articles_code_hint => 'Introduce código...';

  @override
  String get articles_copy_text => 'Copiar';

  @override
  String get articles_copy_to_notes_text => 'Añadir a notas';

  @override
  String get articles_add_to_content => 'Añadir al artículo';

  @override
  String get articles_images_add_button => 'Añadir una imagen';

  @override
  String get articles_images_change_button => 'Cambiar la imagen';

  @override
  String get articles_card_delete_this_article => 'este artículo';

  @override
  String get articles_bottom_menu_open_semantic_text => 'Abrir menú';

  @override
  String get articles_bottom_menu_close_semantic_text => 'Cerrar menú';

  @override
  String get articles_bottom_menu_sources_button => 'Fuentes';

  @override
  String get articles_bottom_menu_content_button => 'Contenido';

  @override
  String get articles_bottom_menu_notes_button => 'Notas';

  @override
  String get articles_add_source_hint => 'Indicar una fuente...';

  @override
  String get articles_add_source_button => 'Añadir una fuente';

  @override
  String articles_no_notes(Object actionName) {
    return '¡No tienes ninguna nota! Haz clic en \'$actionName\' para empezar a tomar notas.';
  }

  @override
  String get articles_no_sources => '¡No se ha proporcionado ninguna fuente por el momento! No olvides incluir fuentes para los futuros lectores.';

  @override
  String get articles_no_content => '¡Este artículo está vacío! Añade elementos para poder moverlos.';

  @override
  String get articles_calculate_reading_time => 'Calcular el tiempo de lectura';

  @override
  String get articles_add_list_semantic_text => 'Añadir una lista';

  @override
  String get articles_add_code_semantic_text => 'Añadir un bloque de código';

  @override
  String get articles_define_language => 'Definir el lenguaje';

  @override
  String get articles_imported => 'Los artículos han sido importados';

  @override
  String get articles_not_imported => 'Los artículos no han sido gravados';

  @override
  String get snackbar_cancel_button => 'Cancelar';

  @override
  String get snackbar_restart_needed_text => 'Debes reiniciar la aplicación para aplicar los cambios';

  @override
  String get snackbar_restart_button => 'Cerrar la app';

  @override
  String get snackbar_reset_text => '¿Restablecer los ajustes?';

  @override
  String get snackbar_reset_button => 'Restablecer';

  @override
  String snackbar_delete_element_text(Object element) {
    return '¿Eliminar $element?';
  }

  @override
  String get snackbar_delete_button => 'Eliminar';

  @override
  String get snackbar_articles_saved => 'Este artículo ha sido guardado';

  @override
  String get snackbar_articles_unsaved => 'Este artículo ya no está guardado';

  @override
  String get snackbar_close_button => 'Cerrar';

  @override
  String snackbar_welcome_back_text(Object user) {
    return 'Encantado de verte de nuevo $user';
  }

  @override
  String get snackbar_welcome_back_button => 'Gracias';

  @override
  String get home_appbar => 'Inicio';

  @override
  String greeting_morning(Object username) {
    return 'Buenos días $username';
  }

  @override
  String greeting_afternoon(Object username) {
    return 'Buenas tardes $username';
  }

  @override
  String greeting_evening(Object username) {
    return 'Buenas noches $username';
  }

  @override
  String get home_pick_up => 'Continúa donde lo dejaste';

  @override
  String get home_discover => 'Descubrir minddy';

  @override
  String get home_articles_card_open_hint => 'Abrir este artículo';

  @override
  String get submenu_new_project_title => 'Nuevo proyecto';

  @override
  String get submenu_new_project_subtitle => 'Nombre del proyecto';

  @override
  String get submenu_new_project_hint => 'Introduce el nombre del proyecto...';

  @override
  String get submenu_new_project_button => 'Crear';

  @override
  String get submenu_new_project_errorMessage => 'Por favor, proporciona un nombre para el proyecto';

  @override
  String get submenu_artilces_image_description_title => 'Descripción';

  @override
  String get submenu_artilces_image_description_subtitle => 'Descripción de la imagen';

  @override
  String get submenu_artilces_image_description_hint => 'Describe la imagen...';

  @override
  String get submenu_artilces_image_description_button => 'Validar';

  @override
  String get submenu_welcome_password_mnemonic_sentence_title => 'Frase de recordatorio de contraseña';

  @override
  String get submenu_welcome_password_mnemonic_sentence_subtitle => 'Añadir una frase de recordatorio de contraseña';

  @override
  String get submenu_welcome_password_mnemonic_sentence_hint => 'Introduce tu frase de recordatorio de contraseña';

  @override
  String get submenu_welcome_password_mnemonic_sentence_instructs => 'Esta función te ayuda a recordar tu contraseña si la olvidas. No se recomienda introducir tu contraseña directamente; por favor, proporciona una pista en su lugar.';

  @override
  String get submenu_unlock_subtitle_text => 'Introduce tu contraseña';

  @override
  String get submenu_unlock_show_mnemonic => 'Mostrar la frase de recordatorio de contraseña';

  @override
  String get submenu_unlock_hide_mnemonic => 'Ocultar la frase de recordatorio de contraseña';

  @override
  String get submenu_unlock_error_message_incorrect_password => 'Contraseña incorrecta';

  @override
  String get submenu_unlock_error_message_please_enter_password => 'Por favor ingresa tu contraseña';

  @override
  String get submenu_unlock_error_message_error_login => 'No se puede verificar la contraseña.';

  @override
  String get submenu_unlock_content_title => 'Desbloquear';

  @override
  String get custom_date_picker_start => 'Inicio';

  @override
  String get custom_date_picker_end => 'Fin';

  @override
  String get custom_date_picker_invalid_date => 'Fecha no válida';

  @override
  String get custom_date_picker_select_single_date_title => 'Selecciona una fecha';

  @override
  String get custom_date_picker_select_multiples_date_title => 'Seleccionar fechas';

  @override
  String get custom_date_picker_include_hour => 'Incluir hora';

  @override
  String get project_card_open_settings => 'Modificar';

  @override
  String get project_card_duplicate => 'Duplicar';

  @override
  String get project_card_delete => 'Eliminar';

  @override
  String get tool_pomodoro_work_duration => 'Duración de la sesión de trabajo';

  @override
  String get tool_pomodoro_work_session => 'Trabajo';

  @override
  String get tool_pomodoro_break_duration => 'Duración de la sesión de descanso';

  @override
  String get tool_pomodoro_break_session => 'Romper';

  @override
  String tool_pomodoro_break_snackbar(num duration) {
    String _temp0 = intl.Intl.pluralLogic(
      duration,
      locale: localeName,
      other: 'Pomodoro - Es hora de un descanso por $duration minutos',
      one: 'Pomodoro - Es hora de un descanso por $duration minuto',
      zero: 'Pomodoro - Es hora de un descanso',
    );
    return '$_temp0';
  }

  @override
  String tool_pomodoro_work_snackbar(num duration) {
    String _temp0 = intl.Intl.pluralLogic(
      duration,
      locale: localeName,
      other: 'Pomodoro - Es hora de volver al trabajo por $duration minutos',
      one: 'Pomodoro - Es hora de volver al trabajo por $duration minuto',
      zero: 'Pomodoro - Es hora de volver al trabajo',
    );
    return '$_temp0';
  }

  @override
  String tool_pomodoro_end_session(num duration) {
    String _temp0 = intl.Intl.pluralLogic(
      duration,
      locale: localeName,
      other: '$duration minutos',
      one: '1 minuto',
    );
    return 'La sesión de pomodoro ha terminado, has trabajado $_temp0. ¡Es hora de descansar!';
  }

  @override
  String get tool_pomodoro_repetition_count => 'Número de repeticiones';

  @override
  String get tool_pomodoro_focus_timer => 'Temporizador de enfoque';

  @override
  String get tool_pomodoro_start_button => 'Iniciar';

  @override
  String get tool_pomodoro_stop_button => 'Detener';

  @override
  String get projects_next_page_shortcut_tooltip_mac => 'Página siguiente (⌘ + ⭢)';

  @override
  String get projects_previous_page_shortcut_tooltip_mac => 'Página anterior (⌘ + ⭠)';

  @override
  String get projects_next_page_shortcut_tooltip => 'Página siguiente (ctrl + ⭢)';

  @override
  String get projects_previous_page_shortcut_tooltip => 'Página anterior (ctrl + ⭠)';

  @override
  String get projects_add_module_tooltip => 'Nuevo módulo';

  @override
  String get projects_save_project_button_tooltip => 'Guardar';

  @override
  String get projects_module_help_text => 'Ayuda';

  @override
  String get projects_module_tasks_title => 'Tareas';

  @override
  String projects_module_tasks_completed(Object checkedTasks, num totalTasksCount) {
    String _temp0 = intl.Intl.pluralLogic(
      totalTasksCount,
      locale: localeName,
      other: '$checkedTasks/$totalTasksCount tareas completadas',
      one: '$checkedTasks/$totalTasksCount tarea completada',
      zero: 'Sin tareas',
    );
    return '$_temp0';
  }

  @override
  String get projects_module_tasks_task_title_hint => 'Título';

  @override
  String get projects_module_tasks_task_add_subtask_tooltip => 'Agregar una subtarea';

  @override
  String get projects_module_tasks_add_task_tooltip => 'Agregar una nueva tarea';

  @override
  String get projects_module_notes_new_category_tooltip => 'Nueva categoría';

  @override
  String get projects_module_notes_new_note_tooltip => 'Nueva nota';

  @override
  String get projects_module_notes_modify_category => 'Modificar';

  @override
  String get projects_module_notes_modify_note_tooltip => 'Editar esta nota';

  @override
  String get projects_module_notes_new_category_sub_menu_title => 'Nueva categoría';

  @override
  String get projects_module_notes_new_category_sub_menu_subtitle => 'Nombre de categoría';

  @override
  String get projects_module_notes_new_category_sub_menu_name_hint => 'Ingrese el nombre de la categoría';

  @override
  String get projects_module_notes_new_category_sub_menu_is_private => 'Categoria privada';

  @override
  String get projects_module_notes_new_category_sub_menu_error_message => 'Por favor, nombre la categoría';

  @override
  String get projects_module_notes_new_category_sub_menu_is_private_tooltip => 'Habilitar esta opción requerirá su contraseña para abrir esta categoría.';

  @override
  String get projects_module_notes_modify_category_sub_menu_title => 'Editar categoría';

  @override
  String get projects_module_notes_editing_note_sub_menu_save_tooltip => 'Guardar nota';

  @override
  String get projects_module_notes_editing_note_sub_menu_move_tooltip => 'Mover';

  @override
  String get projects_module_notes_for_later_title => 'Notas para más adelante';

  @override
  String get projects_module_notes_important_notes_title => 'Notas importantes';

  @override
  String get projects_module_notes_private_notes_title => 'Notas Privadas';

  @override
  String get projects_module_notes_project_notes_title => 'Notas del proyecto';

  @override
  String projects_module_notes_category_note_count(num totalNotesCount) {
    String _temp0 = intl.Intl.pluralLogic(
      totalNotesCount,
      locale: localeName,
      other: '$totalNotesCount notas',
      one: '1 nota',
      zero: 'Sin notas',
    );
    return '$_temp0';
  }

  @override
  String get projects_module_notes_title => 'Notas';

  @override
  String get projects_module_spreadsheet_title => 'Hoja de cálculo';

  @override
  String get projects_module_spreadsheet_value_unnamed => 'Sin nombre';

  @override
  String get projects_module_spreadsheet_new_row => 'Nueva fila';

  @override
  String get projects_module_spreadsheet_new_column => 'Nueva columna';

  @override
  String get projects_module_spreadsheet_delete_row => 'Eliminar esta fila';

  @override
  String get projects_module_spreadsheet_delete_column => 'Eliminar esta columna';

  @override
  String get projects_module_spreadsheet_data_column_type => 'Tipo de columna';

  @override
  String get projects_module_spreadsheet_data_choose_column_type_tooltip => 'Elija un tipo de columna';

  @override
  String get projects_module_spreadsheet_data_type_text => 'Texto';

  @override
  String get projects_module_spreadsheet_data_type_number => 'Número';

  @override
  String get projects_module_spreadsheet_data_type_phone_number => 'Número de teléfono';

  @override
  String get projects_module_spreadsheet_data_type_email => 'Correo electrónico';

  @override
  String get projects_module_spreadsheet_data_type_url => 'URL';

  @override
  String get projects_module_spreadsheet_data_type_date => 'Fecha';

  @override
  String get projects_module_spreadsheet_date_from_text => 'De';

  @override
  String get projects_module_spreadsheet_date_to_text => 'Para';

  @override
  String get projects_module_spreadsheet_date_single_tooltip => 'Fecha única';

  @override
  String get projects_module_spreadsheet_date_start_end_tooltip => 'Agregar una fecha de finalización';

  @override
  String get projects_module_spreadsheet_data_type_selection => 'Selección';

  @override
  String projetcs_module_spreadsheet_open_website(Object websiteName) {
    return 'Abrir $websiteName';
  }

  @override
  String get projects_module_spreadsheet_number_operation_none => 'Ninguno';

  @override
  String get projects_module_spreadsheet_number_operation_sum => 'Suma';

  @override
  String get projects_module_spreadsheet_number_operation_average => 'Promedio';

  @override
  String get projects_module_spreadsheet_number_operation_maximum => 'Máximo';

  @override
  String get projects_module_spreadsheet_number_operation_minimum => 'Mínimo';

  @override
  String get projects_module_spreadsheet_number_operation_interval => 'Intervalo';

  @override
  String get projects_module_spreadsheet_number_operation_median => 'Mediana';

  @override
  String get projects_module_spreadsheet_number_operation_standard_deviation => 'Desviación estándar';

  @override
  String get projects_module_spreadsheet_number_operation_calculate => 'Calcular';

  @override
  String get projects_module_spreadsheet_number_operation_sum_example => '10 + 50 + 100';

  @override
  String get projects_module_spreadsheet_number_operation_sum_message => 'Suma todos los valores en la columna para obtener el total. Útil para resumir datos.';

  @override
  String get projects_module_spreadsheet_number_operation_average_example => '(10 + 50 + 100) / 3';

  @override
  String get projects_module_spreadsheet_number_operation_average_message => 'Calcula el promedio dividiendo la suma de todos los valores por el número de valores. Esto ayuda a encontrar el valor central de los datos.';

  @override
  String get projects_module_spreadsheet_number_operation_maximum_example => '(10, 50, 100) = 100';

  @override
  String get projects_module_spreadsheet_number_operation_maximum_message => 'Encuentra el valor más alto en la columna. Útil para identificar el número más grande.';

  @override
  String get projects_module_spreadsheet_number_operation_minimum_example => '(10, 50, 100) = 10';

  @override
  String get projects_module_spreadsheet_number_operation_minimum_message => 'Encuentra el valor más bajo en la columna. Esto ayuda a identificar el número más pequeño.';

  @override
  String get projects_module_spreadsheet_number_operation_interval_example => '(10, 50, 100) = 90';

  @override
  String get projects_module_spreadsheet_number_operation_interval_message => 'Calcula el rango restando el valor más pequeño del valor más grande en la columna. Esto muestra la distribución de valores.';

  @override
  String get projects_module_spreadsheet_number_operation_median_example => '(10, 50, 100) = 50';

  @override
  String get projects_module_spreadsheet_number_operation_median_message => 'Encuentra el valor central cuando se ordenan los valores de las columnas. Útil para identificar el valor central.';

  @override
  String get projects_module_spreadsheet_number_operation_standardDeviation_example => '√[((10-53.33)² + (50-53.33)² + (100-53.33)²) / 3]';

  @override
  String get projects_module_spreadsheet_number_operation_standardDeviation_message => 'Calcula la desviación estándar para medir cuánto varían los valores de la media. Aquí, 53,33 es el promedio de los valores 10, 50 y 100.';

  @override
  String get projects_module_spreadsheet_extend_cell_tooltip => 'Extender esta celda';

  @override
  String get projects_module_spreadsheet_selection_cell_not_started => 'Aún no ha comenzado';

  @override
  String get projects_module_spreadsheet_selection_cell_started => 'Iniciado';

  @override
  String get projects_module_spreadsheet_selection_cell_finished => 'Terminado';

  @override
  String get projects_module_spreadsheet_selection_cell_modify_options => 'Modificar opciones';

  @override
  String get projects_module_spreadsheet_selection_cell_add_options => 'Agregar opciones';

  @override
  String get projects_module_spreadsheet_selection_cell_add_an_option => 'Agregar una opción';

  @override
  String get projects_module_spreadsheet_selection_cell_all_options => 'Todas las opciones';

  @override
  String get projects_module_spreadsheet_selection_cell_name_option_hint => 'Nombre esta opción...';

  @override
  String get projects_module_spreadsheet_manage_columns_sub_menu_title => 'Organizar columnas';

  @override
  String get projects_module_spreadsheet_manage_columns_sub_menu_subtitle => 'Todas las columnas';

  @override
  String get projects_module_spreadsheet_manage_rows_sub_menu_title => 'Organizar filas';

  @override
  String get projects_module_spreadsheet_manage_rows_sub_menu_subtitle => 'Todas las filas';

  @override
  String get projects_module_spreadsheet_selection_sub_menu_error_message_no_options => 'Por favor agregue opciones';

  @override
  String get projects_module_spreadsheet_selection_sub_menu_error_message_unnamed_option => 'Por favor nombre todas las opciones';

  @override
  String projects_module_spreadsheet_selection_sub_menu_error_message_redundant_option_name(Object optionName) {
    return 'Dos opciones no pueden tener el mismo nombre ($optionName)';
  }

  @override
  String get projects_module_spreadsheet_selection_sub_menu_error_message_redundant_color => 'Dos opciones no pueden tener el mismo color';

  @override
  String get projects_module_spreadsheet_chart_show_table => 'Mostrar tabla';

  @override
  String get projects_module_spreadsheet_chart_show_chart => 'Mostrar gráficos';

  @override
  String get projects_module_spreadsheet_chart_new_tab => 'Nueva pestaña';

  @override
  String get projects_module_spreadsheet_chart_new_column => 'Agregar una columna';

  @override
  String get projects_module_spreadsheet_chart_chart_type_subtitle => 'Tipo de gráfico';

  @override
  String get projects_module_spreadsheet_chart_chart_type_donut => 'Donut';

  @override
  String get projects_module_spreadsheet_chart_chart_type_bar => 'Barra';

  @override
  String get projects_module_spreadsheet_chart_chart_type_bar_simple => 'Barras simples';

  @override
  String get projects_module_spreadsheet_chart_chart_type_bar_grouped => 'Barras agrupadas';

  @override
  String get projects_module_spreadsheet_chart_chart_type_bar_stacked => 'Barras apiladas';

  @override
  String get projects_module_spreadsheet_chart_chart_select_column => 'Seleccione una columna';

  @override
  String get projects_module_spreadsheet_chart_chart_column_single => 'Columna';

  @override
  String get projects_module_spreadsheet_chart_chart_column_plural => 'Columnas';

  @override
  String get custom_chart_empty_content => 'Para crear un gráfico, agréguele datos';

  @override
  String get custom_chart_donut_total => 'Total';

  @override
  String get custom_chart_donut_share => 'Parte';

  @override
  String get custom_chart_grid_extend_chart => 'Ampliar gráfico';

  @override
  String get custom_color_picker_opacity_tooltip => 'Opacidad';

  @override
  String get node_editor_view_new_node_tooltip => 'Nuevo nodo';

  @override
  String get node_editor_view_close_node_panel_tooltip => 'Cerrar panel de nodos';

  @override
  String get node_editor_view_open_node_panel_tooltip => 'Abrir panel de nodos';

  @override
  String get node_editor_view_close_side_panel_tooltip => 'Cerrar panel lateral';

  @override
  String get node_editor_view_open_side_panel_tooltip => 'Abrir panel lateral';

  @override
  String get node_editor_view_side_panel_variables_title => 'Variables';

  @override
  String get node_editor_view_side_panel_variables_add_button_tooltip => 'Nueva variable';

  @override
  String get node_editor_view_side_panel_variables_variable_type_any => 'No definido';

  @override
  String get node_editor_view_side_panel_variables_variable_type_number => 'Número';

  @override
  String get node_editor_view_side_panel_variables_variable_type_text => 'Texto';

  @override
  String get node_editor_view_side_panel_variables_variable_type_boolean => 'Booleano';

  @override
  String get node_editor_view_side_panel_variables_variable_type_list => 'Lista';

  @override
  String get node_editor_view_side_panel_variables_variable_type_color => 'Color';

  @override
  String get node_editor_view_side_panel_node_trees_title => 'Árboles de nodos';

  @override
  String get node_editor_view_side_panel_node_trees_add_button_tooltip => 'Nuevo árbol';

  @override
  String get node_editor_view_bottom_toolbar_undo_tooltip_windows => 'Deshacer (ctrl + z)';

  @override
  String get node_editor_view_bottom_toolbar_undo_tooltip_mac => 'Deshacer (⌘ + z)';

  @override
  String get node_editor_view_bottom_toolbar_redo_tooltip_windows => 'Rehacer (⇧ + ctrl + z)';

  @override
  String get node_editor_view_bottom_toolbar_redo_tooltip_mac => 'Rehacer (⇧ + ⌘ + z)';

  @override
  String node_editor_view_bottom_toolbar_copy_tooltip_windows(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Copiar nodos seleccionados (ctrl + c)',
      one: 'Copiar nodo seleccionado (ctrl + c)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_copy_tooltip_mac(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Copiar nodos seleccionados (⌘ + c)',
      one: 'Copiar nodo seleccionado (⌘ + c)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_paste_tooltip_windows(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Pegar nodos copiados (ctrl + v)',
      one: 'Pegar nodo copiado (ctrl + v)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_paste_tooltip_mac(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Pegar nodos copiados (⌘ + v)',
      one: 'Pegar nodo copiado (⌘ + v)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_duplicate_tooltip_windows(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Duplicar nodos seleccionados (ctrl + d)',
      one: 'Duplicar nodo seleccionado (ctrl + d)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_duplicate_tooltip_mac(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Duplicar nodos seleccionados (⌘ + d)',
      one: 'Duplicar nodo seleccionado (⌘ + d)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_delete_tooltip_windows(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Eliminar nodos seleccionados (ctrl + ⌫)',
      one: 'Eliminar nodo seleccionado (ctrl + ⌫)',
    );
    return '$_temp0';
  }

  @override
  String node_editor_view_bottom_toolbar_delete_tooltip_mac(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Eliminar nodos seleccionados (⌘ + ⌫)',
      one: 'Eliminar nodo seleccionado (⌘ + ⌫)',
    );
    return '$_temp0';
  }

  @override
  String get node_editor_add_sub_menu_types => 'Tipos';

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
      other: 'Salidas',
      one: 'Salida',
    );
    return '$_temp0';
  }

  @override
  String get node_editor_add_sub_menu_note => 'Nota: Las entradas y salidas pueden variar dependiendo de las opciones elegidas para el nodo';

  @override
  String get node_editor_add_sub_menu_no_nodes_found => 'No se encontraron nodos.';

  @override
  String get node_editor_add_sub_menu_add_button => 'Agregar';

  @override
  String get node_editor_add_sub_menu_none_input_output => 'Ninguno';

  @override
  String get node_widgets_value_text => 'Valor';

  @override
  String get node_widgets_result_text => 'Resultado';

  @override
  String get node_widgets_text_text => 'Texto';

  @override
  String get node_widgets_start_text => 'Inicio';

  @override
  String get node_widgets_end_text => 'Fin';

  @override
  String get node_widgets_length_text => 'Longitud';

  @override
  String get node_widgets_treshold_text => 'Límite';

  @override
  String get node_widgets_category_math => 'Matemáticas';

  @override
  String get node_widgets_category_logic => 'Lógica';

  @override
  String get node_widgets_category_variable => 'Variables';

  @override
  String get node_widgets_math_node_title => 'Cálculos';

  @override
  String get node_widgets_math_node_description => 'Realiza cálculos con números.';

  @override
  String get node_widgets_math_node_options_addition => 'Suma';

  @override
  String get node_widgets_math_node_options_substraction => 'Resta';

  @override
  String get node_widgets_math_node_options_division => 'División';

  @override
  String get node_widgets_math_node_options_multiplication => 'Multiplicación';

  @override
  String get node_widgets_math_node_options_squareRoot => 'Raíz cuadrada';

  @override
  String get node_widgets_math_node_options_power => 'Potencia';

  @override
  String get node_widgets_math_node_options_min => 'Mínimo';

  @override
  String get node_widgets_math_node_options_max => 'Máximo';

  @override
  String get node_widgets_math_node_options_sign => 'Signo';

  @override
  String get node_widgets_math_node_options_round => 'Redondear';

  @override
  String get node_widgets_math_node_options_floor => 'Piso';

  @override
  String get node_widgets_math_node_options_ceil => 'Techo';

  @override
  String get node_widgets_math_node_options_truncate => 'Truncar';

  @override
  String get node_widgets_math_node_options_sin => 'Seno';

  @override
  String get node_widgets_math_node_options_cos => 'Coseno';

  @override
  String get node_widgets_math_node_options_tan => 'Tangente';

  @override
  String get node_widgets_math_node_options_asin => 'Arco seno';

  @override
  String get node_widgets_math_node_options_acos => 'Arco coseno';

  @override
  String get node_widgets_math_node_options_atan => 'Arco tangente';

  @override
  String get node_widgets_math_node_options_sinh => 'Sinh';

  @override
  String get node_widgets_math_node_options_cosh => 'Cosh';

  @override
  String get node_widgets_math_node_options_tanh => 'Tanh';

  @override
  String get node_widgets_math_node_options_asinh => 'Arco sinh';

  @override
  String get node_widgets_math_node_options_acosh => 'Arco cosh';

  @override
  String get node_widgets_math_node_options_atanh => 'Arco tanh';

  @override
  String get node_widgets_math_node_options_ln => 'Logaritmo natural';

  @override
  String get node_widgets_math_node_options_log10 => 'Logaritmo en base 10';

  @override
  String get node_widgets_math_node_options_abs => 'Valor absoluto';

  @override
  String get node_widgets_comparison_node_title => 'Comparación';

  @override
  String get node_widgets_comparison_node_description => 'Realiza una comparación entre números.';

  @override
  String get node_widgets_comparison_node_options_lessThan => 'Menor que';

  @override
  String get node_widgets_comparison_node_options_lessThanOrEqual => 'Menor o igual que';

  @override
  String get node_widgets_comparison_node_options_greatherThan => 'Mayor que';

  @override
  String get node_widgets_comparison_node_options_greatherThanOrEqual => 'Mayor o igual que';

  @override
  String get node_widgets_comparison_node_options_equal => 'Igual a';

  @override
  String get node_widgets_boolean_node_title => 'Operaciones lógicas';

  @override
  String get node_widgets_boolean_node_description => 'Realiza operaciones con valores booleanos.';

  @override
  String get node_widgets_boolean_node_options_and => 'Y';

  @override
  String get node_widgets_boolean_node_options_or => 'O';

  @override
  String get node_widgets_boolean_node_options_not => 'No';

  @override
  String get node_widgets_boolean_node_options_notAnd => 'No Y';

  @override
  String get node_widgets_boolean_node_options_notOr => 'No O';

  @override
  String get node_widgets_boolean_node_options_equal => 'Igual';

  @override
  String get node_widgets_boolean_node_options_notEqual => 'No Igual';

  @override
  String get node_widgets_boolean_node_options_imply => 'Implicar';

  @override
  String get node_widgets_boolean_node_options_subtract => 'Restar';

  @override
  String get node_widgets_conversion_node_title => 'Conversión';

  @override
  String get node_widgets_conversion_node_decsription => 'Convertir un valor a otro tipo';

  @override
  String get node_widgets_text_operation_node_title => 'Operaciones de texto';

  @override
  String get node_widgets_text_operation_node_decsription => 'Realiza operaciones en texto';

  @override
  String get node_widgets_text_operation_node_options_join => 'Fusionar';

  @override
  String get node_widgets_text_operation_node_options_cut => 'Cortar';

  @override
  String get node_widgets_text_operation_node_options_trim => 'Eliminar el espacio en blanco';

  @override
  String get node_widgets_text_operation_node_options_trim_left => 'Eliminar el espacio en blanco';

  @override
  String get node_widgets_text_operation_node_options_trim_right => 'Elimina el espacio en blanco a la derecha';

  @override
  String get node_widgets_text_operation_node_options_pad_left => 'Rellenar a la izquierda';

  @override
  String get node_widgets_text_operation_node_options_pad_right => 'Rellenar a la derecha';

  @override
  String get node_widgets_text_operation_node_options_contains => 'Contiene';

  @override
  String get node_widgets_set_variable_node_title => 'Establecer variable';

  @override
  String get node_widgets_set_variable_node_description => 'Establece el valor de una variable.';

  @override
  String get node_widgets_get_variable_node_title => 'Obtener variable';

  @override
  String get node_widgets_get_variable_node_description => 'Obtiene el valor de una variable.';

  @override
  String get node_widgets_select_variable_node_text => 'Seleccione una variable';

  @override
  String get node_widgets_random_number_node_title => 'Número aleatorio';

  @override
  String get node_widgets_random_number_node_description => 'Genera un número aleatorio entre un mínimo y un máximo (0 y 1 por defecto).';

  @override
  String get plugin_editor_ui_side_panel_layers_title => 'Componentes';

  @override
  String get plugin_editor_ui_side_panel_layers_add_button => 'Nuevo componente';

  @override
  String get plugin_editor_ui_side_panel_layers_add_child => 'Agregar hijo';

  @override
  String get plugin_editor_ui_side_panel_layers_more_options => 'Más opciones';

  @override
  String plugin_editor_ui_side_panel_layers_hide_child(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Ocultar hijos',
      one: 'Ocultar hijo',
    );
    return '$_temp0';
  }

  @override
  String plugin_editor_ui_side_panel_layers_show_child(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Mostrar hijos',
      one: 'Mostrar hijo',
    );
    return '$_temp0';
  }

  @override
  String get plugin_editor_ui_side_panel_properties_size_subtitle => 'Tamaño';

  @override
  String get plugin_editor_ui_side_panel_properties_size_width => 'Ancho';

  @override
  String get plugin_editor_ui_side_panel_properties_size_height => 'Altura';

  @override
  String get plugin_editor_ui_side_panel_properties_style_subtitle => 'Estilo';

  @override
  String get plugin_editor_ui_side_panel_properties_style_border_radius => 'Radio del borde';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment => 'Alineación';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_top_left => 'Arriba a la izquierda';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_top_right => 'Arriba a la derecha';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_bottom_left => 'Abajo a la izquierda';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_bottom_right => 'Abajo a la derecha';

  @override
  String get plugin_editor_ui_side_panel_properties_border_subtitle => 'Borde';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_top => 'Arriba';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_bottom => 'Abajo';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_left => 'Izquierda';

  @override
  String get plugin_editor_ui_side_panel_properties_style_alignment_right => 'Derecha';

  @override
  String get plugin_editor_ui_side_panel_properties_style_border_thickness => 'Grosor';

  @override
  String get plugin_editor_ui_side_panel_properties_theme_colors_primary => 'Primario';

  @override
  String get plugin_editor_ui_side_panel_properties_theme_colors_primary_transparent => 'Primario transparente';

  @override
  String get plugin_editor_ui_side_panel_properties_theme_colors_accent => 'Acento';

  @override
  String get plugin_editor_ui_side_panel_properties_theme_colors_surface => 'Superficie';

  @override
  String get default_app_colors_change_color => 'Cambiar color';

  @override
  String get default_app_colors_grey => 'Gris';

  @override
  String get default_app_colors_mint_green => 'Verde menta';

  @override
  String get default_app_colors_light_pink => 'Rosa claro';

  @override
  String get default_app_colors_light_yellow => 'Amarillo claro';

  @override
  String get default_app_colors_peach => 'Melocotón';

  @override
  String get default_app_colors_soft_red => 'Rojo suave';

  @override
  String get default_app_colors_lavender => 'Lavanda';

  @override
  String get default_app_colors_light_blue => 'Azul claro';

  @override
  String get default_app_colors_light_green => 'Verde claro';

  @override
  String get default_app_colors_light_purple => 'Púrpura claro';

  @override
  String get default_articles_articles_title => 'Artículos';

  @override
  String get default_articles_articles_description => 'Descubre artículos en minddy';

  @override
  String get default_articles_articles_first_subtitle => 'Función Clave';

  @override
  String get default_articles_articles_first_paragraph => 'Los artículos son una función clave de Minddy. Ofrecen una interfaz elegante e intuitiva para redactar y compartir tus conocimientos. Con esta función, puedes difundir fácilmente tus ideas y beneficiar a toda la comunidad.';

  @override
  String get default_articles_articles_second_subtitle => 'Toma de Notas';

  @override
  String get default_articles_articles_second_paragraph => 'También puedes tomar notas, lo cual es ideal para guardar textos o cualquier otro contenido que desees conservar para más tarde. Esta función es perfecta para capturar ideas o información importante para revisar posteriormente.';

  @override
  String get default_articles_articles_third_subtitle => 'Gestión de Fuentes';

  @override
  String get default_articles_articles_third_paragraph => 'Todas tus fuentes son accesibles a través de un menú situado en la parte inferior de la página, lo que te permite gestionar y recuperar tus referencias fácilmente.';

  @override
  String get default_articles_articles_fourth_subtitle => 'Agregar y Gestionar Contenido';

  @override
  String get default_articles_articles_fourth_paragraph => 'Los botones para agregar elementos a tu artículo se encuentran en la parte superior de la página. Para gestionar este contenido, usa el menú en la parte inferior.';

  @override
  String get default_articles_articles_fifth_subtitle => 'Herramienta Poderosa';

  @override
  String get default_articles_articles_fifth_paragraph => 'Con los artículos, tienes una herramienta poderosa y fácil de usar para organizar, compartir y encontrar tu conocimiento con facilidad.';
}
