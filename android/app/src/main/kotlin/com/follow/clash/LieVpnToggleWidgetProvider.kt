package com.follow.clash

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews
import com.follow.clash.common.QuickAction
import com.follow.clash.common.action

class LieVpnToggleWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        val currentState = ServiceState.runState.value
        for (appWidgetId in appWidgetIds) {
            updateWidget(context, appWidgetManager, appWidgetId, currentState)
        }
    }

    companion object {
        fun updateAllWidgets(context: Context, state: RunState) {
            val manager = AppWidgetManager.getInstance(context) ?: return
            val ids = manager.getAppWidgetIds(ComponentName(context, LieVpnToggleWidgetProvider::class.java))
            if (ids == null || ids.isEmpty()) return
            for (id in ids) {
                updateWidget(context, manager, id, state)
            }
        }

        private fun updateWidget(
            context: Context,
            manager: AppWidgetManager,
            appWidgetId: Int,
            state: RunState
        ) {
            val views = RemoteViews(context.packageName, R.layout.widget_toggle_icon)

            // Red fox when inactive (STOPPED), green fox when active (STARTED/STARTING/STOPPING)
            val foxRes = when (state) {
                RunState.STARTED -> R.drawable.ic_widget_fox_green
                RunState.STARTING, RunState.STOPPING -> R.drawable.ic_widget_fox_green
                RunState.STOPPED -> R.drawable.ic_widget_fox_red
            }
            views.setImageViewResource(R.id.widget_fox, foxRes)

            val toggleIntent = Intent(context, QuickActionActivity::class.java).apply {
                action = QuickAction.TOGGLE.action
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
            }
            val pendingIntent = PendingIntent.getActivity(
                context,
                0,
                toggleIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            views.setOnClickPendingIntent(R.id.widget_container, pendingIntent)

            manager.updateAppWidget(appWidgetId, views)
        }
    }
}
