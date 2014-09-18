require 'chefspec'
require 'chefspec/berkshelf'

describe 'vhosts::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge described_recipe }

  before do
    stub_command '/usr/sbin/apache2 -t'
  end

  context 'when no apache configuration exists for node' do
    it 'should raise an apache configuration error' do
      expect { chef_run }.to raise_error 'No vhosts configured for this node.'
    end
  end

  context 'when apache configuration exists for node' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set['apache2'] = {}
      end.converge 'vhosts::default'
    end

    context 'when vhosts are not defined for node' do
      it 'should raise a missing vhost error' do
        expect { chef_run }.to raise_error 'No vhosts configured for this node.'
      end
    end

    context 'when vhosts are defined for node (an empty array)' do
      let(:chef_run) do
        ChefSpec::Runner.new do |node|
          node.set['apache2'] = { vhosts: [] }
        end.converge described_recipe
      end

      it 'should not raise a missing vhost error' do
        expect { chef_run }.to_not raise_error
      end
    end

    context 'when vhosts are defined for node' do
      context 'when cfg is an array' do
        let(:chef_run) do
          ChefSpec::Runner.new do |node|
            node.set['apache2'] = { vhosts: [{ name: 'test' }] }
          end.converge described_recipe
        end

        it 'should include the apache cookbook' do
          expect(chef_run).to include_recipe 'apache2'
        end

        it 'should configure the vhost' do
          expect(chef_run).to create_template '/etc/apache2/sites-available/test.conf'
        end
      end

      context 'when cfg is a hash' do
        let(:chef_run) do
          ChefSpec::Runner.new do |node|
            node.set['apache2'] = { vhosts: { test: { name: 'test' }} }
          end.converge described_recipe
        end

        it 'should include the apache cookbook' do
          expect(chef_run).to include_recipe 'apache2'
        end

        it 'should configure the vhost' do
          expect(chef_run).to create_template '/etc/apache2/sites-available/test.conf'
        end
      end
    end
  end
end
