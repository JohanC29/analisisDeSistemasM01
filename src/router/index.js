import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import cargaArchivoView from '../views/cargaArchivo/View.vue'
import moduloSalasView from '../views/moduloSalas/View.vue'
import moduloPortatilesView from '../views/moduloPortatiles/View.vue'


const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/carga-archivo',
      name: 'cargaArchivo',
      // Componente para el proceso de cargue de archivo
      component: cargaArchivoView
    },
    {
      path: '/modulo-salas',
      name: 'moduloSalas',
      // Componente para el proceso de cargue de archivo
      component: moduloSalasView
    },
    {
      path: '/modulo-portatiles',
      name: 'moduloPortatiles',
      // Componente para el proceso de cargue de archivo
      component: moduloPortatilesView
    },
  ]
})

export default router
