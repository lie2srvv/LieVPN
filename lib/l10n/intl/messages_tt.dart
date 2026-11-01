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

  static String m0(code) =>
      "Windows отказалась запускать LieVPNCore.exe (кринж ${code}). Политики контроля приложений, такие как Smart App Control или AppLocker, блокируют неподписанные программы; разрешите LieVPN в этой политике или отключите её и повторите попытку.";

  static String m1(name) =>
      "Приложуха два раза подряд не смогло завершить запуск. Чтобы разорвать цикл, конфиг ${name} снят с выбора, а автоматическая подкрутка пропущена. Вы можете зацепить его снова в любой момент.";

  static String m2(url) => "Создать конфиг по ссылке ${url}?";

  static String m3(count) =>
      "${Intl.plural(count, one: '${count} день назад', few: '${count} дня назад', many: '${count} дней назад', other: '${count} дня назад')}";

  static String m4(label) =>
      "Вы уверены, что хотите дропнуть выбранные элементы (${label})?";

  static String m5(label) => "Вы уверены, что хотите дропнуть «${label}»?";

  static String m6(label) => "Сведения: ${label}";

  static String m7(label) => "Пустоту отправлять — не вариант";

  static String m8(count) =>
      "${Intl.plural(count, one: '${count} запись', few: '${count} записи', many: '${count} записей', other: '${count} записи')}";

  static String m9(label) => "«${label}» уже существует";

  static String m10(name) => "${name}: уже последняя версия";

  static String m11(name) => "${name}: обновлено";

  static String m12(count) =>
      "${Intl.plural(count, one: '${count} час назад', few: '${count} часа назад', many: '${count} часов назад', other: '${count} часа назад')}";

  static String m13(count) =>
      "${Intl.plural(count, one: '${count} час', few: '${count} часа', many: '${count} часов', other: '${count} часа')}";

  static String m14(target) => "${target} — недопустимая политика";

  static String m15(proxyName) => "${proxyName} — недопустимый прокси";

  static String m16(providerName) =>
      "${providerName} — недопустимый провайдер прокси";

  static String m17(subRule) => "${subRule} — недопустимый SUB_RULE";

  static String m18(appName) =>
      "1. Откройте Системные подкрутки > Конфиденциальность и безопасность\n2. Выберите Службы геолокации\n3. Найдите и отметьте ${appName} в списке\n\nПосле подкрутки вернитесь в приложуха и продолжайте работу. Спасибо за сотрудничество.";

  static String m19(label, max) => "«${label}» — не более ${max} символов";

  static String m20(count) =>
      "${Intl.plural(count, one: '${count} минуту назад', few: '${count} минуты назад', many: '${count} минут назад', other: '${count} минуты назад')}";

  static String m21(count) =>
      "${Intl.plural(count, one: '${count} месяц назад', few: '${count} месяца назад', many: '${count} месяцев назад', other: '${count} месяца назад')}";

  static String m22(version) => "Доступно апдейт ${version}";

  static String m23(label) => "Пока нет: ${label}";

  static String m24(label) => "Значение «${label}» должно быть числом";

  static String m25(label) =>
      "Значение «${label}» должно быть от 1024 до 49151";

  static String m26(count) => "${count} прокси";

  static String m27(count) =>
      "${Intl.plural(count, one: '${count} понятие', few: '${count} понятия', many: '${count} правил', other: '${count} понятия')}";

  static String m28(count) =>
      "${Intl.plural(count, one: '${count} секунда', few: '${count} секунды', many: '${count} секунд', other: '${count} секунды')}";

  static String m29(count) => "Взято: ${count}";

  static String m30(count) => "Все сервакы доступны (${count})";

  static String m31(up, total) => "Работают ${up} из ${total}";

  static String m32(count) =>
      "${Intl.plural(count, one: '${count} день', few: '${count} дня', many: '${count} дней', other: '${count} дней')}";

  static String m33(count) =>
      "Лютейший флекс! ${count} дней подряд на кондициях!";

  static String m34(count) =>
      "Ты сегодня ещё не врубал LieVPN. Залетай до 00:00 МСК на кондициях, а то стрик в ${count} дн. сгорит к чертям!";

  static String m35(count) => "Осталось ресов в этом месяце: ${count} из 3";

  static String m36(time) => "Сабке жить осталось жить ${time}";

  static String m37(label) => "Закинь нормальный валидный URL";

  static String m38(count) =>
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
    "actionMode": MessageLookupByLibrary.simpleMessage("Переключить режим"),
    "actionProxy": MessageLookupByLibrary.simpleMessage("Системный прокси"),
    "actionStart": MessageLookupByLibrary.simpleMessage("Старт/Стоп"),
    "actionTun": MessageLookupByLibrary.simpleMessage("TUN"),
    "actionView": MessageLookupByLibrary.simpleMessage("Показать/Скрыть"),
    "add": MessageLookupByLibrary.simpleMessage("Залутать новое"),
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
    "app": MessageLookupByLibrary.simpleMessage("Приложуха"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage(
      "Контроль доступа приложений",
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
    "backupSuccess": MessageLookupByLibrary.simpleMessage(
      "Резервная копия создана",
    ),
    "basicConfig": MessageLookupByLibrary.simpleMessage("Базовая конфигурация"),
    "basicConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Глобальное изменение базовой конфигурации",
    ),
    "basicInfo": MessageLookupByLibrary.simpleMessage("Основная инфа"),
    "basicStrategy": MessageLookupByLibrary.simpleMessage("Базовые политики"),
    "batteryOptimizationDesc": MessageLookupByLibrary.simpleMessage(
      "Чтобы приложуха работало в фоне, отключите для него оптимизацию батареи. Нажмите, чтобы перейти к подкруткам.",
    ),
    "batteryOptimizationStatusTip": MessageLookupByLibrary.simpleMessage(
      "Из-за системных ограничений во время работы невозможно корректно получить статус оптимизации батареи",
    ),
    "be": MessageLookupByLibrary.simpleMessage("Беларуская"),
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
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "Кэш повреждён. Стереть его?",
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
      "Вы уверены, что хотите закрыть тему текущее окно?",
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
    "coreBlockedByPolicyTip": m0,
    "coreBlockedBySmartAppControlTip": MessageLookupByLibrary.simpleMessage(
      "Smart App Control в Windows заблокировал неподписанный LieVPNCore.exe. Откройте Безопасность Windows → Управление приложухими и браузером → Параметры Smart App Control, выберите «Выкл.» и снова запустите LieVPN. Повторно подрубить Smart App Control без переустановки Windows нельзя.",
    ),
    "coreStatus": MessageLookupByLibrary.simpleMessage("Статус ядра"),
    "country": MessageLookupByLibrary.simpleMessage("Регион"),
    "crashDetected": MessageLookupByLibrary.simpleMessage("Обнаружен сбой"),
    "crashDetectedTip": m1,
    "crashTest": MessageLookupByLibrary.simpleMessage("Тест сбоя"),
    "crashlytics": MessageLookupByLibrary.simpleMessage("Аналитика сбоев"),
    "crashlyticsTip": MessageLookupByLibrary.simpleMessage(
      "При включении в случае сбоя приложухи на автомате загружаются логи сбоя без конфиденциальной информации",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Создать"),
    "createProfile": MessageLookupByLibrary.simpleMessage("Создать конфиг"),
    "createProfileFromUrlTip": m2,
    "creationTime": MessageLookupByLibrary.simpleMessage("Время создания"),
    "custom": MessageLookupByLibrary.simpleMessage("Вручную"),
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
    "daysAgo": m3,
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
    "deleteMultipTip": m4,
    "deleteTip": m5,
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
    "details": m6,
    "detectionTip": MessageLookupByLibrary.simpleMessage(
      "Использует сторонний API; только для справки",
    ),
    "developerMode": MessageLookupByLibrary.simpleMessage(
      "Режим гигачада-кодера",
    ),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "Режим разработчика включён.",
    ),
    "direct": MessageLookupByLibrary.simpleMessage("Напрямую (DIRECT)"),
    "disableUDP": MessageLookupByLibrary.simpleMessage("Потушить UDP"),
    "disclaimer": MessageLookupByLibrary.simpleMessage("Базовый дисклеймер"),
    "disclaimerDesc": MessageLookupByLibrary.simpleMessage(
      "Базовый минимум и роскошный максимум: смажьте мясо саслом и соблюдайте понятия",
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
    "emptyTip": m7,
    "en": MessageLookupByLibrary.simpleMessage("English"),
    "enterSubscriptionUrl": MessageLookupByLibrary.simpleMessage(
      "Закинь линк сюда",
    ),
    "entries": MessageLookupByLibrary.simpleMessage(" записей"),
    "entriesCount": m8,
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
    "existsTip": m9,
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
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Фильтр Fake-IP"),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Диапазон Fake-IP"),
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
    "findProcessMode": MessageLookupByLibrary.simpleMessage("Искать процесса"),
    "findProcessModeDesc": MessageLookupByLibrary.simpleMessage(
      "При включении возможна небольшая потеря производительности",
    ),
    "followProfile": MessageLookupByLibrary.simpleMessage("Как в профиле"),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Шрифт интерфейса"),
    "forceRestartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите принудительно перезапустить ядро?",
    ),
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
    "geoSkipped": m10,
    "geoUpdated": m11,
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
    "hidePassword": MessageLookupByLibrary.simpleMessage("Скрыть пароль"),
    "host": MessageLookupByLibrary.simpleMessage("Хост"),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("Добавить записи hosts"),
    "hotkeyConflict": MessageLookupByLibrary.simpleMessage(
      "Конфликт горячих клавиш",
    ),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage("Горячие клавиши"),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "Управление приложухам с клавиатуры",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("часов"),
    "hoursAgo": m12,
    "hoursCount": m13,
    "icon": MessageLookupByLibrary.simpleMessage("Значок"),
    "iconRecords": MessageLookupByLibrary.simpleMessage("История значков"),
    "iconStyle": MessageLookupByLibrary.simpleMessage("Стиль значков"),
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
    "invalidPolicy": m14,
    "invalidProxy": m15,
    "invalidProxyProvider": m16,
    "invalidSubRule": m17,
    "ipcidr": MessageLookupByLibrary.simpleMessage("IP/CIDR"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage(
      "Врубить поддержку IPv6 трафика",
    ),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешить входящий IPv6",
    ),
    "ja": MessageLookupByLibrary.simpleMessage("日本語"),
    "justNow": MessageLookupByLibrary.simpleMessage("Только что"),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "Интервал TCP keep-alive",
    ),
    "key": MessageLookupByLibrary.simpleMessage("Ключ"),
    "kk": MessageLookupByLibrary.simpleMessage("Қазақша"),
    "ko": MessageLookupByLibrary.simpleMessage("한국어"),
    "language": MessageLookupByLibrary.simpleMessage("Языковой вайб"),
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
    "list": MessageLookupByLibrary.simpleMessage("Список"),
    "listen": MessageLookupByLibrary.simpleMessage("Прослушивание"),
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
    "locationPermission": MessageLookupByLibrary.simpleMessage(
      "Разрешение на геолокацию",
    ),
    "locationPermissionDeniedMessage": MessageLookupByLibrary.simpleMessage(
      "Разрешение на геолокацию отклонено, поэтому невозможно получить ник текущей сети Wi-Fi. Включите разрешение на геолокацию вручную в системных подкрутках.",
    ),
    "locationPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "По требованию системы для получения имени сети Wi-Fi необходимо разрешение на геолокацию. На Android выберите «Разрешить всегда», иначе ник сети Wi-Fi нельзя получить, пока приложуха в фоне.",
    ),
    "locationPermissionGuide": m18,
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
    "maxLengthTip": m19,
    "maximize": MessageLookupByLibrary.simpleMessage(
      "Развернуть на весь экран",
    ),
    "memoryInfo": MessageLookupByLibrary.simpleMessage("Память"),
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
    "minutesAgo": m20,
    "mixedPort": MessageLookupByLibrary.simpleMessage("Микс-порт"),
    "mode": MessageLookupByLibrary.simpleMessage("Режим работы"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("Монохром"),
    "monthsAgo": m21,
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
    "network": MessageLookupByLibrary.simpleMessage("Паутина"),
    "networkDesc": MessageLookupByLibrary.simpleMessage(
      "Подкрутки, связанные с паутинаю",
    ),
    "networkDetection": MessageLookupByLibrary.simpleMessage("Чек пинга"),
    "networkException": MessageLookupByLibrary.simpleMessage(
      "Ситаусьон! Паутина поймала кринж",
    ),
    "networkSpeed": MessageLookupByLibrary.simpleMessage("Турбо-скорость"),
    "networkType": MessageLookupByLibrary.simpleMessage("Тип сети"),
    "neutralScheme": MessageLookupByLibrary.simpleMessage("Нейтральная"),
    "newVersionAvailable": m22,
    "nextMatch": MessageLookupByLibrary.simpleMessage("Следующее совпадение"),
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
    "noSubscriptionFound": MessageLookupByLibrary.simpleMessage(
      "Сабка не добавлена",
    ),
    "none": MessageLookupByLibrary.simpleMessage("Нет"),
    "notLieVpnSubscription": MessageLookupByLibrary.simpleMessage(
      "Это не LieVPN, не по масти",
    ),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "Текущую группу прокси нельзя зацепить",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Конфигов нет, ты в тильте",
    ),
    "nullTip": m23,
    "numberTip": m24,
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
    "outboundMode": MessageLookupByLibrary.simpleMessage("Траектория трафика"),
    "override": MessageLookupByLibrary.simpleMessage("Оверрайд / Моггинг"),
    "overrideDns": MessageLookupByLibrary.simpleMessage("Переопределить DNS"),
    "overrideDnsDesc": MessageLookupByLibrary.simpleMessage(
      "При включении подкрутки DNS профиля переопределяются",
    ),
    "overrideMode": MessageLookupByLibrary.simpleMessage(
      "Режим переопределения",
    ),
    "overrideScript": MessageLookupByLibrary.simpleMessage(
      "Скрипт переопределения",
    ),
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
    "portTip": m25,
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
    "providers": MessageLookupByLibrary.simpleMessage("Внешние ресурсы"),
    "proxies": MessageLookupByLibrary.simpleMessage("Серваки"),
    "proxiesCount": m26,
    "proxiesEmpty": MessageLookupByLibrary.simpleMessage("Список прокси пуст"),
    "proxyChains": MessageLookupByLibrary.simpleMessage("Цепочка прокси"),
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
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("Чисто чёрный режим"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QR-код"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage(
      "Сканируйте QR-код, чтобы получить конфиг",
    ),
    "quickFill": MessageLookupByLibrary.simpleMessage("Быстрое заполнение"),
    "rainbowScheme": MessageLookupByLibrary.simpleMessage("Радуга"),
    "readyToTest": MessageLookupByLibrary.simpleMessage("Готов к тестированию"),
    "redirPort": MessageLookupByLibrary.simpleMessage("Порт Redir"),
    "redo": MessageLookupByLibrary.simpleMessage("Повторить"),
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
    "request": MessageLookupByLibrary.simpleMessage("Запрос"),
    "requests": MessageLookupByLibrary.simpleMessage("Поток Яппинга"),
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
    "ruleProcessHint": MessageLookupByLibrary.simpleMessage(
      "Ник процесса или пакета (PROCESS-NAME)",
    ),
    "ruleSelectAppTooltip": MessageLookupByLibrary.simpleMessage(
      "Зацепить приложуха или процесс",
    ),
    "ruleSet": MessageLookupByLibrary.simpleMessage("Набор правил"),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("Цель понятия"),
    "ruleTargetDirect": MessageLookupByLibrary.simpleMessage("DIRECT"),
    "ruleType": MessageLookupByLibrary.simpleMessage("Тип"),
    "rules": MessageLookupByLibrary.simpleMessage("Понятия (База)"),
    "rulesCount": m27,
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
    "secondsCount": m28,
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
    "selectedCountTitle": m29,
    "serverNotRespondingReconnecting": MessageLookupByLibrary.simpleMessage(
      "Сервак откинулся. Переподрубаем суету...",
    ),
    "serverStatus": MessageLookupByLibrary.simpleMessage("Радар Чечиков"),
    "serverStatusDesc": MessageLookupByLibrary.simpleMessage(
      "Кто тут масик, а кто тюбик",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Тюнинг софтины"),
    "show": MessageLookupByLibrary.simpleMessage("Показать"),
    "showLess": MessageLookupByLibrary.simpleMessage("Свернуть в карман"),
    "showMore": MessageLookupByLibrary.simpleMessage(
      "Развернуть на весь экран",
    ),
    "showNotificationStopAction": MessageLookupByLibrary.simpleMessage(
      "Кнопка остановки в уведомлении",
    ),
    "showNotificationStopActionDesc": MessageLookupByLibrary.simpleMessage(
      "Показывать кнопку остановки в постоянном уведомлении. Отключите, если из-за неё система всегда разворачивает уведомлялка",
    ),
    "showPassword": MessageLookupByLibrary.simpleMessage("Показать пароль"),
    "shrink": MessageLookupByLibrary.simpleMessage("Компактно"),
    "silentLaunch": MessageLookupByLibrary.simpleMessage(
      "Стелс-подкрадули (Тихий запуск)",
    ),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Запуск в стелс-режиме",
    ),
    "size": MessageLookupByLibrary.simpleMessage("Размерчик"),
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
      "Замеры через сторонние серваки, инфа не 100%, скорость может просесть или наврать на кондициях.",
    ),
    "speedtestDownload": MessageLookupByLibrary.simpleMessage(
      "Скачка (Download)",
    ),
    "speedtestError": MessageLookupByLibrary.simpleMessage("Кринж соединения"),
    "speedtestGaugeUnit": MessageLookupByLibrary.simpleMessage("МБИТ/С"),
    "speedtestNoDataError": MessageLookupByLibrary.simpleMessage(
      "Тюбик не ответил: сервак ушёл в тильт, скорость по нулям",
    ),
    "speedtestPing": MessageLookupByLibrary.simpleMessage("Пинг"),
    "speedtestRunAgain": MessageLookupByLibrary.simpleMessage(
      "Измерить ещё раз",
    ),
    "speedtestStart": MessageLookupByLibrary.simpleMessage("Запустить тест"),
    "speedtestStop": MessageLookupByLibrary.simpleMessage("Остановить"),
    "speedtestTestingDownload": MessageLookupByLibrary.simpleMessage(
      "Загрузка дропа (Download)...",
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
    "startVpn": MessageLookupByLibrary.simpleMessage(
      "Подрубить LieVPN (моггинг он)",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Статус коннекта"),
    "statusActive": MessageLookupByLibrary.simpleMessage("Активен"),
    "statusAllAvailable": m30,
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
    "statusPartialOutagesDesc": m31,
    "statusUpdated": MessageLookupByLibrary.simpleMessage("Обновлено"),
    "stop": MessageLookupByLibrary.simpleMessage("Стопэ, отдохни"),
    "stopVpn": MessageLookupByLibrary.simpleMessage(
      "Потушить LieVPN (ушел в тильт)",
    ),
    "streakActiveToday": MessageLookupByLibrary.simpleMessage(
      "Огонёчек горит, чисто гигачад на чиле!",
    ),
    "streakDaysCount": m32,
    "streakFlameTitle": MessageLookupByLibrary.simpleMessage(
      "Огненный стрик на кондициях",
    ),
    "streakInactiveToday": MessageLookupByLibrary.simpleMessage(
      "Огонёк потух, не будь тюбиком! Вруби VPN до 00:00 МСК, чтобы зажечь!",
    ),
    "streakMilestoneCongrats": m33,
    "streakNoRestoresLeft": MessageLookupByLibrary.simpleMessage(
      "Все ресы на этот месяц профуканы (макс 3 шт).",
    ),
    "streakNotificationBody": m34,
    "streakNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "🔥 Огонёчек на грани кринжа!",
    ),
    "streakRestoreButton": MessageLookupByLibrary.simpleMessage(
      "Реснуть огонёчек",
    ),
    "streakRestoredSuccess": MessageLookupByLibrary.simpleMessage(
      "Огонёк воскрес! Красава, магнул систему!",
    ),
    "streakRestoresLeft": m35,
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
      "Осталось жить 3 дня. Если вы уже продлили, то обновите сабку.",
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
    "subscriptionExpiringIn": m36,
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
    "tonalSpotScheme": MessageLookupByLibrary.simpleMessage("Тональный акцент"),
    "tools": MessageLookupByLibrary.simpleMessage("Приблуды"),
    "torch": MessageLookupByLibrary.simpleMessage("Фонарик"),
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
      "Свернуть в карман в окно",
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
    "urlTip": m37,
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
    "yearsAgo": m38,
    "zhCN": MessageLookupByLibrary.simpleMessage("简体中文"),
  };
}
