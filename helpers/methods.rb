# Load data from files
def load_data
  app_dir = Dir.pwd

  nomes = Array.new
  apelidos = Array.new

  File.open(app_dir + "/data/nomes.csv", 'r:utf-8') do |file|
    file.each_line do |line|
      nomes << line.strip
    end
  end

  File.open(app_dir + "/data/apelidos.csv", 'r:utf-8') do |file|
    file.each_line do |line|
      apelidos << line.strip
    end
  end

  return [nomes, apelidos]
end


# API helper method to parse the number of records to return
def check_params(params_number, request_path_info)
  # Default to 1 if not plural route
  return 1 unless request_path_info.include?("s")

  if params_number
    number = params_number.to_i
    # Ensure number is between 1 and 100
    number = [[number, 1].max, 100].min
  else
    number = 10
  end

  number
end