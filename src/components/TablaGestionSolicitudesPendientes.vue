<!-- Componente para el manejo de la tabla de resultados -->
<template>
  <div class="card text-end mb-3">
    <div class="card-body">
      <button @click="exportToCSV" class="btn btn-primary mb-2">
        Exportar a CSV
      </button>
      <div class="table-responsive">
        <table class="table table-bordered">
          <thead class="table-light center">
            <tr class="text-center">
              <th>Documento</th>
              <th>Nombre</th>
              <th>Apellido</th>
              <th>Fecha Solicitud</th>
              <th>Rol</th>
              <th>Equipo</th>
              <th>Accion</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="(item, index) in reportData"
              :key="index"
              :class="{ 'table-danger': item.bloqueado == 'SI' }"
            >
              <td>{{ item.documento }}</td>
              <td>{{ item.nombre }}</td>
              <td>{{ item.apellido }}</td>
              <td>{{ item.fechasolicitud }}</td>
              <td>{{ item.rol }}</td>
              <td>
                <select
                  class="form-select"
                  :disabled="item.bloqueado == 'SI'"
                  aria-label="Lista de equipos"
                  :id="'selectEquipo' + index"
                  v-model="item.idequipo"
                >
                  <option
                    v-for="option in equipoDisponibleList"
                    :value="option.id"
                    :key="option.descripcion"
                  >
                    {{ option.descripcion }}
                  </option>
                </select>
              </td>
              <td>
                <div v-if="item.bloqueado == 'SI'">
                  <button
                    type="button"
                    class="btn btn-danger"
                    @click="eliminarSolicitud(item)"
                  >
                    Eliminar Solicitud
                  </button>
                </div>
                <div v-else>
                  <button
                    type="button"
                    class="btn btn-success"
                    :class="{ disabled: !item.idequipo }"
                    @click="confirmarAsignacion(item)"
                  >
                    Asignar equipo
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>
  
  <script>
import Papa from "papaparse";

import axios from "axios";
import {
  GET_SOLICITUDES_PENDIENTES,
  POST_SAVE_REGISTRO_PORTATIL,
  GET_EQUIPO_DISPONIBLE,
  DELETE_SOLICITUD_LISTA_NEGRA,
} from "@/config/apiUrls.js";

export default {
  computed: {
    objectKeys() {
      return this.reportData.length > 0 ? Object.keys(this.reportData[0]) : [];
    },
  },

  mounted() {
    this.inicio();
  },

  data() {
    return {
      reportData: [
        {
          idfuncionario: null,
          documento: null,
          rol: null,
          celular: null,
          nombre: null,
          idestudiante: null,
          idequipo: null,
          usuarioasigna: null,
          fecharegreso: null,
          fechaasigna: null,
          id: null,
          fechasolicitud: null,
          apellido: null,
          idprofesor: null,
          bloqueado: null,
        },
      ],
      equipoDisponibleList: [
        {
          id: null,
          descripcion: null,
          idsala: null,
        },
      ],
      seleccionEquipo: null,
      nombreUsuario: "ADMINISTRADOR",
    };
  },
  methods: {
    inicio() {
      axios
        .get(GET_SOLICITUDES_PENDIENTES)
        .then((response) => {
          console.log(response);
          if (response.data.code == 0) {
            this.reportData = response.data.list;
          } else {
            this.ubicacion = [];
            this.$toast.error("No hay solicitudes pendientes.");
          }
        })
        .catch((error) => {
          // Manejar el error
          console.error(
            "Error al obtener los datos de las solicitudes pendientes.",
            error
          );
          this.$toast.error(
            "Error al obtener los datos de de las solicitudes pendientes."
          );
        });

      // axios buscando los equipos disponibles
      axios
        .get(GET_EQUIPO_DISPONIBLE)
        .then((response) => {
          console.log(response);
          if (response.data.code == 0) {
            this.equipoDisponibleList = response.data.list;
          } else {
            this.ubicacion = [];
            this.$toast.error("No hay equipos disponibles.");
          }
        })
        .catch((error) => {
          // Manejar el error
          console.error(
            "Error al obtener los datos de los equipos disponibles.",
            error
          );
          this.$toast.error(
            "Error al obtener los datos de los equipos disponibles"
          );
        });
    },

    exportToCSV() {
      // Obtener los encabezados de las columnas de la primera fila de datos
      const headers = Object.keys(this.reportData[0]);
      const csvData = [headers]; // Incluir los encabezados como primera fila

      // Iterar sobre los datos para construir el resto del CSV
      for (const item of this.reportData) {
        const row = headers.map((header) =>
          item[header] === null ? "" : item[header]
        );
        csvData.push(row);
      }

      // Convertir los datos en formato CSV
      const csv = Papa.unparse(csvData, { delimiter: ";" });

      // Crear un enlace de descarga
      const blob = new Blob([csv], { type: "text/csv" });
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement("a");
      a.style.display = "none";
      a.href = url;
      a.download = "datos.csv";

      // Simular un clic en el enlace para descargar el archivo
      document.body.appendChild(a);
      a.click();

      // Limpiar y liberar recursos
      window.URL.revokeObjectURL(url);
      document.body.removeChild(a);
    },
    eliminarSolicitud(item) {
      console.log(item);
      // Use sweetalert2
      // this.$swal("Hello Vue world!!!");

      this.$swal
        .fire({
          title: "¿Estás seguro?",
          text: "¡No podrás revertir esto!",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#3085d6",
          cancelButtonColor: "#d33",
          confirmButtonText: "Si, Confirmo asignacion",
        })
        .then((result) => {
          console.log(result);
          if (result.isConfirmed) {
            axios
              .delete(DELETE_SOLICITUD_LISTA_NEGRA, {
                params: { id: item.id, usuario: this.nombreUsuario },
              })
              .then((response) => {
                console.log("Respuesta del servidor:", response.data);
                // Manejar respuesta
                if (response.data.code == 0) {
                  this.$toast.success("Eliminacion realiza con Exito!.");
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
          }
        });
    },

    confirmarAsignacion(item) {
      console.log(item);
      // Use sweetalert2
      // this.$swal("Hello Vue world!!!");

      this.$swal
        .fire({
          title: "¿Estás seguro?",
          text: "¡No podrás revertir esto!",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#3085d6",
          cancelButtonColor: "#d33",
          confirmButtonText: "Si, Confirmo asignacion",
        })
        .then((result) => {
          console.log(result);
          if (result.isConfirmed) {
            // this.$swal.fire({
            //   title: "Deleted!",
            //   text: "Your file has been deleted.",
            //   icon: "success",
            // });
            const requestSolicitudPortatil = {
              id: item.id,
              idfuncionario: null,
              idestudiante: null,
              idprofesor: null,
              celular: null,
              fechasolicitud: null,
              idequipo: item.idequipo,
              usuarioasigna: this.nombreUsuario,
              fechaasigna: null,
              fecharegreso: null,
            };
            this.asignarEquipo(requestSolicitudPortatil);
          }
        });
    },

    asignarEquipo(item) {
      // Se envia en momento 2
      axios
        .post(POST_SAVE_REGISTRO_PORTATIL + "/2", item)
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
    limpiarDatos() {
      this.reportData = [
        {
          idfuncionario: null,
          documento: null,
          rol: null,
          celular: null,
          nombre: null,
          idestudiante: null,
          idequipo: null,
          usuarioasigna: null,
          fecharegreso: null,
          fechaasigna: null,
          id: null,
          fechasolicitud: null,
          apellido: null,
          idprofesor: null,
        },
      ];
      this.equipoDisponibleList = [
        {
          id: null,
          descripcion: null,
          idsala: null,
        },
      ];
      this.inicio();
    },
  },
};
</script>