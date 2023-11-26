<!-- Componente para el manejo de la tabla de resultados -->
<template>
  <div class="card text-end mb-3">
    <div class="card-body">
      <button @click="exportToCSV" class="btn btn-primary mb-2">
        Exportar a CSV
      </button>
      <div class="table-responsive">
        <table class="table table-bordered" >
          <thead class="table-light">
            <tr>
              <th v-for="key in objectKeys" :key="key">
                {{ key }}
              </th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, index) in reportData" :key="index">
              <td v-for="key in objectKeys" :key="key">
                {{ item[key] }}
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
import { GET_REPORT_SALA_MODULO } from "@/config/apiUrls.js";

export default {
  computed: {
    objectKeys() {
      return this.reportData.length > 0 ? Object.keys(this.reportData[0]) : [];
    },
  },

  mounted() {
    this.fetchData();
  },

  data() {
    return {
      reportData: [],
    };
  },
  methods: {
    fetchData() {
      axios
        .get(GET_REPORT_SALA_MODULO)
        .then((response) => {
          this.reportData = response.data.list;
        })
        .catch((error) => {
          // Manejar el error
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
  },
};
</script>