package com.killnotify.killnotify.domain

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.ZoneId

class WeeklyScheduleEngineTest {
    private val utc = ZoneId.of("UTC")

    @Test
    fun `no configured interval allows notifications`() {
        val decision = WeeklyScheduleEngine.evaluate(emptyList(), instant(2026, 10, 12, 8, 30), utc)

        assertTrue(decision.allowed)
        assertNull(decision.nextStartEpochMillis)
    }

    @Test
    fun `weekly interval includes start and excludes end`() {
        val monday = listOf(ScheduleInterval(dayIndex = 0, startMinute = 9 * 60, endMinute = 10 * 60))

        assertTrue(WeeklyScheduleEngine.evaluate(monday, instant(2026, 10, 12, 9, 0), utc).allowed)
        assertTrue(WeeklyScheduleEngine.evaluate(monday, instant(2026, 10, 12, 9, 59), utc).allowed)
        val atEnd = WeeklyScheduleEngine.evaluate(monday, instant(2026, 10, 12, 10, 0), utc)
        assertFalse(atEnd.allowed)
        assertEquals(instant(2026, 10, 19, 9, 0), atEnd.nextStartEpochMillis)
    }

    @Test
    fun `overnight interval belongs to its start day`() {
        val tuesdayNight = listOf(ScheduleInterval(dayIndex = 1, startMinute = 22 * 60, endMinute = 2 * 60))

        assertTrue(WeeklyScheduleEngine.evaluate(tuesdayNight, instant(2026, 10, 13, 23, 0), utc).allowed)
        assertTrue(WeeklyScheduleEngine.evaluate(tuesdayNight, instant(2026, 10, 14, 1, 59), utc).allowed)
        assertFalse(WeeklyScheduleEngine.evaluate(tuesdayNight, instant(2026, 10, 14, 2, 0), utc).allowed)
    }

    @Test
    fun `equal endpoints mean a full day`() {
        val fullMonday = listOf(ScheduleInterval(dayIndex = 0, startMinute = 12 * 60, endMinute = 12 * 60))

        assertTrue(WeeklyScheduleEngine.evaluate(fullMonday, instant(2026, 10, 12, 12, 0), utc).allowed)
        assertTrue(WeeklyScheduleEngine.evaluate(fullMonday, instant(2026, 10, 13, 11, 59), utc).allowed)
        assertFalse(WeeklyScheduleEngine.evaluate(fullMonday, instant(2026, 10, 13, 12, 0), utc).allowed)
    }

    @Test
    fun `overlapping and adjacent intervals coalesce for the effective policy`() {
        val input = listOf(
            ScheduleInterval(0, 9 * 60, 10 * 60),
            ScheduleInterval(0, 10 * 60, 11 * 60),
            ScheduleInterval(0, 9 * 60 + 30, 10 * 60 + 30),
        )

        assertEquals(listOf(DailyWindow(0, 9 * 60, 11 * 60)),
            WeeklyScheduleEngine.toDailyWindows(WeeklyScheduleEngine.normalize(input)))
        assertEquals(3, input.size)
    }

    @Test
    fun `Sunday to Monday range is coalesced across week boundary`() {
        val input = listOf(
            ScheduleInterval(6, 23 * 60, 60),
            ScheduleInterval(0, 30, 90),
        )

        assertEquals(
            listOf(DailyWindow(0, 0, 90), DailyWindow(6, 23 * 60, 1440)),
            WeeklyScheduleEngine.toDailyWindows(WeeklyScheduleEngine.normalize(input)),
        )
        assertTrue(WeeklyScheduleEngine.evaluate(input, instant(2026, 10, 12, 0, 30), utc).allowed)
        assertTrue(WeeklyScheduleEngine.evaluate(input, instant(2026, 10, 18, 23, 15), utc).allowed)
    }

    @Test
    fun `seven all-day rules normalize to a full week`() {
        val fullWeek = (0..6).map { ScheduleInterval(it, 0, 0) }

        assertEquals(listOf(EffectiveRange(0, WeeklyScheduleEngine.MINUTES_PER_WEEK)),
            WeeklyScheduleEngine.normalize(fullWeek))
        assertTrue(WeeklyScheduleEngine.evaluate(fullWeek, instant(2026, 10, 15, 13, 40), utc).allowed)
    }

    @Test(expected = IllegalArgumentException::class)
    fun `invalid day index is rejected`() {
        WeeklyScheduleEngine.normalize(listOf(ScheduleInterval(7, 0, 30)))
    }

    private fun instant(year: Int, month: Int, day: Int, hour: Int, minute: Int): Long =
        LocalDateTime.of(LocalDate.of(year, month, day), java.time.LocalTime.of(hour, minute))
            .atZone(utc)
            .toInstant()
            .toEpochMilli()
}
