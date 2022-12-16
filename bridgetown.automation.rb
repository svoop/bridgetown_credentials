# If your plugin requires a lot of steps to get set up, consider writing an automation to help guide users.
# You could set up and configure all sorts of things, for example:
#
# add_bridgetown_plugin("my-plugin")
#
# add_yarn_for_gem("my-plugin")
#
# create_builder "my_nifty_builder.rb" do
#   <<~RUBY
#     class MyNeatBuilder < SiteBuilder
#       def build
#         puts MyPlugin.hello
#       end
#     end
#   RUBY
# end
#
# javascript_import do
#   <<~JS
#     import { MyPlugin } from "my-plugin"
#   JS
# end
#
# javascript_import 'import "my-plugin.css"'
#
# create_file "src/_data/plugin_data.yml" do
#   <<~YAML
#     data:
#       goes:
#         here
#   YAML
# end
#
# color = ask("What's your favorite color?")
#
# append_to_file "bridgetown.config.yml" do
#   <<~YAML
#
#     my_plugin:
#       favorite_color: #{color}
#   YAML
# end
#
# Read the Automations documentation: https://www.bridgetownrb.com/docs/automations
