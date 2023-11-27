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
              <th>Retorno</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, index) in reportData" :key="index">
              <td>{{ item.documento }}</td>
              <td>{{ item.nombre }}</td>
              <td>{{ item.apellido }}</td>
              <td>{{ item.fechasolicitud }}</td>
              <td>{{ item.rol }}</td>
              <td>
                <button
                  type="button"
                  class="btn btn-success"
                  @click="confirmarRecibido(item.id)"
                >
                  Confirmar
                </button>
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
  GET_PORTATILES_SIN_DEVOLVER,
  POST_SAVE_REGISTRO_PORTATIL,
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
        },
      ],
    };
  },
  methods: {
    inicio() {
      axios
        .get(GET_PORTATILES_SIN_DEVOLVER)
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

    confirmarRecibido(iid) {
      console.log(iid);
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
          confirmButtonText: "Si, Confirmo recibido",
        })
        .then((result) => {
          console.log(result);
          if (result.isConfirmed) {
            const requestSolicitudPortatil = {
              id: iid,
              idfuncionario: null,
              idestudiante: null,
              idprofesor: null,
              celular: null,
              fechasolicitud: null,
              idequipo: null,
              usuarioasigna: null,
              fechaasigna: null,
              fecharegreso: null,
            };
            this.procesoRecibido(requestSolicitudPortatil);

            // this.$swal.fire({
            //   title: "Deleted!",
            //   text: "Your file has been deleted.",
            //   icon: "success",
            // });
          }
        });
    },
    procesoRecibido(requestSolicitudPortatil) {
      // Se envia en momento 2
      axios
        .post(POST_SAVE_REGISTRO_PORTATIL + "/3", requestSolicitudPortatil)
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
      this.inicio();
    },
  },
};
</script>