import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import cargaArchivoView from '../views/cargaArchivo/View.vue'


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
    }
  ]
})

export default router
