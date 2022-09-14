import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import { splitVendorChunkPlugin } from 'vite'

export default defineConfig({
  plugins: [
    RubyPlugin(),
    splitVendorChunkPlugin()
  ],
})
