<script setup>
import TableResult from "../components/TableResult.vue";
</script>

<template>
  <!-- El marcado HTML comienza aquí -->
  <main>
    <div class="container mt-5">
      <!-- Sección de visualización de resultados utilizando el componente personalizado 'table-result' -->
      <table-result :isVisible="true" :datos="datosTablaResult"></table-result>
    </div>
    <div class="container">
      <div class="card">
        <div class="card-body">
          <!-- Título del formulario -->
          <h1 class="card-title">Ingrese los datos para ser procesados:</h1>

          <!-- Filas de entrada de datos -->
          <div class="row justify-content-center mb-4 mt-4">
            <!-- Campo de entrada para 'Estimated Proxy Size' -->
            <div class="col-5">
              <label for="inputProxySize" class="form-label"
                >Estimated Proxy Size</label
              >

              <!-- Cambia el foco al campo 'Developer Hours' al presionar Enter -->
              <!-- Aplica una clase condicional según la validez -->
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
            <!-- Campo de entrada para 'Developer Hours' -->
            <!-- Cambia el foco al campo 'Estimated Proxy Size' al presionar Enter -->
            <!-- Aplica una clase condicional según la validez -->
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
            <!-- Botones de procesamiento y limpieza -->
            <div class="col-2 d-grid">
              <!-- Llama a la función 'procesarDatos' al hacer clic -->
              <button
                type="button"
                class="btn btn-primary btn-sm mb-1"
                @click="procesarDatos()"
              >
                <i class="bi bi-gear"></i> Procesar
              </button>
              <!-- Llama a la función 'limpiarDatos' al hacer clic -->
              <button
                type="button"
                class="btn btn-danger btn-sm"
                @click="limpiarDatos()"
              >
                <i class="bi bi-eraser-fill"></i> Limpiar
              </button>
            </div>
          </div>

          <!-- Tabla que muestra los datos ingresados -->
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
              <!-- Itera sobre la matriz de datos y muestra cada fila -->
              <tr v-for="(row, index) in matriz" :key="index">
                <th scope="row">{{ index + 1 }}</th>
                <!-- Número de fila -->
                <td>{{ row.proxySize }}</td>
                <!-- Valor de 'Estimated Proxy Size' -->
                <td>{{ row.developerHours }}</td>
                <!-- Valor de 'Developer Hours' -->
                <td class="text-center">
                  <!-- Botón para eliminar la fila -->
                  <!-- Llama a la función 'eliminarItem' al hacer clic -->
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
import { sharedMixin } from "../Mixin/sharedMixin.js"; // Importa un mixin llamado sharedMixin (no se proporciona aquí)

export default {
  components: { TableResult }, // Importa el componente personalizado TableResult

  created() {
    // Método creado automáticamente al crear la instancia del componente.
    // Recupera datos almacenados en el almacenamiento local si existen.
    if (localStorage.getItem("datos") != null) {
      this.matriz = JSON.parse(localStorage.datos); // Recupera y asigna los datos almacenados
    }
  },

  data() {
    // Definición de los datos locales del componente.
    return {
      proxySize: null, // Valor de 'Estimated Proxy Size'
      developerHours: null, // Valor de 'Developer Hours'
      item: {
        proxySize: 0,
        developerHours: 0,
      }, // Objeto para almacenar un elemento de datos
      matriz: [], // Matriz para almacenar datos ingresados
      isValideProxySize: "", // Clase CSS condicional para la validación de 'Estimated Proxy Size'
      isValideDeveloperHours: "", // Clase CSS condicional para la validación de 'Developer Hours'
      datosTablaResult: [], // Datos para la tabla de resultados
    };
  },

  mixins: [sharedMixin], // Agregar el mixin compartido al componente

  methods: {
    agregarItem() {
      // Método para agregar un elemento a la matriz 'matriz' si los valores son válidos
      if (
        this.validateInputNatural(this.proxySize) &&
        this.validateInputReal(this.developerHours)
      ) {
        this.item.proxySize = this.proxySize;
        this.item.developerHours = this.developerHours;
        this.matriz.push(this.item);
        localStorage.setItem("datos", JSON.stringify(this.matriz)); // Almacena datos en el almacenamiento local

        this.cleanInput(); // Limpia los campos de entrada y clases de validación
        this.$refs.inputProxySize.focus(); // Cambia el enfoque al campo 'Estimated Proxy Size'
      }
    },

    focusInputDeveloperHours() {
      // Método para manejar el cambio de enfoque al campo 'Developer Hours'
      if (this.validateInputNatural(this.proxySize)) {
        this.isValideProxySize = "is-valid"; // Aplica una clase de validación
        this.$refs.inputDeveloperHours.focus(); // Cambia el enfoque al campo 'Developer Hours'
        this.agregarItem(); // Agrega un elemento a la matriz
      } else {
        this.isValideProxySize = "is-invalid"; // Aplica una clase de validación
      }
    },

    focusInputProxySize() {
      // Método para manejar el cambio de enfoque al campo 'Estimated Proxy Size'
      if (this.validateInputReal(this.developerHours)) {
        this.isValideDeveloperHours = "is-valid"; // Aplica una clase de validación
        this.$refs.inputProxySize.focus(); // Cambia el enfoque al campo 'Estimated Proxy Size'
        this.agregarItem(); // Agrega un elemento a la matriz
      } else {
        this.isValideDeveloperHours = "is-invalid"; // Aplica una clase de validación
      }
    },

    validateInputNatural(value) {
      // Método para validar si el valor es un número natural
      if (value === null || !Number.isInteger(value)) {
        return false;
      }
      if (value < 0) {
        return false;
      }
      return true;
    },

    validateInputReal(value) {
      // Método para validar si el valor es un número real
      if (value === null || !isFinite(value)) {
        return false;
      }
      if (value < 0) {
        return false;
      }
      return true;
    },

    cleanInput() {
      // Método para limpiar los campos de entrada y clases de validación
      this.proxySize = null;
      this.developerHours = null;
      this.isValideDeveloperHours = null;
      this.isValideProxySize = null;
      this.item = { proxySize: 0, developerHours: 0 };
    },

    eliminarItem(index) {
      // Método para eliminar un elemento de la matriz en el índice dado
      this.matriz.splice(index, 1);
      localStorage.datos = JSON.stringify(this.matriz); // Actualiza los datos en el almacenamiento local
    },

    limpiarDatos() {
      // Método para limpiar los datos almacenados en el almacenamiento local y en la matriz
      localStorage.removeItem("datos");
      this.matriz = [];
      this.datosTablaResult = [];
    },

    procesarDatos() {
      // Método para procesar los datos almacenados en la matriz y calcular resultados
      if (this.matriz.length === 0) {
        this.datosTablaResult = [];
        return; // Retorna un arreglo vacío si la matriz está vacía
      }
      this.datosTablaResult = this.calcularResultados(this.matriz); // Calcula resultados
    },
  },
};
</script>
