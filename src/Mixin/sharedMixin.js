// sharedMixin.js
// Este componente mixin cuenta con la logica necesaria
// para calcular el promedio y desviacion estandar de los datos
export const sharedMixin = {
  methods: {
    calcularResultados(matriz) {
      // Calcular media y desviación estándar para "proxySize"
      const itemResultProxy = {
        mean: this.calcularMedia(matriz, "proxySize"),
        stdDev: this.calcularDesviacionEstandar(matriz, "proxySize"),
        description: "Table 1: Column 1 proxySize",
      };

      // Calcular media y desviación estándar para "developerHours"
      const itemResultDeveloperHours = {
        mean: this.calcularMedia(matriz, "developerHours"),
        stdDev: this.calcularDesviacionEstandar(matriz, "developerHours"),
        description: "Table 1: Column 2 developerHours",
      };

      // Retorno de los resultados para ser ingresados al componente TableResult.vue
      return [itemResultProxy, itemResultDeveloperHours];
    },
    calcularMedia(arr, atributo) {
      if (arr.length === 0) {
        return NaN; // Retorna NaN si el arreglo está vacío
      }
      const suma = arr.reduce(
        (acumulador, item) => acumulador + item[atributo],
        0
      );
      return (suma / arr.length).toFixed(2);
    },
    calcularDesviacionEstandar(arr, atributo) {
      if (arr.length === 0) {
        return NaN; // Retorna NaN si el arreglo está vacío
      }

      const media = this.calcularMedia(arr, atributo);

      const sumaDiferenciasCuadradas = arr.reduce((acumulador, item) => {
        const diferencia = item[atributo] - media;
        return acumulador + diferencia * diferencia;
      }, 0);

      const varianza = sumaDiferenciasCuadradas / (arr.length - 1);
      const desviacionEstandar = Math.sqrt(varianza);

      // console.log(atributo);
      // console.log("Media: "+media);
      // console.log("sumaDiferenciasCuadradas: "+sumaDiferenciasCuadradas);
      // console.log("varianza: "+varianza);
      // console.log("desviacionEstandar: "+desviacionEstandar);

      return desviacionEstandar.toFixed(2);
    },
  },
};
