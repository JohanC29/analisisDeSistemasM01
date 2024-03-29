// Definición de URLs de API
// const API_BASE_URL = 'http://localhost:8080/api';
const API_BASE_URL = "/api";

export const GET_ESTUDIANTE_BY_DOCUMENTO = `${API_BASE_URL}/salas-controller/get-estudiante-by-documento`;
export const GET_SALA_DISPONIBLE = `${API_BASE_URL}/salas-controller/get-sala-disponible`;
export const GET_EQUIPO_BY_IDSALA = `${API_BASE_URL}/salas-controller/get-equipo-by-idsala`;
export const POST_SAVE_REGISTROESTUDIANTE = `${API_BASE_URL}/salas-controller/save-registroestudiante`;
export const GET_INVITADO_BY_DOCUMENTO = `${API_BASE_URL}/salas-controller/get-invitado-by-identificacion`;
export const GET_FACULTAD = `${API_BASE_URL}/salas-controller/get-facultad`;
export const GET_PROGRAMA_BY_FACULTAD = `${API_BASE_URL}/salas-controller/get-programa-by-idfacultad`;
export const POST_SAVE_INVITADO = `${API_BASE_URL}/salas-controller/save-invitado`;
export const GET_PROFESOR = `${API_BASE_URL}/salas-controller/get-profesor`;
export const GET_CURSO_BY_PROGRAMA = `${API_BASE_URL}/salas-controller/get-curso-by-idprograma`;
export const GET_SALA_DISPONIBLE_PROFESOR = `${API_BASE_URL}/salas-controller/get-sala-disponible-profesor`;
export const POST_SAVE_REGISTROSALA = `${API_BASE_URL}/salas-controller/save-registrosala`;
export const GET_REPORT_SALA_MODULO = `${API_BASE_URL}/salas-controller/get-reporte`;
export const GET_PROGRAMA = `${API_BASE_URL}/salas-controller/get-programa`;
export const GET_SEMESTRE = `${API_BASE_URL}/salas-controller/get-semestre`;
export const GET_JORNADA = `${API_BASE_URL}/salas-controller/get-jornada`;
export const POST_SAVE_ESTUDIANTE_LISTA = `${API_BASE_URL}/salas-controller/save-estudiante-lista`;
export const GET_USUARIO_BY_DOCUMENTO = `${API_BASE_URL}/salas-controller/get-usuario-by-documento`;
export const GET_UBICACION = `${API_BASE_URL}/salas-controller/get-ubicacion`;
export const POST_SAVE_REGISTRO_PORTATIL = `${API_BASE_URL}/salas-controller/save-registro-portatil`;
export const GET_SOLICITUDES_PENDIENTES = `${API_BASE_URL}/salas-controller/get-solicitudes-pendientes`;
export const GET_PORTATILES_SIN_DEVOLVER = `${API_BASE_URL}/salas-controller/get-equipo-portatil-sin-devolver`;
export const GET_EQUIPO_DISPONIBLE = `${API_BASE_URL}/salas-controller/get-equipo-portatil-disponible`;
export const DELETE_SOLICITUD_LISTA_NEGRA = `${API_BASE_URL}/salas-controller/delete-solicitud-lista-negra`;
export const GET_USUARIO_LISTA_NEGRA = `${API_BASE_URL}/salas-controller/get-usuario-lista-negra`;
export const GET_REPORTE_MODULO_PORTATILES = `${API_BASE_URL}/salas-controller/get-reporte-modulo-portatiles`;
export const GET_DEPENDENCIA = `${API_BASE_URL}/salas-controller/get-dependencia`;


// ... más URLs según sea necesario

// Otra opción es exportar un objeto completo
export default {
  GET_ESTUDIANTE_BY_DOCUMENTO,
  GET_SALA_DISPONIBLE,
  GET_EQUIPO_BY_IDSALA,
  POST_SAVE_REGISTROESTUDIANTE,
  GET_INVITADO_BY_DOCUMENTO,
  GET_FACULTAD,
  GET_PROGRAMA_BY_FACULTAD,
  POST_SAVE_INVITADO,
  GET_PROFESOR,
  GET_CURSO_BY_PROGRAMA,
  GET_SALA_DISPONIBLE_PROFESOR,
  POST_SAVE_REGISTROSALA,
  GET_REPORT_SALA_MODULO,
  GET_PROGRAMA,
  GET_SEMESTRE,
  GET_JORNADA,
  POST_SAVE_ESTUDIANTE_LISTA,
  GET_USUARIO_BY_DOCUMENTO,
  GET_UBICACION,
  POST_SAVE_REGISTRO_PORTATIL,
  GET_SOLICITUDES_PENDIENTES,
  GET_PORTATILES_SIN_DEVOLVER,
  GET_EQUIPO_DISPONIBLE,
  DELETE_SOLICITUD_LISTA_NEGRA,
  GET_USUARIO_LISTA_NEGRA,
  GET_REPORTE_MODULO_PORTATILES,
  GET_DEPENDENCIA,
};
