package com.follow.clash.models

import com.follow.clash.service.models.VpnOptions
import com.google.gson.annotations.SerializedName

data class SharedState(
    val startTip: String = "Starting VPN...",
    val stopTip: String = "Stopping VPN...",
    val crashlytics: Boolean = true,
    val currentProfileName: String = "LieVPN",
    val stopText: String = "Stop",
    val onlyStatisticsProxy: Boolean = false,
    val showStopAction: Boolean = true,
    val liveNotification: Boolean = false,
    val liveNotificationType: Int = 0,
    val liveNotificationCustomText: String = "",
    val currentServerName: String = "",
    val currentServerPing: Int = 0,
    val vpnOptions: VpnOptions? = null,
    val setupParams: SetupParams? = null,
)

data class SetupParams(
    @SerializedName("test-url")
    val testUrl: String,
    @SerializedName("selected-map")
    val selectedMap: Map<String, String>,
)
