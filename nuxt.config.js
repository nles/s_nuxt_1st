export default {
  srcDir: 'src',
  env: {
    baseUrl: process.env.BASE_URL || 'http://0.0.0.0:3000',
  },
  head: {
    title: 'starter',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: 'Nuxt.js project' },
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
      { rel: 'stylesheet', type: 'text/css', href: 'https://fonts.googleapis.com/icon?family=Material+Icons' },
    ],
  },
  // Customize the progress-bar color
  loading: { color: '#3B8070' },
  modules: [
    ['./modules/typescript'],
    ['./modules/eslint'],
    ['nuxt-vue-material'],
  ],
  build: {
    extend(config, { isDev, isClient }) {
      if (isDev && isClient) {
        config.module.rules.push({
          enforce: 'pre',
          test: /\.(js|vue)$/,
          loader: 'eslint-loader',
          exclude: /(node_modules)/
        })
      }
    }
  }
}
