require_relative '../../spec_helper'

describe BridgetownCredentials do
  describe :initializer do
    it "sets env, dir and defines credentials on Bridgetown" do
      BridgetownCredentials.initializer
      _(Bridgetown).must_respond_to :credentials
      _(Bridgetown.credentials[:env]).must_equal Bridgetown.env
      _(Bridgetown.credentials[:dir]).must_equal Bridgetown.configuration.root_dir + '/config/credentials'
    end
  end
end
