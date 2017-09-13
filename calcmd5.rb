require 'digest/md5'
require 'csv'

if ARGV.empty?
	puts 'filename?'
	exit 1
end

filename = ARGV[0]
volname = ARGV[1]

puts "Loading #{filename}"
contents = File.open(filename).read
length = contents.lines.count
puts "#{length} loaded"
processed = 0
contents.each_line do |fname|
	processed += 1
	begin
		fname.chomp!
		print "#{processed} of #{length}: #{fname} "
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