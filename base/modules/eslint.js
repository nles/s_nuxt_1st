export default function () {
  // Extend build
  this.extendBuild((config) => {
    const eslintLoader = {
      enforce: 'pre',
      test: /\.(js|vue)$/,
      loader: 'eslint-loader',
      exclude: /(node_modules)/,
    };
    // Add eslint loader
    config.module.rules.push(eslintLoader);
  });
}
