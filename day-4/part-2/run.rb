require 'date'
require_relative '../common/log'
require_relative '../common/log_processor'
require_relative '../common/guard'

processor = LogProcessor.new
chronological_logs_from_file('../input.txt').each { |log| processor.process_log(log) }

highest_frequency_sleeper = processor.guards.each_value.sort_by { |guard| guard.highest_sleep_frequency }.last
p highest_frequency_sleeper.id * highest_frequency_sleeper.highest_sleep_frequency_minute
