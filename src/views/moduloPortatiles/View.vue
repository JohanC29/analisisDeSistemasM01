
<template>
  <!-- Contenedor principal de la aplicación -->
  <main>
    <div class="container">
      <div class="card">
        <div class="card-body">
          <h1 class="card-title">Bienvenido! - Modulo de Portatiles</h1>

          <nav class="navbar navbar-expand-lg bg-body-tertiary">
            <div class="container-fluid">
              <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                  <li class="nav-item">
                    <button
                      class="nav-link"
                      @click="select('registro')"
                      :class="{ active: selectedRole === 'registro' }"
                    >
                      Registro Solicitud
                    </button>
                  </li>
                  <li class="nav-item">
                    <button
                      class="nav-link"
                      @click="select('gestionsolicitud')"
                      :class="{ active: selectedRole === 'gestionsolicitud' }"
                    >
                      Gestion Solicitud
                    </button>
                  </li>
                  <li class="nav-item">
                    <button
                      class="nav-link"
                      @click="select('gestionretorno')"
                      :class="{
                        active: selectedRole === 'gestionretorno',
                      }"
                    >
                      Gestion Retorno
                    </button>
                  </li>
                  <li class="nav-item">
                    <button
                      class="nav-link"
                      @click="select('listabloqueo')"
                      :class="{
                        active: selectedRole === 'listabloqueo',
                      }"
                    >
                      Lista de bloqueo
                    </button>
                  </li>
                  <li class="nav-item">
                    <button
                      class="nav-link"
                      @click="select('reporte')"
                      :class="{
                        active: selectedRole === 'reporte',
                      }"
                    >
                      Reporte
                    </button>
                  </li>
                  <li class="nav-item">
                    <button
                      class="nav-link"
                      @click="select('cargausuarios')"
                      :class="{
                        active: selectedRole === 'cargausuarios',
                      }"
                    >
                      Carga Usuarios
                    </button>
                  </li>
                </ul>
              </div>
            </div>
          </nav>

          <div v-if="selectedRole === 'registro'">
            Ingrese el documento de identidad:<br /><br />
            <div class="formulario">
              <form @submit.prevent="obtenerDatos">
                <div class="row g-3 align-items-center">
                  <div class="col-auto">
                    <label
                      for="usuarioDocumentoIdentidad"
                      class="col-form-label"
                      >Documento de identidad:
                    </label>
                  </div>
                  <div class="col-auto">
                    <input
                      type="number"
                      id="usuarioDocumentoIdentidad"
                      class="form-control"
                      aria-describedby="usuarioDocumentoIdentidadHelpInline"
                      v-model="usuarioDocumentoIdentidad"
                      @blur="obtenerDatos"
                    />
                  </div>
                  <div class="col-auto">
                    <span
                      id="usuarioDocumentoIdentidadHelpInline"
                      class="form-text"
                    >
                      Documento de identidad sin puntos ni comas.
                    </span>
                  </div>
                </div>

                <!-- Campos que se llenarán automáticamente -->
                <div class="datos mt-4" v-if="usuario.id">
                  <h4>Datos Estudiante</h4>
                  <div class="mb-3 row">
                    <div class="col-6">
                      <label for="staticNombre" class="col-form-label"
                        >Nombre</label
                      >
                      <input
                        type="text"
                        readonly
                        class="form-control-plaintext col-6"
                        id="staticNombre"
                        v-model="usuario.nombre"
                      />
                    </div>

                    <div class="col-6">
                      <label for="staticApellido" class="col-form-label"
                        >Apellido</label
                      >
                      <input
                        type="text"
                        readonly
                        class="form-control-plaintext"
                        id="staticApellido"
                        v-model="usuario.apellido"
                      />
                    </div>
                  </div>

                  <div v-if="usuario.rol === 'ESTUDIANTE'">
                    <div class="mb-3 row">
                      <div class="col-6">
                        <label for="staticFacultad" class="col-form-label"
                          >Facultad</label
                        >
                        <input
                          type="text"
                          readonly
                          class="form-control-plaintext"
                          id="staticFacultad"
                          v-model="usuario.facultad"
                        />
                      </div>
                      <div class="col-6">
                        <label for="staticPrograma" class="col-form-label"
                          >Programa</label
                        >
                        <input
                          type="text"
                          readonly
                          class="form-control-plaintext col-6"
                          id="staticPrograma"
                          v-model="usuario.programa"
                        />
                      </div>
                    </div>

                    <div class="mb-3 row">
                      <div class="col-6">
                        <label for="staticSemestre" class="col-form-label"
                          >Semestre</label
                        >
                        <input
                          type="text"
                          readonly
                          class="form-control-plaintext"
                          id="staticSemestre"
                          v-model="usuario.semestre"
                        />
                      </div>
                      <div class="col-6">
                        <label for="staticJornada" class="col-form-label"
                          >Jornada</label
                        >
                        <input
                          type="text"
                          readonly
                          class="form-control-plaintext"
                          id="staticJornada"
                          v-model="usuario.jornada"
                        />
                      </div>
                    </div>
                  </div>

                  <div v-if="usuario.rol != 'ESTUDIANTE'">
                    <div class="mb-3 row">
                      <div class="col-6">
                        <label for="staticDependencia" class="col-form-label"
                          >Dependencia</label
                        >
                        <input
                          type="text"
                          readonly
                          class="form-control-plaintext"
                          id="staticDependencia"
                          v-model="usuario.dependencia"
                        />
                      </div>
                    </div>
                  </div>

                  <div class="mb-3 row">
                    <div class="col-6">
                      <label for="selectSala" class="col-form-label"
                        >Seleccione la Ubicacion.</label
                      >
                      <v-select
                        :options="ubicacion"
                        label="descripcion"
                        v-model="ubicacionSelect"
                      ></v-select>
                    </div>

                    <div class="col-6">
                      <label for="numeroCelular" class="col-form-label"
                        >Ingrese el numero celular</label
                      >
                      <div class="col-auto">
                        <input
                          type="text"
                          id="numeroCelular"
                          class="form-control"
                          v-model="celular"
                        />
                      </div>
                    </div>
                  </div>

                  <!-- Botones para procesar y limpiar datos -->
                  <div class="row">
                    <div class="col-3 d-grid">
                      <button
                        type="button"
                        class="btn btn-primary btn-sm mb-1"
                        :class="{ disabled: !(ubicacionSelect && celular) }"
                        @click="registrarSolicitud()"
                      >
                        <i class="bi bi-gear"></i> Enviar solicitud
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
                </div>

                <!-- Agrega más campos según sea necesario -->
              </form>
            </div>
          </div>

          <div v-if="selectedRole === 'gestionsolicitud'">
            <tabla-gestion-solicitudes-pendientes></tabla-gestion-solicitudes-pendientes>
          </div>
          <div v-if="selectedRole === 'gestionretorno'">
            <tabla-gestion-retorno/>
          </div>

          <div v-if="selectedRole === 'reporte'">
            <!-- Componente personalizado TableResult -->
            <reporte-modulo-salas></reporte-modulo-salas>
          </div>

          <div v-if="selectedRole === 'cargausuarios'">
            <!-- Componente personalizado Carga Archvio Modulo Salas -->
            <carga-archivo-modulo-salas></carga-archivo-modulo-salas>
          </div>
        </div>
      </div>
    </div>
  </main>
</template>

<script>
import axios from "axios";

import {
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
  GET_USUARIO_BY_DOCUMENTO,
  GET_UBICACION,
  POST_SAVE_REGISTRO_PORTATIL,
} from "@/config/apiUrls.js";

import ReporteModuloSalas from "../../components/ReporteModuloSalas.vue";
import CargaArchivoModuloSalas from "../../components/CargaArchivoModuloSalas.vue";
import TablaGestionSolicitudesPendientes from "../../components/TablaGestionSolicitudesPendientes.vue";
import TablaGestionRetorno from "../../components/TablaGestionRetorno.vue";

export default {
  components: { ReporteModuloSalas, CargaArchivoModuloSalas, TablaGestionSolicitudesPendientes,TablaGestionRetorno },
  created() {
    this.obtenerUbicacion();
  },

  data() {
    // Definición de los datos locales del componente.
    return {
      selectedRole: "registro",
      usuarioDocumentoIdentidad: "",
      esInvitado: false,
      estudiante: {
        id: null,
        documento: null,
        nombre: null,
        apellido: null,
        estado: null,
        idprograma: null,
        idsemestre: null,
        idjornada: null,
        descripcionprograma: null,
        descripcionsemestre: null,
        descripcionjornada: null,
      },
      usuario: {
        apellido: null,
        rol: null,
        jornada: null,
        nombre: null,
        facultad: null,
        programa: null,
        id: null,
        documento: null,
        semestre: null,
        dependencia: null,
      },
      profesor: {
        id: null,
        cedula: null,
        nombre: null,
        apellido: null,
        estado: null,
      },
      idProfesor: null,
      profesorDocumentoIdentidad: null,
      selectSalaProfesor: null,
      salasList: [
        {
          id: null,
          descripcion: null,
        },
      ],
      selectSala: null,
      equipoList: [
        {
          id: null,
          descripcion: null,
          idsala: null,
        },
      ],
      selectEquipo: null,
      registroEstudiante: {
        idregistrosala: null,
        idestudiante: null,
        idequipo: null,
        idinvitado: null,
      },
      invitado: {
        id: null,
        identificacion: "",
        nombre: "",
        apellido: "",
        idprograma: null,
        idfacultad: null,
      },
      facultadList: [
        {
          id: null,
          descripcion: null,
        },
      ],
      selectFacultad: null,
      programaList: [
        {
          id: null,
          descripcion: null,
          idfacultad: null,
        },
      ],
      selectPrograma: null,
      selectCurso: null,
      fechaSeleccionada: null,
      horaInicialSeleccionada: null,
      horaFinalSeleccionada: null,
      cursosList: [
        {
          id: null,
          descripcion: null,
          idprograma: null,
        },
      ],
      salasListProfesor: [
        {
          id: null,
          descripcion: null,
        },
      ],
      isProcesarDatosProfesor: false,

      ubicacion: [
        {
          id: null,
          descripcion: null,
          estado: null,
        },
      ],
      ubicacionSelect: {
        id: null,
        descripcion: null,
        estado: null,
      },
      celular: null,
    };
  },
  computed: {
    fechaActual() {
      const hoy = new Date();
      const mes = (hoy.getMonth() + 1).toString().padStart(2, "0");
      const dia = hoy.getDate().toString().padStart(2, "0");
      return `${hoy.getFullYear()}-${mes}-${dia}`;
    },
  },
  methods: {
    handleSelect(role) {
      this.selectedRole = role;
    },

    select(role) {
      this.selectedRole = role;

    },

    async selectInvitado() {
      this.selectedRole = "invitado";
      this.obtenerDatosInvitado(this.usuarioDocumentoIdentidad);
    },

    obtenerDatosInvitado(usuarioDocumentoIdentidad) {
      this.invitado.identificacion = usuarioDocumentoIdentidad;
      axios
        .get(GET_INVITADO_BY_DOCUMENTO, {
          params: { identificacion: this.invitado.identificacion },
        })
        .then((response) => {
          console.log(response);
          if (response.data.code == 0) {
            this.invitado = response.data.object;
            this.selectFacultad = this.invitado.idfacultad;

            this.obtenerProgramas(this.selectFacultad);

            this.selectPrograma = this.invitado.idprograma;
            this.$toast.success("Invitado identificado.");
          }
          // Encadena el metodo de obtener las salas disponibles.
          this.obtenerSalasDisponibles();
        })
        .catch((error) => {
          // Manejar error
          console.error("Error al obtener los datos", error);
          this.$toast.error("Error al obtener los datos.");
        });
    },

    async obtenerFacultad() {
      try {
        const response = await axios.get(GET_FACULTAD);
        console.log(response);
        if (response.data.code == 0) {
          this.facultadList = response.data.list;
        } else {
          this.facultadList = [
            {
              id: null,
              descripcion: null,
            },
          ];
          this.$toast.error("No hay facultades configuradas.");
        }
      } catch (error) {
        console.error(
          "Error al obtener los datos de facultades configuradas",
          error
        );
        this.$toast.error(
          "Error al obtener los datos de facultades configuradas."
        );
      }
    },

    async obtenerUbicacion() {
      try {
        const response = await axios.get(GET_UBICACION);
        console.log(response);
        if (response.data.code == 0) {
          this.ubicacion = response.data.list;
        } else {
          this.ubicacion = [];
          this.$toast.error("No hay ubicaciones configuradas.");
        }
      } catch (error) {
        console.error(
          "Error al obtener los datos de ubicacion configuradas",
          error
        );
        this.$toast.error(
          "Error al obtener los datos de ubicacion configuradas."
        );
      }
    },



    async obtenerProgramas(idfacultad) {
      if (idfacultad) {
        try {
          const response = await axios.get(GET_PROGRAMA_BY_FACULTAD, {
            params: { idfacultad: idfacultad },
          });
          console.log(response);
          if (response.data.code == 0) {
            this.programaList = response.data.list;
            this.$toast.success("Programas Cargados.");
          } else {
            this.programaList = [
              {
                id: null,
                descripcion: null,
                idfacultad: null,
              },
            ];
            this.$toast.error("No hay programas disponibles.");
          }
        } catch (error) {
          console.error(
            "Error al obtener los datos de programas disponibles",
            error
          );
          this.$toast.error(
            "Error al obtener los datos de programas disponibles."
          );
        }
      }
    },

    async obtenerCursos(idPrograma) {
      if (idPrograma) {
        try {
          const response = await axios.get(GET_CURSO_BY_PROGRAMA, {
            params: { idprograma: idPrograma },
          });
          console.log(response);
          if (response.data.code == 0) {
            this.cursosList = response.data.list;
            this.$toast.success("Curos Cargados.");
          } else {
            this.cursosList = [
              {
                id: null,
                descripcion: null,
                idprograma: null,
              },
            ];
            this.$toast.error("No hay cursos disponibles.");
          }
        } catch (error) {
          console.error(
            "Error al obtener los datos de curos disponibles",
            error
          );
          this.$toast.error(
            "Error al obtener los datos de cursos disponibles."
          );
        }
      }

      this.validarisProcesarDatosProfesor();
    },

    async obtenerDatos() {
      if (this.usuarioDocumentoIdentidad) {
        try {
          const response = await axios.get(GET_USUARIO_BY_DOCUMENTO, {
            params: { documento: this.usuarioDocumentoIdentidad },
          });
          console.log(response);
          if (response.data.code == 0) {
            this.usuario = response.data.list[0];
            this.$toast.success("Usuario identificado.");
          } else {
            this.usuario = {
              apellido: null,
              rol: null,
              jornada: null,
              nombre: null,
              facultad: null,
              programa: null,
              id: null,
              documento: null,
              semestre: null,
              dependencia: null,
            };
            this.$toast.error(
              "Usuario no encontrado. Puede Ingresar como Invitado."
            );
            this.esInvitado = true;
          }
        } catch (error) {
          console.error("Error al obtener los datos", error);
          this.$toast.error("Error al obtener los datos.");
        }
      }
    },

    async obtenerDatosProfesor() {
      // Validamos y llenamos los parametros de la peticion
      let params = {};
      if (this.profesorDocumentoIdentidad) {
        params.cedula = this.profesorDocumentoIdentidad;
      }

      if (this.idProfesor) {
        params.id = this.idProfesor;
      }

      if (Object.keys(params).length > 0) {
        try {
          const response = await axios.get(GET_PROFESOR, { params });
          console.log(response);
          if (response.data.code == 0) {
            this.profesor = response.data.list[0];
            this.$toast.success("Profesor identificado.");
          } else {
            this.profesor = {
              id: null,
              cedula: null,
              nombre: null,
              apellido: null,
              estado: null,
            };
            this.$toast.error("Usuario no encontrado.");
            this.esInvitado = true;
          }
        } catch (error) {
          console.error("Error al obtener los datos", error);
          this.$toast.error("Error al obtener los datos.");
        }
      }
    },

    async obtenerSalasDisponibles() {
      try {
        const response = await axios.get(GET_SALA_DISPONIBLE);
        console.log(response);
        if (response.data.code == 0) {
          this.salasList = response.data.list;
          this.$toast.success("Salas Cargadas.");
        } else {
          this.salasList = [
            {
              id: null,
              descripcion: null,
            },
          ];
          this.$toast.error("No hay salas disponibles.");
        }
      } catch (error) {
        console.error("Error al obtener los datos de salas disponibles", error);
        this.$toast.error("Error al obtener los datos de salas disponibles.");
      }
    },

    async obtenerEquiposDisponibles() {
      if (this.selectSala) {
        try {
          const response = await axios.get(GET_EQUIPO_BY_IDSALA, {
            params: { idsala: this.selectSala },
          });
          console.log(response);
          if (response.data.code == 0) {
            this.equipoList = response.data.list;
            this.$toast.success("Equipos Cargados.");
          } else {
            this.salasList = [
              {
                id: null,
                descripcion: null,
                idsala: null,
              },
            ];
            this.$toast.error("No hay equipos disponibles.");
          }
        } catch (error) {
          console.error(
            "Error al obtener los datos de equipos disponibles",
            error
          );
          this.$toast.error(
            "Error al obtener los datos de equipos disponibles."
          );
        }
      }
    },

    async procesarDatosEstudiante() {
      if (this.selectSala) {
        this.registroEstudiante.idregistrosala = this.selectSala;
        this.registroEstudiante.idestudiante = this.estudiante.id;
        this.registroEstudiante.idequipo = this.selectEquipo;
        this.registrarDatosEstudiante(this.registroEstudiante);
      }
    },

    async registrarSolicitud() {
      if (this.ubicacionSelect && this.celular) {
        const idfuncionario =
          this.usuario.rol === "FUNCIONARIO" ? this.usuario.id : null;
        const idestudiante =
          this.usuario.rol === "ESTUDIANTE" ? this.usuario.id : null;
        const idprofesor =
          this.usuario.rol === "PROFESOR" ? this.usuario.id : null;

        const requestSolicitudPortatil = {
          id: null,
          idfuncionario: idfuncionario,
          idestudiante: idestudiante,
          idprofesor: idprofesor,
          celular: this.celular,
          fechasolicitud: null,
          idequipo: null,
          usuarioasigna: null,
          fechaasigna: null,
          fecharegreso: null,
        };
        // Se envia en momento 1
        axios
          .post(POST_SAVE_REGISTRO_PORTATIL + "/1", requestSolicitudPortatil)
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
      }
    },

    async registrarDatosEstudiante(registroEstudiante) {
      axios
        .post(POST_SAVE_REGISTROESTUDIANTE, registroEstudiante)
        .then((response) => {
          console.log("Respuesta del servidor:", response.data);
          // Manejar respuesta
          if (response.data.code == 0) {
            this.$toast.success("Registro realizado con Exito!.");

            this.limpiarDatos();
          } else {
            this.registroEstudiante = {
              idregistrosala: null,
              idestudiante: null,
              idequipo: null,
              idinvitado: null,
            };
            this.$toast.error("Corrio un error almacenando los datos.");
          }
        })
        .catch((error) => {
          // Manejar error
          console.error("Error almacenando los registros.", error);
          this.$toast.error("Error almacenando los registros.");
        });
    },

    async procesarDatosInvitado() {
      this.invitado.idprograma = this.selectPrograma;
      if (!this.invitado.id) {
        // Creacion del invitado en la BD
        axios
          .post(POST_SAVE_INVITADO, this.invitado)
          .then((response) => {
            console.log("Respuesta del servidor:", response.data);
            // Manejar respuesta
            if (response.data.code == 0) {
              this.$toast.success("Registro realizado con Exito!.");
              this.invitado.id = response.data.object.id;

              if (this.invitado.id) {
                this.registroEstudiante.idregistrosala = this.selectSala;
                this.registroEstudiante.idinvitado = this.invitado.id;
                this.registroEstudiante.idequipo = this.selectEquipo;
                this.registrarDatosEstudiante(this.registroEstudiante);
              }
            } else {
              this.$toast.error("Corrio un error almacenando los datos.");
              return;
            }
          })
          .catch((error) => {
            // Manejar error
            console.error("Error almacenando los registros.", error);
            this.$toast.error("Error almacenando los registros.");
          });
      }

      if (this.invitado.id) {
        this.registroEstudiante.idregistrosala = this.selectSala;
        this.registroEstudiante.idinvitado = this.invitado.id;
        this.registroEstudiante.idequipo = this.selectEquipo;
        this.registrarDatosEstudiante(this.registroEstudiante);
      }
    },

    async consultarSalasDisponiblesProfesor() {
      if (
        this.fechaSeleccionada &&
        this.horaInicialSeleccionada &&
        this.horaFinalSeleccionada
      ) {
        console.log(this.fechaSeleccionada);
        console.log(this.horaInicialSeleccionada);
        console.log(this.horaFinalSeleccionada);

        const params = {
          fecha: this.fechaSeleccionada,
          horainicial: this.horaInicialSeleccionada,
          horafinal: this.horaFinalSeleccionada,
        };

        try {
          const response = await axios.get(GET_SALA_DISPONIBLE_PROFESOR, {
            params,
          });
          console.log(response);
          if (response.data.code == 0) {
            this.salasListProfesor = response.data.list;
            this.$toast.success("Salas Cargadas.");
          } else {
            this.salasListProfesor = [
              {
                id: null,
                descripcion: null,
              },
            ];
            this.$toast.error("No hay salas disponibles.");
          }
        } catch (error) {
          console.error(
            "Error al obtener los datos de salas disponibles",
            error
          );
          this.$toast.error("Error al obtener los datos de salas disponibles.");
        }
      }

      this.validarisProcesarDatosProfesor();
    },
    validarisProcesarDatosProfesor() {
      if (
        this.selectCurso &&
        this.selectPrograma &&
        this.selectFacultad &&
        this.selectSalaProfesor &&
        this.horaFinalSeleccionada &&
        this.horaInicialSeleccionada &&
        this.fechaSeleccionada &&
        this.profesor
      ) {
        this.isProcesarDatosProfesor = true;
      }
    },
    procesarDatosProfesor() {
      if (
        this.selectCurso &&
        this.selectPrograma &&
        this.selectFacultad &&
        this.selectSalaProfesor &&
        this.horaFinalSeleccionada &&
        this.horaInicialSeleccionada &&
        this.fechaSeleccionada &&
        this.profesor
      ) {
        const fechaInicial =
          this.fechaSeleccionada +
          "T" +
          this.horaInicialSeleccionada +
          ":00.000-05:00";
        const fechaFinal =
          this.fechaSeleccionada +
          "T" +
          this.horaFinalSeleccionada +
          ":00.000-05:00";

        const registroSalaProfesores = {
          idprofesor: this.profesor.id,
          fechainicial: fechaInicial,
          fechafinal: fechaFinal,
          idfacultad: this.selectFacultad,
          idcurso: this.selectCurso,
          idsala: this.selectSalaProfesor,
        };
        this.registrarDatosSalaProfesor(registroSalaProfesores);
      }
    },

    async registrarDatosSalaProfesor(registroSalaProfesor) {
      axios
        .post(POST_SAVE_REGISTROSALA, registroSalaProfesor)
        .then((response) => {
          console.log("Respuesta del servidor:", response.data);
          // Manejar respuesta
          if (response.data.code == 0) {
            this.$toast.success("Registro realizado con Exito!.");

            this.limpiarDatos();
          } else {
            this.$toast.error("Ocurrio un error almacenando los datos.");
          }
        })
        .catch((error) => {
          // Manejar error
          console.error("Error almacenando los registros.", error);
          this.$toast.error("Error almacenando los registros.");
        });
    },
    seleccionUbicacion() {
      console.log(this.ubicacionSelect);
    },

    limpiarDatos() {
      this.selectedRole = "registro";
      this.usuarioDocumentoIdentidad = "";
      this.esInvitado = false;
      this.estudiante = {
        id: null,
        documento: null,
        nombre: null,
        apellido: null,
        estado: null,
        idprograma: null,
        idsemestre: null,
        idjornada: null,
        descripcionprograma: null,
        descripcionsemestre: null,
        descripcionjornada: null,
      };
      this.profesor = {
        id: null,
        cedula: null,
        nombre: null,
        apellido: null,
        estado: null,
      };
      this.idProfesor = null;
      this.profesorDocumentoIdentidad = null;
      this.selectSalaProfesor = null;
      this.salasList = [
        {
          id: null,
          descripcion: null,
        },
      ];
      this.selectSala = null;
      this.equipoList = [
        {
          id: null,
          descripcion: null,
          idsala: null,
        },
      ];
      this.selectEquipo = null;
      this.registroEstudiante = {
        idregistrosala: null,
        idestudiante: null,
        idequipo: null,
        idinvitado: null,
      };
      this.invitado = {
        id: null,
        identificacion: "",
        nombre: "",
        apellido: "",
        idprograma: null,
        idfacultad: null,
      };
      this.facultadList = [
        {
          id: null,
          descripcion: null,
        },
      ];
      this.selectFacultad = null;
      this.programaList = [
        {
          id: null,
          descripcion: null,
          idfacultad: null,
        },
      ];
      this.selectPrograma = null;
      this.selectCurso = null;
      this.fechaSeleccionada = null;
      this.horaInicialSeleccionada = null;
      this.horaFinalSeleccionada = null;
      this.cursosList = [
        {
          id: null,
          descripcion: null,
          idprograma: null,
        },
      ];
      this.salasListProfesor = [
        {
          id: null,
          descripcion: null,
        },
      ];
      this.isProcesarDatosProfesor = false;
      this.usuario = {
        apellido: null,
        rol: null,
        jornada: null,
        nombre: null,
        facultad: null,
        programa: null,
        id: null,
        documento: null,
        semestre: null,
        dependencia: null,
      };
      this.celular = null;
      this.ubicacionSelect = {
        id: null,
        descripcion: null,
        estado: null,
      };
    },
  },
};
</script>


<style>
@import "vue-select/dist/vue-select.css";
</style>