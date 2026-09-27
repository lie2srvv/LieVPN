package com.follow.clash.service.models

data class NotificationParams(
    val title: String = "LieVPN",
    val stopText: String = "STOP",
    val onlyStatisticsProxy: Boolean = false,
    val showStopAction: Boolean = true,
    val liveNotification: Boolean = false,
    val liveNotificationType: Int = 0,
    val liveNotificationCustomText: String = "",
    val currentServerName: String = "",
    val currentServerPing: Int = 0,
)
