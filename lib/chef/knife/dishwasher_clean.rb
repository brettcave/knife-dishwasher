require 'chef/knife'
require 'chef/knife/dishwasher_base'

class Chef
	class Knife
		class DWClean < Chef::Knife::DWBase

			deps do
				require 'readline',
				require'chef/search/query'
			end

			banner "knife dishwasher clean { --prefix <prefix> OR --time <integer> } [ --dry-run ] [ --force-yes ] [ --with-clients ]"

			option :clients,
				:short	=> "-wc",
				:long	=> "--with-clients",
				:description	=> "Include clients in your purge."

			option :prefix,
				:short	=> "-p",
				:long	=> "--prefix",
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
						ui.msg "Finding all nodes and indexing OHAI_TIME attribute"
						for node in Chef::Knife::NodeList
							query = "attribute:ohai_time"
							query_nodes.search('node', query) do |node_item|
								delta = Time.now.to_i - node_item.ohai_time.round
								if delta > config[:time]
									Chef::Knife::NodeDelete
									if config[:clients]
										Chef::Knife::ClientDelete
									end
								end
							end

						end
					end

					if config[:prefix] + config[:time].nil
						ui.msg "Finding all nodes by prefix"
						for node in Chef::Knife::NodeList
							query = config[:prefix]
							query_nodes.search('node', query); do |node_item|
								@knife:name_args = node_item.name
								Chef::Knife::NodeDelete
								if config[:clients]
									Chef::Knife::ClientDelete
								end
							end
						end
					end
				end
			end
		end
	end
end
