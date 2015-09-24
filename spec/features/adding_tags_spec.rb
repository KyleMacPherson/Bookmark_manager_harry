RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end

feature 'adding tags'do

  scenario ' I can add a single tag to a new link' do
    visit 'links/new'
    fill_in 'url', with: 'https://wwww.makersacademy.com'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tags', with: 'education'
    click_button 'Create link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education')
  end

  scenario 'I can add multiple tags to a new link' do
    visit '/links/new'
      fill_in 'url',   with: 'http://www.makersacademy.com/'
      fill_in 'title', with: 'Makers Academy'
      # our tags will be space separated
      fill_in 'tags',  with: 'education ruby'
      click_button 'Create link'
      link = Link.first
      expect(link.tags.map(&:name)).to include('education', 'ruby')
  end

end
