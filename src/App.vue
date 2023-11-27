<script setup>
import { RouterLink, RouterView } from "vue-router";
</script>

<template>
  <header>
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
      <div class="wrapper">
        <ul class="nav nav-tabs">
          <li class="nav-item">
            <RouterLink class="nav-link active" to="/">Manual</RouterLink>
          </li>
          <li class="nav-item">
            <RouterLink class="nav-link" to="/carga-archivo"
              >Cargar Archivo</RouterLink
            >
          </li>
          <li class="nav-item">
            <RouterLink class="nav-link" to="/modulo-salas"
              >Modulo Salas</RouterLink
            >
          </li>
          <li class="nav-item">
            <RouterLink class="nav-link" to="/modulo-portatiles"
              >Modulo Portatiles</RouterLink
            >
          </li>
        </ul>
      </div>
    </nav>
  </header>
  <RouterView />
</template>