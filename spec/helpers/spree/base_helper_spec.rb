require 'spec_helper'

describe Spree::BaseHelper do
  context '#navigator_default' do
    it 'builds default `home` item' do
      expect(helper.navigator_menu).to eq helper.navigator_default
    end
  end

  context '#navigator_item' do
    let!(:menu_item)  { create(:menu_item) }

    it 'builds individual object' do
      expect(helper.navigator_menu).to eq [helper.navigator_item(menu_item)]
    end
  end

  context '#navigator_menu' do
    it 'builds `home` link when no navigation is set' do
      expect(helper.navigator_menu).to eq helper.navigator_default
    end

    it 'builds navigation object' do
      menu_item = create(:menu_item)
      expect(helper.navigator_menu).to eq [helper.navigator_item(menu_item)]
    end
  end

  context '#navigator_levels' do
    let!(:first_menu_item)  { create(:menu_item) }
    let!(:second_menu_item) { create(:menu_item) }

    it 'builds one level of items' do
      records = Spree::MenuItem.top_level
      expect(helper.navigator_levels(records).size).to eq(2)
    end

    before do
      second_sub_menu_item = create(:menu_item)
      second_sub_menu_item.update_attributes!(parent_id: second_menu_item.id)
    end

    it 'builds multiple levels of items' do
      records = Spree::MenuItem.top_level
      expect(helper.navigator_levels(records)[1][:items].size).to eq(1)
    end
  end
end
