#----------------------------------------------------------------------
#
#   Tech support specialist should only perform device updates during
#   core business hours (10:00 to 15:00 GMT).

package acmecorp.devices

default allow = false

allow = true {
    input.action = "UpdateDevice"
    input.subject.groups[_] = "support"
    inside_business_hours
}

inside_business_hours = true {
    [hour, minute, second] := time.clock(time.now_ns())
    time_of_day := (hour * seconds_per_hour) + (minute * seconds_per_minute) + second
    min := 10 * seconds_per_hour
    max := 15 * seconds_per_hour
    time_of_day >= min
    time_of_day <= max
}

input = data.examples.devices.support.update

seconds_per_hour = seconds_per_minute * seconds_per_minute

seconds_per_minute = 60
