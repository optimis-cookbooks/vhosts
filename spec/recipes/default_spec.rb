require 'chefspec'

describe 'vhosts::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new('.').converge 'vhosts::default' }

  context 'when no apache configuration exists for node' do
    it 'should raise an apache configuration error' do
      expect { chef_run }.to raise_error 'No apache configuration found for node.'
    end
  end

  context 'when apache configuration exists for node' do
    let(:chef_run) do
      ChefSpec::ChefRunner.new '.' do |node|
        node.set['apache2'] = {}
      end.converge 'vhosts::default'
    end

    it 'should not raise an apache configuration error' do
      expect { chef_run }.to_not raise_error 'No apache configuration found for node.'
    end

    context 'when vhosts are not defined for node' do
      it 'should raise a missing vhost error' do
        expect { chef_run }.to raise_error 'No vhosts configured for this node.'
      end
    end

    context 'when vhosts are defined for node (an empty array)' do
      let(:chef_run) do
        ChefSpec::ChefRunner.new '.' do |node|
          node.set['apache2'] = { :vhosts => [] }
        end.converge 'vhosts::default'
      end

      it 'should not raise a missing vhost error' do
        expect { chef_run }.to_not raise_error 'No vhosts configured for this node.'
      end
    end

    context 'when vhosts are defined for node' do
      let(:chef_run) do
        ChefSpec::ChefRunner.new '.' do |node|
          node.set['apache2'] = { :vhosts => [{ :name => 'Test' }] }
        end.converge 'vhosts::default'
      end

      it 'should include the apache cookbook' do
        chef_run.should include_recipe 'apache2'
      end

      it 'should receive' do
        Chef::Recipe.any_instance.should_receive(:web_app).with 'Test'
        chef_run
      end
    end
  end
end
