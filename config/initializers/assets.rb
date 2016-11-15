# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( groups.js )
Rails.application.config.assets.precompile += %w( uploads.js )
Rails.application.config.assets.precompile += %w( datatable.js )
Rails.application.config.assets.precompile += %w( swipe-pagination.js )
Rails.application.config.assets.precompile += %w( best_in_place_run.js )
Rails.application.config.assets.precompile += %w( jquery.touchSwipe.min.js )

Rails.application.config.assets.precompile += %w( jquery-1.10.1.min.js )
Rails.application.config.assets.precompile += %w( jquery.mousewheel-3.0.6.pack.js )
Rails.application.config.assets.precompile += %w( jquery.fancybox.js )
Rails.application.config.assets.precompile += %w( jquery.fancybox.css )
Rails.application.config.assets.precompile += %w( fancybox.js )
Rails.application.config.assets.precompile += %w( jquery.dataTables.js )
Rails.application.config.assets.precompile += %w( jquery.dataTables.min.js )
Rails.application.config.assets.precompile += %w( dataTables.bootstrap.min.js )

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
