require 'chef/knife'
require 'chef/knife/dishwasher_base'

class Chef
	class Knife
		class DWClean < Chef::Knife::DWBase

			deps do
				require 'readline'
				require 'chef/knife/essentials'
				Chef::Knife::Essentials.load_deps
			end

			banner "knife dishwasher clean --with-clients { --prefix <prefix> OR --time <integer> [ --dry-run ] [ --force-yes ]"

			option :clients,
				:short	=> "-wc",
				:long	=> "--with-clients",
				:description	=> "Include clients in your purge."

			option :prefix,
				:short	=> "-p",
				:long => "--prefix",
				:description	=> "Purge nodes by prefix."

			option :time,
				:short 	=> "-t",
				:long	=> "--time",
				:description	=> "Purge nodes with a check-in of more than n seconds"

			def run
				$stdout.sync = true

				if config[:prefix] + config[:time]
					puts "Please specify Prefix OR Time"
					exit 1
				end
				
				if config[:prefix].nil + config[:time].nil
					puts "Please specify Prefix OR Time"
					exit 1
				end

				if config[:prefix] + config[:time].nil
					puts "Purging all nodes with prefix " + config[:prefix]
				end
				
				if config[:time] + config[:prefix].nil
					puts "Purging all nodes with check-in time greater than " + config[:time] + "seconds."
				end

				begin






