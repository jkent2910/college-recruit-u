desc "Clean up log and tmp files"
task :clean => ["log:clear", "tmp:clear"] do
  FileUtils.rm_rf(Dir['tmp/capybara/[^.]*'])
end
