const ForkTsCheckerWebpackPlugin = require('fork-ts-checker-webpack-plugin')

export default function () {
  // Add .ts extension for store, middleware and more
  this.nuxt.options.extensions.push('ts')
  // Extend build
  this.extendBuild((config) => {
    const tsLoader = {
      loader: 'ts-loader',
      options: {
        appendTsSuffixTo: [/\.vue$/],
        transpileOnly: true,
      },
      exclude: [
        /dist/,
        /\.temp/,
      ],
    }
    // Add TypeScript loader
    config.module.rules.push(
      Object.assign(
        {
          test: /((client|server)\.js)|(\.tsx?)$/,
        },
        tsLoader,
      ),
    )
    // Add .ts extension in webpack resolve
    if (config.resolve.extensions.indexOf('.ts') === -1) {
      config.resolve.extensions.push('.ts')
    }

    config.plugins.push(
      new ForkTsCheckerWebpackPlugin({
        vue: true,
      }),
    )
  })
}
