module.exports = {
  root: true,
  env: {
    browser: true,
    node: true
  },
  parserOptions: {
    parser: 'babel-eslint'
  },
  extends: [
    "eslint:recommended",
    "airbnb-base",
    // https://github.com/vuejs/eslint-plugin-vue#priority-a-essential-error-prevention
    "plugin:vue/recommended",
  ],
  // required to lint *.vue files
  plugins: [
    'vue'
  ],
  // add your custom rules here
  rules: {
    "semi": [2, "never"],
    "no-console": "off",
    "vue/max-attributes-per-line": "off",
    "vue/html-self-closing": "off",
    // "prettier/prettier": ["error", { "semi": false }]
  }
}
