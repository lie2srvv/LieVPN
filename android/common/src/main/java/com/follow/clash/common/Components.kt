package com.follow.clash.common

import android.content.ComponentName

object Components {
    const val PACKAGE_NAME = "com.lie2srvv.vpn"
    private const val CLASS_PREFIX = "com.follow.clash"

    val mainActivity =
        ComponentName(GlobalState.packageName, "${CLASS_PREFIX}.MainActivity")

    val quickActionActivity =
        ComponentName(GlobalState.packageName, "${CLASS_PREFIX}.QuickActionActivity")

    val serviceBroadcastReceiver =
        ComponentName(GlobalState.packageName, "${CLASS_PREFIX}.ServiceBroadcastReceiver")
}
