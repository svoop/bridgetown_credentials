require_relative '../../spec_helper'

describe BridgetownCredentials::Credentials do
  context "unified credentials" do
    let :root_dir do
      fixtures_path.join('unified')
    end

    subject do
      BridgetownCredentials::Credentials.new(root_dir: root_dir, env: 'development')
    end

    describe :credentials_path do
      it "always discovers credentials.yml.enc" do
        _(subject.send(:credentials_path)).must_equal root_dir.join('config', 'credentials.yml.enc')
      end
    end

    describe :credentials_env do
      it "always returns BRIDGETOWN_CREDENTIALS_KEY" do
        _(subject.send(:credentials_env)).must_equal 'BRIDGETOWN_CREDENTIALS_KEY'
      end
    end

    describe :credentials do
      it "always decodes credentials.yml.enc" do
        ENV['BRIDGETOWN_CREDENTIALS_KEY'] = KEYS[:unified]
        _(subject.credentials).must_be_instance_of ActiveSupport::EncryptedConfiguration
      end

      it "fails if no key env var is set" do
        ENV['BRIDGETOWN_CREDENTIALS_KEY'] = nil
        _{ subject.credentials.config }.must_raise RuntimeError
      end
    end
  end

  context "separated credentials" do
    let :root_dir do
      fixtures_path.join('separated')
    end

    subject do
      BridgetownCredentials::Credentials.new(root_dir: root_dir, env: 'production')
    end

    describe :credentials_path do
      it "discovers .yml.enc for the current environment" do
        _(subject.send(:credentials_path)).must_equal root_dir.join('config', 'credentials', 'production.yml.enc')
      end
    end

    describe :credentials_env do
      it "returns the env var key for the current environment" do
        _(subject.send(:credentials_env)).must_equal 'BRIDGETOWN_PRODUCTION_KEY'
      end
    end

    describe :credentials do
      it "decodes .yml.enc for the current environment" do
        ENV['BRIDGETOWN_PRODUCTION_KEY'] = KEYS[:production]
        _(subject.credentials).must_be_instance_of ActiveSupport::EncryptedConfiguration
      end

      it "fails if no key env var is set" do
        ENV['BRIDGETOWN_PRODUCTION_KEY'] = nil
        _{ subject.credentials.config }.must_raise RuntimeError
      end
    end
  end

  context "new credentials" do
    describe :initializer do
      it "generate a key" do
        Dir.mktmpdir do |root_dir|
          root_dir = Pathname(root_dir)
          BridgetownCredentials::Credentials.new(root_dir: root_dir, env: 'foobar')
          _(root_dir.join('config', 'credentials', 'foobar.key')).path_must_exist
        end
      end
    end
  end
end
