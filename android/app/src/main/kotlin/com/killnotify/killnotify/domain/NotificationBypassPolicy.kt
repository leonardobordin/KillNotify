package com.killnotify.killnotify.domain

object NotificationBypassPolicy {
    fun temporaryExceptionActive(untilEpochMillis: Long?, nowEpochMillis: Long): Boolean =
        untilEpochMillis != null && nowEpochMillis < untilEpochMillis

    fun categoryExceptionApplies(
        category: String?,
        allowCalls: Boolean,
        allowAlarms: Boolean,
    ): Boolean = when (category) {
        "call" -> allowCalls
        "alarm" -> allowAlarms
        else -> false
    }
}
