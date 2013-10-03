require 'chef/knife'
require 'chef/knife/dishwasher_base'

class Chef
	class Knife
		class DWClean < Chef::Knife::DWBase

			deps do
				require 'readline'
			end

			banner "knife dishwasher clean { --prefix <prefix> OR --time <integer> } [ --dry-run ] [ --force-yes ] [ --with-clients ]"

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
					if config[:time] + config[:prefix].nil
						time = Time.now
						t = time.to_i

						for node in Chef::Knife::Node.list
							puts #{node}
						end
					end

					if config[:prefix] + config[:time].nil
						for node in Chef::Knife::Node.list
							puts #{node}
						end
					end
				end
			end
		end
	end
end
