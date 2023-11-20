// Definición de URLs de API
// const API_BASE_URL = 'http://localhost:8080/api';
const API_BASE_URL = '/api';

export const GET_ESTUDIANTE_BY_DOCUMENTO = `${API_BASE_URL}/salas-controller/get-estudiante-by-documento`;
export const GET_SALA_DISPONIBLE = `${API_BASE_URL}/salas-controller/get-sala-disponible`;
export const GET_EQUIPO_BY_IDSALA = `${API_BASE_URL}/salas-controller/get-equipo-by-idsala`;
export const POST_SAVE_REGISTROESTUDIANTE = `${API_BASE_URL}/salas-controller/save-registroestudiante`;
export const GET_INVITADO_BY_DOCUMENTO = `${API_BASE_URL}/salas-controller/get-invitado-by-identificacion`;
export const GET_FACULTAD = `${API_BASE_URL}/salas-controller/get-facultad`;
export const GET_PROGRAMA_BY_FACULTAD = `${API_BASE_URL}/salas-controller/get-programa-by-idfacultad`;
export const POST_SAVE_INVITADO = `${API_BASE_URL}/salas-controller/save-invitado`;


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
    POST_SAVE_INVITADO
};