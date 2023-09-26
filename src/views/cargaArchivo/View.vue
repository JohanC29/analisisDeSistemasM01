<script setup>
import TableResult from "../../components/TableResult.vue";
</script>
<template>
  <!-- Contenedor principal de la aplicación -->
  <main>
    <div class="container mt-5">
      <!-- Componente personalizado TableResult -->
      <table-result :isVisible="true" :datos="datosTablaResult"></table-result>
    </div>
    <div class="container">
      <div class="card">
        <div class="card-body">
          <h1 class="card-title">Subir archivo CSV</h1>

          <!-- Formulario para configuración de procesamiento CSV -->
          <div class="row">
            <!-- Configuración del delimitador CSV -->
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
            <!-- Configuración del carácter decimal -->
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
            <!-- Opción para excluir encabezados del archivo CSV -->
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
          <!-- Input de selección de archivo CSV -->
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

          <!-- Botones para procesar y limpiar datos -->
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

          <!-- Mostrar datos del archivo CSV procesado -->
          <div v-if="data">
            <h2 class="mt-4">Contenido del archivo CSV:</h2>

            <table class="table table-hover table-bordered table-sm">
              <thead class="table-light">
                <tr class="text-center">
                  <!-- <table class="table table-bordered">
              <thead>
                <tr> -->
                  <th>Estimated Proxy Size</th>
                  <th>Development Hours</th>
                </tr>
              </thead>
              <tbody class="text-center">
                <tr
                  v-for="(row, index) in data"
                  :key="index"
                  :class="{ 'table-danger': !areNumbers(row) }"
                >
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
import Papa from "papaparse"; // Importar la biblioteca PapaParse para analizar archivos CSV
import { sharedMixin } from "../../Mixin/sharedMixin.js"; // Importar un mixin llamado sharedMixin (no se proporciona aquí)

export default {
  components: { TableResult }, // Importar el componente personalizado TableResult
  created() {
    // Método creado automáticamente al crear la instancia del componente.
    // Recupera configuraciones previas desde el almacenamiento local del navegador si existen.
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
    // Definición de los datos locales del componente.
    return {
      data: null, // Datos del archivo CSV analizado
      checkHeaders: null, // Bandera para excluir encabezados
      delimiter: null, // Delimitador utilizado en el archivo CSV
      datosTablaResult: [], // Datos para la tabla de resultados
      matriz: [], // Una matriz para almacenar datos del archivo CSV
      caracterDecimal: null, // Carácter decimal utilizado en el archivo CSV
    };
  },

  mixins: [sharedMixin], // Agregar el mixin compartido al componente

  methods: {
    handleFileUpload(event) {
      // Maneja la carga de un archivo CSV desde el formulario
      const file = event.target.files[0];

      // Configuraciones por defecto si no se especifican
      if (this.checkHeaders === null) {
        this.checkHeaders = false;
      }

      if (this.delimiter === null) {
        this.delimiter = ";";
      }

      // Utiliza PapaParse para analizar el archivo CSV
      Papa.parse(file, {
        delimiter: this.delimiter, // Utiliza el delimitador especificado
        header: false, // Indica que el archivo CSV no tiene encabezados
        complete: (result) => {
          if (this.validarEstructura(result.data)) {
            this.data = result.data; // Almacena los datos analizados en 'data'

            // Almacena los datos en el almacenamiento local del navegador
            if (this.checkHeaders) {
              this.data.shift(); // Excluye la primera fila si se deben excluir encabezados
            }

            this.validarYEliminarUltimaFila(); // Valida y elimina la última fila si es necesario

            // Convierte los datos en una matriz y almacena en 'matriz'
            this.data.forEach((element) => {
              this.llenadoMatriz(element[0], element[1]);
            });

            // Validacion si los datos ingresados son todos numeros
            if (!this.validarEsMatrizNumero(this.matriz)) {
              this.matriz = [];
              return;
            }

            // Almacena las configuraciones en el almacenamiento local
            localStorage.setItem("checkHeaders", this.checkHeaders);
            localStorage.setItem("delimiter", this.delimiter);
            localStorage.setItem("caracterDecimal", this.caracterDecimal);
          }
        },
        error: (error) => {
          console.error(error.message); // Maneja errores y los muestra en la consola
          this.$toast.error(
            "¡Error! El archivo no cuenta con el formato adecuado."
          );
        },
      });
    },

    limpiarDatos() {
      // Restablece todas las configuraciones y datos
      this.checkHeaders = null;
      this.delimiter = null;
      this.datosTablaResult = [];
      this.data = null;
      this.caracterDecimal = null;

      this.clearFileInput(); // Limpia el campo de selección de archivo

      // Elimina las configuraciones del almacenamiento local
      localStorage.removeItem("datos");
      localStorage.removeItem("checkHeaders");
      localStorage.removeItem("delimiter");
      localStorage.removeItem("caracterDecimal");
      localStorage.removeItem("csvData");
    },

    clearFileInput() {
      // Limpia el campo de selección de archivo
      this.$refs.fileInput.value = "";
    },

    llenadoMatriz(proxySize, developerHours) {
      // Llena la matriz con datos del archivo CSV
      const item = {
        proxySize: 0,
        developerHours: 0,
      };

      item.proxySize = parseInt(proxySize); // Convierte a entero
      item.developerHours = parseFloat(
        developerHours.replace(this.caracterDecimal, ".")
      ); // Convierte a flotante y reemplaza el carácter decimal

      this.matriz.push(item); // Agrega el elemento a la matriz
    },

    procesarDatos() {
      // Procesa los datos almacenados en 'matriz' y actualiza 'datosTablaResult'
      if (this.matriz.length === 0) {
        this.datosTablaResult = [];
        this.$toast.error("¡Error! Por favor cargue un archivo plano.");
        return; // Retorna un arreglo vacío si la matriz está vacía
      }

      this.datosTablaResult = this.calcularResultados(this.matriz); // Calcula resultados
      this.$toast.success("¡Éxito! Datos procesados.");
    },

    validarYEliminarUltimaFila() {
      // Valida si la última fila está vacía, null o undefined y la elimina si es necesario
      const ultimoElemento = this.data[this.data.length - 1];

      if (
        ultimoElemento.developerHours === "" ||
        ultimoElemento.developerHours === null ||
        ultimoElemento.developerHours === undefined ||
        ultimoElemento.proxySize === "" ||
        ultimoElemento.proxySize === null ||
        ultimoElemento.proxySize === undefined
      ) {
        this.data.pop(); // Elimina la última fila
      }
    },

    validarEstructura(datos) {
      
      if (datos[0].length !== 2) {
        this.$toast.error(
          "¡Error! Estructura invalida. Debe contener dos columnas."
        );
        return false;
      }
      return true;
    },
    validarEsMatrizNumero(matriz) {
      for (const fila of this.matriz) {
        
        if (
          isNaN(Number(fila.proxySize)) ||
          isNaN(Number(fila.developerHours))
        ) {
          this.$toast.error(
            "¡Error! El archivo cargado contiene un elemento que no es un número válido. "
          );
          return false;
        }
      }
      return true;
    },
    areNumbers(row) {
      return row.every((value) => !isNaN(parseFloat(value)));
    },
  },
};
</script>
