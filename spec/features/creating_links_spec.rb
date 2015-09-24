
feature 'Creating links' do

  scenario 'I can create a new link' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers'
    click_button 'Create link'

    expect(current_path).to eq '/links'

      within 'ul#links' do
        expect(page).to have_content('Makers')
      end
  end

  # scenario 'there are no links in the database at the start of the test' do
  #   expect(Link.count).to eq 0
  # end

end
