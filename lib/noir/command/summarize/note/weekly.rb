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

# Sub commands: specific day of week
[:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday].each do |day|
  clazz = Class.new(Noir::Base::TerminalCommand)
  clazz.class_eval do
    @description = "summarize notes weekly separated by #{day}"
    @day_of_week = day
  end
  clazz.class_eval do
    def self.execute *args
      week_diff = args.first.to_i || 0
      Noir::Command::Summarize::Note::Weekly.summarize_by_week @day_of_week, week_diff
    end
  end
  Noir::Command::Summarize::Note::Weekly.const_set(day.capitalize, clazz)
end
