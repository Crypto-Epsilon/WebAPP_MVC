def require_app(folders = %w[services controllers])
    app_list = Array(folders).map { |folder| "app/#{folder}" }
    full_list = ['config', app_list].flatten.join(',')
    Dir.glob("./{#{full_list}}/**/*.rb").each do |file|
      require file
    end
  end