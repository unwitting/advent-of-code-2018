class LogProcessor
    attr_reader :current_guard_id, :guards, :current_guard_fell_asleep_at, :guard_sleep_minutes

    def initialize
        @current_guard_id = nil
        @guards = Hash.new { |hash, guard_id| hash[guard_id] = Guard.new(guard_id) }
        @current_guard_fell_asleep_at = nil
        @guard_sleep_minutes = {}
    end

    def process_log(log)
        new_guard = log.get_new_guard
        if !new_guard.nil?
            @current_guard_id = new_guard
        end
        current_guard = guards[current_guard_id]
        if log.guard_falls_asleep?
            @current_guard_fell_asleep_at = log.datetime.minute
        else
            current_guard.add_sleep_between(current_guard_fell_asleep_at, log.datetime.minute)
        end
    end
end