import json

with open('arb/intl_tt.arb', 'r', encoding='utf-8') as f:
    tt = json.load(f)

MEME_MAP = {
    # Actions & Buttons
    "save": "Засейвить и затащить",
    "delete": "Попустить в утиль",
    "edit": "Подкрутить под свой вайб",
    "apply": "Врубить с кайфом",
    "reset": "Дропнуть в дефолт",
    "cancel": "Дать заднюю",
    "confirm": "Базар, подтверждаю",
    "start": "Запустить, я щас могну",
    "stop": "Стопэ, отдохни",
    "startVpn": "Подрубить LieVPN (моггинг он)",
    "stopVpn": "Потушить LieVPN (ушел в тильт)",
    "download": "Дропнуть файлик",
    "search": "Найти нужную пикчу/движ",
    "retry": "Затащить катку заново",
    "cleanCache": "Вынести мусор как сигма",
    "cleanCacheSuccess": "Чиназес! Мусор попущен",

    # Statuses & Feedback
    "connected": "В сети! Вайб имба, магнул всех",
    "disconnected": "Не в сети. Нормис в тильте",
    "connecting": "Подрубаем тягу... Ща могну",
    "reconnecting": "Сервак залагал, перезатаскиваем...",
    "success": "Чиназес сюдааа! Имба",
    "error": "Анлак лютый / Кринжометр зашкалил",
    "warning": "Алярм! Тут скуф пробегал",
    "notice": "Пон, вот тебе инфа",
    "loading": "Чекаем пруфы, погоди...",
    
    # Live Notification
    "liveNotification": "Live-уведомление (чип сигмы)",
    "liveNotificationDesc": "Вывести статус в шторку и статус-бар",
    "liveNotificationType": "Чо показывать в чипе",
    "liveNotificationTypeDesc": "Настрой чип под свой флекс",
    "liveNotificationTypeUsername": "Погоняло сигмы",
    "liveNotificationTypeTraffic": "Слитый трафик (гиги)",
    "liveNotificationTypeSpeed": "Турбо-флекс (Download + Upload)",
    "liveNotificationTypeSpeedDown": "Скорость дропа (Download)",
    "liveNotificationTypeSpeedUp": "Скорость флекса (Upload)",
    "liveNotificationTypeServer": "Сервак и флаг страны",
    "liveNotificationTypePing": "Пинг в катке (мс)",
    "liveNotificationTypeCustom": "Свой мемный слоган",
    "liveNotificationCustomText": "Твой кастомный текст",
    "liveNotificationCustomTextDesc": "Напиши сюда мемчик или флекс",

    # Subscriptions & Account
    "subscription": "Сабка на VPN",
    "subscriptionInfo": "Пруфы по сабке",
    "subscriptionUrl": "Линк на подписку",
    "subscriptionRequired": "Без сабки ты нормис, подруби!",
    "subscriptionRequiredDesc": "Залутай сабку у бота @liesubbot и могай интернет без тормозов",
    "subscriptionInactive": "Сабка спит, ты попущен",
    "subscriptionExpiredDesc": "Сабка рипнулась! Закинь шекелей тяночке-боту, чтоб снова флексить",
    "insertSubscriptionUrl": "Вставить линк на сабку",
    "scanQrCode": "Счелкнуть QR подкрадулями",
    "checkUpdateStatus": "Чекнуть статус сабки",
    "enterSubscriptionUrl": "Закинь линк сюда",
    "subscriptionActivating": "Активируем сабку... Сигма мод on",
    "subscriptionInvalidOrEmpty": "Линк битый, кринж лютый",
    "subscriptionUpdated": "Сабка свежая, чиназес!",
    "subscriptionNoChanges": "И так всё имба, не душни",
    "notLieVpnSubscription": "Это не LieVPN, не по масти",
    "subExpiredTitle": "Финал сабки, анлак",
    "expirationDate": "Дедлайн кайфа",
    "buyInTelegram": "Залутать сабку в TG (@liesubbot)",
    "renew": "Продлить кайф",
    "renewSubscription": "Продлить сабку и могать дальше",
    "serverNotRespondingReconnecting": "Сервак откинулся. Переподрубаем суету...",
    "tsarOfDonations": "Гигачад Донатов (Царь)",
    "subscriptionExpiredWarning": "Сабка сдулась, пора донатить",

    # UI & Navigation
    "dashboard": "Главный Вайб",
    "proxies": "Серваки",
    "profiles": "Конфиги",
    "tools": "Приблуды",
    "rules": "Понятия (База)",
    "logs": "Пруфы и логи",
    "connections": "Коннекты",
    "networkSpeed": "Турбо-скорость",
    "trafficUsage": "Слито гигов",
    "outboundMode": "Траектория трафика",
    "networkDetection": "Чек пинга",
    "usedTraffic": "Уже потратил",
    "expireTime": "Когда сгорит",
    "nullProfileDesc": "Конфигов нет, ты в тильте",
    "defaultText": "Чисто дефолт",
    "more": "Ещё больше суеты",
    
    # Settings & Customization
    "theme": "Шкурка интерфейса",
    "themeDesc": "Кастомный визуал для глаз",
    "themeModeLight": "Светлая (вырвиглаз)",
    "themeModeDark": "Тёмная (для ночных сигм)",
    "themeModeSystem": "Как на мобиле/пк",
    "primaryColor": "Цвет хайпа",
    "pureBlack": "Чернее ночи (для альтушек)",
    "pureBlackDesc": "Экономит батарею, чистый амолед",
    "accessControl": "Фейсконтроль приложух",
    "accessControlDesc": "Кому дать зелёный свет, кого попустить",
    "accessControlModeAcceptSelected": "Только краши (выбранные)",
    "accessControlModeRejectSelected": "Все, кроме кринжовых",
    "hotkey": "Бинды для про-геймеров",
    "backupAndSync": "Сейв в облако",
    "backupAndSyncDesc": "Засейвить настройки, чтоб не словить тильт",
    "about": "Чо за прога вообще",
    "aboutDesc": "Инфа за LieVPN, версию и движок",
    "support": "Хелпа / Саппорт",
    "supportDesc": "Если залагало или словил кринж — пиши",
    "personalAccount": "Кабинет гигачада",
    "personalAccountDesc": "Чекай баланс и дни сабки",
    
    # Update & Core
    "checkUpdate": "Чекнуть апдейты",
    "checkUpdateDesc": "Позырить, не дропнули ли новый билд",
    "checkingUpdate": "Ищем свежий дроп...",
    "updateAvailable": "Новый дроп подъехал! Забирай",
    "alreadyLatestVersion": "У тебя самый свежий фарш, ты магнул систему",
    "currentVersion": "Твой билд",
    "latestVersion": "Свежий дроп",
    "update": "Обновиться с кайфом",
    
    # Support dialogs
    "supportTitle": "Саппорт LieVPN",
    "supportContactAdmin": "Чиркануть админу в ЛС",
    "supportChannel": "Официальный новостной канал",
    "supportChat": "Чат кентов и сигм",
    "supportInstruction": "Гайд для нормисов (пошагово)",
    "supportFaq": "База ответов на тупые вопросы",
    "supportTelegram": "Телега поддержки",
    "donators": "Топ донатеров (Гигачады)",
    "donatorsDesc": "Респект тем, кто держит проект на плаву",
    "appTitle": "LieVPN",
    "appDesc": "Ультимативный VPN, чтоб могать цензуру и быть на чиле",
}

for k, v in MEME_MAP.items():
    tt[k] = v

with open('arb/intl_tt.arb', 'w', encoding='utf-8') as f:
    json.dump(tt, f, ensure_ascii=False, indent=2)

print("Enriched intl_tt.arb with varied slang!")
