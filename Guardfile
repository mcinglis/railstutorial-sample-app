

def resource_tests(resource)
  ["test/integration/#{resource}_*.rb",
   "test/controllers/#{resource}_controller_test.rb"]
end


guard :minitest, spring: true, all_on_start: false do

  watch %r{^app/(.+)\.rb$} do |m|
    "test/#{m[1]}_test.rb"
  end
  watch %r{^app/controllers/application_controller\.rb$} do
    "test/controllers"
  end
  watch %r{^app/controllers/(.+)_controller\.rb$} do |m|
    resource_tests(m[1])
  end
  watch %r{^app/views/([^/]+)/.*\.html\.erb$} do |m|
    resource_tests(m[1])
  end
  watch %r{^app/views/(.+)_mailer/.+} do |m|
    "test/mailers/#{m[1]}_mailer_test.rb"
  end
  watch %r{^lib/(.+)\.rb$} do |m|
    "test/lib/#{m[1]}_test.rb"
  end
  watch %r{^test/.+_test\.rb$}
  watch %r{^test/test_helper\.rb$} do
    "test"
  end

end



