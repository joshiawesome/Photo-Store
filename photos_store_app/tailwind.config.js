module.exports = {
    content: [
        './app/views/**/*.html.erb',
        './app/helpers/**/*.rb',
        './app/javascript/**/*.js',
        './app/javascript/**/*.ts',
        './app/javascript/**/*.vue'
    ],
    theme: {
        extend: {
            colors: {
                brand: 'red',
            },
        },
    },
    plugins: [],
}
