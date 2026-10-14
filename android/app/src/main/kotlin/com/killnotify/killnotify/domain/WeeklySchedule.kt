package com.killnotify.killnotify.domain

import java.time.DayOfWeek
import java.time.Instant
import java.time.LocalDate
import java.time.LocalTime
import java.time.ZoneId

data class ScheduleInterval(
    val dayIndex: Int,
    val startMinute: Int,
    val endMinute: Int,
)

/** A half-open range on the week clock. endMinute may exceed one week for Sunday-to-Monday ranges. */
data class EffectiveRange(val startMinute: Int, val endMinute: Int) {
    fun contains(minuteOfWeek: Int): Boolean =
        if (endMinute <= WeeklyScheduleEngine.MINUTES_PER_WEEK) {
            minuteOfWeek >= startMinute && minuteOfWeek < endMinute
        } else {
            minuteOfWeek >= startMinute || minuteOfWeek < endMinute - WeeklyScheduleEngine.MINUTES_PER_WEEK
        }
}

data class DailyWindow(val dayIndex: Int, val startMinute: Int, val endMinute: Int)

data class ScheduleDecision(
    val allowed: Boolean,
    val nextStartEpochMillis: Long?,
    val effectiveRanges: List<EffectiveRange>,
)

object WeeklyScheduleEngine {
    const val MINUTES_PER_DAY = 24 * 60
    const val MINUTES_PER_WEEK = 7 * MINUTES_PER_DAY

    private data class LinearRange(val start: Int, val end: Int)

    /** Coalesces overlaps and touching boundaries without changing the stored input intervals. */
    fun normalize(intervals: List<ScheduleInterval>): List<EffectiveRange> {
        validate(intervals)
        if (intervals.isEmpty()) return emptyList()

        val segments = intervals.flatMap { interval ->
            val start = interval.dayIndex * MINUTES_PER_DAY + interval.startMinute
            val duration = (interval.endMinute - interval.startMinute).let { delta ->
                if (delta <= 0) delta + MINUTES_PER_DAY else delta
            }
            val end = start + duration
            if (end <= MINUTES_PER_WEEK) {
                listOf(LinearRange(start, end))
            } else {
                listOf(
                    LinearRange(start, MINUTES_PER_WEEK),
                    LinearRange(0, end - MINUTES_PER_WEEK),
                )
            }
        }.sortedWith(compareBy(LinearRange::start, LinearRange::end))

        val merged = mutableListOf<LinearRange>()
        segments.forEach { segment ->
            val previous = merged.lastOrNull()
            if (previous != null && segment.start <= previous.end) {
                merged[merged.lastIndex] = LinearRange(previous.start, maxOf(previous.end, segment.end))
            } else {
                merged += segment
            }
        }

        if (merged.size == 1 && merged[0].start == 0 && merged[0].end == MINUTES_PER_WEEK) {
            return listOf(EffectiveRange(0, MINUTES_PER_WEEK))
        }

        val wrapsWeek = merged.size > 1 && merged.first().start == 0 && merged.last().end == MINUTES_PER_WEEK
        if (!wrapsWeek) return merged.map { EffectiveRange(it.start, it.end) }

        val wrapped = EffectiveRange(
            startMinute = merged.last().start,
            endMinute = MINUTES_PER_WEEK + merged.first().end,
        )
        return merged.drop(1).dropLast(1).map { EffectiveRange(it.start, it.end) } + wrapped
    }

    fun evaluate(
        intervals: List<ScheduleInterval>,
        nowEpochMillis: Long = System.currentTimeMillis(),
        zone: ZoneId = ZoneId.systemDefault(),
    ): ScheduleDecision {
        val ranges = normalize(intervals)
        if (intervals.isEmpty()) return ScheduleDecision(true, null, ranges)

        val now = Instant.ofEpochMilli(nowEpochMillis).atZone(zone)
        val minuteOfWeek = minuteOfWeek(now.toLocalDate(), now.toLocalTime())
        val allowed = ranges.any { it.contains(minuteOfWeek) }
        if (allowed) return ScheduleDecision(true, null, ranges)

        val monday = now.toLocalDate().minusDays((now.dayOfWeek.value - DayOfWeek.MONDAY.value).toLong())
        val nextStart = ranges.asSequence()
            .flatMap { range ->
                val dayOffset = range.startMinute / MINUTES_PER_DAY
                val minuteInDay = range.startMinute % MINUTES_PER_DAY
                (0L..2L).map { weekOffset ->
                    val localDate = monday.plusDays(dayOffset + weekOffset * 7)
                    localDate.atTime(LocalTime.of(minuteInDay / 60, minuteInDay % 60))
                        .atZone(zone)
                        .toInstant()
                        .toEpochMilli()
                }
            }
            .filter { it > nowEpochMillis }
            .minOrNull()

        return ScheduleDecision(false, nextStart, ranges)
    }

    fun toDailyWindows(ranges: List<EffectiveRange>): List<DailyWindow> {
        val segments = ranges.flatMap { range ->
            if (range.endMinute <= MINUTES_PER_WEEK) {
                listOf(LinearRange(range.startMinute, range.endMinute))
            } else {
                listOf(
                    LinearRange(range.startMinute, MINUTES_PER_WEEK),
                    LinearRange(0, range.endMinute - MINUTES_PER_WEEK),
                )
            }
        }
        return segments.flatMap { segment ->
            buildList {
                var cursor = segment.start
                while (cursor < segment.end) {
                    val day = cursor / MINUTES_PER_DAY
                    val end = minOf(segment.end, (day + 1) * MINUTES_PER_DAY)
                    add(DailyWindow(day, cursor % MINUTES_PER_DAY, end - day * MINUTES_PER_DAY))
                    cursor = end
                }
            }
        }.sortedWith(compareBy(DailyWindow::dayIndex, DailyWindow::startMinute))
    }

    fun validate(intervals: List<ScheduleInterval>) {
        intervals.forEachIndexed { index, interval ->
            require(interval.dayIndex in 0..6) { "Interval $index has an invalid day index." }
            require(interval.startMinute in 0 until MINUTES_PER_DAY) { "Interval $index has an invalid start minute." }
            require(interval.endMinute in 0 until MINUTES_PER_DAY) { "Interval $index has an invalid end minute." }
        }
    }

    private fun minuteOfWeek(date: LocalDate, time: LocalTime): Int =
        (date.dayOfWeek.value - DayOfWeek.MONDAY.value) * MINUTES_PER_DAY +
            time.hour * 60 + time.minute
}
