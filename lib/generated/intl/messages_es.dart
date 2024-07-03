// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(count) =>
      "${count} imágenes encontradas. ¿Quieres importarlas?";

  static String m1(actionName) =>
      "¡No tienes ninguna nota! Haz clic en \'${actionName}\' para empezar a tomar notas.";

  static String m2(username) => "Buenas tardes ${username}";

  static String m3(username) => "Buenas noches ${username}";

  static String m4(username) => "Buenos días ${username}";

  static String m5(totalNotesCount) =>
      "${Intl.plural(totalNotesCount, zero: 'Sin notas', one: '1 nota', other: '${totalNotesCount} notas')}";

  static String m6(totalTasksCount, checkedTasks) =>
      "${Intl.plural(totalTasksCount, zero: 'Sin tareas', one: '${checkedTasks}/${totalTasksCount} tarea completada', other: '${checkedTasks}/${totalTasksCount} tareas completadas')}";

  static String m7(websiteName) => "Abrir ${websiteName}";

  static String m8(actualMonth, actualDay) =>
      "Esta opción pondrá el mes antes del día. Así: ${actualMonth}/${actualDay}";

  static String m9(element) => "¿Eliminar ${element}?";

  static String m10(user) => "Encantado de verte de nuevo ${user}";

  static String m11(accountSettingName) =>
      "Aún podrás ingresar tu nombre en la configuración - ${accountSettingName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appbar_go_home":
            MessageLookupByLibrary.simpleMessage("Retorno al inicio"),
        "articles_add_code_semantic_text":
            MessageLookupByLibrary.simpleMessage("Añadir un bloque de código"),
        "articles_add_image_semantic_text":
            MessageLookupByLibrary.simpleMessage("Añadir una imagen"),
        "articles_add_list_semantic_text":
            MessageLookupByLibrary.simpleMessage("Añadir una lista"),
        "articles_add_source_button":
            MessageLookupByLibrary.simpleMessage("Añadir una fuente"),
        "articles_add_source_hint":
            MessageLookupByLibrary.simpleMessage("Indicar una fuente..."),
        "articles_add_subtitle_semantic_text":
            MessageLookupByLibrary.simpleMessage("Añadir un subtítulo"),
        "articles_add_text_semantic_text":
            MessageLookupByLibrary.simpleMessage("Añadir un bloque de texto"),
        "articles_add_to_content":
            MessageLookupByLibrary.simpleMessage("Añadir al artículo"),
        "articles_bookmark_semantic_text":
            MessageLookupByLibrary.simpleMessage("Guardar el artículo"),
        "articles_bottom_menu_close_semantic_text":
            MessageLookupByLibrary.simpleMessage("Cerrar menú"),
        "articles_bottom_menu_content_button":
            MessageLookupByLibrary.simpleMessage("Contenido"),
        "articles_bottom_menu_notes_button":
            MessageLookupByLibrary.simpleMessage("Notas"),
        "articles_bottom_menu_open_semantic_text":
            MessageLookupByLibrary.simpleMessage("Abrir menú"),
        "articles_bottom_menu_sources_button":
            MessageLookupByLibrary.simpleMessage("Fuentes"),
        "articles_calculate_reading_time": MessageLookupByLibrary.simpleMessage(
            "Calcular el tiempo de lectura"),
        "articles_card_delete_this_article":
            MessageLookupByLibrary.simpleMessage("este artículo"),
        "articles_card_untitled":
            MessageLookupByLibrary.simpleMessage("Sin título"),
        "articles_code_hint":
            MessageLookupByLibrary.simpleMessage("Introduce código..."),
        "articles_copy_text": MessageLookupByLibrary.simpleMessage("Copiar"),
        "articles_copy_to_notes_text":
            MessageLookupByLibrary.simpleMessage("Añadir a notas"),
        "articles_corrupted_file":
            MessageLookupByLibrary.simpleMessage("Este artículo está corrupto"),
        "articles_creativity_title":
            MessageLookupByLibrary.simpleMessage("Creatividad"),
        "articles_daily_life_title":
            MessageLookupByLibrary.simpleMessage("Vida cotidiana"),
        "articles_define_language":
            MessageLookupByLibrary.simpleMessage("Definir el lenguaje"),
        "articles_education_title":
            MessageLookupByLibrary.simpleMessage("Educación"),
        "articles_empty_menu_page_text": MessageLookupByLibrary.simpleMessage(
            "Está vacío ahora. ¡Importe artículos o escriba los suyos propios para llenar el espacio!"),
        "articles_environment_title":
            MessageLookupByLibrary.simpleMessage("Medio ambiente"),
        "articles_export_articles":
            MessageLookupByLibrary.simpleMessage("Exportar este artículo"),
        "articles_export_articles_choose_category":
            MessageLookupByLibrary.simpleMessage("Elige una categoría"),
        "articles_export_canceled": MessageLookupByLibrary.simpleMessage(
            "El artículo no ha sido exportado"),
        "articles_export_confirmed": MessageLookupByLibrary.simpleMessage(
            "El artículo ha sido exportado"),
        "articles_export_confirmed_button":
            MessageLookupByLibrary.simpleMessage("Ver ubicación"),
        "articles_finance_title":
            MessageLookupByLibrary.simpleMessage("Finanzas"),
        "articles_food_title":
            MessageLookupByLibrary.simpleMessage("Alimentación"),
        "articles_go_back_semantic_text":
            MessageLookupByLibrary.simpleMessage("Volver"),
        "articles_images_add_button":
            MessageLookupByLibrary.simpleMessage("Añadir una imagen"),
        "articles_images_change_button":
            MessageLookupByLibrary.simpleMessage("Cambiar la imagen"),
        "articles_import_articles":
            MessageLookupByLibrary.simpleMessage("Importar artículos"),
        "articles_imported": MessageLookupByLibrary.simpleMessage(
            "Los artículos han sido importados"),
        "articles_importer_dont_import_images_button":
            MessageLookupByLibrary.simpleMessage("No importar"),
        "articles_importer_image_found_single":
            MessageLookupByLibrary.simpleMessage(
                "1 imagen encontrada. ¿Quieres importarla?"),
        "articles_importer_images_found_many": m0,
        "articles_importer_import_images_button":
            MessageLookupByLibrary.simpleMessage("Importar"),
        "articles_importer_import_images_title":
            MessageLookupByLibrary.simpleMessage("Importar imágenes"),
        "articles_impossible_to_load_content":
            MessageLookupByLibrary.simpleMessage(
                "No se puede cargar el contenido del artículo"),
        "articles_my_articles_title":
            MessageLookupByLibrary.simpleMessage("Mis artículos"),
        "articles_new_article":
            MessageLookupByLibrary.simpleMessage("Nuevo artículo"),
        "articles_no_content": MessageLookupByLibrary.simpleMessage(
            "¡Este artículo está vacío! Añade elementos para poder moverlos."),
        "articles_no_notes": m1,
        "articles_no_sources": MessageLookupByLibrary.simpleMessage(
            "¡No se ha proporcionado ninguna fuente por el momento! No olvides incluir fuentes para los futuros lectores."),
        "articles_not_imported": MessageLookupByLibrary.simpleMessage(
            "Los artículos no han sido gravados"),
        "articles_philosophy_title":
            MessageLookupByLibrary.simpleMessage("Filosofía"),
        "articles_politics_title":
            MessageLookupByLibrary.simpleMessage("Política"),
        "articles_professional_title":
            MessageLookupByLibrary.simpleMessage("Profesional"),
        "articles_read_button": MessageLookupByLibrary.simpleMessage("Leer"),
        "articles_saved_title":
            MessageLookupByLibrary.simpleMessage("Guardados"),
        "articles_science_title":
            MessageLookupByLibrary.simpleMessage("Ciencia"),
        "articles_search": MessageLookupByLibrary.simpleMessage("Buscar"),
        "articles_search_empty":
            MessageLookupByLibrary.simpleMessage("Sin resultados"),
        "articles_search_explain":
            MessageLookupByLibrary.simpleMessage("Buscar un título, autor"),
        "articles_sources_text":
            MessageLookupByLibrary.simpleMessage("Fuentes"),
        "articles_subtitle_hint":
            MessageLookupByLibrary.simpleMessage("Introduce un subtítulo..."),
        "articles_technology_title":
            MessageLookupByLibrary.simpleMessage("Tecnología"),
        "articles_text_hint":
            MessageLookupByLibrary.simpleMessage("Introduce texto..."),
        "articles_title_hint":
            MessageLookupByLibrary.simpleMessage("Introduce un título..."),
        "articles_travel_title": MessageLookupByLibrary.simpleMessage("Viaje"),
        "articles_wellness_title":
            MessageLookupByLibrary.simpleMessage("Bienestar"),
        "center_menu_general": MessageLookupByLibrary.simpleMessage("General"),
        "center_menu_others": MessageLookupByLibrary.simpleMessage("Otros"),
        "custom_date_picker_end": MessageLookupByLibrary.simpleMessage("Fin"),
        "custom_date_picker_invalid_date":
            MessageLookupByLibrary.simpleMessage("Fecha no válida"),
        "custom_date_picker_select_multiples_date_title":
            MessageLookupByLibrary.simpleMessage("Seleccionar fechas"),
        "custom_date_picker_select_single_date_title":
            MessageLookupByLibrary.simpleMessage("Selecciona una fecha"),
        "custom_date_picker_start":
            MessageLookupByLibrary.simpleMessage("Inicio"),
        "default_articles_articles_description":
            MessageLookupByLibrary.simpleMessage(
                "Descubre artículos en minddy"),
        "default_articles_articles_fifth_paragraph":
            MessageLookupByLibrary.simpleMessage(
                "Con los artículos, tienes una herramienta poderosa y fácil de usar para organizar, compartir y encontrar tu conocimiento con facilidad."),
        "default_articles_articles_fifth_subtitle":
            MessageLookupByLibrary.simpleMessage("Herramienta Poderosa"),
        "default_articles_articles_first_paragraph":
            MessageLookupByLibrary.simpleMessage(
                "Los artículos son una función clave de Minddy. Ofrecen una interfaz elegante e intuitiva para redactar y compartir tus conocimientos. Con esta función, puedes difundir fácilmente tus ideas y beneficiar a toda la comunidad."),
        "default_articles_articles_first_subtitle":
            MessageLookupByLibrary.simpleMessage("Función Clave"),
        "default_articles_articles_fourth_paragraph":
            MessageLookupByLibrary.simpleMessage(
                "Los botones para agregar elementos a tu artículo se encuentran en la parte superior de la página. Para gestionar este contenido, usa el menú en la parte inferior."),
        "default_articles_articles_fourth_subtitle":
            MessageLookupByLibrary.simpleMessage(
                "Agregar y Gestionar Contenido"),
        "default_articles_articles_second_paragraph":
            MessageLookupByLibrary.simpleMessage(
                "También puedes tomar notas, lo cual es ideal para guardar textos o cualquier otro contenido que desees conservar para más tarde. Esta función es perfecta para capturar ideas o información importante para revisar posteriormente."),
        "default_articles_articles_second_subtitle":
            MessageLookupByLibrary.simpleMessage("Toma de Notas"),
        "default_articles_articles_third_paragraph":
            MessageLookupByLibrary.simpleMessage(
                "Todas tus fuentes son accesibles a través de un menú situado en la parte inferior de la página, lo que te permite gestionar y recuperar tus referencias fácilmente."),
        "default_articles_articles_third_subtitle":
            MessageLookupByLibrary.simpleMessage("Gestión de Fuentes"),
        "default_articles_articles_title":
            MessageLookupByLibrary.simpleMessage("Artículos"),
        "greeting_afternoon": m2,
        "greeting_evening": m3,
        "greeting_morning": m4,
        "home_appbar": MessageLookupByLibrary.simpleMessage("Inicio"),
        "home_articles_card_open_hint":
            MessageLookupByLibrary.simpleMessage("Abrir este artículo"),
        "home_discover":
            MessageLookupByLibrary.simpleMessage("Descubrir minddy"),
        "home_pick_up":
            MessageLookupByLibrary.simpleMessage("Continúa donde lo dejaste"),
        "project_card_delete": MessageLookupByLibrary.simpleMessage("Eliminar"),
        "project_card_duplicate":
            MessageLookupByLibrary.simpleMessage("Duplicar"),
        "project_card_open_settings":
            MessageLookupByLibrary.simpleMessage("Modificar"),
        "projects_add_module_tooltip":
            MessageLookupByLibrary.simpleMessage("Nuevo módulo"),
        "projects_module_help_text":
            MessageLookupByLibrary.simpleMessage("Ayuda"),
        "projects_module_notes_category_note_count": m5,
        "projects_module_notes_editing_note_sub_menu_move_tooltip":
            MessageLookupByLibrary.simpleMessage("Mover"),
        "projects_module_notes_editing_note_sub_menu_save_tooltip":
            MessageLookupByLibrary.simpleMessage("Guardar nota"),
        "projects_module_notes_for_later_title":
            MessageLookupByLibrary.simpleMessage("Notas para más adelante"),
        "projects_module_notes_important_notes_title":
            MessageLookupByLibrary.simpleMessage("Notas importantes"),
        "projects_module_notes_modify_category":
            MessageLookupByLibrary.simpleMessage("Modificar"),
        "projects_module_notes_modify_category_sub_menu_title":
            MessageLookupByLibrary.simpleMessage("Editar categoría"),
        "projects_module_notes_modify_note_tooltip":
            MessageLookupByLibrary.simpleMessage("Editar esta nota"),
        "projects_module_notes_new_category_sub_menu_error_message":
            MessageLookupByLibrary.simpleMessage(
                "Por favor, nombre la categoría"),
        "projects_module_notes_new_category_sub_menu_is_private":
            MessageLookupByLibrary.simpleMessage("Categoria privada"),
        "projects_module_notes_new_category_sub_menu_is_private_tooltip":
            MessageLookupByLibrary.simpleMessage(
                "Habilitar esta opción requerirá su contraseña para abrir esta categoría."),
        "projects_module_notes_new_category_sub_menu_name_hint":
            MessageLookupByLibrary.simpleMessage(
                "Ingrese el nombre de la categoría"),
        "projects_module_notes_new_category_sub_menu_subtitle":
            MessageLookupByLibrary.simpleMessage("Nombre de categoría"),
        "projects_module_notes_new_category_sub_menu_title":
            MessageLookupByLibrary.simpleMessage("Nueva categoría"),
        "projects_module_notes_new_category_tooltip":
            MessageLookupByLibrary.simpleMessage("Nueva categoría"),
        "projects_module_notes_new_note_tooltip":
            MessageLookupByLibrary.simpleMessage("Nueva nota"),
        "projects_module_notes_private_notes_title":
            MessageLookupByLibrary.simpleMessage("Notas Privadas"),
        "projects_module_notes_project_notes_title":
            MessageLookupByLibrary.simpleMessage("Notas del proyecto"),
        "projects_module_notes_title":
            MessageLookupByLibrary.simpleMessage("Notas"),
        "projects_module_spreadsheet_data_type_date":
            MessageLookupByLibrary.simpleMessage("Fecha"),
        "projects_module_spreadsheet_data_type_email":
            MessageLookupByLibrary.simpleMessage("Correo electrónico"),
        "projects_module_spreadsheet_data_type_number":
            MessageLookupByLibrary.simpleMessage("Número"),
        "projects_module_spreadsheet_data_type_phone_number":
            MessageLookupByLibrary.simpleMessage("Número de teléfono"),
        "projects_module_spreadsheet_data_type_selection":
            MessageLookupByLibrary.simpleMessage("Selección"),
        "projects_module_spreadsheet_data_type_text":
            MessageLookupByLibrary.simpleMessage("Texto"),
        "projects_module_spreadsheet_data_type_url":
            MessageLookupByLibrary.simpleMessage("URL"),
        "projects_module_spreadsheet_delete_column":
            MessageLookupByLibrary.simpleMessage("Eliminar esta columna"),
        "projects_module_spreadsheet_delete_row":
            MessageLookupByLibrary.simpleMessage("Eliminar esta fila"),
        "projects_module_spreadsheet_new_column":
            MessageLookupByLibrary.simpleMessage("Nueva columna"),
        "projects_module_spreadsheet_new_row":
            MessageLookupByLibrary.simpleMessage("Nueva fila"),
        "projects_module_spreadsheet_number_operation_average":
            MessageLookupByLibrary.simpleMessage("Promedio"),
        "projects_module_spreadsheet_number_operation_interval":
            MessageLookupByLibrary.simpleMessage("Intervalo"),
        "projects_module_spreadsheet_number_operation_maximum":
            MessageLookupByLibrary.simpleMessage("Máximo"),
        "projects_module_spreadsheet_number_operation_median":
            MessageLookupByLibrary.simpleMessage("Mediana"),
        "projects_module_spreadsheet_number_operation_minimum":
            MessageLookupByLibrary.simpleMessage("Mínimo"),
        "projects_module_spreadsheet_number_operation_none":
            MessageLookupByLibrary.simpleMessage("Ninguno"),
        "projects_module_spreadsheet_number_operation_standard_deviation":
            MessageLookupByLibrary.simpleMessage("Desviación estándar"),
        "projects_module_spreadsheet_number_operation_sum":
            MessageLookupByLibrary.simpleMessage("Suma"),
        "projects_module_spreadsheet_title":
            MessageLookupByLibrary.simpleMessage("Hoja de cálculo"),
        "projects_module_spreadsheet_value_unnamed":
            MessageLookupByLibrary.simpleMessage("Sin nombre"),
        "projects_module_tasks_add_task_tooltip":
            MessageLookupByLibrary.simpleMessage("Agregar una nueva tarea"),
        "projects_module_tasks_completed": m6,
        "projects_module_tasks_task_add_subtask_tooltip":
            MessageLookupByLibrary.simpleMessage("Agregar una subtarea"),
        "projects_module_tasks_task_title_hint":
            MessageLookupByLibrary.simpleMessage("Título"),
        "projects_module_tasks_title":
            MessageLookupByLibrary.simpleMessage("Tareas"),
        "projects_next_page_shortcut_tooltip":
            MessageLookupByLibrary.simpleMessage("Página siguiente ctrl + ⭢"),
        "projects_next_page_shortcut_tooltip_mac":
            MessageLookupByLibrary.simpleMessage("Página siguiente ⌘ + ⭢"),
        "projects_previous_page_shortcut_tooltip":
            MessageLookupByLibrary.simpleMessage("Página anterior ctrl + ⭠"),
        "projects_previous_page_shortcut_tooltip_mac":
            MessageLookupByLibrary.simpleMessage("Página anterior ⌘ + ⭠"),
        "projects_save_project_button_tooltip":
            MessageLookupByLibrary.simpleMessage("Guardar"),
        "projetcs_module_spreadsheet_open_website": m7,
        "settings_accessibility_title":
            MessageLookupByLibrary.simpleMessage("Accesibilidad"),
        "settings_account_title":
            MessageLookupByLibrary.simpleMessage("Mi cuenta"),
        "settings_date_format": MessageLookupByLibrary.simpleMessage(
            "Prefiero el formato de fecha MM/dd"),
        "settings_date_format_subtitle":
            MessageLookupByLibrary.simpleMessage("Formato de fecha"),
        "settings_date_format_tooltip": m8,
        "settings_language_subtitle":
            MessageLookupByLibrary.simpleMessage("Idioma"),
        "settings_need_to_quit_project_to_change_language":
            MessageLookupByLibrary.simpleMessage(
                "Para cambiar el idioma, regrese a inicio"),
        "settings_need_to_quit_project_to_change_theme":
            MessageLookupByLibrary.simpleMessage(
                "Para cambiar la configuración del tema, regrese a inicio"),
        "settings_personalize_black_and_white_title":
            MessageLookupByLibrary.simpleMessage("Modo blanco y negro"),
        "settings_personalize_title":
            MessageLookupByLibrary.simpleMessage("Personalizar"),
        "settings_project_delete_button":
            MessageLookupByLibrary.simpleMessage("Eliminar este proyecto"),
        "settings_project_delete_subtitle":
            MessageLookupByLibrary.simpleMessage("Eliminar"),
        "settings_project_rename_button":
            MessageLookupByLibrary.simpleMessage("Renombrar"),
        "settings_project_rename_subtitle":
            MessageLookupByLibrary.simpleMessage("Renombrar"),
        "settings_reset_button":
            MessageLookupByLibrary.simpleMessage("Restablecer ajustes"),
        "settings_reset_subtitle":
            MessageLookupByLibrary.simpleMessage("Restablecer"),
        "settings_security_title":
            MessageLookupByLibrary.simpleMessage("Seguridad"),
        "settings_theme_subtitle": MessageLookupByLibrary.simpleMessage("Tema"),
        "settings_title": MessageLookupByLibrary.simpleMessage("Ajustes"),
        "settings_username_subtitle":
            MessageLookupByLibrary.simpleMessage("Nombre"),
        "settings_using_dark_mode":
            MessageLookupByLibrary.simpleMessage("Modo oscuro"),
        "settings_using_light_mode":
            MessageLookupByLibrary.simpleMessage("Modo claro"),
        "settings_using_system_theme":
            MessageLookupByLibrary.simpleMessage("Tema del sistema"),
        "snackbar_articles_saved": MessageLookupByLibrary.simpleMessage(
            "Este artículo ha sido guardado"),
        "snackbar_articles_unsaved": MessageLookupByLibrary.simpleMessage(
            "Este artículo ya no está guardado"),
        "snackbar_cancel_button":
            MessageLookupByLibrary.simpleMessage("Cerrar"),
        "snackbar_delete_button":
            MessageLookupByLibrary.simpleMessage("Eliminar"),
        "snackbar_delete_element_text": m9,
        "snackbar_reset_button":
            MessageLookupByLibrary.simpleMessage("Restablecer"),
        "snackbar_reset_text":
            MessageLookupByLibrary.simpleMessage("¿Restablecer los ajustes?"),
        "snackbar_restart_button":
            MessageLookupByLibrary.simpleMessage("Cerrar la app"),
        "snackbar_restart_needed_text": MessageLookupByLibrary.simpleMessage(
            "Debes reiniciar la aplicación para aplicar los cambios"),
        "snackbar_welcome_back_button":
            MessageLookupByLibrary.simpleMessage("Gracias"),
        "snackbar_welcome_back_text": m10,
        "submenu_artilces_image_description_button":
            MessageLookupByLibrary.simpleMessage("Validar"),
        "submenu_artilces_image_description_hint":
            MessageLookupByLibrary.simpleMessage("Describe la imagen..."),
        "submenu_artilces_image_description_subtitle":
            MessageLookupByLibrary.simpleMessage("Descripción de la imagen"),
        "submenu_artilces_image_description_title":
            MessageLookupByLibrary.simpleMessage("Descripción"),
        "submenu_new_project_button":
            MessageLookupByLibrary.simpleMessage("Crear"),
        "submenu_new_project_errorMessage":
            MessageLookupByLibrary.simpleMessage(
                "Por favor, proporciona un nombre para el proyecto"),
        "submenu_new_project_hint": MessageLookupByLibrary.simpleMessage(
            "Introduce el nombre del proyecto..."),
        "submenu_new_project_subtitle":
            MessageLookupByLibrary.simpleMessage("Nombre del proyecto"),
        "submenu_new_project_title":
            MessageLookupByLibrary.simpleMessage("Nuevo proyecto"),
        "submenu_unlock_content_title":
            MessageLookupByLibrary.simpleMessage("Desbloquear"),
        "submenu_unlock_error_message_error_login":
            MessageLookupByLibrary.simpleMessage(
                "No se puede verificar la contraseña."),
        "submenu_unlock_error_message_incorrect_password":
            MessageLookupByLibrary.simpleMessage("Contraseña incorrecta"),
        "submenu_unlock_error_message_please_enter_password":
            MessageLookupByLibrary.simpleMessage(
                "Por favor ingresa tu contraseña"),
        "submenu_unlock_hide_mnemonic": MessageLookupByLibrary.simpleMessage(
            "Ocultar la frase de recordatorio de contraseña"),
        "submenu_unlock_show_mnemonic": MessageLookupByLibrary.simpleMessage(
            "Mostrar la frase de recordatorio de contraseña"),
        "submenu_unlock_subtitle_text":
            MessageLookupByLibrary.simpleMessage("Introduce tu contraseña"),
        "submenu_welcome_password_mnemonic_sentence_hint":
            MessageLookupByLibrary.simpleMessage(
                "Introduce tu frase de recordatorio de contraseña"),
        "submenu_welcome_password_mnemonic_sentence_instructs":
            MessageLookupByLibrary.simpleMessage(
                "Esta función te ayuda a recordar tu contraseña si la olvidas. No se recomienda introducir tu contraseña directamente; por favor, proporciona una pista en su lugar."),
        "submenu_welcome_password_mnemonic_sentence_subtitle":
            MessageLookupByLibrary.simpleMessage(
                "Añadir una frase de recordatorio de contraseña"),
        "submenu_welcome_password_mnemonic_sentence_title":
            MessageLookupByLibrary.simpleMessage(
                "Frase de recordatorio de contraseña"),
        "system_files_copy_text":
            MessageLookupByLibrary.simpleMessage("Copiar"),
        "tool_pomodoro_break_duration": MessageLookupByLibrary.simpleMessage(
            "Duración de la sesión de descanso"),
        "tool_pomodoro_break_session":
            MessageLookupByLibrary.simpleMessage("Romper"),
        "tool_pomodoro_focus_timer":
            MessageLookupByLibrary.simpleMessage("Temporizador de enfoque"),
        "tool_pomodoro_repetition_count":
            MessageLookupByLibrary.simpleMessage("Número de repeticiones"),
        "tool_pomodoro_start_button":
            MessageLookupByLibrary.simpleMessage("Iniciar"),
        "tool_pomodoro_stop_button":
            MessageLookupByLibrary.simpleMessage("Detener"),
        "tool_pomodoro_work_duration": MessageLookupByLibrary.simpleMessage(
            "Duración de la sesión de trabajo"),
        "tool_pomodoro_work_session":
            MessageLookupByLibrary.simpleMessage("Trabajo"),
        "welcome_appbar": MessageLookupByLibrary.simpleMessage("Bienvenido"),
        "welcome_because": MessageLookupByLibrary.simpleMessage(
            "Para personalizar tu experiencia"),
        "welcome_before_creating": MessageLookupByLibrary.simpleMessage(
            "Para empezar, por favor introduce tu nombre"),
        "welcome_enter_name":
            MessageLookupByLibrary.simpleMessage("Introduce tu nombre"),
        "welcome_error_save_username": MessageLookupByLibrary.simpleMessage(
            "Se produjo un error al guardar tu nombre"),
        "welcome_first_name_too_long": MessageLookupByLibrary.simpleMessage(
            "El nombre no puede tener más de 25 letras."),
        "welcome_next_page_semantic":
            MessageLookupByLibrary.simpleMessage("Siguiente página"),
        "welcome_pass_default_username":
            MessageLookupByLibrary.simpleMessage("Usuario"),
        "welcome_pass_tooltip": m11,
        "welcome_pass_username": MessageLookupByLibrary.simpleMessage("Pasar"),
        "welcome_password_creation_confirm_hint":
            MessageLookupByLibrary.simpleMessage("Confirma tu contraseña"),
        "welcome_password_creation_description":
            MessageLookupByLibrary.simpleMessage(
                "Para mantener tus datos seguros"),
        "welcome_password_creation_error_must_provide":
            MessageLookupByLibrary.simpleMessage(
                "Por favor, cree una contraseña"),
        "welcome_password_creation_error_not_match":
            MessageLookupByLibrary.simpleMessage(
                "Las contraseñas no coinciden"),
        "welcome_password_creation_error_password_save":
            MessageLookupByLibrary.simpleMessage(
                "Se produjo un error al guardar su contraseña"),
        "welcome_password_creation_hide_semantic":
            MessageLookupByLibrary.simpleMessage("Ocultar contraseña"),
        "welcome_password_creation_hint":
            MessageLookupByLibrary.simpleMessage("Crea tu contraseña"),
        "welcome_password_creation_password_requirements":
            MessageLookupByLibrary.simpleMessage(
                "La contraseña debe tener al menos 8 caracteres e incluir al menos una letra mayúscula, una letra minúscula y un dígito."),
        "welcome_password_creation_remember":
            MessageLookupByLibrary.simpleMessage(
                "Agregar una pista de contraseña (opcional)"),
        "welcome_password_creation_show_semantic":
            MessageLookupByLibrary.simpleMessage("Mostrar contraseña"),
        "welcome_password_creation_title":
            MessageLookupByLibrary.simpleMessage("Ahora, crea una contraseña"),
        "welcome_should_provide":
            MessageLookupByLibrary.simpleMessage("Debes proporcionar tu nombre")
      };
}
