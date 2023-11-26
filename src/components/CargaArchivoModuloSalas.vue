<!-- Componente para el manejo de la tabla de resultados -->
<template>
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
              :class="{ disabled: !matriz }"
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
                <th>Documento</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>IdPrograma</th>
                <th>IdSemestre</th>
                <th>IdJornada</th>
                <th>Estado</th>
              </tr>
            </thead>
            <tbody class="text-center">
              <tr v-for="(row, index) in matriz" :key="index">
                <td>{{ row.documento }}</td>
                <td>{{ row.nombre }}</td>
                <td>{{ row.apellido }}</td>
                <td
                  :class="{ 'table-danger': !esValidoPrograma(row.idprograma) }"
                >
                  {{ row.idprograma }}
                </td>
                <td
                  :class="{ 'table-danger': !esValidoSemetre(row.idsemestre) }"
                >
                  {{ row.idsemestre }}
                </td>
                <td
                  :class="{ 'table-danger': !esValidoJornada(row.idjornada) }"
                >
                  {{ row.idjornada }}
                </td>
                <td :class="{ 'table-danger': !esValidoEstado(row.estado) }">
                  {{ row.estado }}
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- tablas con informacion para llenar el archivo plano -->
        <div class="table-responsive">
          <h2 class="mt-4">Programas:</h2>
          <table class="table table-bordered">
            <thead class="table-light text-center">
              <th v-for="key in listProgramas" :key="key">
                {{ key }}
              </th>
            </thead>
            <tbody class="text-center">
              <tr v-for="(item, index) in listProgramasData" :key="index">
                <td v-for="key in listProgramas" :key="key">
                  {{ item[key] }}
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class="table-responsive">
          <h2 class="mt-4">Semetres:</h2>
          <table class="table table-bordered">
            <thead class="table-light text-center">
              <th v-for="key in listSemestres" :key="key">
                {{ key }}
              </th>
            </thead>
            <tbody class="text-center">
              <tr v-for="(item, index) in listSemetresData" :key="index">
                <td v-for="key in listSemestres" :key="key">
                  {{ item[key] }}
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class="table-responsive">
          <h2 class="mt-4">Jornadas:</h2>
          <table class="table table-bordered">
            <thead class="table-light text-center">
              <th v-for="key in listJornadas" :key="key">
                {{ key }}
              </th>
            </thead>
            <tbody class="text-center">
              <tr v-for="(item, index) in listJornadasData" :key="index">
                <td v-for="key in listJornadas" :key="key">
                  {{ item[key] }}
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>
  
  <script>
import Papa from "papaparse";

import axios from "axios";
import {
  GET_SEMESTRE,
  GET_PROGRAMA,
  GET_JORNADA,
  POST_SAVE_ESTUDIANTE_LISTA,
} from "@/config/apiUrls.js";

export default {
  computed: {
    listProgramas() {
      return this.listProgramasData.length > 0
        ? Object.keys(this.listProgramasData[0])
        : [];
    },

    listSemestres() {
      return this.listSemetresData.length > 0
        ? Object.keys(this.listSemetresData[0])
        : [];
    },

    listJornadas() {
      return this.listJornadasData.length > 0
        ? Object.keys(this.listJornadasData[0])
        : [];
    },
  },
  mounted() {
    this.cargaDatosMaestros();
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
      listProgramasData: [],
      listSemetresData: [],
      listJornadasData: [],
      listEstado: ["ACTIVO", "INACTIVO"],
    };
  },
  methods: {
    cargaDatosMaestros() {
      axios
        .get(GET_PROGRAMA)
        .then((response) => {
          this.listProgramasData = response.data.list;
        })
        .catch((error) => {
          // Manejar el error
        });

      // Consulta de Semetres
      axios
        .get(GET_SEMESTRE)
        .then((response) => {
          this.listSemetresData = response.data.list;
        })
        .catch((error) => {
          // Manejar el error
        });

      // Consulta de Jornadas
      axios
        .get(GET_JORNADA)
        .then((response) => {
          this.listJornadasData = response.data.list;
        })
        .catch((error) => {
          // Manejar el error
        });
    },

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
          console.log(result.data);
          if (this.validarEstructura(result.data)) {
            this.data = result.data; // Almacena los datos analizados en 'data'

            // Almacena los datos en el almacenamiento local del navegador
            if (this.checkHeaders) {
              this.data.shift(); // Excluye la primera fila si se deben excluir encabezados
            }

            this.validarYEliminarUltimaFila(); // Valida y elimina la última fila si es necesario

            // Convierte los datos en una matriz y almacena en 'matriz'
            this.data.forEach((element) => {
              this.llenadoMatriz(
                element[0],
                element[1],
                element[2],
                element[3],
                element[4],
                element[5],
                element[6]
              );
            });
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
      this.matriz = [];

      this.clearFileInput(); // Limpia el campo de selección de archivo
    },
    clearFileInput() {
      // Limpia el campo de selección de archivo
      this.$refs.fileInput.value = "";
    },

    validarEstructura(datos) {
      if (datos[0].length !== 7) {
        this.$toast.error(
          "¡Error! Estructura invalida. Debe contener siete columnas."
        );
        return false;
      }
      return true;
    },

    validarYEliminarUltimaFila() {
      // Valida si la última fila está vacía, null o undefined y la elimina si es necesario
      const ultimoElementos = this.data[this.data.length - 1];
      for (let elemento of ultimoElementos) {
        if (elemento === "" || elemento === null || elemento === undefined) {
          this.data.pop(); // Elimina la última fila
          return;
        }
      }
    },
    llenadoMatriz(
      idocumento,
      inombre,
      iapellido,
      iidprograma,
      iidsemestre,
      iidjornada,
      iestado
    ) {
      // Llena la matriz con datos del archivo CSV
      const item = {
        documento: null,
        nombre: inombre,
        apellido: iapellido,
        idprograma: null,
        idsemestre: null,
        idjornada: null,
        estado: iestado,
      };

      item.documento = parseInt(idocumento); // Convierte a entero
      item.idprograma = parseInt(iidprograma); // Convierte a entero
      item.idsemestre = parseInt(iidsemestre); // Convierte a entero
      item.idjornada = parseInt(iidjornada); // Convierte a entero

      this.matriz.push(item); // Agrega el elemento a la matriz
    },
    esValidoPrograma(iidPrograma) {
      return this.listProgramasData.some(function (elemento) {
        return parseInt(elemento.id) === iidPrograma;
      });
    },
    esValidoSemetre(iidSemestre) {
      return this.listSemetresData.some(function (elemento) {
        return parseInt(elemento.id) === iidSemestre;
      });
    },
    esValidoJornada(iidjornada) {
      return this.listJornadasData.some(function (elemento) {
        return parseInt(elemento.id) === iidjornada;
      });
    },
    esValidoEstado(iestado) {
      return this.listEstado.some(function (elemento) {
        return elemento === iestado;
      });
    },
    procesarDatos() {
      console.log("Matriz");
      console.log(this.matriz);

      // Validacion por cada linea de los datos cargados
      for (let i = 0; i < this.matriz.length; i++) {
        const item = this.matriz[i];
        console.log(item);

        // Proceso de validacion de datos
        let esValido =
          this.esValidoPrograma(item.idprograma) &&
          this.esValidoSemetre(item.idsemestre) &&
          this.esValidoJornada(item.idjornada) &&
          this.esValidoEstado(item.estado);

        if (!esValido) {
          this.$toast.error(
            "¡Error! La informacion cargada no puede ser procesada. Por Favor validar!"
          );
          return; // Esto detendrá la ejecución de procesarDatos
        }
      }

      // // Validacion por cada linea de los dastos cargados
      // this.matriz.forEach((item) => {
      //   console.log(item);
      //   // Proceso de validacion de datos
      //   let esValido = true;
      //   esValido = esValido ? this.esValidoPrograma(item.idprograma) : esValido;

      //   esValido = esValido ? this.esValidoSemetre(item.idsemestre) : esValido;
      //   esValido = esValido ? this.esValidoJornada(item.idjornada) : esValido;
      //   esValido = esValido ? this.esValidoEstado(item.estado) : esValido;

      //   if (!esValido) {
      //     this.$toast.error(
      //       "¡Error! La informacion cargada no puede ser procesada. Por Favor validar!"
      //     );
      //     return;
      //   }
      // });

      // Realizar envio de la peticion, donde se procesen todos los datos de la matriz y se creen los estudiantes nuevos

      axios
        .post(POST_SAVE_ESTUDIANTE_LISTA, this.matriz)
        .then((response) => {
          console.log("Respuesta del servidor:", response.data);
          // Manejar respuesta
          if (response.data.code == 0) {
            this.$toast.success("Registro realizado con Exito!.");
            this.limpiarDatos();
          } else {
            this.$toast.error("Corrio un error almacenando los datos.");
          }
        })
        .catch((error) => {
          // Manejar error
          console.error("Error almacenando los registros.", error);
          this.$toast.error("Error almacenando los registros.");
        });
    },
  },
};
</script>