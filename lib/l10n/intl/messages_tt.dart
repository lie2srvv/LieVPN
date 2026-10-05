// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a tt locale. All the
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
  String get localeName => 'tt';

  static String m0(count, skipped) =>
      "Будет добавлено: ${count}, пропущено (уже есть): ${skipped}";

  static String m1(code) =>
      "Windows отказалась запускать LieVPNCore.exe (кринж ${code}). Политики контроля приложений, такие как Smart App Control или AppLocker, блокируют неподписанные программы; разрешите LieVPN в этой политике или отключите её и повторите попытку.";

  static String m2(name) =>
      "Приложуха два раза подряд не смогло завершить запуск. Чтобы разорвать цикл, конфиг ${name} снят с выбора, а автоматическая подкрутка пропущена. Вы можете зацепить его снова в любой момент.";

  static String m3(url) => "Создать конфиг по ссылке ${url}?";

  static String m4(count) =>
      "${Intl.plural(count, one: '${count} день назад', few: '${count} дня назад', many: '${count} дней назад', other: '${count} дня назад')}";

  static String m5(label) =>
      "Вы уверены, что хотите дропнуть выбранные элементы (${label})?";

  static String m6(label) => "Вы уверены, что хотите дропнуть «${label}»?";

  static String m7(label) => "Сведения: ${label}";

  static String m8(label) => "Пустоту отправлять — не вариант";

  static String m9(count) =>
      "${Intl.plural(count, one: '${count} запись', few: '${count} записи', many: '${count} записей', other: '${count} записи')}";

  static String m10(label) => "«${label}» уже существует";

  static String m11(name) => "${name}: уже последняя версия";

  static String m12(name) => "${name}: обновлено";

  static String m13(action) =>
      "Уже используется для «${action}». При сохранении будет перенесено сюда.";

  static String m14(modifiers) =>
      "Добавьте хотя бы одну из клавиш: ${modifiers}";

  static String m15(count) =>
      "${Intl.plural(count, one: '${count} час назад', few: '${count} часа назад', many: '${count} часов назад', other: '${count} часа назад')}";

  static String m16(count) =>
      "${Intl.plural(count, one: '${count} час', few: '${count} часа', many: '${count} часов', other: '${count} часа')}";

  static String m17(target) => "${target} — недопустимая политика";

  static String m18(proxyName) => "${proxyName} — недопустимый прокси";

  static String m19(providerName) =>
      "${providerName} — недопустимый провайдер прокси";

  static String m20(ruleSet) => "${ruleSet} — недопустимый набор правил";

  static String m21(subRule) => "${subRule} — недопустимый SUB_RULE";

  static String m22(line, message) => "Строка ${line}: ${message}";

  static String m23(appName) =>
      "1. Откройте Системные подкрутки > Конфиденциальность и безопасность\n2. Выберите Службы геолокации\n3. Найдите и отметьте ${appName} в списке\n\nПосле подкрутки вернитесь в приложуха и продолжайте работу. Спасибо за сотрудничество.";

  static String m24(label, max) => "«${label}» — не более ${max} символов";

  static String m25(size) => "Освобождено ${size}";

  static String m26(count) =>
      "${Intl.plural(count, one: '${count} минуту назад', few: '${count} минуты назад', many: '${count} минут назад', other: '${count} минуты назад')}";

  static String m27(count) =>
      "${Intl.plural(count, one: '${count} месяц назад', few: '${count} месяца назад', many: '${count} месяцев назад', other: '${count} месяца назад')}";

  static String m28(code) =>
      "Сервак запретил доступ (HTTP ${code}). Возможно, линк устарела или учётные данные неверны";

  static String m29(code) => "Сервак отклонил запрос (HTTP ${code})";

  static String m30(code) =>
      "По этому адресу ничего не найдено (HTTP ${code}). Проверьте правильность URL";

  static String m31(detail) => "Сетевой запрос не выполнен: ${detail}";

  static String m32(code) =>
      "На серваке произошла кринж (HTTP ${code}). Повторите попытку позже";

  static String m33(version) => "Доступно апдейт ${version}";

  static String m34(label) => "Пока нет: ${label}";

  static String m35(label) => "Значение «${label}» должно быть числом";

  static String m36(message) =>
      "Ядро не может разобрать этот прокси: ${message}";

  static String m37(name) =>
      "Ник ${name} уже занято другим прокси или группой прокси";

  static String m38(path) =>
      "Группы прокси ссылаются друг на друга по кругу: ${path}";

  static String m39(names) => "Эти провайдеры прокси не существуют: ${names}";

  static String m40(names) => "Эти прокси или политики не существуют: ${names}";

  static String m41(name) =>
      "${name} — встроенное ник политики, его нельзя использовать";

  static String m42(names) =>
      "Собственные группы прокси профиля ссылаются на прокси, которых больше нет среди юзерских: ${names}";

  static String m43(count) =>
      "Проблем: ${count}, применение переопределения может завершиться ошибкой";

  static String m44(label) =>
      "Значение «${label}» должно быть от 1024 до 49151";

  static String m45(label, profiles) =>
      "«${label}» всё ещё используется в юзерских группах прокси или понятиях профилей: ${profiles}. Сначала уберите его оттуда";

  static String m46(profiles, label) =>
      "В сабках профилей ${profiles} уже есть «${label}», и после переименования они будут использовать его. Выберите другое ник";

  static String m47(count) => "${count} прокси";

  static String m48(count) =>
      "${Intl.plural(count, one: '${count} понятие', few: '${count} понятия', many: '${count} правил', other: '${count} понятия')}";

  static String m49(appName) => "${appName} (Безопасный режим)";

  static String m50(count) =>
      "${Intl.plural(count, one: '${count} секунда', few: '${count} секунды', many: '${count} секунд', other: '${count} секунды')}";

  static String m51(count) => "Взято: ${count}";

  static String m52(time) => "Проверено в ${time}";

  static String m53(label) => "«${label}» — только одно значение";

  static String m54(count) => "Все сервакы доступны (${count})";

  static String m55(up, total) => "Работают ${up} из ${total}";

  static String m56(count) =>
      "${Intl.plural(count, one: '${count} день', few: '${count} дня', many: '${count} дней', other: '${count} дней')}";

  static String m57(count) =>
      "Лютейший флекс! ${count} дней подряд на кондициях!";

  static String m58(count) =>
      "Ты сегодня ещё не врубал LieVPN. Залетай до 00:00 МСК на кондициях, а то стрик в ${count} дн. сгорит к чертям!";

  static String m59(count) =>
      "Осталось жить ресов в этом месяце: ${count} из 3";

  static String m60(time) => "Сабке жить осталось жить жить ${time}";

  static String m61(label) => "Закинь нормальный валидный URL";

  static String m62(count) =>
      "${Intl.plural(count, one: '${count} год назад', few: '${count} года назад', many: '${count} лет назад', other: '${count} года назад')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Чо за прога вообще"),
    "aboutAppDesc": MessageLookupByLibrary.simpleMessage(
      "Приватный VPN для защиты данных и анонимности в сети на протоколе VLESS и Hysteria2.",
    ),
    "aboutFork": MessageLookupByLibrary.simpleMessage("Форк FlClash"),
    "aboutForkDesc": MessageLookupByLibrary.simpleMessage(
      "Открыть оригинальный репозиторий FlClash",
    ),
    "accessControl": MessageLookupByLibrary.simpleMessage(
      "Фейсконтроль приложух",
    ),
    "accessControlAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Через VPN проходят только выбранные приложухи",
    ),
    "accessControlDesc": MessageLookupByLibrary.simpleMessage(
      "Кому дать зелёный свет, кого попустить",
    ),
    "accessControlDisabledDesc": MessageLookupByLibrary.simpleMessage(
      "Контроль доступа приложений отключён",
    ),
    "accessControlNotAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Выбранные приложухи исключаются из VPN",
    ),
    "accessControlSettings": MessageLookupByLibrary.simpleMessage(
      "Подкрутки контроля доступа",
    ),
    "account": MessageLookupByLibrary.simpleMessage("Аккаунт"),
    "accountStatus": MessageLookupByLibrary.simpleMessage("СТАТУС"),
    "accountUsername": MessageLookupByLibrary.simpleMessage("ИМЯ ПОЛЬЗОВАТЕЛЯ"),
    "action": MessageLookupByLibrary.simpleMessage("Действие"),
    "actionDelayTest": MessageLookupByLibrary.simpleMessage(
      "Чекнуть все задержки",
    ),
    "actionDirectMode": MessageLookupByLibrary.simpleMessage("Прямой режим"),
    "actionGlobalMode": MessageLookupByLibrary.simpleMessage(
      "Глобальный режим",
    ),
    "actionMode": MessageLookupByLibrary.simpleMessage("Переключить режим"),
    "actionProxy": MessageLookupByLibrary.simpleMessage("Системный прокси"),
    "actionRuleMode": MessageLookupByLibrary.simpleMessage("Режим правил"),
    "actionStart": MessageLookupByLibrary.simpleMessage("Старт/Стоп"),
    "actionTun": MessageLookupByLibrary.simpleMessage("TUN"),
    "actionUpdateProfiles": MessageLookupByLibrary.simpleMessage(
      "Освежить конфиги",
    ),
    "actionView": MessageLookupByLibrary.simpleMessage("Показать/Скрыть"),
    "add": MessageLookupByLibrary.simpleMessage("Залутать новое"),
    "addCustomProxy": MessageLookupByLibrary.simpleMessage("Добавить прокси"),
    "addOverrideEntry": MessageLookupByLibrary.simpleMessage(
      "Добавить параметр",
    ),
    "addProfile": MessageLookupByLibrary.simpleMessage("Добавить новый конфиг"),
    "addProxies": MessageLookupByLibrary.simpleMessage("Добавить прокси"),
    "addProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Добавить группу прокси",
    ),
    "addProxyProviders": MessageLookupByLibrary.simpleMessage(
      "Добавить провайдеров прокси",
    ),
    "addRule": MessageLookupByLibrary.simpleMessage("Добавить понятие"),
    "addRules": MessageLookupByLibrary.simpleMessage("Прописать Базу"),
    "addRulesDesc": MessageLookupByLibrary.simpleMessage(
      "Закинуть свои понятия в темку",
    ),
    "addSsid": MessageLookupByLibrary.simpleMessage("Добавить SSID"),
    "addSubscription": MessageLookupByLibrary.simpleMessage("Добавить сабку"),
    "addWidget": MessageLookupByLibrary.simpleMessage("Добавить виджет"),
    "addedRules": MessageLookupByLibrary.simpleMessage("Добавленные понятия"),
    "additionalParameters": MessageLookupByLibrary.simpleMessage(
      "Дополнительные параметры",
    ),
    "address": MessageLookupByLibrary.simpleMessage("Адрес"),
    "addressHelp": MessageLookupByLibrary.simpleMessage("Адрес сервака WebDAV"),
    "addressTip": MessageLookupByLibrary.simpleMessage(
      "Введите корректный адрес WebDAV",
    ),
    "advancedConfig": MessageLookupByLibrary.simpleMessage(
      "Расширенная конфигурация",
    ),
    "advancedConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Разнообразные параметры конфигурации",
    ),
    "agree": MessageLookupByLibrary.simpleMessage("Даттебаё, согласен"),
    "allowBypass": MessageLookupByLibrary.simpleMessage(
      "Разрешить приложухим обходить VPN",
    ),
    "allowBypassDesc": MessageLookupByLibrary.simpleMessage(
      "При включении некоторые приложухи смогут обходить VPN",
    ),
    "allowLan": MessageLookupByLibrary.simpleMessage("Раздать вайб в локалку"),
    "allowLanDesc": MessageLookupByLibrary.simpleMessage(
      "Пустить кентов в сеть",
    ),
    "answers": MessageLookupByLibrary.simpleMessage("Ответы"),
    "app": MessageLookupByLibrary.simpleMessage("Приложуха"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage(
      "Контроль доступа приложений",
    ),
    "appIconDesign": MessageLookupByLibrary.simpleMessage(
      "Дизайн значка приложухи",
    ),
    "appendSystemDns": MessageLookupByLibrary.simpleMessage(
      "Добавлять системный DNS",
    ),
    "appendSystemDnsTip": MessageLookupByLibrary.simpleMessage(
      "Принудительно добавлять системный DNS в конфигурацию",
    ),
    "application": MessageLookupByLibrary.simpleMessage("Приложуха"),
    "applicationDesc": MessageLookupByLibrary.simpleMessage(
      "Подкрутки, связанные с приложухам",
    ),
    "authentication": MessageLookupByLibrary.simpleMessage("Аутентификация"),
    "authenticationDesc": MessageLookupByLibrary.simpleMessage(
      "Требовать учётные данные для локального порта прокси, чтобы другие приложухи не могли использовать его",
    ),
    "authenticationSystemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Не применяется, пока включена аутентификация",
    ),
    "authorize": MessageLookupByLibrary.simpleMessage("Разрешить"),
    "authorized": MessageLookupByLibrary.simpleMessage("Разрешено"),
    "auto": MessageLookupByLibrary.simpleMessage("Авто"),
    "autoCheckUpdate": MessageLookupByLibrary.simpleMessage(
      "Авто-чек новой имбы",
    ),
    "autoCheckUpdateDesc": MessageLookupByLibrary.simpleMessage(
      "На автомате проверять апдейты при запуске приложухи",
    ),
    "autoCloseConnections": MessageLookupByLibrary.simpleMessage(
      "Автозакрытие соединений",
    ),
    "autoCloseConnectionsDesc": MessageLookupByLibrary.simpleMessage(
      "На автомате закрывать соединения после смены узла",
    ),
    "autoLaunch": MessageLookupByLibrary.simpleMessage(
      "Инстинкт сигмы (Автостарт)",
    ),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Врубаться сразу при старте винды/андроида",
    ),
    "autoRun": MessageLookupByLibrary.simpleMessage("Автозапуск на суете"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage(
      "Включаться на автомате при открытии приложухи",
    ),
    "autoSetSystemDns": MessageLookupByLibrary.simpleMessage(
      "Автоподкрутка системного DNS",
    ),
    "autoUpdate": MessageLookupByLibrary.simpleMessage("Автоапдейт"),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Интервал автоапдейта",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Назад"),
    "backup": MessageLookupByLibrary.simpleMessage("Резервное копирование"),
    "backupAndRestore": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование и восстановление",
    ),
    "backupAndRestoreDesc": MessageLookupByLibrary.simpleMessage(
      "Синхронизация данных через WebDAV или файлы",
    ),
    "backupFromNewerVersion": MessageLookupByLibrary.simpleMessage(
      "Резервная копия создана более новой версией приложухи. Обновите приложуха перед восстановлением",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage(
      "Резервная копия создана",
    ),
    "basicConfig": MessageLookupByLibrary.simpleMessage("Базовая конфигурация"),
    "basicConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Глобальное изменение базовой конфигурации",
    ),
    "basicInfo": MessageLookupByLibrary.simpleMessage("Основная инфа"),
    "basicStrategy": MessageLookupByLibrary.simpleMessage("Базовые политики"),
    "batchAdd": MessageLookupByLibrary.simpleMessage("Массовое добавление"),
    "batchListInputTip": MessageLookupByLibrary.simpleMessage(
      "По одному значению на строку или через запятую",
    ),
    "batchMapInputTip": MessageLookupByLibrary.simpleMessage(
      "По одной записи на строку: ключ, пробел, значение",
    ),
    "batchPreviewTip": m0,
    "batteryOptimizationDesc": MessageLookupByLibrary.simpleMessage(
      "Чтобы приложуха работало в фоне, отключите для него оптимизацию батареи. Нажмите, чтобы перейти к подкруткам.",
    ),
    "batteryOptimizationStatusTip": MessageLookupByLibrary.simpleMessage(
      "Из-за системных ограничений во время работы невозможно корректно получить статус оптимизации батареи",
    ),
    "be": MessageLookupByLibrary.simpleMessage("Беларуская"),
    "behavior": MessageLookupByLibrary.simpleMessage("Поведение"),
    "bind": MessageLookupByLibrary.simpleMessage("Привязать"),
    "blacklistMode": MessageLookupByLibrary.simpleMessage(
      "Режим чёрного списка",
    ),
    "blockConnection": MessageLookupByLibrary.simpleMessage(
      "Заблокировать соединение",
    ),
    "buyInTelegram": MessageLookupByLibrary.simpleMessage(
      "Залутать сабку в TG (@liesubbot)",
    ),
    "bypassDomain": MessageLookupByLibrary.simpleMessage(
      "Фильтр нормисов (Bypass)",
    ),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Сайты, которые идут мимо темки",
    ),
    "cache": MessageLookupByLibrary.simpleMessage("Кэш"),
    "cacheAlgorithm": MessageLookupByLibrary.simpleMessage("Алгоритм кэша"),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "Кэш повреждён. Стереть его?",
    ),
    "cacheMaxSize": MessageLookupByLibrary.simpleMessage("Размер кэша"),
    "cameraPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешите доступ к камере в системных подкрутках, чтобы сканировать QR-коды, или выберите изображение QR-кода из галереи.",
    ),
    "cameraPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Требуется доступ к камере",
    ),
    "cameraUnavailable": MessageLookupByLibrary.simpleMessage(
      "Камера недоступна",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Дать заднюю"),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage("Снять выделение"),
    "change": MessageLookupByLibrary.simpleMessage("Сменить"),
    "changeProxyFailedTip": MessageLookupByLibrary.simpleMessage(
      "Не удалось переключить прокси; восстановлен предыдущий выбор",
    ),
    "changeSubscription": MessageLookupByLibrary.simpleMessage("Сменить сабку"),
    "changelogBreaking": MessageLookupByLibrary.simpleMessage(
      "Важные изменения",
    ),
    "changelogFeatures": MessageLookupByLibrary.simpleMessage("Новые функции"),
    "changelogFixes": MessageLookupByLibrary.simpleMessage("Исправления"),
    "changelogPerformance": MessageLookupByLibrary.simpleMessage(
      "Производительность",
    ),
    "changelogReverts": MessageLookupByLibrary.simpleMessage("Откаты"),
    "checkCertificate": MessageLookupByLibrary.simpleMessage(
      "Проверять TLS-сертификаты",
    ),
    "checkCertificateDesc": MessageLookupByLibrary.simpleMessage(
      "Отклонять недоверенные сертификаты. Отключение подвергает сабки и резервные копии атаке «человек посередине»",
    ),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("Чекнуть апдейты"),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage(
      "У вас уже последняя версия",
    ),
    "checkUpdateStatus": MessageLookupByLibrary.simpleMessage(
      "Чекнуть статус сабки",
    ),
    "checkUpdates": MessageLookupByLibrary.simpleMessage("Чекнуть апдейты"),
    "checkUpdatesDesc": MessageLookupByLibrary.simpleMessage(
      "Чекнуть наличие новой версии",
    ),
    "clearData": MessageLookupByLibrary.simpleMessage("Стереть данные"),
    "clearSearch": MessageLookupByLibrary.simpleMessage("Стереть искать"),
    "clipboardExport": MessageLookupByLibrary.simpleMessage(
      "Зашерить базу в буфер",
    ),
    "clipboardImport": MessageLookupByLibrary.simpleMessage(
      "Засосать базу из буфера",
    ),
    "clipboardWriteFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось сспионерить в буфер обмена. Возможно, выделение слишком велико",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Закрыть тему"),
    "closeConnections": MessageLookupByLibrary.simpleMessage(
      "Дропнуть всех чечиков",
    ),
    "color": MessageLookupByLibrary.simpleMessage("Цвет"),
    "colorSchemes": MessageLookupByLibrary.simpleMessage("Цветовые схемы"),
    "columns": MessageLookupByLibrary.simpleMessage("Столбцы"),
    "compatible": MessageLookupByLibrary.simpleMessage("Режим совместимости"),
    "configDataDetected": MessageLookupByLibrary.simpleMessage(
      "В конфигурации обнаружены данные",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Базар, подтверждаю"),
    "confirmClearAllData": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите дропнуть все данные?",
    ),
    "confirmDeleteProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите дропнуть эту группу прокси?",
    ),
    "confirmExitWindow": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите закрыть тему тему текущее окно?",
    ),
    "confirmForceCrashCore": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите принудительно завершить ядро со сбоем?",
    ),
    "confirmOverwriteTip": MessageLookupByLibrary.simpleMessage(
      "После подтверждения существующие данные будут перезаписаны",
    ),
    "connected": MessageLookupByLibrary.simpleMessage(
      "В сети! Вайб имба, магнул всех",
    ),
    "connecting": MessageLookupByLibrary.simpleMessage(
      "Подрубаем тягу... Ща могну",
    ),
    "connection": MessageLookupByLibrary.simpleMessage("Соединение"),
    "connections": MessageLookupByLibrary.simpleMessage("Коннекты"),
    "connectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Сходка активных чечиков и связей",
    ),
    "connectivity": MessageLookupByLibrary.simpleMessage("Коннект: "),
    "content": MessageLookupByLibrary.simpleMessage("Содержимое"),
    "contentNotEmpty": MessageLookupByLibrary.simpleMessage(
      "Содержимое не может быть пустым",
    ),
    "contentScheme": MessageLookupByLibrary.simpleMessage("Контентная"),
    "controlGlobalAddedRules": MessageLookupByLibrary.simpleMessage(
      "Управление глобальными добавленными понятиями",
    ),
    "copy": MessageLookupByLibrary.simpleMessage("Спионерить (скопировать)"),
    "copyEnvVar": MessageLookupByLibrary.simpleMessage(
      "Спионерить переменные окружения",
    ),
    "copyLink": MessageLookupByLibrary.simpleMessage("Спионерить ссылку"),
    "copySuccess": MessageLookupByLibrary.simpleMessage(
      "Скопировано, теперь у тебя в кармане",
    ),
    "core": MessageLookupByLibrary.simpleMessage("Ядро Сигмы"),
    "coreBlockedByPolicyTip": m1,
    "coreBlockedBySmartAppControlTip": MessageLookupByLibrary.simpleMessage(
      "Smart App Control в Windows заблокировал неподписанный LieVPNCore.exe. Откройте Безопасность Windows → Управление приложухими и браузером → Параметры Smart App Control, выберите «Выкл.» и снова запустите LieVPN. Повторно подрубить Smart App Control без переустановки Windows нельзя.",
    ),
    "coreStatus": MessageLookupByLibrary.simpleMessage("Статус ядра"),
    "country": MessageLookupByLibrary.simpleMessage("Регион"),
    "crashDetected": MessageLookupByLibrary.simpleMessage("Обнаружен сбой"),
    "crashDetectedTip": m2,
    "crashTest": MessageLookupByLibrary.simpleMessage("Тест сбоя"),
    "crashlytics": MessageLookupByLibrary.simpleMessage("Аналитика сбоев"),
    "crashlyticsTip": MessageLookupByLibrary.simpleMessage(
      "При включении в случае сбоя приложухи на автомате загружаются логи сбоя без конфиденциальной информации",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Создать"),
    "createProfile": MessageLookupByLibrary.simpleMessage("Создать конфиг"),
    "createProfileFromUrlTip": m3,
    "creationTime": MessageLookupByLibrary.simpleMessage("Время создания"),
    "custom": MessageLookupByLibrary.simpleMessage("Вручную"),
    "customProxiesEmpty": MessageLookupByLibrary.simpleMessage(
      "Юзерских прокси нет, поэтому используются прокси самого профиля",
    ),
    "cut": MessageLookupByLibrary.simpleMessage("Вырезать"),
    "dark": MessageLookupByLibrary.simpleMessage("Тёмная для сигм"),
    "dashboard": MessageLookupByLibrary.simpleMessage("Главный Вайб"),
    "dashboardLieVpn": MessageLookupByLibrary.simpleMessage("Панель LieVPN"),
    "dataChangedSave": MessageLookupByLibrary.simpleMessage(
      "Обнаружены изменения данных. Засейвить их?",
    ),
    "dataCollectionContent": MessageLookupByLibrary.simpleMessage(
      "Это приложуха использует Firebase Crashlytics для сбора информации о сбоях, чтобы повысить стабильность.\nСобираемые данные включают сведения об устройстве и подробности сбоя и не содержат личных конфиденциальных данных.\nЭту функцию можно потушить в подкрутках.",
    ),
    "dataCollectionTip": MessageLookupByLibrary.simpleMessage(
      "Уведомлялка о сборе данных",
    ),
    "dataLimit": MessageLookupByLibrary.simpleMessage("ЛИМИТ ДАННЫХ"),
    "dataUsed": MessageLookupByLibrary.simpleMessage("ИСПОЛЬЗОВАНО"),
    "databaseWriteFailedTip": MessageLookupByLibrary.simpleMessage(
      "Не удалось засейвить изменение; оно отменено",
    ),
    "daysAgo": m4,
    "defaultNameserver": MessageLookupByLibrary.simpleMessage(
      "DNS-сервак по дефолту",
    ),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Используется для разрешения адресов DNS-серваков",
    ),
    "defaultText": MessageLookupByLibrary.simpleMessage("Чисто дефолт"),
    "delay": MessageLookupByLibrary.simpleMessage("Пинг / Задержка"),
    "delayTest": MessageLookupByLibrary.simpleMessage("Тест задержки"),
    "delete": MessageLookupByLibrary.simpleMessage("Попустить в утиль"),
    "deleteMultipTip": m5,
    "deleteTip": m6,
    "desc": MessageLookupByLibrary.simpleMessage(
      "Многоплатформенный прокси-клиент на основе ClashMeta: простой и удобный, с открытым исходным кодом и без рекламы.",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("Назначение"),
    "destinationGeoIP": MessageLookupByLibrary.simpleMessage(
      "GeoIP назначения",
    ),
    "destinationIPASN": MessageLookupByLibrary.simpleMessage(
      "ASN IP назначения",
    ),
    "details": m7,
    "detectionTip": MessageLookupByLibrary.simpleMessage(
      "Использует сторонний API; только для справки",
    ),
    "developerMode": MessageLookupByLibrary.simpleMessage(
      "Режим гигачада-кодера",
    ),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "Режим разработчика включён.",
    ),
    "dialerProxy": MessageLookupByLibrary.simpleMessage(
      "Прокси для подключения",
    ),
    "dialerProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Исход, через который идёт обращение к NTP-серваку",
    ),
    "direct": MessageLookupByLibrary.simpleMessage("Напрямую (DIRECT)"),
    "disableUDP": MessageLookupByLibrary.simpleMessage("Потушить UDP"),
    "disabled": MessageLookupByLibrary.simpleMessage("Офнуто"),
    "discardChanges": MessageLookupByLibrary.simpleMessage(
      "Отменить изменения?",
    ),
    "disclaimer": MessageLookupByLibrary.simpleMessage("Базовый дисклеймер"),
    "disclaimerAcceptContent": MessageLookupByLibrary.simpleMessage(
      "Устанавливая, копируя или используя Программу, вы подтверждаете, что прочитали и приняли это заявление полностью. Если вы не согласны с каким-либо его условием, немедленно прекратите расход и удалите Программу.",
    ),
    "disclaimerAcceptTitle": MessageLookupByLibrary.simpleMessage(
      "Принятие условий",
    ),
    "disclaimerAnalyticsContent": MessageLookupByLibrary.simpleMessage(
      "Вместе с Firebase на автомате собирается базовая статистика использования приложухи.\n\nЧто собирается: базовые события, такие как первый запуск, открытие приложухи и длительность сеанса, апдейт приложухи; идентификатор экземпляра приложухи; модель устройства, версия ОС и язык системы; приблизительное местоположение на уровне страны или региона, определённое по IP-адресу.\n\nЦель: только оценка числа активных устройств, распределения версий и совместимости с ОС. Разработчики не используют эти данные для рекламы, не продают их и не связывают с вашими сабками или конфигурациями.",
    ),
    "disclaimerAnalyticsTitle": MessageLookupByLibrary.simpleMessage(
      "Firebase Analytics (статистика использования)",
    ),
    "disclaimerAndroidOnly": MessageLookupByLibrary.simpleMessage(
      "Только Android",
    ),
    "disclaimerChangesContent": MessageLookupByLibrary.simpleMessage(
      "Разработчики могут изменять это заявление в любом выпуске; изменения вступают в силу с момента публикации выпуска. Продолжая пользоваться Программой после апдейты, вы принимаете изменённое заявление.",
    ),
    "disclaimerChangesTitle": MessageLookupByLibrary.simpleMessage(
      "Изменения заявления",
    ),
    "disclaimerCrashlyticsContent": MessageLookupByLibrary.simpleMessage(
      "При сбое приложухи отчёт о сбое отправляется на автомате.\n\nЧто собирается: трассировка стека и месседж об ошибке, время сбоя, версия и номер сборки приложухи, производитель и модель устройства, версия Android, ориентация экрана, свободная память и место в хранилище, наличие root-доступа, а также случайный идентификатор установки, который создаётся при установке и сбрасывается при переустановке.\n\nЦель: только искать и исправление сбоев.\n\nВы можете потушить это в любой момент: «Инструменты > Общие > Аналитика сбоев».",
    ),
    "disclaimerCrashlyticsTitle": MessageLookupByLibrary.simpleMessage(
      "Firebase Crashlytics (аналитика сбоев)",
    ),
    "disclaimerDataProcessingContent": MessageLookupByLibrary.simpleMessage(
      "Эти данные обрабатываются и хранятся компанией Google от нашего имени, могут передаваться на сервакы за пределами вашей страны или региона (например, в США) и регулируются Политикой конфиденциальности Google и документацией Firebase о конфиденциальности и безопасности. Отчёты о сбоях хранятся до 90 дней; статистика хранится в соответствии с политикой хранения Firebase по дефолту.",
    ),
    "disclaimerDesc": MessageLookupByLibrary.simpleMessage(
      "Базовый минимум и роскошный максимум: смажьте мясо саслом и соблюдайте понятия",
    ),
    "disclaimerFirebasePrivacy": MessageLookupByLibrary.simpleMessage(
      "Конфиденциальность и безопасность Firebase",
    ),
    "disclaimerGooglePrivacy": MessageLookupByLibrary.simpleMessage(
      "Политика конфиденциальности Google",
    ),
    "disclaimerLiabilityContent": MessageLookupByLibrary.simpleMessage(
      "В максимальной степени, допустимой применимым законодательством, ни разработчики, ни участники проекта не несут ответственности за любой прямой, косвенный, случайный, особый, штрафной или последующий ущерб, возникший в результате использования или невозможности использования Программы, включая, помимо прочего, потерю данных, повреждение устройства, сбои сети, прерывание деятельности, упущенную выгоду или связанные с этим правовые споры, даже если они были предупреждены о возможности такого ущерба.",
    ),
    "disclaimerLiabilityTitle": MessageLookupByLibrary.simpleMessage(
      "Ограничение ответственности",
    ),
    "disclaimerLicenseContent": MessageLookupByLibrary.simpleMessage(
      "Программа распространяется с открытым исходным кодом по лицензии GPL-3.0. Вы можете свободно использовать, изменять и распространять её при соблюдении этой лицензии: производные работы также должны распространяться по GPL-3.0 с сохранением уведомлений об авторских правах.\n\nСторонние компоненты Программы, включая ядро Clash.Meta, распространяются по своим собственным лицензиям. Авторы оригинала не несут ответственности за проблемы, возникшие в изменённых или распространяемых третьими лицами версиях.",
    ),
    "disclaimerLicenseTitle": MessageLookupByLibrary.simpleMessage(
      "Лицензия с открытым исходным кодом",
    ),
    "disclaimerPrivacyContent": MessageLookupByLibrary.simpleMessage(
      "Программа не собирает и не отправляет адреса ваших подписок, сведения об узлах, содержимое конфигураций, посещённые сайты, записи о подключениях, содержимое трафика и пруфыы. Эти данные хранятся только на вашем устройстве, и у разработчиков нет к ним доступа.\n\nПрограмма обращается к сети только при использовании соответствующих функций, например загружает указанный вами адрес сабки при обновлении профиля или обращается к GitHub при проверке обновлений.\n\nНастольные версии (Windows, macOS, Linux) не содержат никаких сервисов статистики или отчётов о сбоях. Версия для Android использует два сервиса Google Firebase для повышения стабильности:",
    ),
    "disclaimerPrivacyTitle": MessageLookupByLibrary.simpleMessage(
      "Сбор данных и конфиденциальность",
    ),
    "disclaimerResponsibilityContent": MessageLookupByLibrary.simpleMessage(
      "Вы самостоятельно убеждаетесь, что расход Программы законно в вашей стране или регионе, и единолично несёте юридическую ответственность за все действия с ней и их последствия.\n\nСабки, узлы и конфигурации, которые вы импортируете, выбираете вы сами. Законность их источника, безопасность содержимого и надёжность сервиса — вопрос между вами и их поставщиками.",
    ),
    "disclaimerResponsibilityTitle": MessageLookupByLibrary.simpleMessage(
      "Ваша ответственность",
    ),
    "disclaimerSoftwareContent": MessageLookupByLibrary.simpleMessage(
      "Программа — это клиент сетевого прокси с открытым исходным кодом на основе ядра Clash.Meta (mihomo). Она предоставляет только локальные инструменты: управление конфигурациями, маршрутизацию по понятиям и пересылку трафика.\n\nСама Программа не предоставляет прокси-сервакы, узлы, сабки или услуги доступа к сети и не состоит в партнёрских, агентских или гарантийных отношениях с поставщиками таких услуг.",
    ),
    "disclaimerSoftwareTitle": MessageLookupByLibrary.simpleMessage(
      "Характер программы",
    ),
    "disclaimerThirdPartyContent": MessageLookupByLibrary.simpleMessage(
      "Линки на сабки, файлы конфигурации, наборы правил, скрипты, внешние ресурсы и внешние линки предоставляются третьими лицами. Разработчики не могут проверять и не проверяют их законность, точность, безопасность и доступность и не дают на них никаких гарантий.\n\nУтечка данных, финансовые потери, блокировка аккаунта или иной ущерб, вызванные сторонним контентом, урегулируются между вами и третьим лицом; разработчики не несут за это никакой ответственности.",
    ),
    "disclaimerThirdPartyTitle": MessageLookupByLibrary.simpleMessage(
      "Сторонний контент",
    ),
    "disclaimerUsageContent": MessageLookupByLibrary.simpleMessage(
      "Программа предназначена только для некоммерческого использования: обучения, обмена опытом и технических исследований. Любое коммерческое расход строго запрещено, включая, помимо прочего, платное распространение, продажу в комплекте, расход в составе коммерческого сервиса или ведение деятельности от имени Программы. Любая коммерческая деятельность не имеет отношения к Программе и её разработчикам.\n\nСтрого запрещено использовать Программу для действий, нарушающих законы вашей страны или региона, включая, помимо прочего, обход законно установленных ограничений доступа к сети, распространение незаконной информации, сетевые атаки и нарушение законных прав других лиц.",
    ),
    "disclaimerUsageTitle": MessageLookupByLibrary.simpleMessage(
      "Ограничения использования",
    ),
    "disclaimerWarrantyContent": MessageLookupByLibrary.simpleMessage(
      "Программа предоставляется «как есть» и «по мере доступности», без каких-либо явных или подразумеваемых гарантий, включая, помимо прочего, гарантии товарной пригодности, пригодности для определённой цели, ненарушения прав, бесперебойной работы, отсутствия ошибок и уязвимостей.\n\nРазработчики не гарантируют, что Программа будет соответствовать вашим потребностям или работать без сбоев и ошибок.",
    ),
    "disclaimerWarrantyTitle": MessageLookupByLibrary.simpleMessage(
      "Отсутствие гарантий",
    ),
    "disconnected": MessageLookupByLibrary.simpleMessage(
      "Не в сети. Нормис в тильте",
    ),
    "discoverNewVersion": MessageLookupByLibrary.simpleMessage(
      "Доступна свежая версия",
    ),
    "dnsDesc": MessageLookupByLibrary.simpleMessage(
      "Подкрутки, связанные с DNS",
    ),
    "dnsHijacking": MessageLookupByLibrary.simpleMessage(
      "Перехват DNS наглухо",
    ),
    "dnsMode": MessageLookupByLibrary.simpleMessage("Режим DNS"),
    "dnsQueries": MessageLookupByLibrary.simpleMessage("DNS-запросы"),
    "docked": MessageLookupByLibrary.simpleMessage("Закреплённая"),
    "domain": MessageLookupByLibrary.simpleMessage("Домен"),
    "donators": MessageLookupByLibrary.simpleMessage(
      "Топ донатеров (Гигачады)",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Дропнуть файлик"),
    "edit": MessageLookupByLibrary.simpleMessage("Подкрутить под свой вайб"),
    "editGlobalRules": MessageLookupByLibrary.simpleMessage(
      "Редактировать глобальные понятия",
    ),
    "editProxy": MessageLookupByLibrary.simpleMessage("Редактировать прокси"),
    "editProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Редактировать группу прокси",
    ),
    "editRule": MessageLookupByLibrary.simpleMessage("Редактировать понятие"),
    "editSsid": MessageLookupByLibrary.simpleMessage("Изменить SSID"),
    "editorUnavailable": MessageLookupByLibrary.simpleMessage(
      "Редактор недоступен",
    ),
    "emptyTip": m8,
    "en": MessageLookupByLibrary.simpleMessage("English"),
    "enabled": MessageLookupByLibrary.simpleMessage("Врублено"),
    "enterSubscriptionUrl": MessageLookupByLibrary.simpleMessage(
      "Закинь линк сюда",
    ),
    "entries": MessageLookupByLibrary.simpleMessage(" записей"),
    "entriesCount": m9,
    "error": MessageLookupByLibrary.simpleMessage(
      "Анлак лютый / Кринжометр зашкалил",
    ),
    "exclude": MessageLookupByLibrary.simpleMessage("Скрыть из недавних задач"),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "Скрывать приложуха из недавних задач, когда оно в фоне",
    ),
    "excludeProxyFilter": MessageLookupByLibrary.simpleMessage(
      "Фильтр исключения узлов",
    ),
    "excludeSsids": MessageLookupByLibrary.simpleMessage("Исключённые SSID"),
    "excludeSsidsDesc": MessageLookupByLibrary.simpleMessage(
      "При подключении к Wi-Fi с исключённым SSID состояние работы приложухи переключается на автомате",
    ),
    "excludeType": MessageLookupByLibrary.simpleMessage("Исключаемые типы"),
    "existsTip": m10,
    "exit": MessageLookupByLibrary.simpleMessage("Ливнуть из проги"),
    "exitFullScreen": MessageLookupByLibrary.simpleMessage(
      "Выйти из полноэкранного режима",
    ),
    "expand": MessageLookupByLibrary.simpleMessage("Распаковать"),
    "expectedStatus": MessageLookupByLibrary.simpleMessage("Ожидаемый статус"),
    "expirationDate": MessageLookupByLibrary.simpleMessage("Дедлайн кайфа"),
    "expireTime": MessageLookupByLibrary.simpleMessage("Когда сгорит"),
    "exportFile": MessageLookupByLibrary.simpleMessage("Экспорт файла"),
    "exportLogs": MessageLookupByLibrary.simpleMessage("Экспорт логов"),
    "exportSuccess": MessageLookupByLibrary.simpleMessage("Экспорт выполнен"),
    "expressiveScheme": MessageLookupByLibrary.simpleMessage("Экспрессивная"),
    "externalController": MessageLookupByLibrary.simpleMessage("Внешний руль"),
    "externalControllerDesc": MessageLookupByLibrary.simpleMessage(
      "Адрес руля Clash Core",
    ),
    "externalFetch": MessageLookupByLibrary.simpleMessage("Внешнее получение"),
    "externalLink": MessageLookupByLibrary.simpleMessage("Внешняя линк"),
    "extraLarge": MessageLookupByLibrary.simpleMessage("Очень крупный"),
    "fade": MessageLookupByLibrary.simpleMessage("Растворение"),
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Фильтр Fake-IP"),
    "fakeipFilterMode": MessageLookupByLibrary.simpleMessage(
      "Режим фильтра Fake-IP",
    ),
    "fakeipFilterModeDesc": MessageLookupByLibrary.simpleMessage(
      "blacklist исключает совпадения, whitelist — только их, rule — по понятиям",
    ),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Диапазон Fake-IP"),
    "fakeipRange6": MessageLookupByLibrary.simpleMessage(
      "Диапазон Fake-IP (IPv6)",
    ),
    "fakeipTtl": MessageLookupByLibrary.simpleMessage("TTL Fake-IP"),
    "fallback": MessageLookupByLibrary.simpleMessage("Fallback"),
    "fallbackDesc": MessageLookupByLibrary.simpleMessage(
      "Запасной зарубежный DNS",
    ),
    "fallbackFilter": MessageLookupByLibrary.simpleMessage("Фильтр fallback"),
    "fidelityScheme": MessageLookupByLibrary.simpleMessage("Точная передача"),
    "file": MessageLookupByLibrary.simpleMessage("Файл"),
    "fileDesc": MessageLookupByLibrary.simpleMessage(
      "Загрузить файл профиля напрямую",
    ),
    "fileIsUpdate": MessageLookupByLibrary.simpleMessage(
      "Файл изменён. Засейвить изменения?",
    ),
    "filter": MessageLookupByLibrary.simpleMessage("Фильтр"),
    "findProcessMode": MessageLookupByLibrary.simpleMessage("Искать процесса"),
    "findProcessModeDesc": MessageLookupByLibrary.simpleMessage(
      "При включении возможна небольшая потеря производительности",
    ),
    "floating": MessageLookupByLibrary.simpleMessage("Плавающая"),
    "followProfile": MessageLookupByLibrary.simpleMessage("Как в профиле"),
    "followSystem": MessageLookupByLibrary.simpleMessage("Как в системе"),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Шрифт интерфейса"),
    "fontSize": MessageLookupByLibrary.simpleMessage("Размер"),
    "forceRestartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите принудительно перезапустить ядро?",
    ),
    "format": MessageLookupByLibrary.simpleMessage("Формат"),
    "fruitSaladScheme": MessageLookupByLibrary.simpleMessage("Фруктовый микс"),
    "general": MessageLookupByLibrary.simpleMessage("Общие"),
    "geoAutoUpdate": MessageLookupByLibrary.simpleMessage("Автоапдейт"),
    "geoAutoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Интервал автоапдейты",
    ),
    "geoAutoUpdateIntervalTip": MessageLookupByLibrary.simpleMessage(
      "Интервал автоапдейты должен быть больше 0",
    ),
    "geoOptions": MessageLookupByLibrary.simpleMessage("Подкрутки Geo"),
    "geoResources": MessageLookupByLibrary.simpleMessage("Ресурсы Geo"),
    "geoSkipped": m11,
    "geoUpdated": m12,
    "geodataLoader": MessageLookupByLibrary.simpleMessage(
      "Geo: экономия памяти",
    ),
    "geodataLoaderDesc": MessageLookupByLibrary.simpleMessage(
      "При включении используется Geo-загрузчик с низким потреблением памяти",
    ),
    "geoipCode": MessageLookupByLibrary.simpleMessage("Код GeoIP"),
    "global": MessageLookupByLibrary.simpleMessage("Глобал (весь мир)"),
    "go": MessageLookupByLibrary.simpleMessage("Перейти"),
    "goDownload": MessageLookupByLibrary.simpleMessage("Залутать"),
    "goToConfigureScript": MessageLookupByLibrary.simpleMessage(
      "Перейти к настройке скрипта",
    ),
    "hallOfFameHeader": MessageLookupByLibrary.simpleMessage(
      "// Зал Славы — общий донат",
    ),
    "hasCacheChange": MessageLookupByLibrary.simpleMessage(
      "Кэшировать изменения?",
    ),
    "helperCorruptTip": MessageLookupByLibrary.simpleMessage(
      "Служба Helper недоступна, поэтому TUN-режим подрубить нельзя. Переустановите LieVPN.",
    ),
    "hideFromList": MessageLookupByLibrary.simpleMessage("Скрыть из списка"),
    "hideIp": MessageLookupByLibrary.simpleMessage("Скрыть IP"),
    "hidePassword": MessageLookupByLibrary.simpleMessage("Скрыть пароль"),
    "hideTimeoutProxies": MessageLookupByLibrary.simpleMessage(
      "Скрывать узлы с таймаутом",
    ),
    "hideTimeoutProxiesDesc": MessageLookupByLibrary.simpleMessage(
      "Не показывать узлы, у которых последний тест задержки завершился таймаутом",
    ),
    "host": MessageLookupByLibrary.simpleMessage("Хост"),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("Добавить записи hosts"),
    "hotkeyConflict": MessageLookupByLibrary.simpleMessage(
      "Конфликт горячих клавиш",
    ),
    "hotkeyConflictWith": m13,
    "hotkeyDesc": MessageLookupByLibrary.simpleMessage(
      "Быстрые кнопки для про-геймеров",
    ),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage("Горячие клавиши"),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "Управление приложухам с клавиатуры",
    ),
    "hotkeyNeedsModifier": m14,
    "hotkeyNotSet": MessageLookupByLibrary.simpleMessage("Не задано"),
    "hotkeyUnavailable": MessageLookupByLibrary.simpleMessage(
      "Не зарегистрировано: сочетание может быть занято другим приложухам",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("часов"),
    "hoursAgo": m15,
    "hoursCount": m16,
    "icon": MessageLookupByLibrary.simpleMessage("Значок"),
    "iconRecords": MessageLookupByLibrary.simpleMessage("История значков"),
    "iconStyle": MessageLookupByLibrary.simpleMessage("Стиль значков"),
    "iconStyleFilled": MessageLookupByLibrary.simpleMessage("С подложкой"),
    "iconStyleHidden": MessageLookupByLibrary.simpleMessage("Скрыто"),
    "iconStylePlain": MessageLookupByLibrary.simpleMessage("Без подложки"),
    "iconUrl": MessageLookupByLibrary.simpleMessage("URL значка"),
    "ignoreBatteryOptimization": MessageLookupByLibrary.simpleMessage(
      "Игнорировать оптимизацию батареи",
    ),
    "import": MessageLookupByLibrary.simpleMessage("Импорт"),
    "importFile": MessageLookupByLibrary.simpleMessage("Импорт из файла"),
    "importFromURL": MessageLookupByLibrary.simpleMessage("Импорт из URL"),
    "importUrl": MessageLookupByLibrary.simpleMessage("Импорт по URL"),
    "inbound": MessageLookupByLibrary.simpleMessage("Входящие"),
    "includeAllProxies": MessageLookupByLibrary.simpleMessage(
      "Подрубить все прокси",
    ),
    "includeAllProxiesTip": MessageLookupByLibrary.simpleMessage(
      "Подключает все прокси вне групп; ниже можно добавить дополнительные группы прокси",
    ),
    "includeAllProxyProviders": MessageLookupByLibrary.simpleMessage(
      "Подрубить всех провайдеров прокси",
    ),
    "includeAllProxyProvidersTip": MessageLookupByLibrary.simpleMessage(
      "При включении переопределяет подключённых провайдеров прокси",
    ),
    "infiniteTime": MessageLookupByLibrary.simpleMessage("Бессрочно"),
    "init": MessageLookupByLibrary.simpleMessage("Инициализация"),
    "initiator": MessageLookupByLibrary.simpleMessage("Инициатор"),
    "inputCorrectHotkey": MessageLookupByLibrary.simpleMessage(
      "Введите корректную горячую клавишу",
    ),
    "inputProxyGroupName": MessageLookupByLibrary.simpleMessage(
      "Введите название группы прокси",
    ),
    "inputRuleContent": MessageLookupByLibrary.simpleMessage(
      "Введите содержимое понятия",
    ),
    "insertSubscriptionUrl": MessageLookupByLibrary.simpleMessage(
      "Вставить линк на сабку",
    ),
    "installedAppsPermissionDeniedMessage":
        MessageLookupByLibrary.simpleMessage(
          "Разрешение на список приложений отклонено, поэтому установленные приложухи недоступны. Предоставьте его вручную в системных подкрутках.",
        ),
    "installedAppsPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "Эта система не выдаёт список установленных приложений без разрешения. Предоставьте его, чтобы настроить прокси для отдельных приложений.",
    ),
    "installedAppsPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Требуется разрешение на список приложений",
    ),
    "intelligentSelected": MessageLookupByLibrary.simpleMessage(
      "Имбовый выбор",
    ),
    "interfaceName": MessageLookupByLibrary.simpleMessage("Ник интерфейса"),
    "interfaceNameDesc": MessageLookupByLibrary.simpleMessage(
      "Сетевой интерфейс для исходящих соединений",
    ),
    "interfaceNameMode": MessageLookupByLibrary.simpleMessage(
      "Исходящий интерфейс",
    ),
    "interfaceNameModeClear": MessageLookupByLibrary.simpleMessage("Стереть"),
    "interfaceNameModeCustom": MessageLookupByLibrary.simpleMessage("Вручную"),
    "interfaceNameModeFollow": MessageLookupByLibrary.simpleMessage(
      "Как в конфигурации",
    ),
    "internet": MessageLookupByLibrary.simpleMessage("Интернет"),
    "interval": MessageLookupByLibrary.simpleMessage("Интервал"),
    "intranetIP": MessageLookupByLibrary.simpleMessage("Лок. IP"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Недопустимый файл резервной копии",
    ),
    "invalidDscpContent": MessageLookupByLibrary.simpleMessage(
      "Метка DSCP не может превышать 63",
    ),
    "invalidNetworkContent": MessageLookupByLibrary.simpleMessage(
      "Поддерживаются только tcp и udp",
    ),
    "invalidPolicy": m17,
    "invalidProfileQrcode": MessageLookupByLibrary.simpleMessage(
      "Этот QR-код не содержит ссылку на конфиг",
    ),
    "invalidProxy": m18,
    "invalidProxyProvider": m19,
    "invalidRangeContent": MessageLookupByLibrary.simpleMessage(
      "Введите числа или диапазоны, например 80 или 8000-9000, через /",
    ),
    "invalidRuleSet": m20,
    "invalidSubRule": m21,
    "ipAddress": MessageLookupByLibrary.simpleMessage("IP-адрес"),
    "ipAsn": MessageLookupByLibrary.simpleMessage("ASN"),
    "ipFlagAbuser": MessageLookupByLibrary.simpleMessage("Злоупотребления"),
    "ipFlagProxy": MessageLookupByLibrary.simpleMessage("Прокси"),
    "ipFlagTor": MessageLookupByLibrary.simpleMessage("Tor"),
    "ipFlagVpn": MessageLookupByLibrary.simpleMessage("VPN"),
    "ipFlags": MessageLookupByLibrary.simpleMessage("Метки"),
    "ipOrganization": MessageLookupByLibrary.simpleMessage("Организация"),
    "ipQualityFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось определить тип IP",
    ),
    "ipQualityGood": MessageLookupByLibrary.simpleMessage("Хороший"),
    "ipQualityLevel": MessageLookupByLibrary.simpleMessage("Уровень"),
    "ipQualityNormal": MessageLookupByLibrary.simpleMessage("Обычный"),
    "ipQualityRetry": MessageLookupByLibrary.simpleMessage("Чекнуть снова"),
    "ipQualityRisky": MessageLookupByLibrary.simpleMessage("Рискованный"),
    "ipQualitySource": MessageLookupByLibrary.simpleMessage("Источник ответа"),
    "ipQualitySources": MessageLookupByLibrary.simpleMessage("Источники"),
    "ipSourceIpMismatch": MessageLookupByLibrary.simpleMessage(
      "Другой исходящий IP",
    ),
    "ipSourceNoType": MessageLookupByLibrary.simpleMessage("Тип не определён"),
    "ipSourceRateLimited": MessageLookupByLibrary.simpleMessage(
      "Лимит запросов",
    ),
    "ipType": MessageLookupByLibrary.simpleMessage("Тип"),
    "ipTypeBusiness": MessageLookupByLibrary.simpleMessage("Бизнес"),
    "ipTypeHosting": MessageLookupByLibrary.simpleMessage("Дата-центр"),
    "ipTypeMobile": MessageLookupByLibrary.simpleMessage("Мобильная паутина"),
    "ipTypeResidential": MessageLookupByLibrary.simpleMessage("Домашний"),
    "ipcidr": MessageLookupByLibrary.simpleMessage("IP/CIDR"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage(
      "Врубить поддержку IPv6 трафика",
    ),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешить входящий IPv6",
    ),
    "ipv6Timeout": MessageLookupByLibrary.simpleMessage("Тайм-аут IPv6 (мс)"),
    "ja": MessageLookupByLibrary.simpleMessage("日本語"),
    "justNow": MessageLookupByLibrary.simpleMessage("Только что"),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "Интервал TCP keep-alive",
    ),
    "key": MessageLookupByLibrary.simpleMessage("Ключ"),
    "kk": MessageLookupByLibrary.simpleMessage("Қазақша"),
    "ko": MessageLookupByLibrary.simpleMessage("한국어"),
    "language": MessageLookupByLibrary.simpleMessage("Языковой вайб"),
    "large": MessageLookupByLibrary.simpleMessage("Крупный"),
    "lastUpdated": MessageLookupByLibrary.simpleMessage("Последнее апдейт"),
    "latestVersionInstalled": MessageLookupByLibrary.simpleMessage(
      "У вас установлена последняя версия",
    ),
    "launchInterrupted": MessageLookupByLibrary.simpleMessage(
      "Запуск не завершён",
    ),
    "launchInterruptedTip": MessageLookupByLibrary.simpleMessage(
      "В прошлый раз приложуха неожиданно завершилось во время запуска. Автоматическая подкрутка для этого запуска пропущена; вы можете запустить её вручную.",
    ),
    "layout": MessageLookupByLibrary.simpleMessage("Макет"),
    "lieVpnSettings": MessageLookupByLibrary.simpleMessage(
      "Тюнинг вайба LieVPN",
    ),
    "lieVpnSettingsDesc": MessageLookupByLibrary.simpleMessage(
      "Параметры уведомлений и персонализации",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Светлая для нормисов"),
    "lineIssueTip": m22,
    "lineWrap": MessageLookupByLibrary.simpleMessage("Перенос строк"),
    "list": MessageLookupByLibrary.simpleMessage("Список"),
    "listen": MessageLookupByLibrary.simpleMessage("Прослушивание"),
    "listenRoutingMark": MessageLookupByLibrary.simpleMessage(
      "Метка маршрутизации",
    ),
    "listenRoutingMarkDesc": MessageLookupByLibrary.simpleMessage(
      "Только Linux",
    ),
    "liveConnections": MessageLookupByLibrary.simpleMessage(
      "Активные соединения",
    ),
    "liveNotification": MessageLookupByLibrary.simpleMessage(
      "Live-уведомление (чип сигмы)",
    ),
    "liveNotificationCustomText": MessageLookupByLibrary.simpleMessage(
      "Твой кастомный текст",
    ),
    "liveNotificationCustomTextDesc": MessageLookupByLibrary.simpleMessage(
      "Напиши сюда мемчик или флекс",
    ),
    "liveNotificationDesc": MessageLookupByLibrary.simpleMessage(
      "Вывести статус в шторку и статус-бар",
    ),
    "liveNotificationType": MessageLookupByLibrary.simpleMessage(
      "Чо показывать в чипе",
    ),
    "liveNotificationTypeCustom": MessageLookupByLibrary.simpleMessage(
      "Свой мемный слоган",
    ),
    "liveNotificationTypeDesc": MessageLookupByLibrary.simpleMessage(
      "Настрой чип под свой флекс",
    ),
    "liveNotificationTypePing": MessageLookupByLibrary.simpleMessage(
      "Пинг в катке (мс)",
    ),
    "liveNotificationTypeServer": MessageLookupByLibrary.simpleMessage(
      "Сервак и флаг страны",
    ),
    "liveNotificationTypeSpeed": MessageLookupByLibrary.simpleMessage(
      "Турбо-флекс (Download + Upload)",
    ),
    "liveNotificationTypeSpeedDown": MessageLookupByLibrary.simpleMessage(
      "Скорость дропа (Download)",
    ),
    "liveNotificationTypeSpeedUp": MessageLookupByLibrary.simpleMessage(
      "Скорость флекса (Upload)",
    ),
    "liveNotificationTypeStreak": MessageLookupByLibrary.simpleMessage(
      "Огонёчек стрика",
    ),
    "liveNotificationTypeTraffic": MessageLookupByLibrary.simpleMessage(
      "Слитый трафик (гиги)",
    ),
    "liveNotificationTypeUsername": MessageLookupByLibrary.simpleMessage(
      "Погоняло сигмы",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Чекаем пруфы, погоди..."),
    "local": MessageLookupByLibrary.simpleMessage("Локально"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование данных локально",
    ),
    "localNetworkDeniedTip": MessageLookupByLibrary.simpleMessage(
      "Доступ к локальной сети запрещён: используется стек gvisor, локальная паутина недоступна.",
    ),
    "locationPermission": MessageLookupByLibrary.simpleMessage(
      "Разрешение на геолокацию",
    ),
    "locationPermissionDeniedMessage": MessageLookupByLibrary.simpleMessage(
      "Разрешение на геолокацию отклонено, поэтому невозможно получить ник текущей сети Wi-Fi. Включите разрешение на геолокацию вручную в системных подкрутках.",
    ),
    "locationPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "По требованию системы для получения имени сети Wi-Fi необходимо разрешение на геолокацию. На Android выберите «Разрешить всегда», иначе ник сети Wi-Fi нельзя получить, пока приложуха в фоне.",
    ),
    "locationPermissionGuide": m23,
    "locationPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Требуется разрешение на геолокацию",
    ),
    "log": MessageLookupByLibrary.simpleMessage("Лог"),
    "logLevel": MessageLookupByLibrary.simpleMessage("Уровень духоты логов"),
    "logcat": MessageLookupByLibrary.simpleMessage("Сбор логов на пруфы"),
    "logcatDesc": MessageLookupByLibrary.simpleMessage(
      "При отключении раздел логов будет скрыт",
    ),
    "logs": MessageLookupByLibrary.simpleMessage("Пруфы и логи"),
    "logsAndDiagnostics": MessageLookupByLibrary.simpleMessage(
      "Логи и диагностика",
    ),
    "logsDesc": MessageLookupByLibrary.simpleMessage(
      "Записи захваченных логов",
    ),
    "logsTest": MessageLookupByLibrary.simpleMessage("Тест логов"),
    "loopback": MessageLookupByLibrary.simpleMessage(
      "Инструмент разблокировки loopback",
    ),
    "loopbackDesc": MessageLookupByLibrary.simpleMessage(
      "Для снятия ограничения loopback у UWP-приложений",
    ),
    "loose": MessageLookupByLibrary.simpleMessage("Свободный"),
    "matchSourceIp": MessageLookupByLibrary.simpleMessage(
      "Сопоставлять IP источника",
    ),
    "matchTarget": MessageLookupByLibrary.simpleMessage("MATCH-TARGET"),
    "matchTargetDesc": MessageLookupByLibrary.simpleMessage(
      "Куда направляются понятия с целью MATCH-TARGET. По дефолту — цель последнего понятия MATCH этого профиля.",
    ),
    "matchTargetTitle": MessageLookupByLibrary.simpleMessage("Цель MATCH"),
    "maxFailedTimes": MessageLookupByLibrary.simpleMessage(
      "Макс. число неудач",
    ),
    "maxLengthTip": m24,
    "maximize": MessageLookupByLibrary.simpleMessage(
      "Развернуть на весь экран",
    ),
    "memoryAppResident": MessageLookupByLibrary.simpleMessage(
      "Резидентная память",
    ),
    "memoryAppShared": MessageLookupByLibrary.simpleMessage(
      "Приложуха и общая",
    ),
    "memoryCoreHeapIdle": MessageLookupByLibrary.simpleMessage(
      "Свободная куча",
    ),
    "memoryCoreHeapInuse": MessageLookupByLibrary.simpleMessage(
      "Используемая куча",
    ),
    "memoryCoreNotRunning": MessageLookupByLibrary.simpleMessage(
      "Ядро не запущено",
    ),
    "memoryCoreRuntime": MessageLookupByLibrary.simpleMessage(
      "Накладные расходы среды",
    ),
    "memoryCoreStack": MessageLookupByLibrary.simpleMessage("Стеки горутин"),
    "memoryEstimateDesc": MessageLookupByLibrary.simpleMessage(
      "Оценка по резидентной памяти процессов; может отличаться от данных системы.",
    ),
    "memoryEstimateSharedDesc": MessageLookupByLibrary.simpleMessage(
      "Ядро работает в процессе приложухи. Его доля оценивается по статистике среды выполнения, остальное относится к приложению и общей памяти.",
    ),
    "memoryInfo": MessageLookupByLibrary.simpleMessage("Память"),
    "memoryReleased": MessageLookupByLibrary.simpleMessage(
      "Память освобождена",
    ),
    "memoryReleasedSize": m25,
    "messageTest": MessageLookupByLibrary.simpleMessage("Тест сообщения"),
    "messageTestTip": MessageLookupByLibrary.simpleMessage("Это месседж."),
    "min": MessageLookupByLibrary.simpleMessage("Минимальный"),
    "minimize": MessageLookupByLibrary.simpleMessage("Свернуть в карман"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage(
      "Уйти в зазеркалье при ливнутье",
    ),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "Свернуть в трей без шума и пыли",
    ),
    "minutesAgo": m26,
    "mixedPort": MessageLookupByLibrary.simpleMessage("Микс-порт"),
    "mode": MessageLookupByLibrary.simpleMessage("Режим работы"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("Монохром"),
    "monthsAgo": m27,
    "more": MessageLookupByLibrary.simpleMessage("Ещё больше суеты"),
    "multipleValuesTip": MessageLookupByLibrary.simpleMessage(
      "Разделяйте несколько значений запятыми",
    ),
    "name": MessageLookupByLibrary.simpleMessage("Название"),
    "nameserver": MessageLookupByLibrary.simpleMessage("DNS-сервак"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Используется для разрешения доменов",
    ),
    "nameserverPolicy": MessageLookupByLibrary.simpleMessage(
      "Политика DNS-серваков",
    ),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "Задать политику DNS-серваков для доменов",
    ),
    "navigationBarStyle": MessageLookupByLibrary.simpleMessage("Нижняя панель"),
    "network": MessageLookupByLibrary.simpleMessage("Паутина"),
    "networkAccessDeniedError": m28,
    "networkBadResponseError": m29,
    "networkCancelledError": MessageLookupByLibrary.simpleMessage(
      "Запрос отменён",
    ),
    "networkConnectionError": MessageLookupByLibrary.simpleMessage(
      "Не удалось подрубиться к серваку. Проверьте коннект к сети или подкрутки прокси",
    ),
    "networkDesc": MessageLookupByLibrary.simpleMessage(
      "Подкрутки, связанные с паутинаю",
    ),
    "networkDetection": MessageLookupByLibrary.simpleMessage("Чек пинга"),
    "networkException": MessageLookupByLibrary.simpleMessage(
      "Ситаусьон! Паутина поймала кринж",
    ),
    "networkHostLookupError": MessageLookupByLibrary.simpleMessage(
      "Не удалось определить адрес сервака. Проверьте правильность URL и работу DNS",
    ),
    "networkNotFoundError": m30,
    "networkRateLimitedError": MessageLookupByLibrary.simpleMessage(
      "Слишком много запросов (HTTP 429). Подождите немного и повторите попытку",
    ),
    "networkRequestFailed": m31,
    "networkServerError": m32,
    "networkSpeed": MessageLookupByLibrary.simpleMessage("Турбо-скорость"),
    "networkTimeoutError": MessageLookupByLibrary.simpleMessage(
      "Время ожидания запроса сдулсяло. Проверьте паутина или прокси и повторите попытку",
    ),
    "networkTlsError": MessageLookupByLibrary.simpleMessage(
      "Не удалось установить защищённое соединение. Сертификат сервака может быть недействителен, или соединение перехватывается",
    ),
    "networkType": MessageLookupByLibrary.simpleMessage("Тип сети"),
    "neutralScheme": MessageLookupByLibrary.simpleMessage("Нейтральная"),
    "newVersionAvailable": m33,
    "nextMatch": MessageLookupByLibrary.simpleMessage("Следующее совпадение"),
    "no": MessageLookupByLibrary.simpleMessage("Нет"),
    "noAddedRulesYet": MessageLookupByLibrary.simpleMessage(
      "Правил пока нет. Добавьте домен или приложуха выше.",
    ),
    "noData": MessageLookupByLibrary.simpleMessage("Нет данных"),
    "noExpiration": MessageLookupByLibrary.simpleMessage("∞ Бессрочно"),
    "noHotKey": MessageLookupByLibrary.simpleMessage("Горячих клавиш пока нет"),
    "noInfo": MessageLookupByLibrary.simpleMessage("Нет информации"),
    "noLongerRemind": MessageLookupByLibrary.simpleMessage(
      "Больше не напоминать",
    ),
    "noNetwork": MessageLookupByLibrary.simpleMessage("Нет сети"),
    "noNetworkApp": MessageLookupByLibrary.simpleMessage("Приложухи без сети"),
    "noRecords": MessageLookupByLibrary.simpleMessage("Записей пока нет"),
    "noResolve": MessageLookupByLibrary.simpleMessage("Не разрешать IP"),
    "noResolveHostname": MessageLookupByLibrary.simpleMessage(
      "Не разрешать ник хоста",
    ),
    "noSearchResults": MessageLookupByLibrary.simpleMessage(
      "Ничего не найдено",
    ),
    "noSubscriptionFound": MessageLookupByLibrary.simpleMessage(
      "Сабка не добавлена",
    ),
    "nonTextProviderFile": MessageLookupByLibrary.simpleMessage(
      "Этот внешний ресурс не является текстовым файлом",
    ),
    "none": MessageLookupByLibrary.simpleMessage("Нет"),
    "notLieVpnSubscription": MessageLookupByLibrary.simpleMessage(
      "Это не LieVPN, не по масти",
    ),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "Текущую группу прокси нельзя зацепить",
    ),
    "ntpInterval": MessageLookupByLibrary.simpleMessage(
      "Интервал синхронизации (минуты)",
    ),
    "ntpStatusDesc": MessageLookupByLibrary.simpleMessage(
      "Брать время с NTP-сервака, а не из системных часов",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Конфигов нет, ты в тильте",
    ),
    "nullTip": m34,
    "numberTip": m35,
    "onDemand": MessageLookupByLibrary.simpleMessage("По условию"),
    "onDemandDesc": MessageLookupByLibrary.simpleMessage(
      "Настройте состояние работы приложухи для определённых сценариев",
    ),
    "onlyIcon": MessageLookupByLibrary.simpleMessage("Только значок"),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage(
      "Учитывать только прокси",
    ),
    "onlyStatisticsProxyDesc": MessageLookupByLibrary.simpleMessage(
      "При включении учитывается только трафик через прокси",
    ),
    "optional": MessageLookupByLibrary.simpleMessage("Необязательно"),
    "options": MessageLookupByLibrary.simpleMessage("Опции"),
    "other": MessageLookupByLibrary.simpleMessage("Всякое разное"),
    "otherContributors": MessageLookupByLibrary.simpleMessage(
      "Другие участники",
    ),
    "outboundIp": MessageLookupByLibrary.simpleMessage("Исходящий IP"),
    "outboundMode": MessageLookupByLibrary.simpleMessage("Траектория трафика"),
    "override": MessageLookupByLibrary.simpleMessage("Оверрайд / Моггинг"),
    "overrideDns": MessageLookupByLibrary.simpleMessage("Переопределить DNS"),
    "overrideDnsDesc": MessageLookupByLibrary.simpleMessage(
      "При включении подкрутки DNS профиля переопределяются",
    ),
    "overrideEntries": MessageLookupByLibrary.simpleMessage(
      "Переопределяемые параметры",
    ),
    "overrideMode": MessageLookupByLibrary.simpleMessage(
      "Режим переопределения",
    ),
    "overrideNtp": MessageLookupByLibrary.simpleMessage("Переопределить NTP"),
    "overrideScript": MessageLookupByLibrary.simpleMessage(
      "Скрипт переопределения",
    ),
    "overwriteIssueCoreRejected": m36,
    "overwriteIssueDuplicateName": m37,
    "overwriteIssueEmptyName": MessageLookupByLibrary.simpleMessage(
      "Ник не задано",
    ),
    "overwriteIssueGroupLoop": m38,
    "overwriteIssueMissingProviders": m39,
    "overwriteIssueMissingProxies": m40,
    "overwriteIssueNoProxySource": MessageLookupByLibrary.simpleMessage(
      "Не выбраны ни прокси, ни провайдеры прокси, поэтому ядро отклонит эту группу",
    ),
    "overwriteIssueReservedName": m41,
    "overwriteIssueSubscriptionGroupMissingProxies": m42,
    "overwriteIssuesSummary": m43,
    "overwriteTypeCustom": MessageLookupByLibrary.simpleMessage("Юзерский"),
    "overwriteTypeCustomDesc": MessageLookupByLibrary.simpleMessage(
      "Юзерский режим: полная подкрутка групп прокси и правил",
    ),
    "palette": MessageLookupByLibrary.simpleMessage("Палитра"),
    "password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "paste": MessageLookupByLibrary.simpleMessage("Вставить"),
    "personalAccount": MessageLookupByLibrary.simpleMessage("Кабинет гигачада"),
    "pickFromAlbum": MessageLookupByLibrary.simpleMessage(
      "Зацепить из галереи",
    ),
    "pinWindow": MessageLookupByLibrary.simpleMessage(
      "Закрепить поверх всех окон",
    ),
    "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage(
      "Привяжите WebDAV",
    ),
    "pleaseEnterScriptName": MessageLookupByLibrary.simpleMessage(
      "Введите название скрипта",
    ),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "Загрузите корректный QR-код",
    ),
    "port": MessageLookupByLibrary.simpleMessage("Порт"),
    "portConflictTip": MessageLookupByLibrary.simpleMessage(
      "Введите другой порт",
    ),
    "portTip": m44,
    "preferH3Desc": MessageLookupByLibrary.simpleMessage(
      "Предпочитать HTTP/3 для DoH",
    ),
    "prerequisites": MessageLookupByLibrary.simpleMessage(
      "Предварительные условия",
    ),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage("Нажмите клавишу"),
    "preview": MessageLookupByLibrary.simpleMessage("Предпросмотр"),
    "previousMatch": MessageLookupByLibrary.simpleMessage(
      "Предыдущее совпадение",
    ),
    "process": MessageLookupByLibrary.simpleMessage("Процесс"),
    "profile": MessageLookupByLibrary.simpleMessage("Паспорт сигмы"),
    "profileAutoUpdateIntervalInvalidValidationDesc":
        MessageLookupByLibrary.simpleMessage("Введите корректный интервал"),
    "profileAutoUpdateIntervalNullValidationDesc":
        MessageLookupByLibrary.simpleMessage("Введите интервал автоапдейты"),
    "profileHasUpdate": MessageLookupByLibrary.simpleMessage(
      "Конфиг изменён. Потушить автоапдейт?",
    ),
    "profileNameNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Введите название профиля",
    ),
    "profileUrlInvalidValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Введите корректный URL профиля",
    ),
    "profileUrlNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Введите URL профиля",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Конфиги"),
    "profilesSort": MessageLookupByLibrary.simpleMessage("Сортировка профилей"),
    "project": MessageLookupByLibrary.simpleMessage("Проект"),
    "providerInUse": m45,
    "providerRenameShadowed": m46,
    "providerSourceSubscription": MessageLookupByLibrary.simpleMessage("Сабка"),
    "providerUrlTip": MessageLookupByLibrary.simpleMessage(
      "Поддерживаются только удалённые ресурсы",
    ),
    "providers": MessageLookupByLibrary.simpleMessage("Внешние ресурсы"),
    "proxies": MessageLookupByLibrary.simpleMessage("Серваки"),
    "proxiesCount": m47,
    "proxiesEmpty": MessageLookupByLibrary.simpleMessage("Список прокси пуст"),
    "proxyChains": MessageLookupByLibrary.simpleMessage("Цепочка прокси"),
    "proxyDefinition": MessageLookupByLibrary.simpleMessage(
      "Полная конфигурация",
    ),
    "proxyDefinitionNotMap": MessageLookupByLibrary.simpleMessage(
      "Конфигурация должна быть YAML-словарём с полями name и type",
    ),
    "proxyDetectedAbnormal": MessageLookupByLibrary.simpleMessage(
      "Обнаружены отклонения в выбранных прокси",
    ),
    "proxyFilter": MessageLookupByLibrary.simpleMessage("Фильтр узлов"),
    "proxyGroup": MessageLookupByLibrary.simpleMessage("Группа прокси"),
    "proxyGroupDetectedAbnormal": MessageLookupByLibrary.simpleMessage(
      "Обнаружены отклонения в текущей группе прокси",
    ),
    "proxyGroupEmpty": MessageLookupByLibrary.simpleMessage(
      "Группа прокси пуста",
    ),
    "proxyGroupNameDuplicate": MessageLookupByLibrary.simpleMessage(
      "Название группы прокси уже используется",
    ),
    "proxyGroupNameEmpty": MessageLookupByLibrary.simpleMessage(
      "Название группы прокси не может быть пустым",
    ),
    "proxyNameserver": MessageLookupByLibrary.simpleMessage(
      "DNS-сервак для прокси",
    ),
    "proxyNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Используется для разрешения доменов прокси-узлов",
    ),
    "proxyNode": MessageLookupByLibrary.simpleMessage("Прокси-узел"),
    "proxyProviderDetectedAbnormal": MessageLookupByLibrary.simpleMessage(
      "Обнаружены отклонения в выбранных провайдерах прокси",
    ),
    "proxyProviders": MessageLookupByLibrary.simpleMessage("Провайдеры прокси"),
    "proxyProvidersEmpty": MessageLookupByLibrary.simpleMessage(
      "Список провайдеров прокси пуст",
    ),
    "proxyProvidersNotEmpty": MessageLookupByLibrary.simpleMessage(
      "Провайдеры прокси не могут быть пустыми",
    ),
    "proxyType": MessageLookupByLibrary.simpleMessage("Тип прокси"),
    "pruneCache": MessageLookupByLibrary.simpleMessage("Стереть кэш"),
    "pureBlack": MessageLookupByLibrary.simpleMessage(
      "Чернее ночи (для альтушек)",
    ),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("Чисто чёрный режим"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QR-код"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage(
      "Сканируйте QR-код, чтобы получить конфиг",
    ),
    "quickAdd": MessageLookupByLibrary.simpleMessage("Быстрое добавление"),
    "quickEdit": MessageLookupByLibrary.simpleMessage("Быстрое редактирование"),
    "quickFill": MessageLookupByLibrary.simpleMessage("Быстрое заполнение"),
    "rainbowScheme": MessageLookupByLibrary.simpleMessage("Радуга"),
    "readyToTest": MessageLookupByLibrary.simpleMessage("Готов к тестированию"),
    "recentRequests": MessageLookupByLibrary.simpleMessage("Последние запросы"),
    "recordType": MessageLookupByLibrary.simpleMessage("Тип записи"),
    "redirPort": MessageLookupByLibrary.simpleMessage("Порт Redir"),
    "redo": MessageLookupByLibrary.simpleMessage("Повторить"),
    "releaseMemory": MessageLookupByLibrary.simpleMessage("Освободить память"),
    "releaseMemoryFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось освободить память",
    ),
    "remote": MessageLookupByLibrary.simpleMessage("Удалёнка"),
    "remoteBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Резервное копирование данных в WebDAV",
    ),
    "remoteDestination": MessageLookupByLibrary.simpleMessage(
      "Удалённое назначение",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("Удалить с концами"),
    "renew": MessageLookupByLibrary.simpleMessage("Продлить кайф"),
    "renewSubscription": MessageLookupByLibrary.simpleMessage(
      "Продлить сабку и могать дальше",
    ),
    "replace": MessageLookupByLibrary.simpleMessage("Заменить"),
    "replaceAll": MessageLookupByLibrary.simpleMessage("Заменить все"),
    "request": MessageLookupByLibrary.simpleMessage("Запрос"),
    "requests": MessageLookupByLibrary.simpleMessage("Поток Яппинга"),
    "requestsAndUpdates": MessageLookupByLibrary.simpleMessage(
      "Запросы и апдейты",
    ),
    "requestsDesc": MessageLookupByLibrary.simpleMessage(
      "Просмотр последних запросов",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Дропнуть в дефолт"),
    "resetPageChangesTip": MessageLookupByLibrary.simpleMessage(
      "На этой странице есть изменения. Вы уверены, что хотите выполнить сброс?",
    ),
    "resetTip": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите выполнить сброс?",
    ),
    "resources": MessageLookupByLibrary.simpleMessage("Склад Базы"),
    "resourcesDesc": MessageLookupByLibrary.simpleMessage(
      "Сведения о внешних ресурсах",
    ),
    "respectRules": MessageLookupByLibrary.simpleMessage("Соблюдать понятия"),
    "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
      "DNS-соединения следуют понятиям; требуется настроить proxy-server-nameserver",
    ),
    "responseCode": MessageLookupByLibrary.simpleMessage("Код ответа"),
    "restart": MessageLookupByLibrary.simpleMessage("Перезапустить"),
    "restartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите перезапустить ядро?",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Восстановить"),
    "restoreAllData": MessageLookupByLibrary.simpleMessage(
      "Восстановить все данные",
    ),
    "restoreException": MessageLookupByLibrary.simpleMessage(
      "Кринж восстановления",
    ),
    "restoreFromFileDesc": MessageLookupByLibrary.simpleMessage(
      "Восстановить данные из файла",
    ),
    "restoreFromWebDAVDesc": MessageLookupByLibrary.simpleMessage(
      "Восстановить данные из WebDAV",
    ),
    "restoreOnlyConfig": MessageLookupByLibrary.simpleMessage(
      "Восстановить только конфиги",
    ),
    "restoreStrategy": MessageLookupByLibrary.simpleMessage(
      "Стратегия восстановления",
    ),
    "restoreStrategyCompatible": MessageLookupByLibrary.simpleMessage(
      "Совместимость",
    ),
    "restoreStrategyOverride": MessageLookupByLibrary.simpleMessage(
      "Перезапись",
    ),
    "restoreSuccess": MessageLookupByLibrary.simpleMessage(
      "Восстановление выполнено",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("Затащить катку заново"),
    "routeAddress": MessageLookupByLibrary.simpleMessage("Адреса маршрутов"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage(
      "Настроить прослушиваемые адреса маршрутов",
    ),
    "routeMode": MessageLookupByLibrary.simpleMessage("Режим маршрутизации"),
    "routeModeBypassPrivate": MessageLookupByLibrary.simpleMessage(
      "Обходить частные адреса",
    ),
    "routeModeConfig": MessageLookupByLibrary.simpleMessage(
      "Использовать конфигурацию",
    ),
    "ru": MessageLookupByLibrary.simpleMessage("Российский нормис"),
    "rule": MessageLookupByLibrary.simpleMessage("По понятиям (RULE)"),
    "ruleActionAndDesc": MessageLookupByLibrary.simpleMessage(
      "Логическое понятие AND",
    ),
    "ruleActionDirectBadge": MessageLookupByLibrary.simpleMessage("DIRECT"),
    "ruleActionDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить полный домен",
    ),
    "ruleActionDomainKeywordDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить ключевое слово в домене",
    ),
    "ruleActionDomainRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по регулярному выражению домена",
    ),
    "ruleActionDomainSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить суффикс домена",
    ),
    "ruleActionDomainWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставление по маске; поддерживаются только * и ?",
    ),
    "ruleActionDscpDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить метку DSCP (только для входящих tproxy UDP)",
    ),
    "ruleActionDstPortDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон портов назначения",
    ),
    "ruleActionGeoipDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить код страны IP-адреса",
    ),
    "ruleActionGeositeDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить домены из Geosite",
    ),
    "ruleActionInNameDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить ник входящего подключения",
    ),
    "ruleActionInPortDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить входящий порт",
    ),
    "ruleActionInTypeDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить тип входящего подключения",
    ),
    "ruleActionInUserDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить ник пользователя входящего подключения; несколько имён разделяются /",
    ),
    "ruleActionIpAsnDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить ASN, которой принадлежит IP",
    ),
    "ruleActionIpCidr6Desc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон IP-адресов; IP-CIDR6 — просто псевдоним",
    ),
    "ruleActionIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон IP-адресов",
    ),
    "ruleActionIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон суффиксов IP",
    ),
    "ruleActionMatchDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставляет все запросы, условия не нужны",
    ),
    "ruleActionNetworkDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить TCP или UDP",
    ),
    "ruleActionNotDesc": MessageLookupByLibrary.simpleMessage(
      "Логическое понятие NOT",
    ),
    "ruleActionOrDesc": MessageLookupByLibrary.simpleMessage(
      "Логическое понятие OR",
    ),
    "ruleActionProcessNameDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по имени процесса; на Android соответствует имени пакета",
    ),
    "ruleActionProcessNameRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по регулярному выражению имени процесса; на Android соответствует имени пакета",
    ),
    "ruleActionProcessNameWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по маске имени процесса; поддерживаются только * и ?",
    ),
    "ruleActionProcessPathDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по полному пути процесса",
    ),
    "ruleActionProcessPathRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по регулярному выражению пути процесса",
    ),
    "ruleActionProcessPathWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить по маске пути процесса; поддерживаются только * и ?",
    ),
    "ruleActionRematchNameDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить ник повторного сопоставления; несколько имён разделяются /",
    ),
    "ruleActionRuleSetDesc": MessageLookupByLibrary.simpleMessage(
      "Линк на набор правил; требуется настроить rule-providers",
    ),
    "ruleActionSrcGeoipDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить код страны IP источника",
    ),
    "ruleActionSrcIpAsnDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить ASN IP источника",
    ),
    "ruleActionSrcIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон IP-адресов источника",
    ),
    "ruleActionSrcIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон суффиксов IP источника",
    ),
    "ruleActionSrcPortDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить диапазон портов источника",
    ),
    "ruleActionSubRuleDesc": MessageLookupByLibrary.simpleMessage(
      "Переход к подправилу; обратите алярм на скобки",
    ),
    "ruleActionUidDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставить Linux USER ID",
    ),
    "ruleAddedSuccess": MessageLookupByLibrary.simpleMessage(
      "Понятие чиназес добавлено",
    ),
    "ruleAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Такое понятие уже существует",
    ),
    "ruleApp": MessageLookupByLibrary.simpleMessage("Приложуха"),
    "ruleContent": MessageLookupByLibrary.simpleMessage("Понятие"),
    "ruleDomain": MessageLookupByLibrary.simpleMessage("Домен"),
    "ruleDomainHint": MessageLookupByLibrary.simpleMessage(
      "example.com (DOMAIN-SUFFIX)",
    ),
    "ruleEmpty": MessageLookupByLibrary.simpleMessage("Понятие пусто"),
    "ruleInputEmpty": MessageLookupByLibrary.simpleMessage(
      "Поле ввода не может быть пустым",
    ),
    "ruleName": MessageLookupByLibrary.simpleMessage("Название понятия"),
    "rulePresetBittorrentDirect": MessageLookupByLibrary.simpleMessage(
      "BitTorrent напрямую",
    ),
    "rulePresetBlockDot": MessageLookupByLibrary.simpleMessage(
      "Блокировать DNS over TLS",
    ),
    "rulePresetBlockQuic": MessageLookupByLibrary.simpleMessage(
      "Блокировать QUIC",
    ),
    "rulePresetBlockStun": MessageLookupByLibrary.simpleMessage(
      "Блокировать STUN",
    ),
    "rulePresetLanDirect": MessageLookupByLibrary.simpleMessage(
      "Локальная паутина напрямую",
    ),
    "rulePresetSystemServicesDirect": MessageLookupByLibrary.simpleMessage(
      "Apple и Microsoft напрямую",
    ),
    "ruleProcessHint": MessageLookupByLibrary.simpleMessage(
      "Ник процесса или пакета (PROCESS-NAME)",
    ),
    "ruleProviders": MessageLookupByLibrary.simpleMessage("Провайдеры правил"),
    "ruleSelectAppTooltip": MessageLookupByLibrary.simpleMessage(
      "Зацепить приложуха или процесс",
    ),
    "ruleSet": MessageLookupByLibrary.simpleMessage("Набор правил"),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("Цель понятия"),
    "ruleTargetDirect": MessageLookupByLibrary.simpleMessage("DIRECT"),
    "ruleType": MessageLookupByLibrary.simpleMessage("Тип"),
    "rules": MessageLookupByLibrary.simpleMessage("Понятия (База)"),
    "rulesCount": m48,
    "runTime": MessageLookupByLibrary.simpleMessage("Время работы"),
    "safeMode": MessageLookupByLibrary.simpleMessage("Безопасный режим"),
    "safeModeAppTitle": m49,
    "save": MessageLookupByLibrary.simpleMessage("Засейвить и затащить"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Засейвить изменения?"),
    "scanQrCode": MessageLookupByLibrary.simpleMessage(
      "Счелкнуть QR подкрадулями",
    ),
    "script": MessageLookupByLibrary.simpleMessage("Скрипт"),
    "scriptModeDesc": MessageLookupByLibrary.simpleMessage(
      "Режим скрипта: использует внешние скрипты-расширения для переопределения конфигурации в один клик",
    ),
    "scrollToSelected": MessageLookupByLibrary.simpleMessage(
      "Прокрутить к выбранному",
    ),
    "search": MessageLookupByLibrary.simpleMessage("Найти нужную пикчу/движ"),
    "searchAppHint": MessageLookupByLibrary.simpleMessage(
      "Искать приложухи или процесса...",
    ),
    "seconds": MessageLookupByLibrary.simpleMessage("секунд"),
    "secondsCount": m50,
    "selectAll": MessageLookupByLibrary.simpleMessage("Выбрать вообще всё"),
    "selectAppTitle": MessageLookupByLibrary.simpleMessage(
      "Зацепить приложуха / процесс",
    ),
    "selectMatchTarget": MessageLookupByLibrary.simpleMessage(
      "Зацепить MATCH-TARGET",
    ),
    "selectProxies": MessageLookupByLibrary.simpleMessage("Зацепить прокси"),
    "selectProxyProviders": MessageLookupByLibrary.simpleMessage(
      "Зацепить провайдеров прокси",
    ),
    "selectRuleSet": MessageLookupByLibrary.simpleMessage(
      "Выберите набор правил",
    ),
    "selectSplitStrategy": MessageLookupByLibrary.simpleMessage(
      "Выберите стратегию распределения",
    ),
    "selectSubRule": MessageLookupByLibrary.simpleMessage(
      "Выберите подпонятие",
    ),
    "selected": MessageLookupByLibrary.simpleMessage("Выбран (Любимость)"),
    "selectedCountTitle": m51,
    "server": MessageLookupByLibrary.simpleMessage("Сервак"),
    "serverNotRespondingReconnecting": MessageLookupByLibrary.simpleMessage(
      "Сервак откинулся. Переподрубаем суету...",
    ),
    "serverStatus": MessageLookupByLibrary.simpleMessage("Радар Чечиков"),
    "serverStatusDesc": MessageLookupByLibrary.simpleMessage(
      "Кто тут масик, а кто тюбик",
    ),
    "serviceAvailable": MessageLookupByLibrary.simpleMessage("Доступен"),
    "serviceBlocked": MessageLookupByLibrary.simpleMessage("Заблокировано"),
    "serviceCheck": MessageLookupByLibrary.simpleMessage("Чекнуть"),
    "serviceCheckAll": MessageLookupByLibrary.simpleMessage("Чекнуть все"),
    "serviceCheckedAt": m52,
    "serviceComingSoon": MessageLookupByLibrary.simpleMessage("Скоро появится"),
    "serviceDisallowedIsp": MessageLookupByLibrary.simpleMessage(
      "Недопустимый провайдер",
    ),
    "serviceFailed": MessageLookupByLibrary.simpleMessage("Кринж проверки"),
    "serviceManage": MessageLookupByLibrary.simpleMessage(
      "Управление сервисами",
    ),
    "serviceOriginalsOnly": MessageLookupByLibrary.simpleMessage(
      "Только оригиналы",
    ),
    "servicePending": MessageLookupByLibrary.simpleMessage("Не проверено"),
    "serviceRestricted": MessageLookupByLibrary.simpleMessage(
      "Доступ ограничен",
    ),
    "serviceStatus": MessageLookupByLibrary.simpleMessage("Состояние сервисов"),
    "serviceUnavailable": MessageLookupByLibrary.simpleMessage("Недоступен"),
    "serviceUnsupportedRegion": MessageLookupByLibrary.simpleMessage(
      "Регион не поддерживается",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Тюнинг софтины"),
    "show": MessageLookupByLibrary.simpleMessage("Показать"),
    "showLess": MessageLookupByLibrary.simpleMessage(
      "Свернуть в карман в карман",
    ),
    "showMore": MessageLookupByLibrary.simpleMessage(
      "Развернуть на весь экран на весь экран",
    ),
    "showNotificationStopAction": MessageLookupByLibrary.simpleMessage(
      "Кнопка остановки в уведомлении",
    ),
    "showNotificationStopActionDesc": MessageLookupByLibrary.simpleMessage(
      "Показывать кнопку остановки в постоянном уведомлении. Отключите, если из-за неё система всегда разворачивает уведомлялка",
    ),
    "showPassword": MessageLookupByLibrary.simpleMessage("Показать пароль"),
    "shrink": MessageLookupByLibrary.simpleMessage("Компактно"),
    "sidebarBlur": MessageLookupByLibrary.simpleMessage(
      "Размытие боковой панели",
    ),
    "sidebarBlurDesc": MessageLookupByLibrary.simpleMessage(
      "Показывать сквозь боковую панель размытый рабочий стол за окном",
    ),
    "silentLaunch": MessageLookupByLibrary.simpleMessage(
      "Стелс-подкрадули (Тихий запуск)",
    ),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Запуск в стелс-режиме",
    ),
    "singleAdd": MessageLookupByLibrary.simpleMessage("По одному"),
    "singleValueTip": m53,
    "size": MessageLookupByLibrary.simpleMessage("Размерчик"),
    "slide": MessageLookupByLibrary.simpleMessage("Сдвиг"),
    "socksPort": MessageLookupByLibrary.simpleMessage("Порт SOCKS"),
    "sort": MessageLookupByLibrary.simpleMessage("Сортировка"),
    "source": MessageLookupByLibrary.simpleMessage("Источник"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("IP источника"),
    "specialProxy": MessageLookupByLibrary.simpleMessage("Специальный прокси"),
    "specialRules": MessageLookupByLibrary.simpleMessage("Специальные понятия"),
    "speedStatistics": MessageLookupByLibrary.simpleMessage(
      "Статистика скорости",
    ),
    "speedtest": MessageLookupByLibrary.simpleMessage("Замер Тяги"),
    "speedtestCompleted": MessageLookupByLibrary.simpleMessage(
      "Тест чиназес завершён",
    ),
    "speedtestDesc": MessageLookupByLibrary.simpleMessage(
      "Чекнуть ризз и замерить кондиции",
    ),
    "speedtestDisclaimer": MessageLookupByLibrary.simpleMessage(
      "Замеры через сторонние серваки, инфа не 100%, турбо-тяга может просесть или наврать на кондициях.",
    ),
    "speedtestDownload": MessageLookupByLibrary.simpleMessage(
      "Скачка (Download)",
    ),
    "speedtestError": MessageLookupByLibrary.simpleMessage("Кринж соединения"),
    "speedtestGaugeUnit": MessageLookupByLibrary.simpleMessage("МБИТ/С"),
    "speedtestNoDataError": MessageLookupByLibrary.simpleMessage(
      "Тюбик не ответил: сервак ушёл в тильт, турбо-тяга по нулям",
    ),
    "speedtestPing": MessageLookupByLibrary.simpleMessage("Пинг"),
    "speedtestRunAgain": MessageLookupByLibrary.simpleMessage(
      "Измерить ещё раз",
    ),
    "speedtestStart": MessageLookupByLibrary.simpleMessage("Запустить тест"),
    "speedtestStop": MessageLookupByLibrary.simpleMessage("Остановить"),
    "speedtestTestingDownload": MessageLookupByLibrary.simpleMessage(
      "Загрузка дропа дропа (Download)...",
    ),
    "speedtestTestingPing": MessageLookupByLibrary.simpleMessage(
      "Измерение задержки (Ping)...",
    ),
    "speedtestTestingUpload": MessageLookupByLibrary.simpleMessage(
      "Отдача (Upload)...",
    ),
    "speedtestUnitMbps": MessageLookupByLibrary.simpleMessage("Мбит/с"),
    "speedtestUnitMs": MessageLookupByLibrary.simpleMessage("мс"),
    "speedtestUpload": MessageLookupByLibrary.simpleMessage("Отдача (Upload)"),
    "splitStrategy": MessageLookupByLibrary.simpleMessage(
      "Стратегия распределения",
    ),
    "splitStrategyNotEmpty": MessageLookupByLibrary.simpleMessage(
      "Стратегия распределения не может быть пустой",
    ),
    "ssidsEmpty": MessageLookupByLibrary.simpleMessage("Список SSID пуст"),
    "stackMode": MessageLookupByLibrary.simpleMessage("Режим стека"),
    "standard": MessageLookupByLibrary.simpleMessage("Стандартный"),
    "standardModeDesc": MessageLookupByLibrary.simpleMessage(
      "Стандартный режим: переопределяет базовую конфигурацию и позволяет просто добавлять понятия",
    ),
    "start": MessageLookupByLibrary.simpleMessage("Запустить, я щас могну"),
    "startFromScratch": MessageLookupByLibrary.simpleMessage("С нуля"),
    "startVpn": MessageLookupByLibrary.simpleMessage(
      "Подрубить LieVPN (моггинг он)",
    ),
    "startupAndBackground": MessageLookupByLibrary.simpleMessage(
      "Запуск и фосвежая работа",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Статус коннекта"),
    "statusActive": MessageLookupByLibrary.simpleMessage("Активен"),
    "statusAllAvailable": m54,
    "statusAllDown": MessageLookupByLibrary.simpleMessage("Сервакы недоступны"),
    "statusAllDownDesc": MessageLookupByLibrary.simpleMessage(
      "Все мониторы сообщают об ошибке",
    ),
    "statusAllSystemsOperational": MessageLookupByLibrary.simpleMessage(
      "Все системы работают нормально",
    ),
    "statusAllSystemsOperationalDesc": MessageLookupByLibrary.simpleMessage(
      "Все сервакы в статусе «Доступен»",
    ),
    "statusCheckHistory": MessageLookupByLibrary.simpleMessage(
      "История проверок",
    ),
    "statusChecking": MessageLookupByLibrary.simpleMessage("Чек серваков..."),
    "statusDesc": MessageLookupByLibrary.simpleMessage(
      "При отключении используется системный DNS",
    ),
    "statusDown": MessageLookupByLibrary.simpleMessage("Недоступен"),
    "statusExpired": MessageLookupByLibrary.simpleMessage("Сдулсяла"),
    "statusMonitors": MessageLookupByLibrary.simpleMessage("// МОНИТОРЫ"),
    "statusNoMonitors": MessageLookupByLibrary.simpleMessage(
      "Нет данных о мониторах",
    ),
    "statusOperational": MessageLookupByLibrary.simpleMessage("Доступен"),
    "statusPartialOutages": MessageLookupByLibrary.simpleMessage(
      "Частичные проблемы",
    ),
    "statusPartialOutagesDesc": m55,
    "statusUpdated": MessageLookupByLibrary.simpleMessage("Обновлено"),
    "stop": MessageLookupByLibrary.simpleMessage("Стопэ, отдохни"),
    "stopVpn": MessageLookupByLibrary.simpleMessage(
      "Потушить LieVPN (ушел в тильт)",
    ),
    "strategy": MessageLookupByLibrary.simpleMessage("Стратегия"),
    "streakActiveToday": MessageLookupByLibrary.simpleMessage(
      "Огонёчек горит, чисто гигачад на чиле!",
    ),
    "streakDaysCount": m56,
    "streakFlameTitle": MessageLookupByLibrary.simpleMessage(
      "Огненный стрик на кондициях",
    ),
    "streakInactiveToday": MessageLookupByLibrary.simpleMessage(
      "Огонёк потух, не будь тюбиком! Вруби VPN до 00:00 МСК, чтобы зажечь!",
    ),
    "streakMilestoneCongrats": m57,
    "streakNoRestoresLeft": MessageLookupByLibrary.simpleMessage(
      "Все ресы на этот месяц профуканы (макс 3 шт).",
    ),
    "streakNotificationBody": m58,
    "streakNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "🔥 Огонёчек на грани кринжа!",
    ),
    "streakRestoreButton": MessageLookupByLibrary.simpleMessage(
      "Реснуть огонёчек",
    ),
    "streakRestoredSuccess": MessageLookupByLibrary.simpleMessage(
      "Огонёк воскрес! Красава, магнул систему!",
    ),
    "streakRestoresLeft": m59,
    "streakRuleRestore": MessageLookupByLibrary.simpleMessage(
      "• За месяц можно ровно 3 раза реснуть огонёк, если поймал тильт и забыл зайти.",
    ),
    "streakRuleStorage": MessageLookupByLibrary.simpleMessage(
      "• Стрик сейвится чисто на твоей трубке и удалится, только если снести приложуху.",
    ),
    "streakRuleTime": MessageLookupByLibrary.simpleMessage(
      "• Огонёк обновляется строго в 00:00 по МСК (12:00 AM UTC+3).",
    ),
    "streakRuleTitle": MessageLookupByLibrary.simpleMessage("База по огонёчку"),
    "style": MessageLookupByLibrary.simpleMessage("Стиль"),
    "subExpireReminder1d": MessageLookupByLibrary.simpleMessage(
      "Остался 1 день. Если вы уже продлили, то обновите сабку.",
    ),
    "subExpireReminder1h": MessageLookupByLibrary.simpleMessage(
      "Остался 1 час. Если вы уже продлили, то обновите сабку.",
    ),
    "subExpireReminder3d": MessageLookupByLibrary.simpleMessage(
      "Осталось жить жить 3 дня. Если вы уже продлили, то обновите сабку.",
    ),
    "subExpiredNotice": MessageLookupByLibrary.simpleMessage(
      "Срок действия вашей сабки истёк. Если вы уже продлили, то обновите сабку.",
    ),
    "subExpiredTitle": MessageLookupByLibrary.simpleMessage(
      "Финал сабки, анлак",
    ),
    "subExpiringTitle": MessageLookupByLibrary.simpleMessage(
      "Сабка скоро закончится",
    ),
    "subRule": MessageLookupByLibrary.simpleMessage("Подпонятие"),
    "subRuleEmpty": MessageLookupByLibrary.simpleMessage("Подпонятие пусто"),
    "subRuleNotEmpty": MessageLookupByLibrary.simpleMessage(
      "Подпонятие не может быть пустым",
    ),
    "submit": MessageLookupByLibrary.simpleMessage("Отправить"),
    "subscriptionActivating": MessageLookupByLibrary.simpleMessage(
      "Активируем сабку... Сигма мод on",
    ),
    "subscriptionExpiredDesc": MessageLookupByLibrary.simpleMessage(
      "Сабка рипнулась! Закинь шекелей тяночке-боту, чтоб снова флексить",
    ),
    "subscriptionExpiredWarning": MessageLookupByLibrary.simpleMessage(
      "Сабка сдулась, пора донатить",
    ),
    "subscriptionExpiringIn": m60,
    "subscriptionFoundInClipboard": MessageLookupByLibrary.simpleMessage(
      "Найдена сабка в буфере обмена",
    ),
    "subscriptionFromClipboardHint": MessageLookupByLibrary.simpleMessage(
      "Из буфера обмена, по ссылке или QR-коду",
    ),
    "subscriptionInactive": MessageLookupByLibrary.simpleMessage(
      "Сабка спит, ты попущен",
    ),
    "subscriptionInfo": MessageLookupByLibrary.simpleMessage("Пруфы по сабке"),
    "subscriptionInvalidOrEmpty": MessageLookupByLibrary.simpleMessage(
      "Линк битый, кринж лютый",
    ),
    "subscriptionNoChanges": MessageLookupByLibrary.simpleMessage(
      "И так всё имба, не душни",
    ),
    "subscriptionRequired": MessageLookupByLibrary.simpleMessage(
      "Без сабки ты нормис, подруби!",
    ),
    "subscriptionRequiredDesc": MessageLookupByLibrary.simpleMessage(
      "Залутай сабку у бота @liesubbot и могай интернет без тормозов",
    ),
    "subscriptionUpdated": MessageLookupByLibrary.simpleMessage(
      "Сабка свежая, чиназес!",
    ),
    "supportEmail": MessageLookupByLibrary.simpleMessage("Электронная почта"),
    "supportLieVpn": MessageLookupByLibrary.simpleMessage("Хелпа LieVPN"),
    "supportLieVpnTitle": MessageLookupByLibrary.simpleMessage(
      "Служба поддержки LieVPN",
    ),
    "supportMessengerMax": MessageLookupByLibrary.simpleMessage(
      "Мессенджер MAX",
    ),
    "supportMessengerMaxSubtitle": MessageLookupByLibrary.simpleMessage(
      "Написать в MAX",
    ),
    "supportProject": MessageLookupByLibrary.simpleMessage("Поддержать проект"),
    "suspended": MessageLookupByLibrary.simpleMessage("Приостановлено..."),
    "switchProfile": MessageLookupByLibrary.simpleMessage("Сменить конфиг"),
    "sync": MessageLookupByLibrary.simpleMessage("Синхронизация"),
    "system": MessageLookupByLibrary.simpleMessage("Система"),
    "systemApp": MessageLookupByLibrary.simpleMessage("Системные приложухи"),
    "systemProxy": MessageLookupByLibrary.simpleMessage("Системный прокси"),
    "systemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Врубить прокси на всю ОС",
    ),
    "tab": MessageLookupByLibrary.simpleMessage("Вкладки"),
    "tabAnimation": MessageLookupByLibrary.simpleMessage("Анимация вкладок"),
    "tabAnimationDesc": MessageLookupByLibrary.simpleMessage(
      "Действует только в мобильном виде",
    ),
    "tapToAuthorize": MessageLookupByLibrary.simpleMessage(
      "Нажмите, чтобы разрешить",
    ),
    "tapToInsertSubscription": MessageLookupByLibrary.simpleMessage(
      "Нажмите, чтобы влепить сабку",
    ),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage(
      "Параллельный TCP буст",
    ),
    "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage(
      "При включении разрешает параллельные TCP-подключения",
    ),
    "testInterval": MessageLookupByLibrary.simpleMessage(
      "Интервал тестирования",
    ),
    "testUrl": MessageLookupByLibrary.simpleMessage("URL чека пинга"),
    "testWhenUsed": MessageLookupByLibrary.simpleMessage(
      "Тестировать при использовании",
    ),
    "textScale": MessageLookupByLibrary.simpleMessage("Масштаб текста"),
    "textScalePreview": MessageLookupByLibrary.simpleMessage(
      "Так будет выглядеть текст в приложении",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Шкурка интерфейса"),
    "themeColor": MessageLookupByLibrary.simpleMessage("Цвет хайпа"),
    "themeDesc": MessageLookupByLibrary.simpleMessage(
      "Кастомный визуал для глаз",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Тема оформления"),
    "tight": MessageLookupByLibrary.simpleMessage("Плотный"),
    "time": MessageLookupByLibrary.simpleMessage("Время"),
    "timeout": MessageLookupByLibrary.simpleMessage("Тайм-аут"),
    "tip": MessageLookupByLibrary.simpleMessage("Лайфхак"),
    "toggle": MessageLookupByLibrary.simpleMessage("Переключить"),
    "toggleLabel": MessageLookupByLibrary.simpleMessage("Переключить подписи"),
    "tolerance": MessageLookupByLibrary.simpleMessage("Допуск"),
    "tonalSpotScheme": MessageLookupByLibrary.simpleMessage("Тональный акцент"),
    "tools": MessageLookupByLibrary.simpleMessage("Приблуды"),
    "torch": MessageLookupByLibrary.simpleMessage("Фонарик"),
    "total": MessageLookupByLibrary.simpleMessage("В сумме"),
    "totalTraffic": MessageLookupByLibrary.simpleMessage(
      "В сумме залутано базы (богатство и сладость)",
    ),
    "tproxyPort": MessageLookupByLibrary.simpleMessage("Порт TProxy"),
    "trafficUsage": MessageLookupByLibrary.simpleMessage("Слито гигов"),
    "tsarOfDonations": MessageLookupByLibrary.simpleMessage(
      "Гигачад Донатов (Царь)",
    ),
    "tt": MessageLookupByLibrary.simpleMessage("ТікТок / Мемы ⚡"),
    "tun": MessageLookupByLibrary.simpleMessage("TUN режим (полный фарш)"),
    "tunDesc": MessageLookupByLibrary.simpleMessage(
      "Завернуть вообще весь трафик устройства",
    ),
    "turnOff": MessageLookupByLibrary.simpleMessage("Вырубить"),
    "turnOn": MessageLookupByLibrary.simpleMessage("Подрубить"),
    "uk": MessageLookupByLibrary.simpleMessage("Українська"),
    "undo": MessageLookupByLibrary.simpleMessage("Отменить"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage("Единая пинг"),
    "unifiedDelayDesc": MessageLookupByLibrary.simpleMessage(
      "Убирает лишние задержки, например рукопожатие",
    ),
    "unknown": MessageLookupByLibrary.simpleMessage("Неизвестно"),
    "unknownNetworkError": MessageLookupByLibrary.simpleMessage(
      "Вот такие дела, собачка... Кринж сети",
    ),
    "unlimited": MessageLookupByLibrary.simpleMessage("Полный безлимит"),
    "unmaximize": MessageLookupByLibrary.simpleMessage(
      "Свернуть в карман в карман в окно",
    ),
    "unnamed": MessageLookupByLibrary.simpleMessage("Без названия"),
    "unpinWindow": MessageLookupByLibrary.simpleMessage("Открепить окно"),
    "update": MessageLookupByLibrary.simpleMessage("Обновиться с кайфом"),
    "updateCheckError": MessageLookupByLibrary.simpleMessage(
      "Не удалось чекнуть апдейты",
    ),
    "updateLater": MessageLookupByLibrary.simpleMessage("Позже"),
    "updateNow": MessageLookupByLibrary.simpleMessage("Освежить"),
    "updateSubscription": MessageLookupByLibrary.simpleMessage(
      "Освежить сабку",
    ),
    "upload": MessageLookupByLibrary.simpleMessage("Турбо-тяга яппинга"),
    "url": MessageLookupByLibrary.simpleMessage("URL ссылка"),
    "urlDesc": MessageLookupByLibrary.simpleMessage("Получить конфиг по URL"),
    "urlTip": m61,
    "useHosts": MessageLookupByLibrary.simpleMessage("Использовать hosts"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage(
      "Использовать системный hosts",
    ),
    "usedTraffic": MessageLookupByLibrary.simpleMessage("Уже потратил"),
    "userAgent": MessageLookupByLibrary.simpleMessage("User-Agent"),
    "userProfileHeader": MessageLookupByLibrary.simpleMessage(
      "// ПОЛЬЗОВАТЕЛЬ",
    ),
    "value": MessageLookupByLibrary.simpleMessage("Значение"),
    "vibrantScheme": MessageLookupByLibrary.simpleMessage("Яркая"),
    "view": MessageLookupByLibrary.simpleMessage("Просмотр"),
    "vpnConfigChangeDetected": MessageLookupByLibrary.simpleMessage(
      "Обнаружено изменение настроек VPN",
    ),
    "vpnConnected": MessageLookupByLibrary.simpleMessage("VPN подключён"),
    "vpnDisconnected": MessageLookupByLibrary.simpleMessage("VPN отключён"),
    "vpnEnableDesc": MessageLookupByLibrary.simpleMessage(
      "На автомате направляет весь системный трафик через VpnService",
    ),
    "vpnTip": MessageLookupByLibrary.simpleMessage(
      "Изменения вступят в силу после перезапуска VPN",
    ),
    "webDAVConfiguration": MessageLookupByLibrary.simpleMessage(
      "Подкрутка WebDAV",
    ),
    "whitelistMode": MessageLookupByLibrary.simpleMessage(
      "Режим белого списка",
    ),
    "writeToSystem": MessageLookupByLibrary.simpleMessage(
      "Записывать в систему",
    ),
    "writeToSystemDesc": MessageLookupByLibrary.simpleMessage(
      "Также устанавливать системные часы; Android это игнорирует",
    ),
    "yearsAgo": m62,
    "yes": MessageLookupByLibrary.simpleMessage("Да"),
    "zhCN": MessageLookupByLibrary.simpleMessage("简体中文"),
  };
}
