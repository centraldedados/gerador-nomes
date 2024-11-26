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
  # check if the route is plural or not
  if !request.path_info.include? "s"
    return 1
  else
    if params_number
      number = params_number.to_i <= 100 ? params_number.to_i : 100
    else
      number = 10
    end
    return number
  end
end