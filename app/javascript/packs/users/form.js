import 'babel-polyfill'
import Vue from 'vue'

import BarApp from '../../components/charts/BarApp.vue'
import PieApp from '../../components/charts/PieApp.vue'

import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)

import ModalEvent from '../EventBus.js'
export default ModalEvent

document.addEventListener('turbolinks:load', () => {
  if (document.getElementById('form')) {
    new Vue({
      el: '#form',
      components: {
        'bar-app': BarApp,
        'pie-app': PieApp
      }
    })
  }
})
