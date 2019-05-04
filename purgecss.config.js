module.exports = {
  content: ['views/index.erb'],
  css: ['public/css/src/tachyons.min.css'],
  extractors: [
    {
      extractor: class {
        static extract(content) {
          return content.match(/[A-z0-9-:\/]+/g) || []
        }
      },
      extensions: ['html', 'css']
    }
  ]
}