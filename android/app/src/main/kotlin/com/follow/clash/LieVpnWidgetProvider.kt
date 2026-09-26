package com.follow.clash

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.RemoteViews
import com.follow.clash.common.QuickAction
import com.follow.clash.common.quickIntent
import com.follow.clash.common.toPendingIntent

class LieVpnWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        val runState = ServiceState.runState.value
        for (widgetId in appWidgetIds) {
            val options = appWidgetManager.getAppWidgetOptions(widgetId)
            updateWidget(context, appWidgetManager, widgetId, runState, options)
        }
    }

    override fun onAppWidgetOptionsChanged(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int,
        newOptions: Bundle
    ) {
        val runState = ServiceState.runState.value
        updateWidget(context, appWidgetManager, appWidgetId, runState, newOptions)
    }

    companion object {
        fun updateAllWidgets(context: Context, runState: RunState) {
            val manager = AppWidgetManager.getInstance(context)
            val ids = manager.getAppWidgetIds(ComponentName(context, LieVpnWidgetProvider::class.java))
            for (widgetId in ids) {
                val options = manager.getAppWidgetOptions(widgetId)
                updateWidget(context, manager, widgetId, runState, options)
            }
        }

        private fun updateWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            widgetId: Int,
            runState: RunState,
            options: Bundle?
        ) {
            val views = RemoteViews(context.packageName, R.layout.widget_vpn_adaptive)

            // Dynamic size check: minWidth in dp
            val minWidth = options?.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_WIDTH) ?: 0
            val isCompact = minWidth < 110

            if (isCompact) {
                views.setViewVisibility(R.id.widget_text_container, View.GONE)
            } else {
                views.setViewVisibility(R.id.widget_text_container, View.VISIBLE)
            }

            val isConnected = runState == RunState.STARTED
            val isBusy = runState == RunState.STARTING || runState == RunState.STOPPING

            if (isConnected) {
                views.setInt(R.id.widget_btn_toggle, "setBackgroundResource", R.drawable.widget_bg_circle_active)
                views.setTextViewText(R.id.widget_status, context.getString(R.string.vpn_connected))
                views.setTextColor(R.id.widget_status, 0xFF22C55E.toInt())
            } else if (isBusy) {
                views.setInt(R.id.widget_btn_toggle, "setBackgroundResource", R.drawable.widget_bg_circle)
                views.setTextViewText(R.id.widget_status, "...")
                views.setTextColor(R.id.widget_status, 0xFFEAB308.toInt())
            } else {
                views.setInt(R.id.widget_btn_toggle, "setBackgroundResource", R.drawable.widget_bg_circle)
                views.setTextViewText(R.id.widget_status, context.getString(R.string.vpn_disconnected))
                views.setTextColor(R.id.widget_status, 0xFF9E9E9E.toInt())
            }

            // Click pending intent -> Toggle action
            val toggleIntent = QuickAction.TOGGLE.quickIntent
            val pendingIntent = toggleIntent.toPendingIntent
            views.setOnClickPendingIntent(R.id.widget_container, pendingIntent)
            views.setOnClickPendingIntent(R.id.widget_btn_toggle, pendingIntent)

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
