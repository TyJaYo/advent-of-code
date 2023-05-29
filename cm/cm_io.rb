 #!/usr/bin/env ruby
require 'csv'
require 'pry'

class CmIo
  INPUT_DIR   = '/Users/tyleryoung/projects/advent-of-code/cm/inputs'
  OUTPUT_DIR  = '/Users/tyleryoung/projects/advent-of-code/cm/outputs'
  TIMESTAMP   = Time.new.strftime('%d_%I%M')
  OUTPUT_FILE = "#{OUTPUT_DIR}/questions#{TIMESTAMP}.csv"
  LETTERS     = ('A'..'E').to_a
  HEADERS     = [
    'source',
    'question',
    'correct_answer',
    'answer_option_2',
    'answer_option_3',
    'answer_option_4',
    'answer_option_5',
    'explanation'
  ]

  def initialize
    @filename  = ''
    @csv_rows  = []
    @all_files = []
  end

  def process
    puts TIMESTAMP
    gather_txt_files
    extract_from_files
    export_csv
  end

  def gather_txt_files
    @all_files = Dir.glob("#{@file_path.to_s}/**/*.{txt,TXT}")
  end

  def extract_from_files
    @all_files.each do |txt_file|
      @filename = File.basename(txt_file)
      text = File.read(txt_file)
      extract_from_text(text)
    end
  end

  def extract_from_text(text)
    items = text.scan(/\n(Q\. )?(.*?)\n[A-E][.)]\s+(.*?)\n[A-E][.)]\s+(.*?)\n[A-E][.)]\s+(.*?)\n[A-E][.)]\s+(.*?)\n[A-E][.)]\s+(.*?)$/)
    if items.empty?
      items = text.scan(/\n(Q\. )?(.*?)\n[A-D][.)]\s+(.*?)\n[A-D][.)]\s+(.*?)\n[A-D][.)]\s+(.*?)\n[A-D][.)]\s+(.*?)$/)
      items.each do |item|
        parse(item)
      end
    else
      explanations = text.scan(/The correct answer is \(([A-E])\)\. (.*?)$/)
      items.each_with_index do |item, idx|
        parse(item, explanations[idx])
      end
    end
  end

  def parse(item, explanation = nil)
    _, question, correct_answer, answer_option_2, answer_option_3, answer_option_4, answer_option_5 = item
    if explanation
      letter = explanation.first
      unless letter == 'A'
        answer_array = [correct_answer, answer_option_2, answer_option_3, answer_option_4, answer_option_5]
        answer_array.prepend(answer_array.delete_at(LETTERS.find_index(letter)))
        correct_answer, answer_option_2, answer_option_3, answer_option_4, answer_option_5 = answer_array
      end
    end
    row = [
      @filename,
      question,
      correct_answer,
      answer_option_2,
      answer_option_3,
      answer_option_4,
      answer_option_5,
      explanation&.last
    ]
    row.map { |c| c&.strip! }
    @csv_rows << row
  end

  def export_csv
    csv = CSV.open(OUTPUT_FILE, 'w')
    csv << HEADERS
    @csv_rows.each { |row| csv << row }
  end
end

processor = CmIo.new
processor.process
