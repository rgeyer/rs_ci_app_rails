require 'test_helper'

class DeployControllerTest < ActionController::TestCase

  test "can create" do
    mule_re_mock = flexmock("re")
    mule_re_mock
      .should_receive("run_executable")
      .once
      .with("rs_ci_app:environment=production", "rs_ci_app_rails::default", :inputs => {"rs_ci_app_rails/branch" => "text:1a60f81a54545eec9574001e6c99ea6d91f04639"}, :update_inputs => ["current_instance", "next_instance"])

    flexmock(RightApi::Client)
      .should_receive(:new)
      .and_return(flexmock("foo"))

    flexmock(RsMule::RunExecutable)
      .should_receive(:new)
      .and_return(mule_re_mock)

    post :create, payload: <<EOF
{"id":21443156,"repository":{"id":1957796,"name":"rs_ci_app_rails","owner_name":"rgeyer","url":"https://github.com/rgeyer/rs_ci_app_rails"},"number":"14","config":{"language":"ruby","rvm":["1.9.3"],"notifications":{"webhooks":{"urls":["http://production-rs-ci-app-rails.cse.rightscale-services.com/deploy"],"on_success":"always","on_failure":"never"}},".result":"configured"},"status":0,"result":0,"status_message":"Passed","result_message":"Passed","started_at":"2014-03-24T17:26:51Z","finished_at":"2014-03-24T17:32:27Z","duration":336,"build_url":"https://travis-ci.org/rgeyer/rs_ci_app_rails/builds/21443156","commit":"1a60f81a54545eec9574001e6c99ea6d91f04639","branch":"master","message":"Use the right controller for the webhook","compare_url":"https://github.com/rgeyer/rs_ci_app_rails/compare/75dcb404d24e...1a60f81a5454","committed_at":"2014-03-24T17:14:07Z","author_name":"Ryan J. Geyer","author_email":"me@ryangeyer.com","committer_name":"Ryan J. Geyer","committer_email":"me@ryangeyer.com","matrix":[{"id":21443157,"repository_id":1957796,"parent_id":21443156,"number":"14.1","state":"finished","config":{"language":"ruby","rvm":"1.9.3","notifications":{"webhooks":{"urls":["http://production-rs-ci-app-rails.cse.rightscale-services.com/deploy"],"on_success":"always","on_failure":"never"}},".result":"configured"},"status":null,"result":null,"commit":"1a60f81a54545eec9574001e6c99ea6d91f04639","branch":"master","message":"Use the right controller for the webhook","compare_url":"https://github.com/rgeyer/rs_ci_app_rails/compare/75dcb404d24e...1a60f81a5454","committed_at":"2014-03-24T17:14:07Z","author_name":"Ryan J. Geyer","author_email":"me@ryangeyer.com","committer_name":"Ryan J. Geyer","committer_email":"me@ryangeyer.com","finished_at":"2014-03-24T17:32:27Z"}],"type":"push"}
EOF

    assert_response :success
  end

  test "can create specifying environment" do
    mule_re_mock = flexmock("re")
    mule_re_mock
    .should_receive("run_executable")
    .once
    .with("rs_ci_app:environment=dev", "rs_ci_app_rails::default", :inputs => {"rs_ci_app_rails/branch" => "text:1a60f81a54545eec9574001e6c99ea6d91f04639"}, :update_inputs => ["current_instance", "next_instance"])

    flexmock(RightApi::Client)
    .should_receive(:new)
    .and_return(flexmock("foo"))

    flexmock(RsMule::RunExecutable)
    .should_receive(:new)
    .and_return(mule_re_mock)

    post :create, environment: "dev", payload: <<EOF
{"id":21443156,"repository":{"id":1957796,"name":"rs_ci_app_rails","owner_name":"rgeyer","url":"https://github.com/rgeyer/rs_ci_app_rails"},"number":"14","config":{"language":"ruby","rvm":["1.9.3"],"notifications":{"webhooks":{"urls":["http://production-rs-ci-app-rails.cse.rightscale-services.com/deploy"],"on_success":"always","on_failure":"never"}},".result":"configured"},"status":0,"result":0,"status_message":"Passed","result_message":"Passed","started_at":"2014-03-24T17:26:51Z","finished_at":"2014-03-24T17:32:27Z","duration":336,"build_url":"https://travis-ci.org/rgeyer/rs_ci_app_rails/builds/21443156","commit":"1a60f81a54545eec9574001e6c99ea6d91f04639","branch":"master","message":"Use the right controller for the webhook","compare_url":"https://github.com/rgeyer/rs_ci_app_rails/compare/75dcb404d24e...1a60f81a5454","committed_at":"2014-03-24T17:14:07Z","author_name":"Ryan J. Geyer","author_email":"me@ryangeyer.com","committer_name":"Ryan J. Geyer","committer_email":"me@ryangeyer.com","matrix":[{"id":21443157,"repository_id":1957796,"parent_id":21443156,"number":"14.1","state":"finished","config":{"language":"ruby","rvm":"1.9.3","notifications":{"webhooks":{"urls":["http://production-rs-ci-app-rails.cse.rightscale-services.com/deploy"],"on_success":"always","on_failure":"never"}},".result":"configured"},"status":null,"result":null,"commit":"1a60f81a54545eec9574001e6c99ea6d91f04639","branch":"master","message":"Use the right controller for the webhook","compare_url":"https://github.com/rgeyer/rs_ci_app_rails/compare/75dcb404d24e...1a60f81a5454","committed_at":"2014-03-24T17:14:07Z","author_name":"Ryan J. Geyer","author_email":"me@ryangeyer.com","committer_name":"Ryan J. Geyer","committer_email":"me@ryangeyer.com","finished_at":"2014-03-24T17:32:27Z"}],"type":"push"}
EOF

    assert_response :success
  end

end