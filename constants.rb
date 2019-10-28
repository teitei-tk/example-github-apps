module Constants
  PEM_FILE_PATH = Pathname("#{Pathname.new("#{__FILE__}").dirname}/private-key.pem")
  REPOSITORY_NAME = 'example-github-apps'.freeze
  OWNER_NAME = 'teitei-tk'
end
