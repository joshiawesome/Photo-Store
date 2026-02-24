# Photo-Store

This is a Vue on Rails photo store application with hot reload.

# Tech stack
1. Rails for backend
2. Vue for frontend
3. Vite for frontend build tool
4. Pinia for state management
5. SQLite for database

# Vs Code Extensions
1. Vue (Official)
2. Vue 3 Snippets (to create a boilerplate vue file, type `vue init` and hit enter)
3. Vue Language Features (Volar) support for Vue and Typescript
4. Press Cmd+Shift+P → TypeScript: Select TypeScript Version → Choose Use Workspace Version. 
   This ensures Volar uses the TypeScript in your node_modules instead of the built-in VS Code version.

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