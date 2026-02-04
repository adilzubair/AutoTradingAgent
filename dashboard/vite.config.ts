import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'

const apiTarget = process.env.MAHORAGA_API_URL || 'https://mahoraga.pagesofadil.workers.dev'

export default defineConfig({
  plugins: [react(), tailwindcss()],
  server: {
    port: 3000,
    proxy: {
      '/api': {
        target: apiTarget,
        changeOrigin: true,
        secure: true,
        rewrite: (path) => path.replace(/^\/api/, '/agent'),
      },
    },
  },
})
