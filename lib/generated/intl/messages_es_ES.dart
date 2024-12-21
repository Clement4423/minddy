// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es_ES locale. All the
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
  String get localeName => 'es_ES';

  static String m0(count) =>
      "${count} imágenes encontradas. ¿Quieres importarlas?";

  static String m1(actionName) =>
      "¡No tienes ninguna nota! Haz clic en \'${actionName}\' para empezar a tomar notas.";

  static String m2(eventName, username) =>
      "${eventName} ha sido completado por ${username}";

  static String m3(username) => "Completado por ${username}";

  static String m4(username) => "Buenas tardes ${username}";

  static String m5(username) => "Buenas noches ${username}";

  static String m6(username) => "Buenos días ${username}";

  static String m7(length) =>
      "${Intl.plural(length, one: 'Input', other: 'Inputs')}";

  static String m8(length) =>
      "${Intl.plural(length, one: 'Salida', other: 'Salidas')}";

  static String m9(length) =>
      "${Intl.plural(length, one: 'Copiar nodo seleccionado (⌘ + c)', other: 'Copiar nodos seleccionados (⌘ + c)')}";

  static String m10(length) =>
      "${Intl.plural(length, one: 'Copiar nodo seleccionado (ctrl + c)', other: 'Copiar nodos seleccionados (ctrl + c)')}";

  static String m11(length) =>
      "${Intl.plural(length, one: 'Eliminar nodo seleccionado (⌘ + ⌫)', other: 'Eliminar nodos seleccionados (⌘ + ⌫)')}";

  static String m12(length) =>
      "${Intl.plural(length, one: 'Eliminar nodo seleccionado (ctrl + ⌫)', other: 'Eliminar nodos seleccionados (ctrl + ⌫)')}";

  static String m13(length) =>
      "${Intl.plural(length, one: 'Duplicar nodo seleccionado (⌘ + d)', other: 'Duplicar nodos seleccionados (⌘ + d)')}";

  static String m14(length) =>
      "${Intl.plural(length, one: 'Duplicar nodo seleccionado (ctrl + d)', other: 'Duplicar nodos seleccionados (ctrl + d)')}";

  static String m15(length) =>
      "${Intl.plural(length, one: 'Pegar nodo copiado (⌘ + v)', other: 'Pegar nodos copiados (⌘ + v)')}";

  static String m16(length) =>
      "${Intl.plural(length, one: 'Pegar nodo copiado (ctrl + v)', other: 'Pegar nodos copiados (ctrl + v)')}";

  static String m17(totalNotesCount) =>
      "${Intl.plural(totalNotesCount, zero: 'Sin notas', one: '1 nota', other: '${totalNotesCount} notas')}";

  static String m18(optionName) =>
      "Dos opciones no pueden tener el mismo nombre (${optionName})";

  static String m19(totalTasksCount, checkedTasks) =>
      "${Intl.plural(totalTasksCount, zero: 'Sin tareas', one: '${checkedTasks}/${totalTasksCount} tarea completada', other: '${checkedTasks}/${totalTasksCount} tareas completadas')}";

  static String m20(websiteName) => "Abrir ${websiteName}";

  static String m21(actualMonth, actualDay) =>
      "Esta opción pondrá el mes antes del día. Así: ${actualMonth}/${actualDay}";

  static String m22(element) => "¿Eliminar ${element}?";

  static String m23(user) => "Encantado de verte de nuevo ${user}";

  static String m24(duration) =>
      "${Intl.plural(duration, zero: 'Pomodoro - Es hora de un descanso', one: 'Pomodoro - Es hora de un descanso por ${duration} minuto', other: 'Pomodoro - Es hora de un descanso por ${duration} minutos')}";

  static String m25(duration) =>
      "La sesión de pomodoro ha terminado, has trabajado ${Intl.plural(duration, one: '1 minuto', other: '${duration} minutos')}. ¡Es hora de descansar!";

  static String m26(duration) =>
      "${Intl.plural(duration, zero: 'Pomodoro - Es hora de volver al trabajo', one: 'Pomodoro - Es hora de volver al trabajo por ${duration} minuto', other: 'Pomodoro - Es hora de volver al trabajo por ${duration} minutos')}";

  static String m27(accountSettingName) =>
      "Aún podrás ingresar tu nombre en la configuración - ${accountSettingName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "app_name": MessageLookupByLibrary.simpleMessage("minddy"),
        "app_slogan": MessageLookupByLibrary.simpleMessage("Todo sucede aquí."),
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
            "¡No hay artículos para esta categoría, importa o escribe uno!"),
        "articles_empty_menu_saved_page_text":
            MessageLookupByLibrary.simpleMessage("No se guardaron artículos."),
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
        "calendar_button_add_event_button_tooltip":
            MessageLookupByLibrary.simpleMessage("Agregar un evento"),
        "calendar_button_calendar_title":
            MessageLookupByLibrary.simpleMessage("Calendario"),
        "calendar_button_due_date_cancel_complete":
            MessageLookupByLibrary.simpleMessage("Cancelar"),
        "calendar_button_due_date_has_been_complete": m2,
        "calendar_button_event_date_today":
            MessageLookupByLibrary.simpleMessage("Hoy"),
        "calendar_button_event_date_tomorrow":
            MessageLookupByLibrary.simpleMessage("Mañana"),
        "calendar_button_event_date_yesterday":
            MessageLookupByLibrary.simpleMessage("Ayer"),
        "calendar_button_event_preview_private_event":
            MessageLookupByLibrary.simpleMessage("Este evento es privado."),
        "calendar_button_event_preview_see_button":
            MessageLookupByLibrary.simpleMessage("Ver"),
        "calendar_button_event_selection_menu_all_occurence":
            MessageLookupByLibrary.simpleMessage("Todas las ocurrencias"),
        "calendar_button_event_selection_menu_only_this_event":
            MessageLookupByLibrary.simpleMessage("Solo este evento"),
        "calendar_button_free_for_next_days":
            MessageLookupByLibrary.simpleMessage(
                "Estás libre durante los próximos 5 días."),
        "calendar_button_manage_calendar_button_tooltip":
            MessageLookupByLibrary.simpleMessage("Administrar calendarios"),
        "calendar_button_manage_calendars_sub_menu_add_calendar":
            MessageLookupByLibrary.simpleMessage("Nuevo calendario"),
        "calendar_button_manage_calendars_sub_menu_all_calendars_subtitle":
            MessageLookupByLibrary.simpleMessage("Todos los calendarios"),
        "calendar_button_manage_calendars_sub_menu_modify_calendar":
            MessageLookupByLibrary.simpleMessage("Editar calendario"),
        "calendar_button_new_calendar_calendar_subtitle_name":
            MessageLookupByLibrary.simpleMessage("Nombre"),
        "calendar_button_new_calendar_personalized_color":
            MessageLookupByLibrary.simpleMessage("Personalizado"),
        "calendar_button_new_calendar_private_calendar_explanation":
            MessageLookupByLibrary.simpleMessage(
                "Al habilitar esta opción, se requerirá la contraseña para ver los eventos en este calendario"),
        "calendar_button_new_calendar_private_calendar_title":
            MessageLookupByLibrary.simpleMessage("Calendario privado"),
        "calendar_button_new_due_date_button_title":
            MessageLookupByLibrary.simpleMessage("Fecha de vencimiento"),
        "calendar_button_new_event_button_title":
            MessageLookupByLibrary.simpleMessage("Evento"),
        "calendar_button_next_due_dates_title":
            MessageLookupByLibrary.simpleMessage("Fechas de vencimiento"),
        "calendar_button_next_events_title":
            MessageLookupByLibrary.simpleMessage("Próximos eventos"),
        "calendar_button_open_week_view_button_tooltip":
            MessageLookupByLibrary.simpleMessage("Abrir vista semanal"),
        "calendar_event_detailed_preview_completed_by": m3,
        "calendar_event_detailed_preview_not_completed_yet":
            MessageLookupByLibrary.simpleMessage("Aún no completado"),
        "calendar_main_calendar_name":
            MessageLookupByLibrary.simpleMessage("Calendario principal"),
        "calendar_modify_due_date_title": MessageLookupByLibrary.simpleMessage(
            "Modificar fecha de vencimiento"),
        "calendar_modify_event_title":
            MessageLookupByLibrary.simpleMessage("Modificar evento"),
        "calendar_new_due_date_title":
            MessageLookupByLibrary.simpleMessage("Nueva fecha de vencimiento"),
        "calendar_new_event_recurrence_select_calendar":
            MessageLookupByLibrary.simpleMessage("Selecciona un calendario"),
        "calendar_new_event_recurrence_subtitle":
            MessageLookupByLibrary.simpleMessage("Recurrencia"),
        "calendar_new_event_recurrence_type_everyday":
            MessageLookupByLibrary.simpleMessage("Todos los días"),
        "calendar_new_event_recurrence_type_everymonth":
            MessageLookupByLibrary.simpleMessage("Cada mes"),
        "calendar_new_event_recurrence_type_everyweek":
            MessageLookupByLibrary.simpleMessage("Cada semana"),
        "calendar_new_event_recurrence_type_everyyear":
            MessageLookupByLibrary.simpleMessage("Cada año"),
        "calendar_new_event_recurrence_type_never":
            MessageLookupByLibrary.simpleMessage("Nunca"),
        "calendar_new_event_title":
            MessageLookupByLibrary.simpleMessage("Nuevo evento"),
        "calendar_new_event_whole_day":
            MessageLookupByLibrary.simpleMessage("Día completo"),
        "center_menu_general": MessageLookupByLibrary.simpleMessage("General"),
        "center_menu_others": MessageLookupByLibrary.simpleMessage("Otros"),
        "custom_chart_donut_share":
            MessageLookupByLibrary.simpleMessage("Parte"),
        "custom_chart_donut_total":
            MessageLookupByLibrary.simpleMessage("Total"),
        "custom_chart_empty_content": MessageLookupByLibrary.simpleMessage(
            "Para crear un gráfico, agréguele datos"),
        "custom_chart_grid_extend_chart":
            MessageLookupByLibrary.simpleMessage("Ampliar gráfico"),
        "custom_color_picker_opacity_tooltip":
            MessageLookupByLibrary.simpleMessage("Opacidad"),
        "custom_date_picker_end": MessageLookupByLibrary.simpleMessage("Fin"),
        "custom_date_picker_include_hour":
            MessageLookupByLibrary.simpleMessage("Incluir hora"),
        "custom_date_picker_invalid_date":
            MessageLookupByLibrary.simpleMessage("Fecha no válida"),
        "custom_date_picker_select_multiples_date_title":
            MessageLookupByLibrary.simpleMessage("Seleccionar fechas"),
        "custom_date_picker_select_single_date_title":
            MessageLookupByLibrary.simpleMessage("Selecciona una fecha"),
        "custom_date_picker_start":
            MessageLookupByLibrary.simpleMessage("Inicio"),
        "default_app_colors_change_color":
            MessageLookupByLibrary.simpleMessage("Cambiar color"),
        "default_app_colors_grey": MessageLookupByLibrary.simpleMessage("Gris"),
        "default_app_colors_lavender":
            MessageLookupByLibrary.simpleMessage("Lavanda"),
        "default_app_colors_light_blue":
            MessageLookupByLibrary.simpleMessage("Azul claro"),
        "default_app_colors_light_green":
            MessageLookupByLibrary.simpleMessage("Verde claro"),
        "default_app_colors_light_pink":
            MessageLookupByLibrary.simpleMessage("Rosa claro"),
        "default_app_colors_light_purple":
            MessageLookupByLibrary.simpleMessage("Púrpura claro"),
        "default_app_colors_mint_green":
            MessageLookupByLibrary.simpleMessage("Verde menta"),
        "default_app_colors_peach":
            MessageLookupByLibrary.simpleMessage("Melocotón"),
        "default_app_colors_soft_red":
            MessageLookupByLibrary.simpleMessage("Rojo suave"),
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
        "greeting_afternoon": m4,
        "greeting_evening": m5,
        "greeting_morning": m6,
        "home_appbar": MessageLookupByLibrary.simpleMessage("Inicio"),
        "home_articles_card_open_hint":
            MessageLookupByLibrary.simpleMessage("Abrir este artículo"),
        "home_discover":
            MessageLookupByLibrary.simpleMessage("Descubrir minddy"),
        "home_pick_up":
            MessageLookupByLibrary.simpleMessage("Continúa donde lo dejaste"),
        "node_editor_add_sub_menu_add_button":
            MessageLookupByLibrary.simpleMessage("Agregar"),
        "node_editor_add_sub_menu_inputs_subtitle": m7,
        "node_editor_add_sub_menu_no_nodes_found":
            MessageLookupByLibrary.simpleMessage("No se encontraron nodos."),
        "node_editor_add_sub_menu_none_input_output":
            MessageLookupByLibrary.simpleMessage("Ninguno"),
        "node_editor_add_sub_menu_note": MessageLookupByLibrary.simpleMessage(
            "Nota: Las entradas y salidas pueden variar dependiendo de las opciones elegidas para el nodo"),
        "node_editor_add_sub_menu_outputs_subtitle": m8,
        "node_editor_add_sub_menu_types":
            MessageLookupByLibrary.simpleMessage("Tipos"),
        "node_editor_view_bottom_toolbar_copy_tooltip_mac": m9,
        "node_editor_view_bottom_toolbar_copy_tooltip_windows": m10,
        "node_editor_view_bottom_toolbar_delete_tooltip_mac": m11,
        "node_editor_view_bottom_toolbar_delete_tooltip_windows": m12,
        "node_editor_view_bottom_toolbar_duplicate_tooltip_mac": m13,
        "node_editor_view_bottom_toolbar_duplicate_tooltip_windows": m14,
        "node_editor_view_bottom_toolbar_paste_tooltip_mac": m15,
        "node_editor_view_bottom_toolbar_paste_tooltip_windows": m16,
        "node_editor_view_bottom_toolbar_redo_tooltip_mac":
            MessageLookupByLibrary.simpleMessage("Rehacer (⇧ + ⌘ + z)"),
        "node_editor_view_bottom_toolbar_redo_tooltip_windows":
            MessageLookupByLibrary.simpleMessage("Rehacer (⇧ + ctrl + z)"),
        "node_editor_view_bottom_toolbar_undo_tooltip_mac":
            MessageLookupByLibrary.simpleMessage("Deshacer (⌘ + z)"),
        "node_editor_view_bottom_toolbar_undo_tooltip_windows":
            MessageLookupByLibrary.simpleMessage("Deshacer (ctrl + z)"),
        "node_editor_view_close_node_panel_tooltip":
            MessageLookupByLibrary.simpleMessage("Cerrar panel de nodos"),
        "node_editor_view_close_side_panel_tooltip":
            MessageLookupByLibrary.simpleMessage("Cerrar panel lateral"),
        "node_editor_view_new_node_tooltip":
            MessageLookupByLibrary.simpleMessage("Nuevo nodo"),
        "node_editor_view_open_node_panel_tooltip":
            MessageLookupByLibrary.simpleMessage("Abrir panel de nodos"),
        "node_editor_view_open_side_panel_tooltip":
            MessageLookupByLibrary.simpleMessage("Abrir panel lateral"),
        "node_editor_view_side_panel_node_trees_add_button_tooltip":
            MessageLookupByLibrary.simpleMessage("Nuevo árbol"),
        "node_editor_view_side_panel_node_trees_title":
            MessageLookupByLibrary.simpleMessage("Árboles de nodos"),
        "node_editor_view_side_panel_variables_add_button_tooltip":
            MessageLookupByLibrary.simpleMessage("Nueva variable"),
        "node_editor_view_side_panel_variables_title":
            MessageLookupByLibrary.simpleMessage("Variables"),
        "node_editor_view_side_panel_variables_variable_type_any":
            MessageLookupByLibrary.simpleMessage("No definido"),
        "node_editor_view_side_panel_variables_variable_type_boolean":
            MessageLookupByLibrary.simpleMessage("Booleano"),
        "node_editor_view_side_panel_variables_variable_type_color":
            MessageLookupByLibrary.simpleMessage("Color"),
        "node_editor_view_side_panel_variables_variable_type_list":
            MessageLookupByLibrary.simpleMessage("Lista"),
        "node_editor_view_side_panel_variables_variable_type_number":
            MessageLookupByLibrary.simpleMessage("Número"),
        "node_editor_view_side_panel_variables_variable_type_text":
            MessageLookupByLibrary.simpleMessage("Texto"),
        "node_widgets_boolean_node_description":
            MessageLookupByLibrary.simpleMessage(
                "Realiza operaciones con valores booleanos."),
        "node_widgets_boolean_node_options_and":
            MessageLookupByLibrary.simpleMessage("Y"),
        "node_widgets_boolean_node_options_equal":
            MessageLookupByLibrary.simpleMessage("Igual"),
        "node_widgets_boolean_node_options_imply":
            MessageLookupByLibrary.simpleMessage("Implicar"),
        "node_widgets_boolean_node_options_not":
            MessageLookupByLibrary.simpleMessage("No"),
        "node_widgets_boolean_node_options_notAnd":
            MessageLookupByLibrary.simpleMessage("No Y"),
        "node_widgets_boolean_node_options_notEqual":
            MessageLookupByLibrary.simpleMessage("No Igual"),
        "node_widgets_boolean_node_options_notOr":
            MessageLookupByLibrary.simpleMessage("No O"),
        "node_widgets_boolean_node_options_or":
            MessageLookupByLibrary.simpleMessage("O"),
        "node_widgets_boolean_node_options_subtract":
            MessageLookupByLibrary.simpleMessage("Restar"),
        "node_widgets_boolean_node_title":
            MessageLookupByLibrary.simpleMessage("Operaciones lógicas"),
        "node_widgets_category_logic":
            MessageLookupByLibrary.simpleMessage("Lógica"),
        "node_widgets_category_math":
            MessageLookupByLibrary.simpleMessage("Matemáticas"),
        "node_widgets_category_variable":
            MessageLookupByLibrary.simpleMessage("Variables"),
        "node_widgets_comparison_node_description":
            MessageLookupByLibrary.simpleMessage(
                "Realiza una comparación entre números."),
        "node_widgets_comparison_node_options_equal":
            MessageLookupByLibrary.simpleMessage("Igual a"),
        "node_widgets_comparison_node_options_greatherThan":
            MessageLookupByLibrary.simpleMessage("Mayor que"),
        "node_widgets_comparison_node_options_greatherThanOrEqual":
            MessageLookupByLibrary.simpleMessage("Mayor o igual que"),
        "node_widgets_comparison_node_options_lessThan":
            MessageLookupByLibrary.simpleMessage("Menor que"),
        "node_widgets_comparison_node_options_lessThanOrEqual":
            MessageLookupByLibrary.simpleMessage("Menor o igual que"),
        "node_widgets_comparison_node_title":
            MessageLookupByLibrary.simpleMessage("Comparación"),
        "node_widgets_conversion_node_decsription":
            MessageLookupByLibrary.simpleMessage(
                "Convertir un valor a otro tipo"),
        "node_widgets_conversion_node_title":
            MessageLookupByLibrary.simpleMessage("Conversión"),
        "node_widgets_end_text": MessageLookupByLibrary.simpleMessage("Fin"),
        "node_widgets_get_variable_node_description":
            MessageLookupByLibrary.simpleMessage(
                "Obtiene el valor de una variable."),
        "node_widgets_get_variable_node_title":
            MessageLookupByLibrary.simpleMessage("Obtener variable"),
        "node_widgets_length_text":
            MessageLookupByLibrary.simpleMessage("Longitud"),
        "node_widgets_math_node_description":
            MessageLookupByLibrary.simpleMessage(
                "Realiza cálculos con números."),
        "node_widgets_math_node_options_abs":
            MessageLookupByLibrary.simpleMessage("Valor absoluto"),
        "node_widgets_math_node_options_acos":
            MessageLookupByLibrary.simpleMessage("Arco coseno"),
        "node_widgets_math_node_options_acosh":
            MessageLookupByLibrary.simpleMessage("Arco cosh"),
        "node_widgets_math_node_options_addition":
            MessageLookupByLibrary.simpleMessage("Suma"),
        "node_widgets_math_node_options_asin":
            MessageLookupByLibrary.simpleMessage("Arco seno"),
        "node_widgets_math_node_options_asinh":
            MessageLookupByLibrary.simpleMessage("Arco sinh"),
        "node_widgets_math_node_options_atan":
            MessageLookupByLibrary.simpleMessage("Arco tangente"),
        "node_widgets_math_node_options_atanh":
            MessageLookupByLibrary.simpleMessage("Arco tanh"),
        "node_widgets_math_node_options_ceil":
            MessageLookupByLibrary.simpleMessage("Techo"),
        "node_widgets_math_node_options_cos":
            MessageLookupByLibrary.simpleMessage("Coseno"),
        "node_widgets_math_node_options_cosh":
            MessageLookupByLibrary.simpleMessage("Cosh"),
        "node_widgets_math_node_options_division":
            MessageLookupByLibrary.simpleMessage("División"),
        "node_widgets_math_node_options_floor":
            MessageLookupByLibrary.simpleMessage("Piso"),
        "node_widgets_math_node_options_ln":
            MessageLookupByLibrary.simpleMessage("Logaritmo natural"),
        "node_widgets_math_node_options_log10":
            MessageLookupByLibrary.simpleMessage("Logaritmo en base 10"),
        "node_widgets_math_node_options_max":
            MessageLookupByLibrary.simpleMessage("Máximo"),
        "node_widgets_math_node_options_min":
            MessageLookupByLibrary.simpleMessage("Mínimo"),
        "node_widgets_math_node_options_multiplication":
            MessageLookupByLibrary.simpleMessage("Multiplicación"),
        "node_widgets_math_node_options_power":
            MessageLookupByLibrary.simpleMessage("Potencia"),
        "node_widgets_math_node_options_round":
            MessageLookupByLibrary.simpleMessage("Redondear"),
        "node_widgets_math_node_options_sign":
            MessageLookupByLibrary.simpleMessage("Signo"),
        "node_widgets_math_node_options_sin":
            MessageLookupByLibrary.simpleMessage("Seno"),
        "node_widgets_math_node_options_sinh":
            MessageLookupByLibrary.simpleMessage("Sinh"),
        "node_widgets_math_node_options_squareRoot":
            MessageLookupByLibrary.simpleMessage("Raíz cuadrada"),
        "node_widgets_math_node_options_substraction":
            MessageLookupByLibrary.simpleMessage("Resta"),
        "node_widgets_math_node_options_tan":
            MessageLookupByLibrary.simpleMessage("Tangente"),
        "node_widgets_math_node_options_tanh":
            MessageLookupByLibrary.simpleMessage("Tanh"),
        "node_widgets_math_node_options_truncate":
            MessageLookupByLibrary.simpleMessage("Truncar"),
        "node_widgets_math_node_title":
            MessageLookupByLibrary.simpleMessage("Cálculos"),
        "node_widgets_random_number_node_description":
            MessageLookupByLibrary.simpleMessage(
                "Genera un número aleatorio entre un mínimo y un máximo (0 y 1 por defecto)."),
        "node_widgets_random_number_node_title":
            MessageLookupByLibrary.simpleMessage("Número aleatorio"),
        "node_widgets_result_text":
            MessageLookupByLibrary.simpleMessage("Resultado"),
        "node_widgets_select_variable_node_text":
            MessageLookupByLibrary.simpleMessage("Seleccione una variable"),
        "node_widgets_start_text":
            MessageLookupByLibrary.simpleMessage("Inicio"),
        "node_widgets_text_operation_node_decsription":
            MessageLookupByLibrary.simpleMessage(
                "Realiza operaciones en texto"),
        "node_widgets_text_operation_node_options_contains":
            MessageLookupByLibrary.simpleMessage("Contiene"),
        "node_widgets_text_operation_node_options_cut":
            MessageLookupByLibrary.simpleMessage("Cortar"),
        "node_widgets_text_operation_node_options_join":
            MessageLookupByLibrary.simpleMessage("Fusionar"),
        "node_widgets_text_operation_node_options_pad_left":
            MessageLookupByLibrary.simpleMessage("Rellenar a la izquierda"),
        "node_widgets_text_operation_node_options_pad_right":
            MessageLookupByLibrary.simpleMessage("Rellenar a la derecha"),
        "node_widgets_text_operation_node_options_trim":
            MessageLookupByLibrary.simpleMessage(
                "Eliminar el espacio en blanco"),
        "node_widgets_text_operation_node_options_trim_left":
            MessageLookupByLibrary.simpleMessage(
                "Eliminar el espacio en blanco"),
        "node_widgets_text_operation_node_options_trim_right":
            MessageLookupByLibrary.simpleMessage(
                "Elimina el espacio en blanco a la derecha"),
        "node_widgets_text_operation_node_title":
            MessageLookupByLibrary.simpleMessage("Operaciones de texto"),
        "node_widgets_text_text": MessageLookupByLibrary.simpleMessage("Texto"),
        "node_widgets_treshold_text":
            MessageLookupByLibrary.simpleMessage("Límite"),
        "node_widgets_value_text":
            MessageLookupByLibrary.simpleMessage("Valor"),
        "project_card_delete": MessageLookupByLibrary.simpleMessage("Eliminar"),
        "project_card_duplicate":
            MessageLookupByLibrary.simpleMessage("Duplicar"),
        "project_card_open_settings":
            MessageLookupByLibrary.simpleMessage("Modificar"),
        "projects_add_module_tooltip":
            MessageLookupByLibrary.simpleMessage("Nuevo módulo"),
        "projects_module_help_text":
            MessageLookupByLibrary.simpleMessage("Ayuda"),
        "projects_module_notes_category_note_count": m17,
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
        "projects_module_spreadsheet_chart_chart_column_plural":
            MessageLookupByLibrary.simpleMessage("Columnas"),
        "projects_module_spreadsheet_chart_chart_column_single":
            MessageLookupByLibrary.simpleMessage("Columna"),
        "projects_module_spreadsheet_chart_chart_select_column":
            MessageLookupByLibrary.simpleMessage("Seleccione una columna"),
        "projects_module_spreadsheet_chart_chart_type_bar":
            MessageLookupByLibrary.simpleMessage("Barra"),
        "projects_module_spreadsheet_chart_chart_type_bar_grouped":
            MessageLookupByLibrary.simpleMessage("Barras agrupadas"),
        "projects_module_spreadsheet_chart_chart_type_bar_simple":
            MessageLookupByLibrary.simpleMessage("Barras simples"),
        "projects_module_spreadsheet_chart_chart_type_bar_stacked":
            MessageLookupByLibrary.simpleMessage("Barras apiladas"),
        "projects_module_spreadsheet_chart_chart_type_donut":
            MessageLookupByLibrary.simpleMessage("Donut"),
        "projects_module_spreadsheet_chart_chart_type_subtitle":
            MessageLookupByLibrary.simpleMessage("Tipo de gráfico"),
        "projects_module_spreadsheet_chart_new_column":
            MessageLookupByLibrary.simpleMessage("Agregar una columna"),
        "projects_module_spreadsheet_chart_new_tab":
            MessageLookupByLibrary.simpleMessage("Nueva pestaña"),
        "projects_module_spreadsheet_chart_show_chart":
            MessageLookupByLibrary.simpleMessage("Mostrar gráficos"),
        "projects_module_spreadsheet_chart_show_table":
            MessageLookupByLibrary.simpleMessage("Mostrar tabla"),
        "projects_module_spreadsheet_data_choose_column_type_tooltip":
            MessageLookupByLibrary.simpleMessage("Elija un tipo de columna"),
        "projects_module_spreadsheet_data_column_type":
            MessageLookupByLibrary.simpleMessage("Tipo de columna"),
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
        "projects_module_spreadsheet_date_from_text":
            MessageLookupByLibrary.simpleMessage("De"),
        "projects_module_spreadsheet_date_single_tooltip":
            MessageLookupByLibrary.simpleMessage("Fecha única"),
        "projects_module_spreadsheet_date_start_end_tooltip":
            MessageLookupByLibrary.simpleMessage(
                "Agregar una fecha de finalización"),
        "projects_module_spreadsheet_date_to_text":
            MessageLookupByLibrary.simpleMessage("Para"),
        "projects_module_spreadsheet_delete_column":
            MessageLookupByLibrary.simpleMessage("Eliminar esta columna"),
        "projects_module_spreadsheet_delete_row":
            MessageLookupByLibrary.simpleMessage("Eliminar esta fila"),
        "projects_module_spreadsheet_extend_cell_tooltip":
            MessageLookupByLibrary.simpleMessage("Extender esta celda"),
        "projects_module_spreadsheet_manage_columns_sub_menu_subtitle":
            MessageLookupByLibrary.simpleMessage("Todas las columnas"),
        "projects_module_spreadsheet_manage_columns_sub_menu_title":
            MessageLookupByLibrary.simpleMessage("Organizar columnas"),
        "projects_module_spreadsheet_manage_rows_sub_menu_subtitle":
            MessageLookupByLibrary.simpleMessage("Todas las filas"),
        "projects_module_spreadsheet_manage_rows_sub_menu_title":
            MessageLookupByLibrary.simpleMessage("Organizar filas"),
        "projects_module_spreadsheet_new_column":
            MessageLookupByLibrary.simpleMessage("Nueva columna"),
        "projects_module_spreadsheet_new_row":
            MessageLookupByLibrary.simpleMessage("Nueva fila"),
        "projects_module_spreadsheet_number_operation_average":
            MessageLookupByLibrary.simpleMessage("Promedio"),
        "projects_module_spreadsheet_number_operation_average_example":
            MessageLookupByLibrary.simpleMessage("(10 + 50 + 100) / 3"),
        "projects_module_spreadsheet_number_operation_average_message":
            MessageLookupByLibrary.simpleMessage(
                "Calcula el promedio dividiendo la suma de todos los valores por el número de valores. Esto ayuda a encontrar el valor central de los datos."),
        "projects_module_spreadsheet_number_operation_calculate":
            MessageLookupByLibrary.simpleMessage("Calcular"),
        "projects_module_spreadsheet_number_operation_interval":
            MessageLookupByLibrary.simpleMessage("Intervalo"),
        "projects_module_spreadsheet_number_operation_interval_example":
            MessageLookupByLibrary.simpleMessage("(10, 50, 100) = 90"),
        "projects_module_spreadsheet_number_operation_interval_message":
            MessageLookupByLibrary.simpleMessage(
                "Calcula el rango restando el valor más pequeño del valor más grande en la columna. Esto muestra la distribución de valores."),
        "projects_module_spreadsheet_number_operation_maximum":
            MessageLookupByLibrary.simpleMessage("Máximo"),
        "projects_module_spreadsheet_number_operation_maximum_example":
            MessageLookupByLibrary.simpleMessage("(10, 50, 100) = 100"),
        "projects_module_spreadsheet_number_operation_maximum_message":
            MessageLookupByLibrary.simpleMessage(
                "Encuentra el valor más alto en la columna. Útil para identificar el número más grande."),
        "projects_module_spreadsheet_number_operation_median":
            MessageLookupByLibrary.simpleMessage("Mediana"),
        "projects_module_spreadsheet_number_operation_median_example":
            MessageLookupByLibrary.simpleMessage("(10, 50, 100) = 50"),
        "projects_module_spreadsheet_number_operation_median_message":
            MessageLookupByLibrary.simpleMessage(
                "Encuentra el valor central cuando se ordenan los valores de las columnas. Útil para identificar el valor central."),
        "projects_module_spreadsheet_number_operation_minimum":
            MessageLookupByLibrary.simpleMessage("Mínimo"),
        "projects_module_spreadsheet_number_operation_minimum_example":
            MessageLookupByLibrary.simpleMessage("(10, 50, 100) = 10"),
        "projects_module_spreadsheet_number_operation_minimum_message":
            MessageLookupByLibrary.simpleMessage(
                "Encuentra el valor más bajo en la columna. Esto ayuda a identificar el número más pequeño."),
        "projects_module_spreadsheet_number_operation_none":
            MessageLookupByLibrary.simpleMessage("Ninguno"),
        "projects_module_spreadsheet_number_operation_standardDeviation_example":
            MessageLookupByLibrary.simpleMessage(
                "√[((10-53.33)² + (50-53.33)² + (100-53.33)²) / 3]"),
        "projects_module_spreadsheet_number_operation_standardDeviation_message":
            MessageLookupByLibrary.simpleMessage(
                "Calcula la desviación estándar para medir cuánto varían los valores de la media. Aquí, 53,33 es el promedio de los valores 10, 50 y 100."),
        "projects_module_spreadsheet_number_operation_standard_deviation":
            MessageLookupByLibrary.simpleMessage("Desviación estándar"),
        "projects_module_spreadsheet_number_operation_sum":
            MessageLookupByLibrary.simpleMessage("Suma"),
        "projects_module_spreadsheet_number_operation_sum_example":
            MessageLookupByLibrary.simpleMessage("10 + 50 + 100"),
        "projects_module_spreadsheet_number_operation_sum_message":
            MessageLookupByLibrary.simpleMessage(
                "Suma todos los valores en la columna para obtener el total. Útil para resumir datos."),
        "projects_module_spreadsheet_selection_cell_add_an_option":
            MessageLookupByLibrary.simpleMessage("Agregar una opción"),
        "projects_module_spreadsheet_selection_cell_add_options":
            MessageLookupByLibrary.simpleMessage("Agregar opciones"),
        "projects_module_spreadsheet_selection_cell_all_options":
            MessageLookupByLibrary.simpleMessage("Todas las opciones"),
        "projects_module_spreadsheet_selection_cell_finished":
            MessageLookupByLibrary.simpleMessage("Terminado"),
        "projects_module_spreadsheet_selection_cell_modify_options":
            MessageLookupByLibrary.simpleMessage("Modificar opciones"),
        "projects_module_spreadsheet_selection_cell_name_option_hint":
            MessageLookupByLibrary.simpleMessage("Nombre esta opción..."),
        "projects_module_spreadsheet_selection_cell_not_started":
            MessageLookupByLibrary.simpleMessage("Aún no ha comenzado"),
        "projects_module_spreadsheet_selection_cell_started":
            MessageLookupByLibrary.simpleMessage("Iniciado"),
        "projects_module_spreadsheet_selection_sub_menu_error_message_no_options":
            MessageLookupByLibrary.simpleMessage("Por favor agregue opciones"),
        "projects_module_spreadsheet_selection_sub_menu_error_message_redundant_color":
            MessageLookupByLibrary.simpleMessage(
                "Dos opciones no pueden tener el mismo color"),
        "projects_module_spreadsheet_selection_sub_menu_error_message_redundant_option_name":
            m18,
        "projects_module_spreadsheet_selection_sub_menu_error_message_unnamed_option":
            MessageLookupByLibrary.simpleMessage(
                "Por favor nombre todas las opciones"),
        "projects_module_spreadsheet_title":
            MessageLookupByLibrary.simpleMessage("Hoja de cálculo"),
        "projects_module_spreadsheet_value_unnamed":
            MessageLookupByLibrary.simpleMessage("Sin nombre"),
        "projects_module_tasks_add_task_tooltip":
            MessageLookupByLibrary.simpleMessage("Agregar una nueva tarea"),
        "projects_module_tasks_completed": m19,
        "projects_module_tasks_task_add_subtask_tooltip":
            MessageLookupByLibrary.simpleMessage("Agregar una subtarea"),
        "projects_module_tasks_task_title_hint":
            MessageLookupByLibrary.simpleMessage("Título"),
        "projects_module_tasks_title":
            MessageLookupByLibrary.simpleMessage("Tareas"),
        "projects_next_page_shortcut_tooltip":
            MessageLookupByLibrary.simpleMessage("Página siguiente (ctrl + ⭢)"),
        "projects_next_page_shortcut_tooltip_mac":
            MessageLookupByLibrary.simpleMessage("Página siguiente (⌘ + ⭢)"),
        "projects_previous_page_shortcut_tooltip":
            MessageLookupByLibrary.simpleMessage("Página anterior (ctrl + ⭠)"),
        "projects_previous_page_shortcut_tooltip_mac":
            MessageLookupByLibrary.simpleMessage("Página anterior (⌘ + ⭠)"),
        "projects_save_project_button_tooltip":
            MessageLookupByLibrary.simpleMessage("Guardar"),
        "projetcs_module_spreadsheet_open_website": m20,
        "settings_accessibility_title":
            MessageLookupByLibrary.simpleMessage("Accesibilidad"),
        "settings_account_title":
            MessageLookupByLibrary.simpleMessage("Mi cuenta"),
        "settings_date_format": MessageLookupByLibrary.simpleMessage(
            "Prefiero el formato de fecha MM/dd"),
        "settings_date_format_subtitle":
            MessageLookupByLibrary.simpleMessage("Formato de fecha"),
        "settings_date_format_tooltip": m21,
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
        "settings_project_privacy_subtitle":
            MessageLookupByLibrary.simpleMessage("Privacidad"),
        "settings_project_private_project":
            MessageLookupByLibrary.simpleMessage("Proyecto privado"),
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
        "snackbar_delete_element_text": m22,
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
        "snackbar_welcome_back_text": m23,
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
        "tool_pomodoro_break_snackbar": m24,
        "tool_pomodoro_end_session": m25,
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
        "tool_pomodoro_work_snackbar": m26,
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
        "welcome_pass_tooltip": m27,
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
