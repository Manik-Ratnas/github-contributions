require 'github-contributions'


describe 'github-contributions' do
  before(:all) do
    @my_github_username = 'github-contributions'
    @my_github_password = 'github143'
    @connection = Github.new basic_auth: "#{@my_github_username}:#{@my_github_password}"
  end

  it 'list your contributions' do
    list = Github::Contributions::List.new(@connection,@my_github_username).list
    list.should_not be_nil
  end  
end

