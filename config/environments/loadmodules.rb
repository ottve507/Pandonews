if Rails.env == "production"
  Dir.foreach("#{Rails.root}/app/models") do |model_name|
    require_dependency model_name unless model_name == "." || model_name == ".."
  end
end