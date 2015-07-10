def try
  data_directory = File.join(Rails.root, "data", "*.{qfx,QFX}")

  qfx_files = Dir.glob(data_directory)

  qfx_files.each do |qfx_file|

    file = File.open(qfx_file,"r")

    # Chew through headers
    begin
      line = file.gets.chomp
    end until line[0] == "<"

    entries = {}

    build_entries(file, entries, line)
  end
end

def build_entries(file, entries, line)

  match_group = /^<(?<tag>.*)>(?<data>.*)$/
  opening_tag = line.match(match_group)[:tag]
  closing_tag = "/" + opening_tag

  # entries[opening_tag.downcase.to_sym] = {}

  entry = {}
  begin

  end

  entries
end
