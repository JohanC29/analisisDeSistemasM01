<!-- Componente para el manejo de la tabla de resultados -->
<template>
  <div class="card text-end mb-3">
    <div class="card-body">
      <table class="table table-bordered" v-if="isVisible">
        <thead class="table-light">
          <tr>
            <th scope="col">Test</th>
            <th colspan="2" scope="col" class="text-center">Expected Value</th>
          </tr>
        </thead>
        <tbody>
          <tr class="table-active">
            <td></td>
            <td>Mean</td>
            <td>Std. Dev</td>
          </tr>
          <tr v-for="(item, index) in datos" :key="index">
            <td class="table-active">{{ item.description }}</td>
            <td>{{ item.mean }}</td>
            <td>{{ item.stdDev }}</td>
          </tr>
        </tbody>
      </table>
      <button @click="exportToCSV" class="btn btn-primary">
        Exportar a CSV
      </button>
    </div>
  </div>
</template>
  
  <script>
import Papa from "papaparse";
export default {
  props: {
    isVisible: {
      type: Boolean,
      required: true,
    },
    datos: {
      type: Array,
      required: true,
    },
  },
  methods: {
    exportToCSV() {
      // Preparar los datos para el archivo CSV
      const csvData = [];
      csvData.push(["Test", "Mean", "Std. Dev"]); // Encabezados

      for (const item of this.datos) {
        csvData.push([item.description, item.mean, item.stdDev]);
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