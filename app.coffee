axis         = require 'axis'
rupture      = require 'rupture'
autoprefixer = require 'autoprefixer-stylus'
js_pipeline  = require 'js-pipeline'
css_pipeline = require 'css-pipeline'
dynamic_content = require 'dynamic-content'
records = require 'roots-records'
roots_config = require('roots-config')
templates = require('client-templates')

module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf']

  extensions: [
    js_pipeline(files: 'assets/js/*.coffee'),
    css_pipeline(files: ['assets/css/*.styl', 'assets/css/vendor/*.css']),
    dynamic_content(write: 'content.json'),
    records(
      posts:
        file: 'public/content.json',
        hook: (posts) -> posts = posts.posts.items,
    ),
    roots_config(
      limit: 3,
    ),
    templates(base: 'views/templates')
  ]

  stylus:
    use: [axis(), rupture(), autoprefixer()]
    sourcemap: true

  'coffee-script':
    sourcemap: true

  jade:
    pretty: true

  server:
    clean_urls: true

  open_browser: false
