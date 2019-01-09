require 'spec_helper'

feature 'Action button in title bar' do
  stub_authorization!

  let!(:menu_item) { create(:menu_item) }

  let(:index_path) { spree.admin_menu_items_path }
  let(:new_path)   { spree.new_admin_menu_item_path }
  let(:edit_path)  { spree.edit_admin_menu_item_path(menu_item) }

  let(:new_element)  { "[data-hook='toolbar'] li a[href='#{new_path}']" }
  let(:back_element) { "[data-hook='toolbar'] li a[href='#{index_path}']" }

  context 'menu_item#index' do
    before { visit index_path }

    it 'links to menu_item#new' do
      expect(page).to have_css(new_element)
    end
  end

  context 'menu_item#new' do
    before { visit new_path }

    it 'links to menu_item#index' do
      expect(page).to have_css(back_element)
    end
  end

  context 'menu_item#edit' do
    before { visit edit_path }

    it 'links to menu_item#index' do
      expect(page).to have_css(back_element)
    end
  end
end
