import 'babel-polyfill'
import Vue from 'vue'

import Plan from '../../components/plans/PlanIndex.vue'

import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)

import ModalEvent from '../EventBus.js'
export default ModalEvent

document.addEventListener('turbolinks:load', () => {
  if (document.getElementById('calendar')) {
    new Vue({
      el: '#calendar',
      components: {
        'plan': Plan,
      }
    })
  }
})
