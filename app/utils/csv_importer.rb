require 'csv'

class CSVFile < File
  def gets(*args)

    line = super("\n")

    if line != nil
      line.gsub!(/([^\r])\n\z/, "\\1\r\n")
      line = nil if line == "\A\z"
    end

    line
  end
end

def try(headers = true)
  data_directory = File.join(Rails.root, "data", "*.{csv,CSV}")

  csv_files = Dir.glob(data_directory)

  converter = lambda do |entry, ary|
    entry.gsub!(/(\n|\r)/,'')
    case ary.header
    when :date
      # TODO: I18n of date parsing
      Date.strptime(entry, "%m/%d/%Y")
    when :debit, :credit
      entry.gsub!(/,/,'').to_f
    when :description
      entry.strip!
    else
      entry
    end

    entry
  end

  csv_files.each do |csv_file|
    file = CSVFile.open(csv_file, "r")
    CSV.new(
      file,
      headers: true,
      header_converters: [:downcase, :symbol],
      converters: converter,
      row_sep: "\r\n"
    ).each do |line|
      p line
    end
  end
end
