 #!/usr/bin/env ruby
require 'csv'
require 'pry'
require 'doc_ripper'

# textutil -convert txt /Users/tyleryoung/projects/advent-of-code/cm/inputs/*.docx

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
    @txt_files = Dir.glob("#{INPUT_DIR}/**/*.txt")
    @pdf_files = Dir.glob("#{INPUT_DIR}/**/*.pdf")
  end

  def process
    puts TIMESTAMP
    extract_from_txt_file
    extract_from_pdf_file
    export_csv
  end

  def extract_from_txt_file
    @txt_files.each do |file|
      @filename = File.basename(file)
      puts "Reading #{@filename}..."
      text = File.read(file)
      extract_from_text(text)
    end
  end

  def extract_from_pdf_file
    @pdf_files.each do |file|
      @filename = File.basename(file)
      puts "Reading #{@filename}..."
      text = DocRipper::rip(file)
      text.gsub!(/Copyright © \d+/,'')
      extract_from_pdf(text)
    end
  end

  def extract_from_text(text)
    items = text.scan(/\n(Q\. )?(.*?)\n[A-E][.)]\s+(.*?)\n[A-E][.)]\s+(.*?)\n[A-E][.)]\s+(.*?)\n[A-E][.)]\s+(.*?)\n[A-E][.)]\s+(.*?)$/)
    if items.empty?
      items = text.scan(/\n(Q\. )?(.*?)\n[A-D][.)]\s+(.*?)\n[A-D][.)]\s+(.*?)\n[A-D][.)]\s+(.*?)\n[A-D][.)]\s+(.*?)$/)
      items.each do |item|
        parse_txt(item)
      end
    else
      explanations = text.scan(/The correct answer is \(([A-E])\)\. (.*?)$/)
      items.each_with_index do |item, idx|
        parse_txt(item, explanations[idx])
      end
    end
  end

  def extract_from_pdf(text)
    question_number = 1
  while true do
      item = text.match(/
        #{question_number}\W+(.{0,140}?)[\s\n•]{0,42}
        A\.\W+(.*?)\W+
        B\.\W+(.*?)\W+
        C\.\W+(.*?)\W+
        D\.\W+(.*?)\W+
        E\.\W+(.*?)\n\n/xm)
      answer_letter = text.match(/[Aa]nswers?.{1,42}#{question_number}\W*?([a-eA-E])/m, 1)[1].upcase
      break unless item && answer_letter

      parse_pdf(item, answer_letter)
      question_number += 1
    end
  end

  def parse_txt(item, explanation = nil)
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
    row.map { |c| c.gsub!(/\s{2,}/, ' ') }
    @csv_rows << row
  end

  def parse_pdf(item, letter)
    _, question, correct_answer, answer_option_2, answer_option_3, answer_option_4, answer_option_5 = item.to_a
    unless letter == 'A'
      answer_array = [correct_answer, answer_option_2, answer_option_3, answer_option_4, answer_option_5]
      answer_array.prepend(answer_array.delete_at(LETTERS.find_index(letter)))
      correct_answer, answer_option_2, answer_option_3, answer_option_4, answer_option_5 = answer_array
    end
    row = [
      @filename.chomp(@filename.chars.last(4).flatten.to_s),
      question,
      correct_answer,
      answer_option_2,
      answer_option_3,
      answer_option_4,
      answer_option_5,
      ''
    ]
    row.map { |c| c&.strip! }
    row.map { |c| c.gsub!(/\n/, ' ') }
    row.map { |c| c.gsub!(/\s{2,}/, ' ') }
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
