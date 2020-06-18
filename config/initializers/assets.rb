# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
[File.join('app', 'assets', 'stylesheets'), File.join('app', 'assets', 'javascripts')].each do |dir|
  Dir.glob("#{dir}/controllers/**/*")
    .select {|p| p =~ /\.(js|css|scss|erb)$/ && p.exclude?('/_') }
    .map {|p| p.gsub(/\.s?(css|js)(\.erb|)$/, '.\1').gsub("#{dir}/", '') }
    .each do |file|
      Rails.application.config.assets.precompile += [file]
    end
end