describe 'recipe::vhosts::default' do
  it 'configures the vhosts' do
    file("#{node['apache']['dir']}/sites-available/default").must_exist
  end
end
