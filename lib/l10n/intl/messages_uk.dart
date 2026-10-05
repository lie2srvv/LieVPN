// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a uk locale. All the
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
  String get localeName => 'uk';

  static String m0(count, skipped) =>
      "Будет добавлено: ${count}, пропущено (уже есть): ${skipped}";

  static String m1(code) =>
      "Windows відказалазь запузкать LieVPNCore.exe (помілка ${code}). Політікі контроля додатків, такіе как Smart App Control або AppLocker, блокіруют неподпізанные программы; разрешіте LieVPN в этой політіке або відключіте её і повторіте попытку.";

  static String m2(name) =>
      "Додаток два раза подряд не змогло завершіть запузк. Чтобы разорвать цікл, профіль ${name} знят з выбора, а автоматічезкая налаштування пропущена. Вы можете вібраті его знова в любой момент.";

  static String m3(url) => "Зоздать профіль по ззылке ${url}?";

  static String m4(count) =>
      "${Intl.plural(count, one: '${count} день назад', few: '${count} дня назад', many: '${count} днів назад', other: '${count} дня назад')}";

  static String m5(label) =>
      "Вы уверены, что хвідіте відаліті выбранные элементы (${label})?";

  static String m6(label) => "Вы уверены, что хвідіте відаліті «${label}»?";

  static String m7(label) => "Зведенія: ${label}";

  static String m8(label) => "Поле не може бути порожнім";

  static String m9(count) =>
      "${Intl.plural(count, one: '${count} запізь', few: '${count} запізі', many: '${count} запізей', other: '${count} запізі')}";

  static String m10(label) => "«${label}» уже зущезтвует";

  static String m11(name) => "${name}: уже озтання верзія";

  static String m12(name) => "${name}: обновлено";

  static String m13(action) =>
      "Уже используется для «${action}». При сохранении будет перенесено сюда.";

  static String m14(modifiers) =>
      "Добавьте хотя бы одну из клавиш: ${modifiers}";

  static String m15(count) =>
      "${Intl.plural(count, one: '${count} чаз назад', few: '${count} чаза назад', many: '${count} рікін назад', other: '${count} чаза назад')}";

  static String m16(count) =>
      "${Intl.plural(count, one: '${count} чаз', few: '${count} чаза', many: '${count} рікін', other: '${count} чаза')}";

  static String m17(target) => "${target} — недопузтімая політіка";

  static String m18(proxyName) => "${proxyName} — недопузтімый прокзі";

  static String m19(providerName) =>
      "${providerName} — недопузтімый провайдер прокзі";

  static String m20(ruleSet) => "${ruleSet} — недопустимый набор правил";

  static String m21(subRule) => "${subRule} — недопузтімый SUB_RULE";

  static String m22(line, message) => "Строка ${line}: ${message}";

  static String m23(appName) =>
      "1. Відкройте Зізтемні налаштування > Конфіденціальнозть і безопазнозть\n2. Выберіте Злужбы геолокаціі\n3. Найдіте і відметьте ${appName} в зпізке\n\nПозле налаштування вернітезь в додаток і продолжайте рабвіду. Зпазібо за звідруднічезтво.";

  static String m24(label, max) => "«${label}» — не более ${max} зімволов";

  static String m25(size) => "Освобождено ${size}";

  static String m26(count) =>
      "${Intl.plural(count, one: '${count} хвабону назад', few: '${count} хвабоны назад', many: '${count} хвабон назад', other: '${count} хвабоны назад')}";

  static String m27(count) =>
      "${Intl.plural(count, one: '${count} мезяц назад', few: '${count} мезяца назад', many: '${count} мізяців назад', other: '${count} мезяца назад')}";

  static String m28(code) =>
      "Сервер запретил доступ (HTTP ${code}). Возможно, ссылка устарела или учётные данные неверны";

  static String m29(code) => "Сервер отклонил запрос (HTTP ${code})";

  static String m30(code) =>
      "По этому адресу ничего не найдено (HTTP ${code}). Проверьте правильность URL";

  static String m31(detail) => "Сетевой запрос не выполнен: ${detail}";

  static String m32(code) =>
      "На сервере произошла ошибка (HTTP ${code}). Повторите попытку позже";

  static String m33(version) => "Дозтупно оновлення ${version}";

  static String m34(label) => "Пока нет: ${label}";

  static String m35(label) => "Значеніе «${label}» должно быть чізлом";

  static String m36(message) =>
      "Ядро не может разобрать этот прокси: ${message}";

  static String m37(name) =>
      "Имя ${name} уже занято другим прокси или группой прокси";

  static String m38(path) =>
      "Группы прокси ссылаются друг на друга по кругу: ${path}";

  static String m39(names) => "Эти провайдеры прокси не существуют: ${names}";

  static String m40(names) => "Эти прокси или политики не существуют: ${names}";

  static String m41(name) =>
      "${name} — встроенное имя политики, его нельзя использовать";

  static String m42(names) =>
      "Собственные группы прокси профиля ссылаются на прокси, которых больше нет среди пользовательских: ${names}";

  static String m43(count) =>
      "Проблем: ${count}, применение переопределения может завершиться ошибкой";

  static String m44(label) =>
      "Значеніе «${label}» должно быть від 1024 до 49151";

  static String m45(label, profiles) =>
      "«${label}» всё ещё используется в пользовательских группах прокси или правилах профилей: ${profiles}. Сначала уберите его оттуда";

  static String m46(profiles, label) =>
      "В подписках профилей ${profiles} уже есть «${label}», и после переименования они будут использовать его. Выберите другое имя";

  static String m47(count) => "${count} прокзі";

  static String m48(count) =>
      "${Intl.plural(count, one: '${count} правіло', few: '${count} правіла', many: '${count} правіл', other: '${count} правіла')}";

  static String m49(appName) => "${appName} (Безопасный режим)";

  static String m50(count) =>
      "${Intl.plural(count, one: '${count} зекунда', few: '${count} зекунды', many: '${count} зекунд', other: '${count} зекунды')}";

  static String m51(count) => "Вібрано: ${count}";

  static String m52(time) => "Проверено в ${time}";

  static String m53(label) => "«${label}» — только одно значение";

  static String m54(count) => "Взе зервері дозтупны (${count})";

  static String m55(up, total) => "Рабвідают ${up} із ${total}";

  static String m56(count) =>
      "${Intl.plural(count, one: '${count} день', few: '${count} дні', many: '${count} днів', other: '${count} днів')}";

  static String m57(count) => "Ура! ${count} днів стріку поспіль!";

  static String m58(count) =>
      "Ви ще не заходили в LieVPN сьогодні. Підключіться до 00:00 МСК, щоб зберегти стрік у ${count} дн.!";

  static String m59(count) =>
      "Залишилося відновлень цього місяця: ${count} з 3";

  static String m60(time) => "Підпізка закінчуєтьзя через ${time}";

  static String m61(label) => "Введіть коректну адресу";

  static String m62(count) =>
      "${Intl.plural(count, one: '${count} рік назад', few: '${count} ріка назад', many: '${count} років назад', other: '${count} ріка назад')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Про програму"),
    "aboutAppDesc": MessageLookupByLibrary.simpleMessage(
      "Пріватный VPN для защіты даніх і анонімнозті в мережі на првідоколе VLESS і Hysteria2.",
    ),
    "aboutFork": MessageLookupByLibrary.simpleMessage("Форк FlClash"),
    "aboutForkDesc": MessageLookupByLibrary.simpleMessage(
      "Відкрыть орігінальный репозіторій FlClash",
    ),
    "accessControl": MessageLookupByLibrary.simpleMessage("Контроль додатків"),
    "accessControlAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Через VPN проходят только выбранные додаткі",
    ),
    "accessControlDesc": MessageLookupByLibrary.simpleMessage(
      "Виберіть додатки, які будуть використовувати VPN",
    ),
    "accessControlDisabledDesc": MessageLookupByLibrary.simpleMessage(
      "Контроль дозтупа додатків відключён",
    ),
    "accessControlNotAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Выбранные додаткі ізключаютзя із VPN",
    ),
    "accessControlSettings": MessageLookupByLibrary.simpleMessage(
      "Налаштування контроля дозтупа",
    ),
    "account": MessageLookupByLibrary.simpleMessage("Акаунт"),
    "accountStatus": MessageLookupByLibrary.simpleMessage("ЗТАТУЗ"),
    "accountUsername": MessageLookupByLibrary.simpleMessage("ІМЯ ПОЛЬЗОВАТЕЛЯ"),
    "action": MessageLookupByLibrary.simpleMessage("Дія"),
    "actionDelayTest": MessageLookupByLibrary.simpleMessage(
      "Проверить все задержки",
    ),
    "actionDirectMode": MessageLookupByLibrary.simpleMessage("Прямой режим"),
    "actionGlobalMode": MessageLookupByLibrary.simpleMessage(
      "Глобальный режим",
    ),
    "actionMode": MessageLookupByLibrary.simpleMessage("Переключіть режім"),
    "actionProxy": MessageLookupByLibrary.simpleMessage("Зізтемній прокзі"),
    "actionRuleMode": MessageLookupByLibrary.simpleMessage("Режим правил"),
    "actionStart": MessageLookupByLibrary.simpleMessage("Зтарт/Зтоп"),
    "actionTun": MessageLookupByLibrary.simpleMessage("TUN"),
    "actionUpdateProfiles": MessageLookupByLibrary.simpleMessage(
      "Обновить профили",
    ),
    "actionView": MessageLookupByLibrary.simpleMessage("Показаті/Пріховаті"),
    "add": MessageLookupByLibrary.simpleMessage("Додаті"),
    "addCustomProxy": MessageLookupByLibrary.simpleMessage("Добавить прокси"),
    "addOverrideEntry": MessageLookupByLibrary.simpleMessage(
      "Добавить параметр",
    ),
    "addProfile": MessageLookupByLibrary.simpleMessage("Додати профіль"),
    "addProxies": MessageLookupByLibrary.simpleMessage("Добавіть прокзі"),
    "addProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Добавіть группу прокзі",
    ),
    "addProxyProviders": MessageLookupByLibrary.simpleMessage(
      "Добавіть провайдеров прокзі",
    ),
    "addRule": MessageLookupByLibrary.simpleMessage("Добавіть правіло"),
    "addRules": MessageLookupByLibrary.simpleMessage("Додаті правіла"),
    "addRulesDesc": MessageLookupByLibrary.simpleMessage(
      "Керування влазнімі правіламі маршрутізації",
    ),
    "addSsid": MessageLookupByLibrary.simpleMessage("Добавіть SSID"),
    "addSubscription": MessageLookupByLibrary.simpleMessage(
      "Добавіть підпізку",
    ),
    "addWidget": MessageLookupByLibrary.simpleMessage("Добавіть віджет"),
    "addedRules": MessageLookupByLibrary.simpleMessage("Добавленные правіла"),
    "additionalParameters": MessageLookupByLibrary.simpleMessage(
      "Дополнітельные параметрі",
    ),
    "address": MessageLookupByLibrary.simpleMessage("Адрезі"),
    "addressHelp": MessageLookupByLibrary.simpleMessage(
      "Адрезі зервера WebDAV",
    ),
    "addressTip": MessageLookupByLibrary.simpleMessage(
      "Введіте корректный адрезі WebDAV",
    ),
    "advancedConfig": MessageLookupByLibrary.simpleMessage(
      "Разшіренная конфігурація",
    ),
    "advancedConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Разнообразные параметрі конфігураціі",
    ),
    "agree": MessageLookupByLibrary.simpleMessage("Зоглазен"),
    "allowBypass": MessageLookupByLibrary.simpleMessage(
      "Разрешіть додаткім обходіть VPN",
    ),
    "allowBypassDesc": MessageLookupByLibrary.simpleMessage(
      "Прі включеніі неквідорые додаткі змогут обходіть VPN",
    ),
    "allowLan": MessageLookupByLibrary.simpleMessage(
      "Дозволити доступ з локальної мережі",
    ),
    "allowLanDesc": MessageLookupByLibrary.simpleMessage(
      "Дозволити іншим пристроям підключатися",
    ),
    "answers": MessageLookupByLibrary.simpleMessage("Ответы"),
    "app": MessageLookupByLibrary.simpleMessage("Додаток"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage(
      "Контроль дозтупа додатків",
    ),
    "appIconDesign": MessageLookupByLibrary.simpleMessage(
      "Дизайн значка приложения",
    ),
    "appendSystemDns": MessageLookupByLibrary.simpleMessage(
      "Добавлять зізтемній DNS",
    ),
    "appendSystemDnsTip": MessageLookupByLibrary.simpleMessage(
      "Прінудітельно добавлять зізтемній DNS в конфігурацію",
    ),
    "application": MessageLookupByLibrary.simpleMessage("Додаток"),
    "applicationDesc": MessageLookupByLibrary.simpleMessage(
      "Налаштування, звязанные з додатокм",
    ),
    "authentication": MessageLookupByLibrary.simpleMessage("Аутентіфікація"),
    "authenticationDesc": MessageLookupByLibrary.simpleMessage(
      "Требовать учётные дані для локального порта прокзі, чтобы другіе додаткі не моглі вікорізтовуваті его",
    ),
    "authenticationSystemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Не пріменяетзя, пока включена аутентіфікація",
    ),
    "authorize": MessageLookupByLibrary.simpleMessage("Разрешіть"),
    "authorized": MessageLookupByLibrary.simpleMessage("Разрешено"),
    "auto": MessageLookupByLibrary.simpleMessage("Авто"),
    "autoCheckUpdate": MessageLookupByLibrary.simpleMessage(
      "Автоперевірка оновлень",
    ),
    "autoCheckUpdateDesc": MessageLookupByLibrary.simpleMessage(
      "Автоматічно проверять оновлення прі запузке додаткі",
    ),
    "autoCloseConnections": MessageLookupByLibrary.simpleMessage(
      "Автозакрытіе з\'єднань",
    ),
    "autoCloseConnectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Автоматічно закрывать з\'єднання позле змены узла",
    ),
    "autoLaunch": MessageLookupByLibrary.simpleMessage("Автозапузк"),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Запускати додаток при старті системи",
    ),
    "autoRun": MessageLookupByLibrary.simpleMessage("Автозапуск"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage(
      "Включатьзя автоматічно прі відкрытіі додаткі",
    ),
    "autoSetSystemDns": MessageLookupByLibrary.simpleMessage(
      "Автоналаштування зізтемного DNS",
    ),
    "autoUpdate": MessageLookupByLibrary.simpleMessage("Автооновлення"),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Інтервал автооновлення",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Назад"),
    "backup": MessageLookupByLibrary.simpleMessage("Резервное копірованіе"),
    "backupAndRestore": MessageLookupByLibrary.simpleMessage(
      "Резервное копірованіе і воззтановленіе",
    ),
    "backupAndRestoreDesc": MessageLookupByLibrary.simpleMessage(
      "Зінхронізація даніх через WebDAV або файлы",
    ),
    "backupFromNewerVersion": MessageLookupByLibrary.simpleMessage(
      "Резервная копия создана более новой версией приложения. Обновите приложение перед восстановлением",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage(
      "Резервная копія зоздана",
    ),
    "basicConfig": MessageLookupByLibrary.simpleMessage("Базовая конфігурація"),
    "basicConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Глобальное ізмененіе базовой конфігураціі",
    ),
    "basicInfo": MessageLookupByLibrary.simpleMessage("Озновная інформація"),
    "basicStrategy": MessageLookupByLibrary.simpleMessage("Базовые політікі"),
    "batchAdd": MessageLookupByLibrary.simpleMessage("Массовое добавление"),
    "batchListInputTip": MessageLookupByLibrary.simpleMessage(
      "По одному значению на строку или через запятую",
    ),
    "batchMapInputTip": MessageLookupByLibrary.simpleMessage(
      "По одной записи на строку: ключ, пробел, значение",
    ),
    "batchPreviewTip": m0,
    "batteryOptimizationDesc": MessageLookupByLibrary.simpleMessage(
      "Чтобы додаток рабвідало в фоне, відключіте для него оптімізацію батареі. Нажміте, чтобы перейті к налаштуванням.",
    ),
    "batteryOptimizationStatusTip": MessageLookupByLibrary.simpleMessage(
      "Із-за зізтемных ограніченій во чаз рабвіды невозможно корректно получіть зтатуз оптімізаціі батареі",
    ),
    "be": MessageLookupByLibrary.simpleMessage("Беларузкая"),
    "behavior": MessageLookupByLibrary.simpleMessage("Поведение"),
    "bind": MessageLookupByLibrary.simpleMessage("Прівязать"),
    "blacklistMode": MessageLookupByLibrary.simpleMessage(
      "Режім чёрного зпізка",
    ),
    "blockConnection": MessageLookupByLibrary.simpleMessage(
      "Заблокіровать з\'єднання",
    ),
    "buyInTelegram": MessageLookupByLibrary.simpleMessage("Купити в Telegram"),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("Обхід доменів"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Зпізок доменів в обхід прокзі",
    ),
    "cache": MessageLookupByLibrary.simpleMessage("Кэш"),
    "cacheAlgorithm": MessageLookupByLibrary.simpleMessage("Алгоритм кэша"),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "Кэш повреждён. Очізтіті его?",
    ),
    "cacheMaxSize": MessageLookupByLibrary.simpleMessage("Размер кэша"),
    "cameraPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешите доступ к камере в системных настройках, чтобы сканировать QR-коды, или выберите изображение QR-кода из галереи.",
    ),
    "cameraPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Требуется доступ к камере",
    ),
    "cameraUnavailable": MessageLookupByLibrary.simpleMessage(
      "Камера недоступна",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Скасувати"),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage("Знять выделеніе"),
    "change": MessageLookupByLibrary.simpleMessage("Зменіть"),
    "changeProxyFailedTip": MessageLookupByLibrary.simpleMessage(
      "Не удалозь переключіть прокзі; воззтановлен предыдущій выбор",
    ),
    "changeSubscription": MessageLookupByLibrary.simpleMessage(
      "Зменіть підпізку",
    ),
    "changelogBreaking": MessageLookupByLibrary.simpleMessage(
      "Важные ізмененія",
    ),
    "changelogFeatures": MessageLookupByLibrary.simpleMessage("Нові функціі"),
    "changelogFixes": MessageLookupByLibrary.simpleMessage("Ізправленія"),
    "changelogPerformance": MessageLookupByLibrary.simpleMessage(
      "Проізводітельнозть",
    ),
    "changelogReverts": MessageLookupByLibrary.simpleMessage("Відкаты"),
    "checkCertificate": MessageLookupByLibrary.simpleMessage(
      "Проверять TLS-зертіфікаты",
    ),
    "checkCertificateDesc": MessageLookupByLibrary.simpleMessage(
      "Відклонять недоверенные зертіфікаты. Відключеніе подвергает підпізкі і резервные копіі атаке «человек позередіне»",
    ),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("Перевірити оновлення"),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage(
      "У ваз уже озтання верзія",
    ),
    "checkUpdateStatus": MessageLookupByLibrary.simpleMessage("Оновити статус"),
    "checkUpdates": MessageLookupByLibrary.simpleMessage(
      "Перевіріті оновлення",
    ),
    "checkUpdatesDesc": MessageLookupByLibrary.simpleMessage(
      "Перевіріті налічіе новой верзіі",
    ),
    "clearData": MessageLookupByLibrary.simpleMessage("Очізтіті дані"),
    "clearSearch": MessageLookupByLibrary.simpleMessage("Очізтіті пошук"),
    "clipboardExport": MessageLookupByLibrary.simpleMessage(
      "Экзпорт в буфер обмена",
    ),
    "clipboardImport": MessageLookupByLibrary.simpleMessage(
      "Імпорт із буфера обмена",
    ),
    "clipboardWriteFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось скопировать в буфер обмена. Возможно, выделение слишком велико",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Закрити"),
    "closeConnections": MessageLookupByLibrary.simpleMessage(
      "Закріваті з\'єднання",
    ),
    "color": MessageLookupByLibrary.simpleMessage("Цвет"),
    "colorSchemes": MessageLookupByLibrary.simpleMessage("Цветовые зхемы"),
    "columns": MessageLookupByLibrary.simpleMessage("Зтолбцы"),
    "compatible": MessageLookupByLibrary.simpleMessage("Режім зовмезтімозті"),
    "configDataDetected": MessageLookupByLibrary.simpleMessage(
      "В конфігураціі обнаружены дані",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Підтвердити"),
    "confirmClearAllData": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хвідіте відаліті взе дані?",
    ),
    "confirmDeleteProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хвідіте відаліті эту группу прокзі?",
    ),
    "confirmExitWindow": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хвідіте закріті пвідочне окно?",
    ),
    "confirmForceCrashCore": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хвідіте прінудітельно завершіть ядро зо збоем?",
    ),
    "confirmOverwriteTip": MessageLookupByLibrary.simpleMessage(
      "Позле подтвержденія зущезтвующіе дані будут перезапізаны",
    ),
    "connected": MessageLookupByLibrary.simpleMessage("Підключено"),
    "connecting": MessageLookupByLibrary.simpleMessage("Підключення..."),
    "connection": MessageLookupByLibrary.simpleMessage("З\'єднання"),
    "connections": MessageLookupByLibrary.simpleMessage("З\'єднання"),
    "connectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Прозмвідр даніх о текущіх з\'єднаннях",
    ),
    "connectivity": MessageLookupByLibrary.simpleMessage("Підключення: "),
    "content": MessageLookupByLibrary.simpleMessage("Зодержімое"),
    "contentNotEmpty": MessageLookupByLibrary.simpleMessage(
      "Зодержімое не может быть пузтым",
    ),
    "contentScheme": MessageLookupByLibrary.simpleMessage("Контентная"),
    "controlGlobalAddedRules": MessageLookupByLibrary.simpleMessage(
      "Управленіе глобальнымі добавленнымі правіламі",
    ),
    "copy": MessageLookupByLibrary.simpleMessage("Скопіювати"),
    "copyEnvVar": MessageLookupByLibrary.simpleMessage(
      "Зкопіюваті переменные окруженія",
    ),
    "copyLink": MessageLookupByLibrary.simpleMessage("Зкопіюваті ззылку"),
    "copySuccess": MessageLookupByLibrary.simpleMessage(
      "Скопійовано в буфер обміну",
    ),
    "core": MessageLookupByLibrary.simpleMessage("Ядро"),
    "coreBlockedByPolicyTip": m1,
    "coreBlockedBySmartAppControlTip": MessageLookupByLibrary.simpleMessage(
      "Smart App Control в Windows заблокіровал неподпізанный LieVPNCore.exe. Відкройте Безопазнозть Windows → Управленіе додаткімі і браузером → Параметрі Smart App Control, выберіте «Выкл.» і знова запузтіте LieVPN. Повторно увімкнуті Smart App Control без переузтановкі Windows нельзя.",
    ),
    "coreStatus": MessageLookupByLibrary.simpleMessage("Зтатуз ядра"),
    "country": MessageLookupByLibrary.simpleMessage("Регіон"),
    "crashDetected": MessageLookupByLibrary.simpleMessage("Обнаружен збой"),
    "crashDetectedTip": m2,
    "crashTest": MessageLookupByLibrary.simpleMessage("Тезт збоя"),
    "crashlytics": MessageLookupByLibrary.simpleMessage("Аналітіка збоев"),
    "crashlyticsTip": MessageLookupByLibrary.simpleMessage(
      "Прі включеніі в злучае збоя додаткі автоматічно загружаютзя логі збоя без конфіденціальной інформаціі",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Зоздать"),
    "createProfile": MessageLookupByLibrary.simpleMessage("Зоздать профіль"),
    "createProfileFromUrlTip": m3,
    "creationTime": MessageLookupByLibrary.simpleMessage("Чаз зозданія"),
    "custom": MessageLookupByLibrary.simpleMessage("Вручную"),
    "customProxiesEmpty": MessageLookupByLibrary.simpleMessage(
      "Пользовательских прокси нет, поэтому используются прокси самого профиля",
    ),
    "cut": MessageLookupByLibrary.simpleMessage("Вирізати"),
    "dark": MessageLookupByLibrary.simpleMessage("Темна"),
    "dashboard": MessageLookupByLibrary.simpleMessage("Панель керування"),
    "dashboardLieVpn": MessageLookupByLibrary.simpleMessage("Панель LieVPN"),
    "dataChangedSave": MessageLookupByLibrary.simpleMessage(
      "Обнаружены ізмененія даніх. Зберегті іх?",
    ),
    "dataCollectionContent": MessageLookupByLibrary.simpleMessage(
      "Это додаток ізпользует Firebase Crashlytics для збора інформаціі о збоях, чтобы повызіть зтабільнозть.\nЗобіраемые дані включают зведенія об узтройзтве і подробнозті збоя і не зодержат лічных конфіденціальных даніх.\nЭту функцію можно відключіті в налаштуваннях.",
    ),
    "dataCollectionTip": MessageLookupByLibrary.simpleMessage(
      "Зповіщення о зборе даніх",
    ),
    "dataLimit": MessageLookupByLibrary.simpleMessage("ЛІМІТ ДАННЫХ"),
    "dataUsed": MessageLookupByLibrary.simpleMessage("ІЗПОЛЬЗОВАНО"),
    "databaseWriteFailedTip": MessageLookupByLibrary.simpleMessage(
      "Не удалозь зберегті ізмененіе; оно відменено",
    ),
    "daysAgo": m4,
    "defaultNameserver": MessageLookupByLibrary.simpleMessage(
      "DNS-зервер за замовчуванням",
    ),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Ізпользуетзя для разрешенія адрезіов DNS-зерверов",
    ),
    "defaultText": MessageLookupByLibrary.simpleMessage("За замовчуванням"),
    "delay": MessageLookupByLibrary.simpleMessage("Затримка"),
    "delayTest": MessageLookupByLibrary.simpleMessage("Тезт затрімкі"),
    "delete": MessageLookupByLibrary.simpleMessage("Видалити"),
    "deleteMultipTip": m5,
    "deleteTip": m6,
    "desc": MessageLookupByLibrary.simpleMessage(
      "Многоплатформенный прокзі-кліент на ознове ClashMeta: прозтой і удобный, з відкрытым ізходным кодом і без рекламы.",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("Назначеніе"),
    "destinationGeoIP": MessageLookupByLibrary.simpleMessage(
      "GeoIP назначенія",
    ),
    "destinationIPASN": MessageLookupByLibrary.simpleMessage(
      "ASN IP назначенія",
    ),
    "details": m7,
    "detectionTip": MessageLookupByLibrary.simpleMessage(
      "Ізпользует зторонній API; только для зправкі",
    ),
    "developerMode": MessageLookupByLibrary.simpleMessage(
      "Режім разрабвідчіка",
    ),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "Режім разрабвідчіка включён.",
    ),
    "dialerProxy": MessageLookupByLibrary.simpleMessage(
      "Прокси для подключения",
    ),
    "dialerProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Исход, через который идёт обращение к NTP-серверу",
    ),
    "direct": MessageLookupByLibrary.simpleMessage("Пряме з\'єднання"),
    "disableUDP": MessageLookupByLibrary.simpleMessage("Відключіті UDP"),
    "disabled": MessageLookupByLibrary.simpleMessage("Выключено"),
    "discardChanges": MessageLookupByLibrary.simpleMessage(
      "Отменить изменения?",
    ),
    "disclaimer": MessageLookupByLibrary.simpleMessage(
      "Відказ від відветзтвеннозті",
    ),
    "disclaimerAcceptContent": MessageLookupByLibrary.simpleMessage(
      "Устанавливая, копируя или используя Программу, вы подтверждаете, что прочитали и приняли это заявление полностью. Если вы не согласны с каким-либо его условием, немедленно прекратите использование и удалите Программу.",
    ),
    "disclaimerAcceptTitle": MessageLookupByLibrary.simpleMessage(
      "Принятие условий",
    ),
    "disclaimerAnalyticsContent": MessageLookupByLibrary.simpleMessage(
      "Вместе с Firebase автоматически собирается базовая статистика использования приложения.\n\nЧто собирается: базовые события, такие как первый запуск, открытие приложения и длительность сеанса, обновление приложения; идентификатор экземпляра приложения; модель устройства, версия ОС и язык системы; приблизительное местоположение на уровне страны или региона, определённое по IP-адресу.\n\nЦель: только оценка числа активных устройств, распределения версий и совместимости с ОС. Разработчики не используют эти данные для рекламы, не продают их и не связывают с вашими подписками или конфигурациями.",
    ),
    "disclaimerAnalyticsTitle": MessageLookupByLibrary.simpleMessage(
      "Firebase Analytics (статистика использования)",
    ),
    "disclaimerAndroidOnly": MessageLookupByLibrary.simpleMessage(
      "Только Android",
    ),
    "disclaimerChangesContent": MessageLookupByLibrary.simpleMessage(
      "Разработчики могут изменять это заявление в любом выпуске; изменения вступают в силу с момента публикации выпуска. Продолжая пользоваться Программой после обновления, вы принимаете изменённое заявление.",
    ),
    "disclaimerChangesTitle": MessageLookupByLibrary.simpleMessage(
      "Изменения заявления",
    ),
    "disclaimerCrashlyticsContent": MessageLookupByLibrary.simpleMessage(
      "При сбое приложения отчёт о сбое отправляется автоматически.\n\nЧто собирается: трассировка стека и сообщение об ошибке, время сбоя, версия и номер сборки приложения, производитель и модель устройства, версия Android, ориентация экрана, свободная память и место в хранилище, наличие root-доступа, а также случайный идентификатор установки, который создаётся при установке и сбрасывается при переустановке.\n\nЦель: только поиск и исправление сбоев.\n\nВы можете отключить это в любой момент: «Инструменты > Общие > Аналитика сбоев».",
    ),
    "disclaimerCrashlyticsTitle": MessageLookupByLibrary.simpleMessage(
      "Firebase Crashlytics (аналитика сбоев)",
    ),
    "disclaimerDataProcessingContent": MessageLookupByLibrary.simpleMessage(
      "Эти данные обрабатываются и хранятся компанией Google от нашего имени, могут передаваться на серверы за пределами вашей страны или региона (например, в США) и регулируются Политикой конфиденциальности Google и документацией Firebase о конфиденциальности и безопасности. Отчёты о сбоях хранятся до 90 дней; статистика хранится в соответствии с политикой хранения Firebase по умолчанию.",
    ),
    "disclaimerDesc": MessageLookupByLibrary.simpleMessage(
      "Это программное обезпеченіе предназначено только для некоммерчезкого ізпользованія: обученія, обмена опытом і научных іззледованій. Коммерчезкое вікорізтання зтрого запрещено; любая коммерчезкая деятельнозть не імеет відношенія к этому программному обезпеченію.",
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
      "Программа не собирает и не отправляет адреса ваших подписок, сведения об узлах, содержимое конфигураций, посещённые сайты, записи о подключениях, содержимое трафика и журналы. Эти данные хранятся только на вашем устройстве, и у разработчиков нет к ним доступа.\n\nПрограмма обращается к сети только при использовании соответствующих функций, например загружает указанный вами адрес подписки при обновлении профиля или обращается к GitHub при проверке обновлений.\n\nНастольные версии (Windows, macOS, Linux) не содержат никаких сервисов статистики или отчётов о сбоях. Версия для Android использует два сервиса Google Firebase для повышения стабильности:",
    ),
    "disclaimerPrivacyTitle": MessageLookupByLibrary.simpleMessage(
      "Сбор данных и конфиденциальность",
    ),
    "disclaimerResponsibilityContent": MessageLookupByLibrary.simpleMessage(
      "Вы самостоятельно убеждаетесь, что использование Программы законно в вашей стране или регионе, и единолично несёте юридическую ответственность за все действия с ней и их последствия.\n\nПодписки, узлы и конфигурации, которые вы импортируете, выбираете вы сами. Законность их источника, безопасность содержимого и надёжность сервиса — вопрос между вами и их поставщиками.",
    ),
    "disclaimerResponsibilityTitle": MessageLookupByLibrary.simpleMessage(
      "Ваша ответственность",
    ),
    "disclaimerSoftwareContent": MessageLookupByLibrary.simpleMessage(
      "Программа — это клиент сетевого прокси с открытым исходным кодом на основе ядра Clash.Meta (mihomo). Она предоставляет только локальные инструменты: управление конфигурациями, маршрутизацию по правилам и пересылку трафика.\n\nСама Программа не предоставляет прокси-серверы, узлы, подписки или услуги доступа к сети и не состоит в партнёрских, агентских или гарантийных отношениях с поставщиками таких услуг.",
    ),
    "disclaimerSoftwareTitle": MessageLookupByLibrary.simpleMessage(
      "Характер программы",
    ),
    "disclaimerThirdPartyContent": MessageLookupByLibrary.simpleMessage(
      "Ссылки на подписки, файлы конфигурации, наборы правил, скрипты, внешние ресурсы и внешние ссылки предоставляются третьими лицами. Разработчики не могут проверять и не проверяют их законность, точность, безопасность и доступность и не дают на них никаких гарантий.\n\nУтечка данных, финансовые потери, блокировка аккаунта или иной ущерб, вызванные сторонним контентом, урегулируются между вами и третьим лицом; разработчики не несут за это никакой ответственности.",
    ),
    "disclaimerThirdPartyTitle": MessageLookupByLibrary.simpleMessage(
      "Сторонний контент",
    ),
    "disclaimerUsageContent": MessageLookupByLibrary.simpleMessage(
      "Программа предназначена только для некоммерческого использования: обучения, обмена опытом и технических исследований. Любое коммерческое использование строго запрещено, включая, помимо прочего, платное распространение, продажу в комплекте, использование в составе коммерческого сервиса или ведение деятельности от имени Программы. Любая коммерческая деятельность не имеет отношения к Программе и её разработчикам.\n\nСтрого запрещено использовать Программу для действий, нарушающих законы вашей страны или региона, включая, помимо прочего, обход законно установленных ограничений доступа к сети, распространение незаконной информации, сетевые атаки и нарушение законных прав других лиц.",
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
    "disconnected": MessageLookupByLibrary.simpleMessage("Відключено"),
    "discoverNewVersion": MessageLookupByLibrary.simpleMessage(
      "Дозтупна нова верзія",
    ),
    "dnsDesc": MessageLookupByLibrary.simpleMessage(
      "Налаштування, звязанные з DNS",
    ),
    "dnsHijacking": MessageLookupByLibrary.simpleMessage("Перехоплення DNS"),
    "dnsMode": MessageLookupByLibrary.simpleMessage("Режім DNS"),
    "dnsQueries": MessageLookupByLibrary.simpleMessage("DNS-запросы"),
    "docked": MessageLookupByLibrary.simpleMessage("Закреплённая"),
    "domain": MessageLookupByLibrary.simpleMessage("Домен"),
    "donators": MessageLookupByLibrary.simpleMessage("Меценати проєкту"),
    "download": MessageLookupByLibrary.simpleMessage("Завантажити"),
    "edit": MessageLookupByLibrary.simpleMessage("Редагувати"),
    "editGlobalRules": MessageLookupByLibrary.simpleMessage(
      "Редактіровать глобальные правіла",
    ),
    "editProxy": MessageLookupByLibrary.simpleMessage("Редактіровать прокзі"),
    "editProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Редактіровать группу прокзі",
    ),
    "editRule": MessageLookupByLibrary.simpleMessage("Редактіровать правіло"),
    "editSsid": MessageLookupByLibrary.simpleMessage("Ізменіть SSID"),
    "editorUnavailable": MessageLookupByLibrary.simpleMessage(
      "Редактор недоступен",
    ),
    "emptyTip": m8,
    "en": MessageLookupByLibrary.simpleMessage("English"),
    "enabled": MessageLookupByLibrary.simpleMessage("Включено"),
    "enterSubscriptionUrl": MessageLookupByLibrary.simpleMessage(
      "Введіть посилання на підписку",
    ),
    "entries": MessageLookupByLibrary.simpleMessage(" запізей"),
    "entriesCount": m9,
    "error": MessageLookupByLibrary.simpleMessage("Помилка"),
    "exclude": MessageLookupByLibrary.simpleMessage(
      "Пріховаті із недавніх задач",
    ),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "Зкрывать додаток із недавніх задач, когда оно в фоне",
    ),
    "excludeProxyFilter": MessageLookupByLibrary.simpleMessage(
      "Фільтр ізключенія узлов",
    ),
    "excludeSsids": MessageLookupByLibrary.simpleMessage("Ізключённые SSID"),
    "excludeSsidsDesc": MessageLookupByLibrary.simpleMessage(
      "Прі подключеніі к Wi-Fi з ізключённым SSID зозтояніе рабвіды додаткі переключаетзя автоматічно",
    ),
    "excludeType": MessageLookupByLibrary.simpleMessage("Ізключаемые тіпы"),
    "existsTip": m10,
    "exit": MessageLookupByLibrary.simpleMessage("Вихід"),
    "exitFullScreen": MessageLookupByLibrary.simpleMessage(
      "Выйті із полноэкранного режіма",
    ),
    "expand": MessageLookupByLibrary.simpleMessage("Розгорнути"),
    "expectedStatus": MessageLookupByLibrary.simpleMessage("Ожідаемый зтатуз"),
    "expirationDate": MessageLookupByLibrary.simpleMessage("Дата закінчення"),
    "expireTime": MessageLookupByLibrary.simpleMessage("Закінчується"),
    "exportFile": MessageLookupByLibrary.simpleMessage("Экзпорт файла"),
    "exportLogs": MessageLookupByLibrary.simpleMessage("Экзпорт логов"),
    "exportSuccess": MessageLookupByLibrary.simpleMessage("Экзпорт выполнен"),
    "expressiveScheme": MessageLookupByLibrary.simpleMessage("Экзпреззівная"),
    "externalController": MessageLookupByLibrary.simpleMessage(
      "Зовнішній контролер",
    ),
    "externalControllerDesc": MessageLookupByLibrary.simpleMessage(
      "Адреса керування Clash Core",
    ),
    "externalFetch": MessageLookupByLibrary.simpleMessage("Внешнее полученіе"),
    "externalLink": MessageLookupByLibrary.simpleMessage("Внешняя позілання"),
    "extraLarge": MessageLookupByLibrary.simpleMessage("Очень крупный"),
    "fade": MessageLookupByLibrary.simpleMessage("Растворение"),
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Фільтр Fake-IP"),
    "fakeipFilterMode": MessageLookupByLibrary.simpleMessage(
      "Режим фильтра Fake-IP",
    ),
    "fakeipFilterModeDesc": MessageLookupByLibrary.simpleMessage(
      "blacklist исключает совпадения, whitelist — только их, rule — по правилам",
    ),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Діапазон Fake-IP"),
    "fakeipRange6": MessageLookupByLibrary.simpleMessage(
      "Диапазон Fake-IP (IPv6)",
    ),
    "fakeipTtl": MessageLookupByLibrary.simpleMessage("TTL Fake-IP"),
    "fallback": MessageLookupByLibrary.simpleMessage("Fallback"),
    "fallbackDesc": MessageLookupByLibrary.simpleMessage(
      "Зазвичай закордонний DNS",
    ),
    "fallbackFilter": MessageLookupByLibrary.simpleMessage("Фільтр fallback"),
    "fidelityScheme": MessageLookupByLibrary.simpleMessage("Точная передача"),
    "file": MessageLookupByLibrary.simpleMessage("Файл"),
    "fileDesc": MessageLookupByLibrary.simpleMessage(
      "Загрузіть файл профіля напрямую",
    ),
    "fileIsUpdate": MessageLookupByLibrary.simpleMessage(
      "Файл ізменён. Зберегті ізмененія?",
    ),
    "filter": MessageLookupByLibrary.simpleMessage("Фильтр"),
    "findProcessMode": MessageLookupByLibrary.simpleMessage("Пошук процезза"),
    "findProcessModeDesc": MessageLookupByLibrary.simpleMessage(
      "Прі включеніі возможна небольшая пвідеря проізводітельнозті",
    ),
    "floating": MessageLookupByLibrary.simpleMessage("Плавающая"),
    "followProfile": MessageLookupByLibrary.simpleMessage("Как в профіле"),
    "followSystem": MessageLookupByLibrary.simpleMessage("Как в системе"),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Шрифт"),
    "fontSize": MessageLookupByLibrary.simpleMessage("Размер"),
    "forceRestartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хвідіте прінудітельно перезапузтіть ядро?",
    ),
    "format": MessageLookupByLibrary.simpleMessage("Формат"),
    "fruitSaladScheme": MessageLookupByLibrary.simpleMessage("Фруктовый мікз"),
    "general": MessageLookupByLibrary.simpleMessage("Общіе"),
    "geoAutoUpdate": MessageLookupByLibrary.simpleMessage("Автооновлення"),
    "geoAutoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Інтервал автооновлення",
    ),
    "geoAutoUpdateIntervalTip": MessageLookupByLibrary.simpleMessage(
      "Інтервал автооновлення должен быть больше 0",
    ),
    "geoOptions": MessageLookupByLibrary.simpleMessage("Налаштування Geo"),
    "geoResources": MessageLookupByLibrary.simpleMessage("Резурзы Geo"),
    "geoSkipped": m11,
    "geoUpdated": m12,
    "geodataLoader": MessageLookupByLibrary.simpleMessage(
      "Geo: экономія памяті",
    ),
    "geodataLoaderDesc": MessageLookupByLibrary.simpleMessage(
      "Прі включеніі ізпользуетзя Geo-загрузчік з нізкім пвідребленіем памяті",
    ),
    "geoipCode": MessageLookupByLibrary.simpleMessage("Код GeoIP"),
    "global": MessageLookupByLibrary.simpleMessage("Глобальний"),
    "go": MessageLookupByLibrary.simpleMessage("Перейті"),
    "goDownload": MessageLookupByLibrary.simpleMessage("Завантажіті"),
    "goToConfigureScript": MessageLookupByLibrary.simpleMessage(
      "Перейті к назтройке зкріпта",
    ),
    "hallOfFameHeader": MessageLookupByLibrary.simpleMessage(
      "// Зал Злавы — общій донат",
    ),
    "hasCacheChange": MessageLookupByLibrary.simpleMessage(
      "Кэшіровать ізмененія?",
    ),
    "helperCorruptTip": MessageLookupByLibrary.simpleMessage(
      "Злужба Helper недозтупна, поэтому TUN-режім увімкнуті нельзя. Переузтановіте LieVPN.",
    ),
    "hideFromList": MessageLookupByLibrary.simpleMessage("Пріховаті із зпізка"),
    "hideIp": MessageLookupByLibrary.simpleMessage("Скрыть IP"),
    "hidePassword": MessageLookupByLibrary.simpleMessage("Пріховаті пароль"),
    "hideTimeoutProxies": MessageLookupByLibrary.simpleMessage(
      "Скрывать узлы с таймаутом",
    ),
    "hideTimeoutProxiesDesc": MessageLookupByLibrary.simpleMessage(
      "Не показывать узлы, у которых последний тест задержки завершился таймаутом",
    ),
    "host": MessageLookupByLibrary.simpleMessage("Хозт"),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("Добавіть запізі hosts"),
    "hotkeyConflict": MessageLookupByLibrary.simpleMessage(
      "Конфлікт горячіх клавіш",
    ),
    "hotkeyConflictWith": m13,
    "hotkeyDesc": MessageLookupByLibrary.simpleMessage(
      "Глобальные горячие клавиши работают, даже когда окно скрыто. Нажмите на действие, чтобы записать сочетание клавиш.",
    ),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage("Горячіе клавіші"),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "Управленіе додатокм з клавіатуры",
    ),
    "hotkeyNeedsModifier": m14,
    "hotkeyNotSet": MessageLookupByLibrary.simpleMessage("Не задано"),
    "hotkeyUnavailable": MessageLookupByLibrary.simpleMessage(
      "Не зарегистрировано: сочетание может быть занято другим приложением",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("годин"),
    "hoursAgo": m15,
    "hoursCount": m16,
    "icon": MessageLookupByLibrary.simpleMessage("Значок"),
    "iconRecords": MessageLookupByLibrary.simpleMessage("Ізторія значков"),
    "iconStyle": MessageLookupByLibrary.simpleMessage("Зтіль значков"),
    "iconStyleFilled": MessageLookupByLibrary.simpleMessage("С подложкой"),
    "iconStyleHidden": MessageLookupByLibrary.simpleMessage("Скрыто"),
    "iconStylePlain": MessageLookupByLibrary.simpleMessage("Без подложки"),
    "iconUrl": MessageLookupByLibrary.simpleMessage("URL значка"),
    "ignoreBatteryOptimization": MessageLookupByLibrary.simpleMessage(
      "Ігноріровать оптімізацію батареі",
    ),
    "import": MessageLookupByLibrary.simpleMessage("Імпорт"),
    "importFile": MessageLookupByLibrary.simpleMessage("Імпорт із файла"),
    "importFromURL": MessageLookupByLibrary.simpleMessage("Імпорт із URL"),
    "importUrl": MessageLookupByLibrary.simpleMessage("Імпорт по URL"),
    "inbound": MessageLookupByLibrary.simpleMessage("Входящіе"),
    "includeAllProxies": MessageLookupByLibrary.simpleMessage(
      "Увімкнуті взе прокзі",
    ),
    "includeAllProxiesTip": MessageLookupByLibrary.simpleMessage(
      "Подключает взе прокзі вне групп; ніже можно добавіть дополнітельные группы прокзі",
    ),
    "includeAllProxyProviders": MessageLookupByLibrary.simpleMessage(
      "Увімкнуті взех провайдеров прокзі",
    ),
    "includeAllProxyProvidersTip": MessageLookupByLibrary.simpleMessage(
      "Прі включеніі переопределяет подключённых провайдеров прокзі",
    ),
    "infiniteTime": MessageLookupByLibrary.simpleMessage("Беззрочно"),
    "init": MessageLookupByLibrary.simpleMessage("Ініціалізація"),
    "initiator": MessageLookupByLibrary.simpleMessage("Инициатор"),
    "inputCorrectHotkey": MessageLookupByLibrary.simpleMessage(
      "Введіте корректную горячую клавішу",
    ),
    "inputProxyGroupName": MessageLookupByLibrary.simpleMessage(
      "Введіте названіе группы прокзі",
    ),
    "inputRuleContent": MessageLookupByLibrary.simpleMessage(
      "Введіте зодержімое правіла",
    ),
    "insertSubscriptionUrl": MessageLookupByLibrary.simpleMessage(
      "Вставити посилання",
    ),
    "installedAppsPermissionDeniedMessage":
        MessageLookupByLibrary.simpleMessage(
          "Разрешеніе на зпізок додатків відклонено, поэтому узтановленные додаткі недозтупны. Предозтавьте его вручную в зізтемных налаштуваннях.",
        ),
    "installedAppsPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "Эта зізтема не выдаёт зпізок узтановленных додатків без разрешенія. Предозтавьте его, чтобы назтроіть прокзі для віддельных додатків.",
    ),
    "installedAppsPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Требуетзя разрешеніе на зпізок додатків",
    ),
    "intelligentSelected": MessageLookupByLibrary.simpleMessage(
      "Розумний вибір",
    ),
    "interfaceName": MessageLookupByLibrary.simpleMessage("Ім\'я інтерфейза"),
    "interfaceNameDesc": MessageLookupByLibrary.simpleMessage(
      "Мережевій інтерфейз для ізходящіх з\'єднань",
    ),
    "interfaceNameMode": MessageLookupByLibrary.simpleMessage(
      "Ізходящій інтерфейз",
    ),
    "interfaceNameModeClear": MessageLookupByLibrary.simpleMessage("Очізтіті"),
    "interfaceNameModeCustom": MessageLookupByLibrary.simpleMessage("Вручную"),
    "interfaceNameModeFollow": MessageLookupByLibrary.simpleMessage(
      "Как в конфігураціі",
    ),
    "internet": MessageLookupByLibrary.simpleMessage("Інтернет"),
    "interval": MessageLookupByLibrary.simpleMessage("Інтервал"),
    "intranetIP": MessageLookupByLibrary.simpleMessage("Лок. IP"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Недопузтімый файл резервной копіі",
    ),
    "invalidDscpContent": MessageLookupByLibrary.simpleMessage(
      "Метка DSCP не может превышать 63",
    ),
    "invalidNetworkContent": MessageLookupByLibrary.simpleMessage(
      "Поддерживаются только tcp и udp",
    ),
    "invalidPolicy": m17,
    "invalidProfileQrcode": MessageLookupByLibrary.simpleMessage(
      "Этот QR-код не содержит ссылку на профиль",
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
    "ipQualityRetry": MessageLookupByLibrary.simpleMessage("Проверить снова"),
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
    "ipTypeMobile": MessageLookupByLibrary.simpleMessage("Мобильная сеть"),
    "ipTypeResidential": MessageLookupByLibrary.simpleMessage("Домашний"),
    "ipcidr": MessageLookupByLibrary.simpleMessage("IP/CIDR"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage(
      "Увімкнути підтримку IPv6 трафіку",
    ),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешіть входящій IPv6",
    ),
    "ipv6Timeout": MessageLookupByLibrary.simpleMessage("Тайм-аут IPv6 (мс)"),
    "ja": MessageLookupByLibrary.simpleMessage("日本語"),
    "justNow": MessageLookupByLibrary.simpleMessage("Только что"),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "Інтервал TCP keep-alive",
    ),
    "key": MessageLookupByLibrary.simpleMessage("Ключ"),
    "kk": MessageLookupByLibrary.simpleMessage("Қазақша"),
    "ko": MessageLookupByLibrary.simpleMessage("한국어"),
    "language": MessageLookupByLibrary.simpleMessage("Мова"),
    "large": MessageLookupByLibrary.simpleMessage("Крупный"),
    "lastUpdated": MessageLookupByLibrary.simpleMessage("Последнее обновление"),
    "latestVersionInstalled": MessageLookupByLibrary.simpleMessage(
      "У ваз узтановлена озтання верзія",
    ),
    "launchInterrupted": MessageLookupByLibrary.simpleMessage(
      "Запузк не завершён",
    ),
    "launchInterruptedTip": MessageLookupByLibrary.simpleMessage(
      "В прошлый раз додаток неожіданно завершілозь во чаз запузка. Автоматічезкая налаштування для этого запузка пропущена; вы можете запузтіть её вручную.",
    ),
    "layout": MessageLookupByLibrary.simpleMessage("Макет"),
    "lieVpnSettings": MessageLookupByLibrary.simpleMessage(
      "Налаштування LieVPN",
    ),
    "lieVpnSettingsDesc": MessageLookupByLibrary.simpleMessage(
      "Параметрі зповіщень і перзоналізаціі",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Світла"),
    "lineIssueTip": m22,
    "lineWrap": MessageLookupByLibrary.simpleMessage("Перенос строк"),
    "list": MessageLookupByLibrary.simpleMessage("Зпізок"),
    "listen": MessageLookupByLibrary.simpleMessage("Прозлушіваніе"),
    "listenRoutingMark": MessageLookupByLibrary.simpleMessage(
      "Метка маршрутизации",
    ),
    "listenRoutingMarkDesc": MessageLookupByLibrary.simpleMessage(
      "Только Linux",
    ),
    "liveConnections": MessageLookupByLibrary.simpleMessage(
      "Активные соединения",
    ),
    "liveNotification": MessageLookupByLibrary.simpleMessage("Live-сповіщення"),
    "liveNotificationCustomText": MessageLookupByLibrary.simpleMessage(
      "Власний текст",
    ),
    "liveNotificationCustomTextDesc": MessageLookupByLibrary.simpleMessage(
      "Текст, що відображається в Live-сповіщенні",
    ),
    "liveNotificationDesc": MessageLookupByLibrary.simpleMessage(
      "Показувати статус у рядку стану (Android)",
    ),
    "liveNotificationType": MessageLookupByLibrary.simpleMessage(
      "Відображення в Live-сповіщенні",
    ),
    "liveNotificationTypeCustom": MessageLookupByLibrary.simpleMessage(
      "Власний текст",
    ),
    "liveNotificationTypeDesc": MessageLookupByLibrary.simpleMessage(
      "Виберіть, що відображати у рядку стану",
    ),
    "liveNotificationTypePing": MessageLookupByLibrary.simpleMessage(
      "Пінг сервера",
    ),
    "liveNotificationTypeServer": MessageLookupByLibrary.simpleMessage(
      "Поточний сервер (країна)",
    ),
    "liveNotificationTypeSpeed": MessageLookupByLibrary.simpleMessage(
      "Швидкість мережі (Download + Upload)",
    ),
    "liveNotificationTypeSpeedDown": MessageLookupByLibrary.simpleMessage(
      "Швидкість завантаження (Download)",
    ),
    "liveNotificationTypeSpeedUp": MessageLookupByLibrary.simpleMessage(
      "Швидкість віддачі (Upload)",
    ),
    "liveNotificationTypeStreak": MessageLookupByLibrary.simpleMessage(
      "Вогник стріку",
    ),
    "liveNotificationTypeTraffic": MessageLookupByLibrary.simpleMessage(
      "Використано даних",
    ),
    "liveNotificationTypeUsername": MessageLookupByLibrary.simpleMessage(
      "Ім\'я користувача",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Завантаження..."),
    "local": MessageLookupByLibrary.simpleMessage("Локально"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Резервное копірованіе даніх локально",
    ),
    "localNetworkDeniedTip": MessageLookupByLibrary.simpleMessage(
      "Доступ к локальной сети запрещён: используется стек gvisor, локальная сеть недоступна.",
    ),
    "locationPermission": MessageLookupByLibrary.simpleMessage(
      "Разрешеніе на геолокацію",
    ),
    "locationPermissionDeniedMessage": MessageLookupByLibrary.simpleMessage(
      "Разрешеніе на геолокацію відклонено, поэтому невозможно получіть ім\'я текущей мережі Wi-Fi. Включіте разрешеніе на геолокацію вручную в зізтемных налаштуваннях.",
    ),
    "locationPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "По требованію зізтемы для полученія імені мережі Wi-Fi необходімо разрешеніе на геолокацію. На Android выберіте «Разрешіть взегда», іначе ім\'я мережі Wi-Fi нельзя получіть, пока додаток в фоне.",
    ),
    "locationPermissionGuide": m23,
    "locationPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Требуетзя разрешеніе на геолокацію",
    ),
    "log": MessageLookupByLibrary.simpleMessage("Лог"),
    "logLevel": MessageLookupByLibrary.simpleMessage("Рівень журналювання"),
    "logcat": MessageLookupByLibrary.simpleMessage("Захоплення логів"),
    "logcatDesc": MessageLookupByLibrary.simpleMessage(
      "Прі відключеніі раздел логов будет зкрыт",
    ),
    "logs": MessageLookupByLibrary.simpleMessage("Журнал"),
    "logsAndDiagnostics": MessageLookupByLibrary.simpleMessage(
      "Логи и диагностика",
    ),
    "logsDesc": MessageLookupByLibrary.simpleMessage(
      "Запізі захваченных логов",
    ),
    "logsTest": MessageLookupByLibrary.simpleMessage("Тезт логов"),
    "loopback": MessageLookupByLibrary.simpleMessage(
      "Інзтрумент разблокіровкі loopback",
    ),
    "loopbackDesc": MessageLookupByLibrary.simpleMessage(
      "Для знятія ограніченія loopback у UWP-додатків",
    ),
    "loose": MessageLookupByLibrary.simpleMessage("Звободный"),
    "matchSourceIp": MessageLookupByLibrary.simpleMessage(
      "Зопозтавлять IP ізточніка",
    ),
    "matchTarget": MessageLookupByLibrary.simpleMessage("MATCH-TARGET"),
    "matchTargetDesc": MessageLookupByLibrary.simpleMessage(
      "Куда направляютзя правіла з целью MATCH-TARGET. За замовчуванням — цель позледнего правіла MATCH этого профіля.",
    ),
    "matchTargetTitle": MessageLookupByLibrary.simpleMessage("Цель MATCH"),
    "maxFailedTimes": MessageLookupByLibrary.simpleMessage(
      "Макз. чізло неудач",
    ),
    "maxLengthTip": m24,
    "maximize": MessageLookupByLibrary.simpleMessage("Розгорнути"),
    "memoryAppResident": MessageLookupByLibrary.simpleMessage(
      "Резидентная память",
    ),
    "memoryAppShared": MessageLookupByLibrary.simpleMessage(
      "Приложение и общая",
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
      "Ядро работает в процессе приложения. Его доля оценивается по статистике среды выполнения, остальное относится к приложению и общей памяти.",
    ),
    "memoryInfo": MessageLookupByLibrary.simpleMessage("Память"),
    "memoryReleased": MessageLookupByLibrary.simpleMessage(
      "Память освобождена",
    ),
    "memoryReleasedSize": m25,
    "messageTest": MessageLookupByLibrary.simpleMessage("Тезт зообщенія"),
    "messageTestTip": MessageLookupByLibrary.simpleMessage("Это повідомлення."),
    "min": MessageLookupByLibrary.simpleMessage("Мінімальный"),
    "minimize": MessageLookupByLibrary.simpleMessage("Згорнути"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage(
      "Згортаті прі закрітті",
    ),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "Згортати в трей при закритті вікна",
    ),
    "minutesAgo": m26,
    "mixedPort": MessageLookupByLibrary.simpleMessage("Змішаний порт"),
    "mode": MessageLookupByLibrary.simpleMessage("Режим"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("Монохром"),
    "monthsAgo": m27,
    "more": MessageLookupByLibrary.simpleMessage("Більше"),
    "multipleValuesTip": MessageLookupByLibrary.simpleMessage(
      "Разделяйте незколько значеній запятымі",
    ),
    "name": MessageLookupByLibrary.simpleMessage("Названіе"),
    "nameserver": MessageLookupByLibrary.simpleMessage("DNS-зервер"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Ізпользуетзя для разрешенія доменов",
    ),
    "nameserverPolicy": MessageLookupByLibrary.simpleMessage(
      "Політіка DNS-зерверов",
    ),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "Задать політіку DNS-зерверов для доменов",
    ),
    "navigationBarStyle": MessageLookupByLibrary.simpleMessage("Нижняя панель"),
    "network": MessageLookupByLibrary.simpleMessage("Мережа"),
    "networkAccessDeniedError": m28,
    "networkBadResponseError": m29,
    "networkCancelledError": MessageLookupByLibrary.simpleMessage(
      "Запрос отменён",
    ),
    "networkConnectionError": MessageLookupByLibrary.simpleMessage(
      "Не удалось подключиться к серверу. Проверьте подключение к сети или настройки прокси",
    ),
    "networkDesc": MessageLookupByLibrary.simpleMessage(
      "Налаштування, звязанные з мережаю",
    ),
    "networkDetection": MessageLookupByLibrary.simpleMessage(
      "Перевірка мережі",
    ),
    "networkException": MessageLookupByLibrary.simpleMessage("Помілка мережі"),
    "networkHostLookupError": MessageLookupByLibrary.simpleMessage(
      "Не удалось определить адрес сервера. Проверьте правильность URL и работу DNS",
    ),
    "networkNotFoundError": m30,
    "networkRateLimitedError": MessageLookupByLibrary.simpleMessage(
      "Слишком много запросов (HTTP 429). Подождите немного и повторите попытку",
    ),
    "networkRequestFailed": m31,
    "networkServerError": m32,
    "networkSpeed": MessageLookupByLibrary.simpleMessage("Швидкість мережі"),
    "networkTimeoutError": MessageLookupByLibrary.simpleMessage(
      "Время ожидания запроса истекло. Проверьте сеть или прокси и повторите попытку",
    ),
    "networkTlsError": MessageLookupByLibrary.simpleMessage(
      "Не удалось установить защищённое соединение. Сертификат сервера может быть недействителен, или соединение перехватывается",
    ),
    "networkType": MessageLookupByLibrary.simpleMessage("Тіп мережі"),
    "neutralScheme": MessageLookupByLibrary.simpleMessage("Нейтральная"),
    "newVersionAvailable": m33,
    "nextMatch": MessageLookupByLibrary.simpleMessage("Зледующее зовпаденіе"),
    "no": MessageLookupByLibrary.simpleMessage("Нет"),
    "noAddedRulesYet": MessageLookupByLibrary.simpleMessage(
      "Правіл пока нет. Добавьте домен або додаток выше.",
    ),
    "noData": MessageLookupByLibrary.simpleMessage("Ні даніх"),
    "noExpiration": MessageLookupByLibrary.simpleMessage("∞ Беззрочно"),
    "noHotKey": MessageLookupByLibrary.simpleMessage("Горячіх клавіш пока нет"),
    "noInfo": MessageLookupByLibrary.simpleMessage("Ні інформаціі"),
    "noLongerRemind": MessageLookupByLibrary.simpleMessage(
      "Больше не напомінать",
    ),
    "noNetwork": MessageLookupByLibrary.simpleMessage("Ні мережі"),
    "noNetworkApp": MessageLookupByLibrary.simpleMessage("Додаткі без мережі"),
    "noRecords": MessageLookupByLibrary.simpleMessage("Запізей пока нет"),
    "noResolve": MessageLookupByLibrary.simpleMessage("Не разрешать IP"),
    "noResolveHostname": MessageLookupByLibrary.simpleMessage(
      "Не разрешать ім\'я хозта",
    ),
    "noSearchResults": MessageLookupByLibrary.simpleMessage(
      "Ничего не найдено",
    ),
    "noSubscriptionFound": MessageLookupByLibrary.simpleMessage(
      "Підпізка не добавлена",
    ),
    "nonTextProviderFile": MessageLookupByLibrary.simpleMessage(
      "Этот внешний ресурс не является текстовым файлом",
    ),
    "none": MessageLookupByLibrary.simpleMessage("Ні"),
    "notLieVpnSubscription": MessageLookupByLibrary.simpleMessage(
      "Це не посилання LieVPN",
    ),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "Текущую группу прокзі нельзя вібраті",
    ),
    "ntpInterval": MessageLookupByLibrary.simpleMessage(
      "Интервал синхронизации (минуты)",
    ),
    "ntpStatusDesc": MessageLookupByLibrary.simpleMessage(
      "Брать время с NTP-сервера, а не из системных часов",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Немає активного профілю",
    ),
    "nullTip": m34,
    "numberTip": m35,
    "onDemand": MessageLookupByLibrary.simpleMessage("По узловію"),
    "onDemandDesc": MessageLookupByLibrary.simpleMessage(
      "Назтройте зозтояніе рабвіды додаткі для определённых зценаріев",
    ),
    "onlyIcon": MessageLookupByLibrary.simpleMessage("Тільки значок"),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage(
      "Учітывать только прокзі",
    ),
    "onlyStatisticsProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Прі включеніі учітываетзя только трафік через прокзі",
    ),
    "optional": MessageLookupByLibrary.simpleMessage("Необязательно"),
    "options": MessageLookupByLibrary.simpleMessage("Опціі"),
    "other": MessageLookupByLibrary.simpleMessage("Інше"),
    "otherContributors": MessageLookupByLibrary.simpleMessage(
      "Другіе учазтнікі",
    ),
    "outboundIp": MessageLookupByLibrary.simpleMessage("Исходящий IP"),
    "outboundMode": MessageLookupByLibrary.simpleMessage("Режим маршрутизації"),
    "override": MessageLookupByLibrary.simpleMessage("Перевизначення"),
    "overrideDns": MessageLookupByLibrary.simpleMessage("Переопределіть DNS"),
    "overrideDnsDesc": MessageLookupByLibrary.simpleMessage(
      "Прі включеніі налаштування DNS профіля переопределяютзя",
    ),
    "overrideEntries": MessageLookupByLibrary.simpleMessage(
      "Переопределяемые параметры",
    ),
    "overrideMode": MessageLookupByLibrary.simpleMessage(
      "Режім переопределенія",
    ),
    "overrideNtp": MessageLookupByLibrary.simpleMessage("Переопределить NTP"),
    "overrideScript": MessageLookupByLibrary.simpleMessage(
      "Зкріпт переопределенія",
    ),
    "overwriteIssueCoreRejected": m36,
    "overwriteIssueDuplicateName": m37,
    "overwriteIssueEmptyName": MessageLookupByLibrary.simpleMessage(
      "Имя не задано",
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
    "overwriteTypeCustom": MessageLookupByLibrary.simpleMessage(
      "Корізтувачзкій",
    ),
    "overwriteTypeCustomDesc": MessageLookupByLibrary.simpleMessage(
      "Корізтувачзкій режім: полная налаштування групп прокзі і правіл",
    ),
    "palette": MessageLookupByLibrary.simpleMessage("Палітра"),
    "password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "paste": MessageLookupByLibrary.simpleMessage("Вставити"),
    "personalAccount": MessageLookupByLibrary.simpleMessage(
      "Особистий кабінет",
    ),
    "pickFromAlbum": MessageLookupByLibrary.simpleMessage("Вібраті із галереі"),
    "pinWindow": MessageLookupByLibrary.simpleMessage(
      "Закрепіть поверх взех окон",
    ),
    "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage(
      "Прівяжіте WebDAV",
    ),
    "pleaseEnterScriptName": MessageLookupByLibrary.simpleMessage(
      "Введіте названіе зкріпта",
    ),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "Загрузіте корректный QR-код",
    ),
    "port": MessageLookupByLibrary.simpleMessage("Порт"),
    "portConflictTip": MessageLookupByLibrary.simpleMessage(
      "Введіте другой порт",
    ),
    "portTip": m44,
    "preferH3Desc": MessageLookupByLibrary.simpleMessage(
      "Предпочітать HTTP/3 для DoH",
    ),
    "prerequisites": MessageLookupByLibrary.simpleMessage(
      "Предварітельные узловія",
    ),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage("Нажміте клавішу"),
    "preview": MessageLookupByLibrary.simpleMessage("Предпрозмвідр"),
    "previousMatch": MessageLookupByLibrary.simpleMessage(
      "Предыдущее зовпаденіе",
    ),
    "process": MessageLookupByLibrary.simpleMessage("Процезз"),
    "profile": MessageLookupByLibrary.simpleMessage("Профіль"),
    "profileAutoUpdateIntervalInvalidValidationDesc":
        MessageLookupByLibrary.simpleMessage("Введіте корректный інтервал"),
    "profileAutoUpdateIntervalNullValidationDesc":
        MessageLookupByLibrary.simpleMessage("Введіте інтервал автооновлення"),
    "profileHasUpdate": MessageLookupByLibrary.simpleMessage(
      "Профіль ізменён. Відключіті автооновлення?",
    ),
    "profileNameNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Введіте названіе профіля",
    ),
    "profileUrlInvalidValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Введіте корректный URL профіля",
    ),
    "profileUrlNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Введіте URL профіля",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Профілі"),
    "profilesSort": MessageLookupByLibrary.simpleMessage("Зортіровка профілей"),
    "project": MessageLookupByLibrary.simpleMessage("Проект"),
    "providerInUse": m45,
    "providerRenameShadowed": m46,
    "providerSourceSubscription": MessageLookupByLibrary.simpleMessage(
      "Подписка",
    ),
    "providerUrlTip": MessageLookupByLibrary.simpleMessage(
      "Поддерживаются только удалённые ресурсы",
    ),
    "providers": MessageLookupByLibrary.simpleMessage("Внешніе резурзы"),
    "proxies": MessageLookupByLibrary.simpleMessage("Проксі"),
    "proxiesCount": m47,
    "proxiesEmpty": MessageLookupByLibrary.simpleMessage("Зпізок прокзі пузт"),
    "proxyChains": MessageLookupByLibrary.simpleMessage("Цепочка прокзі"),
    "proxyDefinition": MessageLookupByLibrary.simpleMessage(
      "Полная конфигурация",
    ),
    "proxyDefinitionNotMap": MessageLookupByLibrary.simpleMessage(
      "Конфигурация должна быть YAML-словарём с полями name и type",
    ),
    "proxyDetectedAbnormal": MessageLookupByLibrary.simpleMessage(
      "Обнаружены відклоненія в выбранных прокзі",
    ),
    "proxyFilter": MessageLookupByLibrary.simpleMessage("Фільтр узлов"),
    "proxyGroup": MessageLookupByLibrary.simpleMessage("Группа прокзі"),
    "proxyGroupDetectedAbnormal": MessageLookupByLibrary.simpleMessage(
      "Обнаружены відклоненія в текущей группе прокзі",
    ),
    "proxyGroupEmpty": MessageLookupByLibrary.simpleMessage(
      "Группа прокзі пузта",
    ),
    "proxyGroupNameDuplicate": MessageLookupByLibrary.simpleMessage(
      "Названіе группы прокзі уже ізпользуетзя",
    ),
    "proxyGroupNameEmpty": MessageLookupByLibrary.simpleMessage(
      "Названіе группы прокзі не может быть пузтым",
    ),
    "proxyNameserver": MessageLookupByLibrary.simpleMessage(
      "DNS-зервер для прокзі",
    ),
    "proxyNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Ізпользуетзя для разрешенія доменов прокзі-узлов",
    ),
    "proxyNode": MessageLookupByLibrary.simpleMessage("Прокси-узел"),
    "proxyProviderDetectedAbnormal": MessageLookupByLibrary.simpleMessage(
      "Обнаружены відклоненія в выбранных провайдерах прокзі",
    ),
    "proxyProviders": MessageLookupByLibrary.simpleMessage("Провайдеры прокзі"),
    "proxyProvidersEmpty": MessageLookupByLibrary.simpleMessage(
      "Зпізок провайдеров прокзі пузт",
    ),
    "proxyProvidersNotEmpty": MessageLookupByLibrary.simpleMessage(
      "Провайдеры прокзі не могут быть пузтымі",
    ),
    "proxyType": MessageLookupByLibrary.simpleMessage("Тіп прокзі"),
    "pruneCache": MessageLookupByLibrary.simpleMessage("Очізтіті кэш"),
    "pureBlack": MessageLookupByLibrary.simpleMessage(
      "Справжній чорний (AMOLED)",
    ),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("Чізто чёрный режім"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QR-код"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage(
      "Зканіруйте QR-код, чтобы получіть профіль",
    ),
    "quickAdd": MessageLookupByLibrary.simpleMessage("Быстрое добавление"),
    "quickEdit": MessageLookupByLibrary.simpleMessage("Быстрое редактирование"),
    "quickFill": MessageLookupByLibrary.simpleMessage("Бызтрое заполненіе"),
    "rainbowScheme": MessageLookupByLibrary.simpleMessage("Радуга"),
    "readyToTest": MessageLookupByLibrary.simpleMessage(
      "Гвідов к тезтірованію",
    ),
    "recentRequests": MessageLookupByLibrary.simpleMessage("Последние запросы"),
    "recordType": MessageLookupByLibrary.simpleMessage("Тип записи"),
    "redirPort": MessageLookupByLibrary.simpleMessage("Порт Redir"),
    "redo": MessageLookupByLibrary.simpleMessage("Повторіть"),
    "releaseMemory": MessageLookupByLibrary.simpleMessage("Освободить память"),
    "releaseMemoryFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось освободить память",
    ),
    "remote": MessageLookupByLibrary.simpleMessage("Віддалено"),
    "remoteBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Резервное копірованіе даніх в WebDAV",
    ),
    "remoteDestination": MessageLookupByLibrary.simpleMessage(
      "Удалённое назначеніе",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("Прибрати"),
    "renew": MessageLookupByLibrary.simpleMessage("Продовжити"),
    "renewSubscription": MessageLookupByLibrary.simpleMessage(
      "Продовжити підписку",
    ),
    "replace": MessageLookupByLibrary.simpleMessage("Заменить"),
    "replaceAll": MessageLookupByLibrary.simpleMessage("Заменить все"),
    "request": MessageLookupByLibrary.simpleMessage("Запроз"),
    "requests": MessageLookupByLibrary.simpleMessage("Запіті"),
    "requestsAndUpdates": MessageLookupByLibrary.simpleMessage(
      "Запросы и обновления",
    ),
    "requestsDesc": MessageLookupByLibrary.simpleMessage(
      "Прозмвідр позледніх запрозов",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Скинути"),
    "resetPageChangesTip": MessageLookupByLibrary.simpleMessage(
      "На этой зтраніце езть ізмененія. Вы уверены, что хвідіте выполніть зброз?",
    ),
    "resetTip": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хвідіте выполніть зброз?",
    ),
    "resources": MessageLookupByLibrary.simpleMessage("Резурзі"),
    "resourcesDesc": MessageLookupByLibrary.simpleMessage(
      "Зведенія о внешніх резурзах",
    ),
    "respectRules": MessageLookupByLibrary.simpleMessage("Зоблюдать правіла"),
    "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
      "DNS-з\'єднання зледуют правілам; требуетзя назтроіть proxy-server-nameserver",
    ),
    "responseCode": MessageLookupByLibrary.simpleMessage("Код ответа"),
    "restart": MessageLookupByLibrary.simpleMessage("Перезапузтіть"),
    "restartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хвідіте перезапузтіть ядро?",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Воззтановіть"),
    "restoreAllData": MessageLookupByLibrary.simpleMessage(
      "Воззтановіть взе дані",
    ),
    "restoreException": MessageLookupByLibrary.simpleMessage(
      "Помілка воззтановленія",
    ),
    "restoreFromFileDesc": MessageLookupByLibrary.simpleMessage(
      "Воззтановіть дані із файла",
    ),
    "restoreFromWebDAVDesc": MessageLookupByLibrary.simpleMessage(
      "Воззтановіть дані із WebDAV",
    ),
    "restoreOnlyConfig": MessageLookupByLibrary.simpleMessage(
      "Воззтановіть только профілі",
    ),
    "restoreStrategy": MessageLookupByLibrary.simpleMessage(
      "Зтратегія воззтановленія",
    ),
    "restoreStrategyCompatible": MessageLookupByLibrary.simpleMessage(
      "Зовмезтімозть",
    ),
    "restoreStrategyOverride": MessageLookupByLibrary.simpleMessage(
      "Перезапізь",
    ),
    "restoreSuccess": MessageLookupByLibrary.simpleMessage(
      "Воззтановленіе выполнено",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("Повторить"),
    "routeAddress": MessageLookupByLibrary.simpleMessage("Адрезіа маршрутов"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage(
      "Назтроіть прозлушіваемые адрезіа маршрутов",
    ),
    "routeMode": MessageLookupByLibrary.simpleMessage("Режім маршрутізаціі"),
    "routeModeBypassPrivate": MessageLookupByLibrary.simpleMessage(
      "Обходіть чазтные адрезіа",
    ),
    "routeModeConfig": MessageLookupByLibrary.simpleMessage(
      "Вікорізтовуваті конфігурацію",
    ),
    "ru": MessageLookupByLibrary.simpleMessage("Російська"),
    "rule": MessageLookupByLibrary.simpleMessage("За правилами"),
    "ruleActionAndDesc": MessageLookupByLibrary.simpleMessage(
      "Логічезкое правіло AND",
    ),
    "ruleActionDirectBadge": MessageLookupByLibrary.simpleMessage("DIRECT"),
    "ruleActionDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть полный домен",
    ),
    "ruleActionDomainKeywordDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть ключевое злово в домене",
    ),
    "ruleActionDomainRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть по регулярному выраженію домена",
    ),
    "ruleActionDomainSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть зуффікз домена",
    ),
    "ruleActionDomainWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавленіе по мазке; поддержіваютзя только * і ?",
    ),
    "ruleActionDscpDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть метку DSCP (только для входящіх tproxy UDP)",
    ),
    "ruleActionDstPortDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть діапазон портов назначенія",
    ),
    "ruleActionGeoipDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть код зтраны IP-адрезіа",
    ),
    "ruleActionGeositeDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть домены із Geosite",
    ),
    "ruleActionInNameDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть ім\'я входящего подключенія",
    ),
    "ruleActionInPortDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть входящій порт",
    ),
    "ruleActionInTypeDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть тіп входящего подключенія",
    ),
    "ruleActionInUserDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть ім\'я корізтувача входящего подключенія; незколько імён разделяютзя /",
    ),
    "ruleActionIpAsnDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть ASN, квідорой прінадлежіт IP",
    ),
    "ruleActionIpCidr6Desc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть діапазон IP-адрезіов; IP-CIDR6 — прозто пзевдонім",
    ),
    "ruleActionIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть діапазон IP-адрезіов",
    ),
    "ruleActionIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть діапазон зуффікзов IP",
    ),
    "ruleActionMatchDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавляет взе запрозы, узловія не нужны",
    ),
    "ruleActionNetworkDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть TCP або UDP",
    ),
    "ruleActionNotDesc": MessageLookupByLibrary.simpleMessage(
      "Логічезкое правіло NOT",
    ),
    "ruleActionOrDesc": MessageLookupByLibrary.simpleMessage(
      "Логічезкое правіло OR",
    ),
    "ruleActionProcessNameDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть по імені процезза; на Android зовідветзтвует імені пакета",
    ),
    "ruleActionProcessNameRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть по регулярному выраженію імені процезза; на Android зовідветзтвует імені пакета",
    ),
    "ruleActionProcessNameWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть по мазке імені процезза; поддержіваютзя только * і ?",
    ),
    "ruleActionProcessPathDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть по полному путі процезза",
    ),
    "ruleActionProcessPathRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть по регулярному выраженію путі процезза",
    ),
    "ruleActionProcessPathWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть по мазке путі процезза; поддержіваютзя только * і ?",
    ),
    "ruleActionRematchNameDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть ім\'я повторного зопозтавленія; незколько імён разделяютзя /",
    ),
    "ruleActionRuleSetDesc": MessageLookupByLibrary.simpleMessage(
      "Позілання на набор правіл; требуетзя назтроіть rule-providers",
    ),
    "ruleActionSrcGeoipDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть код зтраны IP ізточніка",
    ),
    "ruleActionSrcIpAsnDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть ASN IP ізточніка",
    ),
    "ruleActionSrcIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть діапазон IP-адрезіов ізточніка",
    ),
    "ruleActionSrcIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть діапазон зуффікзов IP ізточніка",
    ),
    "ruleActionSrcPortDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть діапазон портов ізточніка",
    ),
    "ruleActionSubRuleDesc": MessageLookupByLibrary.simpleMessage(
      "Переход к подправілу; обратіте увага на зкобкі",
    ),
    "ruleActionUidDesc": MessageLookupByLibrary.simpleMessage(
      "Зопозтавіть Linux USER ID",
    ),
    "ruleAddedSuccess": MessageLookupByLibrary.simpleMessage(
      "Правіло узпішно добавлено",
    ),
    "ruleAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Такое правіло уже зущезтвует",
    ),
    "ruleApp": MessageLookupByLibrary.simpleMessage("Додаток"),
    "ruleContent": MessageLookupByLibrary.simpleMessage("Правіло"),
    "ruleDomain": MessageLookupByLibrary.simpleMessage("Домен"),
    "ruleDomainHint": MessageLookupByLibrary.simpleMessage(
      "example.com (DOMAIN-SUFFIX)",
    ),
    "ruleEmpty": MessageLookupByLibrary.simpleMessage("Правіло пузто"),
    "ruleInputEmpty": MessageLookupByLibrary.simpleMessage(
      "Поле ввода не может быть пузтым",
    ),
    "ruleName": MessageLookupByLibrary.simpleMessage("Названіе правіла"),
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
      "Локальная сеть напрямую",
    ),
    "rulePresetSystemServicesDirect": MessageLookupByLibrary.simpleMessage(
      "Apple и Microsoft напрямую",
    ),
    "ruleProcessHint": MessageLookupByLibrary.simpleMessage(
      "Ім\'я процезза або пакета (PROCESS-NAME)",
    ),
    "ruleProviders": MessageLookupByLibrary.simpleMessage("Провайдеры правил"),
    "ruleSelectAppTooltip": MessageLookupByLibrary.simpleMessage(
      "Вібраті додаток або процезз",
    ),
    "ruleSet": MessageLookupByLibrary.simpleMessage("Набор правіл"),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("Цель правіла"),
    "ruleTargetDirect": MessageLookupByLibrary.simpleMessage("DIRECT"),
    "ruleType": MessageLookupByLibrary.simpleMessage("Тіп"),
    "rules": MessageLookupByLibrary.simpleMessage("Правила"),
    "rulesCount": m48,
    "runTime": MessageLookupByLibrary.simpleMessage("Время работы"),
    "safeMode": MessageLookupByLibrary.simpleMessage("Безопасный режим"),
    "safeModeAppTitle": m49,
    "save": MessageLookupByLibrary.simpleMessage("Зберегти"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Зберегті ізмененія?"),
    "scanQrCode": MessageLookupByLibrary.simpleMessage("Сканувати QR-код"),
    "script": MessageLookupByLibrary.simpleMessage("Скрипт"),
    "scriptModeDesc": MessageLookupByLibrary.simpleMessage(
      "Режім зкріпта: ізпользует внешніе зкріпты-разшіренія для переопределенія конфігураціі в одін клік",
    ),
    "scrollToSelected": MessageLookupByLibrary.simpleMessage(
      "Прокрутіть к выбранному",
    ),
    "search": MessageLookupByLibrary.simpleMessage("Пошук"),
    "searchAppHint": MessageLookupByLibrary.simpleMessage(
      "Пошук додаткі або процезза...",
    ),
    "seconds": MessageLookupByLibrary.simpleMessage("зекунд"),
    "secondsCount": m50,
    "selectAll": MessageLookupByLibrary.simpleMessage("Вибрати все"),
    "selectAppTitle": MessageLookupByLibrary.simpleMessage(
      "Вібраті додаток / процезз",
    ),
    "selectMatchTarget": MessageLookupByLibrary.simpleMessage(
      "Вібраті MATCH-TARGET",
    ),
    "selectProxies": MessageLookupByLibrary.simpleMessage("Вібраті прокзі"),
    "selectProxyProviders": MessageLookupByLibrary.simpleMessage(
      "Вібраті провайдеров прокзі",
    ),
    "selectRuleSet": MessageLookupByLibrary.simpleMessage(
      "Выберіте набор правіл",
    ),
    "selectSplitStrategy": MessageLookupByLibrary.simpleMessage(
      "Выберіте зтратегію разпределенія",
    ),
    "selectSubRule": MessageLookupByLibrary.simpleMessage(
      "Выберіте подправіло",
    ),
    "selected": MessageLookupByLibrary.simpleMessage("Вібрано"),
    "selectedCountTitle": m51,
    "server": MessageLookupByLibrary.simpleMessage("Сервер"),
    "serverNotRespondingReconnecting": MessageLookupByLibrary.simpleMessage(
      "Сервер перестав відповідати. Перепідключення...",
    ),
    "serverStatus": MessageLookupByLibrary.simpleMessage("Зтан зерверів"),
    "serverStatusDesc": MessageLookupByLibrary.simpleMessage(
      "Моніторінг дозтупнозті зерверів",
    ),
    "serviceAvailable": MessageLookupByLibrary.simpleMessage("Доступен"),
    "serviceBlocked": MessageLookupByLibrary.simpleMessage("Заблокировано"),
    "serviceCheck": MessageLookupByLibrary.simpleMessage("Проверить"),
    "serviceCheckAll": MessageLookupByLibrary.simpleMessage("Проверить все"),
    "serviceCheckedAt": m52,
    "serviceComingSoon": MessageLookupByLibrary.simpleMessage("Скоро появится"),
    "serviceDisallowedIsp": MessageLookupByLibrary.simpleMessage(
      "Недопустимый провайдер",
    ),
    "serviceFailed": MessageLookupByLibrary.simpleMessage("Ошибка проверки"),
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
    "settings": MessageLookupByLibrary.simpleMessage("Налаштування"),
    "show": MessageLookupByLibrary.simpleMessage("Показаті"),
    "showLess": MessageLookupByLibrary.simpleMessage("Згорнуті"),
    "showMore": MessageLookupByLibrary.simpleMessage("Розгорнуті"),
    "showNotificationStopAction": MessageLookupByLibrary.simpleMessage(
      "Кнопка озтановкі в уведомленіі",
    ),
    "showNotificationStopActionDesc": MessageLookupByLibrary.simpleMessage(
      "Показывать кнопку озтановкі в позтоянном уведомленіі. Відключіте, езлі із-за неё зізтема взегда разворачівает зповіщення",
    ),
    "showPassword": MessageLookupByLibrary.simpleMessage("Показаті пароль"),
    "shrink": MessageLookupByLibrary.simpleMessage("Компактний"),
    "sidebarBlur": MessageLookupByLibrary.simpleMessage(
      "Размытие боковой панели",
    ),
    "sidebarBlurDesc": MessageLookupByLibrary.simpleMessage(
      "Показывать сквозь боковую панель размытый рабочий стол за окном",
    ),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("Тіхій запузк"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Запускати у фоновому режимі без показу вікна",
    ),
    "singleAdd": MessageLookupByLibrary.simpleMessage("По одному"),
    "singleValueTip": m53,
    "size": MessageLookupByLibrary.simpleMessage("Розмір"),
    "slide": MessageLookupByLibrary.simpleMessage("Сдвиг"),
    "socksPort": MessageLookupByLibrary.simpleMessage("Порт SOCKS"),
    "sort": MessageLookupByLibrary.simpleMessage("Сортування"),
    "source": MessageLookupByLibrary.simpleMessage("Ізточнік"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("IP ізточніка"),
    "specialProxy": MessageLookupByLibrary.simpleMessage("Зпеціальный прокзі"),
    "specialRules": MessageLookupByLibrary.simpleMessage("Зпеціальные правіла"),
    "speedStatistics": MessageLookupByLibrary.simpleMessage(
      "Зтатізтіка зкорозті",
    ),
    "speedtest": MessageLookupByLibrary.simpleMessage("Тезт швідкозті"),
    "speedtestCompleted": MessageLookupByLibrary.simpleMessage(
      "Тезт узпішно завершён",
    ),
    "speedtestDesc": MessageLookupByLibrary.simpleMessage(
      "Перевірте швідкізть вашої мережі",
    ),
    "speedtestDisclaimer": MessageLookupByLibrary.simpleMessage(
      "Перевірка швидкості виконується через сторонні сервіси. Реальна швидкість може відрізнятися або бути виміряна неточно.",
    ),
    "speedtestDownload": MessageLookupByLibrary.simpleMessage("Завантаження"),
    "speedtestError": MessageLookupByLibrary.simpleMessage(
      "Помілка з\'єднання",
    ),
    "speedtestGaugeUnit": MessageLookupByLibrary.simpleMessage("МБІТ/З"),
    "speedtestNoDataError": MessageLookupByLibrary.simpleMessage(
      "Не вдалося виміряти швидкість: немає відповіді від сервера",
    ),
    "speedtestPing": MessageLookupByLibrary.simpleMessage("Пінг"),
    "speedtestRunAgain": MessageLookupByLibrary.simpleMessage(
      "Ізмеріть ещё раз",
    ),
    "speedtestStart": MessageLookupByLibrary.simpleMessage("Запузтіть тезт"),
    "speedtestStop": MessageLookupByLibrary.simpleMessage("Озтановіть"),
    "speedtestTestingDownload": MessageLookupByLibrary.simpleMessage(
      "Завантаження (Download)...",
    ),
    "speedtestTestingPing": MessageLookupByLibrary.simpleMessage(
      "Ізмереніе затрімкі (Ping)...",
    ),
    "speedtestTestingUpload": MessageLookupByLibrary.simpleMessage(
      "Віддача (Upload)...",
    ),
    "speedtestUnitMbps": MessageLookupByLibrary.simpleMessage("Мбіт/з"),
    "speedtestUnitMs": MessageLookupByLibrary.simpleMessage("мз"),
    "speedtestUpload": MessageLookupByLibrary.simpleMessage("Віддача"),
    "splitStrategy": MessageLookupByLibrary.simpleMessage(
      "Зтратегія разпределенія",
    ),
    "splitStrategyNotEmpty": MessageLookupByLibrary.simpleMessage(
      "Зтратегія разпределенія не может быть пузтой",
    ),
    "ssidsEmpty": MessageLookupByLibrary.simpleMessage("Зпізок SSID пузт"),
    "stackMode": MessageLookupByLibrary.simpleMessage("Режім зтека"),
    "standard": MessageLookupByLibrary.simpleMessage("Зтандартный"),
    "standardModeDesc": MessageLookupByLibrary.simpleMessage(
      "Зтандартный режім: переопределяет базовую конфігурацію і позволяет прозто добавлять правіла",
    ),
    "start": MessageLookupByLibrary.simpleMessage("Підключити"),
    "startFromScratch": MessageLookupByLibrary.simpleMessage("С нуля"),
    "startVpn": MessageLookupByLibrary.simpleMessage("Запустити VPN"),
    "startupAndBackground": MessageLookupByLibrary.simpleMessage(
      "Запуск и фоновая работа",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Стан"),
    "statusActive": MessageLookupByLibrary.simpleMessage("Актівен"),
    "statusAllAvailable": m54,
    "statusAllDown": MessageLookupByLibrary.simpleMessage("Зервері недозтупны"),
    "statusAllDownDesc": MessageLookupByLibrary.simpleMessage(
      "Взе моніторы зообщают об ошібке",
    ),
    "statusAllSystemsOperational": MessageLookupByLibrary.simpleMessage(
      "Взе зізтемы рабвідают нормально",
    ),
    "statusAllSystemsOperationalDesc": MessageLookupByLibrary.simpleMessage(
      "Взе зервері в зтатузе «Дозтупен»",
    ),
    "statusCheckHistory": MessageLookupByLibrary.simpleMessage(
      "Ізторія проверок",
    ),
    "statusChecking": MessageLookupByLibrary.simpleMessage(
      "Перевірка зерверов...",
    ),
    "statusDesc": MessageLookupByLibrary.simpleMessage(
      "Прі відключеніі ізпользуетзя зізтемній DNS",
    ),
    "statusDown": MessageLookupByLibrary.simpleMessage("Недозтупен"),
    "statusExpired": MessageLookupByLibrary.simpleMessage("Закінчівзяла"),
    "statusMonitors": MessageLookupByLibrary.simpleMessage("// МОНІТОРЫ"),
    "statusNoMonitors": MessageLookupByLibrary.simpleMessage(
      "Ні даніх о моніторах",
    ),
    "statusOperational": MessageLookupByLibrary.simpleMessage("Дозтупен"),
    "statusPartialOutages": MessageLookupByLibrary.simpleMessage(
      "Чазтічные проблемы",
    ),
    "statusPartialOutagesDesc": m55,
    "statusUpdated": MessageLookupByLibrary.simpleMessage("Обновлено"),
    "stop": MessageLookupByLibrary.simpleMessage("Відключити"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("Зупинити VPN"),
    "strategy": MessageLookupByLibrary.simpleMessage("Стратегия"),
    "streakActiveToday": MessageLookupByLibrary.simpleMessage(
      "Вогник палає! Підключення сьогодні виконано.",
    ),
    "streakDaysCount": m56,
    "streakFlameTitle": MessageLookupByLibrary.simpleMessage("Вогняний стрік"),
    "streakInactiveToday": MessageLookupByLibrary.simpleMessage(
      "Вогник згас. Підключіться до 00:00 МСК, щоб запалити його!",
    ),
    "streakMilestoneCongrats": m57,
    "streakNoRestoresLeft": MessageLookupByLibrary.simpleMessage(
      "Ліміт відновлень на цей місяць вичерпано (максимум 3).",
    ),
    "streakNotificationBody": m58,
    "streakNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "🔥 Вогник скоро згасне!",
    ),
    "streakRestoreButton": MessageLookupByLibrary.simpleMessage(
      "Відновити вогник",
    ),
    "streakRestoredSuccess": MessageLookupByLibrary.simpleMessage(
      "Вогник успішно відновлено!",
    ),
    "streakRestoresLeft": m59,
    "streakRuleRestore": MessageLookupByLibrary.simpleMessage(
      "• За один календарний місяць стрік можна відновити до 3 разів у разі пропуску дня.",
    ),
    "streakRuleStorage": MessageLookupByLibrary.simpleMessage(
      "• Вогник зберігається локально на вашому пристрої і видалиться лише при видаленні застосунку.",
    ),
    "streakRuleTime": MessageLookupByLibrary.simpleMessage(
      "• Вогник оновлюється щодня о 00:00 за МСК (12:00 AM UTC+3).",
    ),
    "streakRuleTitle": MessageLookupByLibrary.simpleMessage(
      "Правила вогняного стріку",
    ),
    "style": MessageLookupByLibrary.simpleMessage("Зтіль"),
    "subExpireReminder1d": MessageLookupByLibrary.simpleMessage(
      "Озталзя 1 день. Езлі вы уже продлабо, то обновіте підпізку.",
    ),
    "subExpireReminder1h": MessageLookupByLibrary.simpleMessage(
      "Озталзя 1 чаз. Езлі вы уже продлабо, то обновіте підпізку.",
    ),
    "subExpireReminder3d": MessageLookupByLibrary.simpleMessage(
      "Залішілозя 3 дня. Езлі вы уже продлабо, то обновіте підпізку.",
    ),
    "subExpiredNotice": MessageLookupByLibrary.simpleMessage(
      "Зрок дії вашей підпізкі ізтёк. Езлі вы уже продлабо, то обновіте підпізку.",
    ),
    "subExpiredTitle": MessageLookupByLibrary.simpleMessage(
      "Підписка закінчилася",
    ),
    "subExpiringTitle": MessageLookupByLibrary.simpleMessage(
      "Підпізка зкоро закончітзя",
    ),
    "subRule": MessageLookupByLibrary.simpleMessage("Подправіло"),
    "subRuleEmpty": MessageLookupByLibrary.simpleMessage("Подправіло пузто"),
    "subRuleNotEmpty": MessageLookupByLibrary.simpleMessage(
      "Подправіло не может быть пузтым",
    ),
    "submit": MessageLookupByLibrary.simpleMessage("Відправіть"),
    "subscriptionActivating": MessageLookupByLibrary.simpleMessage(
      "Активація підписки...",
    ),
    "subscriptionExpiredDesc": MessageLookupByLibrary.simpleMessage(
      "Термін дії вашої підписки закінчився. Будь ласка, продовжіть її для відновлення доступу",
    ),
    "subscriptionExpiredWarning": MessageLookupByLibrary.simpleMessage(
      "Термін дії підписки закінчився",
    ),
    "subscriptionExpiringIn": m60,
    "subscriptionFoundInClipboard": MessageLookupByLibrary.simpleMessage(
      "Найдена підпізка в буфере обмена",
    ),
    "subscriptionFromClipboardHint": MessageLookupByLibrary.simpleMessage(
      "Із буфера обмена, по ззылке або QR-коду",
    ),
    "subscriptionInactive": MessageLookupByLibrary.simpleMessage(
      "Підписка неактивна",
    ),
    "subscriptionInfo": MessageLookupByLibrary.simpleMessage("Дані підписки"),
    "subscriptionInvalidOrEmpty": MessageLookupByLibrary.simpleMessage(
      "Некоректне або порожнє посилання",
    ),
    "subscriptionNoChanges": MessageLookupByLibrary.simpleMessage("Змін немає"),
    "subscriptionRequired": MessageLookupByLibrary.simpleMessage(
      "Потрібна підписка",
    ),
    "subscriptionRequiredDesc": MessageLookupByLibrary.simpleMessage(
      "Для користування сервісом додайте посилання на вашу підписку",
    ),
    "subscriptionUpdated": MessageLookupByLibrary.simpleMessage(
      "Підписку оновлено",
    ),
    "supportEmail": MessageLookupByLibrary.simpleMessage("Электронная почта"),
    "supportLieVpn": MessageLookupByLibrary.simpleMessage("Підтрімка LieVPN"),
    "supportLieVpnTitle": MessageLookupByLibrary.simpleMessage(
      "Злужба поддержкі LieVPN",
    ),
    "supportMessengerMax": MessageLookupByLibrary.simpleMessage(
      "Меззенджер MAX",
    ),
    "supportMessengerMaxSubtitle": MessageLookupByLibrary.simpleMessage(
      "Напізать в MAX",
    ),
    "supportProject": MessageLookupByLibrary.simpleMessage("Поддержать проект"),
    "suspended": MessageLookupByLibrary.simpleMessage("Пріозтановлено..."),
    "switchProfile": MessageLookupByLibrary.simpleMessage("Сменить профиль"),
    "sync": MessageLookupByLibrary.simpleMessage("Зінхронізація"),
    "system": MessageLookupByLibrary.simpleMessage("Зізтема"),
    "systemApp": MessageLookupByLibrary.simpleMessage("Зізтемні додаткі"),
    "systemProxy": MessageLookupByLibrary.simpleMessage("Системний проксі"),
    "systemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Встановити системний HTTP/SOCKS проксі",
    ),
    "tab": MessageLookupByLibrary.simpleMessage("Вкладкі"),
    "tabAnimation": MessageLookupByLibrary.simpleMessage("Анімація вкладок"),
    "tabAnimationDesc": MessageLookupByLibrary.simpleMessage(
      "Дейзтвует только в мобільном віде",
    ),
    "tapToAuthorize": MessageLookupByLibrary.simpleMessage(
      "Нажміте, чтобы разрешіть",
    ),
    "tapToInsertSubscription": MessageLookupByLibrary.simpleMessage(
      "Нажміте, чтобы взтавіті підпізку",
    ),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage("Паралельний TCP"),
    "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage(
      "Прі включеніі разрешает параллельные TCP-подключенія",
    ),
    "testInterval": MessageLookupByLibrary.simpleMessage(
      "Інтервал тезтірованія",
    ),
    "testUrl": MessageLookupByLibrary.simpleMessage(
      "URL для перевірки затримки",
    ),
    "testWhenUsed": MessageLookupByLibrary.simpleMessage(
      "Тезтіровать прі ізпользованіі",
    ),
    "textScale": MessageLookupByLibrary.simpleMessage("Мазштаб текзта"),
    "textScalePreview": MessageLookupByLibrary.simpleMessage(
      "Так будет выглядеть текст в приложении",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Тема"),
    "themeColor": MessageLookupByLibrary.simpleMessage("Колір теми"),
    "themeDesc": MessageLookupByLibrary.simpleMessage(
      "Налаштування зовнішнього вигляду",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Режим теми"),
    "tight": MessageLookupByLibrary.simpleMessage("Плвідный"),
    "time": MessageLookupByLibrary.simpleMessage("Чаз"),
    "timeout": MessageLookupByLibrary.simpleMessage("Тайм-аут"),
    "tip": MessageLookupByLibrary.simpleMessage("Підказка"),
    "toggle": MessageLookupByLibrary.simpleMessage("Переключіть"),
    "toggleLabel": MessageLookupByLibrary.simpleMessage("Переключіть подпізі"),
    "tolerance": MessageLookupByLibrary.simpleMessage("Допуск"),
    "tonalSpotScheme": MessageLookupByLibrary.simpleMessage("Тональный акцент"),
    "tools": MessageLookupByLibrary.simpleMessage("Інструменти"),
    "torch": MessageLookupByLibrary.simpleMessage("Фонарік"),
    "total": MessageLookupByLibrary.simpleMessage("Всего"),
    "totalTraffic": MessageLookupByLibrary.simpleMessage("Загальній трафік"),
    "tproxyPort": MessageLookupByLibrary.simpleMessage("Порт TProxy"),
    "trafficUsage": MessageLookupByLibrary.simpleMessage(
      "Використання трафіку",
    ),
    "tsarOfDonations": MessageLookupByLibrary.simpleMessage("Цар Донату"),
    "tt": MessageLookupByLibrary.simpleMessage("ТікТок / Мемы ⚡"),
    "tun": MessageLookupByLibrary.simpleMessage("Режим TUN"),
    "tunDesc": MessageLookupByLibrary.simpleMessage(
      "Перехоплення всього системного трафіку",
    ),
    "turnOff": MessageLookupByLibrary.simpleMessage("Вімкнуті"),
    "turnOn": MessageLookupByLibrary.simpleMessage("Увімкнуті"),
    "uk": MessageLookupByLibrary.simpleMessage("Українзька"),
    "undo": MessageLookupByLibrary.simpleMessage("Відменіть"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage("Едіная затрімка"),
    "unifiedDelayDesc": MessageLookupByLibrary.simpleMessage(
      "Убірает лішніе затрімкі, напрімер рукопожатіе",
    ),
    "unknown": MessageLookupByLibrary.simpleMessage("Невідомо"),
    "unknownNetworkError": MessageLookupByLibrary.simpleMessage(
      "Невідома помілка мережі",
    ),
    "unlimited": MessageLookupByLibrary.simpleMessage("Безлімітно"),
    "unmaximize": MessageLookupByLibrary.simpleMessage("Згорнуті в окно"),
    "unnamed": MessageLookupByLibrary.simpleMessage("Без названія"),
    "unpinWindow": MessageLookupByLibrary.simpleMessage("Відкрепіть окно"),
    "update": MessageLookupByLibrary.simpleMessage("Оновити"),
    "updateCheckError": MessageLookupByLibrary.simpleMessage(
      "Не удалозь перевіріті оновлення",
    ),
    "updateLater": MessageLookupByLibrary.simpleMessage("Позже"),
    "updateNow": MessageLookupByLibrary.simpleMessage("Оновіті"),
    "updateSubscription": MessageLookupByLibrary.simpleMessage(
      "Оновіті підпізку",
    ),
    "upload": MessageLookupByLibrary.simpleMessage("Відвантаження"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage("Получіть профіль по URL"),
    "urlTip": m61,
    "useHosts": MessageLookupByLibrary.simpleMessage("Вікорізтовуваті hosts"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage(
      "Вікорізтовуваті зізтемній hosts",
    ),
    "usedTraffic": MessageLookupByLibrary.simpleMessage("Використано"),
    "userAgent": MessageLookupByLibrary.simpleMessage("User-Agent"),
    "userProfileHeader": MessageLookupByLibrary.simpleMessage(
      "// ПОЛЬЗОВАТЕЛЬ",
    ),
    "value": MessageLookupByLibrary.simpleMessage("Значеніе"),
    "vibrantScheme": MessageLookupByLibrary.simpleMessage("Яркая"),
    "view": MessageLookupByLibrary.simpleMessage("Прозмвідр"),
    "vpnConfigChangeDetected": MessageLookupByLibrary.simpleMessage(
      "Обнаружено ізмененіе назтроек VPN",
    ),
    "vpnConnected": MessageLookupByLibrary.simpleMessage("VPN подключён"),
    "vpnDisconnected": MessageLookupByLibrary.simpleMessage("VPN відключён"),
    "vpnEnableDesc": MessageLookupByLibrary.simpleMessage(
      "Автоматічно направляет везь зізтемній трафік через VpnService",
    ),
    "vpnTip": MessageLookupByLibrary.simpleMessage(
      "Ізмененія взтупят в зілу позле перезапузка VPN",
    ),
    "webDAVConfiguration": MessageLookupByLibrary.simpleMessage(
      "Налаштування WebDAV",
    ),
    "whitelistMode": MessageLookupByLibrary.simpleMessage(
      "Режім белого зпізка",
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
