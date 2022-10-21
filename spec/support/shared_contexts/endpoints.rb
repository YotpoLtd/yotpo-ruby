shared_context 'endpoints' do
  subject { @response.body }

  before(:all) do
    @base_params = {
      app_key: 'foo',
      utoken: 'baz',
    }.freeze
  end
end
