# ejercicio1

This template should help get you started developing with Vue 3 in Vite.

## Diagrama de Flujo

[Ver Diagrama Mermaid](./diagrama/diagramaFlujo.md)
***
## Recommended IDE Setup

[VSCode](https://code.visualstudio.com/) + [Volar](https://marketplace.visualstudio.com/items?itemName=Vue.volar) (and disable Vetur) + [TypeScript Vue Plugin (Volar)](https://marketplace.visualstudio.com/items?itemName=Vue.vscode-typescript-vue-plugin).

## Customize configuration

See [Vite Configuration Reference](https://vitejs.dev/config/).

## Project Setup

```sh
npm install
```

### Compile and Hot-Reload for Development

```sh
npm run dev
```

### Compile and Minify for Production

```sh
npm run build
```

## comandos para desplegar

1. Generacion del dist
`npm run build`

2. Creacion de la imagen

`docker build -t phx.ocir.io/arqcloudoci/arqbs-registry:prueba-vue-0.0.1 .`

3. Subiendo la imagen al repositorio

`docker push phx.ocir.io/arqcloudoci/arqbs-registry:prueba-vue-0.0.1`
