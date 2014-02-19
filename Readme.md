# Github Contributions 

This Gem is used to find User Contributions list

**github-contribution** can be used from the command line or as part of a Ruby web framework.

### Installation

To install the gem using terminal, run the following command:

    gem install github-contributions

To use it in rails application add the gem to the Gemfile:

    gem "github-contributions"    

### Basic Usage

github-contributions can simply import or export issues from an Excel file.:

    require 'github-contributions'
    require 'github_api'
    
    your_github_username = '***********'
    your_github_password = '***********'

    connection = Github.new(basic_auth: "#{your_github_username}:#{your_github_password}")
    
    # The List Module will fetch all the repositories to which you have contributed.

    Github::Contributions::List.new(connection,your_github_username)
    
### Contributing

Contributions are welcomed. You can fork a repository, add your code changes to the forked branch, ensure all existing unit tests pass, create new unit tests cover your new changes and finally create a pull request.

After forking and then cloning the repository locally, install Bundler and then use it
to install the development gem dependecies:

    gem install bundler
    bundle install

github-contributions this is complete, you should be able to run the test suite:

    rake spec


### Bug Reporting

Please use the Issues page to report bugs or suggest new enhancements.


