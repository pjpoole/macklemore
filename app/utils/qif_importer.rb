def try
  data_directory = File.join(Rails.root, "data", "*.{qif,QIF}")

  qif_files = Dir.glob(data_directory)

  qif_files.each do |qif_file|
    file = File.open(qif_file, "r")

    # eat first line
    line = file.gets

    entries = []
    entry = {}

    file.each_line do |line|
      line.chomp!
      unless line[0] == "^"
        letter = line[0]
        line.slice!(0)

        case letter
        when "D"
          entry[:date] = line
        when "P"
          entry[:description] = line.chomp
        when "M"
          entry[:memo] = line.chomp
        when "T"
          total = line.to_f
          entry[:debit] = total < 0 ? total * -1 : 0
          entry[:credit] = total > 0 ? total : 0
        when "C"
          entry[:status] = line
        end
      else
        entries << entry
        p entry
        entry = {}
      end
    end
  end
end
