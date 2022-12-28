require_relative '../../spec_helper'

describe BridgetownCredentials::Commands do

  describe :edit do
    it "generates the necessary files and writes the credentials via EDITOR" do
      ENV['EDITOR'] = 'echo "foo: bar" >'
      Dir.mktmpdir do |root_dir|
        root_dir = Pathname(root_dir)
        subject = BridgetownCredentials::Commands.new(root_dir: root_dir, env: 'staging')
        subject.edit
        ENV['BRIDGETOWN_STAGING_KEY'] = File.read(root_dir.join('config', 'credentials', 'staging.key'))
        subject = BridgetownCredentials::Commands.new(root_dir: root_dir, env: 'staging')
        _{ subject.show }.must_output "foo: bar\n"
      end
    end
  end

  describe :show do
    let :root_dir do
      fixtures_path.join('separated')
    end

    subject do
      ENV['BRIDGETOWN_PRODUCTION_KEY'] = KEYS[:production]
      BridgetownCredentials::Commands.new(root_dir: root_dir, env: 'production')
    end

    it "prints the decrypted credentials without leading three dashes line" do
      _{ subject.show }.must_output "production: PRODUCTION\n"
    end
  end

end
