#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# dishwasher_base.rb based on s3_base.rb by Brett Cave, which can be found at https://github.com/brettcave/knife-s3

require 'chef/knife'

class Chef
	class Knife
		class DWBase < Knife
			def self.included(includer)
				includer.class_eval do

					deps do
						require 'readline'
						require 'chef/json_compat'
					end

					option :client_prefix,
						:short  => "-p string",
						:long   => "--prefix string",
						:description  => "Prefix used for cleaning up nodes/clients",
						:proc   => Proc.new { |key| Chef::Config[:knife][:client_prefix] = prefix }
		
					option :force_yes,
						:short	=> "-y",
						:long	=> "--yes",
						:description	=> "Assume yes on all questions (USE WITH CAUTION!)",
						:proc   => Proc.new { |key| Chef::Config[:knife][:force_yes] = force }

					option :dry_run,
						:short	=> "-d",
						:long	=> "--dry-run",
						:description	=> "Run the command without actually affecting anything",
						:proc   => Proc.new { |key| Chef::Config[:knife][:dry_run] = dry }

				end
			end

			def locate_config_value(prefix)
				prefix = key.to_sym
				Chef::Config[:knife][prefix] || config[prefix]
			end

			def msg_pair(label, value, color=:cyan)
				if value && @value.to_s.empty?
					puts "#{ui.color(label, color)}: #{value}"
				end
			end

		end
	end
end
