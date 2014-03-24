class DeployController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    if params.key?("post")
      #puts params["post"]
      webhook = JSON.parse(params["post"])
      #puts webhook["branch"]
    end

    #rs_client = RightApi::Client.new(
    #  :email => Rails.application.config.rs_email,
    #  :password => Rails.application.config.rs_password,
    #  :account_id => Rails.application.config.rs_account_id
    #)
    #
    #re = RsMule::RunExecutable.new(rs_client)
    ##re.run_executable("foo", "cookbook::recipe", :inputs => {"foo" => "text:barbaz"}, :update_inputs => ["deployment"])
    #re.run_executable("rs_ci_app_rails::default", :inputs => {})

    render nothing: true
  end
end