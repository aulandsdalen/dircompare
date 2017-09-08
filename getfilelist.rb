require 'digest/md5'
require 'csv'

if ARGV.empty?
	puts "Usage: getfilelist.rb <path/to/root/directory>"
	exit 1
end

dir = ARGV[0]

dirlist = []
output = []

dirlist = `find #{dir} -type file`.split("\n")

dirlist.each do |file|
	puts "Calculating md5 for #{file}"
	output << {:filename => file.sub(dir, ""), :size => File.size(file), :checksum => Digest::MD5.hexdigest(File.read(file))}
end

CSV.open("#{dir.tr('/ \\ :', '_')}.csv", "w") { |csv|
	output.each { |record|
		csv << record.values
	}
}
