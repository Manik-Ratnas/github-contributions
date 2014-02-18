require 'github_api'

module Github
  module Contributions   
    class Github::Contributions::List
      attr_reader :connection,:current_user
      def initialize connection,current_user, options = {}
        @current_user=current_user
        @connection = connection
        find_list_of_orgs
      end

      def find_list_of_orgs
        @repos_org=Array.new()
        @repos_contributions=Array.new()
        @your_contri=Array.new()
        @orgs=@connection.orgs.list.map(&:login)
        @orgs.each do |org|
          self.find_repo_of_org(org)
        end
      end

      def find_repo_of_org(org)
        @repos_org.push(@connection.repos.all(auto_pagination:true).map(&:name)
        @repos_org.push(@connection.repos.list(auto_pagination: true,user:org).map(&:name))
        @repos_org.each do |repos|
          repos.each do |repo|
            self.find_contributors(org,repo)
          end
        end
      end

      def find_contributors(org,repo)
        @repos_contributions=@connection.repos.contributors(auto_pagination: true,repo:repo,anon:1,user:org).map(&:login) rescue []
        if @repos_contributions.include? @current_user
          combo=org+"/"+repo
          @your_contri.push(combo)
        end
        @your_contri
      end
    end
  end
end
