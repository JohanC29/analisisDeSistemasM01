<script setup>
import TableResult from "../../components/TableResult.vue";
</script>
<template>
  <main>
    <div class="container mt-5">
      <table-result :isVisible="true" :datos="datosTablaResult"></table-result>
    </div>
    <div class="container">
      <div class="card">
        <div class="card-body">
          <h1 class="card-title">Subir archivo CSV</h1>

          <div class="row">
            <div class="col">
              <div class="row">
                <label for="staticEmail" class="col-sm-6 col-form-label"
                  >Delimitador</label
                >
                <div class="col-sm-4">
                  <input class="form-control" type="text" v-model="delimiter" />
                </div>
              </div>
            </div>
            <div class="col">
              <div class="row">
                <label for="staticEmail" class="col-sm-6 col-form-label"
                  >Decimal</label
                >
                <div class="col-sm-4">
                  <input
                    class="form-control"
                    type="text"
                    v-model="caracterDecimal"
                  />
                </div>
              </div>
            </div>
            <div class="col">
              <div class="form-check">
                <label class="form-check-label" for="checkHeaders">
                  Excluir encabezados
                </label>
                <input
                  class="form-check-input"
                  type="checkbox"
                  value=""
                  id="checkHeaders"
                  v-model="checkHeaders"
                />
              </div>
            </div>
          </div>
          <div class="row mt-2">
            <div class="col">
              <input
                type="file"
                ref="fileInput"
                @change="handleFileUpload"
                class="form-control mb-3"
                accept=".csv"
              />
            </div>
          </div>

          <div class="row">
            <div class="col-3 d-grid">
              <button
                type="button"
                class="btn btn-primary btn-sm mb-1"
                @click="procesarDatos()"
              >
                <i class="bi bi-gear"></i> Procesar
              </button>
            </div>
            <div class="col-3 d-grid">
              <button
                type="button"
                class="btn btn-danger btn-sm"
                @click="limpiarDatos()"
              >
                <i class="bi bi-eraser-fill"></i> Limpiar
              </button>
            </div>
          </div>

          <div v-if="data">
            <h2 class="mt-4">Contenido del archivo CSV:</h2>
            <table class="table table-bordered">
              <thead>
                <tr>
                  <th>Estimated Proxy Size</th>
                  <th>Development Hours</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(row, index) in data" :key="index">
                  <td>{{ row[0] }}</td>
                  <td>{{ row[1] }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </main>
</template>

<script>
import Papa from "papaparse";
import { sharedMixin } from "../../Mixin/sharedMixin.js";

export default {
  components: { TableResult },
  created() {
    if (localStorage.getItem("checkHeaders") != null) {
      this.checkHeaders = localStorage.checkHeaders;
    }
    if (localStorage.getItem("delimiter") != null) {
      this.delimiter = localStorage.delimiter;
    }
    if (localStorage.getItem("caracterDecimal") != null) {
      this.caracterDecimal = localStorage.caracterDecimal;
    }
  },
  data() {
    return {
      data: null,
      checkHeaders: null,
      delimiter: null,
      datosTablaResult: [],
      matriz: [],
      caracterDecimal: null,
    };
  },
  mixins: [sharedMixin],
  methods: {
    handleFileUpload(event) {
      const file = event.target.files[0];

      if (this.checkHeaders === null) {
        this.checkHeaders = false;
      }

      if (this.delimiter === null) {
        this.delimiter = ";";
      }

      Papa.parse(file, {
        delimiter: this.delimiter,
        header: false,
        complete: (result) => {
          this.data = result.data;

          // Almacena los datos en el almacenamiento local del navegador
          if (this.checkHeaders) {
            this.data.shift();
          }

          this.validarYEliminarUltimaFila();

          this.data.forEach((element) => {
            this.llenadoMatriz(element[0], element[1]);
          });

          localStorage.setItem("checkHeaders", this.checkHeaders);
          localStorage.setItem("delimiter", this.delimiter);
          localStorage.setItem("caracterDecimal", this.caracterDecimal);
        },
        error: (error) => {
          console.error(error.message);
        },
      });
    },

    limpiarDatos() {
      this.checkHeaders = null;
      this.delimiter = null;
      this.datosTablaResult = [];
      this.data = null;

      this.clearFileInput();

      localStorage.removeItem("datos");
      localStorage.removeItem("checkHeaders");
      localStorage.removeItem("delimiter");
    },

    clearFileInput() {
      this.$refs.fileInput.value = "";
    },

    llenadoMatriz(proxySize, developerHours) {
      const item = {
        proxySize: 0,
        developerHours: 0,
      };

      item.proxySize = parseInt(proxySize);
      item.developerHours = parseFloat(
        developerHours.replace(this.caracterDecimal, ".")
      );

      

      this.matriz.push(item);
    },

    procesarDatos() {
      if (this.matriz.length === 0) {
        this.datosTablaResult = [];
        return; // Retorna NaN si el arreglo está vacío
      }

      this.datosTablaResult = this.calcularResultados(this.matriz);

    },
    validarYEliminarUltimaFila() {
      // Validar si la última fila está vacía, null o undefined
      const ultimoElemento = this.data[this.data.length - 1];

      if (
        ultimoElemento.developerHours === "" ||
        ultimoElemento.developerHours === null ||
        ultimoElemento.developerHours === undefined ||
        ultimoElemento.proxySize === "" ||
        ultimoElemento.proxySize === null ||
        ultimoElemento.proxySize === undefined
      ) {
        this.data.pop(); // Eliminar la última fila
      }
      // this.miArray contendrá el array sin la última fila vacía, null o undefined
    },
  },
};
</script>

<style>
/* Puedes personalizar los estilos aquí según tus preferencias */
</style>