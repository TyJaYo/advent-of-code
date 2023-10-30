 #!/usr/bin/env ruby
require 'csv'
require 'pry'

# textutil -convert txt /Users/tyleryoung/projects/advent-of-code/cm/inputs/*.docx

class CmIo
  INPUT_DIR   = '/Users/tyleryoung/projects/advent-of-code/cm/inputs'
  OUTPUT_DIR  = '/Users/tyleryoung/projects/advent-of-code/cm/outputs'
  TIMESTAMP   = Time.new.strftime('%d_%I%M')
  OUTPUT_FILE = "#{OUTPUT_DIR}/questions#{TIMESTAMP}.csv"
  # OUTPUT_FILE = "#{OUTPUT_DIR}/test.csv"
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
    @all_files = Dir.glob("#{INPUT_DIR}/**/*.txt")
  end

  def process
    puts TIMESTAMP
    extract_from_files
    export_csv
  end

  def extract_from_files
    @all_files.each do |file|
      @filename = File.basename(file)
      puts "Reading #{@filename}..."
      text = File.read(file)
      extract_from_text(text)
    end
  end

  def extract_from_text(text)
    text = text.gsub(/^\s+•\s+$/, '')
    text = text.gsub(/^\s+•\s+/, '')
    items = text.scan(/\n([Q\d][\d\w\s]*[.:] )?(.*?)[\n ][A-Ea-e][.)]\s+(.*?)[\n ][A-Ea-e][.)]\s+(.*?)[\n ][A-Ea-e][.)]\s+(.*?)[\n ][A-Ea-e][.)]\s+(.*?)[\n ][A-Ea-e][.)]\s+(.*?)$/)
    if items.empty?
      items = text.scan(/\n([Q\d][\d\w\s]*[.:] )?(.*?)[\n ][A-Ea-e][.)]\s+(.*?)[\n ][A-Ea-e][.)]\s+(.*?)[\n ][A-Ea-e][.)]\s+(.*?)[\n ][A-Ea-e][.)]\s+(.*?)$/)
    end
    explanations = text.scan(/The correct answer is \(([A-Ea-e])\)\. (.*?)$/)
    explanations = text.scan(/Answer: ([A-Ea-e])\) (.*?)$/) if explanations.empty?
    items.each_with_index do |item, idx|
      parse(item, explanations[idx])
    end
  end

  def parse(item, explanation = nil)
    _, question, correct_answer, answer_option_2, answer_option_3, answer_option_4, answer_option_5 = item
    if explanation
      letter = explanation.first.upcase
      unless letter == 'A'
        answer_array = [correct_answer, answer_option_2, answer_option_3, answer_option_4, answer_option_5]
        answer_array.prepend(answer_array.delete_at(LETTERS.find_index(letter)))
        correct_answer, answer_option_2, answer_option_3, answer_option_4, answer_option_5 = answer_array
      end
    end
    row = [
      @filename.chomp('.txt'),
      question,
      correct_answer,
      answer_option_2,
      answer_option_3,
      answer_option_4,
      answer_option_5,
      explanation&.last
    ]
    row.map { |c| c&.strip! }
    row.map { |c| c&.gsub!(/\s{2,}/, ' ') }
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
