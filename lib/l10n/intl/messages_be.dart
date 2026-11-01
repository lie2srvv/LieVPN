// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a be locale. All the
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
  String get localeName => 'be';

  static String m0(code) =>
      "Windows адказалась запускать LieVPNCore.exe (памылка ${code}). Політікі контроля праграм, такіе как Smart App Control ці AppLocker, блокіруют неподпісанные программы; разрешіте LieVPN в этой політіке ці адключіте её і повторіте попытку.";

  static String m1(name) =>
      "Праграма два раза подряд не смогло завершіть запуск. Чтобы разорвать цікл, профіль ${name} снят с выбора, а автоматіческая налада пропущена. Вы можете выбраць его снова в любой момент.";

  static String m2(url) => "Создать профіль по ссылке ${url}?";

  static String m3(count) =>
      "${Intl.plural(count, one: '${count} день назад', few: '${count} дня назад', many: '${count} дзён назад', other: '${count} дня назад')}";

  static String m4(label) =>
      "Вы уверены, что хадіте выдаліць выбранные элементы (${label})?";

  static String m5(label) => "Вы уверены, что хадіте выдаліць «${label}»?";

  static String m6(label) => "Сведенія: ${label}";

  static String m7(label) => "Поле не можа быць пустым";

  static String m8(count) =>
      "${Intl.plural(count, one: '${count} запісь', few: '${count} запісі', many: '${count} запісей', other: '${count} запісі')}";

  static String m9(label) => "«${label}» уже существует";

  static String m10(name) => "${name}: уже последняя версія";

  static String m11(name) => "${name}: обновлено";

  static String m12(count) =>
      "${Intl.plural(count, one: '${count} час назад', few: '${count} часа назад', many: '${count} гадзін назад', other: '${count} часа назад')}";

  static String m13(count) =>
      "${Intl.plural(count, one: '${count} час', few: '${count} часа', many: '${count} гадзін', other: '${count} часа')}";

  static String m14(target) => "${target} — недапустімая політіка";

  static String m15(proxyName) => "${proxyName} — недапустімый проксі";

  static String m16(providerName) =>
      "${providerName} — недапустімый провайдер проксі";

  static String m17(subRule) => "${subRule} — недапустімый SUB_RULE";

  static String m18(appName) =>
      "1. Адкройте Сістемные налады > Конфіденціальность і безопасность\n2. Выберіте Службы геолокаціі\n3. Найдіте і адметьте ${appName} в спіске\n\nПосле налады вернітесь в праграма і продалжайте рабаду. Спасібо за садруднічество.";

  static String m19(label, max) => "«${label}» — не более ${max} сімволов";

  static String m20(count) =>
      "${Intl.plural(count, one: '${count} хвіліну назад', few: '${count} хвіліны назад', many: '${count} хвілін назад', other: '${count} хвіліны назад')}";

  static String m21(count) =>
      "${Intl.plural(count, one: '${count} месяц назад', few: '${count} месяца назад', many: '${count} месяцев назад', other: '${count} месяца назад')}";

  static String m22(version) => "Даступно абнаўленне ${version}";

  static String m23(label) => "Пока нет: ${label}";

  static String m24(label) => "Значеніе «${label}» далжно быть чіслом";

  static String m25(label) =>
      "Значеніе «${label}» далжно быть ад 1024 да 49151";

  static String m26(count) => "${count} проксі";

  static String m27(count) =>
      "${Intl.plural(count, one: '${count} правіла', few: '${count} правілы', many: '${count} правіл', other: '${count} правілы')}";

  static String m28(count) =>
      "${Intl.plural(count, one: '${count} секунда', few: '${count} секунды', many: '${count} секунд', other: '${count} секунды')}";

  static String m29(count) => "Выбрана: ${count}";

  static String m30(count) => "Все серверы даступны (${count})";

  static String m31(up, total) => "Рабадают ${up} із ${total}";

  static String m32(count) =>
      "${Intl.plural(count, one: '${count} дзень', few: '${count} дні', many: '${count} дзён', other: '${count} дзён')}";

  static String m33(count) => "Ура! ${count} дзён стрыку запар!";

  static String m34(count) =>
      "Вы яшчэ не заходзілі ў LieVPN сёння. Падключыцеся да 00:00 МСК, каб захаваць стрык у ${count} дзён!";

  static String m35(count) =>
      "Засталося аднаўленняў у гэтым месяцы: ${count} з 3";

  static String m36(time) => "Падпіска заканчваецца праз ${time}";

  static String m37(label) => "Увядзіце карэктны адрас";

  static String m38(count) =>
      "${Intl.plural(count, one: '${count} год назад', few: '${count} года назад', many: '${count} лет назад', other: '${count} года назад')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Пра праграму"),
    "aboutAppDesc": MessageLookupByLibrary.simpleMessage(
      "Пріватный VPN для защіты дадзеных і анонімності в сеткі на прадаколе VLESS і Hysteria2.",
    ),
    "aboutFork": MessageLookupByLibrary.simpleMessage("Форк FlClash"),
    "aboutForkDesc": MessageLookupByLibrary.simpleMessage(
      "Адкрыть орігінальный репозіторій FlClash",
    ),
    "accessControl": MessageLookupByLibrary.simpleMessage("Кантроль праграм"),
    "accessControlAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Через VPN проходят только выбранные праграмы",
    ),
    "accessControlDesc": MessageLookupByLibrary.simpleMessage(
      "Выберыце праграмы, якія будуць выкарыстоўваць VPN",
    ),
    "accessControlDisabledDesc": MessageLookupByLibrary.simpleMessage(
      "Контроль даступа праграм адключён",
    ),
    "accessControlNotAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Выбранные праграмы ісключаются із VPN",
    ),
    "accessControlSettings": MessageLookupByLibrary.simpleMessage(
      "Налады контроля даступа",
    ),
    "account": MessageLookupByLibrary.simpleMessage("Аккаунт"),
    "accountStatus": MessageLookupByLibrary.simpleMessage("СТАТУС"),
    "accountUsername": MessageLookupByLibrary.simpleMessage("ІМЯ ПОЛЬЗОВАТЕЛЯ"),
    "action": MessageLookupByLibrary.simpleMessage("Действіе"),
    "actionMode": MessageLookupByLibrary.simpleMessage("Переключіть режім"),
    "actionProxy": MessageLookupByLibrary.simpleMessage("Сістэмны проксі"),
    "actionStart": MessageLookupByLibrary.simpleMessage("Старт/Стоп"),
    "actionTun": MessageLookupByLibrary.simpleMessage("TUN"),
    "actionView": MessageLookupByLibrary.simpleMessage("Показать/Схаваць"),
    "add": MessageLookupByLibrary.simpleMessage("Такдаць"),
    "addProfile": MessageLookupByLibrary.simpleMessage("Дадаць профіль"),
    "addProxies": MessageLookupByLibrary.simpleMessage("Дабавіть проксі"),
    "addProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Дабавіть группу проксі",
    ),
    "addProxyProviders": MessageLookupByLibrary.simpleMessage(
      "Дабавіть провайдеров проксі",
    ),
    "addRule": MessageLookupByLibrary.simpleMessage("Дабавіть правіла"),
    "addRules": MessageLookupByLibrary.simpleMessage("Такдаць правілы"),
    "addRulesDesc": MessageLookupByLibrary.simpleMessage(
      "Кіраванне ўласнымі правіламі маршрутызацыі",
    ),
    "addSsid": MessageLookupByLibrary.simpleMessage("Дабавіть SSID"),
    "addSubscription": MessageLookupByLibrary.simpleMessage(
      "Дабавіть падпіску",
    ),
    "addWidget": MessageLookupByLibrary.simpleMessage("Дабавіть віджет"),
    "addedRules": MessageLookupByLibrary.simpleMessage("Дабавленные правілы"),
    "additionalParameters": MessageLookupByLibrary.simpleMessage(
      "Даполнітельные параметры",
    ),
    "address": MessageLookupByLibrary.simpleMessage("Адрес"),
    "addressHelp": MessageLookupByLibrary.simpleMessage("Адрес сервера WebDAV"),
    "addressTip": MessageLookupByLibrary.simpleMessage(
      "Введіте корректный адрес WebDAV",
    ),
    "advancedConfig": MessageLookupByLibrary.simpleMessage(
      "Расшіренная конфігурація",
    ),
    "advancedConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Разнообразные параметры конфігураціі",
    ),
    "agree": MessageLookupByLibrary.simpleMessage("Согласен"),
    "allowBypass": MessageLookupByLibrary.simpleMessage(
      "Разрешіть праграмым обходіть VPN",
    ),
    "allowBypassDesc": MessageLookupByLibrary.simpleMessage(
      "Прі включеніі некадарые праграмы смогут обходіть VPN",
    ),
    "allowLan": MessageLookupByLibrary.simpleMessage(
      "Дазволіць доступ з лакальнай сеткі",
    ),
    "allowLanDesc": MessageLookupByLibrary.simpleMessage(
      "Дазволіць іншым прыладам падключацца",
    ),
    "app": MessageLookupByLibrary.simpleMessage("Праграма"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage(
      "Контроль даступа праграм",
    ),
    "appendSystemDns": MessageLookupByLibrary.simpleMessage(
      "Дабавлять сістэмны DNS",
    ),
    "appendSystemDnsTip": MessageLookupByLibrary.simpleMessage(
      "Прінудітельно дабавлять сістэмны DNS в конфігурацію",
    ),
    "application": MessageLookupByLibrary.simpleMessage("Праграма"),
    "applicationDesc": MessageLookupByLibrary.simpleMessage(
      "Налады, связанные с праграмам",
    ),
    "authentication": MessageLookupByLibrary.simpleMessage("Аутентіфікація"),
    "authenticationDesc": MessageLookupByLibrary.simpleMessage(
      "Требовать учётные дадзеныя для локального порта проксі, чтобы другіе праграмы не моглі выкарыстоўваць его",
    ),
    "authenticationSystemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Не пріменяется, пока включена аутентіфікація",
    ),
    "authorize": MessageLookupByLibrary.simpleMessage("Разрешіть"),
    "authorized": MessageLookupByLibrary.simpleMessage("Разрешено"),
    "auto": MessageLookupByLibrary.simpleMessage("Авто"),
    "autoCheckUpdate": MessageLookupByLibrary.simpleMessage(
      "Аўтаправерка абнаўленняў",
    ),
    "autoCheckUpdateDesc": MessageLookupByLibrary.simpleMessage(
      "Аўтаматычна проверять абнаўленні прі запуске праграмы",
    ),
    "autoCloseConnections": MessageLookupByLibrary.simpleMessage(
      "Автозакрытіе соедіненій",
    ),
    "autoCloseConnectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Аўтаматычна закрывать соедіненія после смены узла",
    ),
    "autoLaunch": MessageLookupByLibrary.simpleMessage("Аўтазапуск"),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Запускаць праграму пры старце сістэмы",
    ),
    "autoRun": MessageLookupByLibrary.simpleMessage("Аўтазапуск"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage(
      "Включаться аўтаматычна прі адкрытіі праграмы",
    ),
    "autoSetSystemDns": MessageLookupByLibrary.simpleMessage(
      "Автоналада сістемного DNS",
    ),
    "autoUpdate": MessageLookupByLibrary.simpleMessage("Аўтаабнаўленне"),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Інтэрвал аўтаабнаўлення",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Назад"),
    "backup": MessageLookupByLibrary.simpleMessage("Резервное копірованіе"),
    "backupAndRestore": MessageLookupByLibrary.simpleMessage(
      "Резервное копірованіе і восстановленіе",
    ),
    "backupAndRestoreDesc": MessageLookupByLibrary.simpleMessage(
      "Сінхронізація дадзеных через WebDAV ці файлы",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage(
      "Резервная копія создана",
    ),
    "basicConfig": MessageLookupByLibrary.simpleMessage("Базовая конфігурація"),
    "basicConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Глобальное ізмененіе базовой конфігураціі",
    ),
    "basicInfo": MessageLookupByLibrary.simpleMessage("Основная інфармацыя"),
    "basicStrategy": MessageLookupByLibrary.simpleMessage("Базовые політікі"),
    "batteryOptimizationDesc": MessageLookupByLibrary.simpleMessage(
      "Чтобы праграма рабадало в фоне, адключіте для него оптімізацію батареі. Нажміте, чтобы перейті к наладам.",
    ),
    "batteryOptimizationStatusTip": MessageLookupByLibrary.simpleMessage(
      "Із-за сістемных ограніченій во час рабады невозможно корректно получіть статус оптімізаціі батареі",
    ),
    "be": MessageLookupByLibrary.simpleMessage("Беларуская"),
    "bind": MessageLookupByLibrary.simpleMessage("Прівязать"),
    "blacklistMode": MessageLookupByLibrary.simpleMessage(
      "Режім чёрного спіска",
    ),
    "blockConnection": MessageLookupByLibrary.simpleMessage(
      "Заблокіровать соедіненіе",
    ),
    "buyInTelegram": MessageLookupByLibrary.simpleMessage("Купіць у Telegram"),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("Абыход даменаў"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Спіс даменаў у абыход проксі",
    ),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "Кэш повреждён. Ачысціць его?",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Скасаваць"),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage("Снять выделеніе"),
    "change": MessageLookupByLibrary.simpleMessage("Сменіть"),
    "changeProxyFailedTip": MessageLookupByLibrary.simpleMessage(
      "Не удалось переключіть проксі; восстановлен предыдущій выбор",
    ),
    "changeSubscription": MessageLookupByLibrary.simpleMessage(
      "Сменіть падпіску",
    ),
    "changelogBreaking": MessageLookupByLibrary.simpleMessage(
      "Важные ізмененія",
    ),
    "changelogFeatures": MessageLookupByLibrary.simpleMessage("Новые функціі"),
    "changelogFixes": MessageLookupByLibrary.simpleMessage("Ісправленія"),
    "changelogPerformance": MessageLookupByLibrary.simpleMessage(
      "Проізводітельность",
    ),
    "changelogReverts": MessageLookupByLibrary.simpleMessage("Адкаты"),
    "checkCertificate": MessageLookupByLibrary.simpleMessage(
      "Проверять TLS-сертіфікаты",
    ),
    "checkCertificateDesc": MessageLookupByLibrary.simpleMessage(
      "Адклонять недаверенные сертіфікаты. Адключеніе подвергает падпіскі і резервные копіі атаке «человек посередіне»",
    ),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("Праверыць абнаўленні"),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage(
      "У вас уже последняя версія",
    ),
    "checkUpdateStatus": MessageLookupByLibrary.simpleMessage(
      "Абнавіць статус",
    ),
    "checkUpdates": MessageLookupByLibrary.simpleMessage(
      "Праверыць абнаўленні",
    ),
    "checkUpdatesDesc": MessageLookupByLibrary.simpleMessage(
      "Праверыць налічіе новой версіі",
    ),
    "clearData": MessageLookupByLibrary.simpleMessage("Ачысціць дадзеныя"),
    "clearSearch": MessageLookupByLibrary.simpleMessage("Ачысціць пошук"),
    "clipboardExport": MessageLookupByLibrary.simpleMessage(
      "Экспорт в буфер обмена",
    ),
    "clipboardImport": MessageLookupByLibrary.simpleMessage(
      "Імпорт із буфера обмена",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Закрыць"),
    "closeConnections": MessageLookupByLibrary.simpleMessage(
      "Закрываць злучэнні",
    ),
    "color": MessageLookupByLibrary.simpleMessage("Цвет"),
    "colorSchemes": MessageLookupByLibrary.simpleMessage("Цветовые схемы"),
    "columns": MessageLookupByLibrary.simpleMessage("Столбцы"),
    "compatible": MessageLookupByLibrary.simpleMessage("Режім совместімості"),
    "configDataDetected": MessageLookupByLibrary.simpleMessage(
      "В конфігураціі обнаружены дадзеныя",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Пацвердзіць"),
    "confirmClearAllData": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хадіте выдаліць все дадзеныя?",
    ),
    "confirmDeleteProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хадіте выдаліць эту группу проксі?",
    ),
    "confirmExitWindow": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хадіте закрыць бягучае окно?",
    ),
    "confirmForceCrashCore": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хадіте прінудітельно завершіть ядро со сбоем?",
    ),
    "confirmOverwriteTip": MessageLookupByLibrary.simpleMessage(
      "После подтвержденія существующіе дадзеныя будут перезапісаны",
    ),
    "connected": MessageLookupByLibrary.simpleMessage("Падключана"),
    "connecting": MessageLookupByLibrary.simpleMessage("Падключэнне..."),
    "connection": MessageLookupByLibrary.simpleMessage("Соедіненіе"),
    "connections": MessageLookupByLibrary.simpleMessage("Злучэнні"),
    "connectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Просмадр дадзеных о текущіх соедіненіях",
    ),
    "connectivity": MessageLookupByLibrary.simpleMessage("Падключэнне: "),
    "content": MessageLookupByLibrary.simpleMessage("Содержімое"),
    "contentNotEmpty": MessageLookupByLibrary.simpleMessage(
      "Содержімое не может быть пустым",
    ),
    "contentScheme": MessageLookupByLibrary.simpleMessage("Контентная"),
    "controlGlobalAddedRules": MessageLookupByLibrary.simpleMessage(
      "Управленіе глобальнымі дабавленнымі правілымі",
    ),
    "copy": MessageLookupByLibrary.simpleMessage("Скапіяваць"),
    "copyEnvVar": MessageLookupByLibrary.simpleMessage(
      "Скапіяваць переменные окруженія",
    ),
    "copyLink": MessageLookupByLibrary.simpleMessage("Скапіяваць ссылку"),
    "copySuccess": MessageLookupByLibrary.simpleMessage(
      "Скапіявана ў буфер абмену",
    ),
    "core": MessageLookupByLibrary.simpleMessage("Ядро"),
    "coreBlockedByPolicyTip": m0,
    "coreBlockedBySmartAppControlTip": MessageLookupByLibrary.simpleMessage(
      "Smart App Control в Windows заблокіровал неподпісанный LieVPNCore.exe. Адкройте Безопасность Windows → Управленіе праграмымі і браузером → Параметры Smart App Control, выберіте «Выкл.» і снова запустіте LieVPN. Повторно уключыць Smart App Control без переустановкі Windows нельзя.",
    ),
    "coreStatus": MessageLookupByLibrary.simpleMessage("Статус ядра"),
    "country": MessageLookupByLibrary.simpleMessage("Регіон"),
    "crashDetected": MessageLookupByLibrary.simpleMessage("Обнаружен сбой"),
    "crashDetectedTip": m1,
    "crashTest": MessageLookupByLibrary.simpleMessage("Тест сбоя"),
    "crashlytics": MessageLookupByLibrary.simpleMessage("Аналітіка сбоев"),
    "crashlyticsTip": MessageLookupByLibrary.simpleMessage(
      "Прі включеніі в случае сбоя праграмы аўтаматычна загружаются логі сбоя без конфіденціальной інформаціі",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Создать"),
    "createProfile": MessageLookupByLibrary.simpleMessage("Создать профіль"),
    "createProfileFromUrlTip": m2,
    "creationTime": MessageLookupByLibrary.simpleMessage("Час созданія"),
    "custom": MessageLookupByLibrary.simpleMessage("Вручную"),
    "cut": MessageLookupByLibrary.simpleMessage("Выразаць"),
    "dark": MessageLookupByLibrary.simpleMessage("Цёмная"),
    "dashboard": MessageLookupByLibrary.simpleMessage("Панэль кіравання"),
    "dashboardLieVpn": MessageLookupByLibrary.simpleMessage("Панель LieVPN"),
    "dataChangedSave": MessageLookupByLibrary.simpleMessage(
      "Обнаружены ізмененія дадзеных. Захаваць іх?",
    ),
    "dataCollectionContent": MessageLookupByLibrary.simpleMessage(
      "Это праграма іспользует Firebase Crashlytics для сбора інформаціі о сбоях, чтобы повысіть стабільность.\nСобіраемые дадзеныя включают сведенія об устройстве і подробності сбоя і не содержат лічных конфіденціальных дадзеных.\nЭту функцію можно адключыць в наладах.",
    ),
    "dataCollectionTip": MessageLookupByLibrary.simpleMessage(
      "Апавяшчэнне о сборе дадзеных",
    ),
    "dataLimit": MessageLookupByLibrary.simpleMessage("ЛІМІТ ДАННЫХ"),
    "dataUsed": MessageLookupByLibrary.simpleMessage("ІСПОЛЬЗОВАНО"),
    "databaseWriteFailedTip": MessageLookupByLibrary.simpleMessage(
      "Не удалось захаваць ізмененіе; оно адменено",
    ),
    "daysAgo": m3,
    "defaultNameserver": MessageLookupByLibrary.simpleMessage(
      "DNS-сервер па змаўчанні",
    ),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Іспользуется для разрешенія адресов DNS-серверов",
    ),
    "defaultText": MessageLookupByLibrary.simpleMessage("Па змаўчанні"),
    "delay": MessageLookupByLibrary.simpleMessage("Затрымка"),
    "delayTest": MessageLookupByLibrary.simpleMessage("Тест затрымкі"),
    "delete": MessageLookupByLibrary.simpleMessage("Выдаліць"),
    "deleteMultipTip": m4,
    "deleteTip": m5,
    "desc": MessageLookupByLibrary.simpleMessage(
      "Многоплатформенный проксі-кліент на основе ClashMeta: простой і удабный, с адкрытым ісходным кодам і без рекламы.",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("Назначеніе"),
    "destinationGeoIP": MessageLookupByLibrary.simpleMessage(
      "GeoIP назначенія",
    ),
    "destinationIPASN": MessageLookupByLibrary.simpleMessage(
      "ASN IP назначенія",
    ),
    "details": m6,
    "detectionTip": MessageLookupByLibrary.simpleMessage(
      "Іспользует сторонній API; только для справкі",
    ),
    "developerMode": MessageLookupByLibrary.simpleMessage("Режім разрабадчіка"),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "Режім разрабадчіка включён.",
    ),
    "direct": MessageLookupByLibrary.simpleMessage("Прамое злучэнне"),
    "disableUDP": MessageLookupByLibrary.simpleMessage("Адключыць UDP"),
    "disclaimer": MessageLookupByLibrary.simpleMessage(
      "Адказ ад адветственності",
    ),
    "disclaimerDesc": MessageLookupByLibrary.simpleMessage(
      "Это программное обеспеченіе предназначено только для некоммерческого іспользованія: обученія, обмена опытом і научных ісследаваній. Коммерческое выкарыстанне строго запрещено; любая коммерческая деятельность не імеет адношенія к этому программному обеспеченію.",
    ),
    "disconnected": MessageLookupByLibrary.simpleMessage("Адключана"),
    "discoverNewVersion": MessageLookupByLibrary.simpleMessage(
      "Даступна новая версія",
    ),
    "dnsDesc": MessageLookupByLibrary.simpleMessage("Налады, связанные с DNS"),
    "dnsHijacking": MessageLookupByLibrary.simpleMessage("Перахоп DNS"),
    "dnsMode": MessageLookupByLibrary.simpleMessage("Режім DNS"),
    "domain": MessageLookupByLibrary.simpleMessage("Дамен"),
    "donators": MessageLookupByLibrary.simpleMessage("Мецэнаты праекта"),
    "download": MessageLookupByLibrary.simpleMessage("Спампаваць"),
    "edit": MessageLookupByLibrary.simpleMessage("Рэдагаваць"),
    "editGlobalRules": MessageLookupByLibrary.simpleMessage(
      "Редактіровать глобальные правілы",
    ),
    "editProxy": MessageLookupByLibrary.simpleMessage("Редактіровать проксі"),
    "editProxyGroup": MessageLookupByLibrary.simpleMessage(
      "Редактіровать группу проксі",
    ),
    "editRule": MessageLookupByLibrary.simpleMessage("Редактіровать правіла"),
    "editSsid": MessageLookupByLibrary.simpleMessage("Ізменіть SSID"),
    "emptyTip": m7,
    "en": MessageLookupByLibrary.simpleMessage("English"),
    "enterSubscriptionUrl": MessageLookupByLibrary.simpleMessage(
      "Увядзіце спасылку на падпіску",
    ),
    "entries": MessageLookupByLibrary.simpleMessage(" запісей"),
    "entriesCount": m8,
    "exclude": MessageLookupByLibrary.simpleMessage(
      "Схаваць із недавніх задач",
    ),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "Скрывать праграма із недавніх задач, когда оно в фоне",
    ),
    "excludeProxyFilter": MessageLookupByLibrary.simpleMessage(
      "Фільтр ісключенія узлов",
    ),
    "excludeSsids": MessageLookupByLibrary.simpleMessage("Ісключённые SSID"),
    "excludeSsidsDesc": MessageLookupByLibrary.simpleMessage(
      "Прі подключеніі к Wi-Fi с ісключённым SSID состояніе рабады праграмы переключается аўтаматычна",
    ),
    "excludeType": MessageLookupByLibrary.simpleMessage("Ісключаемые тіпы"),
    "existsTip": m9,
    "exit": MessageLookupByLibrary.simpleMessage("Выхад"),
    "exitFullScreen": MessageLookupByLibrary.simpleMessage(
      "Выйті із полноэкранного режіма",
    ),
    "expand": MessageLookupByLibrary.simpleMessage("Разгарнуць"),
    "expectedStatus": MessageLookupByLibrary.simpleMessage("Ожідаемый статус"),
    "expirationDate": MessageLookupByLibrary.simpleMessage("Дата заканчэння"),
    "expireTime": MessageLookupByLibrary.simpleMessage("Заканчваецца"),
    "exportFile": MessageLookupByLibrary.simpleMessage("Экспорт файла"),
    "exportLogs": MessageLookupByLibrary.simpleMessage("Экспорт логов"),
    "exportSuccess": MessageLookupByLibrary.simpleMessage("Экспорт выполнен"),
    "expressiveScheme": MessageLookupByLibrary.simpleMessage("Экспрессівная"),
    "externalController": MessageLookupByLibrary.simpleMessage(
      "Знешні кантролер",
    ),
    "externalControllerDesc": MessageLookupByLibrary.simpleMessage(
      "Адрас кіравання Clash Core",
    ),
    "externalFetch": MessageLookupByLibrary.simpleMessage("Внешнее полученіе"),
    "externalLink": MessageLookupByLibrary.simpleMessage("Внешняя спасылка"),
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Фільтр Fake-IP"),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Діапазон Fake-IP"),
    "fallback": MessageLookupByLibrary.simpleMessage("Fallback"),
    "fallbackDesc": MessageLookupByLibrary.simpleMessage(
      "Звычайна замежны DNS",
    ),
    "fallbackFilter": MessageLookupByLibrary.simpleMessage("Фільтр fallback"),
    "fidelityScheme": MessageLookupByLibrary.simpleMessage("Точная передача"),
    "file": MessageLookupByLibrary.simpleMessage("Файл"),
    "fileDesc": MessageLookupByLibrary.simpleMessage(
      "Загрузіть файл профіля напрямую",
    ),
    "fileIsUpdate": MessageLookupByLibrary.simpleMessage(
      "Файл ізменён. Захаваць ізмененія?",
    ),
    "findProcessMode": MessageLookupByLibrary.simpleMessage("Пошук процесса"),
    "findProcessModeDesc": MessageLookupByLibrary.simpleMessage(
      "Прі включеніі возможна небольшая падеря проізводітельності",
    ),
    "followProfile": MessageLookupByLibrary.simpleMessage("Как в профіле"),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Шрыфт"),
    "forceRestartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хадіте прінудітельно перезапустіть ядро?",
    ),
    "fruitSaladScheme": MessageLookupByLibrary.simpleMessage("Фруктовый мікс"),
    "general": MessageLookupByLibrary.simpleMessage("Общіе"),
    "geoAutoUpdate": MessageLookupByLibrary.simpleMessage("Автоабнаўленне"),
    "geoAutoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Інтервал автоабнаўленні",
    ),
    "geoAutoUpdateIntervalTip": MessageLookupByLibrary.simpleMessage(
      "Інтервал автоабнаўленні далжен быть больше 0",
    ),
    "geoOptions": MessageLookupByLibrary.simpleMessage("Налады Geo"),
    "geoResources": MessageLookupByLibrary.simpleMessage("Ресурсы Geo"),
    "geoSkipped": m10,
    "geoUpdated": m11,
    "geodataLoader": MessageLookupByLibrary.simpleMessage(
      "Geo: экономія памяті",
    ),
    "geodataLoaderDesc": MessageLookupByLibrary.simpleMessage(
      "Прі включеніі іспользуется Geo-загрузчік с нізкім падребленіем памяті",
    ),
    "geoipCode": MessageLookupByLibrary.simpleMessage("Код GeoIP"),
    "global": MessageLookupByLibrary.simpleMessage("Глабальны"),
    "go": MessageLookupByLibrary.simpleMessage("Перейті"),
    "goDownload": MessageLookupByLibrary.simpleMessage("Спампаваць"),
    "goToConfigureScript": MessageLookupByLibrary.simpleMessage(
      "Перейті к настройке скріпта",
    ),
    "hallOfFameHeader": MessageLookupByLibrary.simpleMessage(
      "// Зал Славы — общій данат",
    ),
    "hasCacheChange": MessageLookupByLibrary.simpleMessage(
      "Кэшіровать ізмененія?",
    ),
    "helperCorruptTip": MessageLookupByLibrary.simpleMessage(
      "Служба Helper недаступна, поэтому TUN-режім уключыць нельзя. Переустановіте LieVPN.",
    ),
    "hideFromList": MessageLookupByLibrary.simpleMessage("Схаваць із спіска"),
    "hidePassword": MessageLookupByLibrary.simpleMessage("Схаваць пароль"),
    "host": MessageLookupByLibrary.simpleMessage("Хост"),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("Дабавіть запісі hosts"),
    "hotkeyConflict": MessageLookupByLibrary.simpleMessage(
      "Конфлікт горячіх клавіш",
    ),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage("Горячіе клавіші"),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "Управленіе праграмам с клавіатуры",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("гадзін"),
    "hoursAgo": m12,
    "hoursCount": m13,
    "icon": MessageLookupByLibrary.simpleMessage("Значок"),
    "iconRecords": MessageLookupByLibrary.simpleMessage("Історія значков"),
    "iconStyle": MessageLookupByLibrary.simpleMessage("Стіль значков"),
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
      "Уключыць все проксі",
    ),
    "includeAllProxiesTip": MessageLookupByLibrary.simpleMessage(
      "Подключает все проксі вне групп; ніже можно дабавіть даполнітельные группы проксі",
    ),
    "includeAllProxyProviders": MessageLookupByLibrary.simpleMessage(
      "Уключыць всех провайдеров проксі",
    ),
    "includeAllProxyProvidersTip": MessageLookupByLibrary.simpleMessage(
      "Прі включеніі переопределяет подключённых провайдеров проксі",
    ),
    "infiniteTime": MessageLookupByLibrary.simpleMessage("Бессрочно"),
    "init": MessageLookupByLibrary.simpleMessage("Ініціалізація"),
    "inputCorrectHotkey": MessageLookupByLibrary.simpleMessage(
      "Введіте корректную горячую клавішу",
    ),
    "inputProxyGroupName": MessageLookupByLibrary.simpleMessage(
      "Введіте названіе группы проксі",
    ),
    "inputRuleContent": MessageLookupByLibrary.simpleMessage(
      "Введіте содержімое правілы",
    ),
    "insertSubscriptionUrl": MessageLookupByLibrary.simpleMessage(
      "Уставіць спасылку",
    ),
    "installedAppsPermissionDeniedMessage":
        MessageLookupByLibrary.simpleMessage(
          "Разрешеніе на спісок праграм адклонено, поэтому установленные праграмы недаступны. Предаставьте его вручную в сістемных наладах.",
        ),
    "installedAppsPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "Эта сістэма не выдаёт спісок установленных праграм без разрешенія. Предаставьте его, чтобы настроіть проксі для аддельных праграм.",
    ),
    "installedAppsPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Требуется разрешеніе на спісок праграм",
    ),
    "intelligentSelected": MessageLookupByLibrary.simpleMessage(
      "Разумны выбар",
    ),
    "interfaceName": MessageLookupByLibrary.simpleMessage("Імя інтерфейса"),
    "interfaceNameDesc": MessageLookupByLibrary.simpleMessage(
      "Сетевой інтерфейс для ісходящіх соедіненій",
    ),
    "interfaceNameMode": MessageLookupByLibrary.simpleMessage(
      "Ісходящій інтерфейс",
    ),
    "interfaceNameModeClear": MessageLookupByLibrary.simpleMessage("Ачысціць"),
    "interfaceNameModeCustom": MessageLookupByLibrary.simpleMessage("Вручную"),
    "interfaceNameModeFollow": MessageLookupByLibrary.simpleMessage(
      "Как в конфігураціі",
    ),
    "internet": MessageLookupByLibrary.simpleMessage("Інтернет"),
    "interval": MessageLookupByLibrary.simpleMessage("Інтервал"),
    "intranetIP": MessageLookupByLibrary.simpleMessage("Лок. IP"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Недапустімый файл резервной копіі",
    ),
    "invalidPolicy": m14,
    "invalidProxy": m15,
    "invalidProxyProvider": m16,
    "invalidSubRule": m17,
    "ipcidr": MessageLookupByLibrary.simpleMessage("IP/CIDR"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage(
      "Уключыць падтрымку IPv6 трафіка",
    ),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage(
      "Разрешіть входящій IPv6",
    ),
    "ja": MessageLookupByLibrary.simpleMessage("日本語"),
    "justNow": MessageLookupByLibrary.simpleMessage("Только что"),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "Інтервал TCP keep-alive",
    ),
    "key": MessageLookupByLibrary.simpleMessage("Ключ"),
    "kk": MessageLookupByLibrary.simpleMessage("Қазақша"),
    "ko": MessageLookupByLibrary.simpleMessage("한국어"),
    "language": MessageLookupByLibrary.simpleMessage("Мова"),
    "latestVersionInstalled": MessageLookupByLibrary.simpleMessage(
      "У вас установлена последняя версія",
    ),
    "launchInterrupted": MessageLookupByLibrary.simpleMessage(
      "Запуск не завершён",
    ),
    "launchInterruptedTip": MessageLookupByLibrary.simpleMessage(
      "В прошлый раз праграма неожіданно завершілось во час запуска. Автоматіческая налада для этого запуска пропущена; вы можете запустіть её вручную.",
    ),
    "layout": MessageLookupByLibrary.simpleMessage("Макет"),
    "lieVpnSettings": MessageLookupByLibrary.simpleMessage("Налады LieVPN"),
    "lieVpnSettingsDesc": MessageLookupByLibrary.simpleMessage(
      "Параметры апавяшчэнняў і персоналізаціі",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Светлая"),
    "list": MessageLookupByLibrary.simpleMessage("Спісок"),
    "listen": MessageLookupByLibrary.simpleMessage("Прослушіваніе"),
    "liveNotification": MessageLookupByLibrary.simpleMessage(
      "Live-апавяшчэнне",
    ),
    "liveNotificationCustomText": MessageLookupByLibrary.simpleMessage(
      "Уласны тэкст",
    ),
    "liveNotificationCustomTextDesc": MessageLookupByLibrary.simpleMessage(
      "Тэкст, які адлюстроўваецца ў Live-апавяшчэнні",
    ),
    "liveNotificationDesc": MessageLookupByLibrary.simpleMessage(
      "Паказваць статус у радку стану (Android)",
    ),
    "liveNotificationType": MessageLookupByLibrary.simpleMessage(
      "Адлюстраванне ў Live-апавяшчэнні",
    ),
    "liveNotificationTypeCustom": MessageLookupByLibrary.simpleMessage(
      "Уласны тэкст",
    ),
    "liveNotificationTypeDesc": MessageLookupByLibrary.simpleMessage(
      "Выберыце, што адлюстроўваць у радку стану",
    ),
    "liveNotificationTypePing": MessageLookupByLibrary.simpleMessage(
      "Пінг сервера",
    ),
    "liveNotificationTypeServer": MessageLookupByLibrary.simpleMessage(
      "Бягучы сервер (краіна)",
    ),
    "liveNotificationTypeSpeed": MessageLookupByLibrary.simpleMessage(
      "Хуткасць сеткі (Download + Upload)",
    ),
    "liveNotificationTypeSpeedDown": MessageLookupByLibrary.simpleMessage(
      "Хуткасць загрузкі (Download)",
    ),
    "liveNotificationTypeSpeedUp": MessageLookupByLibrary.simpleMessage(
      "Хуткасць аддачы (Upload)",
    ),
    "liveNotificationTypeStreak": MessageLookupByLibrary.simpleMessage(
      "Агеньчык стрыку",
    ),
    "liveNotificationTypeTraffic": MessageLookupByLibrary.simpleMessage(
      "Выкарыстана дадзеных",
    ),
    "liveNotificationTypeUsername": MessageLookupByLibrary.simpleMessage(
      "Імя карыстальніка",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Загрузка..."),
    "local": MessageLookupByLibrary.simpleMessage("Локально"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Резервное копірованіе дадзеных локально",
    ),
    "locationPermission": MessageLookupByLibrary.simpleMessage(
      "Разрешеніе на геолокацію",
    ),
    "locationPermissionDeniedMessage": MessageLookupByLibrary.simpleMessage(
      "Разрешеніе на геолокацію адклонено, поэтому невозможно получіть імя текущей сеткі Wi-Fi. Включіте разрешеніе на геолокацію вручную в сістемных наладах.",
    ),
    "locationPermissionDesc": MessageLookupByLibrary.simpleMessage(
      "По требованію сістемы для полученія імені сеткі Wi-Fi необходімо разрешеніе на геолокацію. На Android выберіте «Разрешіть всегда», іначе імя сеткі Wi-Fi нельзя получіть, пока праграма в фоне.",
    ),
    "locationPermissionGuide": m18,
    "locationPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Требуется разрешеніе на геолокацію",
    ),
    "log": MessageLookupByLibrary.simpleMessage("Лог"),
    "logLevel": MessageLookupByLibrary.simpleMessage("Узровень журнала"),
    "logcat": MessageLookupByLibrary.simpleMessage("Захоп логаў"),
    "logcatDesc": MessageLookupByLibrary.simpleMessage(
      "Прі адключеніі раздел логов будет скрыт",
    ),
    "logs": MessageLookupByLibrary.simpleMessage("Журнал"),
    "logsDesc": MessageLookupByLibrary.simpleMessage(
      "Запісі захваченных логов",
    ),
    "logsTest": MessageLookupByLibrary.simpleMessage("Тест логов"),
    "loopback": MessageLookupByLibrary.simpleMessage(
      "Інструмент разблокіровкі loopback",
    ),
    "loopbackDesc": MessageLookupByLibrary.simpleMessage(
      "Для снятія ограніченія loopback у UWP-праграм",
    ),
    "loose": MessageLookupByLibrary.simpleMessage("Свободный"),
    "matchSourceIp": MessageLookupByLibrary.simpleMessage(
      "Сопоставлять IP істочніка",
    ),
    "matchTarget": MessageLookupByLibrary.simpleMessage("MATCH-TARGET"),
    "matchTargetDesc": MessageLookupByLibrary.simpleMessage(
      "Куда направляются правілы с целью MATCH-TARGET. Па змаўчанні — цель последнего правілы MATCH этого профіля.",
    ),
    "matchTargetTitle": MessageLookupByLibrary.simpleMessage("Цель MATCH"),
    "maxFailedTimes": MessageLookupByLibrary.simpleMessage(
      "Макс. чісло неудач",
    ),
    "maxLengthTip": m19,
    "maximize": MessageLookupByLibrary.simpleMessage("Разгарнуць"),
    "memoryInfo": MessageLookupByLibrary.simpleMessage("Память"),
    "messageTest": MessageLookupByLibrary.simpleMessage("Тест сообщенія"),
    "messageTestTip": MessageLookupByLibrary.simpleMessage("Это паведамленне."),
    "min": MessageLookupByLibrary.simpleMessage("Мінімальный"),
    "minimize": MessageLookupByLibrary.simpleMessage("Згарнуць"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage(
      "Згортваць пры закрыцці",
    ),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "Згортваць у трэй пры закрыцці акна",
    ),
    "minutesAgo": m20,
    "mixedPort": MessageLookupByLibrary.simpleMessage("Змешаны порт"),
    "mode": MessageLookupByLibrary.simpleMessage("Рэжым"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("Монохром"),
    "monthsAgo": m21,
    "more": MessageLookupByLibrary.simpleMessage("Больш"),
    "multipleValuesTip": MessageLookupByLibrary.simpleMessage(
      "Разделяйте несколько значеній запятымі",
    ),
    "name": MessageLookupByLibrary.simpleMessage("Названіе"),
    "nameserver": MessageLookupByLibrary.simpleMessage("DNS-сервер"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Іспользуется для разрешенія даменов",
    ),
    "nameserverPolicy": MessageLookupByLibrary.simpleMessage(
      "Політіка DNS-серверов",
    ),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "Задать політіку DNS-серверов для даменов",
    ),
    "network": MessageLookupByLibrary.simpleMessage("Сетка"),
    "networkDesc": MessageLookupByLibrary.simpleMessage(
      "Налады, связанные с сеткаю",
    ),
    "networkDetection": MessageLookupByLibrary.simpleMessage("Праверка сеткі"),
    "networkException": MessageLookupByLibrary.simpleMessage("Памылка сеткі"),
    "networkSpeed": MessageLookupByLibrary.simpleMessage("Хуткасць сеткі"),
    "networkType": MessageLookupByLibrary.simpleMessage("Тіп сеткі"),
    "neutralScheme": MessageLookupByLibrary.simpleMessage("Нейтральная"),
    "newVersionAvailable": m22,
    "nextMatch": MessageLookupByLibrary.simpleMessage("Следующее совпаденіе"),
    "noAddedRulesYet": MessageLookupByLibrary.simpleMessage(
      "Правіл пока нет. Дабавьте дамен ці праграма выше.",
    ),
    "noData": MessageLookupByLibrary.simpleMessage("Не дадзеных"),
    "noExpiration": MessageLookupByLibrary.simpleMessage("∞ Бессрочно"),
    "noHotKey": MessageLookupByLibrary.simpleMessage("Горячіх клавіш пока нет"),
    "noInfo": MessageLookupByLibrary.simpleMessage("Не інформаціі"),
    "noLongerRemind": MessageLookupByLibrary.simpleMessage(
      "Больше не напомінать",
    ),
    "noNetwork": MessageLookupByLibrary.simpleMessage("Не сеткі"),
    "noNetworkApp": MessageLookupByLibrary.simpleMessage("Праграмы без сеткі"),
    "noRecords": MessageLookupByLibrary.simpleMessage("Запісей пока нет"),
    "noResolve": MessageLookupByLibrary.simpleMessage("Не разрешать IP"),
    "noResolveHostname": MessageLookupByLibrary.simpleMessage(
      "Не разрешать імя хоста",
    ),
    "noSubscriptionFound": MessageLookupByLibrary.simpleMessage(
      "Падпіска не дабавлена",
    ),
    "none": MessageLookupByLibrary.simpleMessage("Не"),
    "notLieVpnSubscription": MessageLookupByLibrary.simpleMessage(
      "Гэта не спасылка LieVPN",
    ),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "Текущую группу проксі нельзя выбраць",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Няма актыўнага профілю",
    ),
    "nullTip": m23,
    "numberTip": m24,
    "onDemand": MessageLookupByLibrary.simpleMessage("По условію"),
    "onDemandDesc": MessageLookupByLibrary.simpleMessage(
      "Настройте состояніе рабады праграмы для определённых сценаріев",
    ),
    "onlyIcon": MessageLookupByLibrary.simpleMessage("Толькі значок"),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage(
      "Учітывать только проксі",
    ),
    "onlyStatisticsProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Прі включеніі учітывается только трафік через проксі",
    ),
    "optional": MessageLookupByLibrary.simpleMessage("Необязательно"),
    "options": MessageLookupByLibrary.simpleMessage("Опціі"),
    "other": MessageLookupByLibrary.simpleMessage("Іншае"),
    "otherContributors": MessageLookupByLibrary.simpleMessage(
      "Другіе участнікі",
    ),
    "outboundMode": MessageLookupByLibrary.simpleMessage("Рэжым маршрутызацыі"),
    "override": MessageLookupByLibrary.simpleMessage("Перавызначэнне"),
    "overrideDns": MessageLookupByLibrary.simpleMessage("Переопределіть DNS"),
    "overrideDnsDesc": MessageLookupByLibrary.simpleMessage(
      "Прі включеніі налады DNS профіля переопределяются",
    ),
    "overrideMode": MessageLookupByLibrary.simpleMessage(
      "Режім переопределенія",
    ),
    "overrideScript": MessageLookupByLibrary.simpleMessage(
      "Скріпт переопределенія",
    ),
    "overwriteTypeCustom": MessageLookupByLibrary.simpleMessage(
      "Карыстальнікскій",
    ),
    "overwriteTypeCustomDesc": MessageLookupByLibrary.simpleMessage(
      "Карыстальнікскій режім: полная налада групп проксі і правіл",
    ),
    "palette": MessageLookupByLibrary.simpleMessage("Палітра"),
    "password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "paste": MessageLookupByLibrary.simpleMessage("Уставіць"),
    "personalAccount": MessageLookupByLibrary.simpleMessage("Асабісты кабінет"),
    "pickFromAlbum": MessageLookupByLibrary.simpleMessage("Выбраць із галереі"),
    "pinWindow": MessageLookupByLibrary.simpleMessage(
      "Закрепіть поверх всех окон",
    ),
    "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage(
      "Прівяжіте WebDAV",
    ),
    "pleaseEnterScriptName": MessageLookupByLibrary.simpleMessage(
      "Введіте названіе скріпта",
    ),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "Загрузіте корректный QR-код",
    ),
    "port": MessageLookupByLibrary.simpleMessage("Порт"),
    "portConflictTip": MessageLookupByLibrary.simpleMessage(
      "Введіте другой порт",
    ),
    "portTip": m25,
    "preferH3Desc": MessageLookupByLibrary.simpleMessage(
      "Предпочітать HTTP/3 для DoH",
    ),
    "prerequisites": MessageLookupByLibrary.simpleMessage(
      "Предварітельные условія",
    ),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage("Нажміте клавішу"),
    "preview": MessageLookupByLibrary.simpleMessage("Предпросмадр"),
    "previousMatch": MessageLookupByLibrary.simpleMessage(
      "Предыдущее совпаденіе",
    ),
    "process": MessageLookupByLibrary.simpleMessage("Процесс"),
    "profile": MessageLookupByLibrary.simpleMessage("Профіль"),
    "profileAutoUpdateIntervalInvalidValidationDesc":
        MessageLookupByLibrary.simpleMessage("Введіте корректный інтервал"),
    "profileAutoUpdateIntervalNullValidationDesc":
        MessageLookupByLibrary.simpleMessage("Введіте інтервал автоабнаўленні"),
    "profileHasUpdate": MessageLookupByLibrary.simpleMessage(
      "Профіль ізменён. Адключыць автоабнаўленне?",
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
    "profilesSort": MessageLookupByLibrary.simpleMessage("Сортіровка профілей"),
    "project": MessageLookupByLibrary.simpleMessage("Проект"),
    "providers": MessageLookupByLibrary.simpleMessage("Внешніе ресурсы"),
    "proxies": MessageLookupByLibrary.simpleMessage("Проксі"),
    "proxiesCount": m26,
    "proxiesEmpty": MessageLookupByLibrary.simpleMessage("Спісок проксі пуст"),
    "proxyChains": MessageLookupByLibrary.simpleMessage("Цепочка проксі"),
    "proxyDetectedAbnormal": MessageLookupByLibrary.simpleMessage(
      "Обнаружены адклоненія в выбранных проксі",
    ),
    "proxyFilter": MessageLookupByLibrary.simpleMessage("Фільтр узлов"),
    "proxyGroup": MessageLookupByLibrary.simpleMessage("Группа проксі"),
    "proxyGroupDetectedAbnormal": MessageLookupByLibrary.simpleMessage(
      "Обнаружены адклоненія в текущей группе проксі",
    ),
    "proxyGroupEmpty": MessageLookupByLibrary.simpleMessage(
      "Группа проксі пуста",
    ),
    "proxyGroupNameDuplicate": MessageLookupByLibrary.simpleMessage(
      "Названіе группы проксі уже іспользуется",
    ),
    "proxyGroupNameEmpty": MessageLookupByLibrary.simpleMessage(
      "Названіе группы проксі не может быть пустым",
    ),
    "proxyNameserver": MessageLookupByLibrary.simpleMessage(
      "DNS-сервер для проксі",
    ),
    "proxyNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Іспользуется для разрешенія даменов проксі-узлов",
    ),
    "proxyProviderDetectedAbnormal": MessageLookupByLibrary.simpleMessage(
      "Обнаружены адклоненія в выбранных провайдерах проксі",
    ),
    "proxyProviders": MessageLookupByLibrary.simpleMessage("Провайдеры проксі"),
    "proxyProvidersEmpty": MessageLookupByLibrary.simpleMessage(
      "Спісок провайдеров проксі пуст",
    ),
    "proxyProvidersNotEmpty": MessageLookupByLibrary.simpleMessage(
      "Провайдеры проксі не могут быть пустымі",
    ),
    "proxyType": MessageLookupByLibrary.simpleMessage("Тіп проксі"),
    "pruneCache": MessageLookupByLibrary.simpleMessage("Ачысціць кэш"),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("Чісто чёрный режім"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QR-код"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage(
      "Сканіруйте QR-код, чтобы получіть профіль",
    ),
    "quickFill": MessageLookupByLibrary.simpleMessage("Быстрое заполненіе"),
    "rainbowScheme": MessageLookupByLibrary.simpleMessage("Радуга"),
    "readyToTest": MessageLookupByLibrary.simpleMessage("Гадав к тестірованію"),
    "redirPort": MessageLookupByLibrary.simpleMessage("Порт Redir"),
    "redo": MessageLookupByLibrary.simpleMessage("Повторіть"),
    "remote": MessageLookupByLibrary.simpleMessage("Аддалена"),
    "remoteBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Резервное копірованіе дадзеных в WebDAV",
    ),
    "remoteDestination": MessageLookupByLibrary.simpleMessage(
      "Удалённое назначеніе",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("Прыбраць"),
    "renew": MessageLookupByLibrary.simpleMessage("Працягнуць"),
    "renewSubscription": MessageLookupByLibrary.simpleMessage(
      "Працягнуць падпіску",
    ),
    "request": MessageLookupByLibrary.simpleMessage("Запрос"),
    "requests": MessageLookupByLibrary.simpleMessage("Запыты"),
    "requestsDesc": MessageLookupByLibrary.simpleMessage(
      "Просмадр последніх запросов",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Скінуць"),
    "resetPageChangesTip": MessageLookupByLibrary.simpleMessage(
      "На этой страніце есть ізмененія. Вы уверены, что хадіте выполніть сброс?",
    ),
    "resetTip": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хадіте выполніть сброс?",
    ),
    "resources": MessageLookupByLibrary.simpleMessage("Рэсурсы"),
    "resourcesDesc": MessageLookupByLibrary.simpleMessage(
      "Сведенія о внешніх ресурсах",
    ),
    "respectRules": MessageLookupByLibrary.simpleMessage("Соблюдать правілы"),
    "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
      "DNS-соедіненія следуют правілым; требуется настроіть proxy-server-nameserver",
    ),
    "restart": MessageLookupByLibrary.simpleMessage("Перезапустіть"),
    "restartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хадіте перезапустіть ядро?",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Восстановіть"),
    "restoreAllData": MessageLookupByLibrary.simpleMessage(
      "Восстановіть все дадзеныя",
    ),
    "restoreException": MessageLookupByLibrary.simpleMessage(
      "Памылка восстановленія",
    ),
    "restoreFromFileDesc": MessageLookupByLibrary.simpleMessage(
      "Восстановіть дадзеныя із файла",
    ),
    "restoreFromWebDAVDesc": MessageLookupByLibrary.simpleMessage(
      "Восстановіть дадзеныя із WebDAV",
    ),
    "restoreOnlyConfig": MessageLookupByLibrary.simpleMessage(
      "Восстановіть только профілі",
    ),
    "restoreStrategy": MessageLookupByLibrary.simpleMessage(
      "Стратегія восстановленія",
    ),
    "restoreStrategyCompatible": MessageLookupByLibrary.simpleMessage(
      "Совместімость",
    ),
    "restoreStrategyOverride": MessageLookupByLibrary.simpleMessage(
      "Перезапісь",
    ),
    "restoreSuccess": MessageLookupByLibrary.simpleMessage(
      "Восстановленіе выполнено",
    ),
    "routeAddress": MessageLookupByLibrary.simpleMessage("Адреса маршрутов"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage(
      "Настроіть прослушіваемые адреса маршрутов",
    ),
    "routeMode": MessageLookupByLibrary.simpleMessage("Режім маршрутізаціі"),
    "routeModeBypassPrivate": MessageLookupByLibrary.simpleMessage(
      "Обходіть частные адреса",
    ),
    "routeModeConfig": MessageLookupByLibrary.simpleMessage(
      "Выкарыстоўваць конфігурацію",
    ),
    "ru": MessageLookupByLibrary.simpleMessage("Руская"),
    "rule": MessageLookupByLibrary.simpleMessage("Па правілах"),
    "ruleActionAndDesc": MessageLookupByLibrary.simpleMessage(
      "Логіческое правіла AND",
    ),
    "ruleActionDirectBadge": MessageLookupByLibrary.simpleMessage("DIRECT"),
    "ruleActionDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть полный дамен",
    ),
    "ruleActionDomainKeywordDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть ключевое слово в дамене",
    ),
    "ruleActionDomainRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть по регулярному выраженію дамена",
    ),
    "ruleActionDomainSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть суффікс дамена",
    ),
    "ruleActionDomainWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставленіе по маске; поддержіваются только * і ?",
    ),
    "ruleActionDscpDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть метку DSCP (только для входящіх tproxy UDP)",
    ),
    "ruleActionDstPortDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть діапазон портов назначенія",
    ),
    "ruleActionGeoipDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть код страны IP-адреса",
    ),
    "ruleActionGeositeDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть дамены із Geosite",
    ),
    "ruleActionInNameDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть імя входящего подключенія",
    ),
    "ruleActionInPortDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть входящій порт",
    ),
    "ruleActionInTypeDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть тіп входящего подключенія",
    ),
    "ruleActionInUserDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть імя карыстальніка входящего подключенія; несколько імён разделяются /",
    ),
    "ruleActionIpAsnDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть ASN, кадарой прінадлежіт IP",
    ),
    "ruleActionIpCidr6Desc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть діапазон IP-адресов; IP-CIDR6 — просто псевданім",
    ),
    "ruleActionIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть діапазон IP-адресов",
    ),
    "ruleActionIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть діапазон суффіксов IP",
    ),
    "ruleActionMatchDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставляет все запросы, условія не нужны",
    ),
    "ruleActionNetworkDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть TCP ці UDP",
    ),
    "ruleActionNotDesc": MessageLookupByLibrary.simpleMessage(
      "Логіческое правіла NOT",
    ),
    "ruleActionOrDesc": MessageLookupByLibrary.simpleMessage(
      "Логіческое правіла OR",
    ),
    "ruleActionProcessNameDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть по імені процесса; на Android соадветствует імені пакета",
    ),
    "ruleActionProcessNameRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть по регулярному выраженію імені процесса; на Android соадветствует імені пакета",
    ),
    "ruleActionProcessNameWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть по маске імені процесса; поддержіваются только * і ?",
    ),
    "ruleActionProcessPathDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть по полному путі процесса",
    ),
    "ruleActionProcessPathRegexDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть по регулярному выраженію путі процесса",
    ),
    "ruleActionProcessPathWildcardDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть по маске путі процесса; поддержіваются только * і ?",
    ),
    "ruleActionRematchNameDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть імя повторного сопоставленія; несколько імён разделяются /",
    ),
    "ruleActionRuleSetDesc": MessageLookupByLibrary.simpleMessage(
      "Спасылка на набор правіл; требуется настроіть rule-providers",
    ),
    "ruleActionSrcGeoipDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть код страны IP істочніка",
    ),
    "ruleActionSrcIpAsnDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть ASN IP істочніка",
    ),
    "ruleActionSrcIpCidrDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть діапазон IP-адресов істочніка",
    ),
    "ruleActionSrcIpSuffixDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть діапазон суффіксов IP істочніка",
    ),
    "ruleActionSrcPortDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть діапазон портов істочніка",
    ),
    "ruleActionSubRuleDesc": MessageLookupByLibrary.simpleMessage(
      "Переход к подправілу; обратіте увага на скобкі",
    ),
    "ruleActionUidDesc": MessageLookupByLibrary.simpleMessage(
      "Сопоставіть Linux USER ID",
    ),
    "ruleAddedSuccess": MessageLookupByLibrary.simpleMessage(
      "Правіла паспяхова дабавлено",
    ),
    "ruleAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Такое правіла уже существует",
    ),
    "ruleApp": MessageLookupByLibrary.simpleMessage("Праграма"),
    "ruleContent": MessageLookupByLibrary.simpleMessage("Правіла"),
    "ruleDomain": MessageLookupByLibrary.simpleMessage("Дамен"),
    "ruleDomainHint": MessageLookupByLibrary.simpleMessage(
      "example.com (DOMAIN-SUFFIX)",
    ),
    "ruleEmpty": MessageLookupByLibrary.simpleMessage("Правіла пусто"),
    "ruleInputEmpty": MessageLookupByLibrary.simpleMessage(
      "Поле ввода не может быть пустым",
    ),
    "ruleName": MessageLookupByLibrary.simpleMessage("Названіе правілы"),
    "ruleProcessHint": MessageLookupByLibrary.simpleMessage(
      "Імя процесса ці пакета (PROCESS-NAME)",
    ),
    "ruleSelectAppTooltip": MessageLookupByLibrary.simpleMessage(
      "Выбраць праграма ці процесс",
    ),
    "ruleSet": MessageLookupByLibrary.simpleMessage("Набор правіл"),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("Цель правілы"),
    "ruleTargetDirect": MessageLookupByLibrary.simpleMessage("DIRECT"),
    "ruleType": MessageLookupByLibrary.simpleMessage("Тіп"),
    "rules": MessageLookupByLibrary.simpleMessage("Правілы"),
    "rulesCount": m27,
    "save": MessageLookupByLibrary.simpleMessage("Захаваць"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Захаваць ізмененія?"),
    "scanQrCode": MessageLookupByLibrary.simpleMessage("Сканаваць QR-код"),
    "script": MessageLookupByLibrary.simpleMessage("Скрыпт"),
    "scriptModeDesc": MessageLookupByLibrary.simpleMessage(
      "Режім скріпта: іспользует внешніе скріпты-расшіренія для переопределенія конфігураціі в одін клік",
    ),
    "scrollToSelected": MessageLookupByLibrary.simpleMessage(
      "Прокрутіть к выбранному",
    ),
    "search": MessageLookupByLibrary.simpleMessage("Пошук"),
    "searchAppHint": MessageLookupByLibrary.simpleMessage(
      "Пошук праграмы ці процесса...",
    ),
    "seconds": MessageLookupByLibrary.simpleMessage("секунд"),
    "secondsCount": m28,
    "selectAll": MessageLookupByLibrary.simpleMessage("Выбраць усё"),
    "selectAppTitle": MessageLookupByLibrary.simpleMessage(
      "Выбраць праграма / процесс",
    ),
    "selectMatchTarget": MessageLookupByLibrary.simpleMessage(
      "Выбраць MATCH-TARGET",
    ),
    "selectProxies": MessageLookupByLibrary.simpleMessage("Выбраць проксі"),
    "selectProxyProviders": MessageLookupByLibrary.simpleMessage(
      "Выбраць провайдеров проксі",
    ),
    "selectRuleSet": MessageLookupByLibrary.simpleMessage(
      "Выберіте набор правіл",
    ),
    "selectSplitStrategy": MessageLookupByLibrary.simpleMessage(
      "Выберіте стратегію распределенія",
    ),
    "selectSubRule": MessageLookupByLibrary.simpleMessage(
      "Выберіте подправіла",
    ),
    "selected": MessageLookupByLibrary.simpleMessage("Выбрана"),
    "selectedCountTitle": m29,
    "serverNotRespondingReconnecting": MessageLookupByLibrary.simpleMessage(
      "Сервер перастаў адказваць. Перападключэнне...",
    ),
    "serverStatus": MessageLookupByLibrary.simpleMessage("Стан сервераў"),
    "serverStatusDesc": MessageLookupByLibrary.simpleMessage(
      "Маніторынг даступнасці сервераў",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Налады"),
    "show": MessageLookupByLibrary.simpleMessage("Показать"),
    "showLess": MessageLookupByLibrary.simpleMessage("Згарнуць"),
    "showMore": MessageLookupByLibrary.simpleMessage("Разгарнуць"),
    "showNotificationStopAction": MessageLookupByLibrary.simpleMessage(
      "Кнопка остановкі в уведамленіі",
    ),
    "showNotificationStopActionDesc": MessageLookupByLibrary.simpleMessage(
      "Показывать кнопку остановкі в постоянном уведамленіі. Адключіте, еслі із-за неё сістэма всегда разворачівает апавяшчэнне",
    ),
    "showPassword": MessageLookupByLibrary.simpleMessage("Показать пароль"),
    "shrink": MessageLookupByLibrary.simpleMessage("Кампактны"),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("Ціхі запуск"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Запускаць у фонавым рэжыме без паказу акна",
    ),
    "size": MessageLookupByLibrary.simpleMessage("Памер"),
    "socksPort": MessageLookupByLibrary.simpleMessage("Порт SOCKS"),
    "sort": MessageLookupByLibrary.simpleMessage("Сартаванне"),
    "source": MessageLookupByLibrary.simpleMessage("Істочнік"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("IP істочніка"),
    "specialProxy": MessageLookupByLibrary.simpleMessage("Спеціальный проксі"),
    "specialRules": MessageLookupByLibrary.simpleMessage("Спеціальные правілы"),
    "speedStatistics": MessageLookupByLibrary.simpleMessage(
      "Статістіка скорості",
    ),
    "speedtest": MessageLookupByLibrary.simpleMessage("Тэст хуткасці"),
    "speedtestCompleted": MessageLookupByLibrary.simpleMessage(
      "Тест паспяхова завершён",
    ),
    "speedtestDesc": MessageLookupByLibrary.simpleMessage(
      "Праверце хуткасць вашай сеткі",
    ),
    "speedtestDisclaimer": MessageLookupByLibrary.simpleMessage(
      "Праверка хуткасці выконваецца праз староннія сэрвісы. Рэальная хуткасць можа адрознівацца або быць вымерана недакладна.",
    ),
    "speedtestDownload": MessageLookupByLibrary.simpleMessage("Загрузка"),
    "speedtestError": MessageLookupByLibrary.simpleMessage(
      "Памылка соедіненія",
    ),
    "speedtestGaugeUnit": MessageLookupByLibrary.simpleMessage("МБІТ/С"),
    "speedtestNoDataError": MessageLookupByLibrary.simpleMessage(
      "Не ўдалося вымераць хуткасць: няма адказу ад сервера",
    ),
    "speedtestPing": MessageLookupByLibrary.simpleMessage("Пінг"),
    "speedtestRunAgain": MessageLookupByLibrary.simpleMessage(
      "Ізмеріть ещё раз",
    ),
    "speedtestStart": MessageLookupByLibrary.simpleMessage("Запустіть тест"),
    "speedtestStop": MessageLookupByLibrary.simpleMessage("Остановіть"),
    "speedtestTestingDownload": MessageLookupByLibrary.simpleMessage(
      "Загрузка (Download)...",
    ),
    "speedtestTestingPing": MessageLookupByLibrary.simpleMessage(
      "Ізмереніе затрымкі (Ping)...",
    ),
    "speedtestTestingUpload": MessageLookupByLibrary.simpleMessage(
      "Аддача (Upload)...",
    ),
    "speedtestUnitMbps": MessageLookupByLibrary.simpleMessage("Мбіт/с"),
    "speedtestUnitMs": MessageLookupByLibrary.simpleMessage("мс"),
    "speedtestUpload": MessageLookupByLibrary.simpleMessage("Аддача"),
    "splitStrategy": MessageLookupByLibrary.simpleMessage(
      "Стратегія распределенія",
    ),
    "splitStrategyNotEmpty": MessageLookupByLibrary.simpleMessage(
      "Стратегія распределенія не может быть пустой",
    ),
    "ssidsEmpty": MessageLookupByLibrary.simpleMessage("Спісок SSID пуст"),
    "stackMode": MessageLookupByLibrary.simpleMessage("Режім стека"),
    "standard": MessageLookupByLibrary.simpleMessage("Стандартный"),
    "standardModeDesc": MessageLookupByLibrary.simpleMessage(
      "Стандартный режім: переопределяет базовую конфігурацію і позволяет просто дабавлять правілы",
    ),
    "start": MessageLookupByLibrary.simpleMessage("Падключыць"),
    "startVpn": MessageLookupByLibrary.simpleMessage("Запусціць VPN"),
    "status": MessageLookupByLibrary.simpleMessage("Стан"),
    "statusActive": MessageLookupByLibrary.simpleMessage("Актівен"),
    "statusAllAvailable": m30,
    "statusAllDown": MessageLookupByLibrary.simpleMessage("Серверы недаступны"),
    "statusAllDownDesc": MessageLookupByLibrary.simpleMessage(
      "Все моніторы сообщают об ошібке",
    ),
    "statusAllSystemsOperational": MessageLookupByLibrary.simpleMessage(
      "Все сістемы рабадают нормально",
    ),
    "statusAllSystemsOperationalDesc": MessageLookupByLibrary.simpleMessage(
      "Все серверы в статусе «Даступен»",
    ),
    "statusCheckHistory": MessageLookupByLibrary.simpleMessage(
      "Історія проверок",
    ),
    "statusChecking": MessageLookupByLibrary.simpleMessage(
      "Праверка серверов...",
    ),
    "statusDesc": MessageLookupByLibrary.simpleMessage(
      "Прі адключеніі іспользуется сістэмны DNS",
    ),
    "statusDown": MessageLookupByLibrary.simpleMessage("Недаступен"),
    "statusExpired": MessageLookupByLibrary.simpleMessage("Скончыўсяла"),
    "statusMonitors": MessageLookupByLibrary.simpleMessage("// МОНІТОРЫ"),
    "statusNoMonitors": MessageLookupByLibrary.simpleMessage(
      "Не дадзеных о моніторах",
    ),
    "statusOperational": MessageLookupByLibrary.simpleMessage("Даступен"),
    "statusPartialOutages": MessageLookupByLibrary.simpleMessage(
      "Частічные проблемы",
    ),
    "statusPartialOutagesDesc": m31,
    "statusUpdated": MessageLookupByLibrary.simpleMessage("Обновлено"),
    "stop": MessageLookupByLibrary.simpleMessage("Адключыць"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("Спыніць VPN"),
    "streakActiveToday": MessageLookupByLibrary.simpleMessage(
      "Агеньчык гарыць! Падключэнне сёння выканана.",
    ),
    "streakDaysCount": m32,
    "streakFlameTitle": MessageLookupByLibrary.simpleMessage("Вогненны стрык"),
    "streakInactiveToday": MessageLookupByLibrary.simpleMessage(
      "Агеньчык патух. Падключыцеся да 00:00 МСК, каб запаліць яго!",
    ),
    "streakMilestoneCongrats": m33,
    "streakNoRestoresLeft": MessageLookupByLibrary.simpleMessage(
      "Ліміт аднаўленняў на гэты месяц вычарпаны (максімум 3).",
    ),
    "streakNotificationBody": m34,
    "streakNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "🔥 Агеньчык хутка патухне!",
    ),
    "streakRestoreButton": MessageLookupByLibrary.simpleMessage(
      "Аднавіць агеньчык",
    ),
    "streakRestoredSuccess": MessageLookupByLibrary.simpleMessage(
      "Агеньчык паспяхова адноўлены!",
    ),
    "streakRestoresLeft": m35,
    "streakRuleRestore": MessageLookupByLibrary.simpleMessage(
      "• За адзін каляндарны месяц стрык можна аднавіць да 3 разоў у выпадку пропуску дня.",
    ),
    "streakRuleStorage": MessageLookupByLibrary.simpleMessage(
      "• Агеньчык захоўваецца лакальна на вашай прыладзе і выдаліцца толькі пры выдаленні праграмы.",
    ),
    "streakRuleTime": MessageLookupByLibrary.simpleMessage(
      "• Агеньчык абнаўляецца штодня ў 00:00 па МСК (12:00 AM UTC+3).",
    ),
    "streakRuleTitle": MessageLookupByLibrary.simpleMessage(
      "Правілы вогненнага стрыку",
    ),
    "style": MessageLookupByLibrary.simpleMessage("Стіль"),
    "subExpireReminder1d": MessageLookupByLibrary.simpleMessage(
      "Остался 1 день. Еслі вы уже продлці, то обновіте падпіску.",
    ),
    "subExpireReminder1h": MessageLookupByLibrary.simpleMessage(
      "Остался 1 час. Еслі вы уже продлці, то обновіте падпіску.",
    ),
    "subExpireReminder3d": MessageLookupByLibrary.simpleMessage(
      "Засталося 3 дня. Еслі вы уже продлці, то обновіте падпіску.",
    ),
    "subExpiredNotice": MessageLookupByLibrary.simpleMessage(
      "Срок действія вашей падпіскі істёк. Еслі вы уже продлці, то обновіте падпіску.",
    ),
    "subExpiredTitle": MessageLookupByLibrary.simpleMessage(
      "Падпіска скончылася",
    ),
    "subExpiringTitle": MessageLookupByLibrary.simpleMessage(
      "Падпіска скоро закончітся",
    ),
    "subRule": MessageLookupByLibrary.simpleMessage("Подправіла"),
    "subRuleEmpty": MessageLookupByLibrary.simpleMessage("Подправіла пусто"),
    "subRuleNotEmpty": MessageLookupByLibrary.simpleMessage(
      "Подправіла не может быть пустым",
    ),
    "submit": MessageLookupByLibrary.simpleMessage("Адправіть"),
    "subscriptionActivating": MessageLookupByLibrary.simpleMessage(
      "Актывацыя падпіскі...",
    ),
    "subscriptionExpiredDesc": MessageLookupByLibrary.simpleMessage(
      "Тэрмін дзеяння вашай падпіскі скончыўся. Калі ласка, працягніце яе для аднаўлення доступу",
    ),
    "subscriptionExpiredWarning": MessageLookupByLibrary.simpleMessage(
      "Тэрмін дзеяння падпіскі скончыўся",
    ),
    "subscriptionExpiringIn": m36,
    "subscriptionFoundInClipboard": MessageLookupByLibrary.simpleMessage(
      "Найдена падпіска в буфере обмена",
    ),
    "subscriptionFromClipboardHint": MessageLookupByLibrary.simpleMessage(
      "Із буфера обмена, по ссылке ці QR-коду",
    ),
    "subscriptionInactive": MessageLookupByLibrary.simpleMessage(
      "Падпіска неактыўная",
    ),
    "subscriptionInfo": MessageLookupByLibrary.simpleMessage(
      "Дадзеныя падпіскі",
    ),
    "subscriptionInvalidOrEmpty": MessageLookupByLibrary.simpleMessage(
      "Няправільная альбо пустая спасылка",
    ),
    "subscriptionNoChanges": MessageLookupByLibrary.simpleMessage(
      "Зменаў няма",
    ),
    "subscriptionRequired": MessageLookupByLibrary.simpleMessage(
      "Патрабуецца падпіска",
    ),
    "subscriptionRequiredDesc": MessageLookupByLibrary.simpleMessage(
      "Для карыстання сэрвісам дадайце спасылку на вашу падпіску",
    ),
    "subscriptionUpdated": MessageLookupByLibrary.simpleMessage(
      "Падпіска абноўлена",
    ),
    "supportEmail": MessageLookupByLibrary.simpleMessage("Электронная почта"),
    "supportLieVpn": MessageLookupByLibrary.simpleMessage("Падтрымка LieVPN"),
    "supportLieVpnTitle": MessageLookupByLibrary.simpleMessage(
      "Служба поддержкі LieVPN",
    ),
    "supportMessengerMax": MessageLookupByLibrary.simpleMessage(
      "Мессенджер MAX",
    ),
    "supportMessengerMaxSubtitle": MessageLookupByLibrary.simpleMessage(
      "Напісать в MAX",
    ),
    "supportProject": MessageLookupByLibrary.simpleMessage("Поддержать проект"),
    "suspended": MessageLookupByLibrary.simpleMessage("Пріостановлено..."),
    "sync": MessageLookupByLibrary.simpleMessage("Сінхронізація"),
    "system": MessageLookupByLibrary.simpleMessage("Сістэма"),
    "systemApp": MessageLookupByLibrary.simpleMessage("Сістемные праграмы"),
    "systemProxy": MessageLookupByLibrary.simpleMessage("Сістэмны проксі"),
    "systemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Усталяваць сістэмны HTTP/SOCKS проксі",
    ),
    "tab": MessageLookupByLibrary.simpleMessage("Вкладкі"),
    "tabAnimation": MessageLookupByLibrary.simpleMessage("Анімація вкладак"),
    "tabAnimationDesc": MessageLookupByLibrary.simpleMessage(
      "Действует только в мобільном віде",
    ),
    "tapToAuthorize": MessageLookupByLibrary.simpleMessage(
      "Нажміте, чтобы разрешіть",
    ),
    "tapToInsertSubscription": MessageLookupByLibrary.simpleMessage(
      "Нажміте, чтобы уставіць падпіску",
    ),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage("Паралельны TCP"),
    "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage(
      "Прі включеніі разрешает параллельные TCP-подключенія",
    ),
    "testInterval": MessageLookupByLibrary.simpleMessage(
      "Інтервал тестірованія",
    ),
    "testUrl": MessageLookupByLibrary.simpleMessage(
      "URL для праверкі затрымкі",
    ),
    "testWhenUsed": MessageLookupByLibrary.simpleMessage(
      "Тестіровать прі іспользованіі",
    ),
    "textScale": MessageLookupByLibrary.simpleMessage("Масштаб текста"),
    "theme": MessageLookupByLibrary.simpleMessage("Тэма"),
    "themeColor": MessageLookupByLibrary.simpleMessage("Колер тэмы"),
    "themeDesc": MessageLookupByLibrary.simpleMessage(
      "Налады знешняга выгляду",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Рэжым тэмы"),
    "tight": MessageLookupByLibrary.simpleMessage("Пладный"),
    "time": MessageLookupByLibrary.simpleMessage("Час"),
    "timeout": MessageLookupByLibrary.simpleMessage("Тайм-аут"),
    "tip": MessageLookupByLibrary.simpleMessage("Падказка"),
    "toggle": MessageLookupByLibrary.simpleMessage("Переключіть"),
    "toggleLabel": MessageLookupByLibrary.simpleMessage("Переключіть подпісі"),
    "tonalSpotScheme": MessageLookupByLibrary.simpleMessage("Тональный акцент"),
    "tools": MessageLookupByLibrary.simpleMessage("Інструменты"),
    "torch": MessageLookupByLibrary.simpleMessage("Фонарік"),
    "totalTraffic": MessageLookupByLibrary.simpleMessage("Агульны трафік"),
    "tproxyPort": MessageLookupByLibrary.simpleMessage("Порт TProxy"),
    "trafficUsage": MessageLookupByLibrary.simpleMessage(
      "Выкарыстанне трафіка",
    ),
    "tsarOfDonations": MessageLookupByLibrary.simpleMessage("Цар Даната"),
    "tt": MessageLookupByLibrary.simpleMessage("ТікТок / Мемы ⚡"),
    "tun": MessageLookupByLibrary.simpleMessage("Рэжым TUN"),
    "tunDesc": MessageLookupByLibrary.simpleMessage(
      "Перахоп усяго сістэмнага трафіка",
    ),
    "turnOff": MessageLookupByLibrary.simpleMessage("Выключыць"),
    "turnOn": MessageLookupByLibrary.simpleMessage("Уключыць"),
    "uk": MessageLookupByLibrary.simpleMessage("Українська"),
    "undo": MessageLookupByLibrary.simpleMessage("Адменіть"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage("Едіная затрымка"),
    "unifiedDelayDesc": MessageLookupByLibrary.simpleMessage(
      "Убірает лішніе затрымкі, напрімер рукопожатіе",
    ),
    "unknown": MessageLookupByLibrary.simpleMessage("Неізвестно"),
    "unknownNetworkError": MessageLookupByLibrary.simpleMessage(
      "Невядамая памылка сеткі",
    ),
    "unlimited": MessageLookupByLibrary.simpleMessage("Безлімітна"),
    "unmaximize": MessageLookupByLibrary.simpleMessage("Згарнуць в окно"),
    "unnamed": MessageLookupByLibrary.simpleMessage("Без названія"),
    "unpinWindow": MessageLookupByLibrary.simpleMessage("Адкрепіть окно"),
    "update": MessageLookupByLibrary.simpleMessage("Абнавіць"),
    "updateCheckError": MessageLookupByLibrary.simpleMessage(
      "Не удалось праверыць абнаўленні",
    ),
    "updateLater": MessageLookupByLibrary.simpleMessage("Позже"),
    "updateNow": MessageLookupByLibrary.simpleMessage("Абнавіць"),
    "updateSubscription": MessageLookupByLibrary.simpleMessage(
      "Абнавіць падпіску",
    ),
    "upload": MessageLookupByLibrary.simpleMessage("Загрузка"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage("Получіть профіль по URL"),
    "urlTip": m37,
    "useHosts": MessageLookupByLibrary.simpleMessage("Выкарыстоўваць hosts"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage(
      "Выкарыстоўваць сістэмны hosts",
    ),
    "usedTraffic": MessageLookupByLibrary.simpleMessage("Выкарыстана"),
    "userAgent": MessageLookupByLibrary.simpleMessage("User-Agent"),
    "userProfileHeader": MessageLookupByLibrary.simpleMessage(
      "// ПОЛЬЗОВАТЕЛЬ",
    ),
    "value": MessageLookupByLibrary.simpleMessage("Значеніе"),
    "vibrantScheme": MessageLookupByLibrary.simpleMessage("Яркая"),
    "view": MessageLookupByLibrary.simpleMessage("Просмадр"),
    "vpnConfigChangeDetected": MessageLookupByLibrary.simpleMessage(
      "Обнаружено ізмененіе настроек VPN",
    ),
    "vpnConnected": MessageLookupByLibrary.simpleMessage("VPN подключён"),
    "vpnDisconnected": MessageLookupByLibrary.simpleMessage("VPN адключён"),
    "vpnEnableDesc": MessageLookupByLibrary.simpleMessage(
      "Аўтаматычна направляет весь сістэмны трафік через VpnService",
    ),
    "vpnTip": MessageLookupByLibrary.simpleMessage(
      "Ізмененія вступят в сілу после перезапуска VPN",
    ),
    "webDAVConfiguration": MessageLookupByLibrary.simpleMessage(
      "Налада WebDAV",
    ),
    "whitelistMode": MessageLookupByLibrary.simpleMessage(
      "Режім белого спіска",
    ),
    "yearsAgo": m38,
    "zhCN": MessageLookupByLibrary.simpleMessage("简体中文"),
  };
}
