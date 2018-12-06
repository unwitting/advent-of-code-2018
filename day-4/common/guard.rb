class Guard
    attr_reader :sleep_minutes, :id

    def initialize(id)
        @id = id
        @sleep_minutes = Hash.new(0)
    end

    def add_sleep_between(min_start_inclusive, min_end_exclusive)
        return if min_start_inclusive.nil? || min_end_exclusive.nil?
        (min_start_inclusive..(min_end_exclusive - 1)).each { |m| sleep_minutes[m] += 1 }
    end

    def total_mins_asleep
        sleep_minutes.values.sum
    end

    def highest_sleep_frequency_minute
        sleep_minutes.keys.sort_by { |k| sleep_minutes[k] }.last
    end

    def highest_sleep_frequency
        sleep_minutes[highest_sleep_frequency_minute]
    end

    def most_common_sleep_minute
        top_amount = @sleep_minutes.each_value.sort.last
        sleep_minutes.each_key { |min| return min if @sleep_minutes[min] == top_amount }
    end
end