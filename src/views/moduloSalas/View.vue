<template>
  <!-- Contenedor principal de la aplicación -->
  <main>
    <div class="container">
      <div class="card">
        <div class="card-body">
          <h1 class="card-title">Bienvenido! - Modulo de Salas</h1>

          <nav class="navbar navbar-expand-lg bg-body-tertiary">
            <div class="container-fluid">
              <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                  <li class="nav-item">
                    <button
                      class="nav-link"
                      @click="select('estudiante')"
                      :class="{ active: selectedRole === 'estudiante' }"
                    >
                      Estudiante
                    </button>
                  </li>
                  <li class="nav-item">
                    <button
                      class="nav-link"
                      @click="select('profesor')"
                      :class="{ active: selectedRole === 'profesor' }"
                    >
                      Profesor
                    </button>
                  </li>
                  <li class="nav-item">
                    <button
                      class="nav-link"
                      @click="selectInvitado()"
                      :class="{
                        disabled: !esInvitado,
                        active: selectedRole === 'invitado',
                      }"
                    >
                      Invitado
                    </button>
                  </li>
                </ul>
              </div>
            </div>
          </nav>

          <div v-if="selectedRole === 'estudiante'">
            Ingrese el documento de identidad:<br /><br />
            <div class="formulario">
              <form @submit.prevent="obtenerDatos">
                <div class="row g-3 align-items-center">
                  <div class="col-auto">
                    <label
                      for="estudianteDocumentoIdentidad"
                      class="col-form-label"
                      >Documento de identidad:
                    </label>
                  </div>
                  <div class="col-auto">
                    <input
                      type="number"
                      id="estudianteDocumentoIdentidad"
                      class="form-control"
                      aria-describedby="estudianteDocumentoIdentidadHelpInline"
                      v-model="estudianteDocumentoIdentidad"
                      @blur="obtenerDatos"
                    />
                  </div>
                  <div class="col-auto">
                    <span
                      id="estudianteDocumentoIdentidadHelpInline"
                      class="form-text"
                    >
                      Documento de identidad sin puntos ni comas.
                    </span>
                  </div>
                </div>

                <!-- Campos que se llenarán automáticamente -->
                <div class="datos mt-4" v-if="estudiante.id">
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
                        v-model="estudiante.nombre"
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
                        v-model="estudiante.apellido"
                      />
                    </div>
                  </div>

                  <div class="mb-3 row">
                    <div class="col-6">
                      <label for="staticPrograma" class="col-form-label"
                        >Programa</label
                      >
                      <input
                        type="text"
                        readonly
                        class="form-control-plaintext col-6"
                        id="staticPrograma"
                        v-model="estudiante.descripcionprograma"
                      />
                    </div>

                    <div class="col-6">
                      <label for="staticSemestre" class="col-form-label"
                        >Semestre</label
                      >
                      <input
                        type="text"
                        readonly
                        class="form-control-plaintext"
                        id="staticSemestre"
                        v-model="estudiante.descripcionsemestre"
                      />
                    </div>
                  </div>

                  <div class="mb-3 row">
                    <div class="col-6">
                      <label for="staticJornada" class="col-form-label"
                        >Jornada</label
                      >
                      <input
                        type="text"
                        readonly
                        class="form-control-plaintext"
                        id="staticJornada"
                        v-model="estudiante.descripcionjornada"
                      />
                    </div>
                  </div>

                  <div class="mb-3 row">
                    <div class="col-6">
                      <label for="selectSala" class="col-form-label"
                        >Seleccione la Sala.</label
                      >
                      <select
                        class="form-select"
                        aria-label="Lista de salas"
                        id="selectSala"
                        v-model="selectSala"
                        @change="obtenerEquiposDisponibles"
                      >
                        <option
                          v-for="option in salasList"
                          :value="option.id"
                          :key="option.descripcion"
                        >
                          {{ option.descripcion }}
                        </option>
                      </select>
                    </div>

                    <div class="col-6">
                      <label for="selectEquipo" class="col-form-label"
                        >Seleccione el Equipo.</label
                      >
                      <select
                        class="form-select"
                        aria-label="Lista de equipos"
                        id="selectEquipo"
                        v-model="selectEquipo"
                      >
                        <option
                          v-for="option in equipoList"
                          :value="option.id"
                          :key="option.descripcion"
                        >
                          {{ option.descripcion }}
                        </option>
                      </select>
                    </div>
                  </div>

                  <!-- Botones para procesar y limpiar datos -->
                  <div class="row">
                    <div class="col-3 d-grid">
                      <button
                        type="button"
                        class="btn btn-primary btn-sm mb-1"
                        :class="{ disabled: !selectSala }"
                        @click="procesarDatosEstudiante()"
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
                </div>

                <!-- Agrega más campos según sea necesario -->
              </form>
            </div>
          </div>

          <div v-if="selectedRole === 'profesor'">Contenido para Profesor</div>
          <div v-if="selectedRole === 'invitado'">
            Contenido para Invitado

            <!-- Campos Invitado -->
            <div class="datos mt-4" v-if="esInvitado">
              <h4>Datos Invitado</h4>

              <div class="row g-3 align-items-center">
                <div class="col-auto">
                  <label for="invitadoDocumentoIdentidad" class="col-form-label"
                    >Documento de identidad:
                  </label>
                </div>
                <div class="col-auto">
                  <input
                    type="number"
                    id="invitadoDocumentoIdentidad"
                    class="form-control"
                    aria-describedby="invitadoDocumentoIdentidadHelpInline"
                    v-model="estudianteDocumentoIdentidad"
                    disabled
                  />
                </div>
                <div class="col-auto">
                  <span
                    id="invitadoDocumentoIdentidadHelpInline"
                    class="form-text"
                  >
                    Documento de identidad sin puntos ni comas.
                  </span>
                </div>
              </div>

              <div class="row g-3 mt-1 align-items-center">
                <div class="col-auto">
                  <label for="invitadoNombre" class="col-form-label"
                    >Nombre:
                  </label>
                </div>
                <div class="col-auto">
                  <input
                    type="text"
                    id="invitadoNombre"
                    class="form-control"
                    v-model="invitado.nombre"
                  />
                </div>

                <div class="col-auto">
                  <label for="invitadoApellido" class="col-form-label"
                    >Apellido:
                  </label>
                </div>
                <div class="col-auto">
                  <input
                    type="text"
                    id="invitadoApellido"
                    class="form-control"
                    v-model="invitado.apellido"
                  />
                </div>
              </div>
              <div class="mb-3 row">
                <div class="col-6">
                  <label for="selectFacultad" class="col-form-label"
                    >Seleccione la Facultad.</label
                  >
                  <select
                    class="form-select"
                    aria-label="Lista de facultades"
                    id="selectFacultad"
                    v-model="selectFacultad"
                    @change="obtenerProgramas(selectFacultad)"
                  >
                    <option
                      v-for="option in facultadList"
                      :value="option.id"
                      :key="option.descripcion"
                    >
                      {{ option.descripcion }}
                    </option>
                  </select>
                </div>

                <div class="col-6">
                  <label for="selectPrograma" class="col-form-label"
                    >Seleccione el Programa.</label
                  >
                  <select
                    class="form-select"
                    aria-label="Lista de programas"
                    id="selectPrograma"
                    v-model="selectPrograma"
                  >
                    <option
                      v-for="option in programaList"
                      :value="option.id"
                      :key="option.descripcion"
                    >
                      {{ option.descripcion }}
                    </option>
                  </select>
                </div>
              </div>

              <div class="mb-3 row">
                <div class="col-6">
                  <label for="selectSala" class="col-form-label"
                    >Seleccione la Sala.</label
                  >
                  <select
                    class="form-select"
                    aria-label="Lista de salas"
                    id="selectSala"
                    v-model="selectSala"
                    @change="obtenerEquiposDisponibles"
                  >
                    <option
                      v-for="option in salasList"
                      :value="option.id"
                      :key="option.descripcion"
                    >
                      {{ option.descripcion }}
                    </option>
                  </select>
                </div>

                <div class="col-6">
                  <label for="selectEquipo" class="col-form-label"
                    >Seleccione el Equipo.</label
                  >
                  <select
                    class="form-select"
                    aria-label="Lista de equipos"
                    id="selectEquipo"
                    v-model="selectEquipo"
                  >
                    <option
                      v-for="option in equipoList"
                      :value="option.id"
                      :key="option.descripcion"
                    >
                      {{ option.descripcion }}
                    </option>
                  </select>
                </div>
              </div>

              <!-- Botones para procesar y limpiar datos -->
              <div class="row">
                <div class="col-3 d-grid">
                  <button
                    type="button"
                    class="btn btn-primary btn-sm mb-1"
                    :class="{ disabled: !selectPrograma , disabled: !selectSala }"
                    @click="procesarDatosInvitado()"
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
            </div>
          </div>
        </div>
      </div>
    </div>
  </main>
</template>

<script>
import axios from "axios";
import {
  GET_ESTUDIANTE_BY_DOCUMENTO,
  GET_SALA_DISPONIBLE,
  GET_EQUIPO_BY_IDSALA,
  POST_SAVE_REGISTROESTUDIANTE,
  GET_INVITADO_BY_DOCUMENTO,
  GET_FACULTAD,
  GET_PROGRAMA_BY_FACULTAD,
  POST_SAVE_INVITADO,
} from "@/config/apiUrls.js";

export default {
  created() {
    this.obtenerFacultad();
  },

  data() {
    // Definición de los datos locales del componente.
    return {
      selectedRole: "estudiante",
      estudianteDocumentoIdentidad: "",
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
    };
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
      this.obtenerDatosInvitado(this.estudianteDocumentoIdentidad);
    },

    obtenerDatosInvitado(estudianteDocumentoIdentidad) {
      this.invitado.identificacion = estudianteDocumentoIdentidad;
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

    async obtenerDatos() {
      if (this.estudianteDocumentoIdentidad) {
        try {
          const response = await axios.get(GET_ESTUDIANTE_BY_DOCUMENTO, {
            params: { documento: this.estudianteDocumentoIdentidad },
          });
          console.log(response);
          if (response.data.code == 0) {
            this.estudiante = response.data.object;
            this.$toast.success("Estudiante identificado.");

            // Encadena el metodo de obtener las salas disponibles.
            this.obtenerSalasDisponibles();
          } else {
            this.estudiante = {
              id: null,
              documento: null,
              nombre: null,
              apellido: null,
              estado: null,
              idprograma: null,
              idsemestre: null,
              idjornada: null,
              descripcionPrograma: null,
              descripcionSemestre: null,
              descripcionjornada: null,
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

    limpiarDatos() {
      this.selectedRole = "estudiante";
      this.estudianteDocumentoIdentidad = "";
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
    },
  },
};
</script>


