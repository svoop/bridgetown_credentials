require_relative '../../spec_helper'

describe BridgetownCredentials do
  it "must be defined" do
    _(BridgetownCredentials::VERSION).wont_be_nil
  end
end
