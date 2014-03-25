class DeployController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    if params.key?("payload")
      webhook = JSON.parse(params["payload"])
      environment = params["environment"] || "production"

      rs_client = RightApi::Client.new(
        :email => Rails.application.config.rs_email,
        :password => Rails.application.config.rs_password,
        :account_id => Rails.application.config.rs_account_id
      )

      re = RsMule::RunExecutable.new(rs_client)
      re.run_executable(
        "rs_ci_app:environment=#{environment}",
        "rs_ci_app_rails::default",
        :inputs => {"rs_ci_app_rails/branch" => webhook["commit"]},
        :update_inputs => ["current_instance", "next_instance"]
      )
    end

    render nothing: true
  end
end