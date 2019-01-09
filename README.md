# Spree Navigator

Customizable navigation menu for Spree. Sure you can overwrite the view file in your application to add your own menu items. But what fun would that be?

Works well with [multi-tenant sites](https://github.com/groundctrl/shopping_mall) or applications where overwriting the `views/spree/shared/_main_nav_bar.html.erb` file is not an option.

But... but... what happens when no menu items are set? It will default to the translated `Home` text with the `root_path` link just like Spree does by default.

> More information at http://dfreerksen.github.io/spree_navigator


## Installation

Add this line to your Spree application's Gemfile:

    gem 'spree_navigator', github: 'dfreerksen/spree_navigator'

Run the bundle command to install it:

    bundle install

After installing, run the generator:

    bundle exec rails g spree_navigator:install


## Testing

Generate a dummy application

    bundle exec rake test_app

Running tests

    bundle exec rake spec


## Contributing

1. Fork it ( https://github.com/dfreerksen/spree_navigator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
