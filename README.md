# tooplooxtest

start:

rackup config.ru

define routes in config.ru file

get '/:file.:ext' do |file, ext, params|
  <<-html
  <pre>
    file: #{file.inspect}
    ext: #{ext.inspect}
    params: #{params.inspect}
  </pre>
  html
end
