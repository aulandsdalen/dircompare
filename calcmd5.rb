require 'digest/md5'
require 'csv'

if ARGV.empty?
	puts 'filename?'
	exit 1
end

filename = ARGV[0]
volname = ARGV[1]

contents = File.open(filename).read
contents.each_line do |fname|
	begin
		fname.chomp!
		print "#{fname} "
		size = File.size(fname)
		rname = fname.sub(volname, "")
		md5hash = Digest::MD5.hexdigest(File.read(fname))
		print "= #{md5hash}\n"
		csvstring = "#{rname},#{size},#{md5hash}"
		open('output.csv', 'a') { |f|
			f.puts csvstring
		}
	rescue Exception => msg
		puts msg
	end
end