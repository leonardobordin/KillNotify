package com.killnotify.killnotify.domain

import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

class NotificationBypassPolicyTest {
    @Test
    fun `temporary exception is active only before its expiry`() {
        assertTrue(NotificationBypassPolicy.temporaryExceptionActive(2_000L, 1_999L))
        assertFalse(NotificationBypassPolicy.temporaryExceptionActive(2_000L, 2_000L))
        assertFalse(NotificationBypassPolicy.temporaryExceptionActive(2_000L, 2_001L))
        assertFalse(NotificationBypassPolicy.temporaryExceptionActive(null, 1_000L))
    }

    @Test
    fun `only configured Android call and alarm categories bypass`() {
        assertTrue(NotificationBypassPolicy.categoryExceptionApplies("call", true, false))
        assertFalse(NotificationBypassPolicy.categoryExceptionApplies("call", false, true))
        assertTrue(NotificationBypassPolicy.categoryExceptionApplies("alarm", false, true))
        assertFalse(NotificationBypassPolicy.categoryExceptionApplies("alarm", true, false))
        assertFalse(NotificationBypassPolicy.categoryExceptionApplies("message", true, true))
        assertFalse(NotificationBypassPolicy.categoryExceptionApplies(null, true, true))
    }
}
