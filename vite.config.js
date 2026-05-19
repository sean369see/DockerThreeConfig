import react from '@vitejs/plugin-react'
import { transformWithEsbuild } from 'vite'
import restart from 'vite-plugin-restart'

export default {
    root: 'src/',
    publicDir: '../public/',
    plugins:
        [
            // Restart server on static/public file change
            restart({ restart: ['../public/**',] }),

            // React support
            react(),

            // .js file support as if it was JSX
            {
                name: 'load+transform-js-files-as-jsx',
                async transform(code, id) {
                    if (!id.match(/src\/.*\.js$/))
                        return null

                    return transformWithEsbuild(code, id, {
                        loader: 'jsx',
                        jsx: 'automatic',
                    });
                },
            },
        ],
    server:
    {
        host: true, // Open to local network and display URL
        // disable browser opening (open: false) for docker container version
        open: false,
        // open: !('SANDBOX_URL' in process.env || 'CODESANDBOX_HOST' in process.env), // Open if it's not a CodeSandbox
        // port: 5173, // added for docker, maybe not needed
        // strictPort: true, // added for docker 

    },
    build:
    {
        outDir: '../dist', // Output in the dist/ folder
        emptyOutDir: true, // Empty the folder first
        sourcemap: false // Add sourcemap
    },
}