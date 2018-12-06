class Log
    attr_reader :raw_string, :datetime, :action_string

    def self.parse_raw_line(raw_log_line)
        return WakeUpLog.new(raw_log_line) if raw_log_line.include? 'wakes up'
        return FallsAsleepLog.new(raw_log_line) if raw_log_line.include? 'falls asleep'
        return BeginShiftLog.new(raw_log_line) if raw_log_line.include? 'begins shift'
    end

    def initialize(raw_string)
        @raw_string = raw_string.chomp
        populate_from_raw_string
    end

    def populate_from_raw_string
        match = /^\[(.+)\] (.*)$/.match(raw_string)
        @datetime = DateTime.parse(match[1])
        @action_string = match[2]
    end

    def guard_falls_asleep?
        false
    end

    def get_new_guard
        nil
    end
end

class BeginShiftLog < Log
    attr_reader :guard_id

    def populate_from_raw_string
        super
        @guard_id = /Guard #(\d+) begins/.match(raw_string)[1].to_i
    end

    def get_new_guard
        guard_id
    end
end

class FallsAsleepLog < Log
    def guard_falls_asleep?
        true
    end
end

class WakeUpLog < Log
end

def raw_log_lines_from_file(path)
    File.open(path, 'r') { |f| f.each_line.to_a }
end

def chronological_sort(logs)
    logs.sort_by { |log| log.datetime }
end

def chronological_logs_from_file(path)
    chronological_sort(
        raw_log_lines_from_file(path).map { |l| Log.parse_raw_line(l) }
    )
end
