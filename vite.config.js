import { defineConfig, loadEnv } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig(({ mode }) => {
  // Load env file based on `mode` in the current working directory.
  const env = loadEnv(mode, process.cwd(), '')
  
  return {
    plugins: [react()],
    base: "/",
    server: {
      port: '3000',
      proxy: {
        '/api': {
          target: "https://topazio-shop-backend.onrender.com",
          changeOrigin: true,
          //rewrite: (path) => path.replace(/^\/api/, '')
        }
      }
    }
  }
});