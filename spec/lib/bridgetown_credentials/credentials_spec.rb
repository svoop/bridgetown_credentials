require_relative '../../spec_helper'

KEYS = {
  unified: '4f9ab3ef4bddd3ad6d01886b6ffff49c',
  development: 'e4af0afc87c885a430afa3c9691d8bf4',
  production: '5f1380543df0a4c839324619e0acf0bf'
}

describe BridgetownCredentials::Credentials do
  context "unified" do
    let :root_dir do
      fixtures_path.join('unified')
    end

    subject do
      BridgetownCredentials::Credentials.new(root_dir: root_dir)
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

    describe :config do
      it "returns the decoded config with stringified keys" do
        ENV['BRIDGETOWN_CREDENTIALS_KEY'] = KEYS[:unified]
        _(subject.config).must_equal({ 'unified' => 'UNIFIED' })
      end
    end
  end

  context "not unified" do
    let :root_dir do
      fixtures_path.join('not_unified')
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

    describe :config do
      it "returns the decoded config with stringified keys" do
        ENV['BRIDGETOWN_PRODUCTION_KEY'] = KEYS[:production]
        _(subject.config).must_equal({ 'production' => 'PRODUCTION' })
      end
    end
  end
end
