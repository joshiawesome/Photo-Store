# Authors
- Jhosiah Felips
- Karthik Krishna Balakrishna

# Photo-Store
This is a Vue on Rails photo store application with hot reload.

# Concept
- Use an external API to fetch photos
- Hydrate the local database with the photos
- Use Vue to display the photos
- Use Pinia to manage state

# Tech stack
1. Rails for backend
2. Vue for frontend
3. Tailwind CSS for styling
4. Vite for frontend build tool
5. Pinia for state management
6. SQLite for database

# Vs Code Extensions
1. Vue (Official)
2. Vue 3 Snippets (to create a boilerplate vue file, type `vue init` and hit enter)
3. Vue Language Features (Volar) support for Vue and Typescript - disable this extension
4. Press Cmd+Shift+P → TypeScript: Select TypeScript Version → Choose Use Workspace Version. 
   This ensures Volar uses the TypeScript in your node_modules instead of the built-in VS Code version.
5. Ruby Solargraph (for autocompletion in ruby files)
6. Tailwind CSS Intellisense (for styling)
7. Heroicons (for icons). link: https://heroicons.com/

# How this project was created

1. run `rails new photos_store_app` from the root directory
2. run `cd photos_store_app`
3. run `rails db:create`
4. run `bundle add vite_rails`
5. run `bundle exec vite install`
6. run `bundle binstub vite_ruby`
7. run `bundle add vue@^3.4.9`
8. run `npm install vue@3 pinia axios`

# To Run the application

# Prerequisites
1. Ruby (>= 3.x) and Rails
2. Node.js (>= 18.x) and npm
3. SQLite3

run the commands below in the photos_store_app directory:
# Install frontend dependencies
npm install

# Start Rails backend
rails s

# Start Vite development server parallel to the Rails server
bin/vite dev

# To add a RubyGem
1. Navigate to the `Gemfile` and add the gem
2. Run `bundle install`
3. Restart the Rails server

# To add a log inside an `rb` file
1. Navigate to the `rb` file
2. Add `Rails.logger.info "Your log message"` eg `Rails.logger.info "URL: #{URL}"`
3. The logs will show up in the terminal as server logs

# Imports in rails
1. Rails imports are auto-loaded via `Zeitwerk autoloading`

# Rails Console
1. Run `rails console` to open the console.
2. Run `exit!` to exit the console.

# Rails Routes
1. Run `rails routes` from the root directory/bin to see the routes
2. Check for prefix column
3. Path will be prefix + _url

# Testing with Rails
1. run `rails test` to run tests from the root directory/bin
2. run `rails test test/directory` to run tests from the test/directory/ file


# API Calls
1. Use the `useAPI` hook to make API calls

# Styling
1. Use Tailwind CSS for styling
2. Use the `animation.css` file for animation utilities
3. Use the `button.css` file for button utilities
4. Use the `colors.css` file for color utilities
5. Use the `font.css` file for font utilities
6. Use the `height.css` file for height utilities
7. Use the `icon.css` file for icon utilities
8. Use the `input.css` file for input utilities
9. Use the `loader.css` file for loader utilities
10. Use the `spacing.css` file for spacing utilities
11. Use the `width.css` file for width utilities

