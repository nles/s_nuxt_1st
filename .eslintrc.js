module.exports = {
  root: true,
  env: {
    browser: true,
    node: true
  },
  parser: "vue-eslint-parser",
  parserOptions: {
    parser: "typescript-eslint-parser"
  },
  plugins: [
    'typescript',
    'vue',
  ],
  extends: [
    "eslint:recommended",
    "airbnb-base",
    // https://github.com/vuejs/eslint-plugin-vue#priority-a-essential-error-prevention
    "plugin:vue/recommended",
  ],
  rules: {
    "no-console": "off",
    "vue/max-attributes-per-line": "off",
    "vue/html-self-closing": "off",
    "typescript/no-unused-vars": "error",
  }
}
