

def integration_tests(r)
  ["test/integration/#{r}_*.rb"]
end

def controller_tests(r)
  ["test/controllers/#{r}_controller_test.rb"]
end

def resource_tests(r)
  integration_tests(r) + controller_tests(r)
end


guard :minitest, spring: true, all_on_start: false do

  watch('config/routes.rb')                  { 'test' }
  watch('test/test_helper.rb')               { 'test' }
  watch('app/helpers/application_helper.rb') { 'test' }
  watch(%r{^test/.+_test\.rb$})

  watch %r{^app/(.+)\.rb$} do |m|
    "test/#{m[1]}_test.rb"
  end
  watch %r{^app/controllers/application_controller\.rb$} do
    'test/controllers'
  end
  watch %r{^app/controllers/(.+)_controller\.rb$} do |m|
    resource_tests(m[1])
  end
  watch %r{^app/views/([^/]+)/.*\.html\.erb$} do |m|
    resource_tests(m[1])
  end
  watch(%r{app/views/layouts/.*}) do
    'test/integration'
  end
  watch %r{^app/views/(.+)_mailer/.+} do |m|
    "test/mailers/#{m[1]}_mailer_test.rb"
  end
  watch %r{^app/helpers/(.+)_helper\.rb$} do |m|
    resource_tests(m[1])
  end
  watch %r{^lib/(.+)\.rb$} do |m|
    "test/lib/#{m[1]}_test.rb"
  end

end

