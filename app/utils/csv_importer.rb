

require 'csv'

# def try(headers = true)
#   data_directory = File.join(Rails.root, "data", "*.{csv,CSV}")

#   csv_files = Dir.glob(data_directory)

#   csv_files.each do |csv_file|
#     file = File.open(csv_file, "r")

#     headers = file.readline


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

  # Repair files broken across lines
  csv_files.each do |csv_file|
    file = CSVFile.open(csv_file, "r")

    file.gets
    line = file.gets
    if line.count("\"").odd?
      file.rewind

      contents = headers ? [file.gets] : []

      lines = file.readlines

      (0...lines.size).step(2) do |idx|
        contents << lines[idx].sub(/\n/,'').concat(lines[idx + 1])
      end

      output = contents.join

      File.write(csv_file, output)
    end

    file = CSVFile.open(csv_file, "r")
    CSV.new(
      file,
      headers: true,
      header_converters: [:downcase, :symbol],
      row_sep: "\r\n"
    ).each do |line|
      p "blah"
    end
  end
end
