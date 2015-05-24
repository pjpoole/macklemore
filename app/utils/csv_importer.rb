require 'csv'

def try(headers = true)
  data_directory = File.join(Rails.root, "data", "*.{csv,CSV}")

  csv_files = Dir.glob(data_directory)

  # Repair files broken across lines
  csv_files.each do |csv_file|
    file = File.open(csv_file, "r")

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
  end

  csv_files.each do |csv_file|
    puts csv_file
    CSV.foreach(csv_file, headers: true, header_converters: [:downcase, :symbol]) do |line|
      p line
    end
    # puts file.readline
  end
end
