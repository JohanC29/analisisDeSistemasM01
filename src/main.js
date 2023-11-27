import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import ToastPlugin from 'vue-toast-notification';
// import { VueSelect } from "vue-select";
import VueSelect from 'vue-select';
import VueSweetalert2 from 'vue-sweetalert2';

import 'sweetalert2/dist/sweetalert2.min.css';
import 'vue-toast-notification/dist/theme-default.css';

const app = createApp(App)

app.use(router)
app.use(ToastPlugin)
app.use(VueSweetalert2)
app.component("v-select", VueSelect)

app.mount('#app')
