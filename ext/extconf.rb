require 'mkmf'

# override normal build configuration to build debug friendly library
# if installed via 'gem install oops-null -- --enable-debug'
if enable_config('debug')
  puts '[INFO] enabling debug library build configuration.'
  if RUBY_VERSION < '1.9'
    $CFLAGS = CONFIG['CFLAGS'].gsub(/\s\-O\d?\s/, ' -O0 ')
    $CFLAGS.gsub!(/\s?\-g\w*\s/, ' -ggdb3 ')
    CONFIG['LDSHARED'] = CONFIG['LDSHARED'].gsub(/\s\-s(\s|\z)/, ' ')
  else
    CONFIG['debugflags'] << ' -ggdb3 -O0'
  end
end

dir_config("geohash_native")
create_makefile("geohash_native")
