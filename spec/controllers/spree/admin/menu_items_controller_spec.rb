require 'spec_helper'

describe Spree::Admin::MenuItemsController do
  stub_authorization!

  let!(:menu_item) { create(:menu_item) }

  let(:index_path) { spree.admin_menu_items_path }

  let(:valid_item)     { { name: Faker::Lorem.word } }
  let(:invalid_item)   { { name: '' } }
  let(:valid_item_top) { { name: Faker::Lorem.word, parent_id: 'menu_tree' } }
  let(:scope)          { 'navigator.admin.flash.success' }

  context '#index' do
    it 'loads `index` template (HTML)' do
      spree_get :index
      expect(response).to render_template(:index)
    end

    it 'loads JSON data (AJAX)' do
      spree_xhr_get :index
      expect(response).to render_template(:children)
    end
  end

  context '#new' do
    it 'loads `new` template' do
      spree_get :new
      expect(response).to render_template(:new)
    end
  end

  context '#create' do
    context 'fails with invalid values' do
      it 'then renders `new` template for HTML' do
        spree_post :create, menu_item: invalid_item
        expect(response).to render_template(:new)
      end

      it 'then renders json template for AJAX' do
        spree_xhr_post :create, menu_item: invalid_item
        expect(response.body).to eq('{"name":["can\'t be blank"]}')
        expect(response.code).to eq '422'
        expect(response.header['Content-Type']).to match(/json/)
      end
    end

    context 'creates menu item' do
      it 'with HTML' do
        spree_post :create, menu_item: valid_item
        expect(flash[:success]).to eq(
          Spree.t(:create, name: valid_item[:name], scope: scope)
        )
        expect(response).to redirect_to(index_path)
      end

      it 'with AJAX' do
        spree_xhr_post :create, menu_item: valid_item_top
        expect(response.code).to eq '201'
        expect(response.header['Content-Type']).to match(/json/)
      end
    end
  end

  context '#edit' do
    it 'loads `edit` template' do
      spree_get :edit, id: menu_item.id
      expect(response).to render_template(:edit)
    end
  end

  context '#update' do
    context 'fails with invalid values' do
      it 'then renders `edit` template' do
        spree_post :update, id: menu_item.id, menu_item: invalid_item
        expect(response).to render_template(:edit)
      end

      it 'then renders json template for AJAX' do
        spree_xhr_post :update, id: menu_item.id, menu_item: invalid_item
        expect(response.body).to eq('{"name":["can\'t be blank"]}')
        expect(response.code).to eq '422'
        expect(response.header['Content-Type']).to match(/json/)
      end
    end

    context 'updates menu item' do
      it 'with HTML' do
        spree_post :update, id: menu_item.id, menu_item: valid_item
        expect(flash[:success]).to eq(
          Spree.t(:update, name: valid_item[:name], scope: scope)
        )
        expect(response).to redirect_to(index_path)
      end

      it 'with AJAX' do
        spree_xhr_post :update, id: menu_item.id, menu_item: valid_item
        expect(response.code).to eq '201'
        expect(response.header['Content-Type']).to match(/json/)
      end

      # jsTree passes `menu_tree` for top level item. Those get converted
      # to `nil` in `MenuItemsController.menu_item_params`
      it 'with AJAX and `menu_tree` as parent_id' do
        spree_xhr_post :update, id: menu_item.id, menu_item: valid_item_top
        expect(response.code).to eq '201'
        expect(response.header['Content-Type']).to match(/json/)
      end
    end
  end

  context '#destroy' do
    it 'deletes item' do
      spree_post :destroy, id: menu_item.id
      expect(flash[:success]).to eq(
        Spree.t(:destroy, name: menu_item[:name], scope: scope)
      )
      expect(response).to redirect_to(index_path)
    end
  end

  context '#children' do
    it 'loads children JSON' do
      spree_xhr_get :children, id: menu_item.id
      expect(response).to render_template(:children)
    end
  end
end
