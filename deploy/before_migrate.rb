# coding: utf-8
run “ln -nfs #{config.shared_path}/config/google_college_credentials.json #{config.release_path}/config/google_college_credentials.json”
run “ln -nfs #{config.shared_path}/config/s3.yml #{config.release_path}/config/s3.yml”
run “ln -nfs #{config.shared_path}/config/secrets.yml #{config.release_path}/config/secrets.yml”
