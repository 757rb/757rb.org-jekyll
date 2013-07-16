gem 'rack-rewrite'
require 'rack/rewrite'

use Rack::Rewrite do
  r301 %r{^([^\.]*[^\/])$}, '$1/' 
  r301 %r{^(.*\/)$}, '$1index.html'
end

# use Rack::Static, :urls => ["/"], :root => Dir.pwd + '/output'
