<script setup>
import TableResult from "../components/TableResult.vue";
</script>

<template>
  <main>
    <div class="container mt-5">
      <table-result :isVisible="true" :datos="datosTablaResult"></table-result>
    </div>
    <div class="container">
      <div class="card">
        <div class="card-body">
          <h1 class="card-title">Ingrese los datos para ser procesados:</h1>

          <div class="row justify-content-center mb-4 mt-4">
            <div class="col-5">
              <label for="inputProxySize" class="form-label"
                >Estimated Proxy Size</label
              >
              <input
                type="number"
                class="form-control"
                id="inputProxySize"
                placeholder="123"
                min="0"
                v-model="proxySize"
                @keyup.enter="focusInputDeveloperHours()"
                ref="inputProxySize"
                :class="isValideProxySize"
              />
            </div>
            <div class="col-5">
              <label for="inputDeveloperHours" class="form-label"
                >Developer Hours</label
              >
              <input
                type="number"
                class="form-control"
                id="inputDeveloperHours"
                placeholder="1.5"
                min="0"
                v-model="developerHours"
                @keyup.enter="focusInputProxySize()"
                ref="inputDeveloperHours"
                :class="isValideDeveloperHours"
              />
            </div>
            <div class="col-2 d-grid">
              <button
                type="button"
                class="btn btn-primary btn-sm mb-1"
                @click="procesarDatos()"
              >
                <i class="bi bi-gear"></i> Procesar
              </button>
              <button
                type="button"
                class="btn btn-danger btn-sm"
                @click="limpiarDatos()"
              >
                <i class="bi bi-eraser-fill"></i> Limpiar
              </button>
            </div>
          </div>

          <table class="table table-hover table-bordered table-sm">
            <thead class="table-light">
              <tr class="text-center">
                <th scope="col">#</th>
                <th scope="col">Estimated Proxy Size</th>
                <th scope="col">Developer Hours</th>
                <th scope="col">Option</th>
              </tr>
            </thead>
            <tbody class="text-center">
              <tr v-for="(row, index) in matriz" :key="index">
                <th scope="row">{{ index + 1 }}</th>
                <td>{{ row.proxySize }}</td>
                <td>{{ row.developerHours }}</td>
                <td class="text-center">
                  <button
                    @click="eliminarItem(index)"
                    type="button"
                    class="btn btn-outline-danger"
                  >
                    <i class="bi bi-trash3-fill"></i>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </main>
</template>

<script>
import { sharedMixin } from '../Mixin/sharedMixin.js';
export default {
  components: { TableResult },
  created() {
    if (localStorage.getItem("datos") != null) {
      this.matriz = JSON.parse(localStorage.datos);
    }
  },
  data() {
    return {
      proxySize: null,
      developerHours: null,
      item: {
        proxySize: 0,
        developerHours: 0,
      },
      matriz: [],
      isValideProxySize: "",
      isValideDeveloperHours: "",
      datosTablaResult: [],
    };
  },
  mixins: [sharedMixin],
  methods: {
    agregarItem() {
      // Validamos que ambos esten correctos
      if (
        this.validateInputNatural(this.proxySize) &&
        this.validateInputReal(this.developerHours)
      ) {
        this.item.proxySize = this.proxySize;
        this.item.developerHours = this.developerHours;
        this.matriz.push(this.item);
        localStorage.setItem("datos", JSON.stringify(this.matriz));

        this.cleanInput();
        this.$refs.inputProxySize.focus();
      }
    },
    focusInputDeveloperHours() {
      if (this.validateInputNatural(this.proxySize)) {
        this.isValideProxySize = "is-valid";
        this.$refs.inputDeveloperHours.focus();
        this.agregarItem();
      } else {
        this.isValideProxySize = "is-invalid";
      }
    },
    focusInputProxySize() {
      if (this.validateInputReal(this.developerHours)) {
        this.isValideDeveloperHours = "is-valid";
        this.$refs.inputProxySize.focus();
        this.agregarItem();
      } else {
        this.isValideDeveloperHours = "is-invalid";
      }
    },
    validateInputNatural(value) {
      // Verificar si el número es natural
      if (value === null || !Number.isInteger(value)) {
        return false;
      }
      // Validamos que tenga un valor
      if (value == null) {
        return false;
      }
      // Si el numero es mayor a cero
      if (value < 0) {
        return false;
      }
      // Validar si el numero no es un numero natural
      return true;
    },
    validateInputReal(value) {
      // Verificar si el número es real
      if (value === null || !isFinite(value)) {
        return false;
      }
      // Validamos que tenga un valor
      if (value == null) {
        return false;
      }
      // Si el numero es mayor a cero
      if (value < 0) {
        return false;
      }
      // Validar si el numero no es un numero natural
      return true;
    },
    cleanInput() {
      this.proxySize = null;
      this.developerHours = null;
      this.isValideDeveloperHours = null;
      this.isValideProxySize = null;
      this.item = { proxySize: 0, developerHours: 0 };
    },
    eliminarItem(index) {
      // Elimina el elemento en el índice dado de la matriz data
      this.matriz.splice(index, 1);
      localStorage.datos = JSON.stringify(this.matriz);
    },
    limpiarDatos() {
      localStorage.removeItem("datos");
      this.matriz = [];
      this.datosTablaResult = [];
    },
    procesarDatos() {
      if (this.matriz.length === 0) {
        this.datosTablaResult = [];
        return; // Retorna NaN si el arreglo está vacío
      }
      this.datosTablaResult =this.calcularResultados(this.matriz);
    },
  },
};
</script>