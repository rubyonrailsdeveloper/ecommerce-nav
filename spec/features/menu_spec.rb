require 'spec_helper'

feature 'Menu' do
  let(:root_path) { spree.root_path }
  let(:cart_path) { spree.cart_path }

  let(:first_element)  { '#main-nav-bar li:first' }
  let(:second_element) { '#main-nav-bar li:nth-child(2)' }
  let(:cart_element)   { '#main-nav-bar li:last#link-to-cart' }

  it 'contain `cart` at the end of the menu' do
    visit root_path
    within(:css, cart_element) do
      expect(page).to have_link(Spree.t(:cart), href: cart_path)
    end
  end

  context 'with no menu items specified' do
    before { visit root_path }

    it 'default `Home` item listed' do
      within(:css, first_element) do
        expect(page).to have_link(Spree.t(:home), href: root_path)
      end
    end
  end

  context 'with menu item available' do
    let!(:menu_item) { create(:menu_item) }

    before { visit root_path }

    it 'builds menu items' do
      within(:css, first_element) do
        expect(page).to have_link(menu_item.name, href: menu_item.url)
      end
    end
  end

  context 'with multiple menu item available' do
    let!(:menu_item1) { create(:menu_item) }
    let!(:menu_item2) { create(:menu_item) }

    before { visit root_path }

    it 'builds menu items' do
      within(:css, first_element) do
        expect(page).to have_link(menu_item1.name, href: menu_item1.url)
      end
      within(:css, second_element) do
        expect(page).to have_link(menu_item2.name, href: menu_item2.url)
      end
    end
  end
end
