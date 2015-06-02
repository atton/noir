class Noir::Command::Summarize::Note::Weekly < Noir::Base::Command
  @description = 'summarize notes weekly'

  extend Noir::Util::Weekly
  TimeFormat = '%Y%m%d'

  def self.summarize_by_week separator_day_of_week, week_diff=0
    begin_note = begin_of_week_separeted(separator_day_of_week, week_diff).strftime(TimeFormat)
    end_note   = end_of_week_separeted(separator_day_of_week, week_diff).strftime(TimeFormat)

    note_names = (begin_note..end_note).map{|n| Dir.glob("*#{n}*").first}.compact
    puts note_names.flat_map {|name| ['-----' + name + '-----', File.read(name) ]}.join("\n")
  end
end

require 'noir/command/summarize/note/weekly/monday'
