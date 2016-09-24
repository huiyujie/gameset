require 'vrlib'

STDOUT.sync = true
STDERR.sync = true

my_path = File.expand_path(File.dirname(__FILE__))
require_all Dir.glob(my_path + "/cards/**/*.rb")

MyClass.new.show
