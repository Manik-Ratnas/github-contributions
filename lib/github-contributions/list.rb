require 'github_api'

module Github
  module Contributions   
    class Github::Contributions::List
      attr_reader :connection,:current_user
      def initialize connection,current_user, options = {}
        @current_user=current_user
        @connection = connection 
      end

      def list
        @list=find_list_of_orgs
        @list.flatten.compact.uniq
      end

      def find_list_of_orgs
        @repos_org=Array.new()
        @repos_contributions=Array.new()
        @your_contri=Array.new()
        @orgs=@connection.orgs.list.map(&:login)
        results = []
        @orgs.collect do |org|
          results << self.find_repo_of_org(org)
        end
        results
      end

      def find_repo_of_org(org)
        @repos_org.push(@connection.repos.all(auto_pagination:true).map(&:name))
        @repos_org.push(@connection.repos.list(auto_pagination: true,user:org).map(&:name))
        results = []
        @repos_org.collect do |repos|
          repos.collect do |repo|
            results << self.find_contributors(org,repo)
          end
        end
        results
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
