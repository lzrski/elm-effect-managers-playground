import commonjs from 'rollup-plugin-commonjs'
import elm from 'rollup-plugin-elm'
import coffeescript from 'rollup-plugin-coffee-script'
import serve from "rollup-plugin-serve"

export default {
  input: 'src/index.coffee',
  output: {
    file: `built/bundle.js`,
    format: 'iife'
  },
  plugins: [
    serve({
      contentBase: ["built", "assets"]
    }),
    coffeescript(),
    elm({
        exclude: 'elm_stuff/**',
        compiler: {
          debug: true
        }
    }),
    commonjs({
      // add .elm extension
      extensions: ['.js', '.elm', '.coffee' ]
    })
  ],
  watch: {
    // add .elm files to watched files
    include: 'src/**'
  }
}
