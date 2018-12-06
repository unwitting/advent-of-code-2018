require 'date'
require_relative '../common/log'
require_relative '../common/log_processor'
require_relative '../common/guard'

processor = LogProcessor.new
chronological_logs_from_file('../input.txt').each { |log| processor.process_log(log) }

top_sleeping_guard = processor.guards.each_value.sort_by { |guard| guard.total_mins_asleep }.last
p top_sleeping_guard.id * top_sleeping_guard.most_common_sleep_minute
