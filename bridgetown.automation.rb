# Make sure key files are not committed to the source code repository
append_to_file ".gitignore" do
  <<~END
    config/credentials.key
    config/credentials/*.key
  END
end
